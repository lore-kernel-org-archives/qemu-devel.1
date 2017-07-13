Received: from eggs.gnu.org ([2001:4830:134:3::10]:42708)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1dVh3g-0003fk-GL
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 12:33:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1dVh3f-0004gO-Hq
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 12:33:44 -0400
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Thu, 13 Jul 2017 18:32:00 +0200
Message-Id: <20170713163219.9024-11-marcandre.lureau@redhat.com>
In-Reply-To: <20170713163219.9024-1-marcandre.lureau@redhat.com>
References: <20170713163219.9024-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 10/29] vvfat: use DIV_ROUND_UP
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org, peter.maydell@linaro.org, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, "open list:vvfat" <qemu-block@nongnu.org>

I used the clang-tidy qemu-round check to generate the fix:
https://github.com/elmarco/clang-tools-extra

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 block/vvfat.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/block/vvfat.c b/block/vvfat.c
index 4fd28e1e87..c08c4fb525 100644
--- a/block/vvfat.c
+++ b/block/vvfat.c
@@ -437,7 +437,7 @@ static direntry_t *create_long_filename(BDRVVVFATStat=
e *s, const char *filename)
         return NULL;
     }
=20
-    number_of_entries =3D (length * 2 + 25) / 26;
+    number_of_entries =3D DIV_ROUND_UP(length * 2, 26);
=20
     for(i=3D0;i<number_of_entries;i++) {
         entry=3Darray_get_next(&(s->directory));
@@ -2520,7 +2520,7 @@ static int commit_one_file(BDRVVVFATState* s,
                 (size > offset && c >=3D2 && !fat_eof(s, c)));
=20
         ret =3D vvfat_read(s->bs, cluster2sector(s, c),
-            (uint8_t*)cluster, (rest_size + 0x1ff) / 0x200);
+            (uint8_t*)cluster, DIV_ROUND_UP(rest_size, 0x200));
=20
         if (ret < 0) {
             qemu_close(fd);
--=20
2.13.1.395.gf7b71de06
