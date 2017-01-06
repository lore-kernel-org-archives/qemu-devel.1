Received: from eggs.gnu.org ([2001:4830:134:3::10]:46342)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1cPQJh-0006Ra-EA
	for qemu-devel@nongnu.org; Fri, 06 Jan 2017 03:56:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1cPQJf-0008Np-3x
	for qemu-devel@nongnu.org; Fri, 06 Jan 2017 03:56:05 -0500
Received: from mx1.redhat.com ([209.132.183.28]:41350)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1cPQJe-0008Mb-Sr
	for qemu-devel@nongnu.org; Fri, 06 Jan 2017 03:56:03 -0500
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Fri,  6 Jan 2017 09:55:42 +0100
Message-Id: <1483692945-9866-15-git-send-email-kraxel@redhat.com>
In-Reply-To: <1483692945-9866-1-git-send-email-kraxel@redhat.com>
References: <1483692945-9866-1-git-send-email-kraxel@redhat.com>
Subject: [Qemu-devel] [PATCH 14/17] wctablet: misc cleanups
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: avg.tolik@gmail.com, Gerd Hoffmann <kraxel@redhat.com>

Some codestyle fixes, place comments first,
turn lengts into #defines, delete unused stuff.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 backends/wctablet.c | 34 ++++++++++++++++------------------
 1 file changed, 16 insertions(+), 18 deletions(-)

diff --git a/backends/wctablet.c b/backends/wctablet.c
index 07d2a7e..29b75b4 100644
--- a/backends/wctablet.c
+++ b/backends/wctablet.c
@@ -34,9 +34,6 @@
 #include "trace.h"
 
 
-#define WC_BUSY_STATE 1
-#define WC_BUSY_WITH_CODES 3
-#define WC_WAITING_STATE 2
 #define WC_OUTPUT_BUF_MAX_LEN 512
 #define WC_COMMAND_MAX_LEN 60
 
@@ -47,12 +44,15 @@
 #define WC_L4(n) ((n) & 15)
 #define WC_H4(n) (((n) >> 4) & 15)
 
-// Model string and config string
-uint8_t *WC_MODEL_STRING = (uint8_t *) "~#CT-0045R,V1.3-5,";
-size_t WC_MODEL_STRING_LENGTH = 18;
-uint8_t *WC_CONFIG_STRING = (uint8_t *) "96,N,8,0";
-size_t WC_CONFIG_STRING_LENGTH = 8;
-uint8_t WC_FULL_CONFIG_STRING[61] = {
+/* Model string and config string */
+#define WC_MODEL_STRING_LENGTH 18
+uint8_t WC_MODEL_STRING[WC_MODEL_STRING_LENGTH + 1] = "~#CT-0045R,V1.3-5,";
+
+#define WC_CONFIG_STRING_LENGTH 8
+uint8_t WC_CONFIG_STRING[WC_CONFIG_STRING_LENGTH + 1] = "96,N,8,0";
+
+#define WC_FULL_CONFIG_STRING_LENGTH 61
+uint8_t WC_FULL_CONFIG_STRING[WC_FULL_CONFIG_STRING_LENGTH + 1] = {
     0x5c, 0x39, 0x36, 0x2c, 0x4e, 0x2c, 0x38, 0x2c,
     0x31, 0x28, 0x01, 0x24, 0x57, 0x41, 0x43, 0x30,
     0x30, 0x34, 0x35, 0x5c, 0x5c, 0x50, 0x45, 0x4e, 0x5c,
@@ -62,18 +62,19 @@ uint8_t WC_FULL_CONFIG_STRING[61] = {
     0x2c, 0x56, 0x31, 0x2e, 0x33, 0x2d, 0x35, 0x0d,
     0x0a, 0x45, 0x37, 0x29
 };
-size_t WC_FULL_CONFIG_STRING_LENGTH = 61;
-int COMMON_SPEAD = 900 * 1000;
 
-// This structure is used to save private info for Wacom Tablet.
+/* This structure is used to save private info for Wacom Tablet. */
 typedef struct {
     CharDriverState *chr;
+
+    /* Query string from serial */
     uint8_t query[100];
     int query_index;
-    /* Query string from serial */
+
+    /* Command to be sent to serial port */
     uint8_t outbuf[WC_OUTPUT_BUF_MAX_LEN];
     int outlen;
-    /* Command to be sent to serial port */
+
     int line_speed;
 } TabletState;
 
@@ -110,9 +111,6 @@ static void wctablet_event(void *opaque, int x,
     CharDriverState *chr = (CharDriverState *) opaque;
     TabletState *tablet = (TabletState *) chr->opaque;
     uint8_t codes[8] = { 0xe0, 0, 0, 0, 0, 0, 0 };
-    // uint8_t codes[8] = { 0xa0, 0x0e, 0x06, 0x00, 0x13, 0x3b, 0x00 };
-    // uint8_t codes[8] = { 0xe0, 0x05, 0x6a, 0x00, 0x06, 0x64, 0x40 };
-    // uint8_t codes[8] = { 0xa0, 0x1c, 0x29, 0x00, 0x19, 0x1c, 0x00 };
 
     if (tablet->line_speed != 9600) {
         return;
@@ -139,7 +137,7 @@ static void wctablet_event(void *opaque, int x,
 static void wctablet_chr_accept_input(CharDriverState *chr)
 {
     TabletState *tablet = (TabletState *) chr->opaque;
-    int len, canWrite; // , i;
+    int len, canWrite;
 
     canWrite = qemu_chr_be_can_write(chr);
     len = canWrite;
-- 
1.8.3.1
