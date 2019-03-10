Received: from eggs.gnu.org ([209.51.188.92]:42516)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1h2tns-0000hV-MZ
	for qemu-devel@nongnu.org; Sun, 10 Mar 2019 04:27:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1h2tnr-00018M-1S
	for qemu-devel@nongnu.org; Sun, 10 Mar 2019 04:27:28 -0400
From: David Gibson <david@gibson.dropbear.id.au>
Date: Sun, 10 Mar 2019 19:26:12 +1100
Message-Id: <20190310082703.1245-10-david@gibson.dropbear.id.au>
In-Reply-To: <20190310082703.1245-1-david@gibson.dropbear.id.au>
References: <20190310082703.1245-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 09/60] target/ppc/spapr: Add workaround option
 to SPAPR_CAP_IBS
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: groug@kaod.org, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, lvivier@redhat.com, Suraj Jitindar Singh <sjitindarsingh@gmail.com>, David Gibson <david@gibson.dropbear.id.au>

From: Suraj Jitindar Singh <sjitindarsingh@gmail.com>

The spapr_cap SPAPR_CAP_IBS is used to indicate the level of capability
for mitigations for indirect branch speculation. Currently the available
values are broken (default), fixed-ibs (fixed by serialising indirect
branches) and fixed-ccd (fixed by diabling the count cache).

Introduce a new value for this capability denoted workaround, meaning tha=
t
software can work around the issue by flushing the count cache on
context switch. This option is available if the hypervisor sets the
H_CPU_BEHAV_FLUSH_COUNT_CACHE flag in the cpu behaviours returned from
the KVM_PPC_GET_CPU_CHAR ioctl.

Signed-off-by: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
Message-Id: <20190301031912.28809-1-sjitindarsingh@gmail.com>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/ppc/spapr_caps.c    | 21 ++++++++++-----------
 hw/ppc/spapr_hcall.c   |  5 +++++
 include/hw/ppc/spapr.h |  7 +++++++
 target/ppc/kvm.c       |  8 +++++++-
 4 files changed, 29 insertions(+), 12 deletions(-)

diff --git a/hw/ppc/spapr_caps.c b/hw/ppc/spapr_caps.c
index 920224d0c2..74a48a423a 100644
--- a/hw/ppc/spapr_caps.c
+++ b/hw/ppc/spapr_caps.c
@@ -276,11 +276,13 @@ static void cap_safe_bounds_check_apply(sPAPRMachin=
eState *spapr, uint8_t val,
 }
=20
 sPAPRCapPossible cap_ibs_possible =3D {
-    .num =3D 4,
+    .num =3D 5,
     /* Note workaround only maintained for compatibility */
-    .vals =3D {"broken", "workaround", "fixed-ibs", "fixed-ccd"},
-    .help =3D "broken - no protection, fixed-ibs - indirect branch seria=
lisation,"
-            " fixed-ccd - cache count disabled",
+    .vals =3D {"broken", "workaround", "fixed-ibs", "fixed-ccd", "fixed-=
na"},
+    .help =3D "broken - no protection, workaround - count cache flush"
+            ", fixed-ibs - indirect branch serialisation,"
+            " fixed-ccd - cache count disabled,"
+            " fixed-na - fixed in hardware (no longer applicable)",
 };
=20
 static void cap_safe_indirect_branch_apply(sPAPRMachineState *spapr,
@@ -288,15 +290,11 @@ static void cap_safe_indirect_branch_apply(sPAPRMac=
hineState *spapr,
 {
     uint8_t kvm_val =3D kvmppc_get_cap_safe_indirect_branch();
=20
-    if (val =3D=3D SPAPR_CAP_WORKAROUND) { /* Can only be Broken or Fixe=
d */
-        error_setg(errp,
-"Requested safe indirect branch capability level \"workaround\" not vali=
d, try cap-ibs=3D%s",
-                   cap_ibs_possible.vals[kvm_val]);
-    } else if (tcg_enabled() && val) {
+    if (tcg_enabled() && val) {
         /* TODO - for now only allow broken for TCG */
         error_setg(errp,
 "Requested safe indirect branch capability level not supported by tcg, t=
ry a different value for cap-ibs");
-    } else if (kvm_enabled() && val && (val !=3D kvm_val)) {
+    } else if (kvm_enabled() && (val > kvm_val)) {
         error_setg(errp,
 "Requested safe indirect branch capability level not supported by kvm, t=
ry cap-ibs=3D%s",
                    cap_ibs_possible.vals[kvm_val]);
@@ -489,7 +487,8 @@ sPAPRCapabilityInfo capability_table[SPAPR_CAP_NUM] =3D=
 {
     [SPAPR_CAP_IBS] =3D {
         .name =3D "ibs",
         .description =3D
-            "Indirect Branch Speculation (broken, fixed-ibs, fixed-ccd)"=
,
+            "Indirect Branch Speculation (broken, workaround, fixed-ibs,=
"
+            "fixed-ccd, fixed-na)",
         .index =3D SPAPR_CAP_IBS,
         .get =3D spapr_cap_get_string,
         .set =3D spapr_cap_set_string,
diff --git a/hw/ppc/spapr_hcall.c b/hw/ppc/spapr_hcall.c
index 476bad6271..4aa8036fc0 100644
--- a/hw/ppc/spapr_hcall.c
+++ b/hw/ppc/spapr_hcall.c
@@ -1723,12 +1723,17 @@ static target_ulong h_get_cpu_characteristics(Pow=
erPCCPU *cpu,
     }
=20
     switch (safe_indirect_branch) {
+    case SPAPR_CAP_FIXED_NA:
+        break;
     case SPAPR_CAP_FIXED_CCD:
         characteristics |=3D H_CPU_CHAR_CACHE_COUNT_DIS;
         break;
     case SPAPR_CAP_FIXED_IBS:
         characteristics |=3D H_CPU_CHAR_BCCTRL_SERIALISED;
         break;
+    case SPAPR_CAP_WORKAROUND:
+        behaviour |=3D H_CPU_BEHAV_FLUSH_COUNT_CACHE;
+        break;
     default: /* broken */
         assert(safe_indirect_branch =3D=3D SPAPR_CAP_BROKEN);
         break;
diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
index 8efc5e0779..a7f3b1bfdd 100644
--- a/include/hw/ppc/spapr.h
+++ b/include/hw/ppc/spapr.h
@@ -85,12 +85,17 @@ typedef enum {
 /* Bool Caps */
 #define SPAPR_CAP_OFF                   0x00
 #define SPAPR_CAP_ON                    0x01
+
 /* Custom Caps */
+
+/* Generic */
 #define SPAPR_CAP_BROKEN                0x00
 #define SPAPR_CAP_WORKAROUND            0x01
 #define SPAPR_CAP_FIXED                 0x02
+/* SPAPR_CAP_IBS (cap-ibs) */
 #define SPAPR_CAP_FIXED_IBS             0x02
 #define SPAPR_CAP_FIXED_CCD             0x03
+#define SPAPR_CAP_FIXED_NA              0x10 /* Lets leave a bit of a ga=
p... */
=20
 typedef struct sPAPRCapabilities sPAPRCapabilities;
 struct sPAPRCapabilities {
@@ -339,9 +344,11 @@ struct sPAPRMachineState {
 #define H_CPU_CHAR_HON_BRANCH_HINTS             PPC_BIT(5)
 #define H_CPU_CHAR_THR_RECONF_TRIG              PPC_BIT(6)
 #define H_CPU_CHAR_CACHE_COUNT_DIS              PPC_BIT(7)
+#define H_CPU_CHAR_BCCTR_FLUSH_ASSIST           PPC_BIT(9)
 #define H_CPU_BEHAV_FAVOUR_SECURITY             PPC_BIT(0)
 #define H_CPU_BEHAV_L1D_FLUSH_PR                PPC_BIT(1)
 #define H_CPU_BEHAV_BNDS_CHK_SPEC_BAR           PPC_BIT(2)
+#define H_CPU_BEHAV_FLUSH_COUNT_CACHE           PPC_BIT(5)
=20
 /* Each control block has to be on a 4K boundary */
 #define H_CB_ALIGNMENT     4096
diff --git a/target/ppc/kvm.c b/target/ppc/kvm.c
index 3f650c8fc4..7a7a5adee3 100644
--- a/target/ppc/kvm.c
+++ b/target/ppc/kvm.c
@@ -2391,7 +2391,13 @@ static int parse_cap_ppc_safe_bounds_check(struct =
kvm_ppc_cpu_char c)
=20
 static int parse_cap_ppc_safe_indirect_branch(struct kvm_ppc_cpu_char c)
 {
-    if (c.character & c.character_mask & H_CPU_CHAR_CACHE_COUNT_DIS) {
+    if ((~c.behaviour & c.behaviour_mask & H_CPU_BEHAV_FLUSH_COUNT_CACHE=
) &&
+        (~c.character & c.character_mask & H_CPU_CHAR_CACHE_COUNT_DIS) &=
&
+        (~c.character & c.character_mask & H_CPU_CHAR_BCCTRL_SERIALISED)=
) {
+        return SPAPR_CAP_FIXED_NA;
+    } else if (c.behaviour & c.behaviour_mask & H_CPU_BEHAV_FLUSH_COUNT_=
CACHE) {
+        return SPAPR_CAP_WORKAROUND;
+    } else if (c.character & c.character_mask & H_CPU_CHAR_CACHE_COUNT_D=
IS) {
         return  SPAPR_CAP_FIXED_CCD;
     } else if (c.character & c.character_mask & H_CPU_CHAR_BCCTRL_SERIAL=
ISED) {
         return SPAPR_CAP_FIXED_IBS;
--=20
2.20.1
