Received: from eggs.gnu.org ([2001:4830:134:3::10]:56899)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ewpzU-000187-C1
	for qemu-devel@nongnu.org; Fri, 16 Mar 2018 10:05:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ewpzQ-0005Q2-Vj
	for qemu-devel@nongnu.org; Fri, 16 Mar 2018 10:05:52 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:56438 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1ewpzQ-0005PP-Re
	for qemu-devel@nongnu.org; Fri, 16 Mar 2018 10:05:48 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
	[10.11.54.3])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 808EC402277A
	for <qemu-devel@nongnu.org>; Fri, 16 Mar 2018 14:05:48 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
Date: Fri, 16 Mar 2018 09:04:42 -0500
Message-Id: <20180316140508.863778-13-eblake@redhat.com>
In-Reply-To: <20180316140508.863778-1-eblake@redhat.com>
References: <20180316140508.863778-1-eblake@redhat.com>
Subject: [Qemu-devel] [PULL 12/38] chardev: tcp: postpone TLS work until
 machine done
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: "Daniel P. Berrange" <berrange@redhat.com>, Peter Xu <peterx@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

From: "Daniel P. Berrange" <berrange@redhat.com>

TLS handshake may create background GSource tasks, while we won't know
the correct GMainContext until the whole chardev (including frontend)
inited.  Let's postpone the initial TLS handshake until machine done.

For dynamically created tcp chardev, we don't postpone that by checking
the init_machine_done variable.

Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
[peterx: add missing include line, do unit test]
Signed-off-by: Peter Xu <peterx@redhat.com>
Message-Id: <20180308140714.28906-1-peterx@redhat.com>
Acked-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Eric Blake <eblake@redhat.com>
---
 chardev/char-socket.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/chardev/char-socket.c b/chardev/char-socket.c
index d92c5aee73f..d057192ced0 100644
--- a/chardev/char-socket.c
+++ b/chardev/char-socket.c
@@ -32,6 +32,7 @@
 #include "qapi/error.h"
 #include "qapi/clone-visitor.h"
 #include "qapi/qapi-visit-sockets.h"
+#include "sysemu/sysemu.h"

 #include "chardev/char-io.h"

@@ -722,6 +723,11 @@ static void tcp_chr_tls_init(Chardev *chr)
     Error *err = NULL;
     gchar *name;

+    if (!machine_init_done) {
+        /* This will be postponed to machine_done notifier */
+        return;
+    }
+
     if (s->is_listen) {
         tioc = qio_channel_tls_new_server(
             s->ioc, s->tls_creds,
@@ -1162,6 +1168,10 @@ static int tcp_chr_machine_done_hook(Chardev *chr)
         tcp_chr_connect_async(chr);
     }

+    if (s->ioc && s->tls_creds) {
+        tcp_chr_tls_init(chr);
+    }
+
     return 0;
 }

-- 
2.14.3
