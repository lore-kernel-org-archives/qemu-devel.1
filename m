Received: from eggs.gnu.org ([209.51.188.92]:33086)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1grREr-0005i7-Be
	for qemu-devel@nongnu.org; Wed, 06 Feb 2019 12:43:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1grREp-0004JX-93
	for qemu-devel@nongnu.org; Wed, 06 Feb 2019 12:43:57 -0500
Received: from mx1.redhat.com ([209.132.183.28]:53710)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1grREo-00049Y-RC
	for qemu-devel@nongnu.org; Wed, 06 Feb 2019 12:43:55 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 9B31119F43
	for <qemu-devel@nongnu.org>; Wed,  6 Feb 2019 17:43:42 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Wed,  6 Feb 2019 18:43:24 +0100
Message-Id: <20190206174328.9736-3-marcandre.lureau@redhat.com>
In-Reply-To: <20190206174328.9736-1-marcandre.lureau@redhat.com>
References: <20190206174328.9736-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 2/6] char-fe: set_handlers() needs an
 associated chardev
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

It is futile to call qemu_chr_fe_set_handlers() without an associated
chardev, because the function is doing nothing in that case, not even
reporting an error, it would likely be a programming error. Let's not
handle that hypothetical case.

(fwiw, I introduced the check in commit
94a40fc56036b5058b0b194d9e372a22e65ce7be, that was a mistake imho)

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 include/chardev/char-fe.h | 2 --
 chardev/char-fe.c         | 7 +------
 2 files changed, 1 insertion(+), 8 deletions(-)

diff --git a/include/chardev/char-fe.h b/include/chardev/char-fe.h
index 46c997d352..54f0d61d32 100644
--- a/include/chardev/char-fe.h
+++ b/include/chardev/char-fe.h
@@ -82,8 +82,6 @@ bool qemu_chr_fe_backend_open(CharBackend *be);
  *
  * Set the front end char handlers. The front end takes the focus if
  * any of the handler is non-NULL.
- *
- * Without associated Chardev, nothing is changed.
  */
 void qemu_chr_fe_set_handlers(CharBackend *b,
                               IOCanReadHandler *fd_can_read,
diff --git a/chardev/char-fe.c b/chardev/char-fe.c
index f69ca18647..4ec9823d34 100644
--- a/chardev/char-fe.c
+++ b/chardev/char-fe.c
@@ -255,14 +255,9 @@ void qemu_chr_fe_set_handlers(CharBackend *b,
                               GMainContext *context,
                               bool set_open)
 {
-    Chardev *s;
+    Chardev *s =3D b->chr;
     int fe_open;
=20
-    s =3D b->chr;
-    if (!s) {
-        return;
-    }
-
     if (!opaque && !fd_can_read && !fd_read && !fd_event) {
         fe_open =3D 0;
         remove_fd_in_watch(s);
--=20
2.20.1.519.g8feddda32c
