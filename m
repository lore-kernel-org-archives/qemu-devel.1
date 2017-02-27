Received: from eggs.gnu.org ([2001:4830:134:3::10]:53427)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1ciLZn-0001uI-Nw
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 08:42:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1ciLZm-0001eJ-SC
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 08:42:55 -0500
Received: from mx1.redhat.com ([209.132.183.28]:38808)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1ciLZm-0001dy-Lj
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 08:42:54 -0500
Received: from int-mx13.intmail.prod.int.phx2.redhat.com
	(int-mx13.intmail.prod.int.phx2.redhat.com [10.5.11.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id BF69F4E4D4
	for <qemu-devel@nongnu.org>; Mon, 27 Feb 2017 13:42:54 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Mon, 27 Feb 2017 17:41:50 +0400
Message-Id: <20170227134202.2991-10-marcandre.lureau@redhat.com>
In-Reply-To: <20170227134202.2991-1-marcandre.lureau@redhat.com>
References: <20170227134202.2991-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 09/21] char: remove chardevs list
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
index b3622be3f4..558fd8b31c 100644
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
2.12.0.rc2.3.gc93709801
