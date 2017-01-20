Received: from eggs.gnu.org ([2001:4830:134:3::10]:40560)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <farman@linux.vnet.ibm.com>) id 1cUc0U-0005EL-94
	for qemu-devel@nongnu.org; Fri, 20 Jan 2017 11:25:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <farman@linux.vnet.ibm.com>) id 1cUc0P-0000Zb-Ti
	for qemu-devel@nongnu.org; Fri, 20 Jan 2017 11:25:42 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:35983)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <farman@linux.vnet.ibm.com>)
	id 1cUc0P-0000YU-FS
	for qemu-devel@nongnu.org; Fri, 20 Jan 2017 11:25:37 -0500
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v0KGOJEh141808
	for <qemu-devel@nongnu.org>; Fri, 20 Jan 2017 11:25:36 -0500
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
	by mx0a-001b2d01.pphosted.com with ESMTP id 283bmfgp86-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 20 Jan 2017 11:25:35 -0500
Received: from localhost
	by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <farman@linux.vnet.ibm.com>;
	Fri, 20 Jan 2017 16:25:33 -0000
From: Eric Farman <farman@linux.vnet.ibm.com>
Date: Fri, 20 Jan 2017 17:25:27 +0100
In-Reply-To: <20170120162527.66075-1-farman@linux.vnet.ibm.com>
References: <20170120162527.66075-1-farman@linux.vnet.ibm.com>
Message-Id: <20170120162527.66075-4-farman@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH v3 3/3] block: get max_transfer limit for char
 (scsi-generic) devices
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

We can get the maximum number of bytes for a single I/O transfer
from the BLKSECTGET ioctl, but we only perform this for block
devices.  scsi-generic devices are represented as character devices,
and so do not issue this today.  Update this, so that virtio-scsi
devices using the scsi-generic interface can return the same data.

Signed-off-by: Eric Farman <farman@linux.vnet.ibm.com>
---
 block/file-posix.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/file-posix.c b/block/file-posix.c
index 9f83725..2134e0e 100644
--- a/block/file-posix.c
+++ b/block/file-posix.c
@@ -674,7 +674,7 @@ static void raw_refresh_limits(BlockDriverState *bs, Error **errp)
     struct stat st;
 
     if (!fstat(s->fd, &st)) {
-        if (S_ISBLK(st.st_mode)) {
+        if (S_ISBLK(st.st_mode) || S_ISCHR(st.st_mode)) {
             int ret = hdev_get_max_transfer_length(bs, s->fd);
             if (ret > 0 && ret <= BDRV_REQUEST_MAX_BYTES) {
                 bs->bl.max_transfer = pow2floor(ret);
-- 
2.8.4
