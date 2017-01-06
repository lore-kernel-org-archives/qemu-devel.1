Received: from eggs.gnu.org ([2001:4830:134:3::10]:46309)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1cPQJg-0006RE-Vw
	for qemu-devel@nongnu.org; Fri, 06 Jan 2017 03:56:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1cPQJe-0008N5-Gr
	for qemu-devel@nongnu.org; Fri, 06 Jan 2017 03:56:05 -0500
Received: from mx1.redhat.com ([209.132.183.28]:42688)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1cPQJe-0008MI-CO
	for qemu-devel@nongnu.org; Fri, 06 Jan 2017 03:56:02 -0500
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Fri,  6 Jan 2017 09:55:37 +0100
Message-Id: <1483692945-9866-10-git-send-email-kraxel@redhat.com>
In-Reply-To: <1483692945-9866-1-git-send-email-kraxel@redhat.com>
References: <1483692945-9866-1-git-send-email-kraxel@redhat.com>
Subject: [Qemu-devel] [PATCH 09/17] wctablet: add wctablet_shift_input
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

Helper function to drop leading chars from the input buffer.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 backends/wctablet.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/backends/wctablet.c b/backends/wctablet.c
index d0ee0e4..2b14241 100644
--- a/backends/wctablet.c
+++ b/backends/wctablet.c
@@ -141,6 +141,13 @@ static int wctablet_check_command(uint8_t *arr, int count)
     return -1;
 }
 
+static void wctablet_shift_input(TabletState *tablet, int count)
+{
+    tablet->query_index -= count;
+    memmove(tablet->query, tablet->query + count, tablet->query_index);
+    tablet->query[tablet->query_index] = 0;
+}
+
 static void wctablet_queue_output(TabletState *tablet, uint8_t *buf, int count)
 {
     if (tablet->outlen + count > sizeof(tablet->outbuf)) {
@@ -232,8 +239,7 @@ static int wctablet_chr_write(struct CharDriverState *s,
     while (tablet->query_index > 0 && (tablet->query[0] == '@'  ||
                                        tablet->query[0] == '\r' ||
                                        tablet->query[0] == '\n')) {
-        memmove(tablet->query, tablet->query + 1, tablet->query_index);
-        tablet->query_index--;
+        wctablet_shift_input(tablet, 1);
     }
     if (!tablet->query_index) {
         return len;
-- 
1.8.3.1
