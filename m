Received: from eggs.gnu.org ([2001:4830:134:3::10]:54679)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <xyjxie@linux.vnet.ibm.com>) id 1cg4EA-00030U-0X
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 01:47:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <xyjxie@linux.vnet.ibm.com>) id 1cg4E5-0001jj-3E
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 01:47:10 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:59603)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <xyjxie@linux.vnet.ibm.com>)
	id 1cg4E4-0001jd-Q9
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 01:47:05 -0500
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v1L6dQWW053512
	for <qemu-devel@nongnu.org>; Tue, 21 Feb 2017 01:47:02 -0500
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
	by mx0a-001b2d01.pphosted.com with ESMTP id 28r120bh8e-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 21 Feb 2017 01:47:01 -0500
Received: from localhost
	by e31.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <xyjxie@linux.vnet.ibm.com>;
	Mon, 20 Feb 2017 23:47:01 -0700
From: Yongji Xie <xyjxie@linux.vnet.ibm.com>
Date: Tue, 21 Feb 2017 14:46:55 +0800
Message-Id: <1487659615-15820-1-git-send-email-xyjxie@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH] memory: make ram device read/write endian
 sensitive
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: pbonzini@redhat.com
Cc: qemu-devel@nongnu.org, xyjxie@linux.vnet.ibm.com, alex.williamson@redhat.com, aik@ozlabs.ru, zhong@linux.vnet.ibm.com

At the moment ram device's memory regions are NATIVE_ENDIAN. This does
not work on PPC64 because VFIO PCI device is little endian but PPC64
always defines static macro TARGET_WORDS_BIGENDIAN.

This fixes endianness for ram device the same way as it is done
for VFIO region in commit 6758008e2c4e79fb6bd04fe8e7a41665fa583965.

Signed-off-by: Yongji Xie <xyjxie@linux.vnet.ibm.com>
---
 memory.c |   14 +++++++-------
 1 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/memory.c b/memory.c
index 6c58373..1ccb99f 100644
--- a/memory.c
+++ b/memory.c
@@ -1139,13 +1139,13 @@ static uint64_t memory_region_ram_device_read(void *opaque,
         data = *(uint8_t *)(mr->ram_block->host + addr);
         break;
     case 2:
-        data = *(uint16_t *)(mr->ram_block->host + addr);
+        data = le16_to_cpu(*(uint16_t *)(mr->ram_block->host + addr));
         break;
     case 4:
-        data = *(uint32_t *)(mr->ram_block->host + addr);
+        data = le32_to_cpu(*(uint32_t *)(mr->ram_block->host + addr));
         break;
     case 8:
-        data = *(uint64_t *)(mr->ram_block->host + addr);
+        data = le64_to_cpu(*(uint64_t *)(mr->ram_block->host + addr));
         break;
     }
 
@@ -1166,13 +1166,13 @@ static void memory_region_ram_device_write(void *opaque, hwaddr addr,
         *(uint8_t *)(mr->ram_block->host + addr) = (uint8_t)data;
         break;
     case 2:
-        *(uint16_t *)(mr->ram_block->host + addr) = (uint16_t)data;
+        *(uint16_t *)(mr->ram_block->host + addr) = cpu_to_le16((uint16_t)data);
         break;
     case 4:
-        *(uint32_t *)(mr->ram_block->host + addr) = (uint32_t)data;
+        *(uint32_t *)(mr->ram_block->host + addr) = cpu_to_le32((uint32_t)data);
         break;
     case 8:
-        *(uint64_t *)(mr->ram_block->host + addr) = data;
+        *(uint64_t *)(mr->ram_block->host + addr) = cpu_to_le64(data);
         break;
     }
 }
@@ -1180,7 +1180,7 @@ static void memory_region_ram_device_write(void *opaque, hwaddr addr,
 static const MemoryRegionOps ram_device_mem_ops = {
     .read = memory_region_ram_device_read,
     .write = memory_region_ram_device_write,
-    .endianness = DEVICE_NATIVE_ENDIAN,
+    .endianness = DEVICE_LITTLE_ENDIAN,
     .valid = {
         .min_access_size = 1,
         .max_access_size = 8,
-- 
1.7.1
