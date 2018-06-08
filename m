Received: from eggs.gnu.org ([2001:4830:134:3::10]:47796)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1fRLUF-0002RT-4I
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 13:47:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1fRLUA-0001WK-Us
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 13:47:43 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:49482 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jsnow@redhat.com>) id 1fRLUA-0001Vv-Px
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 13:47:38 -0400
From: John Snow <jsnow@redhat.com>
Date: Fri,  8 Jun 2018 13:47:07 -0400
Message-Id: <20180608174733.4936-5-jsnow@redhat.com>
In-Reply-To: <20180608174733.4936-1-jsnow@redhat.com>
References: <20180608174733.4936-1-jsnow@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 04/30] ahci: add port register enumeration
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

Instead of tracking offsets, lets count the registers.

Signed-off-by: John Snow <jsnow@redhat.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Message-id: 20180531222835.16558-2-jsnow@redhat.com
Signed-off-by: John Snow <jsnow@redhat.com>
---
 hw/ide/ahci.c          | 25 +++++++++++++++++++++++++
 hw/ide/ahci_internal.h | 29 +++++++++++++++++++++++++++++
 2 files changed, 54 insertions(+)

diff --git a/hw/ide/ahci.c b/hw/ide/ahci.c
index ac4bc1738b..9815a64b5a 100644
--- a/hw/ide/ahci.c
+++ b/hw/ide/ahci.c
@@ -46,6 +46,31 @@ static bool ahci_map_fis_address(AHCIDevice *ad);
 static void ahci_unmap_clb_address(AHCIDevice *ad);
 static void ahci_unmap_fis_address(AHCIDevice *ad);
=20
+__attribute__((__unused__)) /* TODO */
+static const char *AHCIPortReg_lookup[AHCI_PORT_REG__COUNT] =3D {
+    [AHCI_PORT_REG_LST_ADDR]    =3D "PxCLB",
+    [AHCI_PORT_REG_LST_ADDR_HI] =3D "PxCLBU",
+    [AHCI_PORT_REG_FIS_ADDR]    =3D "PxFB",
+    [AHCI_PORT_REG_FIS_ADDR_HI] =3D "PxFBU",
+    [AHCI_PORT_REG_IRQ_STAT]    =3D "PxIS",
+    [AHCI_PORT_REG_IRQ_MASK]    =3D "PXIE",
+    [AHCI_PORT_REG_CMD]         =3D "PxCMD",
+    [7]                         =3D "Reserved",
+    [AHCI_PORT_REG_TFDATA]      =3D "PxTFD",
+    [AHCI_PORT_REG_SIG]         =3D "PxSIG",
+    [AHCI_PORT_REG_SCR_STAT]    =3D "PxSSTS",
+    [AHCI_PORT_REG_SCR_CTL]     =3D "PxSCTL",
+    [AHCI_PORT_REG_SCR_ERR]     =3D "PxSERR",
+    [AHCI_PORT_REG_SCR_ACT]     =3D "PxSACT",
+    [AHCI_PORT_REG_CMD_ISSUE]   =3D "PxCI",
+    [AHCI_PORT_REG_SCR_NOTIF]   =3D "PxSNTF",
+    [AHCI_PORT_REG_FIS_CTL]     =3D "PxFBS",
+    [AHCI_PORT_REG_DEV_SLEEP]   =3D "PxDEVSLP",
+    [18 ... 27]                 =3D "Reserved",
+    [AHCI_PORT_REG_VENDOR_1 ...
+     AHCI_PORT_REG_VENDOR_4]    =3D "PxVS",
+};
+
 static const char *AHCIPortIRQ_lookup[AHCI_PORT_IRQ__COUNT] =3D {
     [AHCI_PORT_IRQ_BIT_DHRS] =3D "DHRS",
     [AHCI_PORT_IRQ_BIT_PSS]  =3D "PSS",
diff --git a/hw/ide/ahci_internal.h b/hw/ide/ahci_internal.h
index 1a25d6c039..eb7e1eefc0 100644
--- a/hw/ide/ahci_internal.h
+++ b/hw/ide/ahci_internal.h
@@ -74,6 +74,34 @@
 #define HOST_CAP_NCQ              (1 << 30) /* Native Command Queueing *=
/
 #define HOST_CAP_64               (1U << 31) /* PCI DAC (64-bit DMA) sup=
port */
=20
+/* registers for each SATA port */
+enum AHCIPortReg {
+    AHCI_PORT_REG_LST_ADDR    =3D 0, /* PxCLB: command list DMA addr */
+    AHCI_PORT_REG_LST_ADDR_HI =3D 1, /* PxCLBU: command list DMA addr hi=
 */
+    AHCI_PORT_REG_FIS_ADDR    =3D 2, /* PxFB: FIS rx buf addr */
+    AHCI_PORT_REG_FIS_ADDR_HI =3D 3, /* PxFBU: FIX rx buf addr hi */
+    AHCI_PORT_REG_IRQ_STAT    =3D 4, /* PxIS: interrupt status */
+    AHCI_PORT_REG_IRQ_MASK    =3D 5, /* PxIE: interrupt enable/disable m=
ask */
+    AHCI_PORT_REG_CMD         =3D 6, /* PxCMD: port command */
+    /* RESERVED */
+    AHCI_PORT_REG_TFDATA      =3D 8, /* PxTFD: taskfile data */
+    AHCI_PORT_REG_SIG         =3D 9, /* PxSIG: device TF signature */
+    AHCI_PORT_REG_SCR_STAT    =3D 10, /* PxSSTS: SATA phy register: SSta=
tus */
+    AHCI_PORT_REG_SCR_CTL     =3D 11, /* PxSCTL: SATA phy register: SCon=
trol */
+    AHCI_PORT_REG_SCR_ERR     =3D 12, /* PxSERR: SATA phy register: SErr=
or */
+    AHCI_PORT_REG_SCR_ACT     =3D 13, /* PxSACT: SATA phy register: SAct=
ive */
+    AHCI_PORT_REG_CMD_ISSUE   =3D 14, /* PxCI: command issue */
+    AHCI_PORT_REG_SCR_NOTIF   =3D 15, /* PxSNTF: SATA phy register: SNot=
ification */
+    AHCI_PORT_REG_FIS_CTL     =3D 16, /* PxFBS: Port multiplier switchin=
g ctl */
+    AHCI_PORT_REG_DEV_SLEEP   =3D 17, /* PxDEVSLP: device sleep control =
*/
+    /* RESERVED */
+    AHCI_PORT_REG_VENDOR_1    =3D 28, /* PxVS: Vendor Specific */
+    AHCI_PORT_REG_VENDOR_2    =3D 29,
+    AHCI_PORT_REG_VENDOR_3    =3D 30,
+    AHCI_PORT_REG_VENDOR_4    =3D 31,
+    AHCI_PORT_REG__COUNT      =3D 32
+};
+
 /* registers for each SATA port */
 #define PORT_LST_ADDR             0x00 /* command list DMA addr */
 #define PORT_LST_ADDR_HI          0x04 /* command list DMA addr hi */
@@ -82,6 +110,7 @@
 #define PORT_IRQ_STAT             0x10 /* interrupt status */
 #define PORT_IRQ_MASK             0x14 /* interrupt enable/disable mask =
*/
 #define PORT_CMD                  0x18 /* port command */
+
 #define PORT_TFDATA               0x20 /* taskfile data */
 #define PORT_SIG                  0x24 /* device TF signature */
 #define PORT_SCR_STAT             0x28 /* SATA phy register: SStatus */
--=20
2.14.3
