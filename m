Received: from eggs.gnu.org ([2001:4830:134:3::10]:47936)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1cRk39-0000vz-7K
	for qemu-devel@nongnu.org; Thu, 12 Jan 2017 13:24:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1cRk37-0002L7-Uv
	for qemu-devel@nongnu.org; Thu, 12 Jan 2017 13:24:35 -0500
Received: from mx1.redhat.com ([209.132.183.28]:39534)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lersek@redhat.com>) id 1cRk37-0002Kp-MW
	for qemu-devel@nongnu.org; Thu, 12 Jan 2017 13:24:33 -0500
From: Laszlo Ersek <lersek@redhat.com>
Date: Thu, 12 Jan 2017 19:24:16 +0100
Message-Id: <20170112182417.9548-4-lersek@redhat.com>
In-Reply-To: <20170112182417.9548-1-lersek@redhat.com>
References: <20170112182417.9548-1-lersek@redhat.com>
Subject: [Qemu-devel] [PATCH v6 wave 1 3/4] pc: Add 2.9 machine-types
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu devel list <qemu-devel@nongnu.org>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Gabriel Somlo <somlo@cmu.edu>

From: Eduardo Habkost <ehabkost@redhat.com>

Cc: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Laszlo Ersek <lersek@redhat.com>
Cc: Igor Mammedov <imammedo@redhat.com>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
Reviewed-by: Laszlo Ersek <lersek@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Acked-by: Gabriel Somlo <somlo@cmu.edu>
Tested-by: Gabriel Somlo <somlo@cmu.edu>
Cc: Gabriel Somlo <somlo@cmu.edu>
Signed-off-by: Laszlo Ersek <lersek@redhat.com>
---

Notes:
    v6:
    - no changes, pick up Gabriel's A-b and T-b
    - append an explicit Cc: tag for Gabriel (missed him last time), and
      then an S-o-b for myself at the bottom
    
    v5:
    - Include this patch from
      <http://lists.nongnu.org/archive/html/qemu-devel/2017-01/msg01020.html>
      verbatim, as a dependency, with the R-b tags already posted, replacing
      v4's "hw/i386/pc: introduce 2.9 machine types with 0x20 fw_cfg file
      slots".

 include/hw/i386/pc.h |  2 ++
 hw/i386/pc_piix.c    | 15 ++++++++++++---
 hw/i386/pc_q35.c     | 13 +++++++++++--
 3 files changed, 25 insertions(+), 5 deletions(-)

diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
index b22e699c46cd..230e9e70c504 100644
--- a/include/hw/i386/pc.h
+++ b/include/hw/i386/pc.h
@@ -375,6 +375,8 @@ int e820_get_num_entries(void);
 bool e820_get_entry(int, uint32_t, uint64_t *, uint64_t *);
 
 #define PC_COMPAT_2_8 \
+    HW_COMPAT_2_8 \
+
 
 #define PC_COMPAT_2_7 \
     HW_COMPAT_2_7 \
diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
index 5e1adbe53c94..9f102aa38875 100644
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
index d042fe0843c6..dd792a8547b3 100644
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
2.9.3
