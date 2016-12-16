Received: from eggs.gnu.org ([2001:4830:134:3::10]:46117)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <haoqf@linux.vnet.ibm.com>) id 1cHkxE-0007Kq-Ct
	for qemu-devel@nongnu.org; Fri, 16 Dec 2016 00:21:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <haoqf@linux.vnet.ibm.com>) id 1cHkxB-00063t-LR
	for qemu-devel@nongnu.org; Fri, 16 Dec 2016 00:21:12 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:32879)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <haoqf@linux.vnet.ibm.com>)
	id 1cHkxB-00062z-Bi
	for qemu-devel@nongnu.org; Fri, 16 Dec 2016 00:21:09 -0500
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
	uBG5JQwR142975
	for <qemu-devel@nongnu.org>; Fri, 16 Dec 2016 00:21:08 -0500
Received: from e06smtp15.uk.ibm.com (e06smtp15.uk.ibm.com [195.75.94.111])
	by mx0a-001b2d01.pphosted.com with ESMTP id 27c6muwsur-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 16 Dec 2016 00:21:07 -0500
Received: from localhost
	by e06smtp15.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <haoqf@linux.vnet.ibm.com>;
	Fri, 16 Dec 2016 05:21:05 -0000
From: QingFeng Hao <haoqf@linux.vnet.ibm.com>
Date: Fri, 16 Dec 2016 06:20:40 +0100
In-Reply-To: <20161216052040.53067-1-haoqf@linux.vnet.ibm.com>
References: <20161216052040.53067-1-haoqf@linux.vnet.ibm.com>
Message-Id: <20161216052040.53067-2-haoqf@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH v3 1/1] block/vmdk: Fix the endian problem of
 buf_len and lba
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: borntraeger@de.ibm.com, cornelia.huck@de.ibm.com, liujbjl@linux.vnet.ibm.com, kwolf@redhat.com, famz@redhat.com, QingFeng Hao <haoqf@linux.vnet.ibm.com>, qemu-stable@nongnu.org

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
2.8.4
