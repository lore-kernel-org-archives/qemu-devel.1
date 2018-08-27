Received: from eggs.gnu.org ([2001:4830:134:3::10]:56674)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1fuPvE-0003lS-Kv
	for qemu-devel@nongnu.org; Mon, 27 Aug 2018 18:23:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1fuPv9-0005qv-Iy
	for qemu-devel@nongnu.org; Mon, 27 Aug 2018 18:23:44 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:34114 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1fuPv9-0005qI-AW
	for qemu-devel@nongnu.org; Mon, 27 Aug 2018 18:23:39 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
	[10.11.54.3])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id E28FD87A82
	for <qemu-devel@nongnu.org>; Mon, 27 Aug 2018 22:23:38 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Tue, 28 Aug 2018 00:23:18 +0200
Message-Id: <20180827222322.26009-6-marcandre.lureau@redhat.com>
In-Reply-To: <20180827222322.26009-1-marcandre.lureau@redhat.com>
References: <20180827222322.26009-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 5/9] char-fe: set_handlers() needs an associted
 chardev
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, berrange@redhat.com, armbru@redhat.com, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

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
index 21071f1fb1..4677a9e65a 100644
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
index 6ed8bff46a..e3b1c54721 100644
--- a/chardev/char-fe.c
+++ b/chardev/char-fe.c
@@ -254,14 +254,9 @@ void qemu_chr_fe_set_handlers(CharBackend *b,
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
2.18.0.547.g1d89318c48
