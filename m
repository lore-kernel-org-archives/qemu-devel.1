Received: from eggs.gnu.org ([2001:4830:134:3::10]:53522)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fXNR0-0003Qu-4j
	for qemu-devel@nongnu.org; Mon, 25 Jun 2018 05:05:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fXNQw-0002bh-Uw
	for qemu-devel@nongnu.org; Mon, 25 Jun 2018 05:05:18 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:44268 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1fXNQw-0002bW-OL
	for qemu-devel@nongnu.org; Mon, 25 Jun 2018 05:05:14 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
	[10.11.54.5])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 52E7781663EC
	for <qemu-devel@nongnu.org>; Mon, 25 Jun 2018 09:05:14 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
Date: Mon, 25 Jun 2018 11:05:12 +0200
Message-Id: <1529917512-10528-1-git-send-email-thuth@redhat.com>
Subject: [Qemu-devel] [PATCH v4] hw/i386: Deprecate the machine types
 pc-0.10 and pc-0.11
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>

The oldest machine type which is still used in a still maintained distro
is a pc-0.12 based machine type in RHEL6, so everything that is older
than pc-0.12 should not be used anymore. Thus let's deprecate pc-0.10
and pc-0.11 so that we can finally remove them in a future release.

Reviewed-by: Eduardo Habkost <ehabkost@redhat.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 This is based on a patch that I already sent in 2017. But back then, we
 were still in progress of discussing our deprecation policies (e.g. auto-
 matic deprecation for old machine types), and there was no clear consensus
 whether we should deprecate 0.10 - 0.11, all 0.x or even up to version 1.2.
 After some iterations and too much discussion, I've forgotten about this
 patch. Anyway, I think we agreed that at least 0.10 and 0.11 can certainly
 be removed nowadays, so let's finally get at least those two machine types
 marked as deprecated! If there is not too much bikeshed-painting discussions
 anymore and the patch gets finally accepted and we will finally have removed
 these two types in v3.2, we can resume the discussion about newer machine
 types afterwards.

 Note: I don't want to add a QMP interface for this in this patch here,
 let's keep this small and simple! If we decide that we need a QMP interface,
 we can do that with a separate patch later.

 v4:
 - Shorten the deprecation message as requested by Markus
 - Added Eduardo's Reviewed-by

 v3:
 - Do not print the deprecation messages if qtest_enabled()

 v2:
 - Renamed deprecation_msg to deprecation_reason
 - Added information about that field to the MachineClass comment

 hw/i386/pc_piix.c   |  1 +
 include/hw/boards.h |  3 +++
 qemu-doc.texi       |  5 +++++
 vl.c                | 10 ++++++++--
 4 files changed, 17 insertions(+), 2 deletions(-)

diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
index e9b6f06..d357907 100644
--- a/hw/i386/pc_piix.c
+++ b/hw/i386/pc_piix.c
@@ -956,6 +956,7 @@ static void pc_i440fx_0_11_machine_options(MachineClass *m)
 {
     pc_i440fx_0_12_machine_options(m);
     m->hw_version = "0.11";
+    m->deprecation_reason = "use a newer machine type instead";
     SET_MACHINE_COMPAT(m, PC_COMPAT_0_11);
 }
 
diff --git a/include/hw/boards.h b/include/hw/boards.h
index ef7457f..79069dd 100644
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
diff --git a/qemu-doc.texi b/qemu-doc.texi
index 282bc3d..16fcb47 100644
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
diff --git a/vl.c b/vl.c
index d451f45..5d8a9df 100644
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
 
@@ -4257,6 +4258,11 @@ int main(int argc, char **argv, char **envp)
 
     configure_accelerator(current_machine);
 
+    if (!qtest_enabled() && machine_class->deprecation_reason) {
+        error_report("Machine type '%s' is deprecated: %s",
+                     machine_class->name, machine_class->deprecation_reason);
+    }
+
     /*
      * Register all the global properties, including accel properties,
      * machine properties, and user-specified ones.
-- 
1.8.3.1
