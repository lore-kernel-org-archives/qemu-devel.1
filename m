Received: from eggs.gnu.org ([208.118.235.92]:37420)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eoe3W-0001rH-0y
	for qemu-devel@nongnu.org; Wed, 21 Feb 2018 18:44:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eoe2C-0008Cr-FB
	for qemu-devel@nongnu.org; Wed, 21 Feb 2018 18:44:10 -0500
From: Eric Blake <eblake@redhat.com>
Date: Wed, 21 Feb 2018 17:39:53 -0600
Message-Id: <20180221233953.5142-4-eblake@redhat.com>
In-Reply-To: <20180221233953.5142-1-eblake@redhat.com>
References: <20180221233953.5142-1-eblake@redhat.com>
Subject: [Qemu-devel] [PATCH v2 3/3] qcow2: Avoid memory over-allocation on
 compressed images
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: kwolf@redhat.com, qemu-block@nongnu.org, berto@igalia.com, Max Reitz <mreitz@redhat.com>

When reading a compressed image, we were allocating s->cluster_data
to 32*cluster_size + 512 (possibly over 64 megabytes, for an image
with 2M clusters).  Let's check out the history:

Back when qcow2 was first written, we used s->cluster_data for
everything, including copy_sectors() and encryption, where we want
to operate on more than one cluster at once.  Obviously, at that
point, the buffer had to be aligned for other users, even though
compression itself doesn't require any alignment (the fact that
the compressed data generally starts mid-sector means that aligning
our buffer buys us nothing - either the protocol already supports
byte-based access into whatever offset we want, or we are already
using a bounce buffer to read a full sector, and copying into
our destination no longer requires alignment).

But commit 1b9f1491 (v1.1!) changed things to allocate parallel
buffers on demand rather than sharing a single buffer, for encryption
and COW, leaving compression as the final client of s->cluster_data.
That use was still preserved, because if a single compressed cluster
is read more than once, we reuse the cache instead of decompressing
it a second time (someday, we may come up with better caching to
avoid wasting repeated decompressions while still being more parallel,
but that is a task for another patch; the XXX comment in
qcow2_co_preadv for QCOW2_CLUSTER_COMPRESSED is telling).

Much later, in commit de82815d (v2.2), we noticed that a 64M
allocation is prone to failure, so we switched over to a graceful
memory allocation error message.  Elsewhere in the code, we do
g_malloc(2 * cluster_size) without ever checking for failure, but
even 4M starts to be large enough that trying to be nice is worth
the effort, so we want to keep that aspect.

Then even later, in 3e4c7052 (2.11), we realized that allocating
a large buffer up front for every qcow2 image is expensive, and
switched to lazy allocation only for images that actually had
compressed clusters.  But in the process, we never even bothered
to check whether what we were allocating still made sense in its
new context!

So, it's time to cut back on the waste.  A compressed cluster
written by qemu will NEVER occupy more than an uncompressed
cluster, but based on mid-sector alignment, we may still need
to read 1 cluster + 1 sector in order to recover enough bytes
for the decompression.  But third-party producers of qcow2 may
not be as smart, and gzip DOES document that because the
compression stream adds metadata, and because of the pigeonhole
principle, there are worst case scenarios where attempts to
compress will actually inflate an image, by up to 0.015% (or 62
sectors larger for an unfortunate 2M compression).  In fact,
the qcow2 spec permits up to 2 full clusters of sectors beyond
the initial offset; and the way decompression works, it really
doesn't matter if we read too much (gzip ignores slop, once it
has decoded a full cluster), so it's feasible to encounter a
third-party image that reports the maximum 'nb_csectors'
possible, even if it no longer has any bearing to the actual
compressed size.  So it's easier to just allocate cluster_data
to be as large as we can ever possibly see; even if it still
wastes up to 2M on any image created by qcow2, that's still an
improvment of 60M less waste than pre-patch.

Signed-off-by: Eric Blake <eblake@redhat.com>

---
v2: actually check allocation failure (previous version meant
to use g_malloc, but ended up posted with g_try_malloc without
checking); add assertions outside of conditional, improve
commit message to better match reality now that qcow2 spec bug
has been fixed
---
 block/qcow2-cluster.c | 27 ++++++++++++++++++---------
 block/qcow2.c         |  2 +-
 2 files changed, 19 insertions(+), 10 deletions(-)

diff --git a/block/qcow2-cluster.c b/block/qcow2-cluster.c
index 85be7d5e340..7d5276b5f6b 100644
--- a/block/qcow2-cluster.c
+++ b/block/qcow2-cluster.c
@@ -1598,20 +1598,29 @@ int qcow2_decompress_cluster(BlockDriverState *bs, uint64_t cluster_offset)
         sector_offset = coffset & 511;
         csize = nb_csectors * 512 - sector_offset;

-        /* Allocate buffers on first decompress operation, most images are
-         * uncompressed and the memory overhead can be avoided.  The buffers
-         * are freed in .bdrv_close().
+        /* Allocate buffers on the first decompress operation; most
+         * images are uncompressed and the memory overhead can be
+         * avoided.  The buffers are freed in .bdrv_close().  qemu
+         * never writes an inflated cluster, and gzip itself never
+         * inflates a problematic cluster by more than 0.015%, but the
+         * qcow2 format allows up to 2 full clusters beyond the sector
+         * containing offset, and gzip ignores trailing slop, so it's
+         * easier to just allocate that much up front than to reject
+         * third-party images with overlarge csize.
          */
+        assert(!!s->cluster_data == !!s->cluster_cache);
+        assert(csize < 2 * s->cluster_size + 512);
         if (!s->cluster_data) {
-            /* one more sector for decompressed data alignment */
-            s->cluster_data = qemu_try_blockalign(bs->file->bs,
-                    QCOW_MAX_CRYPT_CLUSTERS * s->cluster_size + 512);
+            s->cluster_data = g_try_malloc(2 * s->cluster_size + 512);
             if (!s->cluster_data) {
                 return -ENOMEM;
             }
-        }
-        if (!s->cluster_cache) {
-            s->cluster_cache = g_malloc(s->cluster_size);
+            s->cluster_cache = g_try_malloc(s->cluster_size);
+            if (!s->cluster_cache) {
+                g_free(s->cluster_data);
+                s->cluster_data = NULL;
+                return -ENOMEM;
+            }
         }

         BLKDBG_EVENT(bs->file, BLKDBG_READ_COMPRESSED);
diff --git a/block/qcow2.c b/block/qcow2.c
index 288b5299d80..6ad3436e0e5 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -2103,7 +2103,7 @@ static void qcow2_close(BlockDriverState *bs)
     g_free(s->image_backing_format);

     g_free(s->cluster_cache);
-    qemu_vfree(s->cluster_data);
+    g_free(s->cluster_data);
     qcow2_refcount_close(bs);
     qcow2_free_snapshots(bs);
 }
-- 
2.14.3
