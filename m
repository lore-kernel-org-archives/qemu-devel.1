Received: from eggs.gnu.org ([2001:4830:134:3::10]:57295)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <g.danil.anto@gmail.com>) id 1cuJcs-0002W2-77
	for qemu-devel@nongnu.org; Sat, 01 Apr 2017 10:03:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <g.danil.anto@gmail.com>) id 1cuJcq-0007lH-W8
	for qemu-devel@nongnu.org; Sat, 01 Apr 2017 10:03:34 -0400
Received: from mail-oi0-x244.google.com ([2607:f8b0:4003:c06::244]:36089)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <g.danil.anto@gmail.com>)
	id 1cuJcq-0007ky-Om
	for qemu-devel@nongnu.org; Sat, 01 Apr 2017 10:03:32 -0400
Received: by mail-oi0-x244.google.com with SMTP id b187so13231837oif.3
	for <qemu-devel@nongnu.org>; Sat, 01 Apr 2017 07:03:32 -0700 (PDT)
MIME-Version: 1.0
From: Danil Antonov <g.danil.anto@gmail.com>
Date: Sat, 1 Apr 2017 17:03:31 +0300
Message-ID: <CA+KKJYCkYkn_TnDheO=1zcTyn8VzSibHqO8yDc3ttHL1bCj3hw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: [Qemu-devel] [PATCH 32/43] char: made printf always compile in
 debug output
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

>From 9147a39cc2dabe76e7c1b38e801069390d5a3321 Mon Sep 17 00:00:00 2001
From: Danil Antonov <g.danil.anto@gmail.com>
Date: Wed, 29 Mar 2017 12:40:02 +0300
Subject: [PATCH 32/43] char: made printf always compile in debug output

Wrapped printf calls inside debug macros (DPRINTF) in `if` statement.
This will ensure that printf function will always compile even if debug
output is turned off and, in turn, will prevent bitrot of the format
strings.

Signed-off-by: Danil Antonov <g.danil.anto@gmail.com>
---
 hw/char/ipoctal232.c | 24 +++++++++++++-----------
 hw/char/serial.c     | 16 +++++++++-------
 2 files changed, 22 insertions(+), 18 deletions(-)

diff --git a/hw/char/ipoctal232.c b/hw/char/ipoctal232.c
index 93929c2..180d8f7 100644
--- a/hw/char/ipoctal232.c
+++ b/hw/char/ipoctal232.c
@@ -13,14 +13,16 @@
 #include "qemu/bitops.h"
 #include "sysemu/char.h"

-/* #define DEBUG_IPOCTAL */

-#ifdef DEBUG_IPOCTAL
-#define DPRINTF2(fmt, ...) \
-    do { fprintf(stderr, fmt, ## __VA_ARGS__); } while (0)
-#else
-#define DPRINTF2(fmt, ...) do { } while (0)
-#endif
+#ifndef DEBUG_IPOCTAL
+#define DEBUG_IPOCTAL 0
+#endif
+
+#define DPRINTF2(fmt, ...) do {                \
+    if (DEBUG_IPOCTAL) {                       \
+        fprintf(stderr, fmt, ## __VA_ARGS__);  \
+    }                                          \
+} while (0);

 #define DPRINTF(fmt, ...) DPRINTF2("IP-Octal: " fmt, ## __VA_ARGS__)

@@ -504,11 +506,11 @@ static void hostdev_event(void *opaque, int event)
     SCC2698Channel *ch = opaque;
     switch (event) {
     case CHR_EVENT_OPENED:
-        DPRINTF("Device %s opened\n", ch->dev->label);
+        DPRINTF("Device %s opened\n", ch->dev.chr->label);
         break;
     case CHR_EVENT_BREAK: {
         uint8_t zero = 0;
-        DPRINTF("Device %s received break\n", ch->dev->label);
+        DPRINTF("Device %s received break\n", ch->dev.chr->label);

         if (!(ch->sr & SR_BREAK)) {
             IPOctalState *dev = ch->ipoctal;
@@ -528,7 +530,7 @@ static void hostdev_event(void *opaque, int event)
     }
         break;
     default:
-        DPRINTF("Device %s received event %d\n", ch->dev->label, event);
+        DPRINTF("Device %s received event %d\n", ch->dev.chr->label,
event);
     }
 }

@@ -546,7 +548,7 @@ static void ipoctal_realize(DeviceState *dev, Error
**errp)
             qemu_chr_fe_set_handlers(&ch->dev, hostdev_can_receive,
                                      hostdev_receive, hostdev_event,
                                      ch, NULL, true);
-            DPRINTF("Redirecting channel %u to %s\n", i, ch->dev->label);
+            DPRINTF("Redirecting channel %u to %s\n", i,
ch->dev.chr->label);
         } else {
             DPRINTF("Could not redirect channel %u, no chardev set\n", i);
         }
diff --git a/hw/char/serial.c b/hw/char/serial.c
index 03d890c..9421c7a 100644
--- a/hw/char/serial.c
+++ b/hw/char/serial.c
@@ -97,13 +97,15 @@

 #define MAX_XMIT_RETRY      4

-#ifdef DEBUG_SERIAL
-#define DPRINTF(fmt, ...) \
-do { fprintf(stderr, "serial: " fmt , ## __VA_ARGS__); } while (0)
-#else
-#define DPRINTF(fmt, ...) \
-do {} while (0)
-#endif
+#ifndef DEBUG_SERIAL
+#define DEBUG_SERIAL 0
+#endif
+
+#define DPRINTF(fmt, ...) do {                            \
+    if (DEBUG_SERIAL) {                                   \
+        fprintf(stderr, "serial: " fmt , ## __VA_ARGS__); \
+    }                                                     \
+} while (0);

 static void serial_receive1(void *opaque, const uint8_t *buf, int size);
 static void serial_xmit(SerialState *s);
-- 
2.8.0.rc3
