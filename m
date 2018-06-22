Received: from eggs.gnu.org ([2001:4830:134:3::10]:39822)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fWDd2-0007lg-QE
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 00:24:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fWDd0-0003cQ-To
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 00:24:56 -0400
From: David Gibson <david@gibson.dropbear.id.au>
Date: Fri, 22 Jun 2018 14:24:36 +1000
Message-Id: <20180622042437.14259-22-david@gibson.dropbear.id.au>
In-Reply-To: <20180622042437.14259-1-david@gibson.dropbear.id.au>
References: <20180622042437.14259-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 22/23] spapr: Limit available pagesizes to
 provide a consistent guest environment
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

KVM HV has some limitations (deriving from the hardware) that mean not al=
l
host-cpu supported pagesizes may be usable in the guest.  At present this
means that KVM guests and TCG guests may see different available page siz=
es
even if they notionally have the same vcpu model.  This is confusing and
also prevents migration between TCG and KVM.

This patch makes the environment consistent by always allowing the same s=
et
of pagesizes.  Since we can't remove the KVM limitations, we do this by
always applying the same limitations it has, even to TCG guests.

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
Reviewed-by: C=C3=A9dric Le Goater <clg@kaod.org>
Reviewed-by: Greg Kurz <groug@kaod.org>
---
 hw/ppc/spapr_caps.c | 34 ++++++++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/hw/ppc/spapr_caps.c b/hw/ppc/spapr_caps.c
index 722b213d9a..62663ebdf5 100644
--- a/hw/ppc/spapr_caps.c
+++ b/hw/ppc/spapr_caps.c
@@ -335,6 +335,39 @@ static void cap_hpt_maxpagesize_apply(sPAPRMachineSt=
ate *spapr,
     spapr_check_pagesize(spapr, qemu_getrampagesize(), errp);
 }
=20
+static bool spapr_pagesize_cb(void *opaque, uint32_t seg_pshift,
+                              uint32_t pshift)
+{
+    unsigned maxshift =3D *((unsigned *)opaque);
+
+    assert(pshift >=3D seg_pshift);
+
+    /* Don't allow the guest to use pages bigger than the configured
+     * maximum size */
+    if (pshift > maxshift) {
+        return false;
+    }
+
+    /* For whatever reason, KVM doesn't allow multiple pagesizes
+     * within a segment, *except* for the case of 16M pages in a 4k or
+     * 64k segment.  Always exclude other cases, so that TCG and KVM
+     * guests see a consistent environment */
+    if ((pshift !=3D seg_pshift) && (pshift !=3D 24)) {
+        return false;
+    }
+
+    return true;
+}
+
+static void cap_hpt_maxpagesize_cpu_apply(sPAPRMachineState *spapr,
+                                          PowerPCCPU *cpu,
+                                          uint8_t val, Error **errp)
+{
+    unsigned maxshift =3D val;
+
+    ppc_hash64_filter_pagesizes(cpu, spapr_pagesize_cb, &maxshift);
+}
+
 sPAPRCapabilityInfo capability_table[SPAPR_CAP_NUM] =3D {
     [SPAPR_CAP_HTM] =3D {
         .name =3D "htm",
@@ -402,6 +435,7 @@ sPAPRCapabilityInfo capability_table[SPAPR_CAP_NUM] =3D=
 {
         .set =3D spapr_cap_set_pagesize,
         .type =3D "int",
         .apply =3D cap_hpt_maxpagesize_apply,
+        .cpu_apply =3D cap_hpt_maxpagesize_cpu_apply,
     },
 };
=20
--=20
2.17.1
