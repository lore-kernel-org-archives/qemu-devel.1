Received: from eggs.gnu.org ([2001:4830:134:3::10]:56913)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <g.danil.anto@gmail.com>) id 1cuJbl-0001fK-Tf
	for qemu-devel@nongnu.org; Sat, 01 Apr 2017 10:02:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <g.danil.anto@gmail.com>) id 1cuJbk-00075A-Nc
	for qemu-devel@nongnu.org; Sat, 01 Apr 2017 10:02:25 -0400
Received: from mail-oi0-x241.google.com ([2607:f8b0:4003:c06::241]:33086)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <g.danil.anto@gmail.com>)
	id 1cuJbk-00074Y-Hn
	for qemu-devel@nongnu.org; Sat, 01 Apr 2017 10:02:24 -0400
Received: by mail-oi0-x241.google.com with SMTP id f193so13240197oib.0
	for <qemu-devel@nongnu.org>; Sat, 01 Apr 2017 07:02:24 -0700 (PDT)
MIME-Version: 1.0
From: Danil Antonov <g.danil.anto@gmail.com>
Date: Sat, 1 Apr 2017 17:02:23 +0300
Message-ID: <CA+KKJYCWDTS9NAD59Q-nCi1MLwGY8+gqVAgMTZHuAc70ouuW0Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: [Qemu-devel] [PATCH 30/43] block: made printf always compile in
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

>From 63139dc0a7e3b5c8caa1ecf6fbe900372fddeba0 Mon Sep 17 00:00:00 2001
From: Danil Antonov <g.danil.anto@gmail.com>
Date: Wed, 29 Mar 2017 12:39:12 +0300
Subject: [PATCH 30/43] block: made printf always compile in debug output

Wrapped printf calls inside debug macros (DPRINTF) in `if` statement.
This will ensure that printf function will always compile even if debug
output is turned off and, in turn, will prevent bitrot of the format
strings.

Signed-off-by: Danil Antonov <g.danil.anto@gmail.com>
---
 hw/block/pflash_cfi01.c | 18 +++++++++---------
 hw/block/pflash_cfi02.c | 19 +++++++++++--------
 2 files changed, 20 insertions(+), 17 deletions(-)

diff --git a/hw/block/pflash_cfi01.c b/hw/block/pflash_cfi01.c
index 594d4cf..6e07ad7 100644
--- a/hw/block/pflash_cfi01.c
+++ b/hw/block/pflash_cfi01.c
@@ -55,15 +55,15 @@ do { \
     exit(1); \
 } while(0)

-/* #define PFLASH_DEBUG */
-#ifdef PFLASH_DEBUG
-#define DPRINTF(fmt, ...)                                   \
-do {                                                        \
-    fprintf(stderr, "PFLASH: " fmt , ## __VA_ARGS__);       \
-} while (0)
-#else
-#define DPRINTF(fmt, ...) do { } while (0)
-#endif
+#ifndef PFLASH_DEBUG
+#define PFLASH_DEBUG 0
+#endif
+
+#define DPRINTF(fmt, ...) do {                           \
+    if (PFLASH_DEBUG) {                                  \
+        fprintf(stderr, "PFLASH: " fmt, ## __VA_ARGS__); \
+    }                                                    \
+} while (0);

 #define CFI_PFLASH01(obj) OBJECT_CHECK(pflash_t, (obj), TYPE_CFI_PFLASH01)

diff --git a/hw/block/pflash_cfi02.c b/hw/block/pflash_cfi02.c
index e6c5c6c..be35bca 100644
--- a/hw/block/pflash_cfi02.c
+++ b/hw/block/pflash_cfi02.c
@@ -46,14 +46,17 @@
 #include "hw/sysbus.h"

 //#define PFLASH_DEBUG
-#ifdef PFLASH_DEBUG
-#define DPRINTF(fmt, ...)                                  \
-do {                                                       \
-    fprintf(stderr, "PFLASH: " fmt , ## __VA_ARGS__);       \
-} while (0)
-#else
-#define DPRINTF(fmt, ...) do { } while (0)
-#endif
+
+#ifndef PFLASH_DEBUG
+#define PFLASH_DEBUG 0
+#endif
+
+#define DPRINTF(fmt, ...) do {                           \
+    if (PFLASH_DEBUG) {                                  \
+        fprintf(stderr, "PFLASH: " fmt, ## __VA_ARGS__); \
+    }                                                    \
+} while (0);
+

 #define PFLASH_LAZY_ROMD_THRESHOLD 42

-- 
2.8.0.rc3
