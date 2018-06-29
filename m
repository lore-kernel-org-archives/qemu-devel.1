Received: from eggs.gnu.org ([2001:4830:134:3::10]:49772)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1fYxaj-0000LP-P4
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 13:53:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1fYxai-0000B2-Ta
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 13:53:53 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:40278 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1fYxai-0000Ar-OP
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 13:53:52 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
Date: Fri, 29 Jun 2018 18:53:28 +0100
Message-Id: <20180629175330.19391-10-stefanha@redhat.com>
In-Reply-To: <20180629175330.19391-1-stefanha@redhat.com>
References: <20180629175330.19391-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 09/11] hw/net/etraxfs_eth: Convert printf()
 calls to trace events
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

Suggested-by: Alistair Francis <alistair@alistair23.me>
Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 hw/net/etraxfs_eth.c | 8 ++++----
 hw/net/trace-events  | 5 +++++
 2 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/hw/net/etraxfs_eth.c b/hw/net/etraxfs_eth.c
index 013c8d0a41..a6932432b1 100644
--- a/hw/net/etraxfs_eth.c
+++ b/hw/net/etraxfs_eth.c
@@ -27,6 +27,7 @@
 #include "net/net.h"
 #include "hw/cris/etraxfs.h"
 #include "qemu/error-report.h"
+#include "trace.h"
=20
 #define D(x)
=20
@@ -106,7 +107,7 @@ static unsigned int tdk_read(struct qemu_phy *phy, un=
signed int req)
         r =3D phy->regs[regnum];
         break;
     }
-    D(printf("\n%s %x =3D reg[%d]\n", __func__, r, regnum));
+    trace_mdio_phy_read(regnum, r);
     return r;
 }
=20
@@ -116,7 +117,7 @@ tdk_write(struct qemu_phy *phy, unsigned int req, uns=
igned int data)
     int regnum;
=20
     regnum =3D req & 0x1f;
-    D(printf("%s reg[%d] =3D %x\n", __func__, regnum, data));
+    trace_mdio_phy_write(regnum, data);
     switch (regnum) {
     default:
         phy->regs[regnum] =3D data;
@@ -206,8 +207,7 @@ static void mdio_cycle(struct qemu_mdio *bus)
 {
     bus->cnt++;
=20
-    D(printf("mdc=3D%d mdio=3D%d state=3D%d cnt=3D%d drv=3D%d\n",
-        bus->mdc, bus->mdio, bus->state, bus->cnt, bus->drive));
+    trace_mdio_bitbang(bus->mdc, bus->mdio, bus->state, bus->cnt, bus->d=
rive);
 #if 0
     if (bus->mdc) {
         printf("%d", bus->mdio);
diff --git a/hw/net/trace-events b/hw/net/trace-events
index f57010df37..663bea1b74 100644
--- a/hw/net/trace-events
+++ b/hw/net/trace-events
@@ -1,5 +1,10 @@
 # See docs/devel/tracing.txt for syntax documentation.
=20
+# hw/net/etraxfs_eth.c
+mdio_phy_read(int regnum, uint16_t value) "read phy_reg:%d value:0x%04x"
+mdio_phy_write(int regnum, uint16_t value) "write phy_reg:%d value:0x%04=
x"
+mdio_bitbang(bool mdc, bool mdio, int state, uint16_t cnt, unsigned int =
drive) "bitbang mdc=3D%u mdio=3D%u state=3D%d cnt=3D%u drv=3D%d"
+
 # hw/net/lance.c
 lance_mem_readw(uint64_t addr, uint32_t ret) "addr=3D0x%"PRIx64"val=3D0x=
%04x"
 lance_mem_writew(uint64_t addr, uint32_t val) "addr=3D0x%"PRIx64"val=3D0=
x%04x"
--=20
2.17.1
