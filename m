Received: from eggs.gnu.org ([2001:4830:134:3::10]:47819)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1fRLUF-0002Rc-8g
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 13:47:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1fRLUC-0001Y8-9n
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 13:47:43 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:49488 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jsnow@redhat.com>) id 1fRLUC-0001XM-4N
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 13:47:40 -0400
From: John Snow <jsnow@redhat.com>
Date: Fri,  8 Jun 2018 13:47:12 -0400
Message-Id: <20180608174733.4936-10-jsnow@redhat.com>
In-Reply-To: <20180608174733.4936-1-jsnow@redhat.com>
References: <20180608174733.4936-1-jsnow@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 09/30] ahci: modify ahci_port_write to use
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
Message-id: 20180531222835.16558-7-jsnow@redhat.com
Signed-off-by: John Snow <jsnow@redhat.com>
---
 hw/ide/ahci.c | 32 +++++++++++++++++---------------
 1 file changed, 17 insertions(+), 15 deletions(-)

diff --git a/hw/ide/ahci.c b/hw/ide/ahci.c
index 2aea9c3e12..4e6f3f1514 100644
--- a/hw/ide/ahci.c
+++ b/hw/ide/ahci.c
@@ -282,30 +282,32 @@ static int ahci_cond_start_engines(AHCIDevice *ad)
 static void ahci_port_write(AHCIState *s, int port, int offset, uint32_t=
 val)
 {
     AHCIPortRegs *pr =3D &s->dev[port].port_regs;
+    enum AHCIPortReg regnum =3D offset / sizeof(uint32_t);
+    assert(regnum < (AHCI_PORT_ADDR_OFFSET_LEN / sizeof(uint32_t)));
=20
     trace_ahci_port_write(s, port, offset, val);
-    switch (offset) {
-    case PORT_LST_ADDR:
+    switch (regnum) {
+    case AHCI_PORT_REG_LST_ADDR:
         pr->lst_addr =3D val;
         break;
-    case PORT_LST_ADDR_HI:
+    case AHCI_PORT_REG_LST_ADDR_HI:
         pr->lst_addr_hi =3D val;
         break;
-    case PORT_FIS_ADDR:
+    case AHCI_PORT_REG_FIS_ADDR:
         pr->fis_addr =3D val;
         break;
-    case PORT_FIS_ADDR_HI:
+    case AHCI_PORT_REG_FIS_ADDR_HI:
         pr->fis_addr_hi =3D val;
         break;
-    case PORT_IRQ_STAT:
+    case AHCI_PORT_REG_IRQ_STAT:
         pr->irq_stat &=3D ~val;
         ahci_check_irq(s);
         break;
-    case PORT_IRQ_MASK:
+    case AHCI_PORT_REG_IRQ_MASK:
         pr->irq_mask =3D val & 0xfdc000ff;
         ahci_check_irq(s);
         break;
-    case PORT_CMD:
+    case AHCI_PORT_REG_CMD:
         /* Block any Read-only fields from being set;
          * including LIST_ON and FIS_ON.
          * The spec requires to set ICC bits to zero after the ICC chang=
e
@@ -329,26 +331,26 @@ static void ahci_port_write(AHCIState *s, int port,=
 int offset, uint32_t val)
=20
         check_cmd(s, port);
         break;
-    case PORT_TFDATA:
-    case PORT_SIG:
-    case PORT_SCR_STAT:
+    case AHCI_PORT_REG_TFDATA:
+    case AHCI_PORT_REG_SIG:
+    case AHCI_PORT_REG_SCR_STAT:
         /* Read Only */
         break;
-    case PORT_SCR_CTL:
+    case AHCI_PORT_REG_SCR_CTL:
         if (((pr->scr_ctl & AHCI_SCR_SCTL_DET) =3D=3D 1) &&
             ((val & AHCI_SCR_SCTL_DET) =3D=3D 0)) {
             ahci_reset_port(s, port);
         }
         pr->scr_ctl =3D val;
         break;
-    case PORT_SCR_ERR:
+    case AHCI_PORT_REG_SCR_ERR:
         pr->scr_err &=3D ~val;
         break;
-    case PORT_SCR_ACT:
+    case AHCI_PORT_REG_SCR_ACT:
         /* RW1 */
         pr->scr_act |=3D val;
         break;
-    case PORT_CMD_ISSUE:
+    case AHCI_PORT_REG_CMD_ISSUE:
         pr->cmd_issue |=3D val;
         check_cmd(s, port);
         break;
--=20
2.14.3
