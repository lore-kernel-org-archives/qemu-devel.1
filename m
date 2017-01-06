Received: from eggs.gnu.org ([2001:4830:134:3::10]:46329)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1cPQJh-0006RN-8S
	for qemu-devel@nongnu.org; Fri, 06 Jan 2017 03:56:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1cPQJe-0008Nh-TG
	for qemu-devel@nongnu.org; Fri, 06 Jan 2017 03:56:05 -0500
Received: from mx1.redhat.com ([209.132.183.28]:51760)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1cPQJe-0008MR-M4
	for qemu-devel@nongnu.org; Fri, 06 Jan 2017 03:56:02 -0500
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Fri,  6 Jan 2017 09:55:41 +0100
Message-Id: <1483692945-9866-14-git-send-email-kraxel@redhat.com>
In-Reply-To: <1483692945-9866-1-git-send-email-kraxel@redhat.com>
References: <1483692945-9866-1-git-send-email-kraxel@redhat.com>
Subject: [Qemu-devel] [PATCH 13/17] wctablet: drop DPRINTF,
 add trace events instead
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: avg.tolik@gmail.com, Gerd Hoffmann <kraxel@redhat.com>

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 Makefile.objs         |  1 +
 backends/trace-events |  8 ++++++++
 backends/wctablet.c   | 18 +++++++-----------
 3 files changed, 16 insertions(+), 11 deletions(-)
 create mode 100644 backends/trace-events

diff --git a/Makefile.objs b/Makefile.objs
index 51c36a4..df7d0cb 100644
--- a/Makefile.objs
+++ b/Makefile.objs
@@ -124,6 +124,7 @@ trace-events-y += crypto/trace-events
 trace-events-y += io/trace-events
 trace-events-y += migration/trace-events
 trace-events-y += block/trace-events
+trace-events-y += backends/trace-events
 trace-events-y += hw/block/trace-events
 trace-events-y += hw/char/trace-events
 trace-events-y += hw/intc/trace-events
diff --git a/backends/trace-events b/backends/trace-events
new file mode 100644
index 0000000..f8a2e2b
--- /dev/null
+++ b/backends/trace-events
@@ -0,0 +1,8 @@
+# See docs/tracing.txt for syntax documentation.
+
+# backends/wctablet.c
+wct_init(void) ""
+wct_cmd_re(void) ""
+wct_cmd_ts(int input) "0x%02x"
+wct_cmd_other(const char *cmd) "%s"
+wct_speed(int speed) "%d"
diff --git a/backends/wctablet.c b/backends/wctablet.c
index 28daf26..07d2a7e 100644
--- a/backends/wctablet.c
+++ b/backends/wctablet.c
@@ -31,18 +31,9 @@
 #include "sysemu/char.h"
 #include "ui/console.h"
 #include "ui/input.h"
+#include "trace.h"
 
 
-#define DEBUG_WCTABLET_MOUSE
-
-#ifdef DEBUG_WCTABLET_MOUSE
-#define DPRINTF(fmt, ...) \
-do { fprintf(stderr, fmt , ## __VA_ARGS__); } while (0)
-#else
-#define DPRINTF(fmt, ...) \
-do {} while (0)
-#endif
-
 #define WC_BUSY_STATE 1
 #define WC_BUSY_WITH_CODES 3
 #define WC_WAITING_STATE 2
@@ -127,7 +118,6 @@ static void wctablet_event(void *opaque, int x,
         return;
     }
 
-    DPRINTF("x= %d; y= %d; buttons=%x\n", x, y, buttons_state);
     int newX = x * 0.1537;
     int nexY = y * 0.1152;
 
@@ -192,6 +182,7 @@ static int wctablet_chr_write(struct CharDriverState *s,
 
     if (strncmp((char *)tablet->query, "~#", 2) == 0) {
         /* init / detect sequence */
+        trace_wct_init();
         wctablet_shift_input(tablet, 2);
         wctablet_queue_output(tablet, WC_MODEL_STRING,
                               WC_MODEL_STRING_LENGTH);
@@ -211,6 +202,7 @@ static int wctablet_chr_write(struct CharDriverState *s,
     /* process commands */
     if (strncmp((char *)tablet->query, "RE", 2) == 0 &&
         clen == 2) {
+        trace_wct_cmd_re();
         wctablet_shift_input(tablet, 3);
         wctablet_queue_output(tablet, WC_CONFIG_STRING,
                               WC_CONFIG_STRING_LENGTH);
@@ -227,10 +219,13 @@ static int wctablet_chr_write(struct CharDriverState *s,
             0x7f,
             0x00,
         };
+        trace_wct_cmd_ts(input);
         wctablet_shift_input(tablet, 4);
         wctablet_queue_output(tablet, codes, 7);
 
     } else {
+        tablet->query[clen] = 0; /* terminate line for printing */
+        trace_wct_cmd_other((char *)tablet->query);
         wctablet_shift_input(tablet, clen + 1);
 
     }
@@ -247,6 +242,7 @@ static int wctablet_chr_ioctl(CharDriverState *s, int cmd, void *arg)
     case CHR_IOCTL_SERIAL_SET_PARAMS:
         ssp = arg;
         if (tablet->line_speed != ssp->speed) {
+            trace_wct_speed(ssp->speed);
             wctablet_reset(tablet);
             tablet->line_speed = ssp->speed;
         }
-- 
1.8.3.1
