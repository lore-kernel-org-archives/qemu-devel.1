Received: from eggs.gnu.org ([2001:4830:134:3::10]:54036)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <g.danil.anto@gmail.com>) id 1cuJU1-0004PH-Px
	for qemu-devel@nongnu.org; Sat, 01 Apr 2017 09:54:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <g.danil.anto@gmail.com>) id 1cuJU0-0002x3-DQ
	for qemu-devel@nongnu.org; Sat, 01 Apr 2017 09:54:25 -0400
Received: from mail-oi0-x242.google.com ([2607:f8b0:4003:c06::242]:35812)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <g.danil.anto@gmail.com>)
	id 1cuJU0-0002wt-6t
	for qemu-devel@nongnu.org; Sat, 01 Apr 2017 09:54:24 -0400
Received: by mail-oi0-x242.google.com with SMTP id d2so5868441oig.2
	for <qemu-devel@nongnu.org>; Sat, 01 Apr 2017 06:54:24 -0700 (PDT)
MIME-Version: 1.0
From: Danil Antonov <g.danil.anto@gmail.com>
Date: Sat, 1 Apr 2017 16:54:22 +0300
Message-ID: <CA+KKJYD=yKETyMtTKifS-fuwi9NYzOW7jxe9_c5+vpvxC6ZUHQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: [Qemu-devel] [PATCH 19/43] input: made printf always compile in
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

>From 2ff917db477911239c613f3b8f3605b12d669bfe Mon Sep 17 00:00:00 2001
From: Danil Antonov <g.danil.anto@gmail.com>
Date: Wed, 29 Mar 2017 12:31:47 +0300
Subject: [PATCH 19/43] input: made printf always compile in debug output

Wrapped printf calls inside debug macros (DPRINTF) in `if` statement.
This will ensure that printf function will always compile even if debug
output is turned off and, in turn, will prevent bitrot of the format
strings.

Signed-off-by: Danil Antonov <g.danil.anto@gmail.com>
---
 hw/input/adb.c     | 17 ++++++++++-------
 hw/input/pckbd.c   | 17 +++++++++++------
 hw/input/vmmouse.c | 15 ++++++++++-----
 3 files changed, 31 insertions(+), 18 deletions(-)

diff --git a/hw/input/adb.c b/hw/input/adb.c
index 43d3205..a8e0958 100644
--- a/hw/input/adb.c
+++ b/hw/input/adb.c
@@ -31,13 +31,16 @@

 /* debug ADB */
 //#define DEBUG_ADB
-
-#ifdef DEBUG_ADB
-#define ADB_DPRINTF(fmt, ...) \
-do { printf("ADB: " fmt , ## __VA_ARGS__); } while (0)
-#else
-#define ADB_DPRINTF(fmt, ...)
-#endif
+#ifndef DEBUG_ADB
+#define DEBUG_ADB 0
+#endif
+
+#define ADB_DPRINTF(fmt, ...)                                   \
+    do {                                                        \
+        if (DEBUG_ADB) {                                        \
+            fprintf(stderr, "ADB: " fmt , ## __VA_ARGS__);      \
+        }                                                       \
+    } while (0)

 /* ADB commands */
 #define ADB_BUSRESET        0x00
diff --git a/hw/input/pckbd.c b/hw/input/pckbd.c
index d414288..d886ab6 100644
--- a/hw/input/pckbd.c
+++ b/hw/input/pckbd.c
@@ -30,12 +30,17 @@

 /* debug PC keyboard */
 //#define DEBUG_KBD
-#ifdef DEBUG_KBD
-#define DPRINTF(fmt, ...)                                       \
-    do { printf("KBD: " fmt , ## __VA_ARGS__); } while (0)
-#else
-#define DPRINTF(fmt, ...)
-#endif
+
+#ifndef DEBUG_KBD
+#define DEBUG_KBD 0
+#endif
+
+#define DPRINTF(fmt, ...)                                     \
+    do {                                                      \
+        if (DEBUG_KBD) {                                      \
+            fprintf(stderr, "KDB: " fmt , ## __VA_ARGS__); \
+        }                                                     \
+    } while (0)

 /*    Keyboard Controller Commands */
 #define KBD_CCMD_READ_MODE    0x20    /* Read mode bits */
diff --git a/hw/input/vmmouse.c b/hw/input/vmmouse.c
index 6d15a88..2a4fa0a 100644
--- a/hw/input/vmmouse.c
+++ b/hw/input/vmmouse.c
@@ -46,11 +46,16 @@

 #define VMMOUSE_VERSION        0x3442554a

-#ifdef DEBUG_VMMOUSE
-#define DPRINTF(fmt, ...) printf(fmt, ## __VA_ARGS__)
-#else
-#define DPRINTF(fmt, ...) do { } while (0)
-#endif
+#ifndef DEBUG_VMMOUSE
+#define DEBUG_VMMOUSE 0
+#endif
+
+#define DPRINTF(fmt, ...)                          \
+    do {                                           \
+        if (DEBUG_VMMOUSE) {                       \
+            fprintf(stderr, fmt, ## __VA_ARGS__);  \
+        }                                          \
+    } while (0)

 #define TYPE_VMMOUSE "vmmouse"
 #define VMMOUSE(obj) OBJECT_CHECK(VMMouseState, (obj), TYPE_VMMOUSE)
-- 
2.8.0.rc3
