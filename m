Received: from eggs.gnu.org ([2001:4830:134:3::10]:46360)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1cPQJh-0006Ru-QO
	for qemu-devel@nongnu.org; Fri, 06 Jan 2017 03:56:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1cPQJf-0008Nw-5H
	for qemu-devel@nongnu.org; Fri, 06 Jan 2017 03:56:05 -0500
Received: from mx1.redhat.com ([209.132.183.28]:42698)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1cPQJe-0008Mf-UG
	for qemu-devel@nongnu.org; Fri, 06 Jan 2017 03:56:03 -0500
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Fri,  6 Jan 2017 09:55:39 +0100
Message-Id: <1483692945-9866-12-git-send-email-kraxel@redhat.com>
In-Reply-To: <1483692945-9866-1-git-send-email-kraxel@redhat.com>
References: <1483692945-9866-1-git-send-email-kraxel@redhat.com>
Subject: [Qemu-devel] [PATCH 11/17] wctablet: revamp command parser.
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

Split incoming data into lines.  Then use simple string compare
to match commands.  Drop command table and special compare functions.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 backends/wctablet.c | 113 +++++++++++++++-------------------------------------
 1 file changed, 33 insertions(+), 80 deletions(-)

diff --git a/backends/wctablet.c b/backends/wctablet.c
index 5c41bc4..f21b1f4 100644
--- a/backends/wctablet.c
+++ b/backends/wctablet.c
@@ -43,8 +43,6 @@ do { fprintf(stderr, fmt , ## __VA_ARGS__); } while (0)
 do {} while (0)
 #endif
 
-#define WC_COMMANDS_COUNT 30
-
 #define WC_BUSY_STATE 1
 #define WC_BUSY_WITH_CODES 3
 #define WC_WAITING_STATE 2
@@ -58,29 +56,6 @@ do {} while (0)
 #define WC_L4(n) ((n) & 15)
 #define WC_H4(n) (((n) >> 4) & 15)
 
-// Avaliable commands
-uint8_t wctablet_commands[WC_COMMANDS_COUNT][7] = {
-    {0x53, 0x50, 0x0a, 0},                      // SP\n
-    {0x7e, 0x23, 0},                            // ~#
-    {0x54, 0x45, 0x0a, 0},                      // TE\n
-    {0x52, 0x45, 0x0a, 0},                      // RE\n
-    {0x41, 0x53, 0x31, 0x0a, 0},                // AS1\n
-    {0x49, 0x43, 0x31, 0x0a, 0},                // IC1\n
-    {0x4f, 0x43, 0x31, 0x0a, 0},                // OC1\n
-    {0x49, 0x54, 0x88, 0x88, 0},                // IT3\r
-    {0x53, 0x55, 0x88, 0x88, 0},                // SU3\n
-    {0x50, 0x48, 0x31, 0x0a, 0},                // PH1\n
-    {0x53, 0x54, 0x0d, 0},                      // ST\n
-    {0x53, 0x50, 0x0d, 0},                      // SP\r
-    {0x54, 0x45, 0x0d, 0},                      // TE\r
-    {0x53, 0x50, 0x88, 0},                      // SP\n
-    {0x23, 0x41, 0x4c, 0x31, 0x0d, 0},          // #AL1\r
-    {0x53, 0x54, 0x88, 0},                      // ST\n
-    {0x54, 0x53, 0x88, 0xd, 0},                 // TS&\r
-    {0x53, 0x50, 0x0d, 0x0a, 0},                // SP\r\n
-    {0x7e, 0x23, 0x0d, 0}                       // ~#\r
-};
-
 // Model string and config string
 uint8_t *WC_MODEL_STRING = (uint8_t *) "~#CT-0045R,V1.3-5,";
 size_t WC_MODEL_STRING_LENGTH = 18;
@@ -114,33 +89,6 @@ typedef struct {
     int line_speed;
 } TabletState;
 
-static int wctablet_memcmp(uint8_t *a1, uint8_t *a2, int count)
-{
-    int i;
-
-    for (i = 0; i < count; i++) {
-        if (a1[i] != a2[i] && a2[i] != 0x88) {
-            return -1;
-        }
-    }
-
-    return 0;
-}
-
-static int wctablet_check_command(uint8_t *arr, int count)
-{
-    int i;
-
-    for (i = 0; i < WC_COMMANDS_COUNT; i++) {
-        if (wctablet_memcmp(arr, wctablet_commands[i], count) == 0 &&
-            wctablet_commands[i][count] == 0) {
-            return i;
-        }
-    }
-
-    return -1;
-}
-
 static void wctablet_shift_input(TabletState *tablet, int count)
 {
     tablet->query_index -= count;
@@ -226,7 +174,8 @@ static int wctablet_chr_write(struct CharDriverState *s,
                               const uint8_t *buf, int len)
 {
     TabletState *tablet = (TabletState *) s->opaque;
-    uint8_t i, input;
+    unsigned int i, clen;
+    char *pos;
 
     if (tablet->line_speed != 9600) {
         return len;
@@ -253,37 +202,41 @@ static int wctablet_chr_write(struct CharDriverState *s,
         return len;
     }
 
-    int comm = wctablet_check_command(tablet->query, tablet->query_index);
+    /* detect line */
+    pos = strchr((char *)tablet->query, '\r');
+    if (!pos) {
+        pos = strchr((char *)tablet->query, '\n');
+    }
+    if (!pos) {
+        return len;
+    }
+    clen = pos - (char *)tablet->query;
 
-    if (comm != -1) {
-        if (comm == 3) {
-            wctablet_queue_output(tablet, WC_CONFIG_STRING,
-                                  WC_CONFIG_STRING_LENGTH);
-        }
+    /* process commands */
+    if (strncmp((char *)tablet->query, "RE", 2) == 0 &&
+        clen == 2) {
+        wctablet_shift_input(tablet, 3);
+        wctablet_queue_output(tablet, WC_CONFIG_STRING,
+                              WC_CONFIG_STRING_LENGTH);
 
-        if (comm == 18) {
-            wctablet_queue_output(tablet, WC_FULL_CONFIG_STRING,
-                                  WC_FULL_CONFIG_STRING_LENGTH);
-        }
+    } else if (strncmp((char *)tablet->query, "TS", 2) == 0 &&
+               clen == 3) {
+        unsigned int input = tablet->query[2];
+        uint8_t codes[7] = {
+            0xa3,
+            ((input & 0x80) == 0) ? 0x7e : 0x7f,
+            (((WC_H4(input) & 0x7) ^ 0x5) << 4) | (WC_L4(input) ^ 0x7),
+            0x03,
+            0x7f,
+            0x7f,
+            0x00,
+        };
+        wctablet_shift_input(tablet, 4);
+        wctablet_queue_output(tablet, codes, 7);
 
-        if (comm == 16) {
-            input = tablet->query[2];
-            uint8_t codes[7] = {
-                0xa3,
-                0x88,
-                0x88,
-                0x03,
-                0x7f,
-                0x7f,
-                0x00
-            };
-            codes[1] = ((input & 0x80) == 0) ? 0x7e : 0x7f;
-            codes[2] = ( ( ( WC_H4(input) & 0x7 ) ^ 0x5) << 4 ) | (WC_L4(input) ^ 0x7);
+    } else {
+        wctablet_shift_input(tablet, clen + 1);
 
-            wctablet_queue_output(tablet, codes, 7);
-        }
-
-        tablet->query_index = 0;
     }
 
     return len;
-- 
1.8.3.1
