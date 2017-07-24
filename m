Received: from eggs.gnu.org ([2001:4830:134:3::10]:50110)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dZi5i-0008Gw-UP
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 14:28:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dZi5i-0004l3-4Z
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 14:28:26 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Mon, 24 Jul 2017 15:27:21 -0300
Message-Id: <20170724182751.18261-6-f4bug@amsat.org>
In-Reply-To: <20170724182751.18261-1-f4bug@amsat.org>
References: <20170724182751.18261-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH for 2.10 05/35] nbd: fix memory leak in
 nbd_opt_go()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, qemu-trivial@nongnu.org, qemu-block@nongnu.org

nbd/client.c:385:12: warning: Potential leak of memory pointed to by 'buf'

Reported-by: Clang Static Analyzer
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 nbd/client.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/nbd/client.c b/nbd/client.c
index 509ed5e4ba..0a17de80b5 100644
--- a/nbd/client.c
+++ b/nbd/client.c
@@ -376,9 +376,11 @@ static int nbd_opt_go(QIOChannel *ioc, const char *wantname,
     if (info->request_sizes) {
         stw_be_p(buf + 4 + len + 2, NBD_INFO_BLOCK_SIZE);
     }
-    if (nbd_send_option_request(ioc, NBD_OPT_GO,
-                                4 + len + 2 + 2 * info->request_sizes, buf,
-                                errp) < 0) {
+    error = nbd_send_option_request(ioc, NBD_OPT_GO,
+                                    4 + len + 2 + 2 * info->request_sizes,
+                                    buf, errp);
+    g_free(buf);
+    if (error < 0) {
         return -1;
     }
 
-- 
2.13.3
