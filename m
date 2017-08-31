Received: from eggs.gnu.org ([2001:4830:134:3::10]:41090)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1dnMor-00024E-7q
	for qemu-devel@nongnu.org; Thu, 31 Aug 2017 06:35:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1dnMoo-0005cp-Dx
	for qemu-devel@nongnu.org; Thu, 31 Aug 2017 06:35:29 -0400
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Thu, 31 Aug 2017 12:34:13 +0200
Message-Id: <20170831103432.6007-11-marcandre.lureau@redhat.com>
In-Reply-To: <20170831103432.6007-1-marcandre.lureau@redhat.com>
References: <20170831103432.6007-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 10/29] vvfat: use DIV_ROUND_UP
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
Reviewed-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Richard Henderson <rth@twiddle.net>
---
 block/vvfat.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/block/vvfat.c b/block/vvfat.c
index a9e207f7f0..c54fa94651 100644
--- a/block/vvfat.c
+++ b/block/vvfat.c
@@ -449,7 +449,7 @@ static direntry_t *create_long_filename(BDRVVVFATStat=
e *s, const char *filename)
         return NULL;
     }
=20
-    number_of_entries =3D (length * 2 + 25) / 26;
+    number_of_entries =3D DIV_ROUND_UP(length * 2, 26);
=20
     for(i=3D0;i<number_of_entries;i++) {
         entry=3Darray_get_next(&(s->directory));
@@ -2554,7 +2554,7 @@ static int commit_one_file(BDRVVVFATState* s,
                 (size > offset && c >=3D2 && !fat_eof(s, c)));
=20
         ret =3D vvfat_read(s->bs, cluster2sector(s, c),
-            (uint8_t*)cluster, (rest_size + 0x1ff) / 0x200);
+            (uint8_t*)cluster, DIV_ROUND_UP(rest_size, 0x200));
=20
         if (ret < 0) {
             qemu_close(fd);
--=20
2.14.1.146.gd35faa819
