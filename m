Received: from eggs.gnu.org ([2001:4830:134:3::10]:34184)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1g7i0Z-00066J-KT
	for qemu-devel@nongnu.org; Wed, 03 Oct 2018 10:20:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1g7i0X-0005S7-Oy
	for qemu-devel@nongnu.org; Wed, 03 Oct 2018 10:20:11 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39712)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1g7i0X-0005PL-Iw
	for qemu-devel@nongnu.org; Wed, 03 Oct 2018 10:20:09 -0400
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Wed,  3 Oct 2018 18:18:31 +0400
Message-Id: <20181003141833.21493-11-marcandre.lureau@redhat.com>
In-Reply-To: <20181003141833.21493-1-marcandre.lureau@redhat.com>
References: <20181003141833.21493-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 10/12] vl: handle -object help
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

List the user creatable objects.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>
---
 vl.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/vl.c b/vl.c
index 0388852deb..aab1452d1a 100644
--- a/vl.c
+++ b/vl.c
@@ -2698,6 +2698,19 @@ static int machine_set_property(void *opaque,
  */
 static bool object_create_initial(const char *type)
 {
+    if (is_help_option(type)) {
+        GSList *l, *list;
+
+        printf("List of user creatable objects:\n");
+        list =3D object_class_get_list_sorted(TYPE_USER_CREATABLE, false=
);
+        for (l =3D list; l !=3D NULL; l =3D l->next) {
+            ObjectClass *oc =3D OBJECT_CLASS(l->data);
+            printf("%s\n", object_class_get_name(oc));
+        }
+        g_slist_free(list);
+        exit(0);
+    }
+
     if (g_str_equal(type, "rng-egd") ||
         g_str_has_prefix(type, "pr-manager-")) {
         return false;
--=20
2.19.0.271.gfe8321ec05
