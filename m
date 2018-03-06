Received: from eggs.gnu.org ([2001:4830:134:3::10]:41441)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1et5EK-0000ru-QM
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 00:33:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1et5EJ-0006hs-IM
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 00:33:40 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:52460 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1et5EJ-0006ho-Dh
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 00:33:39 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
	[10.11.54.5])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 06A8E8163C5F
	for <qemu-devel@nongnu.org>; Tue,  6 Mar 2018 05:33:39 +0000 (UTC)
From: Peter Xu <peterx@redhat.com>
Date: Tue,  6 Mar 2018 13:33:13 +0800
Message-Id: <20180306053320.15401-3-peterx@redhat.com>
In-Reply-To: <20180306053320.15401-1-peterx@redhat.com>
References: <20180306053320.15401-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 2/9] chardev: fix leak in
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, "Daniel P . Berrange" <berrange@redhat.com>, peterx@redhat.com, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

Need to free TCPChardevTelnetInit when session established.

Since at it, switch to use G_SOURCE_* macros.

Reviewed-by: Daniel P. Berrange <berrange@redhat.com>
Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>
Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 chardev/char-socket.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/chardev/char-socket.c b/chardev/char-socket.c
index 113feaf948..205ee377a4 100644
--- a/chardev/char-socket.c
+++ b/chardev/char-socket.c
@@ -591,19 +591,23 @@ static gboolean tcp_chr_telnet_init_io(QIOChannel *=
ioc,
             ret =3D 0;
         } else {
             tcp_chr_disconnect(init->chr);
-            return FALSE;
+            goto end;
         }
     }
     init->buflen -=3D ret;
=20
     if (init->buflen =3D=3D 0) {
         tcp_chr_connect(init->chr);
-        return FALSE;
+        goto end;
     }
=20
     memmove(init->buf, init->buf + ret, init->buflen);
=20
-    return TRUE;
+    return G_SOURCE_CONTINUE;
+
+end:
+    g_free(init);
+    return G_SOURCE_REMOVE;
 }
=20
 static void tcp_chr_telnet_init(Chardev *chr)
--=20
2.14.3
