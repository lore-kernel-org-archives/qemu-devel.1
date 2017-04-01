Received: from eggs.gnu.org ([2001:4830:134:3::10]:50214)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <g.danil.anto@gmail.com>) id 1cuJMc-0000FG-94
	for qemu-devel@nongnu.org; Sat, 01 Apr 2017 09:46:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <g.danil.anto@gmail.com>) id 1cuJMa-0000Bq-OL
	for qemu-devel@nongnu.org; Sat, 01 Apr 2017 09:46:46 -0400
Received: from mail-oi0-x243.google.com ([2607:f8b0:4003:c06::243]:33921)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <g.danil.anto@gmail.com>)
	id 1cuJMa-0000Bf-HG
	for qemu-devel@nongnu.org; Sat, 01 Apr 2017 09:46:44 -0400
Received: by mail-oi0-x243.google.com with SMTP id t11so13198959oib.1
	for <qemu-devel@nongnu.org>; Sat, 01 Apr 2017 06:46:44 -0700 (PDT)
MIME-Version: 1.0
From: Danil Antonov <g.danil.anto@gmail.com>
Date: Sat, 1 Apr 2017 16:46:43 +0300
Message-ID: <CA+KKJYD+tAuhKGaCv8SqyA5p2K_hesz+vhUK13cKggpPu36EZA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: [Qemu-devel] [PATCH 11/43] scsi: made printf always compile in
 debug output
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, pbonzini@redhat.com

>From 48b18f304de1761128e8cccbb517ddad4346c824 Mon Sep 17 00:00:00 2001
From: Danil Antonov <g.danil.anto@gmail.com>
Date: Wed, 29 Mar 2017 12:26:43 +0300
Subject: [PATCH 11/43] scsi: made printf always compile in debug output

Wrapped printf calls inside debug macros (DPRINTF) in `if` statement.
This will ensure that printf function will always compile even if debug
output is turned off and, in turn, will prevent bitrot of the format
strings.

Signed-off-by: Danil Antonov <g.danil.anto@gmail.com>
---
 hw/scsi/lsi53c895a.c   | 26 ++++++++++++++++----------
 hw/scsi/scsi-disk.c    | 17 ++++++++++-------
 hw/scsi/scsi-generic.c | 17 +++++++++--------
 3 files changed, 35 insertions(+), 25 deletions(-)

diff --git a/hw/scsi/lsi53c895a.c b/hw/scsi/lsi53c895a.c
index 595c260..379db4b 100644
--- a/hw/scsi/lsi53c895a.c
+++ b/hw/scsi/lsi53c895a.c
@@ -24,16 +24,22 @@
 //#define DEBUG_LSI
 //#define DEBUG_LSI_REG

-#ifdef DEBUG_LSI
-#define DPRINTF(fmt, ...) \
-do { printf("lsi_scsi: " fmt , ## __VA_ARGS__); } while (0)
-#define BADF(fmt, ...) \
-do { fprintf(stderr, "lsi_scsi: error: " fmt , ## __VA_ARGS__); exit(1);}
while (0)
-#else
-#define DPRINTF(fmt, ...) do {} while(0)
-#define BADF(fmt, ...) \
-do { fprintf(stderr, "lsi_scsi: error: " fmt , ## __VA_ARGS__);} while (0)
-#endif
+#ifndef DEBUG_LSI
+#define DEBUG_LSI 0
+#endif
+
+#define DPRINTF(fmt, ...) do {                              \
+    if (DEBUG_LSI) {                                        \
+        fprintf(stderr, "lsi_scsi: " fmt , ## __VA_ARGS__); \
+    }                                                       \
+} while (0);
+
+#define BADF(fmt, ...) do {                                    \
+    fprintf(stderr, "lsi_scsi: error: " fmt , ## __VA_ARGS__); \
+    if (DEBUG_LSI) {                                           \
+        exit(1);                                               \
+    }                                                          \
+} while (0);

 static const char *names[] = {
     "SCNTL0", "SCNTL1", "SCNTL2", "SCNTL3", "SCID", "SXFER", "SDID",
"GPREG",
diff --git a/hw/scsi/scsi-disk.c b/hw/scsi/scsi-disk.c
index a53f058..33213df 100644
--- a/hw/scsi/scsi-disk.c
+++ b/hw/scsi/scsi-disk.c
@@ -19,14 +19,17 @@
  * the host adapter emulator.
  */

-//#define DEBUG_SCSI

-#ifdef DEBUG_SCSI
-#define DPRINTF(fmt, ...) \
-do { printf("scsi-disk: " fmt , ## __VA_ARGS__); } while (0)
-#else
-#define DPRINTF(fmt, ...) do {} while(0)
-#endif
+#ifndef DEBUG_SCSI
+#define DEBUG_SCSI 0
+#endif
+
+#define DPRINTF(fmt, ...) do {                               \
+    if (DEBUG_SCSI) {                                        \
+        fprintf(stderr, "scsi-disk: " fmt , ## __VA_ARGS__); \
+    }                                                        \
+} while (0);
+

 #include "qemu/osdep.h"
 #include "qapi/error.h"
diff --git a/hw/scsi/scsi-generic.c b/hw/scsi/scsi-generic.c
index a55ff87..dcd3c08 100644
--- a/hw/scsi/scsi-generic.c
+++ b/hw/scsi/scsi-generic.c
@@ -21,14 +21,15 @@

 #ifdef __linux__

-//#define DEBUG_SCSI
-
-#ifdef DEBUG_SCSI
-#define DPRINTF(fmt, ...) \
-do { printf("scsi-generic: " fmt , ## __VA_ARGS__); } while (0)
-#else
-#define DPRINTF(fmt, ...) do {} while(0)
-#endif
+#ifndef DEBUG_SCSI
+#define DEBUG_SCSI 0
+#endif
+
+#define DPRINTF(fmt, ...) do {                                  \
+    if (DEBUG_SCSI) {                                           \
+        fprintf(stderr, "scsi-generic: " fmt , ## __VA_ARGS__); \
+    }                                                           \
+} while (0);

 #define BADF(fmt, ...) \
 do { fprintf(stderr, "scsi-generic: " fmt , ## __VA_ARGS__); } while (0)
-- 
2.8.0.rc3
