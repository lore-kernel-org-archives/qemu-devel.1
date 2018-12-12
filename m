Received: from eggs.gnu.org ([2001:4830:134:3::10]:35122)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lvivier@redhat.com>) id 1gX8LB-0006yW-IW
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 12:30:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lvivier@redhat.com>) id 1gX8L9-000199-Fu
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 12:30:33 -0500
From: Laurent Vivier <lvivier@redhat.com>
Date: Wed, 12 Dec 2018 18:30:04 +0100
Message-Id: <20181212173007.11407-4-lvivier@redhat.com>
In-Reply-To: <20181212173007.11407-1-lvivier@redhat.com>
References: <20181212173007.11407-1-lvivier@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 3/6] hw/dma/puv3_intc: Convert from DPRINTF()
 macro to trace event
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-trivial@nongnu.org, Guan Xuetao <gxt@mprc.pku.edu.cn>, Michael Tokarev <mjt@tls.msk.ru>, Laurent Vivier <lvivier@redhat.com>

Signed-off-by: Laurent Vivier <lvivier@redhat.com>
---
 hw/intc/puv3_intc.c  | 13 ++++++-------
 hw/intc/trace-events |  7 +++++++
 2 files changed, 13 insertions(+), 7 deletions(-)

diff --git a/hw/intc/puv3_intc.c b/hw/intc/puv3_intc.c
index ef8488aacc..6c1f36bba6 100644
--- a/hw/intc/puv3_intc.c
+++ b/hw/intc/puv3_intc.c
@@ -10,9 +10,8 @@
  */
 #include "qemu/osdep.h"
 #include "hw/sysbus.h"
-
-#undef DEBUG_PUV3
 #include "hw/unicore32/puv3.h"
+#include "trace.h"
=20
 #define TYPE_PUV3_INTC "puv3_intc"
 #define PUV3_INTC(obj) OBJECT_CHECK(PUV3INTCState, (obj), TYPE_PUV3_INTC=
)
@@ -42,7 +41,7 @@ static void puv3_intc_handler(void *opaque, int irq, in=
t level)
 {
     PUV3INTCState *s =3D opaque;
=20
-    DPRINTF("irq 0x%x, level 0x%x\n", irq, level);
+    trace_puv3_intc_handler(irq, level);
     if (level) {
         s->reg_ICPR |=3D (1 << irq);
     } else {
@@ -65,9 +64,9 @@ static uint64_t puv3_intc_read(void *opaque, hwaddr off=
set,
         ret =3D s->reg_ICPR; /* the same value with ICPR */
         break;
     default:
-        DPRINTF("Bad offset %x\n", (int)offset);
+        trace_puv3_intc_read_bad(offset);
     }
-    DPRINTF("offset 0x%x, value 0x%x\n", offset, ret);
+    trace_puv3_intc_read(offset, ret);
     return ret;
 }
=20
@@ -76,7 +75,7 @@ static void puv3_intc_write(void *opaque, hwaddr offset=
,
 {
     PUV3INTCState *s =3D opaque;
=20
-    DPRINTF("offset 0x%x, value 0x%x\n", offset, value);
+    trace_puv3_intc_write(offset, value);
     switch (offset) {
     case 0x00: /* INTC_ICLR */
     case 0x14: /* INTC_ICCR */
@@ -85,7 +84,7 @@ static void puv3_intc_write(void *opaque, hwaddr offset=
,
         s->reg_ICMR =3D value;
         break;
     default:
-        DPRINTF("Bad offset 0x%x\n", (int)offset);
+        trace_puv3_intc_write_bad(offset);
         return;
     }
     puv3_intc_update(s);
diff --git a/hw/intc/trace-events b/hw/intc/trace-events
index 7769869a13..e42d0cfb2d 100644
--- a/hw/intc/trace-events
+++ b/hw/intc/trace-events
@@ -200,3 +200,10 @@ nvic_sysreg_write(uint64_t addr, uint32_t value, uns=
igned size) "NVIC sysreg wri
 heathrow_write(uint64_t addr, unsigned int n, uint64_t value) "0x%"PRIx6=
4" %u: 0x%"PRIx64
 heathrow_read(uint64_t addr, unsigned int n, uint64_t value) "0x%"PRIx64=
" %u: 0x%"PRIx64
 heathrow_set_irq(int num, int level) "set_irq: num=3D0x%02x level=3D%d"
+
+# hw/intc/puv3_intc.c
+puv3_intc_handler(int irq, int level) "irq 0x%x, level 0x%x"
+puv3_intc_read_bad(uint32_t offset) "Bad offset 0x%x"
+puv3_intc_read(uint32_t offset, uint32_t value) "offset 0x%x, value 0x%x=
"
+puv3_intc_write(uint32_t offset, uint64_t value) "offset 0x%x, value 0x%=
" PRIx64
+puv3_intc_write_bad(uint32_t offset) "Bad offset 0x%x"
--=20
2.19.2
