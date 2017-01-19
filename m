Received: from eggs.gnu.org ([2001:4830:134:3::10]:59537)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <farman@linux.vnet.ibm.com>) id 1cUJgQ-0004WY-K8
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 15:51:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <farman@linux.vnet.ibm.com>) id 1cUJgM-000840-ML
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 15:51:46 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:57469
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <farman@linux.vnet.ibm.com>)
	id 1cUJgM-00083E-Gx
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 15:51:42 -0500
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v0JKhwGv081857
	for <qemu-devel@nongnu.org>; Thu, 19 Jan 2017 15:51:41 -0500
Received: from e06smtp15.uk.ibm.com (e06smtp15.uk.ibm.com [195.75.94.111])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2832af5yts-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 19 Jan 2017 15:51:41 -0500
Received: from localhost
	by e06smtp15.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <farman@linux.vnet.ibm.com>;
	Thu, 19 Jan 2017 20:51:40 -0000
From: Eric Farman <farman@linux.vnet.ibm.com>
Date: Thu, 19 Jan 2017 21:51:33 +0100
In-Reply-To: <20170119205134.50112-1-farman@linux.vnet.ibm.com>
References: <20170119205134.50112-1-farman@linux.vnet.ibm.com>
Message-Id: <20170119205134.50112-3-farman@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH v2 2/3] block: Fix target variable of
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

Commit 6f607174 introduced a routine to call the kernel BLKSECTGET
ioctl, which stores the result back to user space.  However, the
size of the data returned depends on the routine handling the ioctl.
The (compat_)blkdev_ioctl returns a short, while sg_ioctl returns
an int.  Thus, on big-endian systems, we can find ourselves
accidentally shifting the result to a much larger value.
(On s390x, a short is 16 bits while an int is 32 bits.)

Signed-off-by: Eric Farman <farman@linux.vnet.ibm.com>
---
 block/file-posix.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/block/file-posix.c b/block/file-posix.c
index 28b47d9..2115155 100644
--- a/block/file-posix.c
+++ b/block/file-posix.c
@@ -651,12 +651,15 @@ static void raw_reopen_abort(BDRVReopenState *state)
     state->opaque = NULL;
 }
 
-static int hdev_get_max_transfer_length(int fd)
+static int hdev_get_max_transfer_length(BlockDriverState *bs, int fd)
 {
 #ifdef BLKSECTGET
     int max_sectors = 0;
-    if (ioctl(fd, BLKSECTGET, &max_sectors) == 0) {
+    short max_sectors_short = 0;
+    if (bs->sg && ioctl(fd, BLKSECTGET, &max_sectors) == 0) {
         return max_sectors;
+    } else if (!bs->sg && ioctl(fd, BLKSECTGET, &max_sectors_short) == 0) {
+        return max_sectors_short;
     } else {
         return -errno;
     }
@@ -672,7 +675,7 @@ static void raw_refresh_limits(BlockDriverState *bs, Error **errp)
 
     if (!fstat(s->fd, &st)) {
         if (S_ISBLK(st.st_mode)) {
-            int ret = hdev_get_max_transfer_length(s->fd);
+            int ret = hdev_get_max_transfer_length(bs, s->fd);
             if (ret > 0 && ret <= BDRV_REQUEST_MAX_SECTORS) {
                 bs->bl.max_transfer = pow2floor(ret << BDRV_SECTOR_BITS);
             }
-- 
2.8.4
