Received: from eggs.gnu.org ([2001:4830:134:3::10]:47803)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1fRLUF-0002RX-5g
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 13:47:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1fRLUD-0001Zu-Nj
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 13:47:43 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:50436 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jsnow@redhat.com>) id 1fRLUD-0001ZF-Ig
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 13:47:41 -0400
From: John Snow <jsnow@redhat.com>
Date: Fri,  8 Jun 2018 13:47:17 -0400
Message-Id: <20180608174733.4936-15-jsnow@redhat.com>
In-Reply-To: <20180608174733.4936-1-jsnow@redhat.com>
References: <20180608174733.4936-1-jsnow@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 14/30] ahci: modify ahci_mem_read_32 to work on
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
Message-id: 20180531222835.16558-12-jsnow@redhat.com
Signed-off-by: John Snow <jsnow@redhat.com>
---
 hw/ide/ahci.c | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/hw/ide/ahci.c b/hw/ide/ahci.c
index 5be43ba2d0..99cbfe6447 100644
--- a/hw/ide/ahci.c
+++ b/hw/ide/ahci.c
@@ -386,22 +386,27 @@ static uint64_t ahci_mem_read_32(void *opaque, hwad=
dr addr)
     uint32_t val =3D 0;
=20
     if (addr < AHCI_GENERIC_HOST_CONTROL_REGS_MAX_ADDR) {
-        switch (addr) {
-        case HOST_CAP:
+        enum AHCIHostReg regnum =3D addr / 4;
+        assert(regnum < AHCI_HOST_REG__COUNT);
+
+        switch (regnum) {
+        case AHCI_HOST_REG_CAP:
             val =3D s->control_regs.cap;
             break;
-        case HOST_CTL:
+        case AHCI_HOST_REG_CTL:
             val =3D s->control_regs.ghc;
             break;
-        case HOST_IRQ_STAT:
+        case AHCI_HOST_REG_IRQ_STAT:
             val =3D s->control_regs.irqstatus;
             break;
-        case HOST_PORTS_IMPL:
+        case AHCI_HOST_REG_PORTS_IMPL:
             val =3D s->control_regs.impl;
             break;
-        case HOST_VERSION:
+        case AHCI_HOST_REG_VERSION:
             val =3D s->control_regs.version;
             break;
+        default:
+            break;
         }
     } else if ((addr >=3D AHCI_PORT_REGS_START_ADDR) &&
                (addr < (AHCI_PORT_REGS_START_ADDR +
--=20
2.14.3
