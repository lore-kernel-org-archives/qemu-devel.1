Received: from eggs.gnu.org ([2001:4830:134:3::10]:58935)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1g8PFU-00011c-Mj
	for qemu-devel@nongnu.org; Fri, 05 Oct 2018 08:30:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1g8PFR-0006P4-EH
	for qemu-devel@nongnu.org; Fri, 05 Oct 2018 08:30:27 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38752)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1g8PFP-0006L2-CS
	for qemu-devel@nongnu.org; Fri, 05 Oct 2018 08:30:24 -0400
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Fri,  5 Oct 2018 16:29:04 +0400
Message-Id: <20181005122910.11745-7-marcandre.lureau@redhat.com>
In-Reply-To: <20181005122910.11745-1-marcandre.lureau@redhat.com>
References: <20181005122910.11745-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL v2 06/12] qom/object: register 'type' property
 as class property
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

Let's save a few byte in each object instance.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>
---
 qom/object.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/qom/object.c b/qom/object.c
index 9eaf08a53c..547dcf97c3 100644
--- a/qom/object.c
+++ b/qom/object.c
@@ -2430,9 +2430,10 @@ void object_class_property_set_description(ObjectC=
lass *klass,
     op->description =3D g_strdup(description);
 }
=20
-static void object_instance_init(Object *obj)
+static void object_class_init(ObjectClass *klass, void *data)
 {
-    object_property_add_str(obj, "type", qdev_get_type, NULL, NULL);
+    object_class_property_add_str(klass, "type", qdev_get_type,
+                                  NULL, &error_abort);
 }
=20
 static void register_types(void)
@@ -2446,7 +2447,7 @@ static void register_types(void)
     static TypeInfo object_info =3D {
         .name =3D TYPE_OBJECT,
         .instance_size =3D sizeof(Object),
-        .instance_init =3D object_instance_init,
+        .class_init =3D object_class_init,
         .abstract =3D true,
     };
=20
--=20
2.19.0.271.gfe8321ec05
