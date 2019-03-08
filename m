Received: from eggs.gnu.org ([209.51.188.92]:59240)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1h2F5K-00082S-RQ
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 07:58:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1h2F5G-0004ln-Vm
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 07:58:46 -0500
From: Kevin Wolf <kwolf@redhat.com>
Date: Fri,  8 Mar 2019 13:57:52 +0100
Message-Id: <20190308125823.32535-3-kwolf@redhat.com>
In-Reply-To: <20190308125823.32535-1-kwolf@redhat.com>
References: <20190308125823.32535-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 02/33] qcow2: Default to 4KB for the qcow2 cache
 entry size
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, peter.maydell@linaro.org, qemu-devel@nongnu.org

From: Alberto Garcia <berto@igalia.com>

QEMU 2.12 (commit 1221fe6f636754ab5f2c1c87caa77633e9123622) introduced
a new setting called l2-cache-entry-size that allows making entries on
the qcow2 L2 cache smaller than the cluster size.

I have been performing several tests with different cluster and entry
sizes and all of them show that reducing the entry size (aka L2 slice)
consistently improves I/O performance, notably during random I/O (all
tests done with sequential I/O show similar results). This is to be
expected because loading and evicting an L2 slice is more expensive
the larger the slice is.

Here are some numbers on fully populated 40GB qcow2 images. The
rightmost column represents the maximum L2 cache size in both cases.

   Cluster size =3D 64 KB
   |-------------+--------------+--------------+--------------|
   |             | 1MB L2 cache | 3MB L2 cache | 5MB L2 cache |
   |-------------+--------------+--------------+--------------|
   |  4KB slices |    6545 IOPS |   12045 IOPS |   55680 IOPS |
   | 16KB slices |    5177 IOPS |    9798 IOPS |   56278 IOPS |
   | 64KB slices |    2718 IOPS |    5326 IOPS |   57355 IOPS |
   |-------------+--------------+--------------+--------------|

   Cluster size =3D 256 KB
   |--------------+----------------+--------------+-----------------|
   |              | 512KB L2 cache | 1MB L2 cache | 1280KB L2 cache |
   |--------------+----------------+--------------+-----------------|
   |   4KB slices |      8539 IOPS |   21071 IOPS |      55417 IOPS |
   |  64KB slices |      3598 IOPS |    9772 IOPS |      57687 IOPS |
   | 256KB slices |      1415 IOPS |    4120 IOPS |      58001 IOPS |
   |--------------+----------------+--------------+-----------------|

As can be seen in the numbers, the only exception to the rule is when
the cache is large enough to hold all L2 tables. This is also to be
expected because in this case no cache entry is ever evicted so
reducing its size doesn't bring any benefit.

This patch sets the default L2 cache entry size to 4KB except when the
cache is large enough for the whole disk.

Signed-off-by: Alberto Garcia <berto@igalia.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 docs/qcow2-cache.txt | 17 +++++++++++------
 block/qcow2.c        | 12 ++++++++++++
 2 files changed, 23 insertions(+), 6 deletions(-)

diff --git a/docs/qcow2-cache.txt b/docs/qcow2-cache.txt
index c1e7751fea..d57f409861 100644
--- a/docs/qcow2-cache.txt
+++ b/docs/qcow2-cache.txt
@@ -158,10 +158,10 @@ refcount cache is as small as possible unless overr=
idden by the user.
=20
 Using smaller cache entries
 ---------------------------
-The qcow2 L2 cache stores complete tables by default. This means that
-if QEMU needs an entry from an L2 table then the whole table is read
-from disk and is kept in the cache. If the cache is full then a
-complete table needs to be evicted first.
+The qcow2 L2 cache can store complete tables. This means that if QEMU
+needs an entry from an L2 table then the whole table is read from disk
+and is kept in the cache. If the cache is full then a complete table
+needs to be evicted first.
=20
 This can be inefficient with large cluster sizes since it results in
 more disk I/O and wastes more cache memory.
@@ -172,6 +172,9 @@ it smaller than the cluster size. This can be configu=
red using the
=20
    -drive file=3Dhd.qcow2,l2-cache-size=3D2097152,l2-cache-entry-size=3D=
4096
=20
+Since QEMU 4.0 the value of l2-cache-entry-size defaults to 4KB (or
+the cluster size if it's smaller).
+
 Some things to take into account:
=20
  - The L2 cache entry size has the same restrictions as the cluster
@@ -185,7 +188,8 @@ Some things to take into account:
=20
  - Try different entry sizes to see which one gives faster performance
    in your case. The block size of the host filesystem is generally a
-   good default (usually 4096 bytes in the case of ext4).
+   good default (usually 4096 bytes in the case of ext4, hence the
+   default).
=20
  - Only the L2 cache can be configured this way. The refcount cache
    always uses the cluster size as the entry size.
@@ -194,7 +198,8 @@ Some things to take into account:
    (as explained in the "Choosing the right cache sizes" and "How to
    configure the cache sizes" sections in this document) then none of
    this is necessary and you can omit the "l2-cache-entry-size"
-   parameter altogether.
+   parameter altogether. In this case QEMU makes the entry size
+   equal to the cluster size by default.
=20
=20
 Reducing the memory usage
diff --git a/block/qcow2.c b/block/qcow2.c
index 7fb2730f09..48d22f48d5 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -788,6 +788,7 @@ static void read_cache_sizes(BlockDriverState *bs, Qe=
muOpts *opts,
     BDRVQcow2State *s =3D bs->opaque;
     uint64_t combined_cache_size, l2_cache_max_setting;
     bool l2_cache_size_set, refcount_cache_size_set, combined_cache_size=
_set;
+    bool l2_cache_entry_size_set;
     int min_refcount_cache =3D MIN_REFCOUNT_CACHE_SIZE * s->cluster_size=
;
     uint64_t virtual_disk_size =3D bs->total_sectors * BDRV_SECTOR_SIZE;
     uint64_t max_l2_cache =3D virtual_disk_size / (s->cluster_size / 8);
@@ -795,6 +796,7 @@ static void read_cache_sizes(BlockDriverState *bs, Qe=
muOpts *opts,
     combined_cache_size_set =3D qemu_opt_get(opts, QCOW2_OPT_CACHE_SIZE)=
;
     l2_cache_size_set =3D qemu_opt_get(opts, QCOW2_OPT_L2_CACHE_SIZE);
     refcount_cache_size_set =3D qemu_opt_get(opts, QCOW2_OPT_REFCOUNT_CA=
CHE_SIZE);
+    l2_cache_entry_size_set =3D qemu_opt_get(opts, QCOW2_OPT_L2_CACHE_EN=
TRY_SIZE);
=20
     combined_cache_size =3D qemu_opt_get_size(opts, QCOW2_OPT_CACHE_SIZE=
, 0);
     l2_cache_max_setting =3D qemu_opt_get_size(opts, QCOW2_OPT_L2_CACHE_=
SIZE,
@@ -841,6 +843,16 @@ static void read_cache_sizes(BlockDriverState *bs, Q=
emuOpts *opts,
             }
         }
     }
+
+    /*
+     * If the L2 cache is not enough to cover the whole disk then
+     * default to 4KB entries. Smaller entries reduce the cost of
+     * loads and evictions and increase I/O performance.
+     */
+    if (*l2_cache_size < max_l2_cache && !l2_cache_entry_size_set) {
+        *l2_cache_entry_size =3D MIN(s->cluster_size, 4096);
+    }
+
     /* l2_cache_size and refcount_cache_size are ensured to have at leas=
t
      * their minimum values in qcow2_update_options_prepare() */
=20
--=20
2.20.1
