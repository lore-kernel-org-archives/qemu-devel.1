Received: from eggs.gnu.org ([2001:4830:134:3::10]:56514)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1d2TIF-0001bM-C2
	for qemu-devel@nongnu.org; Sun, 23 Apr 2017 22:00:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1d2TIE-0003Tf-1w
	for qemu-devel@nongnu.org; Sun, 23 Apr 2017 21:59:59 -0400
From: David Gibson <david@gibson.dropbear.id.au>
Date: Mon, 24 Apr 2017 11:59:12 +1000
Message-Id: <20170424015927.8933-33-david@gibson.dropbear.id.au>
In-Reply-To: <20170424015927.8933-1-david@gibson.dropbear.id.au>
References: <20170424015927.8933-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 32/47] ipmi: introduce an ipmi_bmc_sdr_find() API
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: agraf@suse.de, mdroth@linux.vnet.ibm.com, aik@ozlabs.ru, qemu-devel@nongnu.org, qemu-ppc@nongnu.org, clg@kaod.org, David Gibson <david@gibson.dropbear.id.au>

From: C=C3=A9dric Le Goater <clg@kaod.org>

This patch exposes a new IPMI routine to query a sdr entry from the
sdr table maintained by the IPMI BMC simulator. The API is very
similar to the internal sdr_find_entry() routine and should be used
the same way to query one or all sdrs.

A typical use would be to loop on the sdrs to build nodes of a device
tree.

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
Acked-by: Corey Minyard <cminyard@mvista.com>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/ipmi/ipmi_bmc_sim.c | 16 ++++++++++++++++
 include/hw/ipmi/ipmi.h |  2 ++
 2 files changed, 18 insertions(+)

diff --git a/hw/ipmi/ipmi_bmc_sim.c b/hw/ipmi/ipmi_bmc_sim.c
index eae7b2d..8185a84 100644
--- a/hw/ipmi/ipmi_bmc_sim.c
+++ b/hw/ipmi/ipmi_bmc_sim.c
@@ -416,6 +416,22 @@ static int sdr_find_entry(IPMISdr *sdr, uint16_t rec=
id,
     return 1;
 }
=20
+int ipmi_bmc_sdr_find(IPMIBmc *b, uint16_t recid,
+                      const struct ipmi_sdr_compact **sdr, uint16_t *nex=
trec)
+
+{
+    IPMIBmcSim *ibs =3D IPMI_BMC_SIMULATOR(b);
+    unsigned int pos;
+
+    pos =3D 0;
+    if (sdr_find_entry(&ibs->sdr, recid, &pos, nextrec)) {
+        return -1;
+    }
+
+    *sdr =3D (const struct ipmi_sdr_compact *) &ibs->sdr.sdr[pos];
+    return 0;
+}
+
 static void sel_inc_reservation(IPMISel *sel)
 {
     sel->reservation++;
diff --git a/include/hw/ipmi/ipmi.h b/include/hw/ipmi/ipmi.h
index 91b83b5..0d36cfc 100644
--- a/include/hw/ipmi/ipmi.h
+++ b/include/hw/ipmi/ipmi.h
@@ -259,4 +259,6 @@ struct ipmi_sdr_compact {
=20
 typedef uint8_t ipmi_sdr_compact_buffer[sizeof(struct ipmi_sdr_compact)]=
;
=20
+int ipmi_bmc_sdr_find(IPMIBmc *b, uint16_t recid,
+                      const struct ipmi_sdr_compact **sdr, uint16_t *nex=
trec);
 #endif
--=20
2.9.3
