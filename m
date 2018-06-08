Received: from eggs.gnu.org ([2001:4830:134:3::10]:47829)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1fRLUF-0002Ri-V5
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 13:47:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1fRLUE-0001ac-H7
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 13:47:43 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:49496 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jsnow@redhat.com>) id 1fRLUE-0001aF-CW
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 13:47:42 -0400
From: John Snow <jsnow@redhat.com>
Date: Fri,  8 Jun 2018 13:47:20 -0400
Message-Id: <20180608174733.4936-18-jsnow@redhat.com>
In-Reply-To: <20180608174733.4936-1-jsnow@redhat.com>
References: <20180608174733.4936-1-jsnow@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 17/30] ahci: adjust ahci_mem_write to work on
 registers
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

Actually, this function looks pretty broken, but for now, let's finish
up what this series of commits came here to do.

Signed-off-by: John Snow <jsnow@redhat.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Message-id: 20180531222835.16558-15-jsnow@redhat.com
Signed-off-by: John Snow <jsnow@redhat.com>
---
 hw/ide/ahci.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/hw/ide/ahci.c b/hw/ide/ahci.c
index 51c3e96c80..e4e87351c9 100644
--- a/hw/ide/ahci.c
+++ b/hw/ide/ahci.c
@@ -468,11 +468,14 @@ static void ahci_mem_write(void *opaque, hwaddr add=
r,
     }
=20
     if (addr < AHCI_GENERIC_HOST_CONTROL_REGS_MAX_ADDR) {
-        switch (addr) {
-        case HOST_CAP: /* R/WO, RO */
+        enum AHCIHostReg regnum =3D addr / 4;
+        assert(regnum < AHCI_HOST_REG__COUNT);
+
+        switch (regnum) {
+        case AHCI_HOST_REG_CAP: /* R/WO, RO */
             /* FIXME handle R/WO */
             break;
-        case HOST_CTL: /* R/W */
+        case AHCI_HOST_REG_CTL: /* R/W */
             if (val & HOST_CTL_RESET) {
                 ahci_reset(s);
             } else {
@@ -480,14 +483,14 @@ static void ahci_mem_write(void *opaque, hwaddr add=
r,
                 ahci_check_irq(s);
             }
             break;
-        case HOST_IRQ_STAT: /* R/WC, RO */
+        case AHCI_HOST_REG_IRQ_STAT: /* R/WC, RO */
             s->control_regs.irqstatus &=3D ~val;
             ahci_check_irq(s);
             break;
-        case HOST_PORTS_IMPL: /* R/WO, RO */
+        case AHCI_HOST_REG_PORTS_IMPL: /* R/WO, RO */
             /* FIXME handle R/WO */
             break;
-        case HOST_VERSION: /* RO */
+        case AHCI_HOST_REG_VERSION: /* RO */
             /* FIXME report write? */
             break;
         default:
--=20
2.14.3
