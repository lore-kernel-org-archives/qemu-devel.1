Received: from eggs.gnu.org ([2001:4830:134:3::10]:50746)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <g.danil.anto@gmail.com>) id 1cuJNG-0000Zp-Hu
	for qemu-devel@nongnu.org; Sat, 01 Apr 2017 09:47:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <g.danil.anto@gmail.com>) id 1cuJN9-0000RT-Us
	for qemu-devel@nongnu.org; Sat, 01 Apr 2017 09:47:26 -0400
Received: from mail-oi0-x243.google.com ([2607:f8b0:4003:c06::243]:33959)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <g.danil.anto@gmail.com>)
	id 1cuJN9-0000R5-OL
	for qemu-devel@nongnu.org; Sat, 01 Apr 2017 09:47:19 -0400
Received: by mail-oi0-x243.google.com with SMTP id t11so13200326oib.1
	for <qemu-devel@nongnu.org>; Sat, 01 Apr 2017 06:47:19 -0700 (PDT)
MIME-Version: 1.0
From: Danil Antonov <g.danil.anto@gmail.com>
Date: Sat, 1 Apr 2017 16:47:18 +0300
Message-ID: <CA+KKJYDwb6n_=YCSOTxpYu5SnEOZn3zakAaBt3c=N8u7AiAQ=Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: [Qemu-devel] [PATCH 12/43] sd: made printf always compile in debug
 output
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, peter.maydell@linaro.org

>From 78c7cc133ba566b13afe6e9924e174b6d081e393 Mon Sep 17 00:00:00 2001
From: Danil Antonov <g.danil.anto@gmail.com>
Date: Wed, 29 Mar 2017 12:27:24 +0300
Subject: [PATCH 12/43] sd: made printf always compile in debug output

Wrapped printf calls inside debug macros (DPRINTF) in `if` statement.
This will ensure that printf function will always compile even if debug
output is turned off and, in turn, will prevent bitrot of the format
strings.

Signed-off-by: Danil Antonov <g.danil.anto@gmail.com>
---
 hw/sd/pl181.c  | 16 ++++++++++------
 hw/sd/sd.c     | 14 +++++++++-----
 hw/sd/ssi-sd.c | 27 +++++++++++++++++----------
 3 files changed, 36 insertions(+), 21 deletions(-)

diff --git a/hw/sd/pl181.c b/hw/sd/pl181.c
index 82c63a4..e4d350f 100644
--- a/hw/sd/pl181.c
+++ b/hw/sd/pl181.c
@@ -16,14 +16,18 @@
 #include "qapi/error.h"

 //#define DEBUG_PL181 1
-
-#ifdef DEBUG_PL181
-#define DPRINTF(fmt, ...) \
-do { printf("pl181: " fmt , ## __VA_ARGS__); } while (0)
-#else
-#define DPRINTF(fmt, ...) do {} while(0)
+//
+#ifndef DEBUG_PL181
+#define DEBUG_PL181 0
 #endif

+#define DPRINTF(fmt, ...)                                   \
+    do {                                                    \
+        if (DEBUG_PL181) {                                  \
+            fprintf(stderr, "pl181: " fmt, ## __VA_ARGS__); \
+        }                                                   \
+    } while (0)
+
 #define PL181_FIFO_LEN 16

 #define TYPE_PL181 "pl181"
diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index ba47bff..f2cd369 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -43,13 +43,17 @@

 //#define DEBUG_SD 1

-#ifdef DEBUG_SD
-#define DPRINTF(fmt, ...) \
-do { fprintf(stderr, "SD: " fmt , ## __VA_ARGS__); } while (0)
-#else
-#define DPRINTF(fmt, ...) do {} while(0)
+#ifndef DEBUG_SD
+#define DEBUG_SD 0
 #endif

+#define DPRINTF(fmt, ...)                                \
+    do {                                                 \
+        if (DEBUG_SD) {                                  \
+            fprintf(stderr, "SD: " fmt, ## __VA_ARGS__); \
+        }                                                \
+    } while (0)
+
 #define ACMD41_ENQUIRY_MASK     0x00ffffff
 #define OCR_POWER_UP            0x80000000
 #define OCR_POWER_DELAY_NS      500000 /* 0.5ms */
diff --git a/hw/sd/ssi-sd.c b/hw/sd/ssi-sd.c
index 24001dc..c8168ae 100644
--- a/hw/sd/ssi-sd.c
+++ b/hw/sd/ssi-sd.c
@@ -18,18 +18,25 @@
 #include "qapi/error.h"

 //#define DEBUG_SSI_SD 1
-
-#ifdef DEBUG_SSI_SD
-#define DPRINTF(fmt, ...) \
-do { printf("ssi_sd: " fmt , ## __VA_ARGS__); } while (0)
-#define BADF(fmt, ...) \
-do { fprintf(stderr, "ssi_sd: error: " fmt , ## __VA_ARGS__); exit(1);}
while (0)
-#else
-#define DPRINTF(fmt, ...) do {} while(0)
-#define BADF(fmt, ...) \
-do { fprintf(stderr, "ssi_sd: error: " fmt , ## __VA_ARGS__);} while (0)
+#ifndef DEBUG_SSI_SD
+#define DEBUG_SSI_SD 0
 #endif

+#define DPRINTF(fmt, ...)                                    \
+    do {                                                     \
+        if (DEBUG_SSI_SD) {                                  \
+            fprintf(stderr, "ssi_sd: " fmt, ## __VA_ARGS__); \
+        }                                                    \
+    } while (0)
+
+#define BADF(fmt, ...)                                          \
+    do {                                                        \
+        fprintf(stderr, "ssi_sd: error: " fmt, ## __VA_ARGS__); \
+        if (DEBUG_SSI_SD) {                                     \
+            exit(1);                                            \
+        }                                                       \
+    } while (0)
+
 typedef enum {
     SSI_SD_CMD = 0,
     SSI_SD_CMDARG,
-- 
2.8.0.rc3
