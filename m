Received: from eggs.gnu.org ([2001:4830:134:3::10]:39181)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gJykL-0005QJ-Vj
	for qemu-devel@nongnu.org; Tue, 06 Nov 2018 05:38:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gJyWQ-0005HC-KE
	for qemu-devel@nongnu.org; Tue, 06 Nov 2018 05:23:48 -0500
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Tue,  6 Nov 2018 11:23:32 +0100
Message-Id: <20181106102335.20027-4-kraxel@redhat.com>
In-Reply-To: <20181106102335.20027-1-kraxel@redhat.com>
References: <20181106102335.20027-1-kraxel@redhat.com>
Subject: [Qemu-devel] [PATCH v2 3/6] Use QemuSupportState for machine types.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Alexander Graf <agraf@suse.de>, Eduardo Habkost <ehabkost@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, "Michael S. Tsirkin" <mst@redhat.com>, David Gibson <david@gibson.dropbear.id.au>, Eric Blake <eblake@redhat.com>, qemu-ppc@nongnu.org, Richard Henderson <rth@twiddle.net>, =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>, Markus Armbruster <armbru@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>

Switch over the current deprecation_reason users to use
the QemuSupportState field in ObjectClass instead.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 include/hw/boards.h | 3 ---
 hw/i386/pc_piix.c   | 5 ++++-
 hw/ppc/prep.c       | 5 ++++-
 vl.c                | 7 ++++---
 4 files changed, 12 insertions(+), 8 deletions(-)

diff --git a/include/hw/boards.h b/include/hw/boards.h
index f82f28468b..b7bb181fc8 100644
--- a/include/hw/boards.h
+++ b/include/hw/boards.h
@@ -106,8 +106,6 @@ typedef struct {
 
 /**
  * MachineClass:
- * @deprecation_reason: If set, the machine is marked as deprecated. The
- *    string should provide some clear information about what to use instead.
  * @max_cpus: maximum number of CPUs supported. Default: 1
  * @min_cpus: minimum number of CPUs supported. Default: 1
  * @default_cpus: number of CPUs instantiated if none are specified. Default: 1
@@ -167,7 +165,6 @@ struct MachineClass {
     char *name;
     const char *alias;
     const char *desc;
-    const char *deprecation_reason;
 
     void (*init)(MachineState *state);
     void (*reset)(void);
diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
index dc09466b3e..407f4503a3 100644
--- a/hw/i386/pc_piix.c
+++ b/hw/i386/pc_piix.c
@@ -955,9 +955,12 @@ DEFINE_I440FX_MACHINE(v0_12, "pc-0.12", pc_compat_0_13,
 
 static void pc_i440fx_0_11_machine_options(MachineClass *m)
 {
+    ObjectClass *oc = OBJECT_CLASS(m);
+
     pc_i440fx_0_12_machine_options(m);
     m->hw_version = "0.11";
-    m->deprecation_reason = "use a newer machine type instead";
+    oc->supported.state = SUPPORT_STATE_DEPRECATED;
+    oc->supported.help = "use a newer machine type instead";
     SET_MACHINE_COMPAT(m, PC_COMPAT_0_11);
 }
 
diff --git a/hw/ppc/prep.c b/hw/ppc/prep.c
index 2afb7f437e..260700847b 100644
--- a/hw/ppc/prep.c
+++ b/hw/ppc/prep.c
@@ -588,7 +588,10 @@ static void ppc_prep_init(MachineState *machine)
 
 static void prep_machine_init(MachineClass *mc)
 {
-    mc->deprecation_reason = "use 40p machine type instead";
+    ObjectClass *oc = OBJECT_CLASS(mc);
+
+    oc->supported.state = SUPPORT_STATE_DEPRECATED;
+    oc->supported.help = "use 40p machine type instead";
     mc->desc = "PowerPC PREP platform";
     mc->init = ppc_prep_init;
     mc->block_default_type = IF_IDE;
diff --git a/vl.c b/vl.c
index 1fcacc5caa..ba81fefb66 100644
--- a/vl.c
+++ b/vl.c
@@ -2573,7 +2573,7 @@ static gint machine_class_cmp(gconstpointer a, gconstpointer b)
             }
             printf("%-20s %s%s%s\n", mc->name, mc->desc,
                    mc->is_default ? " (default)" : "",
-                   mc->deprecation_reason ? " (deprecated)" : "");
+                   qemu_is_deprecated(OBJECT_CLASS(mc)) ? " (deprecated)" : "");
         }
     }
 
@@ -4290,9 +4290,10 @@ int main(int argc, char **argv, char **envp)
 
     configure_accelerator(current_machine);
 
-    if (!qtest_enabled() && machine_class->deprecation_reason) {
+    if (!qtest_enabled() && qemu_is_deprecated(OBJECT_CLASS(machine_class))) {
         error_report("Machine type '%s' is deprecated: %s",
-                     machine_class->name, machine_class->deprecation_reason);
+                     machine_class->name,
+                     OBJECT_CLASS(machine_class)->supported.help);
     }
 
     /*
-- 
2.9.3
