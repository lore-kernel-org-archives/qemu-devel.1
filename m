Received: from eggs.gnu.org ([2001:4830:134:3::10]:40679)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cornelia.huck@de.ibm.com>) id 1d1TBX-00010v-SU
	for qemu-devel@nongnu.org; Fri, 21 Apr 2017 03:40:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cornelia.huck@de.ibm.com>) id 1d1TBX-0000ep-15
	for qemu-devel@nongnu.org; Fri, 21 Apr 2017 03:40:55 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:44580
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cornelia.huck@de.ibm.com>)
	id 1d1TBW-0000eb-QW
	for qemu-devel@nongnu.org; Fri, 21 Apr 2017 03:40:54 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v3L7ess5127990
	for <qemu-devel@nongnu.org>; Fri, 21 Apr 2017 03:40:54 -0400
Received: from e06smtp15.uk.ibm.com (e06smtp15.uk.ibm.com [195.75.94.111])
	by mx0b-001b2d01.pphosted.com with ESMTP id 29xvy2sy3m-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 21 Apr 2017 03:40:54 -0400
Received: from localhost
	by e06smtp15.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <cornelia.huck@de.ibm.com>;
	Fri, 21 Apr 2017 08:40:52 +0100
From: Cornelia Huck <cornelia.huck@de.ibm.com>
Date: Fri, 21 Apr 2017 09:40:34 +0200
In-Reply-To: <20170421074038.774-1-cornelia.huck@de.ibm.com>
References: <20170421074038.774-1-cornelia.huck@de.ibm.com>
Message-Id: <20170421074038.774-8-cornelia.huck@de.ibm.com>
Subject: [Qemu-devel] [PULL 07/11] s390x: use enum for adapter type and
 standardize its naming
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: borntraeger@de.ibm.com, agraf@suse.de, qemu-devel@nongnu.org, Fei Li <sherrylf@linux.vnet.ibm.com>, Cornelia Huck <cornelia.huck@de.ibm.com>

From: Fei Li <sherrylf@linux.vnet.ibm.com>

Let's use an enum for io adapter type, and standardize its naming to
CSS_IO_ADAPTER_* by changing S390_PCIPT_ADAPTER to CSS_IO_ADAPTER_PCI.

Signed-off-by: Fei Li <sherrylf@linux.vnet.ibm.com>
Reviewed-by: Cornelia Huck <cornelia.huck@de.ibm.com>
Signed-off-by: Cornelia Huck <cornelia.huck@de.ibm.com>
---
 hw/s390x/css.c           | 2 +-
 hw/s390x/s390-pci-bus.h  | 1 -
 hw/s390x/s390-pci-inst.c | 2 +-
 include/hw/s390x/css.h   | 9 +++++++--
 4 files changed, 9 insertions(+), 5 deletions(-)

diff --git a/hw/s390x/css.c b/hw/s390x/css.c
index f966ce2d15..1b242c1fb7 100644
--- a/hw/s390x/css.c
+++ b/hw/s390x/css.c
@@ -155,7 +155,7 @@ int css_create_css_image(uint8_t cssid, bool default_image)
     return 0;
 }
 
-int css_register_io_adapter(uint8_t type, uint8_t isc, bool swap,
+int css_register_io_adapter(CssIoAdapterType type, uint8_t isc, bool swap,
                             bool maskable, uint32_t *id)
 {
     IoAdapter *adapter;
diff --git a/hw/s390x/s390-pci-bus.h b/hw/s390x/s390-pci-bus.h
index dcbf4820c9..cf142a3e68 100644
--- a/hw/s390x/s390-pci-bus.h
+++ b/hw/s390x/s390-pci-bus.h
@@ -30,7 +30,6 @@
 #define FH_MASK_INDEX    0x0000ffff
 #define FH_SHM_VFIO      0x00010000
 #define FH_SHM_EMUL      0x00020000
-#define S390_PCIPT_ADAPTER 2
 #define ZPCI_MAX_FID 0xffffffff
 #define ZPCI_MAX_UID 0xffff
 #define UID_UNDEFINED 0
diff --git a/hw/s390x/s390-pci-inst.c b/hw/s390x/s390-pci-inst.c
index f520ce105f..93980d6b1f 100644
--- a/hw/s390x/s390-pci-inst.c
+++ b/hw/s390x/s390-pci-inst.c
@@ -734,7 +734,7 @@ static int reg_irqs(CPUS390XState *env, S390PCIBusDevice *pbdev, ZpciFib fib)
 {
     int ret, len;
 
-    ret = css_register_io_adapter(S390_PCIPT_ADAPTER,
+    ret = css_register_io_adapter(CSS_IO_ADAPTER_PCI,
                                   FIB_DATA_ISC(ldl_p(&fib.data)), true, false,
                                   &pbdev->routes.adapter.adapter_id);
     assert(ret == 0);
diff --git a/include/hw/s390x/css.h b/include/hw/s390x/css.h
index e88f24b868..cdc73fe0aa 100644
--- a/include/hw/s390x/css.h
+++ b/include/hw/s390x/css.h
@@ -124,8 +124,13 @@ void css_generate_css_crws(uint8_t cssid);
 void css_clear_sei_pending(void);
 void css_adapter_interrupt(uint8_t isc);
 
-#define CSS_IO_ADAPTER_VIRTIO 1
-int css_register_io_adapter(uint8_t type, uint8_t isc, bool swap,
+typedef enum {
+    CSS_IO_ADAPTER_VIRTIO = 0,
+    CSS_IO_ADAPTER_PCI = 1,
+    CSS_IO_ADAPTER_TYPE_NUMS,
+} CssIoAdapterType;
+
+int css_register_io_adapter(CssIoAdapterType type, uint8_t isc, bool swap,
                             bool maskable, uint32_t *id);
 
 #ifndef CONFIG_USER_ONLY
-- 
2.11.0
