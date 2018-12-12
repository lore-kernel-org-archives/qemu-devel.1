Received: from eggs.gnu.org ([2001:4830:134:3::10]:35121)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lvivier@redhat.com>) id 1gX8LB-0006yV-IV
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 12:30:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lvivier@redhat.com>) id 1gX8L8-00017p-Ex
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 12:30:33 -0500
From: Laurent Vivier <lvivier@redhat.com>
Date: Wed, 12 Dec 2018 18:30:06 +0100
Message-Id: <20181212173007.11407-6-lvivier@redhat.com>
In-Reply-To: <20181212173007.11407-1-lvivier@redhat.com>
References: <20181212173007.11407-1-lvivier@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 5/6] hw/timer/puv3_ost: Convert from DPRINTF()
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
 hw/timer/puv3_ost.c   | 14 ++++++--------
 hw/timer/trace-events |  7 +++++++
 2 files changed, 13 insertions(+), 8 deletions(-)

diff --git a/hw/timer/puv3_ost.c b/hw/timer/puv3_ost.c
index 0b3d717e60..387b7a9bd1 100644
--- a/hw/timer/puv3_ost.c
+++ b/hw/timer/puv3_ost.c
@@ -12,9 +12,8 @@
 #include "hw/sysbus.h"
 #include "hw/ptimer.h"
 #include "qemu/main-loop.h"
-
-#undef DEBUG_PUV3
 #include "hw/unicore32/puv3.h"
+#include "trace.h"
=20
 #define TYPE_PUV3_OST "puv3_ost"
 #define PUV3_OST(obj) OBJECT_CHECK(PUV3OSTState, (obj), TYPE_PUV3_OST)
@@ -51,9 +50,9 @@ static uint64_t puv3_ost_read(void *opaque, hwaddr offs=
et,
         ret =3D s->reg_OIER;
         break;
     default:
-        DPRINTF("Bad offset %x\n", (int)offset);
+        trace_puv3_ost_read_bad(offset);
     }
-    DPRINTF("offset 0x%x, value 0x%x\n", offset, ret);
+    trace_puv3_ost_read(offset, ret);
     return ret;
 }
=20
@@ -62,7 +61,7 @@ static void puv3_ost_write(void *opaque, hwaddr offset,
 {
     PUV3OSTState *s =3D opaque;
=20
-    DPRINTF("offset 0x%x, value 0x%x\n", offset, value);
+    trace_puv3_ost_write(offset, value);
     switch (offset) {
     case 0x00: /* Match Register 0 */
         s->reg_OSMR0 =3D value;
@@ -85,7 +84,7 @@ static void puv3_ost_write(void *opaque, hwaddr offset,
         s->reg_OIER =3D value;
         break;
     default:
-        DPRINTF("Bad offset %x\n", (int)offset);
+        trace_puv3_ost_write_bad(offset);
     }
 }
=20
@@ -103,8 +102,7 @@ static void puv3_ost_tick(void *opaque)
 {
     PUV3OSTState *s =3D opaque;
=20
-    DPRINTF("ost hit when ptimer counter from 0x%x to 0x%x!\n",
-            s->reg_OSCR, s->reg_OSMR0);
+    trace_puv3_ost_tick(s->reg_OSCR, s->reg_OSMR0);
=20
     s->reg_OSCR =3D s->reg_OSMR0;
     if (s->reg_OIER) {
diff --git a/hw/timer/trace-events b/hw/timer/trace-events
index 75bd3b1042..c504fd52c0 100644
--- a/hw/timer/trace-events
+++ b/hw/timer/trace-events
@@ -72,3 +72,10 @@ sun4v_rtc_write(uint64_t addr, uint64_t value) "write:=
 addr 0x%" PRIx64 " value
=20
 # hw/timer/xlnx-zynqmp-rtc.c
 xlnx_zynqmp_rtc_gettime(int year, int month, int day, int hour, int min,=
 int sec) "Get time from host: %d-%d-%d %2d:%02d:%02d"
+
+# hw/timer/puv3_ost.c
+puv3_ost_read_bad(uint32_t offset) "Bad offset 0x%x"
+puv3_ost_read(uint32_t offset, uint32_t value) "offset 0x%x, value 0x%x"
+puv3_ost_write(uint32_t offset, uint64_t value) "offset 0x%x, value 0x%"=
 PRIx64
+puv3_ost_write_bad(uint32_t offset) "Bad offset 0x%x"
+puv3_ost_tick(uint32_t oscr, uint32_t osmr0) "ost hit when ptimer counte=
r from 0x%x to 0x%x!"
--=20
2.19.2
