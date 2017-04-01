Received: from eggs.gnu.org ([2001:4830:134:3::10]:46995)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <g.danil.anto@gmail.com>) id 1cuJ8W-0001gQ-KP
	for qemu-devel@nongnu.org; Sat, 01 Apr 2017 09:32:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <g.danil.anto@gmail.com>) id 1cuJ8V-0006Lk-EG
	for qemu-devel@nongnu.org; Sat, 01 Apr 2017 09:32:12 -0400
Received: from mail-oi0-x244.google.com ([2607:f8b0:4003:c06::244]:33895)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <g.danil.anto@gmail.com>)
	id 1cuJ8V-0006KE-76
	for qemu-devel@nongnu.org; Sat, 01 Apr 2017 09:32:11 -0400
Received: by mail-oi0-x244.google.com with SMTP id t11so13164616oib.1
	for <qemu-devel@nongnu.org>; Sat, 01 Apr 2017 06:32:09 -0700 (PDT)
MIME-Version: 1.0
From: Danil Antonov <g.danil.anto@gmail.com>
Date: Sat, 1 Apr 2017 16:32:08 +0300
Message-ID: <CA+KKJYCHT1kyH0Ha+kRrK_G12m8ip7dxNiQEG+7mou5MavZY=w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: [Qemu-devel] [PATCH 01/43] acpi: made printf always compile in
 debug output
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, imammedo@redhat.com, mst@redhat.com

>From 8127ae68568b3c6876a5ee58a74e5ef0439f548a Mon Sep 17 00:00:00 2001
From: Danil Antonov <g.danil.anto@gmail.com>
Date: Wed, 29 Mar 2017 01:59:37 +0300
Subject: [PATCH 01/43] acpi: made printf always compile in debug output

Wrapped printf calls inside debug macros (DPRINTF) in `if` statement.
This will ensure that printf function will always compile even if debug
output is turned off and, in turn, will prevent bitrot of the format
strings.

Signed-off-by: Danil Antonov <g.danil.anto@gmail.com>
---
 hw/acpi/pcihp.c | 15 +++++++++------
 hw/acpi/piix4.c | 16 +++++++++-------
 2 files changed, 18 insertions(+), 13 deletions(-)

diff --git a/hw/acpi/pcihp.c b/hw/acpi/pcihp.c
index 2b0f3e1..bf880c1 100644
--- a/hw/acpi/pcihp.c
+++ b/hw/acpi/pcihp.c
@@ -39,13 +39,16 @@
 #include "qom/qom-qobject.h"
 #include "qapi/qmp/qint.h"

-//#define DEBUG

-#ifdef DEBUG
-# define ACPI_PCIHP_DPRINTF(format, ...)     printf(format, ## __VA_ARGS__)
-#else
-# define ACPI_PCIHP_DPRINTF(format, ...)     do { } while (0)
-#endif
+#ifndef DEBUG
+#define DEBUG 0
+#endif
+
+#define ACPI_PCIHP_DPRINTF(fmt, ...) do {     \
+    if (DEBUG) {                              \
+        fprintf(stderr, fmt, ## __VA_ARGS__); \
+    }                                         \
+} while (0);

 #define ACPI_PCIHP_ADDR 0xae00
 #define ACPI_PCIHP_SIZE 0x0014
diff --git a/hw/acpi/piix4.c b/hw/acpi/piix4.c
index a553a7e..34e85b4 100644
--- a/hw/acpi/piix4.c
+++ b/hw/acpi/piix4.c
@@ -42,13 +42,15 @@
 #include "hw/xen/xen.h"
 #include "qom/cpu.h"

-//#define DEBUG
-
-#ifdef DEBUG
-# define PIIX4_DPRINTF(format, ...)     printf(format, ## __VA_ARGS__)
-#else
-# define PIIX4_DPRINTF(format, ...)     do { } while (0)
-#endif
+#ifndef DEBUG
+#define DEBUG 0
+#endif
+
+#define PIIX4_DPRINTF(fmt, ...) do {                    \
+    if (DEBUG) {                          \
+        fprintf(stderr, fmt, ## __VA_ARGS__); \
+    }                                             \
+} while (0);

 #define GPE_BASE 0xafe0
 #define GPE_LEN 4
--
2.8.0.rc3
