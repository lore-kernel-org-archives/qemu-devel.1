Received: from eggs.gnu.org ([2001:4830:134:3::10]:38022)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cgQVB-00038D-Bi
	for qemu-devel@nongnu.org; Wed, 22 Feb 2017 01:34:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cgQV8-00089e-H2
	for qemu-devel@nongnu.org; Wed, 22 Feb 2017 01:34:13 -0500
From: David Gibson <david@gibson.dropbear.id.au>
Date: Wed, 22 Feb 2017 17:33:24 +1100
Message-Id: <20170222063348.32176-20-david@gibson.dropbear.id.au>
In-Reply-To: <20170222063348.32176-1-david@gibson.dropbear.id.au>
References: <20170222063348.32176-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 19/43] mac99: replace debug printf with trace
 points
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: agraf@suse.de, thuth@redhat.com, lvivier@redhat.com, qemu-devel@nongnu.org, qemu-ppc@nongnu.org, mdroth@linux.vnet.ibm.com, imammedo@redhat.com, David Gibson <david@gibson.dropbear.id.au>

From: Laurent Vivier <lvivier@redhat.com>

Signed-off-by: Laurent Vivier <lvivier@redhat.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/ppc/mac_newworld.c | 15 +++------------
 hw/ppc/trace-events   |  4 ++++
 2 files changed, 7 insertions(+), 12 deletions(-)

diff --git a/hw/ppc/mac_newworld.c b/hw/ppc/mac_newworld.c
index 716aea6..68aaedc 100644
--- a/hw/ppc/mac_newworld.c
+++ b/hw/ppc/mac_newworld.c
@@ -72,6 +72,7 @@
 #include "exec/address-spaces.h"
 #include "hw/sysbus.h"
 #include "qemu/cutils.h"
+#include "trace.h"
=20
 #define MAX_IDE_BUS 2
 #define CFG_ADDR 0xf0000510
@@ -79,21 +80,11 @@
 #define CLOCKFREQ (266UL * 1000UL * 1000UL)
 #define BUSFREQ (100UL * 1000UL * 1000UL)
=20
-/* debug UniNorth */
-//#define DEBUG_UNIN
-
-#ifdef DEBUG_UNIN
-#define UNIN_DPRINTF(fmt, ...)                                  \
-    do { printf("UNIN: " fmt , ## __VA_ARGS__); } while (0)
-#else
-#define UNIN_DPRINTF(fmt, ...)
-#endif
-
 /* UniN device */
 static void unin_write(void *opaque, hwaddr addr, uint64_t value,
                        unsigned size)
 {
-    UNIN_DPRINTF("write addr " TARGET_FMT_plx " val %"PRIx64"\n", addr, =
value);
+    trace_mac99_uninorth_write(addr, value);
     if (addr =3D=3D 0x0) {
         *(int*)opaque =3D value;
     }
@@ -109,7 +100,7 @@ static uint64_t unin_read(void *opaque, hwaddr addr, =
unsigned size)
         value =3D *(int*)opaque;
     }
=20
-    UNIN_DPRINTF("readl addr " TARGET_FMT_plx " val %x\n", addr, value);
+    trace_mac99_uninorth_read(addr, value);
=20
     return value;
 }
diff --git a/hw/ppc/trace-events b/hw/ppc/trace-events
index f46995c..6122a12 100644
--- a/hw/ppc/trace-events
+++ b/hw/ppc/trace-events
@@ -85,3 +85,7 @@ rs6000mc_presence_read(uint32_t addr, uint32_t val) "re=
ad addr=3D%x val=3D%x"
 rs6000mc_size_read(uint32_t addr, uint32_t val) "read addr=3D%x val=3D%x=
"
 rs6000mc_size_write(uint32_t addr, uint32_t val) "write addr=3D%x val=3D=
%x"
 rs6000mc_parity_read(uint32_t addr, uint32_t val) "read addr=3D%x val=3D=
%x"
+
+# hw/ppc/mac_newworld.c
+mac99_uninorth_write(uint64_t addr, uint64_t value) "addr=3D0x%" PRIx64 =
" val=3D0x%"PRIx64
+mac99_uninorth_read(uint64_t addr, uint64_t value) "addr=3D0x%" PRIx64 "=
 val=3D0x%"PRIx64
--=20
2.9.3
