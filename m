Received: from eggs.gnu.org ([2001:4830:134:3::10]:56885)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <shorne@gmail.com>) id 1d651z-0001dC-Uj
	for qemu-devel@nongnu.org; Wed, 03 May 2017 20:54:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <shorne@gmail.com>) id 1d651z-00062i-47
	for qemu-devel@nongnu.org; Wed, 03 May 2017 20:54:08 -0400
Received: from mail-pg0-x243.google.com ([2607:f8b0:400e:c05::243]:36757)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <shorne@gmail.com>) id 1d651y-00062P-UQ
	for qemu-devel@nongnu.org; Wed, 03 May 2017 20:54:07 -0400
Received: by mail-pg0-x243.google.com with SMTP id v1so783211pgv.3
	for <qemu-devel@nongnu.org>; Wed, 03 May 2017 17:54:06 -0700 (PDT)
From: Stafford Horne <shorne@gmail.com>
Date: Thu,  4 May 2017 09:53:24 +0900
Message-Id: <acf57591c01cd0b1667e4f0ed2176d59cb5827aa.1493858877.git.shorne@gmail.com>
In-Reply-To: <cover.1493858877.git.shorne@gmail.com>
References: <cover.1493858877.git.shorne@gmail.com>
In-Reply-To: <cover.1493858877.git.shorne@gmail.com>
References: <cover.1493858877.git.shorne@gmail.com>
Subject: [Qemu-devel] [PULL v2 09/11] target/openrisc: Implement full
 vmstate serialization
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: QEMU Development <qemu-devel@nongnu.org>
Cc: Stefan Hajnoczi <stefanha@gmail.com>, Stafford Horne <shorne@gmail.com>

Previously serialization did not persist the tlb, timer, pic and other
key state items.  This meant snapshotting and restoring a running os
would crash. After adding these I am able to take snapshots of a
running linux os and restore at a later time.

I am currently not trying to maintain capatibility with older versions
as I do not believe this really worked before or anyone used it.

Signed-off-by: Stafford Horne <shorne@gmail.com>
---
 target/openrisc/machine.c | 73 +++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 71 insertions(+), 2 deletions(-)

diff --git a/target/openrisc/machine.c b/target/openrisc/machine.c
index 2bf71c3..a82be62 100644
--- a/target/openrisc/machine.c
+++ b/target/openrisc/machine.c
@@ -24,6 +24,63 @@
 #include "hw/boards.h"
 #include "migration/cpu.h"
 
+static int env_post_load(void *opaque, int version_id)
+{
+    CPUOpenRISCState *env = opaque;
+
+    /* Restore MMU handlers */
+    if (env->sr & SR_DME) {
+        env->tlb->cpu_openrisc_map_address_data =
+            &cpu_openrisc_get_phys_data;
+    } else {
+        env->tlb->cpu_openrisc_map_address_data =
+            &cpu_openrisc_get_phys_nommu;
+    }
+
+    if (env->sr & SR_IME) {
+        env->tlb->cpu_openrisc_map_address_code =
+            &cpu_openrisc_get_phys_code;
+    } else {
+        env->tlb->cpu_openrisc_map_address_code =
+            &cpu_openrisc_get_phys_nommu;
+    }
+
+
+    return 0;
+}
+
+static const VMStateDescription vmstate_tlb_entry = {
+    .name = "tlb_entry",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .minimum_version_id_old = 1,
+    .fields = (VMStateField[]) {
+        VMSTATE_UINTTL(mr, OpenRISCTLBEntry),
+        VMSTATE_UINTTL(tr, OpenRISCTLBEntry),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
+static const VMStateDescription vmstate_cpu_tlb = {
+    .name = "cpu_tlb",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .minimum_version_id_old = 1,
+    .fields = (VMStateField[]) {
+        VMSTATE_STRUCT_2DARRAY(itlb, CPUOpenRISCTLBContext,
+                             ITLB_WAYS, ITLB_SIZE, 0,
+                             vmstate_tlb_entry, OpenRISCTLBEntry),
+        VMSTATE_STRUCT_2DARRAY(dtlb, CPUOpenRISCTLBContext,
+                             DTLB_WAYS, DTLB_SIZE, 0,
+                             vmstate_tlb_entry, OpenRISCTLBEntry),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
+#define VMSTATE_CPU_TLB(_f, _s)                             \
+    VMSTATE_STRUCT_POINTER(_f, _s, vmstate_cpu_tlb, CPUOpenRISCTLBContext)
+
+
 static int get_sr(QEMUFile *f, void *opaque, size_t size, VMStateField *field)
 {
     CPUOpenRISCState *env = opaque;
@@ -47,8 +104,9 @@ static const VMStateInfo vmstate_sr = {
 
 static const VMStateDescription vmstate_env = {
     .name = "env",
-    .version_id = 5,
-    .minimum_version_id = 5,
+    .version_id = 6,
+    .minimum_version_id = 6,
+    .post_load = env_post_load,
     .fields = (VMStateField[]) {
         VMSTATE_UINTTL_2DARRAY(shadow_gpr, CPUOpenRISCState, 16, 32),
         VMSTATE_UINTTL(pc, CPUOpenRISCState),
@@ -79,9 +137,20 @@ static const VMStateDescription vmstate_env = {
         VMSTATE_UINT32(cpucfgr, CPUOpenRISCState),
         VMSTATE_UINT32(dmmucfgr, CPUOpenRISCState),
         VMSTATE_UINT32(immucfgr, CPUOpenRISCState),
+        VMSTATE_UINT32(evbar, CPUOpenRISCState),
         VMSTATE_UINT32(esr, CPUOpenRISCState),
         VMSTATE_UINT32(fpcsr, CPUOpenRISCState),
         VMSTATE_UINT64(mac, CPUOpenRISCState),
+
+        VMSTATE_CPU_TLB(tlb, CPUOpenRISCState),
+
+        VMSTATE_TIMER_PTR(timer, CPUOpenRISCState),
+        VMSTATE_UINT32(ttmr, CPUOpenRISCState),
+        VMSTATE_UINT32(ttcr, CPUOpenRISCState),
+
+        VMSTATE_UINT32(picmr, CPUOpenRISCState),
+        VMSTATE_UINT32(picsr, CPUOpenRISCState),
+
         VMSTATE_END_OF_LIST()
     }
 };
-- 
2.9.3
