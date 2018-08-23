Received: from eggs.gnu.org ([2001:4830:134:3::10]:39460)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1fsqeH-00015P-PM
	for qemu-devel@nongnu.org; Thu, 23 Aug 2018 10:31:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1fsqeG-00048N-M7
	for qemu-devel@nongnu.org; Thu, 23 Aug 2018 10:31:45 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:60148 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1fsqeG-000455-H9
	for qemu-devel@nongnu.org; Thu, 23 Aug 2018 10:31:44 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
	[10.11.54.5])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id B7BE387A82
	for <qemu-devel@nongnu.org>; Thu, 23 Aug 2018 14:31:38 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Thu, 23 Aug 2018 16:31:21 +0200
Message-Id: <20180823143125.16767-2-marcandre.lureau@redhat.com>
In-Reply-To: <20180823143125.16767-1-marcandre.lureau@redhat.com>
References: <20180823143125.16767-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 1/5] Revert "chardev: tcp: postpone TLS work
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, berrange@redhat.com, peterx@redhat.com, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

This reverts commit 99f2f54174a595e3ada6e4332fcd2b37ebb0d55d.

See next commit reverting 25679e5d58e258e9950685ffbd0cae4cd40d9cc2 as
well for rationale.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 chardev/char-socket.c | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/chardev/char-socket.c b/chardev/char-socket.c
index efbad6ee7c..e28d2cca4c 100644
--- a/chardev/char-socket.c
+++ b/chardev/char-socket.c
@@ -32,7 +32,6 @@
 #include "qapi/error.h"
 #include "qapi/clone-visitor.h"
 #include "qapi/qapi-visit-sockets.h"
-#include "sysemu/sysemu.h"
=20
 #include "chardev/char-io.h"
=20
@@ -724,11 +723,6 @@ static void tcp_chr_tls_init(Chardev *chr)
     Error *err =3D NULL;
     gchar *name;
=20
-    if (!machine_init_done) {
-        /* This will be postponed to machine_done notifier */
-        return;
-    }
-
     if (s->is_listen) {
         tioc =3D qio_channel_tls_new_server(
             s->ioc, s->tls_creds,
@@ -1169,10 +1163,6 @@ static int tcp_chr_machine_done_hook(Chardev *chr)
         tcp_chr_connect_async(chr);
     }
=20
-    if (s->ioc && s->tls_creds) {
-        tcp_chr_tls_init(chr);
-    }
-
     return 0;
 }
=20
--=20
2.18.0.547.g1d89318c48
