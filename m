Received: from eggs.gnu.org ([2001:4830:134:3::10]:42599)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <haozhong.zhang@intel.com>) id 1eR8jf-0007vT-Na
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 22:38:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <haozhong.zhang@intel.com>) id 1eR8jd-0004wg-3S
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 22:38:31 -0500
Received: from mga09.intel.com ([134.134.136.24]:24814)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <haozhong.zhang@intel.com>)
	id 1eR8jc-0004v3-RD
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 22:38:29 -0500
From: Haozhong Zhang <haozhong.zhang@intel.com>
Date: Tue, 19 Dec 2017 11:37:29 +0800
Message-Id: <20171219033730.12748-2-haozhong.zhang@intel.com>
In-Reply-To: <20171219033730.12748-1-haozhong.zhang@intel.com>
References: <20171219033730.12748-1-haozhong.zhang@intel.com>
Subject: [Qemu-devel] [PATCH v3 1/2] pc: add 2.12 machine types
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: mst@redhat.com, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>, Haozhong Zhang <haozhong.zhang@intel.com>

Signed-off-by: Haozhong Zhang <haozhong.zhang@intel.com>
---
 hw/i386/pc_piix.c    | 15 ++++++++++++---
 hw/i386/pc_q35.c     | 13 +++++++++++--
 include/hw/i386/pc.h |  3 +++
 3 files changed, 26 insertions(+), 5 deletions(-)

diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
index 5e47528993..f235ee12c2 100644
--- a/hw/i386/pc_piix.c
+++ b/hw/i386/pc_piix.c
@@ -430,21 +430,30 @@ static void pc_i440fx_machine_options(MachineClass *m)
     m->default_display = "std";
 }
 
-static void pc_i440fx_2_11_machine_options(MachineClass *m)
+static void pc_i440fx_2_12_machine_options(MachineClass *m)
 {
     pc_i440fx_machine_options(m);
     m->alias = "pc";
     m->is_default = 1;
 }
 
+DEFINE_I440FX_MACHINE(v2_12, "pc-i440fx-2.12", NULL,
+                      pc_i440fx_2_12_machine_options);
+
+static void pc_i440fx_2_11_machine_options(MachineClass *m)
+{
+    pc_i440fx_2_12_machine_options(m);
+    m->is_default = 0;
+    m->alias = NULL;
+    SET_MACHINE_COMPAT(m, PC_COMPAT_2_11);
+}
+
 DEFINE_I440FX_MACHINE(v2_11, "pc-i440fx-2.11", NULL,
                       pc_i440fx_2_11_machine_options);
 
 static void pc_i440fx_2_10_machine_options(MachineClass *m)
 {
     pc_i440fx_2_11_machine_options(m);
-    m->is_default = 0;
-    m->alias = NULL;
     SET_MACHINE_COMPAT(m, PC_COMPAT_2_10);
     m->auto_enable_numa_with_memhp = false;
 }
diff --git a/hw/i386/pc_q35.c b/hw/i386/pc_q35.c
index d6060043ac..5c6c608fcb 100644
--- a/hw/i386/pc_q35.c
+++ b/hw/i386/pc_q35.c
@@ -303,19 +303,28 @@ static void pc_q35_machine_options(MachineClass *m)
     m->max_cpus = 288;
 }
 
-static void pc_q35_2_11_machine_options(MachineClass *m)
+static void pc_q35_2_12_machine_options(MachineClass *m)
 {
     pc_q35_machine_options(m);
     m->alias = "q35";
 }
 
+DEFINE_Q35_MACHINE(v2_12, "pc-q35-2.12", NULL,
+                   pc_q35_2_12_machine_options);
+
+static void pc_q35_2_11_machine_options(MachineClass *m)
+{
+    pc_q35_2_12_machine_options(m);
+    m->alias = NULL;
+    SET_MACHINE_COMPAT(m, PC_COMPAT_2_11);
+}
+
 DEFINE_Q35_MACHINE(v2_11, "pc-q35-2.11", NULL,
                    pc_q35_2_11_machine_options);
 
 static void pc_q35_2_10_machine_options(MachineClass *m)
 {
     pc_q35_2_11_machine_options(m);
-    m->alias = NULL;
     SET_MACHINE_COMPAT(m, PC_COMPAT_2_10);
     m->numa_auto_assign_ram = numa_legacy_auto_assign_ram;
     m->auto_enable_numa_with_memhp = false;
diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
index 6f77eb0665..83d825e896 100644
--- a/include/hw/i386/pc.h
+++ b/include/hw/i386/pc.h
@@ -321,6 +321,9 @@ int e820_add_entry(uint64_t, uint64_t, uint32_t);
 int e820_get_num_entries(void);
 bool e820_get_entry(int, uint32_t, uint64_t *, uint64_t *);
 
+#define PC_COMPAT_2_11 \
+    HW_COMPAT_2_11 \
+
 #define PC_COMPAT_2_10 \
     HW_COMPAT_2_10 \
     {\
-- 
2.14.1
