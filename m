Received: from eggs.gnu.org ([2001:4830:134:3::10]:51314)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peng.hao2@zte.com.cn>) id 1eejOd-0005sl-0W
	for qemu-devel@nongnu.org; Thu, 25 Jan 2018 10:24:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peng.hao2@zte.com.cn>) id 1eejOa-0006uQ-Df
	for qemu-devel@nongnu.org; Thu, 25 Jan 2018 10:24:59 -0500
Received: from out1.zte.com.cn ([202.103.147.172]:49008 helo=mxct.zte.com.cn)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peng.hao2@zte.com.cn>)
	id 1eejOa-0006qn-0z
	for qemu-devel@nongnu.org; Thu, 25 Jan 2018 10:24:56 -0500
From: Peng Hao <peng.hao2@zte.com.cn>
Date: Fri, 26 Jan 2018 07:40:04 +0800
Message-Id: <1516923604-101518-1-git-send-email-peng.hao2@zte.com.cn>
Subject: [Qemu-devel] [PATCH]  char-pty: avoid assertion warning
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: pbonzini@redhat.com, marcandre.lureau@redhat.com
Cc: qemu-devel@nongnu.org, Peng Hao <peng.hao2@zte.com.cn>

g_source_unref(s->open_source) in pty_chr_timer may trigger a assertion like this:
g_source_unref: assertion 'source != NULL' failed.
pty_chr_update_read_handler_locked-->pty_chr_state(chr, 0) may be called
in pty_chr_timer, pty_chr_state(chr, 0) will call g_source_unref(s->open_source)
and set s->open_source=NULL.

Signed-off-by: Peng Hao <peng.hao2@zte.com.cn>
---
 chardev/char-pty.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/chardev/char-pty.c b/chardev/char-pty.c
index 89315e6..da0f286 100644
--- a/chardev/char-pty.c
+++ b/chardev/char-pty.c
@@ -58,8 +58,10 @@ static gboolean pty_chr_timer(gpointer opaque)
 
     qemu_mutex_lock(&chr->chr_write_lock);
     s->timer_src = NULL;
-    g_source_unref(s->open_source);
-    s->open_source = NULL;
+    if (s->open_source) {
+        g_source_unref(s->open_source);
+        s->open_source = NULL;
+    }
     if (!s->connected) {
         /* Next poll ... */
         pty_chr_update_read_handler_locked(chr);
-- 
1.8.3.1
