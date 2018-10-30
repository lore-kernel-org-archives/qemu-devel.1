Received: from eggs.gnu.org ([2001:4830:134:3::10]:53753)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gHRyE-0000ys-3f
	for qemu-devel@nongnu.org; Tue, 30 Oct 2018 07:14:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gHRyB-0008A2-BE
	for qemu-devel@nongnu.org; Tue, 30 Oct 2018 07:14:01 -0400
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Tue, 30 Oct 2018 12:13:48 +0100
Message-Id: <20181030111348.14713-5-kraxel@redhat.com>
In-Reply-To: <20181030111348.14713-1-kraxel@redhat.com>
References: <20181030111348.14713-1-kraxel@redhat.com>
Subject: [Qemu-devel] [PATCH 4/4] switch machine types to QemuSupportState
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Alexander Graf <agraf@suse.de>, Eduardo Habkost <ehabkost@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, "Michael S. Tsirkin" <mst@redhat.com>, David Gibson <david@gibson.dropbear.id.au>, Eric Blake <eblake@redhat.com>, qemu-ppc@nongnu.org, Richard Henderson <rth@twiddle.net>, Markus Armbruster <armbru@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>

So we can indicate machine type support state.
For starters switch over the current deprecation_reason users.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 include/hw/boards.h | 5 ++---
 hw/i386/pc_piix.c   | 3 ++-
 hw/ppc/prep.c       | 3 ++-
 vl.c                | 6 +++---
 4 files changed, 9 insertions(+), 8 deletions(-)

diff --git a/include/hw/boards.h b/include/hw/boards.h
index f82f28468b..25e5d8b292 100644
--- a/include/hw/boards.h
+++ b/include/hw/boards.h
@@ -106,8 +106,7 @@ typedef struct {
 
 /**
  * MachineClass:
- * @deprecation_reason: If set, the machine is marked as deprecated. The
- *    string should provide some clear information about what to use instead.
+ * @supported: support state of the machine type.
  * @max_cpus: maximum number of CPUs supported. Default: 1
  * @min_cpus: minimum number of CPUs supported. Default: 1
  * @default_cpus: number of CPUs instantiated if none are specified. Default: 1
@@ -167,7 +166,7 @@ struct MachineClass {
     char *name;
     const char *alias;
     const char *desc;
-    const char *deprecation_reason;
+    QemuSupportState supported;
 
     void (*init)(MachineState *state);
     void (*reset)(void);
diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
index dc09466b3e..bc238cc465 100644
--- a/hw/i386/pc_piix.c
+++ b/hw/i386/pc_piix.c
@@ -957,7 +957,8 @@ static void pc_i440fx_0_11_machine_options(MachineClass *m)
 {
     pc_i440fx_0_12_machine_options(m);
     m->hw_version = "0.11";
-    m->deprecation_reason = "use a newer machine type instead";
+    m->supported.state = SUPPORT_STATE_DEPRECATED;
+    m->supported.reason = "use a newer machine type instead";
     SET_MACHINE_COMPAT(m, PC_COMPAT_0_11);
 }
 
diff --git a/hw/ppc/prep.c b/hw/ppc/prep.c
index 2afb7f437e..ab1c2bcc7d 100644
--- a/hw/ppc/prep.c
+++ b/hw/ppc/prep.c
@@ -588,7 +588,8 @@ static void ppc_prep_init(MachineState *machine)
 
 static void prep_machine_init(MachineClass *mc)
 {
-    mc->deprecation_reason = "use 40p machine type instead";
+    mc->supported.state = SUPPORT_STATE_DEPRECATED;
+    mc->supported.reason = "use 40p machine type instead";
     mc->desc = "PowerPC PREP platform";
     mc->init = ppc_prep_init;
     mc->block_default_type = IF_IDE;
diff --git a/vl.c b/vl.c
index 1fcacc5caa..83506de0cc 100644
--- a/vl.c
+++ b/vl.c
@@ -2573,7 +2573,7 @@ static gint machine_class_cmp(gconstpointer a, gconstpointer b)
             }
             printf("%-20s %s%s%s\n", mc->name, mc->desc,
                    mc->is_default ? " (default)" : "",
-                   mc->deprecation_reason ? " (deprecated)" : "");
+                   qemu_is_deprecated(&mc->supported) ? " (deprecated)" : "");
         }
     }
 
@@ -4290,9 +4290,9 @@ int main(int argc, char **argv, char **envp)
 
     configure_accelerator(current_machine);
 
-    if (!qtest_enabled() && machine_class->deprecation_reason) {
+    if (!qtest_enabled() && qemu_is_deprecated(&machine_class->supported)) {
         error_report("Machine type '%s' is deprecated: %s",
-                     machine_class->name, machine_class->deprecation_reason);
+                     machine_class->name, machine_class->supported.reason);
     }
 
     /*
-- 
2.9.3
