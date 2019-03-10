Received: from eggs.gnu.org ([209.51.188.92]:42456)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1h2tnq-0000f9-V2
	for qemu-devel@nongnu.org; Sun, 10 Mar 2019 04:27:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1h2tnp-00016y-0R
	for qemu-devel@nongnu.org; Sun, 10 Mar 2019 04:27:26 -0400
From: David Gibson <david@gibson.dropbear.id.au>
Date: Sun, 10 Mar 2019 19:26:11 +1100
Message-Id: <20190310082703.1245-9-david@gibson.dropbear.id.au>
In-Reply-To: <20190310082703.1245-1-david@gibson.dropbear.id.au>
References: <20190310082703.1245-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 08/60] target/ppc/spapr: Enable the large
 decrementer for pseries-4.0
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

Enable the large decrementer by default for the pseries-4.0 machine type.
It is disabled again by default_caps_with_cpu() for pre-POWER9 cpus
since they don't support the large decrementer.

Signed-off-by: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
Message-Id: <20190301024317.22137-4-sjitindarsingh@gmail.com>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/ppc/spapr.c      | 3 ++-
 hw/ppc/spapr_caps.c | 5 +++++
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 6b54ad260a..8e24d7dc50 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -4311,7 +4311,7 @@ static void spapr_machine_class_init(ObjectClass *o=
c, void *data)
     smc->default_caps.caps[SPAPR_CAP_IBS] =3D SPAPR_CAP_BROKEN;
     smc->default_caps.caps[SPAPR_CAP_HPT_MAXPAGESIZE] =3D 16; /* 64kiB *=
/
     smc->default_caps.caps[SPAPR_CAP_NESTED_KVM_HV] =3D SPAPR_CAP_OFF;
-    smc->default_caps.caps[SPAPR_CAP_LARGE_DECREMENTER] =3D SPAPR_CAP_OF=
F;
+    smc->default_caps.caps[SPAPR_CAP_LARGE_DECREMENTER] =3D SPAPR_CAP_ON=
;
     spapr_caps_add_properties(smc, &error_abort);
     smc->irq =3D &spapr_irq_xics;
     smc->dr_phb_enabled =3D true;
@@ -4387,6 +4387,7 @@ static void spapr_machine_3_1_class_options(Machine=
Class *mc)
     mc->default_cpu_type =3D POWERPC_CPU_TYPE_NAME("power8_v2.0");
     smc->update_dt_enabled =3D false;
     smc->dr_phb_enabled =3D false;
+    smc->default_caps.caps[SPAPR_CAP_LARGE_DECREMENTER] =3D SPAPR_CAP_OF=
F;
 }
=20
 DEFINE_SPAPR_MACHINE(3_1, "3.1", false);
diff --git a/hw/ppc/spapr_caps.c b/hw/ppc/spapr_caps.c
index 1e76685199..920224d0c2 100644
--- a/hw/ppc/spapr_caps.c
+++ b/hw/ppc/spapr_caps.c
@@ -536,6 +536,11 @@ static sPAPRCapabilities default_caps_with_cpu(sPAPR=
MachineState *spapr,
=20
     caps =3D smc->default_caps;
=20
+    if (!ppc_type_check_compat(cputype, CPU_POWERPC_LOGICAL_3_00,
+                               0, spapr->max_compat_pvr)) {
+        caps.caps[SPAPR_CAP_LARGE_DECREMENTER] =3D SPAPR_CAP_OFF;
+    }
+
     if (!ppc_type_check_compat(cputype, CPU_POWERPC_LOGICAL_2_07,
                                0, spapr->max_compat_pvr)) {
         caps.caps[SPAPR_CAP_HTM] =3D SPAPR_CAP_OFF;
--=20
2.20.1
