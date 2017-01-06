Received: from eggs.gnu.org ([2001:4830:134:3::10]:46288)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1cPQJg-0006R5-Nf
	for qemu-devel@nongnu.org; Fri, 06 Jan 2017 03:56:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1cPQJe-0008NL-K6
	for qemu-devel@nongnu.org; Fri, 06 Jan 2017 03:56:04 -0500
Received: from mx1.redhat.com ([209.132.183.28]:57042)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1cPQJe-0008MK-Fm
	for qemu-devel@nongnu.org; Fri, 06 Jan 2017 03:56:02 -0500
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Fri,  6 Jan 2017 09:55:38 +0100
Message-Id: <1483692945-9866-11-git-send-email-kraxel@redhat.com>
In-Reply-To: <1483692945-9866-1-git-send-email-kraxel@redhat.com>
References: <1483692945-9866-1-git-send-email-kraxel@redhat.com>
Subject: [Qemu-devel] [PATCH 10/17] wctablet: move init/detect sequence
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

Move init/detect detection, handle it as special case.
It is the only sequence which doesn't end with a newline.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 backends/wctablet.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/backends/wctablet.c b/backends/wctablet.c
index 2b14241..5c41bc4 100644
--- a/backends/wctablet.c
+++ b/backends/wctablet.c
@@ -245,14 +245,17 @@ static int wctablet_chr_write(struct CharDriverState *s,
         return len;
     }
 
+    if (strncmp((char *)tablet->query, "~#", 2) == 0) {
+        /* init / detect sequence */
+        wctablet_shift_input(tablet, 2);
+        wctablet_queue_output(tablet, WC_MODEL_STRING,
+                              WC_MODEL_STRING_LENGTH);
+        return len;
+    }
+
     int comm = wctablet_check_command(tablet->query, tablet->query_index);
 
     if (comm != -1) {
-        if (comm == 1) {
-            wctablet_queue_output(tablet, WC_MODEL_STRING,
-                                  WC_MODEL_STRING_LENGTH);
-        }
-
         if (comm == 3) {
             wctablet_queue_output(tablet, WC_CONFIG_STRING,
                                   WC_CONFIG_STRING_LENGTH);
-- 
1.8.3.1
