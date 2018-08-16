Received: from eggs.gnu.org ([2001:4830:134:3::10]:38001)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yury-kotov@yandex-team.ru>) id 1fqKGg-000451-TM
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 11:32:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yury-kotov@yandex-team.ru>) id 1fqKGg-0002oI-1G
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 11:32:58 -0400
Received: from forwardcorp1o.cmail.yandex.net ([2a02:6b8:0:1a72::290]:46256)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <yury-kotov@yandex-team.ru>)
	id 1fqKGf-0002n4-NA
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 11:32:57 -0400
From: Yury Kotov <yury-kotov@yandex-team.ru>
Date: Thu, 16 Aug 2018 18:32:41 +0300
Message-Id: <1534433563-30865-2-git-send-email-yury-kotov@yandex-team.ru>
In-Reply-To: <1534433563-30865-1-git-send-email-yury-kotov@yandex-team.ru>
References: <1534433563-30865-1-git-send-email-yury-kotov@yandex-team.ru>
Subject: [Qemu-devel] [PATCH 1/3] chardev: prevent extra connection attempt
 in tcp_chr_machine_done_hook
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Evgeny Yakovlev <wrfsh@yandex-team.ru>

Usually chardev connects to specified address during the initialization.
But if reconnect_time is specified then connection will be postponed until
machine done event.

Thus if reconnect is specified and some device forces connection during
initialization, tcp_chr_machine_done_hook will do useless connection attempt.

So add a check to prevent it.

Signed-off-by: Yury Kotov <yury-kotov@yandex-team.ru>
Signed-off-by: Evgeny Yakovlev <wrfsh@yandex-team.ru>
---
 chardev/char-socket.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/chardev/char-socket.c b/chardev/char-socket.c
index efbad6e..116dcc4 100644
--- a/chardev/char-socket.c
+++ b/chardev/char-socket.c
@@ -1165,7 +1165,10 @@ static int tcp_chr_machine_done_hook(Chardev *chr)
 {
     SocketChardev *s = SOCKET_CHARDEV(chr);
 
-    if (s->reconnect_time) {
+    /* It's possible that connection was established during the device
+     * initialization. So check if the socket is already connected to
+     * prevent extra connection attempt. */
+    if (!s->connected && s->reconnect_time) {
         tcp_chr_connect_async(chr);
     }
 
-- 
2.7.4
