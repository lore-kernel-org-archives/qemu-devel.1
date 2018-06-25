Received: from eggs.gnu.org ([2001:4830:134:3::10]:57611)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fXaAn-0006jr-GQ
	for qemu-devel@nongnu.org; Mon, 25 Jun 2018 18:41:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fXaAm-0000iY-9b
	for qemu-devel@nongnu.org; Mon, 25 Jun 2018 18:41:25 -0400
Received: from mx1.redhat.com ([209.132.183.28]:32732)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1fXaAm-0000gg-1U
	for qemu-devel@nongnu.org; Mon, 25 Jun 2018 18:41:24 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Mon, 25 Jun 2018 19:41:10 -0300
Message-Id: <20180625224110.5147-3-ehabkost@redhat.com>
In-Reply-To: <20180625224110.5147-1-ehabkost@redhat.com>
References: <20180625224110.5147-1-ehabkost@redhat.com>
Subject: [Qemu-devel] [PULL 2/2] hw/i386: Deprecate the machine types
 pc-0.10 and pc-0.11
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, Markus Armbruster <armbru@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Thomas Huth <thuth@redhat.com>

From: Thomas Huth <thuth@redhat.com>

The oldest machine type which is still used in a still maintained distro
is a pc-0.12 based machine type in RHEL6, so everything that is older
than pc-0.12 should not be used anymore. Thus let's deprecate pc-0.10
and pc-0.11 so that we can finally remove them in a future release.

Reviewed-by: Eduardo Habkost <ehabkost@redhat.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
Message-Id: <1529917512-10528-1-git-send-email-thuth@redhat.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 include/hw/boards.h |  3 +++
 hw/i386/pc_piix.c   |  1 +
 vl.c                | 10 ++++++++--
 qemu-doc.texi       |  5 +++++
 4 files changed, 17 insertions(+), 2 deletions(-)

diff --git a/include/hw/boards.h b/include/hw/boards.h
index ef7457f5dd..79069ddcbe 100644
--- a/include/hw/boards.h
+++ b/include/hw/boards.h
@@ -107,6 +107,8 @@ typedef struct {
 
 /**
  * MachineClass:
+ * @deprecation_reason: If set, the machine is marked as deprecated. The
+ *    string should provide some clear information about what to use instead.
  * @max_cpus: maximum number of CPUs supported. Default: 1
  * @min_cpus: minimum number of CPUs supported. Default: 1
  * @default_cpus: number of CPUs instantiated if none are specified. Default: 1
@@ -166,6 +168,7 @@ struct MachineClass {
     char *name;
     const char *alias;
     const char *desc;
+    const char *deprecation_reason;
 
     void (*init)(MachineState *state);
     void (*reset)(void);
diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
index e9b6f064fb..d357907b0b 100644
--- a/hw/i386/pc_piix.c
+++ b/hw/i386/pc_piix.c
@@ -956,6 +956,7 @@ static void pc_i440fx_0_11_machine_options(MachineClass *m)
 {
     pc_i440fx_0_12_machine_options(m);
     m->hw_version = "0.11";
+    m->deprecation_reason = "use a newer machine type instead";
     SET_MACHINE_COMPAT(m, PC_COMPAT_0_11);
 }
 
diff --git a/vl.c b/vl.c
index a37dfe4684..d26f19b06d 100644
--- a/vl.c
+++ b/vl.c
@@ -2560,8 +2560,9 @@ static gint machine_class_cmp(gconstpointer a, gconstpointer b)
             if (mc->alias) {
                 printf("%-20s %s (alias of %s)\n", mc->alias, mc->desc, mc->name);
             }
-            printf("%-20s %s%s\n", mc->name, mc->desc,
-                   mc->is_default ? " (default)" : "");
+            printf("%-20s %s%s%s\n", mc->name, mc->desc,
+                   mc->is_default ? " (default)" : "",
+                   mc->deprecation_reason ? " (deprecated)" : "");
         }
     }
 
@@ -4263,6 +4264,11 @@ int main(int argc, char **argv, char **envp)
 
     configure_accelerator(current_machine);
 
+    if (!qtest_enabled() && machine_class->deprecation_reason) {
+        error_report("Machine type '%s' is deprecated: %s",
+                     machine_class->name, machine_class->deprecation_reason);
+    }
+
     /*
      * Register all the global properties, including accel properties,
      * machine properties, and user-specified ones.
diff --git a/qemu-doc.texi b/qemu-doc.texi
index 282bc3dc35..16fcb47901 100644
--- a/qemu-doc.texi
+++ b/qemu-doc.texi
@@ -2943,6 +2943,11 @@ support page sizes < 4096 any longer.
 
 @section System emulator machines
 
+@subsection pc-0.10 and pc-0.11 (since 3.0)
+
+These machine types are very old and likely can not be used for live migration
+from old QEMU versions anymore. A newer machine type should be used instead.
+
 @section Device options
 
 @subsection Block device options
-- 
2.18.0.rc1.1.g3f1ff2140
