Received: from eggs.gnu.org ([2001:4830:134:3::10]:46260)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1cPQJf-0006Qd-RF
	for qemu-devel@nongnu.org; Fri, 06 Jan 2017 03:56:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1cPQJd-0008Lw-EZ
	for qemu-devel@nongnu.org; Fri, 06 Jan 2017 03:56:03 -0500
Received: from mx1.redhat.com ([209.132.183.28]:41028)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1cPQJd-0008LD-A3
	for qemu-devel@nongnu.org; Fri, 06 Jan 2017 03:56:01 -0500
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Fri,  6 Jan 2017 09:55:33 +0100
Message-Id: <1483692945-9866-6-git-send-email-kraxel@redhat.com>
In-Reply-To: <1483692945-9866-1-git-send-email-kraxel@redhat.com>
References: <1483692945-9866-1-git-send-email-kraxel@redhat.com>
Subject: [Qemu-devel] [PATCH 05/17] wctablet: strip leading \r + \n from
 buffer
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

Should make command detection more robust.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 backends/wctablet.c | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/backends/wctablet.c b/backends/wctablet.c
index 00498e1..767887e 100644
--- a/backends/wctablet.c
+++ b/backends/wctablet.c
@@ -60,9 +60,9 @@ do {} while (0)
 
 // Avaliable commands
 uint8_t wctablet_commands[WC_COMMANDS_COUNT][7] = {
-    {0x0a, 0x53, 0x50, 0x0a, 0},                // \nSP\n
+    {0x53, 0x50, 0x0a, 0},                      // SP\n
     {0x7e, 0x23, 0},                            // ~#
-    {0x0a, 0x54, 0x45, 0x0a, 0},                // \nTE\n
+    {0x54, 0x45, 0x0a, 0},                      // TE\n
     {0x52, 0x45, 0x0a, 0},                      // RE\n
     {0x41, 0x53, 0x31, 0x0a, 0},                // AS1\n
     {0x49, 0x43, 0x31, 0x0a, 0},                // IC1\n
@@ -70,14 +70,14 @@ uint8_t wctablet_commands[WC_COMMANDS_COUNT][7] = {
     {0x49, 0x54, 0x88, 0x88, 0},                // IT3\r
     {0x53, 0x55, 0x88, 0x88, 0},                // SU3\n
     {0x50, 0x48, 0x31, 0x0a, 0},                // PH1\n
-    {0x0d, 0x53, 0x54, 0x0d, 0},                // \rST\n
-    {0x0d, 0x53, 0x50, 0x0d, 0},                // \rSP\r
+    {0x53, 0x54, 0x0d, 0},                      // ST\n
+    {0x53, 0x50, 0x0d, 0},                      // SP\r
     {0x54, 0x45, 0x0d, 0},                      // TE\r
     {0x53, 0x50, 0x88, 0},                      // SP\n
     {0x23, 0x41, 0x4c, 0x31, 0x0d, 0},          // #AL1\r
     {0x53, 0x54, 0x88, 0},                      // ST\n
-    {0x0d, 0x54, 0x53, 0x88, 0xd, 0},           // \rTS&\r
-    {0x0d, 0x0a, 0x53, 0x50, 0x0d, 0x0a, 0},    // \r\nSP\r\n
+    {0x54, 0x53, 0x88, 0xd, 0},                 // TS&\r
+    {0x53, 0x50, 0x0d, 0x0a, 0},                // SP\r\n
     {0x7e, 0x23, 0x0d, 0}                       // ~#\r
 };
 
@@ -222,7 +222,9 @@ static int wctablet_chr_write(struct CharDriverState *s,
     }
     tablet->query[tablet->query_index] = 0;
 
-    while (tablet->query_index > 0 && tablet->query[0] == '@') {
+    while (tablet->query_index > 0 && (tablet->query[0] == '@'  ||
+                                       tablet->query[0] == '\r' ||
+                                       tablet->query[0] == '\n')) {
         memmove(tablet->query, tablet->query + 1, tablet->query_index);
         tablet->query_index--;
     }
@@ -253,7 +255,7 @@ static int wctablet_chr_write(struct CharDriverState *s,
         }
 
         if (comm == 16) {
-            input = tablet->query[3];
+            input = tablet->query[2];
             uint8_t codes[7] = {
                 0xa3,
                 0x88,
-- 
1.8.3.1
