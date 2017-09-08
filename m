Received: from eggs.gnu.org ([2001:4830:134:3::10]:54619)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1dqKMY-0004Lw-LP
	for qemu-devel@nongnu.org; Fri, 08 Sep 2017 10:34:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1dqKMT-0001Pa-4y
	for qemu-devel@nongnu.org; Fri, 08 Sep 2017 10:34:30 -0400
Received: from 7.mo4.mail-out.ovh.net ([178.33.253.54]:52242)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1dqKMS-0001Ot-Uo
	for qemu-devel@nongnu.org; Fri, 08 Sep 2017 10:34:25 -0400
Received: from player159.ha.ovh.net (b9.ovh.net [213.186.33.59])
	by mo4.mail-out.ovh.net (Postfix) with ESMTP id 7F2CA958CE
	for <qemu-devel@nongnu.org>; Fri,  8 Sep 2017 16:34:23 +0200 (CEST)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Date: Fri,  8 Sep 2017 16:33:43 +0200
Message-Id: <20170908143344.12960-3-clg@kaod.org>
In-Reply-To: <20170908143344.12960-1-clg@kaod.org>
References: <20170908143344.12960-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 2/3] spapr: fix CAS-generated reset
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-ppc@nongnu.org, qemu-devel@nongnu.org
Cc: David Gibson <david@gibson.dropbear.id.au>, Michael Roth <mdroth@linux.vnet.ibm.com>, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>

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
---
 hw/ppc/spapr_hcall.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/hw/ppc/spapr_hcall.c b/hw/ppc/spapr_hcall.c
index 07b3da8dc4cd..92f1e21358b8 100644
--- a/hw/ppc/spapr_hcall.c
+++ b/hw/ppc/spapr_hcall.c
@@ -1575,6 +1575,13 @@ static target_ulong h_client_architecture_support(=
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
