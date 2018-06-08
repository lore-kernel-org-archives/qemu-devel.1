Received: from eggs.gnu.org ([2001:4830:134:3::10]:47918)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1fRLUH-0002St-Tt
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 13:47:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1fRLUF-0001bo-Da
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 13:47:45 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:50442 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jsnow@redhat.com>) id 1fRLUE-0001am-Uk
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 13:47:43 -0400
From: John Snow <jsnow@redhat.com>
Date: Fri,  8 Jun 2018 13:47:22 -0400
Message-Id: <20180608174733.4936-20-jsnow@redhat.com>
In-Reply-To: <20180608174733.4936-1-jsnow@redhat.com>
References: <20180608174733.4936-1-jsnow@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 19/30] ahci: make ahci_mem_write traces more
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
Message-id: 20180531222835.16558-17-jsnow@redhat.com
[Fixed format specifiers. --js]
Signed-off-by: John Snow <jsnow@redhat.com>
---
 hw/ide/ahci.c       | 15 ++++++++++++++-
 hw/ide/trace-events |  4 +++-
 2 files changed, 17 insertions(+), 2 deletions(-)

diff --git a/hw/ide/ahci.c b/hw/ide/ahci.c
index e4e87351c9..571e32dd66 100644
--- a/hw/ide/ahci.c
+++ b/hw/ide/ahci.c
@@ -494,13 +494,26 @@ static void ahci_mem_write(void *opaque, hwaddr add=
r,
             /* FIXME report write? */
             break;
         default:
-            trace_ahci_mem_write_unknown(s, size, addr, val);
+            qemu_log_mask(LOG_UNIMP,
+                          "Attempted write to unimplemented register: "
+                          "AHCI host register %s, "
+                          "offset 0x%"PRIx64": 0x%"PRIx64,
+                          AHCIHostReg_lookup[regnum], addr, val);
+            trace_ahci_mem_write_host_unimpl(s, size,
+                                             AHCIHostReg_lookup[regnum],=
 addr);
         }
+        trace_ahci_mem_write_host(s, size, AHCIHostReg_lookup[regnum],
+                                     addr, val);
     } else if ((addr >=3D AHCI_PORT_REGS_START_ADDR) &&
                (addr < (AHCI_PORT_REGS_START_ADDR +
                         (s->ports * AHCI_PORT_ADDR_OFFSET_LEN)))) {
         ahci_port_write(s, (addr - AHCI_PORT_REGS_START_ADDR) >> 7,
                         addr & AHCI_PORT_ADDR_OFFSET_MASK, val);
+    } else {
+        qemu_log_mask(LOG_UNIMP, "Attempted write to unimplemented regis=
ter: "
+                      "AHCI global register at offset 0x%"PRIx64": 0x%"P=
RIx64,
+                      addr, val);
+        trace_ahci_mem_write_unimpl(s, size, addr, val);
     }
 }
=20
diff --git a/hw/ide/trace-events b/hw/ide/trace-events
index 8149a54db8..e6bd95f52f 100644
--- a/hw/ide/trace-events
+++ b/hw/ide/trace-events
@@ -77,7 +77,9 @@ ahci_mem_read_32_host(void *s, const char *reg, uint64_=
t addr, uint32_t val) "ah
 ahci_mem_read_32_host_default(void *s, const char *reg, uint64_t addr) "=
ahci(%p): unimplemented mem read [reg:%s] @ 0x%"PRIx64
 ahci_mem_read(void *s, unsigned size, uint64_t addr, uint64_t val) "ahci=
(%p): read%u @ 0x%"PRIx64": 0x%016"PRIx64
 ahci_mem_write(void *s, unsigned size, uint64_t addr, uint64_t val) "ahc=
i(%p): write%u @ 0x%"PRIx64": 0x%016"PRIx64
-ahci_mem_write_unknown(void *s, unsigned size, uint64_t addr, uint64_t v=
al) "ahci(%p): write%u to unknown register 0x%"PRIx64": 0x%016"PRIx64
+ahci_mem_write_host_unimpl(void *s, unsigned size, const char *reg, uint=
64_t addr) "ahci(%p) unimplemented write%u [reg:%s] @ 0x%"PRIx64
+ahci_mem_write_host(void *s, unsigned size, const char *reg, uint64_t ad=
dr, uint64_t val) "ahci(%p) write%u [reg:%s] @ 0x%"PRIx64": 0x%016"PRIx64
+ahci_mem_write_unimpl(void *s, unsigned size, uint64_t addr, uint64_t va=
l) "ahci(%p): write%u to unknown register 0x%"PRIx64": 0x%016"PRIx64
 ahci_set_signature(void *s, int port, uint8_t nsector, uint8_t sector, u=
int8_t lcyl, uint8_t hcyl, uint32_t sig) "ahci(%p)[%d]: set signature sec=
tor:0x%02x nsector:0x%02x lcyl:0x%02x hcyl:0x%02x (cumulatively: 0x%08x)"
 ahci_reset_port(void *s, int port) "ahci(%p)[%d]: reset port"
 ahci_unmap_fis_address_null(void *s, int port) "ahci(%p)[%d]: Attempt to=
 unmap NULL FIS address"
--=20
2.14.3
