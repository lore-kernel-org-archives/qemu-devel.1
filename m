Received: from eggs.gnu.org ([209.51.188.92]:42414)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1h2tnn-0000dW-Ln
	for qemu-devel@nongnu.org; Sun, 10 Mar 2019 04:27:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1h2tnl-00014W-0J
	for qemu-devel@nongnu.org; Sun, 10 Mar 2019 04:27:23 -0400
From: David Gibson <david@gibson.dropbear.id.au>
Date: Sun, 10 Mar 2019 19:26:08 +1100
Message-Id: <20190310082703.1245-6-david@gibson.dropbear.id.au>
In-Reply-To: <20190310082703.1245-1-david@gibson.dropbear.id.au>
References: <20190310082703.1245-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 05/60] target/ppc/spapr: Add
 SPAPR_CAP_LARGE_DECREMENTER
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

Add spapr_cap SPAPR_CAP_LARGE_DECREMENTER to be used to control the
availability of the large decrementer for a guest.

Signed-off-by: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
Message-Id: <20190301024317.22137-1-sjitindarsingh@gmail.com>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/ppc/spapr.c         |  2 ++
 hw/ppc/spapr_caps.c    | 17 +++++++++++++++++
 include/hw/ppc/spapr.h |  5 ++++-
 3 files changed, 23 insertions(+), 1 deletion(-)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index f7d527464c..e07e5370d3 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -2088,6 +2088,7 @@ static const VMStateDescription vmstate_spapr =3D {
         &vmstate_spapr_irq_map,
         &vmstate_spapr_cap_nested_kvm_hv,
         &vmstate_spapr_dtb,
+        &vmstate_spapr_cap_large_decr,
         NULL
     }
 };
@@ -4302,6 +4303,7 @@ static void spapr_machine_class_init(ObjectClass *o=
c, void *data)
     smc->default_caps.caps[SPAPR_CAP_IBS] =3D SPAPR_CAP_BROKEN;
     smc->default_caps.caps[SPAPR_CAP_HPT_MAXPAGESIZE] =3D 16; /* 64kiB *=
/
     smc->default_caps.caps[SPAPR_CAP_NESTED_KVM_HV] =3D SPAPR_CAP_OFF;
+    smc->default_caps.caps[SPAPR_CAP_LARGE_DECREMENTER] =3D SPAPR_CAP_OF=
F;
     spapr_caps_add_properties(smc, &error_abort);
     smc->irq =3D &spapr_irq_xics;
     smc->dr_phb_enabled =3D true;
diff --git a/hw/ppc/spapr_caps.c b/hw/ppc/spapr_caps.c
index 64f98ae68d..3f90f5823e 100644
--- a/hw/ppc/spapr_caps.c
+++ b/hw/ppc/spapr_caps.c
@@ -390,6 +390,13 @@ static void cap_nested_kvm_hv_apply(sPAPRMachineStat=
e *spapr,
     }
 }
=20
+static void cap_large_decr_apply(sPAPRMachineState *spapr,
+                                 uint8_t val, Error **errp)
+{
+    if (val)
+        error_setg(errp, "No large decrementer support, try cap-large-de=
cr=3Doff");
+}
+
 sPAPRCapabilityInfo capability_table[SPAPR_CAP_NUM] =3D {
     [SPAPR_CAP_HTM] =3D {
         .name =3D "htm",
@@ -468,6 +475,15 @@ sPAPRCapabilityInfo capability_table[SPAPR_CAP_NUM] =
=3D {
         .type =3D "bool",
         .apply =3D cap_nested_kvm_hv_apply,
     },
+    [SPAPR_CAP_LARGE_DECREMENTER] =3D {
+        .name =3D "large-decr",
+        .description =3D "Allow Large Decrementer",
+        .index =3D SPAPR_CAP_LARGE_DECREMENTER,
+        .get =3D spapr_cap_get_bool,
+        .set =3D spapr_cap_set_bool,
+        .type =3D "bool",
+        .apply =3D cap_large_decr_apply,
+    },
 };
=20
 static sPAPRCapabilities default_caps_with_cpu(sPAPRMachineState *spapr,
@@ -596,6 +612,7 @@ SPAPR_CAP_MIG_STATE(cfpc, SPAPR_CAP_CFPC);
 SPAPR_CAP_MIG_STATE(sbbc, SPAPR_CAP_SBBC);
 SPAPR_CAP_MIG_STATE(ibs, SPAPR_CAP_IBS);
 SPAPR_CAP_MIG_STATE(nested_kvm_hv, SPAPR_CAP_NESTED_KVM_HV);
+SPAPR_CAP_MIG_STATE(large_decr, SPAPR_CAP_LARGE_DECREMENTER);
=20
 void spapr_caps_init(sPAPRMachineState *spapr)
 {
diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
index 59073a7579..8efc5e0779 100644
--- a/include/hw/ppc/spapr.h
+++ b/include/hw/ppc/spapr.h
@@ -74,8 +74,10 @@ typedef enum {
 #define SPAPR_CAP_HPT_MAXPAGESIZE       0x06
 /* Nested KVM-HV */
 #define SPAPR_CAP_NESTED_KVM_HV         0x07
+/* Large Decrementer */
+#define SPAPR_CAP_LARGE_DECREMENTER     0x08
 /* Num Caps */
-#define SPAPR_CAP_NUM                   (SPAPR_CAP_NESTED_KVM_HV + 1)
+#define SPAPR_CAP_NUM                   (SPAPR_CAP_LARGE_DECREMENTER + 1=
)
=20
 /*
  * Capability Values
@@ -828,6 +830,7 @@ extern const VMStateDescription vmstate_spapr_cap_cfp=
c;
 extern const VMStateDescription vmstate_spapr_cap_sbbc;
 extern const VMStateDescription vmstate_spapr_cap_ibs;
 extern const VMStateDescription vmstate_spapr_cap_nested_kvm_hv;
+extern const VMStateDescription vmstate_spapr_cap_large_decr;
=20
 static inline uint8_t spapr_get_cap(sPAPRMachineState *spapr, int cap)
 {
--=20
2.20.1
