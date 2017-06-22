Received: from eggs.gnu.org ([2001:4830:134:3::10]:45302)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1dO1S0-0006eu-8S
	for qemu-devel@nongnu.org; Thu, 22 Jun 2017 08:43:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1dO1Rz-0006Hm-Hu
	for qemu-devel@nongnu.org; Thu, 22 Jun 2017 08:43:08 -0400
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Thu, 22 Jun 2017 14:41:43 +0200
Message-Id: <20170622124204.19407-11-marcandre.lureau@redhat.com>
In-Reply-To: <20170622124204.19407-1-marcandre.lureau@redhat.com>
References: <20170622124204.19407-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 10/31] vvfat: use DIV_ROUND_UP
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, "open list:vvfat" <qemu-block@nongnu.org>

I used the clang-tidy qemu-round check to generate the fix:
https://github.com/elmarco/clang-tools-extra

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 block/vvfat.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/block/vvfat.c b/block/vvfat.c
index 426ca70e35..877f71dcdc 100644
--- a/block/vvfat.c
+++ b/block/vvfat.c
@@ -433,7 +433,7 @@ static inline direntry_t* create_long_filename(BDRVVV=
FATState* s,const char* fil
 {
     char buffer[258];
     int length=3Dshort2long_name(buffer,filename),
-        number_of_entries=3D(length+25)/26,i;
+        number_of_entries=3DDIV_ROUND_UP(length, 26),i;
     direntry_t* entry;
=20
     for(i=3D0;i<number_of_entries;i++) {
@@ -2424,7 +2424,7 @@ static int commit_one_file(BDRVVVFATState* s,
 		(size > offset && c >=3D2 && !fat_eof(s, c)));
=20
 	ret =3D vvfat_read(s->bs, cluster2sector(s, c),
-	    (uint8_t*)cluster, (rest_size + 0x1ff) / 0x200);
+	    (uint8_t*)cluster, DIV_ROUND_UP(rest_size, 0x200));
=20
         if (ret < 0) {
             qemu_close(fd);
--=20
2.13.1.395.gf7b71de06
