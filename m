Received: from eggs.gnu.org ([2001:4830:134:3::10]:57156)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <g.danil.anto@gmail.com>) id 1cuJcS-0002BX-FX
	for qemu-devel@nongnu.org; Sat, 01 Apr 2017 10:03:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <g.danil.anto@gmail.com>) id 1cuJcR-0007YG-00
	for qemu-devel@nongnu.org; Sat, 01 Apr 2017 10:03:08 -0400
Received: from mail-oi0-x241.google.com ([2607:f8b0:4003:c06::241]:36062)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <g.danil.anto@gmail.com>)
	id 1cuJcQ-0007Y9-Or
	for qemu-devel@nongnu.org; Sat, 01 Apr 2017 10:03:06 -0400
Received: by mail-oi0-x241.google.com with SMTP id b187so13230787oif.3
	for <qemu-devel@nongnu.org>; Sat, 01 Apr 2017 07:03:06 -0700 (PDT)
MIME-Version: 1.0
From: Danil Antonov <g.danil.anto@gmail.com>
Date: Sat, 1 Apr 2017 17:03:05 +0300
Message-ID: <CA+KKJYBYd5C4JYcFXeP9yxnaNMG=LSO7V2yHZMj3C5AUG2j5_g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: [Qemu-devel] [PATCH 31/43] display: made printf always compile in
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

>From 40bba9c5cdb7060dd01d1c7d81140779e45a489d Mon Sep 17 00:00:00 2001
From: Danil Antonov <g.danil.anto@gmail.com>
Date: Wed, 29 Mar 2017 12:39:40 +0300
Subject: [PATCH 31/43] display: made printf always compile in debug output

Wrapped printf calls inside debug macros (DPRINTF) in `if` statement.
This will ensure that printf function will always compile even if debug
output is turned off and, in turn, will prevent bitrot of the format
strings.

Signed-off-by: Danil Antonov <g.danil.anto@gmail.com>
---
 hw/display/sm501.c   | 15 ++++++++++-----
 hw/display/ssd0303.c | 26 +++++++++++++++-----------
 hw/display/ssd0323.c | 28 +++++++++++++++-------------
 3 files changed, 40 insertions(+), 29 deletions(-)

diff --git a/hw/display/sm501.c b/hw/display/sm501.c
index 040a0b9..ff16613 100644
--- a/hw/display/sm501.c
+++ b/hw/display/sm501.c
@@ -52,11 +52,16 @@
 //#define DEBUG_SM501
 //#define DEBUG_BITBLT

-#ifdef DEBUG_SM501
-#define SM501_DPRINTF(fmt, ...) printf(fmt, ## __VA_ARGS__)
-#else
-#define SM501_DPRINTF(fmt, ...) do {} while(0)
-#endif
+#ifndef DEBUG_SM501
+#define DEBUG_SM501 0
+#endif
+
+#define SM501_DPRINTF(fmt, ...)                   \
+    do {                                          \
+        if (DEBUG_SM501) {                        \
+            fprintf(stderr, fmt, ## __VA_ARGS__); \
+        }                                         \
+    } while (0)


 #define MMIO_BASE_OFFSET 0x3e00000
diff --git a/hw/display/ssd0303.c b/hw/display/ssd0303.c
index 68a80b9..35ce7c4 100644
--- a/hw/display/ssd0303.c
+++ b/hw/display/ssd0303.c
@@ -14,18 +14,22 @@
 #include "hw/i2c/i2c.h"
 #include "ui/console.h"

-//#define DEBUG_SSD0303 1
+#ifndef DEBUG_SSD0303
+#define DEBUG_SSD0303 0
+#endif

-#ifdef DEBUG_SSD0303
-#define DPRINTF(fmt, ...) \
-do { printf("ssd0303: " fmt , ## __VA_ARGS__); } while (0)
-#define BADF(fmt, ...) \
-do { fprintf(stderr, "ssd0303: error: " fmt , ## __VA_ARGS__); exit(1);}
while (0)
-#else
-#define DPRINTF(fmt, ...) do {} while(0)
-#define BADF(fmt, ...) \
-do { fprintf(stderr, "ssd0303: error: " fmt , ## __VA_ARGS__);} while (0)
-#endif
+#define DPRINTF(fmt, ...) do {                    \
+    if (DEBUG_SSD0303) {                          \
+        fprintf(stderr, "ssd0303: " fmt , ## __VA_ARGS__); \
+    }                                             \
+} while (0);
+
+#define BADF(fmt, ...) do {                                   \
+    fprintf(stderr, "ssd0303: error: " fmt , ## __VA_ARGS__); \
+    if (DEBUG_SSD0303) {                                      \
+        exit(1);                                              \
+    }                                                         \
+} while (0);

 /* Scaling factor for pixels.  */
 #define MAGNIFY 4
diff --git a/hw/display/ssd0323.c b/hw/display/ssd0323.c
index e182893..70b1e33 100644
--- a/hw/display/ssd0323.c
+++ b/hw/display/ssd0323.c
@@ -14,20 +14,22 @@
 #include "hw/ssi/ssi.h"
 #include "ui/console.h"

-//#define DEBUG_SSD0323 1
+#ifndef DEBUG_SSD0323
+#define DEBUG_SSD0323 0
+#endif

-#ifdef DEBUG_SSD0323
-#define DPRINTF(fmt, ...) \
-do { printf("ssd0323: " fmt , ## __VA_ARGS__); } while (0)
-#define BADF(fmt, ...) \
-do { \
-    fprintf(stderr, "ssd0323: error: " fmt , ## __VA_ARGS__); abort(); \
-} while (0)
-#else
-#define DPRINTF(fmt, ...) do {} while(0)
-#define BADF(fmt, ...) \
-do { fprintf(stderr, "ssd0323: error: " fmt , ## __VA_ARGS__);} while (0)
-#endif
+#define DPRINTF(fmt, ...) do {                    \
+    if (DEBUG_SSD0323) {                          \
+        fprintf(stderr, "ssd0323: " fmt , ## __VA_ARGS__); \
+    }                                             \
+} while (0);
+
+#define BADF(fmt, ...) do {                                   \
+    fprintf(stderr, "ssd0323: error: " fmt , ## __VA_ARGS__); \
+    if (DEBUG_SSD0323) {                                      \
+        abort();                                              \
+    }                                                         \
+} while (0);

 /* Scaling factor for pixels.  */
 #define MAGNIFY 4
-- 
2.8.0.rc3
