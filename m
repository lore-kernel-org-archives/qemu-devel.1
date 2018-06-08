Received: from eggs.gnu.org ([2001:4830:134:3::10]:47814)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1fRLUF-0002Rb-7d
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 13:47:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1fRLUE-0001a8-0u
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 13:47:43 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:49382 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jsnow@redhat.com>) id 1fRLUD-0001Zg-RB
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 13:47:41 -0400
From: John Snow <jsnow@redhat.com>
Date: Fri,  8 Jun 2018 13:47:18 -0400
Message-Id: <20180608174733.4936-16-jsnow@redhat.com>
In-Reply-To: <20180608174733.4936-1-jsnow@redhat.com>
References: <20180608174733.4936-1-jsnow@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 15/30] ahci: make mem_read_32 traces more
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
Message-id: 20180531222835.16558-13-jsnow@redhat.com
Signed-off-by: John Snow <jsnow@redhat.com>
---
 hw/ide/ahci.c       | 7 +++++--
 hw/ide/trace-events | 3 +++
 2 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/hw/ide/ahci.c b/hw/ide/ahci.c
index 99cbfe6447..b31eb84aaa 100644
--- a/hw/ide/ahci.c
+++ b/hw/ide/ahci.c
@@ -47,7 +47,6 @@ static bool ahci_map_fis_address(AHCIDevice *ad);
 static void ahci_unmap_clb_address(AHCIDevice *ad);
 static void ahci_unmap_fis_address(AHCIDevice *ad);
=20
-__attribute__((__unused__)) /* TODO */
 static const char *AHCIHostReg_lookup[AHCI_HOST_REG__COUNT] =3D {
     [AHCI_HOST_REG_CAP]        =3D "CAP",
     [AHCI_HOST_REG_CTL]        =3D "GHC",
@@ -406,13 +405,17 @@ static uint64_t ahci_mem_read_32(void *opaque, hwad=
dr addr)
             val =3D s->control_regs.version;
             break;
         default:
-            break;
+            trace_ahci_mem_read_32_host_default(s, AHCIHostReg_lookup[re=
gnum],
+                                                addr);
         }
+        trace_ahci_mem_read_32_host(s, AHCIHostReg_lookup[regnum], addr,=
 val);
     } else if ((addr >=3D AHCI_PORT_REGS_START_ADDR) &&
                (addr < (AHCI_PORT_REGS_START_ADDR +
                 (s->ports * AHCI_PORT_ADDR_OFFSET_LEN)))) {
         val =3D ahci_port_read(s, (addr - AHCI_PORT_REGS_START_ADDR) >> =
7,
                              addr & AHCI_PORT_ADDR_OFFSET_MASK);
+    } else {
+        trace_ahci_mem_read_32_default(s, addr, val);
     }
=20
     trace_ahci_mem_read_32(s, addr, val);
diff --git a/hw/ide/trace-events b/hw/ide/trace-events
index 1efbbb8114..8149a54db8 100644
--- a/hw/ide/trace-events
+++ b/hw/ide/trace-events
@@ -72,6 +72,9 @@ ahci_trigger_irq(void *s, int port, const char *name, u=
int32_t val, uint32_t old
 ahci_port_write(void *s, int port, const char *reg, int offset, uint32_t=
 val) "ahci(%p)[%d]: port write [reg:%s] @ 0x%x: 0x%08x"
 ahci_port_write_unimpl(void *s, int port, const char *reg, int offset, u=
int32_t val) "ahci(%p)[%d]: unimplemented port write [reg:%s] @ 0x%x: 0x%=
08x"
 ahci_mem_read_32(void *s, uint64_t addr, uint32_t val) "ahci(%p): mem re=
ad @ 0x%"PRIx64": 0x%08x"
+ahci_mem_read_32_default(void *s, uint64_t addr, uint32_t val) "ahci(%p)=
: mem read @ 0x%"PRIx64": 0x%08x"
+ahci_mem_read_32_host(void *s, const char *reg, uint64_t addr, uint32_t =
val) "ahci(%p): mem read [reg:%s] @ 0x%"PRIx64": 0x%08x"
+ahci_mem_read_32_host_default(void *s, const char *reg, uint64_t addr) "=
ahci(%p): unimplemented mem read [reg:%s] @ 0x%"PRIx64
 ahci_mem_read(void *s, unsigned size, uint64_t addr, uint64_t val) "ahci=
(%p): read%u @ 0x%"PRIx64": 0x%016"PRIx64
 ahci_mem_write(void *s, unsigned size, uint64_t addr, uint64_t val) "ahc=
i(%p): write%u @ 0x%"PRIx64": 0x%016"PRIx64
 ahci_mem_write_unknown(void *s, unsigned size, uint64_t addr, uint64_t v=
al) "ahci(%p): write%u to unknown register 0x%"PRIx64": 0x%016"PRIx64
--=20
2.14.3
