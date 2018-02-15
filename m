Received: from eggs.gnu.org ([2001:4830:134:3::10]:49887)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sjitindarsingh@gmail.com>) id 1em7fm-0003W7-5t
	for qemu-devel@nongnu.org; Wed, 14 Feb 2018 19:45:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sjitindarsingh@gmail.com>) id 1em7fl-0005Q7-C0
	for qemu-devel@nongnu.org; Wed, 14 Feb 2018 19:45:14 -0500
From: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
Date: Thu, 15 Feb 2018 11:44:41 +1100
Message-Id: <20180215004443.18013-1-sjitindarsingh@gmail.com>
Subject: [Qemu-devel] [QEMU-PPC] [PATCH V3 1/3] ppc/spapr-caps: Change
 migration macro to take full spapr-cap name
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-ppc@nongnu.org
Cc: qemu-devel@nongnu.org, david@gibson.dropbear.id.au, aik@ozlabs.ru, Suraj Jitindar Singh <sjitindarsingh@gmail.com>

Change the macro that generates the vmstate migration field and the needed
function for the spapr-caps to take the full spapr-cap name. This has
the benefit of meaning this instance will be picked up when greping
for the spapr-caps and making it more obvious what this macro is doing.

Signed-off-by: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
---
 hw/ppc/spapr_caps.c | 30 +++++++++++++++---------------
 1 file changed, 15 insertions(+), 15 deletions(-)

diff --git a/hw/ppc/spapr_caps.c b/hw/ppc/spapr_caps.c
index 62efdaee38..e69d308560 100644
--- a/hw/ppc/spapr_caps.c
+++ b/hw/ppc/spapr_caps.c
@@ -350,34 +350,34 @@ int spapr_caps_post_migration(sPAPRMachineState *spapr)
 }
 
 /* Used to generate the migration field and needed function for a spapr cap */
-#define SPAPR_CAP_MIG_STATE(cap, ccap)                  \
-static bool spapr_cap_##cap##_needed(void *opaque)      \
+#define SPAPR_CAP_MIG_STATE(sname, cap)                 \
+static bool spapr_cap_##sname##_needed(void *opaque)    \
 {                                                       \
     sPAPRMachineState *spapr = opaque;                  \
                                                         \
-    return spapr->cmd_line_caps[SPAPR_CAP_##ccap] &&    \
-           (spapr->eff.caps[SPAPR_CAP_##ccap] !=        \
-            spapr->def.caps[SPAPR_CAP_##ccap]);         \
+    return spapr->cmd_line_caps[cap] &&                 \
+           (spapr->eff.caps[cap] !=                     \
+            spapr->def.caps[cap]);                      \
 }                                                       \
                                                         \
-const VMStateDescription vmstate_spapr_cap_##cap = {    \
-    .name = "spapr/cap/" #cap,                          \
+const VMStateDescription vmstate_spapr_cap_##sname = {  \
+    .name = "spapr/cap/" #sname,                        \
     .version_id = 1,                                    \
     .minimum_version_id = 1,                            \
-    .needed = spapr_cap_##cap##_needed,                 \
+    .needed = spapr_cap_##sname##_needed,               \
     .fields = (VMStateField[]) {                        \
-        VMSTATE_UINT8(mig.caps[SPAPR_CAP_##ccap],       \
+        VMSTATE_UINT8(mig.caps[cap],                    \
                       sPAPRMachineState),               \
         VMSTATE_END_OF_LIST()                           \
     },                                                  \
 }
 
-SPAPR_CAP_MIG_STATE(htm, HTM);
-SPAPR_CAP_MIG_STATE(vsx, VSX);
-SPAPR_CAP_MIG_STATE(dfp, DFP);
-SPAPR_CAP_MIG_STATE(cfpc, CFPC);
-SPAPR_CAP_MIG_STATE(sbbc, SBBC);
-SPAPR_CAP_MIG_STATE(ibs, IBS);
+SPAPR_CAP_MIG_STATE(htm, SPAPR_CAP_HTM);
+SPAPR_CAP_MIG_STATE(vsx, SPAPR_CAP_VSX);
+SPAPR_CAP_MIG_STATE(dfp, SPAPR_CAP_DFP);
+SPAPR_CAP_MIG_STATE(cfpc, SPAPR_CAP_CFPC);
+SPAPR_CAP_MIG_STATE(sbbc, SPAPR_CAP_SBBC);
+SPAPR_CAP_MIG_STATE(ibs, SPAPR_CAP_IBS);
 
 void spapr_caps_reset(sPAPRMachineState *spapr)
 {
-- 
2.13.6
