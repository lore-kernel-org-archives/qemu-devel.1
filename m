Received: from eggs.gnu.org ([2001:4830:134:3::10]:60468)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1g04dy-0005jW-5u
	for qemu-devel@nongnu.org; Wed, 12 Sep 2018 08:53:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1g04du-0005ns-Gs
	for qemu-devel@nongnu.org; Wed, 12 Sep 2018 08:53:18 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:58864 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1g04du-0005kl-CD
	for qemu-devel@nongnu.org; Wed, 12 Sep 2018 08:53:14 -0400
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Wed, 12 Sep 2018 16:53:03 +0400
Message-Id: <20180912125303.29158-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH] qom/object: add some interface asserts
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>

An interface can't have any instance size or callback, or itself
implement other interfaces (this is unsupported).

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 qom/object.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/qom/object.c b/qom/object.c
index 75d1d48944..9222b23172 100644
--- a/qom/object.c
+++ b/qom/object.c
@@ -286,7 +286,14 @@ static void type_initialize(TypeImpl *ti)
     if (ti->instance_size =3D=3D 0) {
         ti->abstract =3D true;
     }
-
+    if (type_is_ancestor(ti, type_interface)) {
+        assert(ti->instance_size =3D=3D 0);
+        assert(ti->abstract);
+        assert(!ti->instance_init);
+        assert(!ti->instance_post_init);
+        assert(!ti->instance_finalize);
+        assert(!ti->num_interfaces);
+    }
     ti->class =3D g_malloc0(ti->class_size);
=20
     parent =3D type_get_parent(ti);
--=20
2.19.0.rc1
