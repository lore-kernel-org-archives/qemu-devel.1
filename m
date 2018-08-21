Received: from eggs.gnu.org ([2001:4830:134:3::10]:33976)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1fsA4y-0002Sh-5a
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 13:04:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1fsA4q-0007G3-6V
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 13:04:25 -0400
Received: from mail-wm0-x233.google.com ([2a00:1450:400c:c09::233]:36958)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1fsA4p-0007F0-Ui
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 13:04:20 -0400
Received: by mail-wm0-x233.google.com with SMTP id n11-v6so3497324wmc.2
	for <qemu-devel@nongnu.org>; Tue, 21 Aug 2018 10:04:19 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 21 Aug 2018 19:02:43 +0200
Message-Id: <1534870966-9287-72-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1534870966-9287-1-git-send-email-pbonzini@redhat.com>
References: <1534870966-9287-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 71/74] Revert "chardev: tcp: postpone TLS work
 until machine done"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

From: Marc-André Lureau <marcandre.lureau@redhat.com>

This reverts commit 99f2f54174a595e3ada6e4332fcd2b37ebb0d55d.

See next commit reverting 25679e5d58e258e9950685ffbd0cae4cd40d9cc2 as
well for rationale.

Signed-off-by: Marc-AndrÃ© Lureau <marcandre.lureau@redhat.com>
Message-Id: <20180817135224.22971-2-marcandre.lureau@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 chardev/char-socket.c | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/chardev/char-socket.c b/chardev/char-socket.c
index efbad6e..e28d2cc 100644
--- a/chardev/char-socket.c
+++ b/chardev/char-socket.c
@@ -32,7 +32,6 @@
 #include "qapi/error.h"
 #include "qapi/clone-visitor.h"
 #include "qapi/qapi-visit-sockets.h"
-#include "sysemu/sysemu.h"
 
 #include "chardev/char-io.h"
 
@@ -724,11 +723,6 @@ static void tcp_chr_tls_init(Chardev *chr)
     Error *err = NULL;
     gchar *name;
 
-    if (!machine_init_done) {
-        /* This will be postponed to machine_done notifier */
-        return;
-    }
-
     if (s->is_listen) {
         tioc = qio_channel_tls_new_server(
             s->ioc, s->tls_creds,
@@ -1169,10 +1163,6 @@ static int tcp_chr_machine_done_hook(Chardev *chr)
         tcp_chr_connect_async(chr);
     }
 
-    if (s->ioc && s->tls_creds) {
-        tcp_chr_tls_init(chr);
-    }
-
     return 0;
 }
 
-- 
1.8.3.1
