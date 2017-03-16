Received: from eggs.gnu.org ([2001:4830:134:3::10]:47070)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1coRbZ-0004IZ-Jo
	for qemu-devel@nongnu.org; Thu, 16 Mar 2017 05:21:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1coRbY-0000JD-Im
	for qemu-devel@nongnu.org; Thu, 16 Mar 2017 05:21:57 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53910)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1coRbY-0000IX-BA
	for qemu-devel@nongnu.org; Thu, 16 Mar 2017 05:21:56 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 6CAE364D8A
	for <qemu-devel@nongnu.org>; Thu, 16 Mar 2017 09:21:56 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Thu, 16 Mar 2017 13:21:07 +0400
Message-Id: <20170316092121.25672-8-marcandre.lureau@redhat.com>
In-Reply-To: <20170316092121.25672-1-marcandre.lureau@redhat.com>
References: <20170316092121.25672-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v3 07/21] char: use /chardevs container instead
 of chardevs list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, eblake@redhat.com, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

Use object_resolve_path_component() and object_child_foreach() on
/chardevs container instead of iterating over chardevs list.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 chardev/char.c | 66 ++++++++++++++++++++++++++++++++--------------------=
------
 1 file changed, 36 insertions(+), 30 deletions(-)

diff --git a/chardev/char.c b/chardev/char.c
index 5456fb2e3a..1859680bea 100644
--- a/chardev/char.c
+++ b/chardev/char.c
@@ -455,21 +455,24 @@ static const TypeInfo char_type_info =3D {
  * mux will receive CHR_EVENT_OPENED notifications for the BE
  * immediately.
  */
-static void muxes_realize_done(Notifier *notifier, void *unused)
+static int open_muxes(Object *child, void *opaque)
 {
-    Chardev *chr;
+    if (CHARDEV_IS_MUX(child)) {
+        /* send OPENED to all already-attached FEs */
+        mux_chr_send_all_event(CHARDEV(child), CHR_EVENT_OPENED);
+        /* mark mux as OPENED so any new FEs will immediately receive
+         * OPENED event
+         */
+        qemu_chr_be_event(CHARDEV(child), CHR_EVENT_OPENED);
+    }
=20
+    return 0;
+}
+
+static void muxes_realize_done(Notifier *notifier, void *unused)
+{
     muxes_realized =3D true;
-    QTAILQ_FOREACH(chr, &chardevs, next) {
-        if (CHARDEV_IS_MUX(chr)) {
-            /* send OPENED to all already-attached FEs */
-            mux_chr_send_all_event(CHARDEV(chr), CHR_EVENT_OPENED);
-            /* mark mux as OPENED so any new FEs will immediately receiv=
e
-             * OPENED event
-             */
-            qemu_chr_be_event(chr, CHR_EVENT_OPENED);
-        }
-    }
+    object_child_foreach(get_chardevs_root(), open_muxes, NULL);
 }
=20
 static Notifier muxes_realize_notify =3D {
@@ -1068,21 +1071,29 @@ void qemu_chr_fe_disconnect(CharBackend *be)
     }
 }
=20
+static int qmp_query_chardev_foreach(Object *obj, void *data)
+{
+    Chardev *chr =3D CHARDEV(obj);
+    ChardevInfoList **list =3D data;
+    ChardevInfoList *info =3D g_malloc0(sizeof(*info));
+
+    info->value =3D g_malloc0(sizeof(*info->value));
+    info->value->label =3D g_strdup(chr->label);
+    info->value->filename =3D g_strdup(chr->filename);
+    info->value->frontend_open =3D chr->be && chr->be->fe_open;
+
+    info->next =3D *list;
+    *list =3D info;
+
+    return 0;
+}
+
 ChardevInfoList *qmp_query_chardev(Error **errp)
 {
     ChardevInfoList *chr_list =3D NULL;
-    Chardev *chr;
-
-    QTAILQ_FOREACH(chr, &chardevs, next) {
-        ChardevInfoList *info =3D g_malloc0(sizeof(*info));
-        info->value =3D g_malloc0(sizeof(*info->value));
-        info->value->label =3D g_strdup(chr->label);
-        info->value->filename =3D g_strdup(chr->filename);
-        info->value->frontend_open =3D chr->be && chr->be->fe_open;
=20
-        info->next =3D chr_list;
-        chr_list =3D info;
-    }
+    object_child_foreach(get_chardevs_root(),
+                         qmp_query_chardev_foreach, &chr_list);
=20
     return chr_list;
 }
@@ -1110,14 +1121,9 @@ ChardevBackendInfoList *qmp_query_chardev_backends=
(Error **errp)
=20
 Chardev *qemu_chr_find(const char *name)
 {
-    Chardev *chr;
+    Object *obj =3D object_resolve_path_component(get_chardevs_root(), n=
ame);
=20
-    QTAILQ_FOREACH(chr, &chardevs, next) {
-        if (strcmp(chr->label, name) !=3D 0)
-            continue;
-        return chr;
-    }
-    return NULL;
+    return obj ? CHARDEV(obj) : NULL;
 }
=20
 QemuOptsList qemu_chardev_opts =3D {
--=20
2.12.0.191.gc5d8de91d
