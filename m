Received: from eggs.gnu.org ([2001:4830:134:3::10]:58438)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Babu.Moger@amd.com>) id 1fIGYE-0006o4-Qu
	for qemu-devel@nongnu.org; Mon, 14 May 2018 12:42:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <Babu.Moger@amd.com>) id 1fIGYB-0005fG-VQ
	for qemu-devel@nongnu.org; Mon, 14 May 2018 12:42:18 -0400
Received: from mail-cys01nam02on0049.outbound.protection.outlook.com
	([104.47.37.49]:26428
	helo=NAM02-CY1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <Babu.Moger@amd.com>) id 1fIGYB-0005eV-PG
	for qemu-devel@nongnu.org; Mon, 14 May 2018 12:42:15 -0400
From: Babu Moger <babu.moger@amd.com>
Date: Mon, 14 May 2018 11:41:50 -0500
Message-Id: <20180514164156.27034-2-babu.moger@amd.com>
In-Reply-To: <20180514164156.27034-1-babu.moger@amd.com>
References: <20180514164156.27034-1-babu.moger@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v9 1/7] pc: add 2.13 machine types
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: mst@redhat.com, marcel.apfelbaum@gmail.com, pbonzini@redhat.com, rth@twiddle.net, ehabkost@redhat.com, mtosatti@redhat.com
Cc: qemu-devel@nongnu.org, kvm@vger.kernel.org, geoff@hostfission.com, kash@tripleback.net, babu.moger@amd.com

Add pc-q35-2.13 and pc-i440fx-2.13 machine types

Signed-off-by: Babu Moger <babu.moger@amd.com>
---
 hw/i386/pc_piix.c    | 15 ++++++++++++---
 hw/i386/pc_q35.c     | 13 +++++++++++--
 include/hw/i386/pc.h |  3 +++
 3 files changed, 26 insertions(+), 5 deletions(-)

diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
index 729a0508aa..e36c7bbb40 100644
--- a/hw/i386/pc_piix.c
+++ b/hw/i386/pc_piix.c
@@ -425,21 +425,30 @@ static void pc_i440fx_machine_options(MachineClass *m)
     m->default_display = "std";
 }
 
-static void pc_i440fx_2_12_machine_options(MachineClass *m)
+static void pc_i440fx_2_13_machine_options(MachineClass *m)
 {
     pc_i440fx_machine_options(m);
     m->alias = "pc";
     m->is_default = 1;
 }
 
+DEFINE_I440FX_MACHINE(v2_13, "pc-i440fx-2.13", NULL,
+                      pc_i440fx_2_13_machine_options);
+
+static void pc_i440fx_2_12_machine_options(MachineClass *m)
+{
+    pc_i440fx_2_13_machine_options(m);
+    m->is_default = 0;
+    m->alias = NULL;
+    SET_MACHINE_COMPAT(m, PC_COMPAT_2_12);
+}
+
 DEFINE_I440FX_MACHINE(v2_12, "pc-i440fx-2.12", NULL,
                       pc_i440fx_2_12_machine_options);
 
 static void pc_i440fx_2_11_machine_options(MachineClass *m)
 {
     pc_i440fx_2_12_machine_options(m);
-    m->is_default = 0;
-    m->alias = NULL;
     SET_MACHINE_COMPAT(m, PC_COMPAT_2_11);
 }
 
diff --git a/hw/i386/pc_q35.c b/hw/i386/pc_q35.c
index 9ae916327e..2372457c6a 100644
--- a/hw/i386/pc_q35.c
+++ b/hw/i386/pc_q35.c
@@ -308,12 +308,22 @@ static void pc_q35_machine_options(MachineClass *m)
     m->max_cpus = 288;
 }
 
-static void pc_q35_2_12_machine_options(MachineClass *m)
+static void pc_q35_2_13_machine_options(MachineClass *m)
 {
     pc_q35_machine_options(m);
     m->alias = "q35";
 }
 
+DEFINE_Q35_MACHINE(v2_13, "pc-q35-2.13", NULL,
+                    pc_q35_2_13_machine_options);
+
+static void pc_q35_2_12_machine_options(MachineClass *m)
+{
+    pc_q35_2_13_machine_options(m);
+    m->alias = NULL;
+    SET_MACHINE_COMPAT(m, PC_COMPAT_2_12);
+}
+
 DEFINE_Q35_MACHINE(v2_12, "pc-q35-2.12", NULL,
                    pc_q35_2_12_machine_options);
 
@@ -323,7 +333,6 @@ static void pc_q35_2_11_machine_options(MachineClass *m)
 
     pc_q35_2_12_machine_options(m);
     pcmc->default_nic_model = "e1000";
-    m->alias = NULL;
     SET_MACHINE_COMPAT(m, PC_COMPAT_2_11);
 }
 
diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
index 2e834e6ded..69fced9aea 100644
--- a/include/hw/i386/pc.h
+++ b/include/hw/i386/pc.h
@@ -304,6 +304,9 @@ int e820_add_entry(uint64_t, uint64_t, uint32_t);
 int e820_get_num_entries(void);
 bool e820_get_entry(int, uint32_t, uint64_t *, uint64_t *);
 
+#define PC_COMPAT_2_12 \
+    HW_COMPAT_2_12 \
+
 #define PC_COMPAT_2_11 \
     HW_COMPAT_2_11 \
     {\
-- 
2.17.0
