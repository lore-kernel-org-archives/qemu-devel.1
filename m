Received: from eggs.gnu.org ([2001:4830:134:3::10]:50615)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <farman@linux.vnet.ibm.com>) id 1cTEZc-0004IB-Cv
	for qemu-devel@nongnu.org; Mon, 16 Jan 2017 16:12:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <farman@linux.vnet.ibm.com>) id 1cTEZa-0001BD-55
	for qemu-devel@nongnu.org; Mon, 16 Jan 2017 16:12:16 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:38263)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <farman@linux.vnet.ibm.com>)
	id 1cTEZZ-0001Ak-RC
	for qemu-devel@nongnu.org; Mon, 16 Jan 2017 16:12:14 -0500
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v0GL9Ccb039348
	for <qemu-devel@nongnu.org>; Mon, 16 Jan 2017 16:12:13 -0500
Received: from e06smtp10.uk.ibm.com (e06smtp10.uk.ibm.com [195.75.94.106])
	by mx0a-001b2d01.pphosted.com with ESMTP id 28129cfqvt-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 16 Jan 2017 16:12:12 -0500
Received: from localhost
	by e06smtp10.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <farman@linux.vnet.ibm.com>;
	Mon, 16 Jan 2017 21:12:08 -0000
From: Eric Farman <farman@linux.vnet.ibm.com>
Date: Mon, 16 Jan 2017 22:12:01 +0100
In-Reply-To: <20170116211201.46601-1-farman@linux.vnet.ibm.com>
References: <20170116211201.46601-1-farman@linux.vnet.ibm.com>
Message-Id: <20170116211201.46601-4-farman@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH 3/3] block: get max_transfer limit for char
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
Cc: kwolf@redhat.com, mreitz@redhat.com, pbonzini@redhat.com, Eric Farman <farman@linux.vnet.ibm.com>

Commit 6f607174 introduced a routine to get the maximum number
of bytes for a single I/O transfer for block devices, however
scsi generic devices are character devices, not block.  Add
a condition for this, with slightly different logic because
the value is already in bytes, and need not be converted from
blocks as happens for block devices.

Signed-off-by: Eric Farman <farman@linux.vnet.ibm.com>
---
 block/file-posix.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/block/file-posix.c b/block/file-posix.c
index 2115155..c0843c2 100644
--- a/block/file-posix.c
+++ b/block/file-posix.c
@@ -679,6 +679,13 @@ static void raw_refresh_limits(BlockDriverState *bs, Error **errp)
             if (ret > 0 && ret <= BDRV_REQUEST_MAX_SECTORS) {
                 bs->bl.max_transfer = pow2floor(ret << BDRV_SECTOR_BITS);
             }
+        } else if (S_ISCHR(st.st_mode)) {
+            /* sg returns transfer length in bytes already */
+            int ret = hdev_get_max_transfer_length(bs, s->fd);
+            if (ret > 0 &&
+                (ret >> BDRV_SECTOR_BITS) <= BDRV_REQUEST_MAX_SECTORS) {
+                bs->bl.max_transfer = pow2floor(ret);
+            }
         }
     }
 
-- 
2.8.4
