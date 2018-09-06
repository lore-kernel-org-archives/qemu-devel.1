Received: from eggs.gnu.org ([2001:4830:134:3::10]:48489)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1fxvxi-0000Am-V9
	for qemu-devel@nongnu.org; Thu, 06 Sep 2018 11:12:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1fxvxg-0001hg-QO
	for qemu-devel@nongnu.org; Thu, 06 Sep 2018 11:12:50 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:41090 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1fxvxg-0001gL-KI
	for qemu-devel@nongnu.org; Thu, 06 Sep 2018 11:12:48 -0400
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Thu,  6 Sep 2018 19:12:20 +0400
Message-Id: <20180906151227.25514-4-marcandre.lureau@redhat.com>
In-Reply-To: <20180906151227.25514-1-marcandre.lureau@redhat.com>
References: <20180906151227.25514-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 03/10] qom/object: fix iterating properties
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>, =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>, Eduardo Habkost <ehabkost@redhat.com>, Markus Armbruster <armbru@redhat.com>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

object_class_property_iter_init() starts from the given class, so the
next class should continue with the parent class.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 qom/object.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/qom/object.c b/qom/object.c
index 75d1d48944..d8666de3f2 100644
--- a/qom/object.c
+++ b/qom/object.c
@@ -1108,7 +1108,7 @@ void object_class_property_iter_init(ObjectProperty=
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
2.19.0.rc1
