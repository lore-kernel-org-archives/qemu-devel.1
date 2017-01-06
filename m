Received: from eggs.gnu.org ([2001:4830:134:3::10]:46312)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1cPQJh-0006RG-0q
	for qemu-devel@nongnu.org; Fri, 06 Jan 2017 03:56:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1cPQJe-0008NT-PG
	for qemu-devel@nongnu.org; Fri, 06 Jan 2017 03:56:05 -0500
Received: from mx1.redhat.com ([209.132.183.28]:42694)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1cPQJe-0008MO-Ie
	for qemu-devel@nongnu.org; Fri, 06 Jan 2017 03:56:02 -0500
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Fri,  6 Jan 2017 09:55:40 +0100
Message-Id: <1483692945-9866-13-git-send-email-kraxel@redhat.com>
In-Reply-To: <1483692945-9866-1-git-send-email-kraxel@redhat.com>
References: <1483692945-9866-1-git-send-email-kraxel@redhat.com>
Subject: [Qemu-devel] [PATCH 12/17] wctablet: drop timer,
 hook into chr->accept_input instead
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
 backends/wctablet.c | 26 +++++++-------------------
 1 file changed, 7 insertions(+), 19 deletions(-)

diff --git a/backends/wctablet.c b/backends/wctablet.c
index f21b1f4..28daf26 100644
--- a/backends/wctablet.c
+++ b/backends/wctablet.c
@@ -76,10 +76,7 @@ int COMMON_SPEAD = 900 * 1000;
 
 // This structure is used to save private info for Wacom Tablet.
 typedef struct {
-    struct QEMUTimer *transmit_timer;
-    /* QEMU timer */
-    uint64_t transmit_time;
-    /* time to transmit a char in ticks */
+    CharDriverState *chr;
     uint8_t query[100];
     int query_index;
     /* Query string from serial */
@@ -89,6 +86,8 @@ typedef struct {
     int line_speed;
 } TabletState;
 
+static void wctablet_chr_accept_input(CharDriverState *chr);
+
 static void wctablet_shift_input(TabletState *tablet, int count)
 {
     tablet->query_index -= count;
@@ -104,6 +103,7 @@ static void wctablet_queue_output(TabletState *tablet, uint8_t *buf, int count)
 
     memcpy(tablet->outbuf + tablet->outlen, buf, count);
     tablet->outlen += count;
+    wctablet_chr_accept_input(tablet->chr);
 }
 
 static void wctablet_reset(TabletState *tablet)
@@ -146,9 +146,8 @@ static void wctablet_event(void *opaque, int x,
     wctablet_queue_output(tablet, codes, 7);
 }
 
-static void wctablet_handler(void *opaque)
+static void wctablet_chr_accept_input(CharDriverState *chr)
 {
-    CharDriverState *chr = (CharDriverState *) opaque;
     TabletState *tablet = (TabletState *) chr->opaque;
     int len, canWrite; // , i;
 
@@ -165,9 +164,6 @@ static void wctablet_handler(void *opaque)
             memmove(tablet->outbuf, tablet->outbuf + len, tablet->outlen);
         }
     }
-
-    timer_mod(tablet->transmit_timer,
-              qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) + tablet->transmit_time);
 }
 
 static int wctablet_chr_write(struct CharDriverState *s,
@@ -285,24 +281,16 @@ static CharDriverState *qemu_chr_open_wctablet(const char *id,
     chr->chr_write = wctablet_chr_write;
     chr->chr_ioctl = wctablet_chr_ioctl;
     chr->chr_free = wctablet_chr_free;
+    chr->chr_accept_input = wctablet_chr_accept_input;
     *be_opened = true;
 
-    /* create a new QEMU's timer with wctablet_handler() as timeout handler. */
-    tablet->transmit_timer = timer_new_ns(QEMU_CLOCK_VIRTUAL,
-                                       (QEMUTimerCB *) wctablet_handler, chr);
-
-    tablet->transmit_time = COMMON_SPEAD;
-
-    timer_mod(tablet->transmit_timer,
-              qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) + tablet->transmit_time);
-
-
     /* init state machine */
     memcpy(tablet->outbuf, WC_FULL_CONFIG_STRING, WC_FULL_CONFIG_STRING_LENGTH);
     tablet->outlen = WC_FULL_CONFIG_STRING_LENGTH;
     tablet->query_index = 0;
 
     chr->opaque = tablet;
+    tablet->chr = chr;
 
     qemu_add_mouse_event_handler(wctablet_event, chr, 1,
                                  "QEMU Wacome Pen Tablet");
-- 
1.8.3.1
