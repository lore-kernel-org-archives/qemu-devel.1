Received: from eggs.gnu.org ([2001:4830:134:3::10]:58465)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <g.danil.anto@gmail.com>) id 1cuJgr-0005iB-Fj
	for qemu-devel@nongnu.org; Sat, 01 Apr 2017 10:07:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <g.danil.anto@gmail.com>) id 1cuJgq-0002G2-HG
	for qemu-devel@nongnu.org; Sat, 01 Apr 2017 10:07:41 -0400
Received: from mail-oi0-x243.google.com ([2607:f8b0:4003:c06::243]:36388)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <g.danil.anto@gmail.com>)
	id 1cuJgq-0002FI-Bh
	for qemu-devel@nongnu.org; Sat, 01 Apr 2017 10:07:40 -0400
Received: by mail-oi0-x243.google.com with SMTP id b187so13243794oif.3
	for <qemu-devel@nongnu.org>; Sat, 01 Apr 2017 07:07:40 -0700 (PDT)
MIME-Version: 1.0
From: Danil Antonov <g.danil.anto@gmail.com>
Date: Sat, 1 Apr 2017 17:07:39 +0300
Message-ID: <CA+KKJYBEedtXga1PzC5hpntu5dA4wFa-tMP7QWZ1E5JfRWkZaA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: [Qemu-devel] [PATCH 38/43] empty_slot: made printf always compile
 in debug output
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

>From f91f364efb44edd51e865872eeb1bc2293d42930 Mon Sep 17 00:00:00 2001
From: Danil Antonov <g.danil.anto@gmail.com>
Date: Wed, 29 Mar 2017 12:42:32 +0300
Subject: [PATCH 38/43] empty_slot: made printf always compile in debug
output

Wrapped printf calls inside debug macros (DPRINTF) in `if` statement.
This will ensure that printf function will always compile even if debug
output is turned off and, in turn, will prevent bitrot of the format
strings.

Signed-off-by: Danil Antonov <g.danil.anto@gmail.com>
---
 hw/core/empty_slot.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/hw/core/empty_slot.c b/hw/core/empty_slot.c
index c1b9c2b..b58957d 100644
--- a/hw/core/empty_slot.c
+++ b/hw/core/empty_slot.c
@@ -16,12 +16,15 @@

 //#define DEBUG_EMPTY_SLOT

-#ifdef DEBUG_EMPTY_SLOT
-#define DPRINTF(fmt, ...)                                       \
-    do { printf("empty_slot: " fmt , ## __VA_ARGS__); } while (0)
-#else
-#define DPRINTF(fmt, ...) do {} while (0)
-#endif
+#ifndef DEBUG_EMPTY_SLOT
+#define DEBUG_EMPTY_SLOT 0
+#endif
+
+#define DPRINTF(fmt, ...) do {                                \
+    if (DEBUG_EMPTY_SLOT) {                                   \
+        fprintf(stderr, "empty_slot: " fmt , ## __VA_ARGS__); \
+    }                                                         \
+} while (0);

 #define TYPE_EMPTY_SLOT "empty_slot"
 #define EMPTY_SLOT(obj) OBJECT_CHECK(EmptySlot, (obj), TYPE_EMPTY_SLOT)
-- 
2.8.0.rc3
