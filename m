Received: from eggs.gnu.org ([2001:4830:134:3::10]:52668)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <elohimes@gmail.com>) id 1gUnH4-0001Js-IJ
	for qemu-devel@nongnu.org; Thu, 06 Dec 2018 01:36:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <elohimes@gmail.com>) id 1gUnH1-0003Es-PW
	for qemu-devel@nongnu.org; Thu, 06 Dec 2018 01:36:38 -0500
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544]:34113)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <elohimes@gmail.com>) id 1gUnH1-0003BZ-G7
	for qemu-devel@nongnu.org; Thu, 06 Dec 2018 01:36:35 -0500
Received: by mail-pg1-x544.google.com with SMTP id 17so10208605pgg.1
	for <qemu-devel@nongnu.org>; Wed, 05 Dec 2018 22:36:35 -0800 (PST)
From: elohimes@gmail.com
Date: Thu,  6 Dec 2018 14:35:47 +0800
Message-Id: <20181206063552.6701-2-xieyongji@baidu.com>
In-Reply-To: <20181206063552.6701-1-xieyongji@baidu.com>
References: <20181206063552.6701-1-xieyongji@baidu.com>
Subject: [Qemu-devel] [PATCH for-4.0 1/6] char-socket: Enable "wait" option
 for client mode
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: mst@redhat.com, marcandre.lureau@redhat.com
Cc: qemu-devel@nongnu.org, zhangyu31@baidu.com, chaiwen@baidu.com, nixun@baidu.com, lilin24@baidu.com, Xie Yongji <xieyongji@baidu.com>

From: Xie Yongji <xieyongji@baidu.com>

Now we attempt to connect asynchronously for "reconnect socket"
during open(). But vhost-user device prefer a connected socket
during initialization. That means we may still need to support
sync connection during open() for the "reconnect socket".

Signed-off-by: Xie Yongji <xieyongji@baidu.com>
Signed-off-by: Zhang Yu <zhangyu31@baidu.com>
---
 chardev/char-socket.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/chardev/char-socket.c b/chardev/char-socket.c
index eaa8e8b68f..f2819d52e7 100644
--- a/chardev/char-socket.c
+++ b/chardev/char-socket.c
@@ -1072,7 +1072,7 @@ static void qmp_chardev_open_socket(Chardev *chr,
         s->reconnect_time = reconnect;
     }
 
-    if (s->reconnect_time) {
+    if (s->reconnect_time && !is_waitconnect) {
         tcp_chr_connect_async(chr);
     } else {
         if (s->is_listen) {
@@ -1120,7 +1120,8 @@ static void qemu_chr_parse_socket(QemuOpts *opts, ChardevBackend *backend,
                                   Error **errp)
 {
     bool is_listen      = qemu_opt_get_bool(opts, "server", false);
-    bool is_waitconnect = is_listen && qemu_opt_get_bool(opts, "wait", true);
+    bool is_waitconnect = is_listen ? qemu_opt_get_bool(opts, "wait", true) :
+                          qemu_opt_get_bool(opts, "wait", false);
     bool is_telnet      = qemu_opt_get_bool(opts, "telnet", false);
     bool is_tn3270      = qemu_opt_get_bool(opts, "tn3270", false);
     bool is_websock     = qemu_opt_get_bool(opts, "websocket", false);
-- 
2.17.1
