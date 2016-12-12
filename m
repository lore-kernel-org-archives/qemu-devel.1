Received: from eggs.gnu.org ([2001:4830:134:3::10]:43309)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1cGZLP-0004TN-PG
	for qemu-devel@nongnu.org; Mon, 12 Dec 2016 17:45:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1cGZLO-0003yu-Pv
	for qemu-devel@nongnu.org; Mon, 12 Dec 2016 17:45:15 -0500
Received: from mx1.redhat.com ([209.132.183.28]:38026)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1cGZLO-0003yb-Je
	for qemu-devel@nongnu.org; Mon, 12 Dec 2016 17:45:14 -0500
Received: from int-mx09.intmail.prod.int.phx2.redhat.com
	(int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id A00D676A10
	for <qemu-devel@nongnu.org>; Mon, 12 Dec 2016 22:45:13 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Tue, 13 Dec 2016 01:42:57 +0300
Message-Id: <20161212224325.20790-27-marcandre.lureau@redhat.com>
In-Reply-To: <20161212224325.20790-1-marcandre.lureau@redhat.com>
References: <20161212224325.20790-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 26/54] char-win-stdio: convert to finalize
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

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 qemu-char.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/qemu-char.c b/qemu-char.c
index 8a5953954c..3dfb249d81 100644
--- a/qemu-char.c
+++ b/qemu-char.c
@@ -2589,9 +2589,9 @@ static void qemu_chr_set_echo_win_stdio(Chardev *ch=
r, bool echo)
     }
 }
=20
-static void win_stdio_free(Chardev *chr)
+static void char_win_stdio_finalize(Object *obj)
 {
-    WinStdioChardev *stdio =3D WIN_STDIO_CHARDEV(chr);
+    WinStdioChardev *stdio =3D WIN_STDIO_CHARDEV(obj);
=20
     if (stdio->hInputReadyEvent !=3D INVALID_HANDLE_VALUE) {
         CloseHandle(stdio->hInputReadyEvent);
@@ -2608,6 +2608,7 @@ static const TypeInfo char_win_stdio_type_info =3D =
{
     .name =3D TYPE_CHARDEV_WIN_STDIO,
     .parent =3D TYPE_CHARDEV,
     .instance_size =3D sizeof(WinStdioChardev),
+    .instance_finalize =3D char_win_stdio_finalize,
     .abstract =3D true,
 };
=20
@@ -3849,7 +3850,6 @@ static void char_stdio_class_init(ObjectClass *oc, =
void *data)
 #ifdef _WIN32
     cc->chr_write =3D win_stdio_write;
     cc->chr_set_echo =3D qemu_chr_set_echo_win_stdio;
-    cc->chr_free =3D win_stdio_free;
 #else
     cc->chr_set_echo =3D qemu_chr_set_echo_stdio;
 #endif
--=20
2.11.0
