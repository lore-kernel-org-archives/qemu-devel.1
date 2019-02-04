Received: from eggs.gnu.org ([209.51.188.92]:38303)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gqa8f-0000bH-UN
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 04:02:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gqa8e-0007dA-9T
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 04:02:01 -0500
From: David Gibson <david@gibson.dropbear.id.au>
Date: Mon,  4 Feb 2019 20:01:00 +1100
Message-Id: <20190204090124.26191-14-david@gibson.dropbear.id.au>
In-Reply-To: <20190204090124.26191-1-david@gibson.dropbear.id.au>
References: <20190204090124.26191-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 13/37] spapr: Forbid setting ic-mode for old
 machine types
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, groug@kaod.org, clg@kaod.org, lvivier@redhat.com, spopovyc@redhat.com, David Gibson <david@gibson.dropbear.id.au>

From: Greg Kurz <groug@kaod.org>

Machine types 3.0 and older only know about the legacy XICS backend.
Make it clear by erroring out if the user tries to set ic-mode on
such machines.

Signed-off-by: Greg Kurz <groug@kaod.org>
Tested-by: C=C3=A9dric Le Goater <clg@kaod.org>
Reviewed-by: C=C3=A9dric Le Goater <clg@kaod.org>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/ppc/spapr.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 71fe552c83..a217c7f7a6 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -3127,6 +3127,11 @@ static void spapr_set_ic_mode(Object *obj, const c=
har *value, Error **errp)
 {
     sPAPRMachineState *spapr =3D SPAPR_MACHINE(obj);
=20
+    if (SPAPR_MACHINE_GET_CLASS(spapr)->legacy_irq_allocation) {
+        error_setg(errp, "This machine only uses the legacy XICS backend=
, don't pass ic-mode");
+        return;
+    }
+
     /* The legacy IRQ backend can not be set */
     if (strcmp(value, "xics") =3D=3D 0) {
         spapr->irq =3D &spapr_irq_xics;
--=20
2.20.1
