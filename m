Received: from eggs.gnu.org ([2001:4830:134:3::10]:54132)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dshfK-0006eC-RB
	for qemu-devel@nongnu.org; Thu, 14 Sep 2017 23:51:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dshfJ-0003Mk-Iy
	for qemu-devel@nongnu.org; Thu, 14 Sep 2017 23:51:42 -0400
From: David Gibson <david@gibson.dropbear.id.au>
Date: Fri, 15 Sep 2017 13:51:20 +1000
Message-Id: <20170915035130.8354-9-david@gibson.dropbear.id.au>
In-Reply-To: <20170915035130.8354-1-david@gibson.dropbear.id.au>
References: <20170915035130.8354-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 08/18] spapr: fix CAS-generated reset
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: agraf@suse.de, gkurz@kaod.org, qemu-devel@nongnu.org, qemu-ppc@nongnu.org, aik@ozlabs.ru, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>, David Gibson <david@gibson.dropbear.id.au>

From: C=C3=A9dric Le Goater <clg@kaod.org>

The OV5_MMU_RADIX_300 requires special handling in the CAS negotiation
process. It is cleared from the option vector of the guest before
evaluating the changes and re-added later. But, when testing for a
possible CAS reset :

    spapr->cas_reboot =3D spapr_ovec_diff(ov5_updates,
                                        ov5_cas_old, spapr->ov5_cas);

the bit OV5_MMU_RADIX_300 will each time be seen as removed from the
previous OV5 set, hence generating a reset loop.

Fix this problem by also clearing the same bit in the ov5_cas_old set.

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/ppc/spapr_hcall.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/hw/ppc/spapr_hcall.c b/hw/ppc/spapr_hcall.c
index 6ab8c188f3..57bb411394 100644
--- a/hw/ppc/spapr_hcall.c
+++ b/hw/ppc/spapr_hcall.c
@@ -1581,6 +1581,13 @@ static target_ulong h_client_architecture_support(=
PowerPCCPU *cpu,
      * to worry about this for now.
      */
     ov5_cas_old =3D spapr_ovec_clone(spapr->ov5_cas);
+
+    /* also clear the radix/hash bit from the current ov5_cas bits to
+     * be in sync with the newly ov5 bits. Else the radix bit will be
+     * seen as being removed and this will generate a reset loop
+     */
+    spapr_ovec_clear(ov5_cas_old, OV5_MMU_RADIX_300);
+
     /* full range of negotiated ov5 capabilities */
     spapr_ovec_intersect(spapr->ov5_cas, spapr->ov5, ov5_guest);
     spapr_ovec_cleanup(ov5_guest);
--=20
2.13.5
