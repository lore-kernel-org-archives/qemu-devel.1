Received: from eggs.gnu.org ([2001:4830:134:3::10]:52525)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ashijeetacharya@gmail.com>) id 1d36c2-0006re-Rl
	for qemu-devel@nongnu.org; Tue, 25 Apr 2017 15:59:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ashijeetacharya@gmail.com>) id 1d36bz-0003x9-Nt
	for qemu-devel@nongnu.org; Tue, 25 Apr 2017 15:59:02 -0400
From: Ashijeet Acharya <ashijeetacharya@gmail.com>
Date: Wed, 26 Apr 2017 01:29:05 +0530
Message-Id: <1493150351-28918-3-git-send-email-ashijeetacharya@gmail.com>
In-Reply-To: <1493150351-28918-1-git-send-email-ashijeetacharya@gmail.com>
References: <1493150351-28918-1-git-send-email-ashijeetacharya@gmail.com>
Subject: [Qemu-devel] [PATCH v1 2/8] dmg: New function to help us cache
 random access point
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: stefanha@gmail.com
Cc: kwolf@redhat.com, jsnow@redhat.com, mreitz@redhat.com, famz@redhat.com, peter@lekensteyn.nl, qemu-devel@nongnu.org, qemu-block@nongnu.org, Ashijeet Acharya <ashijeetacharya@gmail.com>

Introduce a new cache_access_point() function which will help us first
cache a random access point inside a compressed stream and then keep
updating it according to our requirement at appropriate times.

Signed-off-by: Ashijeet Acharya <ashijeetacharya@gmail.com>
---
 block/dmg.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/block/dmg.c b/block/dmg.c
index a7d25fc..c6fe8b0 100644
--- a/block/dmg.c
+++ b/block/dmg.c
@@ -128,6 +128,18 @@ static void update_max_chunk_size(BDRVDMGState *s, uint32_t chunk,
     }
 }
 
+static void cache_access_point(DMGReadState *drs, uint8_t *next_in,
+                                int64_t avail_in, int32_t chunk,
+                                int64_t sectors_read, int32_t sector_offset)
+{
+    drs->saved_next_in = next_in;
+    drs->saved_avail_in = avail_in;
+    drs->saved_chunk_type = chunk;
+    drs->sectors_read = sectors_read;
+    drs->sector_offset_in_chunk = sector_offset;
+    return;
+}
+
 static int64_t dmg_find_koly_offset(BdrvChild *file, Error **errp)
 {
     BlockDriverState *file_bs = file->bs;
@@ -507,6 +519,10 @@ static int dmg_open(BlockDriverState *bs, QDict *options, int flags,
         goto fail;
     }
 
+    s->drs = g_malloc(sizeof(DMGReadState));
+    /* initialise our access point cache */
+    cache_access_point(s->drs, NULL, -1, -1, -1, -1);
+
     if (inflateInit(&s->zstream) != Z_OK) {
         ret = -EINVAL;
         goto fail;
@@ -523,6 +539,7 @@ fail:
     g_free(s->lengths);
     g_free(s->sectors);
     g_free(s->sectorcounts);
+    g_free(s->drs);
     qemu_vfree(s->compressed_chunk);
     qemu_vfree(s->uncompressed_chunk);
     return ret;
@@ -685,6 +702,7 @@ static void dmg_close(BlockDriverState *bs)
     g_free(s->lengths);
     g_free(s->sectors);
     g_free(s->sectorcounts);
+    g_free(s->drs);
     qemu_vfree(s->compressed_chunk);
     qemu_vfree(s->uncompressed_chunk);
 
-- 
2.6.2
