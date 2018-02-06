Received: from eggs.gnu.org ([2001:4830:134:3::10]:44644)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1ej8j7-0005k3-77
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 14:16:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1ej8iz-0008GA-15
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 14:16:21 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:45282)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1ej8iy-0008F6-M8
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 14:16:12 -0500
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w16JG6XX119645
	for <qemu-devel@nongnu.org>; Tue, 6 Feb 2018 14:16:11 -0500
Received: from e15.ny.us.ibm.com (e15.ny.us.ibm.com [129.33.205.205])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2fygkucwrq-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 06 Feb 2018 14:16:10 -0500
Received: from localhost
	by e15.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Tue, 6 Feb 2018 14:16:08 -0500
From: Michael Roth <mdroth@linux.vnet.ibm.com>
Date: Tue,  6 Feb 2018 13:15:09 -0600
In-Reply-To: <20180206191515.25830-1-mdroth@linux.vnet.ibm.com>
References: <20180206191515.25830-1-mdroth@linux.vnet.ibm.com>
Message-Id: <20180206191515.25830-49-mdroth@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH 48/54] target/ppc/spapr_caps: Add macro to
 generate spapr_caps migration vmstate
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

The vmstate description and the contained needed function for migration
of spapr_caps is the same for each cap, with the name of the cap
substituted. As such introduce a macro to allow for easier generation of
these.

Convert the three existing spapr_caps (htm, vsx, and dfp) to use this
macro.

Signed-off-by: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
(cherry picked from commit 1f63ebaa91f73f469c8f107dbd266cabdbea3a40)
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 hw/ppc/spapr_caps.c | 78 +++++++++++++++++------------------------------------
 1 file changed, 24 insertions(+), 54 deletions(-)

diff --git a/hw/ppc/spapr_caps.c b/hw/ppc/spapr_caps.c
index f95a78547d..5b9e305ac3 100644
--- a/hw/ppc/spapr_caps.c
+++ b/hw/ppc/spapr_caps.c
@@ -232,62 +232,32 @@ int spapr_caps_post_migration(sPAPRMachineState *spapr)
     return ok ? 0 : -EINVAL;
 }
 
-static bool spapr_cap_htm_needed(void *opaque)
-{
-    sPAPRMachineState *spapr = opaque;
-
-    return spapr->cmd_line_caps[SPAPR_CAP_HTM] &&
-           (spapr->eff.caps[SPAPR_CAP_HTM] != spapr->def.caps[SPAPR_CAP_HTM]);
-}
-
-const VMStateDescription vmstate_spapr_cap_htm = {
-    .name = "spapr/cap/htm",
-    .version_id = 1,
-    .minimum_version_id = 1,
-    .needed = spapr_cap_htm_needed,
-    .fields = (VMStateField[]) {
-        VMSTATE_UINT8(mig.caps[SPAPR_CAP_HTM], sPAPRMachineState),
-        VMSTATE_END_OF_LIST()
-    },
-};
-
-static bool spapr_cap_vsx_needed(void *opaque)
-{
-    sPAPRMachineState *spapr = opaque;
-
-    return spapr->cmd_line_caps[SPAPR_CAP_VSX] &&
-           (spapr->eff.caps[SPAPR_CAP_VSX] != spapr->def.caps[SPAPR_CAP_VSX]);
+/* Used to generate the migration field and needed function for a spapr cap */
+#define SPAPR_CAP_MIG_STATE(cap, ccap)                  \
+static bool spapr_cap_##cap##_needed(void *opaque)      \
+{                                                       \
+    sPAPRMachineState *spapr = opaque;                  \
+                                                        \
+    return spapr->cmd_line_caps[SPAPR_CAP_##ccap] &&    \
+           (spapr->eff.caps[SPAPR_CAP_##ccap] !=        \
+            spapr->def.caps[SPAPR_CAP_##ccap]);         \
+}                                                       \
+                                                        \
+const VMStateDescription vmstate_spapr_cap_##cap = {    \
+    .name = "spapr/cap/" #cap,                          \
+    .version_id = 1,                                    \
+    .minimum_version_id = 1,                            \
+    .needed = spapr_cap_##cap##_needed,                 \
+    .fields = (VMStateField[]) {                        \
+        VMSTATE_UINT8(mig.caps[SPAPR_CAP_##ccap],       \
+                      sPAPRMachineState),               \
+        VMSTATE_END_OF_LIST()                           \
+    },                                                  \
 }
 
-const VMStateDescription vmstate_spapr_cap_vsx = {
-    .name = "spapr/cap/vsx",
-    .version_id = 1,
-    .minimum_version_id = 1,
-    .needed = spapr_cap_vsx_needed,
-    .fields = (VMStateField[]) {
-        VMSTATE_UINT8(mig.caps[SPAPR_CAP_VSX], sPAPRMachineState),
-        VMSTATE_END_OF_LIST()
-    },
-};
-
-static bool spapr_cap_dfp_needed(void *opaque)
-{
-    sPAPRMachineState *spapr = opaque;
-
-    return spapr->cmd_line_caps[SPAPR_CAP_DFP] &&
-           (spapr->eff.caps[SPAPR_CAP_DFP] != spapr->def.caps[SPAPR_CAP_DFP]);
-}
-
-const VMStateDescription vmstate_spapr_cap_dfp = {
-    .name = "spapr/cap/dfp",
-    .version_id = 1,
-    .minimum_version_id = 1,
-    .needed = spapr_cap_dfp_needed,
-    .fields = (VMStateField[]) {
-        VMSTATE_UINT8(mig.caps[SPAPR_CAP_DFP], sPAPRMachineState),
-        VMSTATE_END_OF_LIST()
-    },
-};
+SPAPR_CAP_MIG_STATE(htm, HTM);
+SPAPR_CAP_MIG_STATE(vsx, VSX);
+SPAPR_CAP_MIG_STATE(dfp, DFP);
 
 void spapr_caps_reset(sPAPRMachineState *spapr)
 {
-- 
2.11.0
