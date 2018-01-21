Received: from eggs.gnu.org ([2001:4830:134:3::10]:36090)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1ed8Gg-0000Yo-Gs
	for qemu-devel@nongnu.org; Sun, 21 Jan 2018 00:34:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1ed8Gf-0007MA-1r
	for qemu-devel@nongnu.org; Sun, 21 Jan 2018 00:34:10 -0500
From: David Gibson <david@gibson.dropbear.id.au>
Date: Sun, 21 Jan 2018 16:33:53 +1100
Message-Id: <20180121053353.25970-13-david@gibson.dropbear.id.au>
In-Reply-To: <20180121053353.25970-1-david@gibson.dropbear.id.au>
References: <20180121053353.25970-1-david@gibson.dropbear.id.au>
Subject: [Qemu-devel] [PULL 12/12] target/ppc/spapr_caps: Add macro to
 generate spapr_caps migration vmstate
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: groug@kaod.org, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, lvivier@redhat.com, surajjs@au1.ibm.com, Suraj Jitindar Singh <sjitindarsingh@gmail.com>, David Gibson <david@gibson.dropbear.id.au>

From: Suraj Jitindar Singh <sjitindarsingh@gmail.com>

The vmstate description and the contained needed function for migration
of spapr_caps is the same for each cap, with the name of the cap
substituted. As such introduce a macro to allow for easier generation of
these.

Convert the three existing spapr_caps (htm, vsx, and dfp) to use this
macro.

Signed-off-by: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/ppc/spapr_caps.c | 78 +++++++++++++++++------------------------------------
 1 file changed, 24 insertions(+), 54 deletions(-)

diff --git a/hw/ppc/spapr_caps.c b/hw/ppc/spapr_caps.c
index d5c9ce774a..5d52969bd5 100644
--- a/hw/ppc/spapr_caps.c
+++ b/hw/ppc/spapr_caps.c
@@ -228,62 +228,32 @@ int spapr_caps_post_migration(sPAPRMachineState *spapr)
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
2.14.3
