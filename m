Received: from eggs.gnu.org ([2001:4830:134:3::10]:58613)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1etwCm-0008V3-5M
	for qemu-devel@nongnu.org; Thu, 08 Mar 2018 09:07:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1etwCg-0005tQ-JZ
	for qemu-devel@nongnu.org; Thu, 08 Mar 2018 09:07:36 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:59038 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1etwCg-0005tK-Fu
	for qemu-devel@nongnu.org; Thu, 08 Mar 2018 09:07:30 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
	[10.11.54.3])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 70B684000787
	for <qemu-devel@nongnu.org>; Thu,  8 Mar 2018 14:07:26 +0000 (UTC)
From: Peter Xu <peterx@redhat.com>
Date: Thu,  8 Mar 2018 22:07:14 +0800
Message-Id: <20180308140714.28906-1-peterx@redhat.com>
In-Reply-To: <20180306053320.15401-10-peterx@redhat.com>
Subject: [Qemu-devel] [PATCH v2.1 9/9] chardev: tcp: postpone TLS work until
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
Cc: pbonzini@redhat.com, peterx@redhat.com, stefanha@redhat.com, berrange@redhat.com, marcandre.lureau@redhat.com

From: "Daniel P. Berrange" <berrange@redhat.com>

TLS handshake may create background GSource tasks, while we won't know
the correct GMainContext until the whole chardev (including frontend)
inited.  Let's postpone the initial TLS handshake until machine done.

For dynamically created tcp chardev, we don't postpone that by checking
the init_machine_done variable.

Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
[peterx: add missing include line, do unit test]
Signed-off-by: Peter Xu <peterx@redhat.com>
---

Paolo: please feel free to review/queue this one if your pull test has
not yet started.  Thanks.

 chardev/char-socket.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/chardev/char-socket.c b/chardev/char-socket.c
index a1966aae51..f02bf118c9 100644
--- a/chardev/char-socket.c
+++ b/chardev/char-socket.c
@@ -32,6 +32,7 @@
 #include "qapi/error.h"
 #include "qapi/clone-visitor.h"
 #include "qapi/qapi-visit-sockets.h"
+#include "sysemu/sysemu.h"
 
 #include "chardev/char-io.h"
 
@@ -723,6 +724,11 @@ static void tcp_chr_tls_init(Chardev *chr)
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
@@ -1146,6 +1152,10 @@ static int tcp_chr_machine_done_hook(Chardev *chr)
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
