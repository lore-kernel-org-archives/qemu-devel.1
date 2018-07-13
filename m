Received: from eggs.gnu.org ([2001:4830:134:3::10]:40962)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1fdxp5-0003fE-LU
	for qemu-devel@nongnu.org; Fri, 13 Jul 2018 09:09:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1fdxp4-0001Hg-NZ
	for qemu-devel@nongnu.org; Fri, 13 Jul 2018 09:09:23 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:57088 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1fdxp4-0001Fa-Ir
	for qemu-devel@nongnu.org; Fri, 13 Jul 2018 09:09:22 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
	[10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 459A3C12A5
	for <qemu-devel@nongnu.org>; Fri, 13 Jul 2018 13:09:22 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Fri, 13 Jul 2018 15:08:50 +0200
Message-Id: <20180713130916.4153-4-marcandre.lureau@redhat.com>
In-Reply-To: <20180713130916.4153-1-marcandre.lureau@redhat.com>
References: <20180713130916.4153-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v4 03/29] chardev: unref if underlying chardev
 has no parent
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: airlied@redhat.com, kraxel@redhat.com, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

It's possible to write code creating a chardev backend that is not
registered. When it is not user-created, it makes sense to keep it
hidden. Let the associated frontend destroy it also in this case.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
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
2.18.0.129.ge3331758f1
