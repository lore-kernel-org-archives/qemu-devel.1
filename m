Received: from eggs.gnu.org ([2001:4830:134:3::10]:44324)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1ej8iw-0005XY-Ox
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 14:16:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1ej8ir-000883-Vq
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 14:16:10 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:44338)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1ej8ir-00087W-KW
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 14:16:05 -0500
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w16JFLpC116906
	for <qemu-devel@nongnu.org>; Tue, 6 Feb 2018 14:16:04 -0500
Received: from e19.ny.us.ibm.com (e19.ny.us.ibm.com [129.33.205.209])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2fygkucwmc-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 06 Feb 2018 14:16:04 -0500
Received: from localhost
	by e19.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Tue, 6 Feb 2018 14:16:03 -0500
From: Michael Roth <mdroth@linux.vnet.ibm.com>
Date: Tue,  6 Feb 2018 13:15:01 -0600
In-Reply-To: <20180206191515.25830-1-mdroth@linux.vnet.ibm.com>
References: <20180206191515.25830-1-mdroth@linux.vnet.ibm.com>
Message-Id: <20180206191515.25830-41-mdroth@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH 40/54] spapr: Validate capabilities on migration
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, christian.ehrhardt@canonical.com, David Gibson <david@gibson.dropbear.id.au>

From: David Gibson <david@gibson.dropbear.id.au>

Now that the "pseries" machine type implements optional capabilities (well,
one so far) there's the possibility of having different capabilities
available at either end of a migration.  Although arguably a user error,
it would be nice to catch this situation and fail as gracefully as we can.

This adds code to migrate the capabilities flags.  These aren't pulled
directly into the destination's configuration since what the user has
specified on the destination command line should take precedence.  However,
they are checked against the destination capabilities.

If the source was using a capability which is absent on the destination,
we fail the migration, since that could easily cause a guest crash or other
bad behaviour.  If the source lacked a capability which is present on the
destination we warn, but allow the migration to proceed.

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
Reviewed-by: Greg Kurz <groug@kaod.org>
(cherry picked from commit be85537d654565e35e359a74b46fc08b7956525c)
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 hw/ppc/spapr.c         |  6 ++++
 hw/ppc/spapr_caps.c    | 96 ++++++++++++++++++++++++++++++++++++++++++++++++--
 include/hw/ppc/spapr.h |  6 ++++
 3 files changed, 105 insertions(+), 3 deletions(-)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 08e4a14340..69ddc4bb23 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -1563,6 +1563,11 @@ static int spapr_post_load(void *opaque, int version_id)
     sPAPRMachineState *spapr = (sPAPRMachineState *)opaque;
     int err = 0;
 
+    err = spapr_caps_post_migration(spapr);
+    if (err) {
+        return err;
+    }
+
     if (!object_dynamic_cast(OBJECT(spapr->ics), TYPE_ICS_KVM)) {
         CPUState *cs;
         CPU_FOREACH(cs) {
@@ -1729,6 +1734,7 @@ static const VMStateDescription vmstate_spapr = {
         &vmstate_spapr_ov5_cas,
         &vmstate_spapr_patb_entry,
         &vmstate_spapr_pending_events,
+        &vmstate_spapr_caps,
         NULL
     }
 };
diff --git a/hw/ppc/spapr_caps.c b/hw/ppc/spapr_caps.c
index 3b35b91a5b..cad40fe49a 100644
--- a/hw/ppc/spapr_caps.c
+++ b/hw/ppc/spapr_caps.c
@@ -22,6 +22,7 @@
  * THE SOFTWARE.
  */
 #include "qemu/osdep.h"
+#include "qemu/error-report.h"
 #include "qapi/error.h"
 #include "qapi/visitor.h"
 #include "sysemu/hw_accel.h"
@@ -83,6 +84,93 @@ static sPAPRCapabilities default_caps_with_cpu(sPAPRMachineState *spapr,
     return caps;
 }
 
+static bool spapr_caps_needed(void *opaque)
+{
+    sPAPRMachineState *spapr = opaque;
+
+    return (spapr->forced_caps.mask != 0) || (spapr->forbidden_caps.mask != 0);
+}
+
+/* This has to be called from the top-level spapr post_load, not the
+ * caps specific one.  Otherwise it wouldn't be called when the source
+ * caps are all defaults, which could still conflict with overridden
+ * caps on the destination */
+int spapr_caps_post_migration(sPAPRMachineState *spapr)
+{
+    uint64_t allcaps = 0;
+    int i;
+    bool ok = true;
+    sPAPRCapabilities dstcaps = spapr->effective_caps;
+    sPAPRCapabilities srccaps;
+
+    srccaps = default_caps_with_cpu(spapr, first_cpu);
+    srccaps.mask |= spapr->mig_forced_caps.mask;
+    srccaps.mask &= ~spapr->mig_forbidden_caps.mask;
+
+    for (i = 0; i < ARRAY_SIZE(capability_table); i++) {
+        sPAPRCapabilityInfo *info = &capability_table[i];
+
+        allcaps |= info->flag;
+
+        if ((srccaps.mask & info->flag) && !(dstcaps.mask & info->flag)) {
+            error_report("cap-%s=on in incoming stream, but off in destination",
+                         info->name);
+            ok = false;
+        }
+
+        if (!(srccaps.mask & info->flag) && (dstcaps.mask & info->flag)) {
+            warn_report("cap-%s=off in incoming stream, but on in destination",
+                         info->name);
+        }
+    }
+
+    if (spapr->mig_forced_caps.mask & ~allcaps) {
+        error_report(
+            "Unknown capabilities 0x%"PRIx64" enabled in incoming stream",
+            spapr->mig_forced_caps.mask & ~allcaps);
+        ok = false;
+    }
+    if (spapr->mig_forbidden_caps.mask & ~allcaps) {
+        warn_report(
+            "Unknown capabilities 0x%"PRIx64" disabled in incoming stream",
+            spapr->mig_forbidden_caps.mask & ~allcaps);
+    }
+
+    return ok ? 0 : -EINVAL;
+}
+
+static int spapr_caps_pre_save(void *opaque)
+{
+    sPAPRMachineState *spapr = opaque;
+
+    spapr->mig_forced_caps = spapr->forced_caps;
+    spapr->mig_forbidden_caps = spapr->forbidden_caps;
+    return 0;
+}
+
+static int spapr_caps_pre_load(void *opaque)
+{
+    sPAPRMachineState *spapr = opaque;
+
+    spapr->mig_forced_caps = spapr_caps(0);
+    spapr->mig_forbidden_caps = spapr_caps(0);
+    return 0;
+}
+
+const VMStateDescription vmstate_spapr_caps = {
+    .name = "spapr/caps",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .needed = spapr_caps_needed,
+    .pre_save = spapr_caps_pre_save,
+    .pre_load = spapr_caps_pre_load,
+    .fields = (VMStateField[]) {
+        VMSTATE_UINT64(mig_forced_caps.mask, sPAPRMachineState),
+        VMSTATE_UINT64(mig_forbidden_caps.mask, sPAPRMachineState),
+        VMSTATE_END_OF_LIST()
+    },
+};
+
 void spapr_caps_reset(sPAPRMachineState *spapr)
 {
     Error *local_err = NULL;
@@ -92,6 +180,11 @@ void spapr_caps_reset(sPAPRMachineState *spapr)
     /* First compute the actual set of caps we're running with.. */
     caps = default_caps_with_cpu(spapr, first_cpu);
 
+    /* Remove unnecessary forced/forbidden bits (this will help us
+     * with migration) */
+    spapr->forced_caps.mask &= ~caps.mask;
+    spapr->forbidden_caps.mask &= caps.mask;
+
     caps.mask |= spapr->forced_caps.mask;
     caps.mask &= ~spapr->forbidden_caps.mask;
 
@@ -175,9 +268,6 @@ void spapr_caps_validate(sPAPRMachineState *spapr, Error **errp)
         error_setg(errp, "Some sPAPR capabilities set both on and off");
         return;
     }
-
-    /* Check for any caps incompatible with other caps.  Nothing to do
-     * yet */
 }
 
 void spapr_caps_add_properties(sPAPRMachineClass *smc, Error **errp)
diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
index 72422690bd..985948b622 100644
--- a/include/hw/ppc/spapr.h
+++ b/include/hw/ppc/spapr.h
@@ -54,6 +54,8 @@ typedef enum {
  * Capabilities
  */
 
+/* These bits go in the migration stream, so they can't be reassigned */
+
 /* Hardware Transactional Memory */
 #define SPAPR_CAP_HTM               0x0000000000000001ULL
 
@@ -142,6 +144,7 @@ struct sPAPRMachineState {
     const char *icp_type;
 
     sPAPRCapabilities forced_caps, forbidden_caps;
+    sPAPRCapabilities mig_forced_caps, mig_forbidden_caps;
     sPAPRCapabilities effective_caps;
 };
 
@@ -726,6 +729,8 @@ PowerPCCPU *spapr_find_cpu(int vcpu_id);
 /*
  * Handling of optional capabilities
  */
+extern const VMStateDescription vmstate_spapr_caps;
+
 static inline sPAPRCapabilities spapr_caps(uint64_t mask)
 {
     sPAPRCapabilities caps = { mask };
@@ -740,5 +745,6 @@ static inline bool spapr_has_cap(sPAPRMachineState *spapr, uint64_t cap)
 void spapr_caps_reset(sPAPRMachineState *spapr);
 void spapr_caps_validate(sPAPRMachineState *spapr, Error **errp);
 void spapr_caps_add_properties(sPAPRMachineClass *smc, Error **errp);
+int spapr_caps_post_migration(sPAPRMachineState *spapr);
 
 #endif /* HW_SPAPR_H */
-- 
2.11.0
