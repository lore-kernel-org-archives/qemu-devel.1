Received: from eggs.gnu.org ([2001:4830:134:3::10]:45616)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1cYbCD-0008U1-9b
	for qemu-devel@nongnu.org; Tue, 31 Jan 2017 11:22:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1cYbCC-0000sB-Ki
	for qemu-devel@nongnu.org; Tue, 31 Jan 2017 11:22:17 -0500
Received: from mx1.redhat.com ([209.132.183.28]:38576)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1cYbCC-0000s3-EH
	for qemu-devel@nongnu.org; Tue, 31 Jan 2017 11:22:16 -0500
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Tue, 31 Jan 2017 20:20:53 +0400
Message-Id: <20170131162122.29408-13-marcandre.lureau@redhat.com>
In-Reply-To: <20170131162122.29408-1-marcandre.lureau@redhat.com>
References: <20170131162122.29408-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 12/41] char-win-stdio: convert to finalize
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

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
---
 qemu-char.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/qemu-char.c b/qemu-char.c
index 390e6a99de..d92642735e 100644
--- a/qemu-char.c
+++ b/qemu-char.c
@@ -2594,9 +2594,9 @@ static void qemu_chr_set_echo_win_stdio(Chardev *ch=
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
@@ -2613,6 +2613,7 @@ static const TypeInfo char_win_stdio_type_info =3D =
{
     .name =3D TYPE_CHARDEV_WIN_STDIO,
     .parent =3D TYPE_CHARDEV,
     .instance_size =3D sizeof(WinStdioChardev),
+    .instance_finalize =3D char_win_stdio_finalize,
     .abstract =3D true,
 };
=20
@@ -3856,7 +3857,6 @@ static void char_stdio_class_init(ObjectClass *oc, =
void *data)
 #ifdef _WIN32
     cc->chr_write =3D win_stdio_write;
     cc->chr_set_echo =3D qemu_chr_set_echo_win_stdio;
-    cc->chr_free =3D win_stdio_free;
 #else
     cc->chr_set_echo =3D qemu_chr_set_echo_stdio;
 #endif
--=20
2.11.0.295.gd7dffce1c.dirty
