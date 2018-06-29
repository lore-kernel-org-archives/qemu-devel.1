Received: from eggs.gnu.org ([2001:4830:134:3::10]:49706)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1fYxab-0000GU-IA
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 13:53:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1fYxaa-0008TG-Ew
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 13:53:45 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:40230 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1fYxaa-0008Sj-9U
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 13:53:44 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
Date: Fri, 29 Jun 2018 18:53:24 +0100
Message-Id: <20180629175330.19391-6-stefanha@redhat.com>
In-Reply-To: <20180629175330.19391-1-stefanha@redhat.com>
References: <20180629175330.19391-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 05/11] hw/char/parallel: Convert from pdebug()
 macro to trace events
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
 hw/char/parallel.c   | 16 +++++++++++++---
 hw/char/trace-events |  4 ++++
 2 files changed, 17 insertions(+), 3 deletions(-)

diff --git a/hw/char/parallel.c b/hw/char/parallel.c
index 35748e6c1b..a80da47ecf 100644
--- a/hw/char/parallel.c
+++ b/hw/char/parallel.c
@@ -30,6 +30,7 @@
 #include "hw/isa/isa.h"
 #include "hw/char/parallel.h"
 #include "sysemu/sysemu.h"
+#include "trace.h"
=20
 //#define DEBUG_PARALLEL
=20
@@ -110,9 +111,8 @@ parallel_ioport_write_sw(void *opaque, uint32_t addr,=
 uint32_t val)
 {
     ParallelState *s =3D opaque;
=20
-    pdebug("write addr=3D0x%02x val=3D0x%02x\n", addr, val);
-
     addr &=3D 7;
+    trace_parallel_ioport_write("SW", addr, val);
     switch(addr) {
     case PARA_REG_DATA:
         s->dataw =3D val;
@@ -157,6 +157,7 @@ static void parallel_ioport_write_hw(void *opaque, ui=
nt32_t addr, uint32_t val)
     s->last_read_offset =3D ~0U;
=20
     addr &=3D 7;
+    trace_parallel_ioport_write("HW", addr, val);
     switch(addr) {
     case PARA_REG_DATA:
         if (s->dataw =3D=3D val)
@@ -230,6 +231,8 @@ parallel_ioport_eppdata_write_hw2(void *opaque, uint3=
2_t addr, uint32_t val)
     struct ParallelIOArg ioarg =3D {
         .buffer =3D &eppdata, .count =3D sizeof(eppdata)
     };
+
+    trace_parallel_ioport_write("EPP", addr, val);
     if ((s->control & (PARA_CTR_DIR|PARA_CTR_SIGNAL)) !=3D PARA_CTR_INIT=
) {
         /* Controls not correct for EPP data cycle, so do nothing */
         pdebug("we%04x s\n", val);
@@ -253,6 +256,8 @@ parallel_ioport_eppdata_write_hw4(void *opaque, uint3=
2_t addr, uint32_t val)
     struct ParallelIOArg ioarg =3D {
         .buffer =3D &eppdata, .count =3D sizeof(eppdata)
     };
+
+    trace_parallel_ioport_write("EPP", addr, val);
     if ((s->control & (PARA_CTR_DIR|PARA_CTR_SIGNAL)) !=3D PARA_CTR_INIT=
) {
         /* Controls not correct for EPP data cycle, so do nothing */
         pdebug("we%08x s\n", val);
@@ -299,7 +304,7 @@ static uint32_t parallel_ioport_read_sw(void *opaque,=
 uint32_t addr)
         ret =3D s->control;
         break;
     }
-    pdebug("read addr=3D0x%02x val=3D0x%02x\n", addr, ret);
+    trace_parallel_ioport_read("SW", addr, ret);
     return ret;
 }
=20
@@ -371,6 +376,7 @@ static uint32_t parallel_ioport_read_hw(void *opaque,=
 uint32_t addr)
         }
         break;
     }
+    trace_parallel_ioport_read("HW", addr, ret);
     s->last_read_offset =3D addr;
     return ret;
 }
@@ -399,6 +405,7 @@ parallel_ioport_eppdata_read_hw2(void *opaque, uint32=
_t addr)
     }
     else
         pdebug("re%04x\n", ret);
+    trace_parallel_ioport_read("EPP", addr, ret);
     return ret;
 }
=20
@@ -426,11 +433,13 @@ parallel_ioport_eppdata_read_hw4(void *opaque, uint=
32_t addr)
     }
     else
         pdebug("re%08x\n", ret);
+    trace_parallel_ioport_read("EPP", addr, ret);
     return ret;
 }
=20
 static void parallel_ioport_ecp_write(void *opaque, uint32_t addr, uint3=
2_t val)
 {
+    trace_parallel_ioport_write("ECP", addr & 7, val);
     pdebug("wecp%d=3D%02x\n", addr & 7, val);
 }
=20
@@ -438,6 +447,7 @@ static uint32_t parallel_ioport_ecp_read(void *opaque=
, uint32_t addr)
 {
     uint8_t ret =3D 0xff;
=20
+    trace_parallel_ioport_read("ECP", addr & 7, ret);
     pdebug("recp%d:%02x\n", addr & 7, ret);
     return ret;
 }
diff --git a/hw/char/trace-events b/hw/char/trace-events
index 158957627e..b64213d4dd 100644
--- a/hw/char/trace-events
+++ b/hw/char/trace-events
@@ -1,5 +1,9 @@
 # See docs/devel/tracing.txt for syntax documentation.
=20
+# hw/char/parallel.c
+parallel_ioport_read(const char *desc, uint16_t addr, uint8_t value) "re=
ad [%s] addr 0x%02x val 0x%02x"
+parallel_ioport_write(const char *desc, uint16_t addr, uint8_t value) "w=
rite [%s] addr 0x%02x val 0x%02x"
+
 # hw/char/serial.c
 serial_ioport_read(uint16_t addr, uint8_t value) "read addr 0x%02x val 0=
x%02x"
 serial_ioport_write(uint16_t addr, uint8_t value) "write addr 0x%02x val=
 0x%02x"
--=20
2.17.1
