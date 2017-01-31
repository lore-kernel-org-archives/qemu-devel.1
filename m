Received: from eggs.gnu.org ([2001:4830:134:3::10]:57704)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1cYYEB-0007p7-7S
	for qemu-devel@nongnu.org; Tue, 31 Jan 2017 08:12:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1cYYE9-0007oW-23
	for qemu-devel@nongnu.org; Tue, 31 Jan 2017 08:12:07 -0500
From: Thomas Huth <thuth@redhat.com>
Date: Tue, 31 Jan 2017 14:11:58 +0100
Message-Id: <1485868319-16151-2-git-send-email-thuth@redhat.com>
In-Reply-To: <1485868319-16151-1-git-send-email-thuth@redhat.com>
References: <1485868319-16151-1-git-send-email-thuth@redhat.com>
Subject: [Qemu-devel] [PATCH 1/2] ppc/kvm: Handle the "family" CPU via alias
 instead of registering new types
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>, qemu-ppc@nongnu.org
Cc: qemu-devel@nongnu.org, Alexander Graf <agraf@suse.de>, Paolo Bonzini <pbonzini@redhat.com>, Bharata B Rao <bharata@linux.vnet.ibm.com>

When running with KVM on POWER, we are registering a "family" CPU
type for the host CPU that we are running on. For example, on all
POWER8-compatible hosts, we register a "POWER8" CPU type, so that
you can always start QEMU with "-cpu POWER8" there, without the
need to know whether you are running on a POWER8, POWER8E or POWER8NVL
host machine.
However, we also have a "POWER8" CPU alias in the ppc_cpu_aliases list
(that is mainly useful for TCG). This leads to two cosmetical drawbacks:
If the user runs QEMU with "-cpu ?", we always claim that POWER8 is an
"alias for POWER8_v2.0" - which is simply not true when running with
KVM on POWER. And when using the 'query-cpu-definitions' QMP call,
there are currently two entries for "POWER8", one for the alias, and
one for the additional registered type.
To solve the two problems, we should rather update the "family" alias
instead of registering a new types. We then only have one "POWER8"
CPU definition around, an alias, which also points to the right
destination.

Buglink: https://bugzilla.redhat.com/show_bug.cgi?id=1396536
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 target/ppc/kvm.c | 36 +++++++++++++++++++++++-------------
 1 file changed, 23 insertions(+), 13 deletions(-)

diff --git a/target/ppc/kvm.c b/target/ppc/kvm.c
index ec92c64..f58c260 100644
--- a/target/ppc/kvm.c
+++ b/target/ppc/kvm.c
@@ -24,6 +24,7 @@
 #include "qemu-common.h"
 #include "qemu/error-report.h"
 #include "cpu.h"
+#include "cpu-models.h"
 #include "qemu/timer.h"
 #include "sysemu/sysemu.h"
 #include "sysemu/hw_accel.h"
@@ -2412,6 +2413,7 @@ static int kvm_ppc_register_host_cpu_type(void)
     };
     PowerPCCPUClass *pvr_pcc;
     DeviceClass *dc;
+    int i;
 
     pvr_pcc = kvm_ppc_get_host_cpu_class();
     if (pvr_pcc == NULL) {
@@ -2420,13 +2422,6 @@ static int kvm_ppc_register_host_cpu_type(void)
     type_info.parent = object_class_get_name(OBJECT_CLASS(pvr_pcc));
     type_register(&type_info);
 
-    /* Register generic family CPU class for a family */
-    pvr_pcc = ppc_cpu_get_family_class(pvr_pcc);
-    dc = DEVICE_CLASS(pvr_pcc);
-    type_info.parent = object_class_get_name(OBJECT_CLASS(pvr_pcc));
-    type_info.name = g_strdup_printf("%s-"TYPE_POWERPC_CPU, dc->desc);
-    type_register(&type_info);
-
 #if defined(TARGET_PPC64)
     type_info.name = g_strdup_printf("%s-"TYPE_SPAPR_CPU_CORE, "host");
     type_info.parent = TYPE_SPAPR_CPU_CORE,
@@ -2436,14 +2431,29 @@ static int kvm_ppc_register_host_cpu_type(void)
     type_info.class_data = (void *) "host";
     type_register(&type_info);
     g_free((void *)type_info.name);
-
-    /* Register generic spapr CPU family class for current host CPU type */
-    type_info.name = g_strdup_printf("%s-"TYPE_SPAPR_CPU_CORE, dc->desc);
-    type_info.class_data = (void *) dc->desc;
-    type_register(&type_info);
-    g_free((void *)type_info.name);
 #endif
 
+    /*
+     * Update generic CPU family class alias (e.g. on a POWER8NVL host,
+     * we want "POWER8" to be a "family" alias that points to the current
+     * host CPU type, too)
+     */
+    dc = DEVICE_CLASS(ppc_cpu_get_family_class(pvr_pcc));
+    for (i = 0; ppc_cpu_aliases[i].alias != NULL; i++) {
+        if (strcmp(ppc_cpu_aliases[i].alias, dc->desc) == 0) {
+            ObjectClass *oc = OBJECT_CLASS(pvr_pcc);
+            char *suffix;
+
+            ppc_cpu_aliases[i].model = g_strdup(object_class_get_name(oc));
+            suffix = strstr(ppc_cpu_aliases[i].model, "-"TYPE_POWERPC_CPU);
+            if (suffix) {
+                *suffix = 0;
+            }
+            ppc_cpu_aliases[i].oc = oc;
+            break;
+        }
+    }
+
     return 0;
 }
 
-- 
1.8.3.1
