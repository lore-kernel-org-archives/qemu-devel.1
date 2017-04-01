Received: from eggs.gnu.org ([2001:4830:134:3::10]:59050)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <g.danil.anto@gmail.com>) id 1cuJj7-0007PD-EG
	for qemu-devel@nongnu.org; Sat, 01 Apr 2017 10:10:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <g.danil.anto@gmail.com>) id 1cuJj6-0003z4-Bl
	for qemu-devel@nongnu.org; Sat, 01 Apr 2017 10:10:01 -0400
Received: from mail-oi0-x241.google.com ([2607:f8b0:4003:c06::241]:34483)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <g.danil.anto@gmail.com>)
	id 1cuJj6-0003yt-50
	for qemu-devel@nongnu.org; Sat, 01 Apr 2017 10:10:00 -0400
Received: by mail-oi0-x241.google.com with SMTP id t11so13257094oib.1
	for <qemu-devel@nongnu.org>; Sat, 01 Apr 2017 07:10:00 -0700 (PDT)
MIME-Version: 1.0
From: Danil Antonov <g.danil.anto@gmail.com>
Date: Sat, 1 Apr 2017 17:09:59 +0300
Message-ID: <CA+KKJYAyM24zeM6VaGtpJf3Mm_p2MjnVg=FZm6JKASXw8ed5MQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: [Qemu-devel] [PATCH 43/43] ssi: made printf always compile in debug
 output
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, crosthwaite.peter@gmail.com

>From 0bf08ebad3ccfe3e07920f53a304478e1e3b5813 Mon Sep 17 00:00:00 2001
From: Danil Antonov <g.danil.anto@gmail.com>
Date: Wed, 29 Mar 2017 12:44:25 +0300
Subject: [PATCH 43/43] ssi: made printf always compile in debug output

Wrapped printf calls inside debug macros (DPRINTF) in `if` statement.
This will ensure that printf function will always compile even if debug
output is turned off and, in turn, will prevent bitrot of the format
strings.

Signed-off-by: Danil Antonov <g.danil.anto@gmail.com>
---
 hw/ssi/pl022.c | 28 ++++++++++++++++------------
 1 file changed, 16 insertions(+), 12 deletions(-)

diff --git a/hw/ssi/pl022.c b/hw/ssi/pl022.c
index c136801..bf1cc3a 100644
--- a/hw/ssi/pl022.c
+++ b/hw/ssi/pl022.c
@@ -12,18 +12,22 @@
 #include "hw/ssi/ssi.h"
 #include "qemu/log.h"

-//#define DEBUG_PL022 1
-
-#ifdef DEBUG_PL022
-#define DPRINTF(fmt, ...) \
-do { printf("pl022: " fmt , ## __VA_ARGS__); } while (0)
-#define BADF(fmt, ...) \
-do { fprintf(stderr, "pl022: error: " fmt , ## __VA_ARGS__); exit(1);}
while (0)
-#else
-#define DPRINTF(fmt, ...) do {} while(0)
-#define BADF(fmt, ...) \
-do { fprintf(stderr, "pl022: error: " fmt , ## __VA_ARGS__);} while (0)
-#endif
+#ifndef DEBUG_PL022
+#define DEBUG_PL022  0
+#endif
+
+#define DPRINTF(fmt, ...) do {                           \
+    if (DEBUG_PL022) {                                   \
+        fprintf(stderr, "pl022: " fmt , ## __VA_ARGS__); \
+    }                                                    \
+} while (0);
+
+#define BADF(fmt, ...) do {                                 \
+    fprintf(stderr, "pl022: error: " fmt , ## __VA_ARGS__); \
+    if (DEBUG_PL022) {                                   \
+        exit(1);                                            \
+    }                                                       \
+} while (0);

 #define PL022_CR1_LBM 0x01
 #define PL022_CR1_SSE 0x02
-- 
2.8.0.rc3
