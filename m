Received: from eggs.gnu.org ([2001:4830:134:3::10]:47795)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1fRLUF-0002RS-4B
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 13:47:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1fRLUB-0001WZ-8C
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 13:47:43 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:49378 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jsnow@redhat.com>) id 1fRLUB-0001WD-2Z
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 13:47:39 -0400
From: John Snow <jsnow@redhat.com>
Date: Fri,  8 Jun 2018 13:47:08 -0400
Message-Id: <20180608174733.4936-6-jsnow@redhat.com>
In-Reply-To: <20180608174733.4936-1-jsnow@redhat.com>
References: <20180608174733.4936-1-jsnow@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 05/30] ahci: modify ahci_port_read to use
 register numbers
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
Message-id: 20180531222835.16558-3-jsnow@redhat.com
Signed-off-by: John Snow <jsnow@redhat.com>
---
 hw/ide/ahci.c | 38 +++++++++++++++++++-------------------
 1 file changed, 19 insertions(+), 19 deletions(-)

diff --git a/hw/ide/ahci.c b/hw/ide/ahci.c
index 9815a64b5a..fb0e5f1c12 100644
--- a/hw/ide/ahci.c
+++ b/hw/ide/ahci.c
@@ -93,41 +93,42 @@ static const char *AHCIPortIRQ_lookup[AHCI_PORT_IRQ__=
COUNT] =3D {
     [AHCI_PORT_IRQ_BIT_CPDS] =3D "CPDS"
 };
=20
-static uint32_t  ahci_port_read(AHCIState *s, int port, int offset)
+static uint32_t ahci_port_read(AHCIState *s, int port, int offset)
 {
     uint32_t val;
-    AHCIPortRegs *pr;
-    pr =3D &s->dev[port].port_regs;
+    AHCIPortRegs *pr =3D &s->dev[port].port_regs;
+    enum AHCIPortReg regnum =3D offset / sizeof(uint32_t);
+    assert(regnum < (AHCI_PORT_ADDR_OFFSET_LEN / sizeof(uint32_t)));
=20
-    switch (offset) {
-    case PORT_LST_ADDR:
+    switch (regnum) {
+    case AHCI_PORT_REG_LST_ADDR:
         val =3D pr->lst_addr;
         break;
-    case PORT_LST_ADDR_HI:
+    case AHCI_PORT_REG_LST_ADDR_HI:
         val =3D pr->lst_addr_hi;
         break;
-    case PORT_FIS_ADDR:
+    case AHCI_PORT_REG_FIS_ADDR:
         val =3D pr->fis_addr;
         break;
-    case PORT_FIS_ADDR_HI:
+    case AHCI_PORT_REG_FIS_ADDR_HI:
         val =3D pr->fis_addr_hi;
         break;
-    case PORT_IRQ_STAT:
+    case AHCI_PORT_REG_IRQ_STAT:
         val =3D pr->irq_stat;
         break;
-    case PORT_IRQ_MASK:
+    case AHCI_PORT_REG_IRQ_MASK:
         val =3D pr->irq_mask;
         break;
-    case PORT_CMD:
+    case AHCI_PORT_REG_CMD:
         val =3D pr->cmd;
         break;
-    case PORT_TFDATA:
+    case AHCI_PORT_REG_TFDATA:
         val =3D pr->tfdata;
         break;
-    case PORT_SIG:
+    case AHCI_PORT_REG_SIG:
         val =3D pr->sig;
         break;
-    case PORT_SCR_STAT:
+    case AHCI_PORT_REG_SCR_STAT:
         if (s->dev[port].port.ifs[0].blk) {
             val =3D SATA_SCR_SSTATUS_DET_DEV_PRESENT_PHY_UP |
                   SATA_SCR_SSTATUS_SPD_GEN1 | SATA_SCR_SSTATUS_IPM_ACTIV=
E;
@@ -135,19 +136,18 @@ static uint32_t  ahci_port_read(AHCIState *s, int p=
ort, int offset)
             val =3D SATA_SCR_SSTATUS_DET_NODEV;
         }
         break;
-    case PORT_SCR_CTL:
+    case AHCI_PORT_REG_SCR_CTL:
         val =3D pr->scr_ctl;
         break;
-    case PORT_SCR_ERR:
+    case AHCI_PORT_REG_SCR_ERR:
         val =3D pr->scr_err;
         break;
-    case PORT_SCR_ACT:
+    case AHCI_PORT_REG_SCR_ACT:
         val =3D pr->scr_act;
         break;
-    case PORT_CMD_ISSUE:
+    case AHCI_PORT_REG_CMD_ISSUE:
         val =3D pr->cmd_issue;
         break;
-    case PORT_RESERVED:
     default:
         val =3D 0;
     }
--=20
2.14.3
