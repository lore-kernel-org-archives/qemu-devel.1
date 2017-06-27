Received: from eggs.gnu.org ([2001:4830:134:3::10]:42465)
	by lists.gnu.org with esmtp (Exim 4.71) (envelope-from <pl@kamp.de>)
	id 1dPphQ-00057f-Em
	for qemu-devel@nongnu.org; Tue, 27 Jun 2017 08:34:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pl@kamp.de>) id 1dPphO-0005Hg-RZ
	for qemu-devel@nongnu.org; Tue, 27 Jun 2017 08:34:32 -0400
Received: from mx-v6.kamp.de ([2a02:248:0:51::16]:53826 helo=mx01.kamp.de)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pl@kamp.de>) id 1dPphO-0005Gc-HS
	for qemu-devel@nongnu.org; Tue, 27 Jun 2017 08:34:30 -0400
From: Peter Lieven <pl@kamp.de>
Date: Tue, 27 Jun 2017 14:34:10 +0200
Message-Id: <1498566850-7934-5-git-send-email-pl@kamp.de>
In-Reply-To: <1498566850-7934-1-git-send-email-pl@kamp.de>
References: <1498566850-7934-1-git-send-email-pl@kamp.de>
Subject: [Qemu-devel] [PATCH 4/4] block/qcow2: add zlib-fast compression
 algorithm
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, lersek@redhat.com, den@openvz.org, mreitz@redhat.com, eblake@redhat.com, Peter Lieven <pl@kamp.de>

this adds support for optimized zlib settings which almost
tripples the compression speed while maintaining about
the same compressed size.

Signed-off-by: Peter Lieven <pl@kamp.de>
---
 block/qcow2-cluster.c |  3 ++-
 block/qcow2.c         | 11 +++++++++--
 block/qcow2.h         |  1 +
 qemu-img.texi         |  1 +
 4 files changed, 13 insertions(+), 3 deletions(-)

diff --git a/block/qcow2-cluster.c b/block/qcow2-cluster.c
index ecb059b..d8e2378 100644
--- a/block/qcow2-cluster.c
+++ b/block/qcow2-cluster.c
@@ -1532,6 +1532,7 @@ static int decompress_buffer(uint8_t *out_buf, int out_buf_size,
 
     switch (compression_algorithm_id) {
     case QCOW2_COMPRESSION_ZLIB:
+    case QCOW2_COMPRESSION_ZLIB_FAST:
         memset(strm, 0, sizeof(*strm));
 
         strm->next_in = (uint8_t *)buf;
@@ -1539,7 +1540,7 @@ static int decompress_buffer(uint8_t *out_buf, int out_buf_size,
         strm->next_out = out_buf;
         strm->avail_out = out_buf_size;
 
-        ret = inflateInit2(strm, -12);
+        ret = inflateInit2(strm, -15);
         if (ret != Z_OK) {
             return -1;
         }
diff --git a/block/qcow2.c b/block/qcow2.c
index bd65582..f07d8f0 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -87,6 +87,8 @@ static uint32_t is_compression_algorithm_supported(char *algorithm)
         /* no algorithm means the old default of zlib compression
          * with 12 window bits */
         return QCOW2_COMPRESSION_ZLIB;
+    } else if (!strcmp(algorithm, "zlib-fast")) {
+        return QCOW2_COMPRESSION_ZLIB_FAST;
 #ifdef CONFIG_LZO
     } else if (!strcmp(algorithm, "lzo")) {
         return QCOW2_COMPRESSION_LZO;
@@ -2722,6 +2724,7 @@ qcow2_co_pwritev_compressed(BlockDriverState *bs, uint64_t offset,
     QEMUIOVector hd_qiov;
     struct iovec iov;
     z_stream strm;
+    int z_level = Z_DEFAULT_COMPRESSION, z_windowBits = -12;
     int ret, out_len = 0;
     uint8_t *buf, *out_buf = NULL, *local_buf = NULL, *work_buf = NULL;
     uint64_t cluster_offset;
@@ -2749,13 +2752,17 @@ qcow2_co_pwritev_compressed(BlockDriverState *bs, uint64_t offset,
     }
 
     switch (s->compression_algorithm_id) {
+    case QCOW2_COMPRESSION_ZLIB_FAST:
+        z_level = Z_BEST_SPEED;
+        z_windowBits = -15;
+        /* fall-through */
     case QCOW2_COMPRESSION_ZLIB:
         out_buf = g_malloc(s->cluster_size);
 
         /* best compression, small window, no zlib header */
         memset(&strm, 0, sizeof(strm));
-        ret = deflateInit2(&strm, Z_DEFAULT_COMPRESSION,
-                           Z_DEFLATED, -12,
+        ret = deflateInit2(&strm, z_level,
+                           Z_DEFLATED, z_windowBits,
                            9, Z_DEFAULT_STRATEGY);
         if (ret != 0) {
             ret = -EINVAL;
diff --git a/block/qcow2.h b/block/qcow2.h
index 716012c..a89f986 100644
--- a/block/qcow2.h
+++ b/block/qcow2.h
@@ -173,6 +173,7 @@ typedef struct Qcow2UnknownHeaderExtension {
 enum {
     QCOW2_COMPRESSION_ZLIB          = 0xC0318301,
     QCOW2_COMPRESSION_LZO           = 0xC0318302,
+    QCOW2_COMPRESSION_ZLIB_FAST     = 0xC0318303,
 };
 
 enum {
diff --git a/qemu-img.texi b/qemu-img.texi
index 043c1ba..83a5db2 100644
--- a/qemu-img.texi
+++ b/qemu-img.texi
@@ -627,6 +627,7 @@ The following options are available if support for the respective libraries
 has been enabled at compile time:
 
    zlib            Uses standard zlib compression (default)
+   zlib-fast       Uses zlib compression with optimized compression parameters
    lzo             Uses LZO1X compression
 
 The compression algorithm can only be defined at image create time and cannot
-- 
1.9.1
