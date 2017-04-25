Received: from eggs.gnu.org ([2001:4830:134:3::10]:52482)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ashijeetacharya@gmail.com>) id 1d36bu-0006ja-1x
	for qemu-devel@nongnu.org; Tue, 25 Apr 2017 15:58:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ashijeetacharya@gmail.com>) id 1d36bt-0003uo-D3
	for qemu-devel@nongnu.org; Tue, 25 Apr 2017 15:58:54 -0400
From: Ashijeet Acharya <ashijeetacharya@gmail.com>
Date: Wed, 26 Apr 2017 01:29:04 +0530
Message-Id: <1493150351-28918-2-git-send-email-ashijeetacharya@gmail.com>
In-Reply-To: <1493150351-28918-1-git-send-email-ashijeetacharya@gmail.com>
References: <1493150351-28918-1-git-send-email-ashijeetacharya@gmail.com>
Subject: [Qemu-devel] [PATCH v1 1/8] dmg: Introduce a new struct to cache
 random access points
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

We need to cache the random access point while performing partial
decompression so that we can resume decompression from that point
onwards in our next sequential read request. Introduce a new struct
DMGReadState which will help us do this.

Signed-off-by: Ashijeet Acharya <ashijeetacharya@gmail.com>
---
 block/dmg.h | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/block/dmg.h b/block/dmg.h
index b592d6f..ee67ae1 100644
--- a/block/dmg.h
+++ b/block/dmg.h
@@ -31,6 +31,15 @@
 #include "block/block_int.h"
 #include <zlib.h>
 
+/* used to cache current position in compressed input stream */
+typedef struct DMGReadState {
+    uint8_t *saved_next_in;
+    int64_t saved_avail_in;
+    int32_t saved_chunk_type;
+    int64_t sectors_read; /* possible sectors read in each cycle */
+    int32_t sector_offset_in_chunk;
+} DMGReadState;
+
 typedef struct BDRVDMGState {
     CoMutex lock;
     /* each chunk contains a certain number of sectors,
@@ -51,6 +60,7 @@ typedef struct BDRVDMGState {
     uint8_t *compressed_chunk;
     uint8_t *uncompressed_chunk;
     z_stream zstream;
+    DMGReadState *drs;
 } BDRVDMGState;
 
 extern int (*dmg_uncompress_bz2)(char *next_in, unsigned int avail_in,
-- 
2.6.2
