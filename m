Received: from eggs.gnu.org ([2001:4830:134:3::10]:58694)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <g.danil.anto@gmail.com>) id 1cuJi0-0006XU-QV
	for qemu-devel@nongnu.org; Sat, 01 Apr 2017 10:08:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <g.danil.anto@gmail.com>) id 1cuJhz-0003GA-JU
	for qemu-devel@nongnu.org; Sat, 01 Apr 2017 10:08:52 -0400
Received: from mail-oi0-x242.google.com ([2607:f8b0:4003:c06::242]:36468)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <g.danil.anto@gmail.com>)
	id 1cuJhz-0003Fr-Dp
	for qemu-devel@nongnu.org; Sat, 01 Apr 2017 10:08:51 -0400
Received: by mail-oi0-x242.google.com with SMTP id b187so13246568oif.3
	for <qemu-devel@nongnu.org>; Sat, 01 Apr 2017 07:08:51 -0700 (PDT)
MIME-Version: 1.0
From: Danil Antonov <g.danil.anto@gmail.com>
Date: Sat, 1 Apr 2017 17:08:50 +0300
Message-ID: <CA+KKJYBpRE2dQnGJkoQNBLXz3H1L5z_oBffR8KZRokkVWmQfEw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: [Qemu-devel] [PATCH 41/43] nvram: made printf always compile in
 debug output
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, agraf@suse.de

>From f0ac5a35af1c521bb8f87720ec7f82a9452e38a4 Mon Sep 17 00:00:00 2001
From: Danil Antonov <g.danil.anto@gmail.com>
Date: Wed, 29 Mar 2017 12:43:45 +0300
Subject: [PATCH 41/43] nvram: made printf always compile in debug output

Wrapped printf calls inside debug macros (DPRINTF) in `if` statement.
This will ensure that printf function will always compile even if debug
output is turned off and, in turn, will prevent bitrot of the format
strings.

Signed-off-by: Danil Antonov <g.danil.anto@gmail.com>
---
 hw/nvram/mac_nvram.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/hw/nvram/mac_nvram.c b/hw/nvram/mac_nvram.c
index aef80e6..e152203 100644
--- a/hw/nvram/mac_nvram.c
+++ b/hw/nvram/mac_nvram.c
@@ -32,12 +32,16 @@
 /* debug NVR */
 //#define DEBUG_NVR

-#ifdef DEBUG_NVR
-#define NVR_DPRINTF(fmt, ...)                                   \
-    do { printf("NVR: " fmt , ## __VA_ARGS__); } while (0)
-#else
-#define NVR_DPRINTF(fmt, ...)
-#endif
+#ifndef DEBUG_NVR
+#define DEBUG_NVR 0
+#endif
+
+#define NVR_DPRINTF(fmt, ...)                             \
+    do {                                                  \
+        if (DEBUG_NVR) {                                  \
+            fprintf(stderr, "NVR: " fmt, ## __VA_ARGS__); \
+        }                                                 \
+    } while (0)

 #define DEF_SYSTEM_SIZE 0xc10

-- 
2.8.0.rc3
