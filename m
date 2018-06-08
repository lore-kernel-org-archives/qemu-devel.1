Received: from eggs.gnu.org ([2001:4830:134:3::10]:47800)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1fRLUF-0002RW-5c
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 13:47:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1fRLUB-0001Wx-Fi
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 13:47:43 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:50428 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jsnow@redhat.com>) id 1fRLUB-0001WU-At
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 13:47:39 -0400
From: John Snow <jsnow@redhat.com>
Date: Fri,  8 Jun 2018 13:47:09 -0400
Message-Id: <20180608174733.4936-7-jsnow@redhat.com>
In-Reply-To: <20180608174733.4936-1-jsnow@redhat.com>
References: <20180608174733.4936-1-jsnow@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 06/30] ahci: make port read traces more
 descriptive
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

A trace is added to let us watch unimplemented registers specifically,
as these are more likely to cause us trouble. Otherwise, the port read
traces now tell us what register is getting hit, which is nicer.

Signed-off-by: John Snow <jsnow@redhat.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Message-id: 20180531222835.16558-4-jsnow@redhat.com
Signed-off-by: John Snow <jsnow@redhat.com>
---
 hw/ide/ahci.c       | 5 +++--
 hw/ide/trace-events | 3 ++-
 2 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/hw/ide/ahci.c b/hw/ide/ahci.c
index fb0e5f1c12..1107a9b118 100644
--- a/hw/ide/ahci.c
+++ b/hw/ide/ahci.c
@@ -46,7 +46,6 @@ static bool ahci_map_fis_address(AHCIDevice *ad);
 static void ahci_unmap_clb_address(AHCIDevice *ad);
 static void ahci_unmap_fis_address(AHCIDevice *ad);
=20
-__attribute__((__unused__)) /* TODO */
 static const char *AHCIPortReg_lookup[AHCI_PORT_REG__COUNT] =3D {
     [AHCI_PORT_REG_LST_ADDR]    =3D "PxCLB",
     [AHCI_PORT_REG_LST_ADDR_HI] =3D "PxCLBU",
@@ -149,10 +148,12 @@ static uint32_t ahci_port_read(AHCIState *s, int po=
rt, int offset)
         val =3D pr->cmd_issue;
         break;
     default:
+        trace_ahci_port_read_default(s, port, AHCIPortReg_lookup[regnum]=
,
+                                     offset);
         val =3D 0;
     }
=20
-    trace_ahci_port_read(s, port, offset, val);
+    trace_ahci_port_read(s, port, AHCIPortReg_lookup[regnum], offset, va=
l);
     return val;
 }
=20
diff --git a/hw/ide/trace-events b/hw/ide/trace-events
index 5c0e59ec42..0db18d8271 100644
--- a/hw/ide/trace-events
+++ b/hw/ide/trace-events
@@ -63,7 +63,8 @@ ide_atapi_cmd_read_dma_cb_aio(void *s, int lba, int n) =
"IDEState: %p; aio read:
 ide_atapi_cmd_packet(void *s, uint16_t limit, const char *packet) "IDESt=
ate: %p; limit=3D0x%x packet: %s"
=20
 # hw/ide/ahci.c
-ahci_port_read(void *s, int port, int offset, uint32_t ret) "ahci(%p)[%d=
]: port read @ 0x%x: 0x%08x"
+ahci_port_read(void *s, int port, const char *reg, int offset, uint32_t =
ret) "ahci(%p)[%d]: port read [reg:%s] @ 0x%x: 0x%08x"
+ahci_port_read_default(void *s, int port, const char *reg, int offset) "=
ahci(%p)[%d]: unimplemented port read [reg:%s] @ 0x%x"
 ahci_irq_raise(void *s) "ahci(%p): raise irq"
 ahci_irq_lower(void *s) "ahci(%p): lower irq"
 ahci_check_irq(void *s, uint32_t old, uint32_t new) "ahci(%p): check irq=
 0x%08x --> 0x%08x"
--=20
2.14.3
