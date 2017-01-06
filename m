Received: from eggs.gnu.org ([2001:4830:134:3::10]:46252)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1cPQJf-0006QX-Q4
	for qemu-devel@nongnu.org; Fri, 06 Jan 2017 03:56:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1cPQJe-0008Mt-FF
	for qemu-devel@nongnu.org; Fri, 06 Jan 2017 03:56:03 -0500
Received: from mx1.redhat.com ([209.132.183.28]:51756)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1cPQJe-0008ME-AF
	for qemu-devel@nongnu.org; Fri, 06 Jan 2017 03:56:02 -0500
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Fri,  6 Jan 2017 09:55:35 +0100
Message-Id: <1483692945-9866-8-git-send-email-kraxel@redhat.com>
In-Reply-To: <1483692945-9866-1-git-send-email-kraxel@redhat.com>
References: <1483692945-9866-1-git-send-email-kraxel@redhat.com>
Subject: [Qemu-devel] [PATCH 07/17] wctablet: operate on line speed 9600
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

Ignore all input unless line speed is 9600.  This makes line speed
detection work correctly and alot more reliable.

Also drop the reset counter, this served as workaround for the lack of
proper line speed handling and is not needed any more.

The guest sends the reset sequence multiple times with different speeds
to figure what the line speed is.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 backends/wctablet.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/backends/wctablet.c b/backends/wctablet.c
index 4d14e96..84fb485 100644
--- a/backends/wctablet.c
+++ b/backends/wctablet.c
@@ -97,10 +97,8 @@ uint8_t WC_FULL_CONFIG_STRING[61] = {
     0x0a, 0x45, 0x37, 0x29
 };
 size_t WC_FULL_CONFIG_STRING_LENGTH = 61;
-int count = 0;
 int COMMON_SPEAD = 900 * 1000;
 
-
 // This structure is used to save private info for Wacom Tablet.
 typedef struct {
     struct QEMUTimer *transmit_timer;
@@ -170,6 +168,10 @@ static void wctablet_event(void *opaque, int x,
     // uint8_t codes[8] = { 0xe0, 0x05, 0x6a, 0x00, 0x06, 0x64, 0x40 };
     // uint8_t codes[8] = { 0xa0, 0x1c, 0x29, 0x00, 0x19, 0x1c, 0x00 };
 
+    if (tablet->line_speed != 9600) {
+        return;
+    }
+
     DPRINTF("x= %d; y= %d; buttons=%x\n", x, y, buttons_state);
     int newX = x * 0.1537;
     int nexY = y * 0.1152;
@@ -225,6 +227,9 @@ static int wctablet_chr_write(struct CharDriverState *s,
     TabletState *tablet = (TabletState *) s->opaque;
     uint8_t i, input;
 
+    if (tablet->line_speed != 9600) {
+        return len;
+    }
     for (i = 0; i < len && tablet->query_index < sizeof(tablet->query) - 1; i++) {
         tablet->query[tablet->query_index++] = buf[i];
     }
@@ -242,12 +247,8 @@ static int wctablet_chr_write(struct CharDriverState *s,
 
     int comm = wctablet_check_command(tablet->query, tablet->query_index);
 
-    if (comm == 1) {
-        count++;
-    }
-
     if (comm != -1) {
-        if (comm == 1 && count == 2) {
+        if (comm == 1) {
             wctablet_queue_output(tablet, WC_MODEL_STRING,
                                   WC_MODEL_STRING_LENGTH);
         }
-- 
1.8.3.1
