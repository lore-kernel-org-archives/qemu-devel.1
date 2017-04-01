Received: from eggs.gnu.org ([2001:4830:134:3::10]:58523)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <g.danil.anto@gmail.com>) id 1cuJhS-00069x-Eo
	for qemu-devel@nongnu.org; Sat, 01 Apr 2017 10:08:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <g.danil.anto@gmail.com>) id 1cuJhR-0002nq-Fe
	for qemu-devel@nongnu.org; Sat, 01 Apr 2017 10:08:18 -0400
Received: from mail-oi0-x244.google.com ([2607:f8b0:4003:c06::244]:34385)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <g.danil.anto@gmail.com>)
	id 1cuJhR-0002nO-A3
	for qemu-devel@nongnu.org; Sat, 01 Apr 2017 10:08:17 -0400
Received: by mail-oi0-x244.google.com with SMTP id t11so13253113oib.1
	for <qemu-devel@nongnu.org>; Sat, 01 Apr 2017 07:08:17 -0700 (PDT)
MIME-Version: 1.0
From: Danil Antonov <g.danil.anto@gmail.com>
Date: Sat, 1 Apr 2017 17:08:16 +0300
Message-ID: <CA+KKJYDE0D8V6P_vaA9=zfxr2gza_fW4n7W2B4aP3cSq+PcU-w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: [Qemu-devel] [PATCH 40/43] mips: made printf always compile in
 debug output
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, aurelien@aurel32.net, yongbok.kim@imgtec.com

>From fafbd66ef7cd5e2295a5c14e24a6ec1520ca79f4 Mon Sep 17 00:00:00 2001
From: Danil Antonov <g.danil.anto@gmail.com>
Date: Wed, 29 Mar 2017 12:43:28 +0300
Subject: [PATCH 40/43] mips: made printf always compile in debug output

Wrapped printf calls inside debug macros (DPRINTF) in `if` statement.
This will ensure that printf function will always compile even if debug
output is turned off and, in turn, will prevent bitrot of the format
strings.

Signed-off-by: Danil Antonov <g.danil.anto@gmail.com>
---
 hw/mips/gt64xxx_pci.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/hw/mips/gt64xxx_pci.c b/hw/mips/gt64xxx_pci.c
index 4811843..adb64ff 100644
--- a/hw/mips/gt64xxx_pci.c
+++ b/hw/mips/gt64xxx_pci.c
@@ -30,13 +30,16 @@
 #include "hw/i386/pc.h"
 #include "exec/address-spaces.h"

-//#define DEBUG

-#ifdef DEBUG
-#define DPRINTF(fmt, ...) fprintf(stderr, "%s: " fmt, __FUNCTION__,
##__VA_ARGS__)
-#else
-#define DPRINTF(fmt, ...)
-#endif
+#ifndef DEBUG
+#define DEBUG 0
+#endif
+
+#define DPRINTF(fmt, ...) do {                                    \
+    if (DEBUG) {                                                  \
+        fprintf(stderr, "%s: " fmt, __FUNCTION__, ##__VA_ARGS__); \
+    }                                                             \
+} while (0);

 #define GT_REGS            (0x1000 >> 2)

-- 
2.8.0.rc3
