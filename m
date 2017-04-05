Received: from eggs.gnu.org ([2001:4830:134:3::10]:41885)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1cvkH5-0008Vd-6v
	for qemu-devel@nongnu.org; Wed, 05 Apr 2017 08:43:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1cvkH1-0001Fb-A0
	for qemu-devel@nongnu.org; Wed, 05 Apr 2017 08:42:59 -0400
Received: from 3.mo177.mail-out.ovh.net ([46.105.36.172]:56190)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1cvkH1-0001FO-4K
	for qemu-devel@nongnu.org; Wed, 05 Apr 2017 08:42:55 -0400
Received: from player688.ha.ovh.net (b6.ovh.net [213.186.33.56])
	by mo177.mail-out.ovh.net (Postfix) with ESMTP id E017446CF1
	for <qemu-devel@nongnu.org>; Wed,  5 Apr 2017 14:42:53 +0200 (CEST)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Date: Wed,  5 Apr 2017 14:41:33 +0200
Message-Id: <1491396106-26376-9-git-send-email-clg@kaod.org>
In-Reply-To: <1491396106-26376-1-git-send-email-clg@kaod.org>
References: <1491396106-26376-1-git-send-email-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 08/21] ipmi: introduce an ipmi_bmc_sdr_find()
 API
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>, Marcel Apfelbaum <marcel@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Corey Minyard <cminyard@mvista.com>

This patch exposes a new IPMI routine to query a sdr entry from the
sdr table maintained by the IPMI BMC simulator. The API is very
similar to the internal sdr_find_entry() routine and should be used
the same way to query one or all sdrs.

A typical use would be to loop on the sdrs to build nodes of a device
tree.

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
Acked-by: Corey Minyard <cminyard@mvista.com>
---
 hw/ipmi/ipmi_bmc_sim.c | 16 ++++++++++++++++
 include/hw/ipmi/ipmi.h |  2 ++
 2 files changed, 18 insertions(+)

diff --git a/hw/ipmi/ipmi_bmc_sim.c b/hw/ipmi/ipmi_bmc_sim.c
index eae7b2d8c92b..8185a84b76b9 100644
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
index 91b83b5bb0b6..0d36cfc6b7f3 100644
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
2.7.4
