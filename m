Received: from eggs.gnu.org ([2001:4830:134:3::10]:58205)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <g.danil.anto@gmail.com>) id 1cuJfj-0004qA-Hj
	for qemu-devel@nongnu.org; Sat, 01 Apr 2017 10:06:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <g.danil.anto@gmail.com>) id 1cuJfi-0001Jg-3n
	for qemu-devel@nongnu.org; Sat, 01 Apr 2017 10:06:31 -0400
Received: from mail-oi0-x243.google.com ([2607:f8b0:4003:c06::243]:36290)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <g.danil.anto@gmail.com>)
	id 1cuJfh-0001JD-TX
	for qemu-devel@nongnu.org; Sat, 01 Apr 2017 10:06:30 -0400
Received: by mail-oi0-x243.google.com with SMTP id b187so13240185oif.3
	for <qemu-devel@nongnu.org>; Sat, 01 Apr 2017 07:06:29 -0700 (PDT)
MIME-Version: 1.0
From: Danil Antonov <g.danil.anto@gmail.com>
Date: Sat, 1 Apr 2017 17:06:28 +0300
Message-ID: <CA+KKJYB4M2nuw1Nu5tYgLAm1Gj9pBR8mW2B7a8zoPOmF99erDQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: [Qemu-devel] [PATCH 36/43] gpi: made printf always compile in debug
 output
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, peter.maydell@linaro.org, gxt@mprc.pku.edu.cn

>From adb8f4b937b80629881ea23310a8d75ac4671b2a Mon Sep 17 00:00:00 2001
From: Danil Antonov <g.danil.anto@gmail.com>
Date: Wed, 29 Mar 2017 12:41:38 +0300
Subject: [PATCH 36/43] gpi: made printf always compile in debug output

Wrapped printf calls inside debug macros (DPRINTF) in `if` statement.
This will ensure that printf function will always compile even if debug
output is turned off and, in turn, will prevent bitrot of the format
strings.

Signed-off-by: Danil Antonov <g.danil.anto@gmail.com>
---
 hw/gpio/pl061.c     | 28 ++++++++++++++++------------
 hw/gpio/puv3_gpio.c |  8 ++++----
 2 files changed, 20 insertions(+), 16 deletions(-)

diff --git a/hw/gpio/pl061.c b/hw/gpio/pl061.c
index 4ae2aa1..af0de24 100644
--- a/hw/gpio/pl061.c
+++ b/hw/gpio/pl061.c
@@ -12,18 +12,22 @@
 #include "hw/sysbus.h"
 #include "qemu/log.h"

-//#define DEBUG_PL061 1
-
-#ifdef DEBUG_PL061
-#define DPRINTF(fmt, ...) \
-do { printf("pl061: " fmt , ## __VA_ARGS__); } while (0)
-#define BADF(fmt, ...) \
-do { fprintf(stderr, "pl061: error: " fmt , ## __VA_ARGS__); exit(1);}
while (0)
-#else
-#define DPRINTF(fmt, ...) do {} while(0)
-#define BADF(fmt, ...) \
-do { fprintf(stderr, "pl061: error: " fmt , ## __VA_ARGS__);} while (0)
-#endif
+#ifndef DEBUG_PL061
+#define DEBUG_PL061  0
+#endif
+
+#define DPRINTF(fmt, ...) do {                           \
+    if (DEBUG_PL061) {                                   \
+        fprintf(stderr, "pl061: " fmt , ## __VA_ARGS__); \
+    }                                                    \
+} while (0);
+
+#define BADF(fmt, ...) do {                                 \
+    fprintf(stderr, "pl061: error: " fmt , ## __VA_ARGS__); \
+    if (DEBUG_PL061) {                                      \
+        exit(1);                                            \
+    }                                                       \
+} while (0);

 static const uint8_t pl061_id[12] =
   { 0x00, 0x00, 0x00, 0x00, 0x61, 0x10, 0x04, 0x00, 0x0d, 0xf0, 0x05, 0xb1
};
diff --git a/hw/gpio/puv3_gpio.c b/hw/gpio/puv3_gpio.c
index 445afcc..48a8a4b 100644
--- a/hw/gpio/puv3_gpio.c
+++ b/hw/gpio/puv3_gpio.c
@@ -46,9 +46,9 @@ static uint64_t puv3_gpio_read(void *opaque, hwaddr
offset,
         ret = s->reg_GPIR;
         break;
     default:
-        DPRINTF("Bad offset 0x%x\n", offset);
+        DPRINTF("Bad offset 0x%lx\n", offset);
     }
-    DPRINTF("offset 0x%x, value 0x%x\n", offset, ret);
+    DPRINTF("offset 0x%lx, value 0x%x\n", offset, ret);

     return ret;
 }
@@ -58,7 +58,7 @@ static void puv3_gpio_write(void *opaque, hwaddr offset,
 {
     PUV3GPIOState *s = opaque;

-    DPRINTF("offset 0x%x, value 0x%x\n", offset, value);
+    DPRINTF("offset 0x%lx, value 0x%lx\n", offset, value);
     switch (offset) {
     case 0x04:
         s->reg_GPDR = value;
@@ -85,7 +85,7 @@ static void puv3_gpio_write(void *opaque, hwaddr offset,
         s->reg_GPIR = value;
         break;
     default:
-        DPRINTF("Bad offset 0x%x\n", offset);
+        DPRINTF("Bad offset 0x%lx\n", offset);
     }
 }

-- 
2.8.0.rc3
