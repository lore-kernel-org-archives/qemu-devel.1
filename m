Received: from eggs.gnu.org ([2001:4830:134:3::10]:41553)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1et5Em-0001C3-Dt
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 00:34:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1et5Ej-0006wG-At
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 00:34:08 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:52478 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1et5Ej-0006wA-6l
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 00:34:05 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
	[10.11.54.5])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id C7F578182D1E
	for <qemu-devel@nongnu.org>; Tue,  6 Mar 2018 05:34:04 +0000 (UTC)
From: Peter Xu <peterx@redhat.com>
Date: Tue,  6 Mar 2018 13:33:20 +0800
Message-Id: <20180306053320.15401-10-peterx@redhat.com>
In-Reply-To: <20180306053320.15401-1-peterx@redhat.com>
References: <20180306053320.15401-1-peterx@redhat.com>
Subject: [Qemu-devel] [PATCH v2 9/9] chardev: tcp: postpone TLS work until
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, "Daniel P . Berrange" <berrange@redhat.com>, peterx@redhat.com, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

TLS handshake may create background GSource tasks, while we won't know
the correct GMainContext until the whole chardev (including frontend)
inited.  Let's postpone the initial TLS handshake until machine done.

For dynamically created tcp chardev, we don't postpone that by checking
the init_machine_done variable.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 chardev/char-socket.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/chardev/char-socket.c b/chardev/char-socket.c
index bd40864f87..997c70dd7d 100644
--- a/chardev/char-socket.c
+++ b/chardev/char-socket.c
@@ -31,6 +31,7 @@
 #include "qemu/option.h"
 #include "qapi/error.h"
 #include "qapi/clone-visitor.h"
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
@@ -1145,6 +1151,10 @@ static int tcp_chr_machine_done_hook(Chardev *chr)
         tcp_chr_connect_async(chr);
     }
 
+    if (s->tls_creds) {
+        tcp_chr_tls_init(chr);
+    }
+
     return 0;
 }
 
-- 
2.14.3
