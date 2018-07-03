Received: from eggs.gnu.org ([2001:4830:134:3::10]:39580)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1faEKP-0002le-U0
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 01:58:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1faEKO-0006tS-IZ
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 01:58:17 -0400
From: David Gibson <david@gibson.dropbear.id.au>
Date: Tue,  3 Jul 2018 15:57:39 +1000
Message-Id: <20180703055804.13449-11-david@gibson.dropbear.id.au>
In-Reply-To: <20180703055804.13449-1-david@gibson.dropbear.id.au>
References: <20180703055804.13449-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 10/35] ppc/pnv: fix pnv_core_realize() error
 handling
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, groug@kaod.org, clg@kaod.org, agraf@suse.de, mdroth@linux.vnet.ibm.com, aik@ozlabs.ru, David Gibson <david@gibson.dropbear.id.au>

From: C=C3=A9dric Le Goater <clg@kaod.org>

commit d35aefa9ae15 ("ppc/pnv: introduce a new intc_create() operation
to the chip model") changed the object link in the pnv_core_realize()
routine but a return was forgotten in case of error, which can lead to
more problems afterwards (segv)

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
Reviewed-by: Greg Kurz <groug@kaod.org>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/ppc/pnv_core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/ppc/pnv_core.c b/hw/ppc/pnv_core.c
index a9f129fc2c..9750464bf4 100644
--- a/hw/ppc/pnv_core.c
+++ b/hw/ppc/pnv_core.c
@@ -150,6 +150,7 @@ static void pnv_core_realize(DeviceState *dev, Error =
**errp)
     if (!chip) {
         error_propagate(errp, local_err);
         error_prepend(errp, "required link 'chip' not found: ");
+        return;
     }
=20
     pc->threads =3D g_new(PowerPCCPU *, cc->nr_threads);
--=20
2.17.1
