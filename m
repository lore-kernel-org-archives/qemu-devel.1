Received: from eggs.gnu.org ([2001:4830:134:3::10]:48590)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1fxvy7-0000Sm-DI
	for qemu-devel@nongnu.org; Thu, 06 Sep 2018 11:13:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1fxvy4-00024N-A6
	for qemu-devel@nongnu.org; Thu, 06 Sep 2018 11:13:15 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:58572 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1fxvy4-00024B-4a
	for qemu-devel@nongnu.org; Thu, 06 Sep 2018 11:13:12 -0400
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Thu,  6 Sep 2018 19:12:25 +0400
Message-Id: <20180906151227.25514-9-marcandre.lureau@redhat.com>
In-Reply-To: <20180906151227.25514-1-marcandre.lureau@redhat.com>
References: <20180906151227.25514-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 08/10] vl: handle -object ?
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

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 vl.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/vl.c b/vl.c
index 5ba06adf78..8a5fd0c81f 100644
--- a/vl.c
+++ b/vl.c
@@ -2731,6 +2731,19 @@ static int machine_set_property(void *opaque,
  */
 static bool object_create_initial(const char *type)
 {
+    if (is_help_option(type)) {
+        GSList *l, *list;
+
+        error_printf("List of user creatable objects:\n");
+        list =3D object_class_get_list_sorted(TYPE_USER_CREATABLE, false=
);
+        for (l =3D list; l !=3D NULL; l =3D l->next) {
+            ObjectClass *oc =3D OBJECT_CLASS(l->data);
+            error_printf("%s\n", object_class_get_name(oc));
+        }
+        g_slist_free(list);
+        exit(0);
+    }
+
     if (g_str_equal(type, "rng-egd") ||
         g_str_has_prefix(type, "pr-manager-")) {
         return false;
--=20
2.19.0.rc1
