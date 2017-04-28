Received: from eggs.gnu.org ([2001:4830:134:3::10]:35976)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1d41F5-0000b4-Rt
	for qemu-devel@nongnu.org; Fri, 28 Apr 2017 04:27:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1d41F2-0001ms-O4
	for qemu-devel@nongnu.org; Fri, 28 Apr 2017 04:27:07 -0400
Received: from 9.mo1.mail-out.ovh.net ([178.32.108.172]:53752)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1d41F2-0001mB-ID
	for qemu-devel@nongnu.org; Fri, 28 Apr 2017 04:27:04 -0400
Received: from player691.ha.ovh.net (b9.ovh.net [213.186.33.59])
	by mo1.mail-out.ovh.net (Postfix) with ESMTP id 9CA326F940
	for <qemu-devel@nongnu.org>; Fri, 28 Apr 2017 10:26:57 +0200 (CEST)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Date: Fri, 28 Apr 2017 10:26:31 +0200
Message-Id: <1493367991-21269-1-git-send-email-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH] ppc/pnv: restrict BMC object to the BMC
 simulator
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: Corey Minyard <cminyard@mvista.com>, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>

Today, when a PowerNV guest runs, it uses the sensor definitions of
the BMC simulator to populate the device tree. But an external IPMI
BMC could also be used and, in that case, it is not (yet) possible to
retrieve the sensor list. Generating the OEM SEL event for shutdown or
reboot also does not make sense as it should be generated on the BMC
side.

This change allows a guest to use an 'ipmi-bmc-extern' backend to the
'isa-ipmi-bt' device and a 'chardev' for transport such as :
=20
	-chardev socket,id=3Dipmi0,host=3Dlocalhost,port=3D9002,reconnect=3D10 \
	-device ipmi-bmc-extern,id=3Dbmc0,chardev=3Dipmi0 \
	-device isa-ipmi-bt,bmc=3Dbmc0,irq=3D10

and connect to a BMC simulator, the OpenIPMI ipmi_sim simulator for
instance.

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
---

 Corey,

 Should we externalize the TYPE_IPMI_BMC_EXTERN and TYPE_IPMI_BMC_SIMULAT=
OR
 defines ?=20

 hw/ppc/pnv.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: qemu-powernv-2.10.git/hw/ppc/pnv.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- qemu-powernv-2.10.git.orig/hw/ppc/pnv.c
+++ qemu-powernv-2.10.git/hw/ppc/pnv.c
@@ -520,7 +520,7 @@ static void ppc_powernv_reset(void)
      * This is the internal simulator but it could also be an external
      * BMC.
      */
-    obj =3D object_resolve_path_type("", TYPE_IPMI_BMC, NULL);
+    obj =3D object_resolve_path_type("", "ipmi-bmc-sim", NULL);
     if (obj) {
         pnv->bmc =3D IPMI_BMC(obj);
     }
