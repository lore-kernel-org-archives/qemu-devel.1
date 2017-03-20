Received: from eggs.gnu.org ([2001:4830:134:3::10]:41719)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1cq6R2-00025A-7O
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 19:10:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1cq6Qs-0005Cz-Vp
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 19:09:56 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:38883
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1cq6Qs-0005Bf-Mh
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 19:09:46 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v2KN8Xjo014340
	for <qemu-devel@nongnu.org>; Mon, 20 Mar 2017 19:09:46 -0400
Received: from e14.ny.us.ibm.com (e14.ny.us.ibm.com [129.33.205.204])
	by mx0b-001b2d01.pphosted.com with ESMTP id 29af6evvxk-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 20 Mar 2017 19:09:46 -0400
Received: from localhost
	by e14.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Mon, 20 Mar 2017 19:09:45 -0400
From: Michael Roth <mdroth@linux.vnet.ibm.com>
Date: Mon, 20 Mar 2017 18:08:30 -0500
In-Reply-To: <1490051325-3770-1-git-send-email-mdroth@linux.vnet.ibm.com>
References: <1490051325-3770-1-git-send-email-mdroth@linux.vnet.ibm.com>
Message-Id: <1490051325-3770-67-git-send-email-mdroth@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH 66/81] block/vmdk: Fix the endian problem of
 buf_len and lba
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, QingFeng Hao <haoqf@linux.vnet.ibm.com>, Jing Liu <liujbjl@linux.vnet.ibm.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>

From: QingFeng Hao <haoqf@linux.vnet.ibm.com>

The problem was triggered by qemu-iotests case 055. It failed when it
was comparing the compressed vmdk image with original test.img.

The cause is that buf_len in vmdk_write_extent wasn't converted to
little-endian before it was stored to disk. But later vmdk_read_extent
read it and converted it from little-endian to cpu endian.
If the cpu is big-endian like s390, the problem will happen and
the data length read by vmdk_read_extent will become invalid!
The fix is to add the conversion in vmdk_write_extent, meanwhile,
repair the endianness problem of lba field which shall also be converted
to little-endian before storing to disk.

Cc: qemu-stable@nongnu.org
Signed-off-by: QingFeng Hao <haoqf@linux.vnet.ibm.com>
Signed-off-by: Jing Liu <liujbjl@linux.vnet.ibm.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
Reviewed-by: Fam Zheng <famz@redhat.com>
Message-id: 20161216052040.53067-2-haoqf@linux.vnet.ibm.com
Signed-off-by: Max Reitz <mreitz@redhat.com>
(cherry picked from commit 4545d4f4af8b29ba3b38dfb74d6f45342e15a62d)
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 block/vmdk.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/block/vmdk.c b/block/vmdk.c
index a11c27a..26e5f95 100644
--- a/block/vmdk.c
+++ b/block/vmdk.c
@@ -1354,8 +1354,8 @@ static int vmdk_write_extent(VmdkExtent *extent, int64_t cluster_offset,
             goto out;
         }
 
-        data->lba = offset >> BDRV_SECTOR_BITS;
-        data->size = buf_len;
+        data->lba = cpu_to_le64(offset >> BDRV_SECTOR_BITS);
+        data->size = cpu_to_le32(buf_len);
 
         n_bytes = buf_len + sizeof(VmdkGrainMarker);
         iov = (struct iovec) {
-- 
2.7.4
