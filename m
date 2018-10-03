Received: from eggs.gnu.org ([2001:4830:134:3::10]:42161)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1g7erW-0000RU-Ar
	for qemu-devel@nongnu.org; Wed, 03 Oct 2018 06:58:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1g7erS-0002iM-6H
	for qemu-devel@nongnu.org; Wed, 03 Oct 2018 06:58:38 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59836)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1g7erR-0002dP-Oc
	for qemu-devel@nongnu.org; Wed, 03 Oct 2018 06:58:33 -0400
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Wed,  3 Oct 2018 14:57:52 +0400
Message-Id: <20181003105755.10862-4-marcandre.lureau@redhat.com>
In-Reply-To: <20181003105755.10862-1-marcandre.lureau@redhat.com>
References: <20181003105755.10862-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 3/6] chardev: unref if underlying chardev has no
 parent
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

It's possible to write code creating a chardev backend that is not
registered. When it is not user-created, it makes sense to keep it
hidden. Let the associated frontend destroy it also in this case.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
---
 chardev/char-fe.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/chardev/char-fe.c b/chardev/char-fe.c
index f158f158f8..a8931f7afd 100644
--- a/chardev/char-fe.c
+++ b/chardev/char-fe.c
@@ -235,7 +235,12 @@ void qemu_chr_fe_deinit(CharBackend *b, bool del)
             d->backends[b->tag] =3D NULL;
         }
         if (del) {
-            object_unparent(OBJECT(b->chr));
+            Object *obj =3D OBJECT(b->chr);
+            if (obj->parent) {
+                object_unparent(obj);
+            } else {
+                object_unref(obj);
+            }
         }
         b->chr =3D NULL;
     }
--=20
2.19.0.271.gfe8321ec05
