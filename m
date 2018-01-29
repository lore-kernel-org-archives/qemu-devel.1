Received: from eggs.gnu.org ([2001:4830:134:3::10]:34878)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1eg07a-0004TK-PA
	for qemu-devel@nongnu.org; Sun, 28 Jan 2018 22:28:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1eg07Z-0001ep-LY
	for qemu-devel@nongnu.org; Sun, 28 Jan 2018 22:28:38 -0500
From: David Gibson <david@gibson.dropbear.id.au>
Date: Mon, 29 Jan 2018 14:28:22 +1100
Message-Id: <20180129032826.16876-9-david@gibson.dropbear.id.au>
In-Reply-To: <20180129032826.16876-1-david@gibson.dropbear.id.au>
References: <20180129032826.16876-1-david@gibson.dropbear.id.au>
Subject: [Qemu-devel] [PULL 08/12] target/ppc/spapr_caps: Add support for
 tristate spapr_capabilities
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, lvivier@redhat.com, surajjs@au1.ibm.com, groug@kaod.org, Suraj Jitindar Singh <sjitindarsingh@gmail.com>, David Gibson <david@gibson.dropbear.id.au>

From: Suraj Jitindar Singh <sjitindarsingh@gmail.com>

spapr_caps are used to represent the level of support for various
capabilities related to the spapr machine type. Currently there is
only support for boolean capabilities.

Add support for tristate capabilities by implementing their get/set
functions. These capabilities can have the values 0, 1 or 2
corresponding to broken, workaround and fixed.

Signed-off-by: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/ppc/spapr_caps.c    | 66 ++++++++++++++++++++++++++++++++++++++++++++++++++
 include/hw/ppc/spapr.h |  4 +++
 2 files changed, 70 insertions(+)

diff --git a/hw/ppc/spapr_caps.c b/hw/ppc/spapr_caps.c
index 5d52969bd5..d6f82b18fc 100644
--- a/hw/ppc/spapr_caps.c
+++ b/hw/ppc/spapr_caps.c
@@ -73,6 +73,72 @@ static void spapr_cap_set_bool(Object *obj, Visitor *v, const char *name,
     spapr->eff.caps[cap->index] = value ? SPAPR_CAP_ON : SPAPR_CAP_OFF;
 }
 
+static void __attribute__ ((unused)) spapr_cap_get_tristate(Object *obj,
+                                                            Visitor *v,
+                                                            const char *name,
+                                                            void *opaque,
+                                                            Error **errp)
+{
+    sPAPRCapabilityInfo *cap = opaque;
+    sPAPRMachineState *spapr = SPAPR_MACHINE(obj);
+    char *val = NULL;
+    uint8_t value = spapr_get_cap(spapr, cap->index);
+
+    switch (value) {
+    case SPAPR_CAP_BROKEN:
+        val = g_strdup("broken");
+        break;
+    case SPAPR_CAP_WORKAROUND:
+        val = g_strdup("workaround");
+        break;
+    case SPAPR_CAP_FIXED:
+        val = g_strdup("fixed");
+        break;
+    default:
+        error_setg(errp, "Invalid value (%d) for cap-%s", value, cap->name);
+        return;
+    }
+
+    visit_type_str(v, name, &val, errp);
+    g_free(val);
+}
+
+static void __attribute__ ((unused)) spapr_cap_set_tristate(Object *obj,
+                                                            Visitor *v,
+                                                            const char *name,
+                                                            void *opaque,
+                                                            Error **errp)
+{
+    sPAPRCapabilityInfo *cap = opaque;
+    sPAPRMachineState *spapr = SPAPR_MACHINE(obj);
+    char *val;
+    Error *local_err = NULL;
+    uint8_t value;
+
+    visit_type_str(v, name, &val, &local_err);
+    if (local_err) {
+        error_propagate(errp, local_err);
+        return;
+    }
+
+    if (!strcasecmp(val, "broken")) {
+        value = SPAPR_CAP_BROKEN;
+    } else if (!strcasecmp(val, "workaround")) {
+        value = SPAPR_CAP_WORKAROUND;
+    } else if (!strcasecmp(val, "fixed")) {
+        value = SPAPR_CAP_FIXED;
+    } else {
+        error_setg(errp, "Invalid capability mode \"%s\" for cap-%s", val,
+                   cap->name);
+        goto out;
+    }
+
+    spapr->cmd_line_caps[cap->index] = true;
+    spapr->eff.caps[cap->index] = value;
+out:
+    g_free(val);
+}
+
 static void cap_htm_apply(sPAPRMachineState *spapr, uint8_t val, Error **errp)
 {
     if (!val) {
diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
index eded0ea57d..61bb3632c4 100644
--- a/include/hw/ppc/spapr.h
+++ b/include/hw/ppc/spapr.h
@@ -69,6 +69,10 @@ typedef enum {
 /* Bool Caps */
 #define SPAPR_CAP_OFF                   0x00
 #define SPAPR_CAP_ON                    0x01
+/* Broken | Workaround | Fixed Caps */
+#define SPAPR_CAP_BROKEN                0x00
+#define SPAPR_CAP_WORKAROUND            0x01
+#define SPAPR_CAP_FIXED                 0x02
 
 typedef struct sPAPRCapabilities sPAPRCapabilities;
 struct sPAPRCapabilities {
-- 
2.14.3
