Received: from eggs.gnu.org ([2001:4830:134:3::10]:47792)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1fRLUF-0002RP-2p
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 13:47:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1fRLUD-0001Yv-2R
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 13:47:43 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:58034 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jsnow@redhat.com>) id 1fRLUC-0001YU-TR
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 13:47:40 -0400
From: John Snow <jsnow@redhat.com>
Date: Fri,  8 Jun 2018 13:47:15 -0400
Message-Id: <20180608174733.4936-13-jsnow@redhat.com>
In-Reply-To: <20180608174733.4936-1-jsnow@redhat.com>
References: <20180608174733.4936-1-jsnow@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 12/30] ahci: add host register enumeration
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: jsnow@redhat.com, peter.maydell@linaro.org

Signed-off-by: John Snow <jsnow@redhat.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Message-id: 20180531222835.16558-10-jsnow@redhat.com
Signed-off-by: John Snow <jsnow@redhat.com>
---
 hw/ide/ahci.c          | 15 +++++++++++++++
 hw/ide/ahci_internal.h | 15 +++++++++++++++
 2 files changed, 30 insertions(+)

diff --git a/hw/ide/ahci.c b/hw/ide/ahci.c
index a85847b165..5be43ba2d0 100644
--- a/hw/ide/ahci.c
+++ b/hw/ide/ahci.c
@@ -47,6 +47,21 @@ static bool ahci_map_fis_address(AHCIDevice *ad);
 static void ahci_unmap_clb_address(AHCIDevice *ad);
 static void ahci_unmap_fis_address(AHCIDevice *ad);
=20
+__attribute__((__unused__)) /* TODO */
+static const char *AHCIHostReg_lookup[AHCI_HOST_REG__COUNT] =3D {
+    [AHCI_HOST_REG_CAP]        =3D "CAP",
+    [AHCI_HOST_REG_CTL]        =3D "GHC",
+    [AHCI_HOST_REG_IRQ_STAT]   =3D "IS",
+    [AHCI_HOST_REG_PORTS_IMPL] =3D "PI",
+    [AHCI_HOST_REG_VERSION]    =3D "VS",
+    [AHCI_HOST_REG_CCC_CTL]    =3D "CCC_CTL",
+    [AHCI_HOST_REG_CCC_PORTS]  =3D "CCC_PORTS",
+    [AHCI_HOST_REG_EM_LOC]     =3D "EM_LOC",
+    [AHCI_HOST_REG_EM_CTL]     =3D "EM_CTL",
+    [AHCI_HOST_REG_CAP2]       =3D "CAP2",
+    [AHCI_HOST_REG_BOHC]       =3D "BOHC",
+};
+
 static const char *AHCIPortReg_lookup[AHCI_PORT_REG__COUNT] =3D {
     [AHCI_PORT_REG_LST_ADDR]    =3D "PxCLB",
     [AHCI_PORT_REG_LST_ADDR_HI] =3D "PxCLBU",
diff --git a/hw/ide/ahci_internal.h b/hw/ide/ahci_internal.h
index db00c9aa39..af366db6f3 100644
--- a/hw/ide/ahci_internal.h
+++ b/hw/ide/ahci_internal.h
@@ -61,6 +61,21 @@
 #define HOST_PORTS_IMPL           0x0c /* bitmap of implemented ports */
 #define HOST_VERSION              0x10 /* AHCI spec. version compliancy =
*/
=20
+enum AHCIHostReg {
+    AHCI_HOST_REG_CAP        =3D 0,  /* CAP: host capabilities */
+    AHCI_HOST_REG_CTL        =3D 1,  /* GHC: global host control */
+    AHCI_HOST_REG_IRQ_STAT   =3D 2,  /* IS: interrupt status */
+    AHCI_HOST_REG_PORTS_IMPL =3D 3,  /* PI: bitmap of implemented ports =
*/
+    AHCI_HOST_REG_VERSION    =3D 4,  /* VS: AHCI spec. version complianc=
y */
+    AHCI_HOST_REG_CCC_CTL    =3D 5,  /* CCC_CTL: CCC Control */
+    AHCI_HOST_REG_CCC_PORTS  =3D 6,  /* CCC_PORTS: CCC Ports */
+    AHCI_HOST_REG_EM_LOC     =3D 7,  /* EM_LOC: Enclosure Mgmt Location =
*/
+    AHCI_HOST_REG_EM_CTL     =3D 8,  /* EM_CTL: Enclosure Mgmt Control *=
/
+    AHCI_HOST_REG_CAP2       =3D 9,  /* CAP2: host capabilities, extende=
d */
+    AHCI_HOST_REG_BOHC       =3D 10, /* BOHC: firmare/os handoff ctrl & =
status */
+    AHCI_HOST_REG__COUNT     =3D 11
+};
+
 /* HOST_CTL bits */
 #define HOST_CTL_RESET            (1 << 0)  /* reset controller; self-cl=
ear */
 #define HOST_CTL_IRQ_EN           (1 << 1)  /* global IRQ enable */
--=20
2.14.3
