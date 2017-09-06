Received: from eggs.gnu.org ([2001:4830:134:3::10]:60272)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcel@redhat.com>) id 1dpbId-0008O9-7y
	for qemu-devel@nongnu.org; Wed, 06 Sep 2017 10:27:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcel@redhat.com>) id 1dpbIV-0004k7-IB
	for qemu-devel@nongnu.org; Wed, 06 Sep 2017 10:27:27 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60368)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcel@redhat.com>) id 1dpbIV-0004js-A3
	for qemu-devel@nongnu.org; Wed, 06 Sep 2017 10:27:19 -0400
From: Marcel Apfelbaum <marcel@redhat.com>
Date: Wed,  6 Sep 2017 17:26:57 +0300
Message-Id: <20170906142658.58298-2-marcel@redhat.com>
In-Reply-To: <20170906142658.58298-1-marcel@redhat.com>
References: <20170906142658.58298-1-marcel@redhat.com>
Subject: [Qemu-devel]  [PATCH 1/2] pc: add 2.11 machine types
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: marcel@redhat.com, mst@redhat.com, pbonzini@redhat.com, rth@twiddle.net, ehabkost@redhat.com

Signed-off-by: Marcel Apfelbaum <marcel@redhat.com>
---
 hw/i386/pc_piix.c    | 15 ++++++++++++---
 hw/i386/pc_q35.c     | 13 +++++++++++--
 include/hw/i386/pc.h |  3 +++
 3 files changed, 26 insertions(+), 5 deletions(-)

diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
index 46dfd2c954..b03cc047c3 100644
--- a/hw/i386/pc_piix.c
+++ b/hw/i386/pc_piix.c
@@ -436,21 +436,30 @@ static void pc_i440fx_machine_options(MachineClass *m)
     m->default_display = "std";
 }
 
-static void pc_i440fx_2_10_machine_options(MachineClass *m)
+static void pc_i440fx_2_11_machine_options(MachineClass *m)
 {
     pc_i440fx_machine_options(m);
     m->alias = "pc";
     m->is_default = 1;
 }
 
+DEFINE_I440FX_MACHINE(v2_11, "pc-i440fx-2.11", NULL,
+                      pc_i440fx_2_11_machine_options);
+
+static void pc_i440fx_2_10_machine_options(MachineClass *m)
+{
+    pc_i440fx_2_11_machine_options(m);
+    m->is_default = 0;
+    m->alias = NULL;
+    SET_MACHINE_COMPAT(m, PC_COMPAT_2_10);
+}
+
 DEFINE_I440FX_MACHINE(v2_10, "pc-i440fx-2.10", NULL,
                       pc_i440fx_2_10_machine_options);
 
 static void pc_i440fx_2_9_machine_options(MachineClass *m)
 {
     pc_i440fx_2_10_machine_options(m);
-    m->is_default = 0;
-    m->alias = NULL;
     SET_MACHINE_COMPAT(m, PC_COMPAT_2_9);
     m->numa_auto_assign_ram = numa_legacy_auto_assign_ram;
 }
diff --git a/hw/i386/pc_q35.c b/hw/i386/pc_q35.c
index 169a214d50..c1cba584d1 100644
--- a/hw/i386/pc_q35.c
+++ b/hw/i386/pc_q35.c
@@ -302,10 +302,20 @@ static void pc_q35_machine_options(MachineClass *m)
     m->max_cpus = 288;
 }
 
-static void pc_q35_2_10_machine_options(MachineClass *m)
+static void pc_q35_2_11_machine_options(MachineClass *m)
 {
     pc_q35_machine_options(m);
     m->alias = "q35";
+}
+
+DEFINE_Q35_MACHINE(v2_11, "pc-q35-2.11", NULL,
+                   pc_q35_2_11_machine_options);
+
+static void pc_q35_2_10_machine_options(MachineClass *m)
+{
+    pc_q35_2_11_machine_options(m);
+    m->alias = NULL;
+    SET_MACHINE_COMPAT(m, PC_COMPAT_2_10);
     m->numa_auto_assign_ram = numa_legacy_auto_assign_ram;
 }
 
@@ -315,7 +325,6 @@ DEFINE_Q35_MACHINE(v2_10, "pc-q35-2.10", NULL,
 static void pc_q35_2_9_machine_options(MachineClass *m)
 {
     pc_q35_2_10_machine_options(m);
-    m->alias = NULL;
     SET_MACHINE_COMPAT(m, PC_COMPAT_2_9);
 }
 
diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
index d80859bfad..8226904524 100644
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
2.13.5
