Received: from eggs.gnu.org ([2001:4830:134:3::10]:33624)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gAlFG-0006X5-Ld
	for qemu-devel@nongnu.org; Thu, 11 Oct 2018 20:23:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gAlFF-0006iB-PQ
	for qemu-devel@nongnu.org; Thu, 11 Oct 2018 20:23:58 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33726)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gAlFF-0006hs-HV
	for qemu-devel@nongnu.org; Thu, 11 Oct 2018 20:23:57 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id E057D30BF447
	for <qemu-devel@nongnu.org>; Fri, 12 Oct 2018 00:23:56 +0000 (UTC)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Date: Fri, 12 Oct 2018 02:22:15 +0200
Message-Id: <20181012002217.2864-10-philmd@redhat.com>
In-Reply-To: <20181012002217.2864-1-philmd@redhat.com>
References: <20181012002217.2864-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 09/11] chardev: Let qemu_chr_fe_* use
 unsigned type
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, Prasad J Pandit <ppandit@redhat.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>, qemu-devel@nongnu.org, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 chardev/char-fe.c         | 8 ++++----
 chardev/char-win-stdio.c  | 2 +-
 chardev/char-win.c        | 2 +-
 include/chardev/char-fe.h | 6 +++---
 4 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/chardev/char-fe.c b/chardev/char-fe.c
index a8931f7afd..b732f6566b 100644
--- a/chardev/char-fe.c
+++ b/chardev/char-fe.c
@@ -31,7 +31,7 @@
 #include "chardev/char-io.h"
 #include "chardev/char-mux.h"
=20
-int qemu_chr_fe_write(CharBackend *be, const uint8_t *buf, int len)
+size_t qemu_chr_fe_write(CharBackend *be, const uint8_t *buf, size_t len=
)
 {
     Chardev *s =3D be->chr;
=20
@@ -42,7 +42,7 @@ int qemu_chr_fe_write(CharBackend *be, const uint8_t *b=
uf, int len)
     return qemu_chr_write(s, buf, len, false);
 }
=20
-int qemu_chr_fe_write_all(CharBackend *be, const uint8_t *buf, int len)
+size_t qemu_chr_fe_write_all(CharBackend *be, const uint8_t *buf, size_t=
 len)
 {
     Chardev *s =3D be->chr;
=20
@@ -53,10 +53,10 @@ int qemu_chr_fe_write_all(CharBackend *be, const uint=
8_t *buf, int len)
     return qemu_chr_write(s, buf, len, true);
 }
=20
-int qemu_chr_fe_read_all(CharBackend *be, uint8_t *buf, int len)
+size_t qemu_chr_fe_read_all(CharBackend *be, uint8_t *buf, size_t len)
 {
     Chardev *s =3D be->chr;
-    int offset =3D 0;
+    size_t offset =3D 0;
     int res;
=20
     if (!s || !CHARDEV_GET_CLASS(s)->chr_sync_read) {
diff --git a/chardev/char-win-stdio.c b/chardev/char-win-stdio.c
index efcf7827eb..6b1a97144b 100644
--- a/chardev/char-win-stdio.c
+++ b/chardev/char-win-stdio.c
@@ -221,7 +221,7 @@ static void char_win_stdio_finalize(Object *obj)
     }
 }
=20
-static int win_stdio_write(Chardev *chr, const uint8_t *buf, int len)
+static size_t win_stdio_write(Chardev *chr, const uint8_t *buf, size_t l=
en)
 {
     HANDLE  hStdOut =3D GetStdHandle(STD_OUTPUT_HANDLE);
     DWORD   dwSize;
diff --git a/chardev/char-win.c b/chardev/char-win.c
index 05518e0958..7ea7d0a371 100644
--- a/chardev/char-win.c
+++ b/chardev/char-win.c
@@ -152,7 +152,7 @@ int win_chr_pipe_poll(void *opaque)
 }
=20
 /* Called with chr_write_lock held.  */
-static int win_chr_write(Chardev *chr, const uint8_t *buf, int len1)
+static size_t win_chr_write(Chardev *chr, const uint8_t *buf, size_t len=
1)
 {
     WinChardev *s =3D WIN_CHARDEV(chr);
     DWORD len, ret, size, err;
diff --git a/include/chardev/char-fe.h b/include/chardev/char-fe.h
index 46c997d352..2f95c890d8 100644
--- a/include/chardev/char-fe.h
+++ b/include/chardev/char-fe.h
@@ -184,7 +184,7 @@ guint qemu_chr_fe_add_watch(CharBackend *be, GIOCondi=
tion cond,
  *
  * Returns: the number of bytes consumed (0 if no associated Chardev)
  */
-int qemu_chr_fe_write(CharBackend *be, const uint8_t *buf, int len);
+size_t qemu_chr_fe_write(CharBackend *be, const uint8_t *buf, size_t len=
);
=20
 /**
  * qemu_chr_fe_write_all:
@@ -198,7 +198,7 @@ int qemu_chr_fe_write(CharBackend *be, const uint8_t =
*buf, int len);
  *
  * Returns: the number of bytes consumed (0 if no associated Chardev)
  */
-int qemu_chr_fe_write_all(CharBackend *be, const uint8_t *buf, int len);
+size_t qemu_chr_fe_write_all(CharBackend *be, const uint8_t *buf, size_t=
 len);
=20
 /**
  * qemu_chr_fe_read_all:
@@ -209,7 +209,7 @@ int qemu_chr_fe_write_all(CharBackend *be, const uint=
8_t *buf, int len);
  *
  * Returns: the number of bytes read (0 if no associated Chardev)
  */
-int qemu_chr_fe_read_all(CharBackend *be, uint8_t *buf, int len);
+size_t qemu_chr_fe_read_all(CharBackend *be, uint8_t *buf, size_t len);
=20
 /**
  * qemu_chr_fe_ioctl:
--=20
2.17.1
