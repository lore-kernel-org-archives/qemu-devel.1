Received: from eggs.gnu.org ([209.51.188.92]:52808)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sbhat@linux.ibm.com>) id 1grFjK-0003Pt-2K
	for qemu-devel@nongnu.org; Wed, 06 Feb 2019 00:26:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sbhat@linux.ibm.com>) id 1grFjA-0004y1-2l
	for qemu-devel@nongnu.org; Wed, 06 Feb 2019 00:26:31 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:49506
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <sbhat@linux.ibm.com>) id 1grFj6-0004vr-D1
	for qemu-devel@nongnu.org; Wed, 06 Feb 2019 00:26:25 -0500
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
	x165OJ6G051631
	for <qemu-devel@nongnu.org>; Wed, 6 Feb 2019 00:26:22 -0500
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2qfscar50w-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 06 Feb 2019 00:26:22 -0500
Received: from localhost
	by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <sbhat@linux.ibm.com>;
	Wed, 6 Feb 2019 05:26:21 -0000
From: Shivaprasad G Bhat <sbhat@linux.ibm.com>
Date: Tue, 05 Feb 2019 23:26:14 -0600
In-Reply-To: <154943058200.27958.11497653677605446596.stgit@lep8c.aus.stglabs.ibm.com>
References: <154943058200.27958.11497653677605446596.stgit@lep8c.aus.stglabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <154943076146.27958.8619995020189724984.stgit@lep8c.aus.stglabs.ibm.com>
Subject: [Qemu-devel] [RFC PATCH 2/4] mem: implement
 memory_device_set_region_size
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: xiaoguangrong.eric@gmail.com, sbhat@linux.ibm.com, mst@redhat.com, bharata@linux.ibm.com, qemu-ppc@nongnu.org, vaibhav@linux.ibm.com, imammedo@redhat.com, david@gibson.dropbear.id.au

Required for PAPR NVDIMM implementation. Need memory_device_set_region_size
for aligning the size to the SCM block size.

Signed-off-by: Shivaprasad G Bhat <sbhat@linux.ibm.com>
---
 hw/mem/memory-device.c         |   15 +++++++++++++++
 include/hw/mem/memory-device.h |    2 ++
 2 files changed, 17 insertions(+)

diff --git a/hw/mem/memory-device.c b/hw/mem/memory-device.c
index 5f2c408036..ad0419e203 100644
--- a/hw/mem/memory-device.c
+++ b/hw/mem/memory-device.c
@@ -330,6 +330,21 @@ uint64_t memory_device_get_region_size(const MemoryDeviceState *md,
     return memory_region_size(mr);
 }
 
+void memory_device_set_region_size(const MemoryDeviceState *md,
+                                   uint64_t size, Error **errp)
+{
+    const MemoryDeviceClass *mdc = MEMORY_DEVICE_GET_CLASS(md);
+    MemoryRegion *mr;
+
+    /* dropping const here is fine as we don't touch the memory region */
+    mr = mdc->get_memory_region((MemoryDeviceState *)md, errp);
+    if (!mr) {
+        return;
+    }
+
+    memory_region_set_size(mr, size);
+}
+
 static const TypeInfo memory_device_info = {
     .name          = TYPE_MEMORY_DEVICE,
     .parent        = TYPE_INTERFACE,
diff --git a/include/hw/mem/memory-device.h b/include/hw/mem/memory-device.h
index 0293a96abb..ba9b72fd28 100644
--- a/include/hw/mem/memory-device.h
+++ b/include/hw/mem/memory-device.h
@@ -103,5 +103,7 @@ void memory_device_plug(MemoryDeviceState *md, MachineState *ms);
 void memory_device_unplug(MemoryDeviceState *md, MachineState *ms);
 uint64_t memory_device_get_region_size(const MemoryDeviceState *md,
                                        Error **errp);
+void memory_device_set_region_size(const MemoryDeviceState *md,
+                                   uint64_t size, Error **errp);
 
 #endif
