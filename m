Received: from eggs.gnu.org ([2001:4830:134:3::10]:58795)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <g.danil.anto@gmail.com>) id 1cuJiX-0006ur-Am
	for qemu-devel@nongnu.org; Sat, 01 Apr 2017 10:09:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <g.danil.anto@gmail.com>) id 1cuJiW-0003jc-5Q
	for qemu-devel@nongnu.org; Sat, 01 Apr 2017 10:09:25 -0400
Received: from mail-oi0-x241.google.com ([2607:f8b0:4003:c06::241]:34851)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <g.danil.anto@gmail.com>)
	id 1cuJiV-0003j6-Vf
	for qemu-devel@nongnu.org; Sat, 01 Apr 2017 10:09:24 -0400
Received: by mail-oi0-x241.google.com with SMTP id d2so5907363oig.2
	for <qemu-devel@nongnu.org>; Sat, 01 Apr 2017 07:09:23 -0700 (PDT)
MIME-Version: 1.0
From: Danil Antonov <g.danil.anto@gmail.com>
Date: Sat, 1 Apr 2017 17:09:22 +0300
Message-ID: <CA+KKJYB+xAQ68o4xPqgnJ8KoV1vVTtNztkii2s6L=QuEy6hixw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: [Qemu-devel] [PATCH 42/43] pci-bridge: made printf always compile
 in debug output
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, agraf@suse.de

>From bd32eaf17d401067d46891facfa37fe2a315cd2a Mon Sep 17 00:00:00 2001
From: Danil Antonov <g.danil.anto@gmail.com>
Date: Wed, 29 Mar 2017 12:44:02 +0300
Subject: [PATCH 42/43] pci-bridge: made printf always compile in debug
output

Wrapped printf calls inside debug macros (DPRINTF) in `if` statement.
This will ensure that printf function will always compile even if debug
output is turned off and, in turn, will prevent bitrot of the format
strings.

Signed-off-by: Danil Antonov <g.danil.anto@gmail.com>
---
 hw/pci-bridge/dec.c | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/hw/pci-bridge/dec.c b/hw/pci-bridge/dec.c
index 840c961..84149da 100644
--- a/hw/pci-bridge/dec.c
+++ b/hw/pci-bridge/dec.c
@@ -32,14 +32,16 @@
 #include "hw/pci/pci_bus.h"

 /* debug DEC */
-//#define DEBUG_DEC
-
-#ifdef DEBUG_DEC
-#define DEC_DPRINTF(fmt, ...)                               \
-    do { printf("DEC: " fmt , ## __VA_ARGS__); } while (0)
-#else
-#define DEC_DPRINTF(fmt, ...)
-#endif
+
+#ifndef DEBUG_DEC
+#define DEBUG_DEC 0
+#endif
+
+#define DEC_DPRINTF(fmt, ...) do {                     \
+    if (DEBUG_DEC) {                                   \
+        fprintf(stderr, "DEC: " fmt , ## __VA_ARGS__); \
+    }                                                  \
+} while (0);

 #define DEC_21154(obj) OBJECT_CHECK(DECState, (obj), TYPE_DEC_21154)

-- 
2.8.0.rc3
