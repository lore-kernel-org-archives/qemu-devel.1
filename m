Received: from eggs.gnu.org ([2001:4830:134:3::10]:46251)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1cPQJf-0006QW-Px
	for qemu-devel@nongnu.org; Fri, 06 Jan 2017 03:56:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1cPQJd-0008LY-4F
	for qemu-devel@nongnu.org; Fri, 06 Jan 2017 03:56:03 -0500
Received: from mx1.redhat.com ([209.132.183.28]:60708)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1cPQJc-0008L0-Vu
	for qemu-devel@nongnu.org; Fri, 06 Jan 2017 03:56:01 -0500
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Fri,  6 Jan 2017 09:55:31 +0100
Message-Id: <1483692945-9866-4-git-send-email-kraxel@redhat.com>
In-Reply-To: <1483692945-9866-1-git-send-email-kraxel@redhat.com>
References: <1483692945-9866-1-git-send-email-kraxel@redhat.com>
Subject: [Qemu-devel] [PATCH 03/17] wctablet: save all chars in the query
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

... instead of storing the first character only, to avoid things break
in case multiple chars are passed in a single wctablet_chr_write call.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 backends/wctablet.c | 22 +++++++++++++---------
 1 file changed, 13 insertions(+), 9 deletions(-)

diff --git a/backends/wctablet.c b/backends/wctablet.c
index 758c9e8..787da49 100644
--- a/backends/wctablet.c
+++ b/backends/wctablet.c
@@ -234,21 +234,25 @@ static void wctablet_handler(void *opaque)
               qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) + tablet->transmit_time);
 }
 
-static int wctablet_chr_write (struct CharDriverState *s,
-                               const uint8_t *buf, int len)
+static int wctablet_chr_write(struct CharDriverState *s,
+                              const uint8_t *buf, int len)
 {
     TabletState *tablet = (TabletState *) s->opaque;
-    uint8_t c = buf[0];
-    uint8_t input;
+    uint8_t i, input;
 
-    if (c == 0x40) {
+    for (i = 0; i < len && tablet->query_index < sizeof(tablet->query) - 1; i++) {
+        tablet->query[tablet->query_index++] = buf[i];
+    }
+    tablet->query[tablet->query_index] = 0;
+
+    while (tablet->query_index > 0 && tablet->query[0] == '@') {
+        memmove(tablet->query, tablet->query + 1, tablet->query_index);
+        tablet->query_index--;
+    }
+    if (!tablet->query_index) {
         return len;
     }
 
-    tablet->query[tablet->query_index++] = c;
-
-    // DPRINTF("Receive: %.2x\n", c);
-
     int comm = wctablet_check_command(tablet->query, tablet->query_index);
 
     if (comm == 1) {
-- 
1.8.3.1
