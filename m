Received: from eggs.gnu.org ([2001:4830:134:3::10]:47152)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1coRbj-0004P0-8H
	for qemu-devel@nongnu.org; Thu, 16 Mar 2017 05:22:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1coRbh-0000OH-5q
	for qemu-devel@nongnu.org; Thu, 16 Mar 2017 05:22:07 -0400
Received: from mx1.redhat.com ([209.132.183.28]:63192)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1coRbg-0000O0-W7
	for qemu-devel@nongnu.org; Thu, 16 Mar 2017 05:22:05 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 15FA8804E2
	for <qemu-devel@nongnu.org>; Thu, 16 Mar 2017 09:22:05 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Thu, 16 Mar 2017 13:21:09 +0400
Message-Id: <20170316092121.25672-10-marcandre.lureau@redhat.com>
In-Reply-To: <20170316092121.25672-1-marcandre.lureau@redhat.com>
References: <20170316092121.25672-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v3 09/21] char: remove chardevs list
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
 include/sysemu/char.h | 1 -
 chardev/char.c        | 6 ------
 2 files changed, 7 deletions(-)

diff --git a/include/sysemu/char.h b/include/sysemu/char.h
index 98903f31e4..729d186d01 100644
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
diff --git a/chardev/char.c b/chardev/char.c
index 276d27f403..aee8b4555d 100644
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
@@ -418,9 +415,6 @@ static void char_finalize(Object *obj)
 {
     Chardev *chr =3D CHARDEV(obj);
=20
-    if (QTAILQ_IN_USE(chr, next)) {
-        QTAILQ_REMOVE(&chardevs, chr, next);
-    }
     if (chr->be) {
         chr->be->chr =3D NULL;
     }
--=20
2.12.0.191.gc5d8de91d
