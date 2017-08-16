Received: from eggs.gnu.org ([2001:4830:134:3::10]:59540)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <tianyu.lan@intel.com>) id 1dhrZe-0005Hq-5k
	for qemu-devel@nongnu.org; Wed, 16 Aug 2017 02:13:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <tianyu.lan@intel.com>) id 1dhrZZ-00086v-D6
	for qemu-devel@nongnu.org; Wed, 16 Aug 2017 02:13:02 -0400
Received: from mga06.intel.com ([134.134.136.31]:15115)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <tianyu.lan@intel.com>)
	id 1dhrZZ-00086K-4d
	for qemu-devel@nongnu.org; Wed, 16 Aug 2017 02:12:57 -0400
From: Lan Tianyu <tianyu.lan@intel.com>
Date: Tue, 15 Aug 2017 20:06:18 -0400
Message-Id: <1502841979-6233-1-git-send-email-tianyu.lan@intel.com>
Subject: [Qemu-devel] [PATCH v3 1/2] pc: add 2.11 machine type
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Lan Tianyu <tianyu.lan@intel.com>, mst@redhat.com, pbonzini@redhat.com, rth@twiddle.net, ehabkost@redhat.com, berrange@redhat.com, rkrcmar@redhat.com

Signed-off-by: Lan Tianyu <tianyu.lan@intel.com>
---
 hw/i386/pc_piix.c    | 14 +++++++++++---
 hw/i386/pc_q35.c     | 14 +++++++++++---
 include/hw/compat.h  |  3 +++
 include/hw/i386/pc.h |  3 +++
 4 files changed, 28 insertions(+), 6 deletions(-)

diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
index 11b4336..e99ec8c 100644
--- a/hw/i386/pc_piix.c
+++ b/hw/i386/pc_piix.c
@@ -436,11 +436,21 @@ static void pc_i440fx_machine_options(MachineClass *m)
     m->default_display = "std";
 }
 
-static void pc_i440fx_2_10_machine_options(MachineClass *m)
+static void pc_i440fx_2_11_machine_options(MachineClass *m)
 {
     pc_i440fx_machine_options(m);
     m->alias = "pc";
     m->is_default = 1;
+}
+
+DEFINE_I440FX_MACHINE(v2_11, "pc-i440fx-2.11", NULL,
+                      pc_i440fx_2_11_machine_options);
+
+static void pc_i440fx_2_10_machine_options(MachineClass *m)
+{
+    pc_i440fx_machine_options(m);
+    m->is_default = 0;
+    m->alias = NULL;
     m->numa_auto_assign_ram = numa_legacy_auto_assign_ram;
 }
 
@@ -450,8 +460,6 @@ DEFINE_I440FX_MACHINE(v2_10, "pc-i440fx-2.10", NULL,
 static void pc_i440fx_2_9_machine_options(MachineClass *m)
 {
     pc_i440fx_2_10_machine_options(m);
-    m->is_default = 0;
-    m->alias = NULL;
     SET_MACHINE_COMPAT(m, PC_COMPAT_2_9);
 }
 
diff --git a/hw/i386/pc_q35.c b/hw/i386/pc_q35.c
index 169a214..b469d05 100644
--- a/hw/i386/pc_q35.c
+++ b/hw/i386/pc_q35.c
@@ -302,11 +302,20 @@ static void pc_q35_machine_options(MachineClass *m)
     m->max_cpus = 288;
 }
 
+static void pc_q35_2_11_machine_options(MachineClass *m)
+{
+     pc_q35_machine_options(m);
+     m->alias = "q35";
+}
+DEFINE_Q35_MACHINE(v2_11, "pc-q35-2.11", NULL,
+                   pc_q35_2_11_machine_options);
+
 static void pc_q35_2_10_machine_options(MachineClass *m)
 {
-    pc_q35_machine_options(m);
-    m->alias = "q35";
+    pc_q35_2_11_machine_options(m);
+    m->alias = NULL;
     m->numa_auto_assign_ram = numa_legacy_auto_assign_ram;
+    SET_MACHINE_COMPAT(m, PC_COMPAT_2_10);
 }
 
 DEFINE_Q35_MACHINE(v2_10, "pc-q35-2.10", NULL,
@@ -315,7 +324,6 @@ DEFINE_Q35_MACHINE(v2_10, "pc-q35-2.10", NULL,
 static void pc_q35_2_9_machine_options(MachineClass *m)
 {
     pc_q35_2_10_machine_options(m);
-    m->alias = NULL;
     SET_MACHINE_COMPAT(m, PC_COMPAT_2_9);
 }
 
diff --git a/include/hw/compat.h b/include/hw/compat.h
index 08f3600..3e101f8 100644
--- a/include/hw/compat.h
+++ b/include/hw/compat.h
@@ -1,6 +1,9 @@
 #ifndef HW_COMPAT_H
 #define HW_COMPAT_H
 
+#define HW_COMPAT_2_10 \
+    /* empty */
+
 #define HW_COMPAT_2_9 \
     {\
         .driver   = "pci-bridge",\
diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
index d80859b..8226904 100644
--- a/include/hw/i386/pc.h
+++ b/include/hw/i386/pc.h
@@ -369,6 +369,9 @@ int e820_add_entry(uint64_t, uint64_t, uint32_t);
 int e820_get_num_entries(void);
 bool e820_get_entry(int, uint32_t, uint64_t *, uint64_t *);
 
+#define PC_COMPAT_2_10 \
+    HW_COMPAT_2_10 \
+
 #define PC_COMPAT_2_9 \
     HW_COMPAT_2_9 \
     {\
-- 
1.8.3.1
