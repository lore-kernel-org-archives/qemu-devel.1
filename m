Received: from eggs.gnu.org ([2001:4830:134:3::10]:41958)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1cvkHC-0000IV-6O
	for qemu-devel@nongnu.org; Wed, 05 Apr 2017 08:43:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1cvkH8-0001IV-9z
	for qemu-devel@nongnu.org; Wed, 05 Apr 2017 08:43:06 -0400
Received: from 1.mo177.mail-out.ovh.net ([178.33.107.143]:36714)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1cvkH8-0001Hr-4G
	for qemu-devel@nongnu.org; Wed, 05 Apr 2017 08:43:02 -0400
Received: from player688.ha.ovh.net (b6.ovh.net [213.186.33.56])
	by mo177.mail-out.ovh.net (Postfix) with ESMTP id 1C1DC46BF6
	for <qemu-devel@nongnu.org>; Wed,  5 Apr 2017 14:43:01 +0200 (CEST)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Date: Wed,  5 Apr 2017 14:41:34 +0200
Message-Id: <1491396106-26376-10-git-send-email-clg@kaod.org>
In-Reply-To: <1491396106-26376-1-git-send-email-clg@kaod.org>
References: <1491396106-26376-1-git-send-email-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 09/21] ipmi: introduce an ipmi_bmc_gen_event()
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

It will be used to fill the message buffer with custom events expected
by some systems. Typically, an Open PowerNV platform guest is notified
with an OEM SEL message before a shutdown or a reboot.

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
Acked-by: Corey Minyard <cminyard@mvista.com>
---
 hw/ipmi/ipmi_bmc_sim.c | 24 ++++++++++++++++++++++++
 include/hw/ipmi/ipmi.h |  2 ++
 2 files changed, 26 insertions(+)

diff --git a/hw/ipmi/ipmi_bmc_sim.c b/hw/ipmi/ipmi_bmc_sim.c
index 8185a84b76b9..155561d06614 100644
--- a/hw/ipmi/ipmi_bmc_sim.c
+++ b/hw/ipmi/ipmi_bmc_sim.c
@@ -473,6 +473,30 @@ static int attn_irq_enabled(IPMIBmcSim *ibs)
             IPMI_BMC_MSG_FLAG_EVT_BUF_FULL_SET(ibs));
 }
=20
+void ipmi_bmc_gen_event(IPMIBmc *b, uint8_t *evt, bool log)
+{
+    IPMIBmcSim *ibs =3D IPMI_BMC_SIMULATOR(b);
+    IPMIInterface *s =3D ibs->parent.intf;
+    IPMIInterfaceClass *k =3D IPMI_INTERFACE_GET_CLASS(s);
+
+    if (!IPMI_BMC_EVENT_MSG_BUF_ENABLED(ibs)) {
+        return;
+    }
+
+    if (log && IPMI_BMC_EVENT_LOG_ENABLED(ibs)) {
+        sel_add_event(ibs, evt);
+    }
+
+    if (ibs->msg_flags & IPMI_BMC_MSG_FLAG_EVT_BUF_FULL) {
+        goto out;
+    }
+
+    memcpy(ibs->evtbuf, evt, 16);
+    ibs->msg_flags |=3D IPMI_BMC_MSG_FLAG_EVT_BUF_FULL;
+    k->set_atn(s, 1, attn_irq_enabled(ibs));
+ out:
+    return;
+}
 static void gen_event(IPMIBmcSim *ibs, unsigned int sens_num, uint8_t de=
assert,
                       uint8_t evd1, uint8_t evd2, uint8_t evd3)
 {
diff --git a/include/hw/ipmi/ipmi.h b/include/hw/ipmi/ipmi.h
index 0d36cfc6b7f3..0affe5a4d864 100644
--- a/include/hw/ipmi/ipmi.h
+++ b/include/hw/ipmi/ipmi.h
@@ -261,4 +261,6 @@ typedef uint8_t ipmi_sdr_compact_buffer[sizeof(struct=
 ipmi_sdr_compact)];
=20
 int ipmi_bmc_sdr_find(IPMIBmc *b, uint16_t recid,
                       const struct ipmi_sdr_compact **sdr, uint16_t *nex=
trec);
+void ipmi_bmc_gen_event(IPMIBmc *b, uint8_t *evt, bool log);
+
 #endif
--=20
2.7.4
