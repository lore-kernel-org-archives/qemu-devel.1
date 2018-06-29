Received: from eggs.gnu.org ([2001:4830:134:3::10]:49744)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1fYxag-0000JA-Eq
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 13:53:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1fYxac-0008Vo-TL
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 13:53:50 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:40258 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1fYxac-0008VP-Nk
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 13:53:46 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
Date: Fri, 29 Jun 2018 18:53:26 +0100
Message-Id: <20180629175330.19391-8-stefanha@redhat.com>
In-Reply-To: <20180629175330.19391-1-stefanha@redhat.com>
References: <20180629175330.19391-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 07/11] hw/net/ne2000: Add trace events
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Markus Armbruster <armbru@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>, Peter Maydell <peter.maydell@linaro.org>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Juan Quintela <quintela@redhat.com>, Richard Henderson <rth@twiddle.net>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>

From: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 hw/net/ne2000.c     | 17 ++++++++++++-----
 hw/net/trace-events |  4 ++++
 2 files changed, 16 insertions(+), 5 deletions(-)

diff --git a/hw/net/ne2000.c b/hw/net/ne2000.c
index 3a9fc89e48..26b234b7eb 100644
--- a/hw/net/ne2000.c
+++ b/hw/net/ne2000.c
@@ -26,6 +26,7 @@
 #include "net/eth.h"
 #include "ne2000.h"
 #include "sysemu/sysemu.h"
+#include "trace.h"
=20
 /* debug NE2000 card */
 //#define DEBUG_NE2000
@@ -662,19 +663,24 @@ static uint64_t ne2000_read(void *opaque, hwaddr ad=
dr,
                             unsigned size)
 {
     NE2000State *s =3D opaque;
+    uint64_t val;
=20
     if (addr < 0x10 && size =3D=3D 1) {
-        return ne2000_ioport_read(s, addr);
+        val =3D ne2000_ioport_read(s, addr);
     } else if (addr =3D=3D 0x10) {
         if (size <=3D 2) {
-            return ne2000_asic_ioport_read(s, addr);
+            val =3D ne2000_asic_ioport_read(s, addr);
         } else {
-            return ne2000_asic_ioport_readl(s, addr);
+            val =3D ne2000_asic_ioport_readl(s, addr);
         }
     } else if (addr =3D=3D 0x1f && size =3D=3D 1) {
-        return ne2000_reset_ioport_read(s, addr);
+        val =3D ne2000_reset_ioport_read(s, addr);
+    } else {
+        val =3D ((uint64_t)1 << (size * 8)) - 1;
     }
-    return ((uint64_t)1 << (size * 8)) - 1;
+    trace_ne2000_read(addr, val);
+
+    return val;
 }
=20
 static void ne2000_write(void *opaque, hwaddr addr,
@@ -682,6 +688,7 @@ static void ne2000_write(void *opaque, hwaddr addr,
 {
     NE2000State *s =3D opaque;
=20
+    trace_ne2000_write(addr, data);
     if (addr < 0x10 && size =3D=3D 1) {
         ne2000_ioport_write(s, addr, data);
     } else if (addr =3D=3D 0x10) {
diff --git a/hw/net/trace-events b/hw/net/trace-events
index 45c4e9fba0..95a1de01e9 100644
--- a/hw/net/trace-events
+++ b/hw/net/trace-events
@@ -23,6 +23,10 @@ mipsnet_read(uint64_t addr, uint32_t val) "read addr=3D=
0x%" PRIx64 " val=3D0x%x"
 mipsnet_write(uint64_t addr, uint64_t val) "write addr=3D0x%" PRIx64 " v=
al=3D0x%" PRIx64
 mipsnet_irq(uint32_t isr, uint32_t intctl) "set irq to %d (0x%02x)"
=20
+# hw/net/ne2000.c
+ne2000_read(uint64_t addr, uint64_t val) "read addr=3D0x%" PRIx64 " val=3D=
0x%" PRIx64
+ne2000_write(uint64_t addr, uint64_t val) "write addr=3D0x%" PRIx64 " va=
l=3D0x%" PRIx64
+
 # hw/net/opencores_eth.c
 open_eth_mii_write(unsigned idx, uint16_t v) "MII[0x%02x] <- 0x%04x"
 open_eth_mii_read(unsigned idx, uint16_t v) "MII[0x%02x] -> 0x%04x"
--=20
2.17.1
