Received: from eggs.gnu.org ([2001:4830:134:3::10]:50453)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fW39N-0004zp-Fl
	for qemu-devel@nongnu.org; Thu, 21 Jun 2018 13:13:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fW39M-0002FH-JE
	for qemu-devel@nongnu.org; Thu, 21 Jun 2018 13:13:37 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Thu, 21 Jun 2018 14:12:56 -0300
Message-Id: <20180621171257.14897-11-f4bug@amsat.org>
In-Reply-To: <20180621171257.14897-1-f4bug@amsat.org>
References: <20180621171257.14897-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 10/11] hw/block/fdc: Convert from
 FLOPPY_DPRINTF() macro to trace events
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, qemu-trivial@nongnu.org, John Snow <jsnow@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, "open list:Floppy" <qemu-block@nongnu.org>

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/block/fdc.c        | 6 +++---
 hw/block/trace-events | 4 ++++
 2 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/hw/block/fdc.c b/hw/block/fdc.c
index cd29e27d8f..c7b4fe9b3e 100644
--- a/hw/block/fdc.c
+++ b/hw/block/fdc.c
@@ -40,6 +40,7 @@
 #include "sysemu/blockdev.h"
 #include "sysemu/sysemu.h"
 #include "qemu/log.h"
+#include "trace.h"
 
 /********************************************************/
 /* debug Floppy devices */
@@ -934,7 +935,7 @@ static uint32_t fdctrl_read (void *opaque, uint32_t reg)
         retval = (uint32_t)(-1);
         break;
     }
-    FLOPPY_DPRINTF("read reg%d: 0x%02x\n", reg & 7, retval);
+    trace_fdc_ioport_read(reg, retval);
 
     return retval;
 }
@@ -943,9 +944,8 @@ static void fdctrl_write (void *opaque, uint32_t reg, uint32_t value)
 {
     FDCtrl *fdctrl = opaque;
 
-    FLOPPY_DPRINTF("write reg%d: 0x%02x\n", reg & 7, value);
-
     reg &= 7;
+    trace_fdc_ioport_write(reg, value);
     switch (reg) {
     case FD_REG_DOR:
         fdctrl_write_dor(fdctrl, value);
diff --git a/hw/block/trace-events b/hw/block/trace-events
index 6b9e733412..d842c45409 100644
--- a/hw/block/trace-events
+++ b/hw/block/trace-events
@@ -1,5 +1,9 @@
 # See docs/devel/tracing.txt for syntax documentation.
 
+# hw/block/fdc.c
+fdc_ioport_read(uint8_t reg, uint8_t value) "read reg 0x%02x val 0x%02x"
+fdc_ioport_write(uint8_t reg, uint8_t value) "write reg 0x%02x val 0x%02x"
+
 # hw/block/virtio-blk.c
 virtio_blk_req_complete(void *vdev, void *req, int status) "vdev %p req %p status %d"
 virtio_blk_rw_complete(void *vdev, void *req, int ret) "vdev %p req %p ret %d"
-- 
2.18.0.rc2
