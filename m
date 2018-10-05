Received: from eggs.gnu.org ([2001:4830:134:3::10]:58813)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1g8PF4-0000ay-Cc
	for qemu-devel@nongnu.org; Fri, 05 Oct 2018 08:30:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1g8PF1-00062y-4a
	for qemu-devel@nongnu.org; Fri, 05 Oct 2018 08:30:02 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37876)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1g8PF0-00062B-V8
	for qemu-devel@nongnu.org; Fri, 05 Oct 2018 08:29:59 -0400
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Fri,  5 Oct 2018 16:29:03 +0400
Message-Id: <20181005122910.11745-6-marcandre.lureau@redhat.com>
In-Reply-To: <20181005122910.11745-1-marcandre.lureau@redhat.com>
References: <20181005122910.11745-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL v2 05/12] qom/object: fix iterating properties
 over a class
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

object_class_property_iter_init() starts from the given class, so the
next class should continue with the parent class.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>
---
 qom/object.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/qom/object.c b/qom/object.c
index 9222b23172..9eaf08a53c 100644
--- a/qom/object.c
+++ b/qom/object.c
@@ -1115,7 +1115,7 @@ void object_class_property_iter_init(ObjectProperty=
Iterator *iter,
                                      ObjectClass *klass)
 {
     g_hash_table_iter_init(&iter->iter, klass->properties);
-    iter->nextclass =3D klass;
+    iter->nextclass =3D object_class_get_parent(klass);
 }
=20
 ObjectProperty *object_class_property_find(ObjectClass *klass, const cha=
r *name,
--=20
2.19.0.271.gfe8321ec05
