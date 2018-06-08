Received: from eggs.gnu.org ([2001:4830:134:3::10]:47807)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1fRLUF-0002RZ-7Q
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 13:47:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1fRLUC-0001YH-HE
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 13:47:43 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:58030 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jsnow@redhat.com>) id 1fRLUC-0001Xt-C2
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 13:47:40 -0400
From: John Snow <jsnow@redhat.com>
Date: Fri,  8 Jun 2018 13:47:13 -0400
Message-Id: <20180608174733.4936-11-jsnow@redhat.com>
In-Reply-To: <20180608174733.4936-1-jsnow@redhat.com>
References: <20180608174733.4936-1-jsnow@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 10/30] ahci: make port write traces more
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

Signed-off-by: John Snow <jsnow@redhat.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Message-id: 20180531222835.16558-8-jsnow@redhat.com
[Changed format specifier. --js]
Signed-off-by: John Snow <jsnow@redhat.com>
---
 hw/ide/ahci.c       | 8 +++++++-
 hw/ide/trace-events | 3 ++-
 2 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/hw/ide/ahci.c b/hw/ide/ahci.c
index 4e6f3f1514..a85847b165 100644
--- a/hw/ide/ahci.c
+++ b/hw/ide/ahci.c
@@ -27,6 +27,7 @@
 #include "hw/pci/pci.h"
=20
 #include "qemu/error-report.h"
+#include "qemu/log.h"
 #include "sysemu/block-backend.h"
 #include "sysemu/dma.h"
 #include "hw/ide/internal.h"
@@ -284,8 +285,8 @@ static void ahci_port_write(AHCIState *s, int port, i=
nt offset, uint32_t val)
     AHCIPortRegs *pr =3D &s->dev[port].port_regs;
     enum AHCIPortReg regnum =3D offset / sizeof(uint32_t);
     assert(regnum < (AHCI_PORT_ADDR_OFFSET_LEN / sizeof(uint32_t)));
+    trace_ahci_port_write(s, port, AHCIPortReg_lookup[regnum], offset, v=
al);
=20
-    trace_ahci_port_write(s, port, offset, val);
     switch (regnum) {
     case AHCI_PORT_REG_LST_ADDR:
         pr->lst_addr =3D val;
@@ -355,6 +356,11 @@ static void ahci_port_write(AHCIState *s, int port, =
int offset, uint32_t val)
         check_cmd(s, port);
         break;
     default:
+        trace_ahci_port_write_unimpl(s, port, AHCIPortReg_lookup[regnum]=
,
+                                     offset, val);
+        qemu_log_mask(LOG_UNIMP, "Attempted write to unimplemented regis=
ter: "
+                      "AHCI port %d register %s, offset 0x%x: 0x%"PRIx32=
,
+                      port, AHCIPortReg_lookup[regnum], offset, val);
         break;
     }
 }
diff --git a/hw/ide/trace-events b/hw/ide/trace-events
index 0db18d8271..1efbbb8114 100644
--- a/hw/ide/trace-events
+++ b/hw/ide/trace-events
@@ -69,7 +69,8 @@ ahci_irq_raise(void *s) "ahci(%p): raise irq"
 ahci_irq_lower(void *s) "ahci(%p): lower irq"
 ahci_check_irq(void *s, uint32_t old, uint32_t new) "ahci(%p): check irq=
 0x%08x --> 0x%08x"
 ahci_trigger_irq(void *s, int port, const char *name, uint32_t val, uint=
32_t old, uint32_t new, uint32_t effective) "ahci(%p)[%d]: trigger irq +%=
s (0x%08x); irqstat: 0x%08x --> 0x%08x; effective: 0x%08x"
-ahci_port_write(void *s, int port, int offset, uint32_t val) "ahci(%p)[%=
d]: port write @ 0x%x: 0x%08x"
+ahci_port_write(void *s, int port, const char *reg, int offset, uint32_t=
 val) "ahci(%p)[%d]: port write [reg:%s] @ 0x%x: 0x%08x"
+ahci_port_write_unimpl(void *s, int port, const char *reg, int offset, u=
int32_t val) "ahci(%p)[%d]: unimplemented port write [reg:%s] @ 0x%x: 0x%=
08x"
 ahci_mem_read_32(void *s, uint64_t addr, uint32_t val) "ahci(%p): mem re=
ad @ 0x%"PRIx64": 0x%08x"
 ahci_mem_read(void *s, unsigned size, uint64_t addr, uint64_t val) "ahci=
(%p): read%u @ 0x%"PRIx64": 0x%016"PRIx64
 ahci_mem_write(void *s, unsigned size, uint64_t addr, uint64_t val) "ahc=
i(%p): write%u @ 0x%"PRIx64": 0x%016"PRIx64
--=20
2.14.3
