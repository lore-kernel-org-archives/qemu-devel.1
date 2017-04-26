Received: from eggs.gnu.org ([2001:4830:134:3::10]:56781)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1d3Gwp-0005KA-UC
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 03:01:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1d3Gwk-00085J-8r
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 03:01:12 -0400
From: David Gibson <david@gibson.dropbear.id.au>
Date: Wed, 26 Apr 2017 17:00:19 +1000
Message-Id: <20170426070034.10727-34-david@gibson.dropbear.id.au>
In-Reply-To: <20170426070034.10727-1-david@gibson.dropbear.id.au>
References: <20170426070034.10727-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 33/48] ipmi: introduce an ipmi_bmc_gen_event()
 API
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

It will be used to fill the message buffer with custom events expected
by some systems. Typically, an Open PowerNV platform guest is notified
with an OEM SEL message before a shutdown or a reboot.

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
Acked-by: Corey Minyard <cminyard@mvista.com>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/ipmi/ipmi_bmc_sim.c | 24 ++++++++++++++++++++++++
 include/hw/ipmi/ipmi.h |  2 ++
 2 files changed, 26 insertions(+)

diff --git a/hw/ipmi/ipmi_bmc_sim.c b/hw/ipmi/ipmi_bmc_sim.c
index 09213ab..277c28c 100644
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
index 0d36cfc..0affe5a 100644
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
2.9.3
