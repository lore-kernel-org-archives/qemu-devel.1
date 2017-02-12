Received: from eggs.gnu.org ([2001:4830:134:3::10]:46983)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1ccj6O-0005Ie-Rd
	for qemu-devel@nongnu.org; Sat, 11 Feb 2017 20:37:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1ccj6L-00076R-HQ
	for qemu-devel@nongnu.org; Sat, 11 Feb 2017 20:37:20 -0500
From: Max Reitz <mreitz@redhat.com>
Date: Sun, 12 Feb 2017 02:36:49 +0100
Message-Id: <20170212013704.6378-4-mreitz@redhat.com>
In-Reply-To: <20170212013704.6378-1-mreitz@redhat.com>
References: <20170212013440.5919-1-mreitz@redhat.com>
	<20170212013704.6378-1-mreitz@redhat.com>
Subject: [Qemu-devel] [PULL 06/21] block/vmdk: Fix the endian problem of
 buf_len and lba
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, Peter Maydell <peter.maydell@linaro.org>

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
---
 block/vmdk.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/block/vmdk.c b/block/vmdk.c
index 7750212969..393c84d8b1 100644
--- a/block/vmdk.c
+++ b/block/vmdk.c
@@ -1361,8 +1361,8 @@ static int vmdk_write_extent(VmdkExtent *extent, int64_t cluster_offset,
             goto out;
         }
 
-        data->lba = offset >> BDRV_SECTOR_BITS;
-        data->size = buf_len;
+        data->lba = cpu_to_le64(offset >> BDRV_SECTOR_BITS);
+        data->size = cpu_to_le32(buf_len);
 
         n_bytes = buf_len + sizeof(VmdkGrainMarker);
         iov = (struct iovec) {
-- 
2.11.0
