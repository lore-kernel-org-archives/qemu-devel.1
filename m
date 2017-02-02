Received: from eggs.gnu.org ([2001:4830:134:3::10]:39675)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1cZIkQ-0004we-WD
	for qemu-devel@nongnu.org; Thu, 02 Feb 2017 09:52:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1cZIkN-0004HW-2W
	for qemu-devel@nongnu.org; Thu, 02 Feb 2017 09:52:31 -0500
Received: from mx1.redhat.com ([209.132.183.28]:45688)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1cZIkM-0004HA-Sa
	for qemu-devel@nongnu.org; Thu, 02 Feb 2017 09:52:26 -0500
Received: from int-mx14.intmail.prod.int.phx2.redhat.com
	(int-mx14.intmail.prod.int.phx2.redhat.com [10.5.11.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 003E0804EE
	for <qemu-devel@nongnu.org>; Thu,  2 Feb 2017 14:52:27 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Thu,  2 Feb 2017 18:51:28 +0400
Message-Id: <20170202145141.17138-10-marcandre.lureau@redhat.com>
In-Reply-To: <20170202145141.17138-1-marcandre.lureau@redhat.com>
References: <20170202145141.17138-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 09/22] char: remove chardevs list
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

The list is now empty, the chardev cleanup is taken care of by the unref
of the root container.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 include/sysemu/char.h |  8 --------
 chardev/char.c        | 15 ---------------
 vl.c                  |  1 -
 3 files changed, 24 deletions(-)

diff --git a/include/sysemu/char.h b/include/sysemu/char.h
index e3f3a10d17..e273c94421 100644
--- a/include/sysemu/char.h
+++ b/include/sysemu/char.h
@@ -95,7 +95,6 @@ struct Chardev {
     int be_open;
     guint fd_in_tag;
     DECLARE_BITMAP(features, QEMU_CHAR_FEATURE_LAST);
-    QTAILQ_ENTRY(Chardev) next;
 };
=20
 /**
@@ -142,13 +141,6 @@ Chardev *qemu_chr_new(const char *label, const char =
*filename);
 void qemu_chr_fe_disconnect(CharBackend *be);
=20
 /**
- * @qemu_chr_cleanup:
- *
- * Delete all chardevs (when leaving qemu)
- */
-void qemu_chr_cleanup(void);
-
-/**
  * @qemu_chr_fe_wait_connected:
  *
  * Wait for characted backend to be connected, return < 0 on error or
diff --git a/chardev/char.c b/chardev/char.c
index 1103b08177..f47d933828 100644
--- a/chardev/char.c
+++ b/chardev/char.c
@@ -42,9 +42,6 @@
 /***********************************************************/
 /* character device */
=20
-static QTAILQ_HEAD(ChardevHead, Chardev) chardevs =3D
-    QTAILQ_HEAD_INITIALIZER(chardevs);
-
 static Object *get_chardevs_root(void)
 {
     return container_get(object_get_root(), "/chardevs");
@@ -1050,9 +1047,6 @@ void qemu_chr_fe_disconnect(CharBackend *be)
=20
 void qemu_chr_delete(Chardev *chr)
 {
-    if (QTAILQ_IN_USE(chr, next)) {
-        QTAILQ_REMOVE(&chardevs, chr, next);
-    }
     if (OBJECT(chr)->parent) {
         object_unparent(OBJECT(chr));
     } else {
@@ -1317,15 +1311,6 @@ void qmp_chardev_remove(const char *id, Error **er=
rp)
     qemu_chr_delete(chr);
 }
=20
-void qemu_chr_cleanup(void)
-{
-    Chardev *chr, *tmp;
-
-    QTAILQ_FOREACH_SAFE(chr, &chardevs, next, tmp) {
-        qemu_chr_delete(chr);
-    }
-}
-
 static void register_types(void)
 {
     type_register_static(&char_type_info);
diff --git a/vl.c b/vl.c
index 945df1d17f..7bce3b07e2 100644
--- a/vl.c
+++ b/vl.c
@@ -4639,7 +4639,6 @@ int main(int argc, char **argv, char **envp)
     net_cleanup();
     audio_cleanup();
     monitor_cleanup();
-    qemu_chr_cleanup();
     object_unref(object_get_root());
=20
     return 0;
--=20
2.11.0.295.gd7dffce1c.dirty
