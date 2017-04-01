Received: from eggs.gnu.org ([2001:4830:134:3::10]:58329)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <g.danil.anto@gmail.com>) id 1cuJgJ-0005Hh-7T
	for qemu-devel@nongnu.org; Sat, 01 Apr 2017 10:07:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <g.danil.anto@gmail.com>) id 1cuJgI-0001gj-91
	for qemu-devel@nongnu.org; Sat, 01 Apr 2017 10:07:07 -0400
Received: from mail-oi0-x242.google.com ([2607:f8b0:4003:c06::242]:36339)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <g.danil.anto@gmail.com>)
	id 1cuJgI-0001gV-37
	for qemu-devel@nongnu.org; Sat, 01 Apr 2017 10:07:06 -0400
Received: by mail-oi0-x242.google.com with SMTP id b187so13242090oif.3
	for <qemu-devel@nongnu.org>; Sat, 01 Apr 2017 07:07:06 -0700 (PDT)
MIME-Version: 1.0
From: Danil Antonov <g.danil.anto@gmail.com>
Date: Sat, 1 Apr 2017 17:07:04 +0300
Message-ID: <CA+KKJYCi61_2i+NjGc9COwtPr_3OFNJGvCx5VhDUr4KPtZPnrQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: [Qemu-devel] [PATCH 37/43] audio: made printf always compile in
 debug output
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, kraxel@redhat.com

>From ef4e9e576ae80c227d06721284bd49b699e71c71 Mon Sep 17 00:00:00 2001
From: Danil Antonov <g.danil.anto@gmail.com>
Date: Wed, 29 Mar 2017 12:41:59 +0300
Subject: [PATCH 37/43] audio: made printf always compile in debug output

Wrapped printf calls inside debug macros (DPRINTF) in `if` statement.
This will ensure that printf function will always compile even if debug
output is turned off and, in turn, will prevent bitrot of the format
strings.

Signed-off-by: Danil Antonov <g.danil.anto@gmail.com>
---
 hw/audio/lm4549.c | 18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

diff --git a/hw/audio/lm4549.c b/hw/audio/lm4549.c
index a46f230..962db8e 100644
--- a/hw/audio/lm4549.c
+++ b/hw/audio/lm4549.c
@@ -26,13 +26,17 @@
 #define LM4549_DUMP_DAC_INPUT 1
 #endif

-#ifdef LM4549_DEBUG
-#define DPRINTF(fmt, ...) \
-do { printf("lm4549: " fmt , ## __VA_ARGS__); } while (0)
-#else
-#define DPRINTF(fmt, ...) do {} while (0)
+#ifndef LM4549_DEBUG
+#define LM4549_DEBUG 0
 #endif

+#define DPRINTF(fmt, ...)                                    \
+    do {                                                     \
+        if (LM4549_DEBUG) {                                  \
+            fprintf(stderr, "lm4549: " fmt, ## __VA_ARGS__); \
+        }                                                    \
+    } while (0)
+
 #if defined(LM4549_DUMP_DAC_INPUT)
 static FILE *fp_dac_input;
 #endif
@@ -159,7 +163,7 @@ uint32_t lm4549_read(lm4549_state *s, hwaddr offset)
     assert(offset < 128);
     value = regfile[offset];

-    DPRINTF("read [0x%02x] = 0x%04x\n", offset, value);
+    DPRINTF("read [0x%02x] = 0x%04x\n", (int) offset, value);

     return value;
 }
@@ -170,7 +174,7 @@ void lm4549_write(lm4549_state *s,
     uint16_t *regfile = s->regfile;

     assert(offset < 128);
-    DPRINTF("write [0x%02x] = 0x%04x\n", offset, value);
+    DPRINTF("write [0x%02x] = 0x%04x\n", (int) offset, value);

     switch (offset) {
     case LM4549_Reset:
-- 
2.8.0.rc3
