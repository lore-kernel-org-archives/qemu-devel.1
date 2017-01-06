Received: from eggs.gnu.org ([2001:4830:134:3::10]:46248)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1cPQJf-0006QU-Pk
	for qemu-devel@nongnu.org; Fri, 06 Jan 2017 03:56:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1cPQJd-0008Lf-5D
	for qemu-devel@nongnu.org; Fri, 06 Jan 2017 03:56:03 -0500
Received: from mx1.redhat.com ([209.132.183.28]:60704)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1cPQJc-0008Kw-Tu
	for qemu-devel@nongnu.org; Fri, 06 Jan 2017 03:56:01 -0500
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Fri,  6 Jan 2017 09:55:30 +0100
Message-Id: <1483692945-9866-3-git-send-email-kraxel@redhat.com>
In-Reply-To: <1483692945-9866-1-git-send-email-kraxel@redhat.com>
References: <1483692945-9866-1-git-send-email-kraxel@redhat.com>
Subject: [Qemu-devel] [PATCH 02/17] wctablet: add wctablet_queue_output
 helper
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

Add helper function to place data in the output queue, so we don't
duplicate the code and also check the available space every time.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 backends/wctablet.c | 30 ++++++++++++++++++------------
 1 file changed, 18 insertions(+), 12 deletions(-)

diff --git a/backends/wctablet.c b/backends/wctablet.c
index 0aee6fe..758c9e8 100644
--- a/backends/wctablet.c
+++ b/backends/wctablet.c
@@ -165,6 +165,16 @@ static int wctablet_check_command(uint8_t *arr, int count)
     return -1;
 }
 
+static void wctablet_queue_output(TabletState *tablet, uint8_t *buf, int count)
+{
+    if (tablet->outlen + count > sizeof(tablet->outbuf)) {
+        return;
+    }
+
+    memcpy(tablet->outbuf + tablet->outlen, buf, count);
+    tablet->outlen += count;
+}
+
 static void wctablet_event(void *opaque, int x,
                            int y, int dz, int buttons_state)
 {
@@ -191,10 +201,7 @@ static void wctablet_event(void *opaque, int x,
         codes[0] = 0xa0;
     }
 
-    if (tablet->outlen + 7 < WC_OUTPUT_BUF_MAX_LEN) {
-        memcpy(tablet->outbuf + tablet->outlen, codes, 7);
-        tablet->outlen += 7;
-    }
+    wctablet_queue_output(tablet, codes, 7);
 }
 
 static void wctablet_handler(void *opaque)
@@ -250,18 +257,18 @@ static int wctablet_chr_write (struct CharDriverState *s,
 
     if (comm != -1) {
         if (comm == 1 && count == 2) {
-            memcpy(tablet->outbuf + tablet->outlen, WC_MODEL_STRING, WC_MODEL_STRING_LENGTH);
-            tablet->outlen += WC_MODEL_STRING_LENGTH;
+            wctablet_queue_output(tablet, WC_MODEL_STRING,
+                                  WC_MODEL_STRING_LENGTH);
         }
 
         if (comm == 3) {
-            memcpy(tablet->outbuf + tablet->outlen, WC_CONFIG_STRING, WC_CONFIG_STRING_LENGTH);
-            tablet->outlen += WC_CONFIG_STRING_LENGTH;
+            wctablet_queue_output(tablet, WC_CONFIG_STRING,
+                                  WC_CONFIG_STRING_LENGTH);
         }
 
         if (comm == 18) {
-            memcpy(tablet->outbuf + tablet->outlen, WC_FULL_CONFIG_STRING, WC_FULL_CONFIG_STRING_LENGTH);
-            tablet->outlen += WC_FULL_CONFIG_STRING_LENGTH;
+            wctablet_queue_output(tablet, WC_FULL_CONFIG_STRING,
+                                  WC_FULL_CONFIG_STRING_LENGTH);
         }
 
         if (comm == 16) {
@@ -278,8 +285,7 @@ static int wctablet_chr_write (struct CharDriverState *s,
             codes[1] = ((input & 0x80) == 0) ? 0x7e : 0x7f;
             codes[2] = ( ( ( WC_H4(input) & 0x7 ) ^ 0x5) << 4 ) | (WC_L4(input) ^ 0x7);
 
-            memcpy(tablet->outbuf + tablet->outlen, codes, 7);
-            tablet->outlen += 7;
+            wctablet_queue_output(tablet, codes, 7);
         }
 
         // DPRINTF("-------- Command: %s\n", wctablet_commands_names[comm]);
-- 
1.8.3.1
