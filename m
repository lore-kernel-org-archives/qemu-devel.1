Received: from eggs.gnu.org ([2001:4830:134:3::10]:43368)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1cGZLV-0004Z5-J8
	for qemu-devel@nongnu.org; Mon, 12 Dec 2016 17:45:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1cGZLS-00040J-40
	for qemu-devel@nongnu.org; Mon, 12 Dec 2016 17:45:21 -0500
Received: from mx1.redhat.com ([209.132.183.28]:48058)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1cGZLR-0003zh-V6
	for qemu-devel@nongnu.org; Mon, 12 Dec 2016 17:45:18 -0500
Received: from int-mx13.intmail.prod.int.phx2.redhat.com
	(int-mx13.intmail.prod.int.phx2.redhat.com [10.5.11.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 1F3D43B706
	for <qemu-devel@nongnu.org>; Mon, 12 Dec 2016 22:45:17 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Tue, 13 Dec 2016 01:42:58 +0300
Message-Id: <20161212224325.20790-28-marcandre.lureau@redhat.com>
In-Reply-To: <20161212224325.20790-1-marcandre.lureau@redhat.com>
References: <20161212224325.20790-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 27/54] char-win: do not override chr_free
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

For some unclear reason to me, char-file does not have chr_free on
win32. Since we want to switch to instance finalizer instead of class
chr_free, we should be able to run the base WinChardev class finalizer
in any case. Use a boolean to skip free to ease the transition to
instance finalizer.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 qemu-char.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/qemu-char.c b/qemu-char.c
index 3dfb249d81..63b254f632 100644
--- a/qemu-char.c
+++ b/qemu-char.c
@@ -2117,6 +2117,8 @@ typedef struct {
=20
     /* Protected by the Chardev chr_write_lock.  */
     OVERLAPPED osend;
+    /* FIXME: file/console do not finalize */
+    BOOL skip_free;
 } WinChardev;
=20
 #define TYPE_CHARDEV_WIN "chardev-win"
@@ -2147,6 +2149,10 @@ static void win_chr_free(Chardev *chr)
 {
     WinChardev *s =3D WIN_CHARDEV(chr);
=20
+    if (s->skip_free) {
+        return;
+    }
+
     if (s->hsend) {
         CloseHandle(s->hsend);
         s->hsend =3D NULL;
@@ -2427,6 +2433,7 @@ static void qemu_chr_open_win_file(Chardev *chr, HA=
NDLE fd_out)
 {
     WinChardev *s =3D WIN_CHARDEV(chr);
=20
+    s->skip_free =3D true;
     s->hcom =3D fd_out;
 }
=20
@@ -2463,7 +2470,6 @@ static void char_console_class_init(ObjectClass *oc=
, void *data)
     ChardevClass *cc =3D CHARDEV_CLASS(oc);
=20
     cc->open =3D qemu_chr_open_win_con;
-    cc->chr_free =3D NULL;
 }
=20
 static const TypeInfo char_console_type_info =3D {
@@ -4728,10 +4734,6 @@ static void char_file_class_init(ObjectClass *oc, =
void *data)
     ChardevClass *cc =3D CHARDEV_CLASS(oc);
=20
     cc->open =3D qmp_chardev_open_file;
-#ifdef _WIN32
-    /* FIXME: no chr_free */
-    cc->chr_free =3D NULL;
-#endif
 }
=20
 static const TypeInfo char_file_type_info =3D {
--=20
2.11.0
