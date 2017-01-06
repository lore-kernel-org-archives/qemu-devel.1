Received: from eggs.gnu.org ([2001:4830:134:3::10]:46351)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1cPQJh-0006Ro-LE
	for qemu-devel@nongnu.org; Fri, 06 Jan 2017 03:56:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1cPQJf-0008Ol-U9
	for qemu-devel@nongnu.org; Fri, 06 Jan 2017 03:56:05 -0500
Received: from mx1.redhat.com ([209.132.183.28]:51772)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1cPQJf-0008Nu-M9
	for qemu-devel@nongnu.org; Fri, 06 Jan 2017 03:56:03 -0500
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Fri,  6 Jan 2017 09:55:45 +0100
Message-Id: <1483692945-9866-18-git-send-email-kraxel@redhat.com>
In-Reply-To: <1483692945-9866-1-git-send-email-kraxel@redhat.com>
References: <1483692945-9866-1-git-send-email-kraxel@redhat.com>
Subject: [Qemu-devel] [PATCH 17/17] wctablet: implement ST and SP commands
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

ST == start sending events
Sp == stop sending events

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 backends/trace-events |  2 ++
 backends/wctablet.c   | 20 +++++++++++++++++++-
 2 files changed, 21 insertions(+), 1 deletion(-)

diff --git a/backends/trace-events b/backends/trace-events
index f8a2e2b..8c3289a 100644
--- a/backends/trace-events
+++ b/backends/trace-events
@@ -3,6 +3,8 @@
 # backends/wctablet.c
 wct_init(void) ""
 wct_cmd_re(void) ""
+wct_cmd_st(void) ""
+wct_cmd_sp(void) ""
 wct_cmd_ts(int input) "0x%02x"
 wct_cmd_other(const char *cmd) "%s"
 wct_speed(int speed) "%d"
diff --git a/backends/wctablet.c b/backends/wctablet.c
index 97f1996..f9f4c80 100644
--- a/backends/wctablet.c
+++ b/backends/wctablet.c
@@ -81,6 +81,7 @@ typedef struct {
     int outlen;
 
     int line_speed;
+    bool send_events;
     int axis[INPUT_AXIS__MAX];
     bool btns[INPUT_BUTTON__MAX];
 
@@ -111,6 +112,8 @@ static void wctablet_reset(TabletState *tablet)
     /* clear buffers */
     tablet->query_index = 0;
     tablet->outlen = 0;
+    /* reset state */
+    tablet->send_events = false;
 }
 
 static void wctablet_queue_event(TabletState *tablet)
@@ -167,7 +170,9 @@ static void wctablet_input_sync(DeviceState *dev)
 {
     TabletState *tablet = (TabletState *)dev;
 
-    wctablet_queue_event(tablet);
+    if (tablet->send_events) {
+        wctablet_queue_event(tablet);
+    }
 }
 
 static QemuInputHandler wctablet_handler = {
@@ -248,6 +253,19 @@ static int wctablet_chr_write(struct CharDriverState *s,
         wctablet_queue_output(tablet, WC_CONFIG_STRING,
                               WC_CONFIG_STRING_LENGTH);
 
+    } else if (strncmp((char *)tablet->query, "ST", 2) == 0 &&
+               clen == 2) {
+        trace_wct_cmd_st();
+        wctablet_shift_input(tablet, 3);
+        tablet->send_events = true;
+        wctablet_queue_event(tablet);
+
+    } else if (strncmp((char *)tablet->query, "SP", 2) == 0 &&
+               clen == 2) {
+        trace_wct_cmd_sp();
+        wctablet_shift_input(tablet, 3);
+        tablet->send_events = false;
+
     } else if (strncmp((char *)tablet->query, "TS", 2) == 0 &&
                clen == 3) {
         unsigned int input = tablet->query[2];
-- 
1.8.3.1
