Received: from eggs.gnu.org ([2001:4830:134:3::10]:53912)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1cLxJZ-00050E-EC
	for qemu-devel@nongnu.org; Tue, 27 Dec 2016 14:21:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1cLxJY-0006mN-Kr
	for qemu-devel@nongnu.org; Tue, 27 Dec 2016 14:21:37 -0500
Received: from mx1.redhat.com ([209.132.183.28]:44920)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1cLxJY-0006mE-Ck
	for qemu-devel@nongnu.org; Tue, 27 Dec 2016 14:21:36 -0500
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Tue, 27 Dec 2016 17:21:19 -0200
Message-Id: <1482866480-26208-4-git-send-email-ehabkost@redhat.com>
In-Reply-To: <1482866480-26208-1-git-send-email-ehabkost@redhat.com>
References: <1482866480-26208-1-git-send-email-ehabkost@redhat.com>
Subject: [Qemu-devel] [PATCH 3/4] pc: Add 2.9 machine-types
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Marcelo Tosatti <mtosatti@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, Haozhong Zhang <haozhong.zhang@intel.com>, "Michael S. Tsirkin" <mst@redhat.com>, Laszlo Ersek <lersek@redhat.com>, Igor Mammedov <imammedo@redhat.com>

Cc: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Laszlo Ersek <lersek@redhat.com>
Cc: Igor Mammedov <imammedo@redhat.com>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 include/hw/i386/pc.h |  1 +
 hw/i386/pc_piix.c    | 15 ++++++++++++---
 hw/i386/pc_q35.c     | 13 +++++++++++--
 3 files changed, 24 insertions(+), 5 deletions(-)

diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
index b22e699..ceeacca 100644
--- a/include/hw/i386/pc.h
+++ b/include/hw/i386/pc.h
@@ -375,6 +375,7 @@ int e820_get_num_entries(void);
 bool e820_get_entry(int, uint32_t, uint64_t *, uint64_t *);
 
 #define PC_COMPAT_2_8 \
+    HW_COMPAT_2_8
 
 #define PC_COMPAT_2_7 \
     HW_COMPAT_2_7 \
diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
index 5e1adbe..9f102aa 100644
--- a/hw/i386/pc_piix.c
+++ b/hw/i386/pc_piix.c
@@ -437,13 +437,24 @@ static void pc_i440fx_machine_options(MachineClass *m)
     m->default_display = "std";
 }
 
-static void pc_i440fx_2_8_machine_options(MachineClass *m)
+static void pc_i440fx_2_9_machine_options(MachineClass *m)
 {
     pc_i440fx_machine_options(m);
     m->alias = "pc";
     m->is_default = 1;
 }
 
+DEFINE_I440FX_MACHINE(v2_9, "pc-i440fx-2.9", NULL,
+                      pc_i440fx_2_9_machine_options);
+
+static void pc_i440fx_2_8_machine_options(MachineClass *m)
+{
+    pc_i440fx_2_9_machine_options(m);
+    m->is_default = 0;
+    m->alias = NULL;
+    SET_MACHINE_COMPAT(m, PC_COMPAT_2_8);
+}
+
 DEFINE_I440FX_MACHINE(v2_8, "pc-i440fx-2.8", NULL,
                       pc_i440fx_2_8_machine_options);
 
@@ -451,8 +462,6 @@ DEFINE_I440FX_MACHINE(v2_8, "pc-i440fx-2.8", NULL,
 static void pc_i440fx_2_7_machine_options(MachineClass *m)
 {
     pc_i440fx_2_8_machine_options(m);
-    m->is_default = 0;
-    m->alias = NULL;
     SET_MACHINE_COMPAT(m, PC_COMPAT_2_7);
 }
 
diff --git a/hw/i386/pc_q35.c b/hw/i386/pc_q35.c
index d042fe0..dd792a8 100644
--- a/hw/i386/pc_q35.c
+++ b/hw/i386/pc_q35.c
@@ -301,19 +301,28 @@ static void pc_q35_machine_options(MachineClass *m)
     m->max_cpus = 288;
 }
 
-static void pc_q35_2_8_machine_options(MachineClass *m)
+static void pc_q35_2_9_machine_options(MachineClass *m)
 {
     pc_q35_machine_options(m);
     m->alias = "q35";
 }
 
+DEFINE_Q35_MACHINE(v2_9, "pc-q35-2.9", NULL,
+                   pc_q35_2_9_machine_options);
+
+static void pc_q35_2_8_machine_options(MachineClass *m)
+{
+    pc_q35_2_9_machine_options(m);
+    m->alias = NULL;
+    SET_MACHINE_COMPAT(m, PC_COMPAT_2_8);
+}
+
 DEFINE_Q35_MACHINE(v2_8, "pc-q35-2.8", NULL,
                    pc_q35_2_8_machine_options);
 
 static void pc_q35_2_7_machine_options(MachineClass *m)
 {
     pc_q35_2_8_machine_options(m);
-    m->alias = NULL;
     m->max_cpus = 255;
     SET_MACHINE_COMPAT(m, PC_COMPAT_2_7);
 }
-- 
2.7.4
