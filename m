Received: from eggs.gnu.org ([2001:4830:134:3::10]:39355)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1d2x6K-0004Tj-Ll
	for qemu-devel@nongnu.org; Tue, 25 Apr 2017 05:49:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1d2x6F-0003r4-ON
	for qemu-devel@nongnu.org; Tue, 25 Apr 2017 05:49:40 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39724)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1d2x6F-0003qv-FT
	for qemu-devel@nongnu.org; Tue, 25 Apr 2017 05:49:35 -0400
From: Peter Xu <peterx@redhat.com>
Date: Tue, 25 Apr 2017 17:49:13 +0800
Message-Id: <1493113753-30025-1-git-send-email-peterx@redhat.com>
Subject: [Qemu-devel] [PATCH] pc: add 2.10 machine type
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Marcel Apfelbaum <marcel@redhat.com>, peterx@redhat.com, "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>

CC: "Michael S. Tsirkin" <mst@redhat.com>
CC: Paolo Bonzini <pbonzini@redhat.com>
CC: Richard Henderson <rth@twiddle.net>
CC: Eduardo Habkost <ehabkost@redhat.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 hw/i386/pc_piix.c    | 15 ++++++++++++---
 hw/i386/pc_q35.c     | 13 +++++++++++--
 include/hw/i386/pc.h |  3 +++
 3 files changed, 26 insertions(+), 5 deletions(-)

diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
index 9f102aa..8fb6553 100644
--- a/hw/i386/pc_piix.c
+++ b/hw/i386/pc_piix.c
@@ -437,21 +437,30 @@ static void pc_i440fx_machine_options(MachineClass *m)
     m->default_display = "std";
 }
 
-static void pc_i440fx_2_9_machine_options(MachineClass *m)
+static void pc_i440fx_2_10_machine_options(MachineClass *m)
 {
     pc_i440fx_machine_options(m);
     m->alias = "pc";
     m->is_default = 1;
 }
 
+DEFINE_I440FX_MACHINE(v2_10, "pc-i440fx-2.10", NULL,
+                      pc_i440fx_2_10_machine_options);
+
+static void pc_i440fx_2_9_machine_options(MachineClass *m)
+{
+    pc_i440fx_2_10_machine_options(m);
+    m->is_default = 0;
+    m->alias = NULL;
+    SET_MACHINE_COMPAT(m, PC_COMPAT_2_9);
+}
+
 DEFINE_I440FX_MACHINE(v2_9, "pc-i440fx-2.9", NULL,
                       pc_i440fx_2_9_machine_options);
 
 static void pc_i440fx_2_8_machine_options(MachineClass *m)
 {
     pc_i440fx_2_9_machine_options(m);
-    m->is_default = 0;
-    m->alias = NULL;
     SET_MACHINE_COMPAT(m, PC_COMPAT_2_8);
 }
 
diff --git a/hw/i386/pc_q35.c b/hw/i386/pc_q35.c
index dd792a8..f07ebec 100644
--- a/hw/i386/pc_q35.c
+++ b/hw/i386/pc_q35.c
@@ -301,19 +301,28 @@ static void pc_q35_machine_options(MachineClass *m)
     m->max_cpus = 288;
 }
 
-static void pc_q35_2_9_machine_options(MachineClass *m)
+static void pc_q35_2_10_machine_options(MachineClass *m)
 {
     pc_q35_machine_options(m);
     m->alias = "q35";
 }
 
+DEFINE_Q35_MACHINE(v2_10, "pc-q35-2.10", NULL,
+                   pc_q35_2_10_machine_options);
+
+static void pc_q35_2_9_machine_options(MachineClass *m)
+{
+    pc_q35_2_10_machine_options(m);
+    m->alias = NULL;
+    SET_MACHINE_COMPAT(m, PC_COMPAT_2_9);
+}
+
 DEFINE_Q35_MACHINE(v2_9, "pc-q35-2.9", NULL,
                    pc_q35_2_9_machine_options);
 
 static void pc_q35_2_8_machine_options(MachineClass *m)
 {
     pc_q35_2_9_machine_options(m);
-    m->alias = NULL;
     SET_MACHINE_COMPAT(m, PC_COMPAT_2_8);
 }
 
diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
index f278b3a..7546d01 100644
--- a/include/hw/i386/pc.h
+++ b/include/hw/i386/pc.h
@@ -373,6 +373,9 @@ int e820_add_entry(uint64_t, uint64_t, uint32_t);
 int e820_get_num_entries(void);
 bool e820_get_entry(int, uint32_t, uint64_t *, uint64_t *);
 
+#define PC_COMPAT_2_9 \
+    HW_COMPAT_2_9 \
+
 #define PC_COMPAT_2_8 \
     HW_COMPAT_2_8 \
     {\
-- 
2.7.4
