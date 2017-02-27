Received: from eggs.gnu.org ([2001:4830:134:3::10]:38384)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1ciMKe-0001gY-AC
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 09:31:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1ciMKa-0007uh-Bs
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 09:31:20 -0500
Received: from 12.mo6.mail-out.ovh.net ([178.32.125.228]:59304)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1ciMKa-0007ub-5P
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 09:31:16 -0500
Received: from player761.ha.ovh.net (b9.ovh.net [213.186.33.59])
	by mo6.mail-out.ovh.net (Postfix) with ESMTP id B9A0CAE5F1
	for <qemu-devel@nongnu.org>; Mon, 27 Feb 2017 15:31:14 +0100 (CET)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Date: Mon, 27 Feb 2017 15:29:21 +0100
Message-Id: <1488205773-30436-15-git-send-email-clg@kaod.org>
In-Reply-To: <1488205773-30436-1-git-send-email-clg@kaod.org>
References: <1488205773-30436-1-git-send-email-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v4 14/26] ppc/xics: extend the QOM interface to
 handle ICPs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>

Let's add two new handlers for ICPs. One is to get an ICP object from
a server number and a second is to resend the irqs when needed.

The icp_resend() handler is a temporary workaround needed by the
ics-simple post_load() handler. It will be removed when the post_load
portion can be done at the machine level.

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
---
 hw/intc/xics.c        |  2 +-
 hw/ppc/spapr.c        | 20 ++++++++++++++++++++
 include/hw/ppc/xics.h |  3 +++
 3 files changed, 24 insertions(+), 1 deletion(-)

diff --git a/hw/intc/xics.c b/hw/intc/xics.c
index 76b50dc7722a..f828bcb07026 100644
--- a/hw/intc/xics.c
+++ b/hw/intc/xics.c
@@ -216,7 +216,7 @@ static void icp_check_ipi(ICPState *ss)
     qemu_irq_raise(ss->output);
 }
=20
-static void icp_resend(ICPState *ss)
+void icp_resend(ICPState *ss)
 {
     XICSFabric *xi =3D ss->xics;
     XICSFabricClass *xic =3D XICS_FABRIC_GET_CLASS(xi);
diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 70b9618309fc..7273157ad50e 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -2928,6 +2928,24 @@ static void spapr_ics_resend(XICSFabric *dev)
     ics_resend(spapr->ics);
 }
=20
+static ICPState *spapr_icp_get(XICSFabric *xi, int server)
+{
+    sPAPRMachineState *spapr =3D SPAPR_MACHINE(xi);
+
+    return (server < spapr->xics->nr_servers) ? &spapr->xics->ss[server]=
 :
+        NULL;
+}
+
+static void spapr_icp_resend(XICSFabric *xi)
+{
+    sPAPRMachineState *spapr =3D SPAPR_MACHINE(xi);
+    int i;
+
+    for (i =3D 0; i < spapr->xics->nr_servers; i++) {
+        icp_resend(&spapr->xics->ss[i]);
+    }
+}
+
 static void spapr_machine_class_init(ObjectClass *oc, void *data)
 {
     MachineClass *mc =3D MACHINE_CLASS(oc);
@@ -2972,6 +2990,8 @@ static void spapr_machine_class_init(ObjectClass *o=
c, void *data)
     vhc->hypercall =3D emulate_spapr_hypercall;
     xic->ics_get =3D spapr_ics_get;
     xic->ics_resend =3D spapr_ics_resend;
+    xic->icp_get =3D spapr_icp_get;
+    xic->icp_resend =3D spapr_icp_resend;
 }
=20
 static const TypeInfo spapr_machine_info =3D {
diff --git a/include/hw/ppc/xics.h b/include/hw/ppc/xics.h
index 15c52f9d9eda..01ca5e2dab50 100644
--- a/include/hw/ppc/xics.h
+++ b/include/hw/ppc/xics.h
@@ -193,6 +193,8 @@ typedef struct XICSFabricClass {
     InterfaceClass parent;
     ICSState *(*ics_get)(XICSFabric *xi, int irq);
     void (*ics_resend)(XICSFabric *xi);
+    ICPState *(*icp_get)(XICSFabric *xi, int server);
+    void (*icp_resend)(XICSFabric *xi);
 } XICSFabricClass;
=20
 #define XICS_IRQS_SPAPR               1024
@@ -223,5 +225,6 @@ void ics_simple_write_xive(ICSState *ics, int nr, int=
 server,
 void ics_set_irq_type(ICSState *ics, int srcno, bool lsi);
=20
 void ics_resend(ICSState *ics);
+void icp_resend(ICPState *ss);
=20
 #endif /* XICS_H */
--=20
2.7.4
