Received: from eggs.gnu.org ([2001:4830:134:3::10]:50277)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fW39A-0004mo-Dm
	for qemu-devel@nongnu.org; Thu, 21 Jun 2018 13:13:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fW395-000265-GZ
	for qemu-devel@nongnu.org; Thu, 21 Jun 2018 13:13:24 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Thu, 21 Jun 2018 14:12:50 -0300
Message-Id: <20180621171257.14897-5-f4bug@amsat.org>
In-Reply-To: <20180621171257.14897-1-f4bug@amsat.org>
References: <20180621171257.14897-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 04/11] hw/char/parallel: Convert from pdebug()
 macro to trace events
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, qemu-trivial@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
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
 
 //#define DEBUG_PARALLEL
 
@@ -110,9 +111,8 @@ parallel_ioport_write_sw(void *opaque, uint32_t addr, uint32_t val)
 {
     ParallelState *s = opaque;
 
-    pdebug("write addr=0x%02x val=0x%02x\n", addr, val);
-
     addr &= 7;
+    trace_parallel_ioport_write("SW", addr, val);
     switch(addr) {
     case PARA_REG_DATA:
         s->dataw = val;
@@ -157,6 +157,7 @@ static void parallel_ioport_write_hw(void *opaque, uint32_t addr, uint32_t val)
     s->last_read_offset = ~0U;
 
     addr &= 7;
+    trace_parallel_ioport_write("HW", addr, val);
     switch(addr) {
     case PARA_REG_DATA:
         if (s->dataw == val)
@@ -230,6 +231,8 @@ parallel_ioport_eppdata_write_hw2(void *opaque, uint32_t addr, uint32_t val)
     struct ParallelIOArg ioarg = {
         .buffer = &eppdata, .count = sizeof(eppdata)
     };
+
+    trace_parallel_ioport_write("EPP", addr, val);
     if ((s->control & (PARA_CTR_DIR|PARA_CTR_SIGNAL)) != PARA_CTR_INIT) {
         /* Controls not correct for EPP data cycle, so do nothing */
         pdebug("we%04x s\n", val);
@@ -253,6 +256,8 @@ parallel_ioport_eppdata_write_hw4(void *opaque, uint32_t addr, uint32_t val)
     struct ParallelIOArg ioarg = {
         .buffer = &eppdata, .count = sizeof(eppdata)
     };
+
+    trace_parallel_ioport_write("EPP", addr, val);
     if ((s->control & (PARA_CTR_DIR|PARA_CTR_SIGNAL)) != PARA_CTR_INIT) {
         /* Controls not correct for EPP data cycle, so do nothing */
         pdebug("we%08x s\n", val);
@@ -299,7 +304,7 @@ static uint32_t parallel_ioport_read_sw(void *opaque, uint32_t addr)
         ret = s->control;
         break;
     }
-    pdebug("read addr=0x%02x val=0x%02x\n", addr, ret);
+    trace_parallel_ioport_read("SW", addr, ret);
     return ret;
 }
 
@@ -371,6 +376,7 @@ static uint32_t parallel_ioport_read_hw(void *opaque, uint32_t addr)
         }
         break;
     }
+    trace_parallel_ioport_read("HW", addr, ret);
     s->last_read_offset = addr;
     return ret;
 }
@@ -399,6 +405,7 @@ parallel_ioport_eppdata_read_hw2(void *opaque, uint32_t addr)
     }
     else
         pdebug("re%04x\n", ret);
+    trace_parallel_ioport_read("EPP", addr, ret);
     return ret;
 }
 
@@ -426,11 +433,13 @@ parallel_ioport_eppdata_read_hw4(void *opaque, uint32_t addr)
     }
     else
         pdebug("re%08x\n", ret);
+    trace_parallel_ioport_read("EPP", addr, ret);
     return ret;
 }
 
 static void parallel_ioport_ecp_write(void *opaque, uint32_t addr, uint32_t val)
 {
+    trace_parallel_ioport_write("ECP", addr & 7, val);
     pdebug("wecp%d=%02x\n", addr & 7, val);
 }
 
@@ -438,6 +447,7 @@ static uint32_t parallel_ioport_ecp_read(void *opaque, uint32_t addr)
 {
     uint8_t ret = 0xff;
 
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
 
+# hw/char/parallel.c
+parallel_ioport_read(const char *desc, uint16_t addr, uint8_t value) "read [%s] addr 0x%02x val 0x%02x"
+parallel_ioport_write(const char *desc, uint16_t addr, uint8_t value) "write [%s] addr 0x%02x val 0x%02x"
+
 # hw/char/serial.c
 serial_ioport_read(uint16_t addr, uint8_t value) "read addr 0x%02x val 0x%02x"
 serial_ioport_write(uint16_t addr, uint8_t value) "write addr 0x%02x val 0x%02x"
-- 
2.18.0.rc2
