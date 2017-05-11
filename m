Received: from eggs.gnu.org ([2001:4830:134:3::10]:55970)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1d8fUt-0005Hf-Gu
	for qemu-devel@nongnu.org; Thu, 11 May 2017 00:14:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1d8fUq-0001LT-BL
	for qemu-devel@nongnu.org; Thu, 11 May 2017 00:14:39 -0400
From: David Gibson <david@gibson.dropbear.id.au>
Date: Thu, 11 May 2017 14:14:04 +1000
Message-Id: <20170511041426.6488-2-david@gibson.dropbear.id.au>
In-Reply-To: <20170511041426.6488-1-david@gibson.dropbear.id.au>
References: <20170511041426.6488-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 01/23] ppc/pnv: restrict BMC object to the BMC
 simulator
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, mdroth@linux.vnet.ibm.com, bharata@linux.vnet.ibm.com, agraf@suse.de, aik@ozlabs.ru, sjitindarsingh@gmail.com, mark.cave-ayland@ilande.co.uk, sam.bobroff@au1.ibm.com, nikunj@linux.vnet.ibm.com, clg@kaod.org, David Gibson <david@gibson.dropbear.id.au>

From: C=C3=A9dric Le Goater <clg@kaod.org>

Today, when a PowerNV guest runs, it uses the sensor definitions of
the BMC simulator to populate the device tree. But an external IPMI
BMC could also be used and, in that case, it is not (yet) possible to
retrieve the sensor list. Generating the OEM SEL event for shutdown or
reboot also does not make sense as it should be generated on the BMC
side.

This change allows a guest to use an 'ipmi-bmc-extern' backend to the
'isa-ipmi-bt' device and a 'chardev' for transport such as :

	-chardev socket,id=3Dipmi0,host=3Dlocalhost,port=3D9002,reconnect=3D10 \
	-device ipmi-bmc-extern,id=3Dbmc0,chardev=3Dipmi0 \
	-device isa-ipmi-bt,bmc=3Dbmc0,irq=3D10

and connect to a BMC simulator, the OpenIPMI ipmi_sim simulator for
instance.

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/ppc/pnv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
index d4bcdb0..251baea 100644
--- a/hw/ppc/pnv.c
+++ b/hw/ppc/pnv.c
@@ -511,7 +511,7 @@ static void ppc_powernv_reset(void)
      * This is the internal simulator but it could also be an external
      * BMC.
      */
-    obj =3D object_resolve_path_type("", TYPE_IPMI_BMC, NULL);
+    obj =3D object_resolve_path_type("", "ipmi-bmc-sim", NULL);
     if (obj) {
         pnv->bmc =3D IPMI_BMC(obj);
     }
--=20
2.9.3
