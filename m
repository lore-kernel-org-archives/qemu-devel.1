Received: from eggs.gnu.org ([2001:4830:134:3::10]:56321)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <g.danil.anto@gmail.com>) id 1cuJak-0000o0-LA
	for qemu-devel@nongnu.org; Sat, 01 Apr 2017 10:01:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <g.danil.anto@gmail.com>) id 1cuJaj-0006Mp-Ik
	for qemu-devel@nongnu.org; Sat, 01 Apr 2017 10:01:22 -0400
Received: from mail-oi0-x244.google.com ([2607:f8b0:4003:c06::244]:35880)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <g.danil.anto@gmail.com>)
	id 1cuJaj-0006M7-Cy
	for qemu-devel@nongnu.org; Sat, 01 Apr 2017 10:01:21 -0400
Received: by mail-oi0-x244.google.com with SMTP id b187so13225820oif.3
	for <qemu-devel@nongnu.org>; Sat, 01 Apr 2017 07:01:21 -0700 (PDT)
MIME-Version: 1.0
From: Danil Antonov <g.danil.anto@gmail.com>
Date: Sat, 1 Apr 2017 17:01:20 +0300
Message-ID: <CA+KKJYAu23=kNhZtWXnDx7R_R5rb3cP53CowR1F6Wi34iiZS7Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: [Qemu-devel] [PATCH 28/43] sparc64: made printf always compile in
 debug output
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, mark.cave-ayland@ilande.co.uk, atar4qemu@gmail.com

>From 825d7eda5d2900ef7eda37eeebf2b50ea445d50b Mon Sep 17 00:00:00 2001
From: Danil Antonov <g.danil.anto@gmail.com>
Date: Wed, 29 Mar 2017 12:38:23 +0300
Subject: [PATCH 28/43] sparc64: made printf always compile in debug output

Wrapped printf calls inside debug macros (DPRINTF) in `if` statement.
This will ensure that printf function will always compile even if debug
output is turned off and, in turn, will prevent bitrot of the format
strings.

Signed-off-by: Danil Antonov <g.danil.anto@gmail.com>
---
 hw/sparc64/sparc64.c | 36 +++++++++++++++++++-----------------
 hw/sparc64/sun4u.c   | 16 +++++++++-------
 2 files changed, 28 insertions(+), 24 deletions(-)

diff --git a/hw/sparc64/sparc64.c b/hw/sparc64/sparc64.c
index 4e4fdab..2f1136f 100644
--- a/hw/sparc64/sparc64.c
+++ b/hw/sparc64/sparc64.c
@@ -29,23 +29,25 @@
 #include "hw/sparc/sparc64.h"
 #include "qemu/timer.h"

-
-//#define DEBUG_IRQ
-//#define DEBUG_TIMER
-
-#ifdef DEBUG_IRQ
-#define CPUIRQ_DPRINTF(fmt, ...)                                \
-    do { printf("CPUIRQ: " fmt , ## __VA_ARGS__); } while (0)
-#else
-#define CPUIRQ_DPRINTF(fmt, ...)
-#endif
-
-#ifdef DEBUG_TIMER
-#define TIMER_DPRINTF(fmt, ...)                                  \
-    do { printf("TIMER: " fmt , ## __VA_ARGS__); } while (0)
-#else
-#define TIMER_DPRINTF(fmt, ...)
-#endif
+#ifndef DEBUG_IRQ
+#define DEBUG_IRQ 0
+#endif
+
+#ifndef DEBUG_TIMER
+#define DEBUG_TIMER 0
+#endif
+
+#define CPUIRQ_DPRINTF(fmt, ...) do {                     \
+    if (DEBUG_IRQ) {                                      \
+        fprintf(stderr, "CPUIRQ: " fmt , ## __VA_ARGS__); \
+    }                                                     \
+} while (0);
+
+#define TIMER_DPRINTF(fmt, ...) do {                     \
+    if (DEBUG_TIMER) {                                   \
+        fprintf(stderr, "TIMER: " fmt , ## __VA_ARGS__); \
+    }                                                    \
+} while (0);

 #define TICK_MAX             0x7fffffffffffffffULL

diff --git a/hw/sparc64/sun4u.c b/hw/sparc64/sun4u.c
index d347b66..c27b738 100644
--- a/hw/sparc64/sun4u.c
+++ b/hw/sparc64/sun4u.c
@@ -46,14 +46,16 @@
 #include "elf.h"
 #include "qemu/cutils.h"

-//#define DEBUG_EBUS

-#ifdef DEBUG_EBUS
-#define EBUS_DPRINTF(fmt, ...)                                  \
-    do { printf("EBUS: " fmt , ## __VA_ARGS__); } while (0)
-#else
-#define EBUS_DPRINTF(fmt, ...)
-#endif
+#ifndef DEBUG_EBUS
+#define DEBUG_EBUS 0
+#endif
+
+#define EBUS_DPRINTF(fmt, ...) do {                     \
+    if (DEBUG_EBUS) {                                   \
+        fprintf(stderr, "EBUS: " fmt , ## __VA_ARGS__); \
+    }                                                   \
+} while (0);

 #define KERNEL_LOAD_ADDR     0x00404000
 #define CMDLINE_ADDR         0x003ff000
-- 
2.8.0.rc3
