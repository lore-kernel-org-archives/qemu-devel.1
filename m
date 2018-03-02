Received: from eggs.gnu.org ([2001:4830:134:3::10]:38732)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1erdnf-0000mL-Ot
	for qemu-devel@nongnu.org; Fri, 02 Mar 2018 01:04:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1erdnc-00049V-Dk
	for qemu-devel@nongnu.org; Fri, 02 Mar 2018 01:04:11 -0500
From: David Gibson <david@gibson.dropbear.id.au>
Date: Fri,  2 Mar 2018 17:03:45 +1100
Message-Id: <20180302060350.24330-20-david@gibson.dropbear.id.au>
In-Reply-To: <20180302060350.24330-1-david@gibson.dropbear.id.au>
References: <20180302060350.24330-1-david@gibson.dropbear.id.au>
Subject: [Qemu-devel] [PULL 19/24] ppc/spapr-caps: Add support for custom
 spapr_capabilities
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, groug@kaod.org, surajjs@au1.ibm.com, mark.cave-ayland@ilande.co.uk, Suraj Jitindar Singh <sjitindarsingh@gmail.com>, David Gibson <david@gibson.dropbear.id.au>

From: Suraj Jitindar Singh <sjitindarsingh@gmail.com>

There are currently 2 implemented types of spapr-caps, boolean and
tristate. However there may be a need for caps which don't fit either of
these options. Add a custom capability type for which a list of custom
valid strings can be specified and implement the get/set functions for
these. Also add a field for help text to describe the available options.

Signed-off-by: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
[dwg: Change "help" option to "?" matching qemu conventions]
[dwg: Add ATTRIBUTE_UNUSED to avoid breaking bisect]
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/ppc/spapr_caps.c | 70 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 70 insertions(+)

diff --git a/hw/ppc/spapr_caps.c b/hw/ppc/spapr_caps.c
index 99a4b71d19..3d8b796df9 100644
--- a/hw/ppc/spapr_caps.c
+++ b/hw/ppc/spapr_caps.c
@@ -32,6 +32,20 @@
 
 #include "hw/ppc/spapr.h"
 
+typedef struct sPAPRCapPossible {
+    int num;            /* size of vals array below */
+    const char *help;   /* help text for vals */
+    /*
+     * Note:
+     * - because of the way compatibility is determined vals MUST be ordered
+     *   such that later options are a superset of all preceding options.
+     * - the order of vals must be preserved, that is their index is important,
+     *   however vals may be added to the end of the list so long as the above
+     *   point is observed
+     */
+    const char *vals[];
+} sPAPRCapPossible;
+
 typedef struct sPAPRCapabilityInfo {
     const char *name;
     const char *description;
@@ -41,6 +55,8 @@ typedef struct sPAPRCapabilityInfo {
     ObjectPropertyAccessor *get;
     ObjectPropertyAccessor *set;
     const char *type;
+    /* Possible values if this is a custom string type */
+    sPAPRCapPossible *possible;
     /* Make sure the virtual hardware can support this capability */
     void (*apply)(sPAPRMachineState *spapr, uint8_t val, Error **errp);
 } sPAPRCapabilityInfo;
@@ -133,6 +149,60 @@ out:
     g_free(val);
 }
 
+static void ATTRIBUTE_UNUSED spapr_cap_get_string(Object *obj, Visitor *v,
+                                                  const char *name,
+                                                  void *opaque, Error **errp)
+{
+    sPAPRCapabilityInfo *cap = opaque;
+    sPAPRMachineState *spapr = SPAPR_MACHINE(obj);
+    char *val = NULL;
+    uint8_t value = spapr_get_cap(spapr, cap->index);
+
+    if (value >= cap->possible->num) {
+        error_setg(errp, "Invalid value (%d) for cap-%s", value, cap->name);
+        return;
+    }
+
+    val = g_strdup(cap->possible->vals[value]);
+
+    visit_type_str(v, name, &val, errp);
+    g_free(val);
+}
+
+static void ATTRIBUTE_UNUSED spapr_cap_set_string(Object *obj, Visitor *v,
+                                                  const char *name,
+                                                  void *opaque, Error **errp)
+{
+    sPAPRCapabilityInfo *cap = opaque;
+    sPAPRMachineState *spapr = SPAPR_MACHINE(obj);
+    Error *local_err = NULL;
+    uint8_t i;
+    char *val;
+
+    visit_type_str(v, name, &val, &local_err);
+    if (local_err) {
+        error_propagate(errp, local_err);
+        return;
+    }
+
+    if (!strcmp(val, "?")) {
+        error_setg(errp, "%s", cap->possible->help);
+        goto out;
+    }
+    for (i = 0; i < cap->possible->num; i++) {
+        if (!strcasecmp(val, cap->possible->vals[i])) {
+            spapr->cmd_line_caps[cap->index] = true;
+            spapr->eff.caps[cap->index] = i;
+            goto out;
+        }
+    }
+
+    error_setg(errp, "Invalid capability mode \"%s\" for cap-%s", val,
+               cap->name);
+out:
+    g_free(val);
+}
+
 static void cap_htm_apply(sPAPRMachineState *spapr, uint8_t val, Error **errp)
 {
     if (!val) {
-- 
2.14.3
