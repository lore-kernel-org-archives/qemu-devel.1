Received: from eggs.gnu.org ([2001:4830:134:3::10]:54461)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <g.danil.anto@gmail.com>) id 1cuJW5-0005ZR-FE
	for qemu-devel@nongnu.org; Sat, 01 Apr 2017 09:56:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <g.danil.anto@gmail.com>) id 1cuJW4-00040B-4M
	for qemu-devel@nongnu.org; Sat, 01 Apr 2017 09:56:33 -0400
Received: from mail-oi0-x243.google.com ([2607:f8b0:4003:c06::243]:36533)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <g.danil.anto@gmail.com>)
	id 1cuJW3-000400-Ug
	for qemu-devel@nongnu.org; Sat, 01 Apr 2017 09:56:32 -0400
Received: by mail-oi0-x243.google.com with SMTP id b187so13213520oif.3
	for <qemu-devel@nongnu.org>; Sat, 01 Apr 2017 06:56:31 -0700 (PDT)
MIME-Version: 1.0
From: Danil Antonov <g.danil.anto@gmail.com>
Date: Sat, 1 Apr 2017 16:56:30 +0300
Message-ID: <CA+KKJYBi31Bs7DtVdzZdwG2t+u5+FGiAhQpd3pqJzUX1O8Cprg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: [Qemu-devel] [PATCH 21/43] s390: made printf always compile in
 debug output
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, rth@twiddle.net

>From cbc3425092b6ee94d6666365f8714a39af5a583a Mon Sep 17 00:00:00 2001
From: Danil Antonov <g.danil.anto@gmail.com>
Date: Wed, 29 Mar 2017 12:33:01 +0300
Subject: [PATCH 21/43] s390: made printf always compile in debug output

Wrapped printf calls inside debug macros (DPRINTF) in `if` statement.
This will ensure that printf function will always compile even if debug
output is turned off and, in turn, will prevent bitrot of the format
strings.

Signed-off-by: Danil Antonov <g.danil.anto@gmail.com>
---
 hw/s390x/s390-pci-bus.c  | 18 +++++++++++-------
 hw/s390x/s390-pci-inst.c | 18 +++++++++++-------
 2 files changed, 22 insertions(+), 14 deletions(-)

diff --git a/hw/s390x/s390-pci-bus.c b/hw/s390x/s390-pci-bus.c
index 69b0291..6dd9bca 100644
--- a/hw/s390x/s390-pci-bus.c
+++ b/hw/s390x/s390-pci-bus.c
@@ -24,13 +24,17 @@
 #include "qemu/error-report.h"

 /* #define DEBUG_S390PCI_BUS */
-#ifdef DEBUG_S390PCI_BUS
-#define DPRINTF(fmt, ...) \
-    do { fprintf(stderr, "S390pci-bus: " fmt, ## __VA_ARGS__); } while (0)
-#else
-#define DPRINTF(fmt, ...) \
-    do { } while (0)
-#endif
+
+#ifndef DEBUG_S390PCI_BUS
+#define DEBUG_S390PCI_BUS  0
+#endif
+
+#define DPRINTF(fmt, ...)                                         \
+    do {                                                          \
+        if (DEBUG_S390PCI_BUS) {                                  \
+            fprintf(stderr, "S390pci-bus: " fmt, ## __VA_ARGS__); \
+        }                                                         \
+    } while (0)

 S390pciState *s390_get_phb(void)
 {
diff --git a/hw/s390x/s390-pci-inst.c b/hw/s390x/s390-pci-inst.c
index d2a8c0a..82b5617 100644
--- a/hw/s390x/s390-pci-inst.c
+++ b/hw/s390x/s390-pci-inst.c
@@ -21,13 +21,17 @@
 #include "sysemu/hw_accel.h"

 /* #define DEBUG_S390PCI_INST */
-#ifdef DEBUG_S390PCI_INST
-#define DPRINTF(fmt, ...) \
-    do { fprintf(stderr, "s390pci-inst: " fmt, ## __VA_ARGS__); } while (0)
-#else
-#define DPRINTF(fmt, ...) \
-    do { } while (0)
-#endif
+
+#ifndef DEBUG_S390PCI_INST
+#define DEBUG_S390PCI_INST  0
+#endif
+
+#define DPRINTF(fmt, ...)                                          \
+    do {                                                           \
+        if (DEBUG_S390PCI_INST) {                                  \
+            fprintf(stderr, "s390pci-inst: " fmt, ## __VA_ARGS__); \
+        }                                                          \
+    } while (0)

 static void s390_set_status_code(CPUS390XState *env,
                                  uint8_t r, uint64_t status_code)
-- 
2.8.0.rc3
