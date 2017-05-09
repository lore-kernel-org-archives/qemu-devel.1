Received: from eggs.gnu.org ([2001:4830:134:3::10]:59514)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1d83Ou-0004gi-BM
	for qemu-devel@nongnu.org; Tue, 09 May 2017 07:33:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1d83Oq-0002IO-BX
	for qemu-devel@nongnu.org; Tue, 09 May 2017 07:33:56 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44730)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1d83Oq-0002I7-2v
	for qemu-devel@nongnu.org; Tue, 09 May 2017 07:33:52 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 0ECF937E67
	for <qemu-devel@nongnu.org>; Tue,  9 May 2017 11:33:51 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Tue,  9 May 2017 15:33:20 +0400
Message-Id: <20170509113332.4987-2-marcandre.lureau@redhat.com>
In-Reply-To: <20170509113332.4987-1-marcandre.lureau@redhat.com>
References: <20170509113332.4987-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 01/13] char-win: simplify win_chr_read()
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

win_chr_read_poll() is always used before win_chr_read().
We can easily fold win_chr_readfile() too.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 chardev/char-win.h |  2 +-
 chardev/char-win.c | 35 +++++++++--------------------------
 2 files changed, 10 insertions(+), 27 deletions(-)

diff --git a/chardev/char-win.h b/chardev/char-win.h
index d78a7d7972..73a0e3caef 100644
--- a/chardev/char-win.h
+++ b/chardev/char-win.h
@@ -28,7 +28,7 @@
=20
 typedef struct {
     Chardev parent;
-    int max_size;
+
     HANDLE hcom, hrecv, hsend;
     OVERLAPPED orecv;
     BOOL fpipe;
diff --git a/chardev/char-win.c b/chardev/char-win.c
index e4b6957ded..a46d878ef8 100644
--- a/chardev/char-win.c
+++ b/chardev/char-win.c
@@ -26,14 +26,21 @@
 #include "qapi/error.h"
 #include "char-win.h"
=20
-static void win_chr_readfile(Chardev *chr)
+static void win_chr_read(Chardev *chr)
 {
     WinChardev *s =3D WIN_CHARDEV(chr);
-
+    int max_size =3D qemu_chr_be_can_write(chr);
     int ret, err;
     uint8_t buf[CHR_READ_BUF_LEN];
     DWORD size;
=20
+    if (s->len > max_size) {
+        s->len =3D max_size;
+    }
+    if (s->len =3D=3D 0) {
+        return;
+    }
+
     ZeroMemory(&s->orecv, sizeof(s->orecv));
     s->orecv.hEvent =3D s->hrecv;
     ret =3D ReadFile(s->hcom, buf, s->len, &size, &s->orecv);
@@ -49,28 +56,6 @@ static void win_chr_readfile(Chardev *chr)
     }
 }
=20
-static void win_chr_read(Chardev *chr)
-{
-    WinChardev *s =3D WIN_CHARDEV(chr);
-
-    if (s->len > s->max_size) {
-        s->len =3D s->max_size;
-    }
-    if (s->len =3D=3D 0) {
-        return;
-    }
-
-    win_chr_readfile(chr);
-}
-
-static int win_chr_read_poll(Chardev *chr)
-{
-    WinChardev *s =3D WIN_CHARDEV(chr);
-
-    s->max_size =3D qemu_chr_be_can_write(chr);
-    return s->max_size;
-}
-
 static int win_chr_poll(void *opaque)
 {
     Chardev *chr =3D CHARDEV(opaque);
@@ -81,7 +66,6 @@ static int win_chr_poll(void *opaque)
     ClearCommError(s->hcom, &comerr, &status);
     if (status.cbInQue > 0) {
         s->len =3D status.cbInQue;
-        win_chr_read_poll(chr);
         win_chr_read(chr);
         return 1;
     }
@@ -163,7 +147,6 @@ int win_chr_pipe_poll(void *opaque)
     PeekNamedPipe(s->hcom, NULL, 0, NULL, &size, NULL);
     if (size > 0) {
         s->len =3D size;
-        win_chr_read_poll(chr);
         win_chr_read(chr);
         return 1;
     }
--=20
2.13.0.rc1.16.gd80b50c3f
