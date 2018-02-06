Received: from eggs.gnu.org ([2001:4830:134:3::10]:44651)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1ej8j9-0005l4-Hc
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 14:16:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1ej8iy-0008FX-Ay
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 14:16:21 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:42076
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1ej8iy-0008Eo-57
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 14:16:12 -0500
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w16JELfe020121
	for <qemu-devel@nongnu.org>; Tue, 6 Feb 2018 14:16:11 -0500
Received: from e12.ny.us.ibm.com (e12.ny.us.ibm.com [129.33.205.202])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2fyf6usgm4-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 06 Feb 2018 14:16:10 -0500
Received: from localhost
	by e12.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Tue, 6 Feb 2018 14:16:10 -0500
From: Michael Roth <mdroth@linux.vnet.ibm.com>
Date: Tue,  6 Feb 2018 13:15:11 -0600
In-Reply-To: <20180206191515.25830-1-mdroth@linux.vnet.ibm.com>
References: <20180206191515.25830-1-mdroth@linux.vnet.ibm.com>
Message-Id: <20180206191515.25830-51-mdroth@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH 50/54] target/ppc/spapr_caps: Add support for
 tristate spapr_capabilities
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, christian.ehrhardt@canonical.com, Suraj Jitindar Singh <sjitindarsingh@gmail.com>, David Gibson <david@gibson.dropbear.id.au>

From: Suraj Jitindar Singh <sjitindarsingh@gmail.com>

spapr_caps are used to represent the level of support for various
capabilities related to the spapr machine type. Currently there is
only support for boolean capabilities.

Add support for tristate capabilities by implementing their get/set
functions. These capabilities can have the values 0, 1 or 2
corresponding to broken, workaround and fixed.

Signed-off-by: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
(cherry picked from commit 6898aed77f4636c3e77af9c12631f583f22cb5db)
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 hw/ppc/spapr_caps.c    | 66 ++++++++++++++++++++++++++++++++++++++++++++++++++
 include/hw/ppc/spapr.h |  4 +++
 2 files changed, 70 insertions(+)

diff --git a/hw/ppc/spapr_caps.c b/hw/ppc/spapr_caps.c
index 5b9e305ac3..3a195c8fef 100644
--- a/hw/ppc/spapr_caps.c
+++ b/hw/ppc/spapr_caps.c
@@ -74,6 +74,72 @@ static void spapr_cap_set_bool(Object *obj, Visitor *v, const char *name,
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
index 2fda48fa54..5d78024433 100644
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
2.11.0
