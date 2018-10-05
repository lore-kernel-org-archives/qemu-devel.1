Received: from eggs.gnu.org ([2001:4830:134:3::10]:59203)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1g8PFz-0001Uq-EU
	for qemu-devel@nongnu.org; Fri, 05 Oct 2018 08:31:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1g8PFv-0006me-IH
	for qemu-devel@nongnu.org; Fri, 05 Oct 2018 08:30:59 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59692)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1g8PFt-0006kX-HF
	for qemu-devel@nongnu.org; Fri, 05 Oct 2018 08:30:54 -0400
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Fri,  5 Oct 2018 16:29:08 +0400
Message-Id: <20181005122910.11745-11-marcandre.lureau@redhat.com>
In-Reply-To: <20181005122910.11745-1-marcandre.lureau@redhat.com>
References: <20181005122910.11745-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL v2 10/12] vl: handle -object help
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
index a867c9c4d9..f254b99bdb 100644
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
