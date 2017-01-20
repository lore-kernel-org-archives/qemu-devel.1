Received: from eggs.gnu.org ([2001:4830:134:3::10]:40828)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <farman@linux.vnet.ibm.com>) id 1cUc11-0005eI-J2
	for qemu-devel@nongnu.org; Fri, 20 Jan 2017 11:26:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <farman@linux.vnet.ibm.com>) id 1cUc0x-0000xp-Gw
	for qemu-devel@nongnu.org; Fri, 20 Jan 2017 11:26:15 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:56619
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <farman@linux.vnet.ibm.com>)
	id 1cUc0x-0000xN-CT
	for qemu-devel@nongnu.org; Fri, 20 Jan 2017 11:26:11 -0500
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v0KGQ2nU035324
	for <qemu-devel@nongnu.org>; Fri, 20 Jan 2017 11:26:10 -0500
Received: from e06smtp10.uk.ibm.com (e06smtp10.uk.ibm.com [195.75.94.106])
	by mx0b-001b2d01.pphosted.com with ESMTP id 283hjm2tkw-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 20 Jan 2017 11:26:10 -0500
Received: from localhost
	by e06smtp10.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <farman@linux.vnet.ibm.com>;
	Fri, 20 Jan 2017 16:25:33 -0000
From: Eric Farman <farman@linux.vnet.ibm.com>
Date: Fri, 20 Jan 2017 17:25:26 +0100
In-Reply-To: <20170120162527.66075-1-farman@linux.vnet.ibm.com>
References: <20170120162527.66075-1-farman@linux.vnet.ibm.com>
Message-Id: <20170120162527.66075-3-farman@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH v3 2/3] block: Fix target variable of
 BLKSECTGET ioctl
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: Eric Farman <farman@linux.vnet.ibm.com>, kwolf@redhat.com, mreitz@redhat.com

Commit 6f6071745bd0 ("raw-posix: Fetch max sectors for host block device")
introduced a routine to call the kernel BLKSECTGET ioctl, which stores the
result back to user space.  However, the size of the data returned depends
on the routine handling the ioctl.  The (compat_)blkdev_ioctl returns a
short, while sg_ioctl returns an int.  Thus, on big-endian systems, we can
find ourselves accidentally shifting the result to a much larger value.
(On s390x, a short is 16 bits while an int is 32 bits.)

Also, the two ioctl handlers return values in different scales (block
returns sectors, while sg returns bytes), so some tweaking of the outputs
is required such that hdev_get_max_transfer_length returns a value in a
consistent set of units.

Signed-off-by: Eric Farman <farman@linux.vnet.ibm.com>
---
 block/file-posix.c    | 17 ++++++++++-------
 include/block/block.h |  1 +
 2 files changed, 11 insertions(+), 7 deletions(-)

diff --git a/block/file-posix.c b/block/file-posix.c
index 28b47d9..9f83725 100644
--- a/block/file-posix.c
+++ b/block/file-posix.c
@@ -651,12 +651,15 @@ static void raw_reopen_abort(BDRVReopenState *state)
     state->opaque = NULL;
 }
 
-static int hdev_get_max_transfer_length(int fd)
+static int hdev_get_max_transfer_length(BlockDriverState *bs, int fd)
 {
 #ifdef BLKSECTGET
-    int max_sectors = 0;
-    if (ioctl(fd, BLKSECTGET, &max_sectors) == 0) {
-        return max_sectors;
+    int max_bytes = 0;
+    short max_sectors = 0;
+    if (bs->sg && ioctl(fd, BLKSECTGET, &max_bytes) == 0) {
+        return max_bytes;
+    } else if (!bs->sg && ioctl(fd, BLKSECTGET, &max_sectors) == 0) {
+        return max_sectors << BDRV_SECTOR_BITS;
     } else {
         return -errno;
     }
@@ -672,9 +675,9 @@ static void raw_refresh_limits(BlockDriverState *bs, Error **errp)
 
     if (!fstat(s->fd, &st)) {
         if (S_ISBLK(st.st_mode)) {
-            int ret = hdev_get_max_transfer_length(s->fd);
-            if (ret > 0 && ret <= BDRV_REQUEST_MAX_SECTORS) {
-                bs->bl.max_transfer = pow2floor(ret << BDRV_SECTOR_BITS);
+            int ret = hdev_get_max_transfer_length(bs, s->fd);
+            if (ret > 0 && ret <= BDRV_REQUEST_MAX_BYTES) {
+                bs->bl.max_transfer = pow2floor(ret);
             }
         }
     }
diff --git a/include/block/block.h b/include/block/block.h
index 8b0dcda..4e81f20 100644
--- a/include/block/block.h
+++ b/include/block/block.h
@@ -116,6 +116,7 @@ typedef struct HDGeometry {
 
 #define BDRV_REQUEST_MAX_SECTORS MIN(SIZE_MAX >> BDRV_SECTOR_BITS, \
                                      INT_MAX >> BDRV_SECTOR_BITS)
+#define BDRV_REQUEST_MAX_BYTES (BDRV_REQUEST_MAX_SECTORS << BDRV_SECTOR_BITS)
 
 /*
  * Allocation status flags
-- 
2.8.4
