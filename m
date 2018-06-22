Received: from eggs.gnu.org ([2001:4830:134:3::10]:39734)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fWDd0-0007jL-B1
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 00:24:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fWDcy-0003aL-0q
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 00:24:54 -0400
From: David Gibson <david@gibson.dropbear.id.au>
Date: Fri, 22 Jun 2018 14:24:22 +1000
Message-Id: <20180622042437.14259-8-david@gibson.dropbear.id.au>
In-Reply-To: <20180622042437.14259-1-david@gibson.dropbear.id.au>
References: <20180622042437.14259-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 08/23] spapr: Compute effective capability
 values earlier
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: agraf@suse.de, aik@ozlabs.ru, groug@kaod.org, clg@kaod.org, lvivier@redhat.com, qemu-devel@nongnu.org, qemu-ppc@nongnu.org, David Gibson <david@gibson.dropbear.id.au>

Previously, the effective values of the various spapr capability flags
were only determined at machine reset time.  That was a lazy way of makin=
g
sure it was after cpu initialization so it could use the cpu object to
inform the defaults.

But we've now improved the compat checking code so that we don't need to
instantiate the cpus to use it.  That lets us move the resolution of the
capability defaults much earlier.

This is going to be necessary for some future capabilities.

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
Reviewed-by: Greg Kurz <groug@kaod.org>
Reviewed-by: C=C3=A9dric Le Goater <clg@kaod.org>
---
 hw/ppc/spapr.c         | 6 ++++--
 hw/ppc/spapr_caps.c    | 9 ++++++---
 include/hw/ppc/spapr.h | 3 ++-
 3 files changed, 12 insertions(+), 6 deletions(-)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index bc179f6f89..4a0b679166 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -1612,7 +1612,7 @@ static void spapr_machine_reset(void)
     void *fdt;
     int rc;
=20
-    spapr_caps_reset(spapr);
+    spapr_caps_apply(spapr);
=20
     first_ppc_cpu =3D POWERPC_CPU(first_cpu);
     if (kvm_enabled() && kvmppc_has_cap_mmu_radix() &&
@@ -2526,7 +2526,9 @@ static void spapr_machine_init(MachineState *machin=
e)
     QLIST_INIT(&spapr->phbs);
     QTAILQ_INIT(&spapr->pending_dimm_unplugs);
=20
-    /* Check HPT resizing availability */
+    /* Determine capabilities to run with */
+    spapr_caps_init(spapr);
+
     kvmppc_check_papr_resize_hpt(&resize_hpt_err);
     if (spapr->resize_hpt =3D=3D SPAPR_RESIZE_HPT_DEFAULT) {
         /*
diff --git a/hw/ppc/spapr_caps.c b/hw/ppc/spapr_caps.c
index 469f38f0ef..dabed817d1 100644
--- a/hw/ppc/spapr_caps.c
+++ b/hw/ppc/spapr_caps.c
@@ -439,12 +439,12 @@ SPAPR_CAP_MIG_STATE(cfpc, SPAPR_CAP_CFPC);
 SPAPR_CAP_MIG_STATE(sbbc, SPAPR_CAP_SBBC);
 SPAPR_CAP_MIG_STATE(ibs, SPAPR_CAP_IBS);
=20
-void spapr_caps_reset(sPAPRMachineState *spapr)
+void spapr_caps_init(sPAPRMachineState *spapr)
 {
     sPAPRCapabilities default_caps;
     int i;
=20
-    /* First compute the actual set of caps we're running with.. */
+    /* Compute the actual set of caps we should run with */
     default_caps =3D default_caps_with_cpu(spapr, MACHINE(spapr)->cpu_ty=
pe);
=20
     for (i =3D 0; i < SPAPR_CAP_NUM; i++) {
@@ -455,8 +455,11 @@ void spapr_caps_reset(sPAPRMachineState *spapr)
             spapr->eff.caps[i] =3D default_caps.caps[i];
         }
     }
+}
=20
-    /* .. then apply those caps to the virtual hardware */
+void spapr_caps_apply(sPAPRMachineState *spapr)
+{
+    int i;
=20
     for (i =3D 0; i < SPAPR_CAP_NUM; i++) {
         sPAPRCapabilityInfo *info =3D &capability_table[i];
diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
index 3388750fc7..9dbd6010f5 100644
--- a/include/hw/ppc/spapr.h
+++ b/include/hw/ppc/spapr.h
@@ -798,7 +798,8 @@ static inline uint8_t spapr_get_cap(sPAPRMachineState=
 *spapr, int cap)
     return spapr->eff.caps[cap];
 }
=20
-void spapr_caps_reset(sPAPRMachineState *spapr);
+void spapr_caps_init(sPAPRMachineState *spapr);
+void spapr_caps_apply(sPAPRMachineState *spapr);
 void spapr_caps_add_properties(sPAPRMachineClass *smc, Error **errp);
 int spapr_caps_post_migration(sPAPRMachineState *spapr);
=20
--=20
2.17.1
