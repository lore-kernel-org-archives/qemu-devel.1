Received: from eggs.gnu.org ([2001:4830:134:3::10]:47082)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <g.danil.anto@gmail.com>) id 1cuJ8n-0001rX-Ac
	for qemu-devel@nongnu.org; Sat, 01 Apr 2017 09:32:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <g.danil.anto@gmail.com>) id 1cuJ8l-0006RQ-Tp
	for qemu-devel@nongnu.org; Sat, 01 Apr 2017 09:32:29 -0400
Received: from mail-oi0-x242.google.com ([2607:f8b0:4003:c06::242]:33928)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <g.danil.anto@gmail.com>)
	id 1cuJ8l-0006RI-N3
	for qemu-devel@nongnu.org; Sat, 01 Apr 2017 09:32:27 -0400
Received: by mail-oi0-x242.google.com with SMTP id t11so13165329oib.1
	for <qemu-devel@nongnu.org>; Sat, 01 Apr 2017 06:32:27 -0700 (PDT)
MIME-Version: 1.0
From: Danil Antonov <g.danil.anto@gmail.com>
Date: Sat, 1 Apr 2017 16:32:26 +0300
Message-ID: <CA+KKJYBN3Gu5jzToi61Qf2Un7jOTzB0HcfREnniUQhTe9B=GGg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: [Qemu-devel] [PATCH 02/43] arm: made printf always compile in debug
 output
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, peter.maydell@linaro.org, balrogg@gmail.com

>From 1671b92e5a4a59d5e38ce754d1d0dde2401c8236 Mon Sep 17 00:00:00 2001
From: Danil Antonov <g.danil.anto@gmail.com>
Date: Wed, 29 Mar 2017 02:09:33 +0300
Subject: [PATCH 02/43] arm: made printf always compile in debug output

Wrapped printf calls inside debug macros (DPRINTF) in `if` statement.
This will ensure that printf function will always compile even if debug
output is turned off and, in turn, will prevent bitrot of the format
strings.

Signed-off-by: Danil Antonov <g.danil.anto@gmail.com>
---
 hw/arm/strongarm.c | 17 +++++++++++------
 hw/arm/z2.c        | 16 ++++++++++------
 2 files changed, 21 insertions(+), 12 deletions(-)

diff --git a/hw/arm/strongarm.c b/hw/arm/strongarm.c
index 3311cc3..88368ac 100644
--- a/hw/arm/strongarm.c
+++ b/hw/arm/strongarm.c
@@ -59,11 +59,16 @@
  - Enhance UART with modem signals
  */

-#ifdef DEBUG
-# define DPRINTF(format, ...) printf(format , ## __VA_ARGS__)
-#else
-# define DPRINTF(format, ...) do { } while (0)
-#endif
+#ifndef DEBUG
+#define DEBUG 0
+#endif
+
+#define DPRINTF(fmt, ...)                         \
+    do {                                          \
+        if (DEBUG) {                              \
+            fprintf(stderr, fmt, ## __VA_ARGS__); \
+        }                                         \
+    } while (0)

 static struct {
     hwaddr io_base;
@@ -1022,7 +1027,7 @@ static void
strongarm_uart_update_parameters(StrongARMUARTState
*s)
     s->char_transmit_time =  (NANOSECONDS_PER_SECOND / speed) * frame_size;
     qemu_chr_fe_ioctl(&s->chr, CHR_IOCTL_SERIAL_SET_PARAMS, &ssp);

-    DPRINTF(stderr, "%s speed=%d parity=%c data=%d stop=%d\n",
s->chr->label,
+    DPRINTF("%s speed=%d parity=%c data=%d stop=%d\n", s->chr.chr->label,
             speed, parity, data_bits, stop_bits);
 }

diff --git a/hw/arm/z2.c b/hw/arm/z2.c
index 1607cbd..1ee8ed9 100644
--- a/hw/arm/z2.c
+++ b/hw/arm/z2.c
@@ -27,12 +27,16 @@
 #include "exec/address-spaces.h"
 #include "sysemu/qtest.h"

-#ifdef DEBUG_Z2
-#define DPRINTF(fmt, ...) \
-        printf(fmt, ## __VA_ARGS__)
-#else
-#define DPRINTF(fmt, ...)
-#endif
+#ifndef DEBUG_Z2
+#define DEBUG_Z2 0
+#endif
+
+#define DPRINTF(fmt, ...)                                \
+    do {                                                 \
+        if (DEBUG_Z2) {                                  \
+            fprintf(stderr, "z2: " fmt, ## __VA_ARGS__); \
+        }                                                \
+    } while (0)

 static const struct keymap map[0x100] = {
     [0 ... 0xff] = { -1, -1 },
-- 
2.8.0.rc3
