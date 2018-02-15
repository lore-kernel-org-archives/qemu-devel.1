Received: from eggs.gnu.org ([2001:4830:134:3::10]:44255)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <walling@linux.vnet.ibm.com>) id 1emSah-0007Kq-7n
	for qemu-devel@nongnu.org; Thu, 15 Feb 2018 18:05:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <walling@linux.vnet.ibm.com>) id 1emSac-0003G7-60
	for qemu-devel@nongnu.org; Thu, 15 Feb 2018 18:05:22 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:43780
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <walling@linux.vnet.ibm.com>)
	id 1emSab-0003EN-JT
	for qemu-devel@nongnu.org; Thu, 15 Feb 2018 18:05:17 -0500
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w1FN0FcB052322
	for <qemu-devel@nongnu.org>; Thu, 15 Feb 2018 18:05:17 -0500
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2g5ke7ga1c-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 15 Feb 2018 18:05:16 -0500
Received: from localhost
	by e35.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <walling@linux.vnet.ibm.com>;
	Thu, 15 Feb 2018 15:55:04 -0700
From: "Collin L. Walling" <walling@linux.vnet.ibm.com>
Date: Thu, 15 Feb 2018 17:54:26 -0500
In-Reply-To: <1518735273-16089-1-git-send-email-walling@linux.vnet.ibm.com>
References: <1518735273-16089-1-git-send-email-walling@linux.vnet.ibm.com>
Message-Id: <1518735273-16089-6-git-send-email-walling@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH v6 05/12] s390-ccw: move auxiliary IPL data to
 separate location
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-s390x@nongnu.org, qemu-devel@nongnu.org
Cc: borntraeger@de.ibm.com, frankja@linux.vnet.ibm.com, cohuck@redhat.com, thuth@redhat.com, david@redhat.com, alifm@linux.vnet.ibm.com, eblake@redhat.com, mihajlov@linux.vnet.ibm.com

The s390-ccw firmware needs some information in support of the
boot process which is not available on the native machine.
Examples are the netboot firmware load address and now the
boot menu parameters.

While storing that data in unused fields of the IPL parameter block
works, that approach could create problems if the parameter block
definition should change in the future. Because then a guest could
overwrite these fields using the set IPLB diagnose.

In fact the data in question is of more global nature and not really
tied to an IPL device, so separating it is rather logical.

This commit introduces a new structure to hold firmware relevant
IPL parameters set by QEMU. The data is stored at location 204 (dec)
and can contain up to 7 32-bit words. This area is available to
programming in the z/Architecture Principles of Operation and
can thus safely be used by the firmware until the IPL has completed.

Signed-off-by: Viktor Mihajlovski <mihajlov@linux.vnet.ibm.com>
---
 hw/s390x/ipl.c          | 19 ++++++++++++++++++-
 hw/s390x/ipl.h          | 13 +++++++++++--
 pc-bios/s390-ccw/iplb.h | 14 ++++++++++++--
 pc-bios/s390-ccw/main.c |  6 +++++-
 4 files changed, 46 insertions(+), 6 deletions(-)

diff --git a/hw/s390x/ipl.c b/hw/s390x/ipl.c
index 0d06fc1..31565ce 100644
--- a/hw/s390x/ipl.c
+++ b/hw/s390x/ipl.c
@@ -399,6 +399,21 @@ void s390_reipl_request(void)
     qemu_system_reset_request(SHUTDOWN_CAUSE_GUEST_RESET);
 }
 
+static void s390_ipl_prepare_qipl(S390CPU *cpu)
+{
+    S390IPLState *ipl = get_ipl_device();
+    uint8_t *addr;
+    uint64_t len = 4096;
+
+    addr = cpu_physical_memory_map(cpu->env.psa, &len, 1);
+    if (!addr || len < QIPL_ADDRESS + sizeof(QemuIplParameters)) {
+        error_report("Cannot set QEMU IPL parameters");
+        return;
+    }
+    memcpy(addr + QIPL_ADDRESS, &ipl->iplb.qipl, sizeof(QemuIplParameters));
+    cpu_physical_memory_unmap(addr, len, 1, len);
+}
+
 void s390_ipl_prepare_cpu(S390CPU *cpu)
 {
     S390IPLState *ipl = get_ipl_device();
@@ -418,8 +433,10 @@ void s390_ipl_prepare_cpu(S390CPU *cpu)
             error_report_err(err);
             vm_stop(RUN_STATE_INTERNAL_ERROR);
         }
-        ipl->iplb.ccw.netboot_start_addr = cpu_to_be64(ipl->start_addr);
+        ipl->iplb.qipl.netboot_start_addr = cpu_to_be64(ipl->start_addr);
     }
+    s390_ipl_prepare_qipl(cpu);
+
 }
 
 static void s390_ipl_reset(DeviceState *dev)
diff --git a/hw/s390x/ipl.h b/hw/s390x/ipl.h
index 8a705e0..cab8a97 100644
--- a/hw/s390x/ipl.h
+++ b/hw/s390x/ipl.h
@@ -16,8 +16,7 @@
 #include "cpu.h"
 
 struct IplBlockCcw {
-    uint64_t netboot_start_addr;
-    uint8_t  reserved0[77];
+    uint8_t  reserved0[85];
     uint8_t  ssid;
     uint16_t devno;
     uint8_t  vm_flags;
@@ -59,6 +58,15 @@ typedef struct IplBlockQemuScsi IplBlockQemuScsi;
 
 #define DIAG308_FLAGS_LP_VALID 0x80
 
+#define QIPL_ADDRESS  0xcc
+
+struct QemuIplParameters {
+    uint8_t  reserved1[4];
+    uint64_t netboot_start_addr;
+    uint8_t  reserved2[16];
+} QEMU_PACKED;
+typedef struct QemuIplParameters QemuIplParameters;
+
 union IplParameterBlock {
     struct {
         uint32_t len;
@@ -74,6 +82,7 @@ union IplParameterBlock {
             IplBlockFcp fcp;
             IplBlockQemuScsi scsi;
         };
+        QemuIplParameters qipl;
     } QEMU_PACKED;
     struct {
         uint8_t  reserved1[110];
diff --git a/pc-bios/s390-ccw/iplb.h b/pc-bios/s390-ccw/iplb.h
index 890aed9..1266884 100644
--- a/pc-bios/s390-ccw/iplb.h
+++ b/pc-bios/s390-ccw/iplb.h
@@ -13,8 +13,7 @@
 #define IPLB_H
 
 struct IplBlockCcw {
-    uint64_t netboot_start_addr;
-    uint8_t  reserved0[77];
+    uint8_t  reserved0[85];
     uint8_t  ssid;
     uint16_t devno;
     uint8_t  vm_flags;
@@ -73,6 +72,17 @@ typedef struct IplParameterBlock IplParameterBlock;
 
 extern IplParameterBlock iplb __attribute__((__aligned__(PAGE_SIZE)));
 
+#define QIPL_ADDRESS  0xcc
+
+struct QemuIplParameters {
+    uint8_t  reserved1[4];
+    uint64_t netboot_start_addr;
+    uint8_t  reserved2[16];
+} __attribute__ ((packed));
+typedef struct QemuIplParameters QemuIplParameters;
+
+extern QemuIplParameters qipl;
+
 #define S390_IPL_TYPE_FCP 0x00
 #define S390_IPL_TYPE_CCW 0x02
 #define S390_IPL_TYPE_QEMU_SCSI 0xff
diff --git a/pc-bios/s390-ccw/main.c b/pc-bios/s390-ccw/main.c
index e857ce4..e41b264 100644
--- a/pc-bios/s390-ccw/main.c
+++ b/pc-bios/s390-ccw/main.c
@@ -16,6 +16,7 @@ char stack[PAGE_SIZE * 8] __attribute__((__aligned__(PAGE_SIZE)));
 static SubChannelId blk_schid = { .one = 1 };
 IplParameterBlock iplb __attribute__((__aligned__(PAGE_SIZE)));
 static char loadparm[8] = { 0, 0, 0, 0, 0, 0, 0, 0 };
+QemuIplParameters qipl;
 
 /*
  * Priniciples of Operations (SA22-7832-09) chapter 17 requires that
@@ -81,6 +82,7 @@ static void virtio_setup(void)
     uint16_t dev_no;
     char ldp[] = "LOADPARM=[________]\n";
     VDev *vdev = virtio_get_device();
+    QemuIplParameters *early_qipl = (QemuIplParameters *)QIPL_ADDRESS;
 
     /*
      * We unconditionally enable mss support. In every sane configuration,
@@ -93,6 +95,8 @@ static void virtio_setup(void)
     memcpy(ldp + 10, loadparm, 8);
     sclp_print(ldp);
 
+    memcpy(&qipl, early_qipl, sizeof(QemuIplParameters));
+
     if (store_iplb(&iplb)) {
         switch (iplb.pbt) {
         case S390_IPL_TYPE_CCW:
@@ -127,7 +131,7 @@ static void virtio_setup(void)
 
     if (virtio_get_device_type() == VIRTIO_ID_NET) {
         sclp_print("Network boot device detected\n");
-        vdev->netboot_start_addr = iplb.ccw.netboot_start_addr;
+        vdev->netboot_start_addr = qipl.netboot_start_addr;
     } else {
         virtio_blk_setup_device(blk_schid);
 
-- 
2.7.4
