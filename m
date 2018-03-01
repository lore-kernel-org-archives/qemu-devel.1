Received: from eggs.gnu.org ([2001:4830:134:3::10]:52331)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1erJpf-0007c7-34
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 03:44:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1erJpe-0006ly-BP
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 03:44:55 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:39586 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1erJpe-0006lo-77
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 03:44:54 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
	[10.11.54.5])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id C28768D6F1
	for <qemu-devel@nongnu.org>; Thu,  1 Mar 2018 08:44:53 +0000 (UTC)
From: Peter Xu <peterx@redhat.com>
Date: Thu,  1 Mar 2018 16:44:24 +0800
Message-Id: <20180301084438.13594-2-peterx@redhat.com>
In-Reply-To: <20180301084438.13594-1-peterx@redhat.com>
References: <20180301084438.13594-1-peterx@redhat.com>
Subject: [Qemu-devel] [PATCH v2 01/15] chardev: fix leak in
 tcp_chr_telnet_init_io()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, "Daniel P . Berrange" <berrange@redhat.com>, Juan Quintela <quintela@redhat.com>, peterx@redhat.com, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, Markus Armbruster <armbru@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>

Need to free TCPChardevTelnetInit when session established.

Since at it, switch to use G_SOURCE_* macros.

Reviewed-by: Daniel P. Berrange <berrange@redhat.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 chardev/char-socket.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/chardev/char-socket.c b/chardev/char-socket.c
index bdd6cff5f6..43a2cc2c1c 100644
--- a/chardev/char-socket.c
+++ b/chardev/char-socket.c
@@ -591,19 +591,23 @@ static gboolean tcp_chr_telnet_init_io(QIOChannel *ioc,
             ret = 0;
         } else {
             tcp_chr_disconnect(init->chr);
-            return FALSE;
+            goto end;
         }
     }
     init->buflen -= ret;
 
     if (init->buflen == 0) {
         tcp_chr_connect(init->chr);
-        return FALSE;
+        goto end;
     }
 
     memmove(init->buf, init->buf + ret, init->buflen);
 
-    return TRUE;
+    return G_SOURCE_CONTINUE;
+
+end:
+    g_free(init);
+    return G_SOURCE_REMOVE;
 }
 
 static void tcp_chr_telnet_init(Chardev *chr)
-- 
2.14.3
