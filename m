Received: from eggs.gnu.org ([2001:4830:134:3::10]:42629)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1dVh3Z-0003QN-7L
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 12:33:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1dVh3Y-0004cu-93
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 12:33:37 -0400
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Thu, 13 Jul 2017 18:31:59 +0200
Message-Id: <20170713163219.9024-10-marcandre.lureau@redhat.com>
In-Reply-To: <20170713163219.9024-1-marcandre.lureau@redhat.com>
References: <20170713163219.9024-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 09/29] vpc: use DIV_ROUND_UP
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org, peter.maydell@linaro.org, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, "open list:vpc" <qemu-block@nongnu.org>

I used the clang-tidy qemu-round check to generate the fix:
https://github.com/elmarco/clang-tools-extra

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 block/vpc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/block/vpc.c b/block/vpc.c
index 9a6f8173a5..c88dc72491 100644
--- a/block/vpc.c
+++ b/block/vpc.c
@@ -760,7 +760,7 @@ static int calculate_geometry(int64_t total_sectors, =
uint16_t* cyls,
     } else {
         *secs_per_cyl =3D 17;
         cyls_times_heads =3D total_sectors / *secs_per_cyl;
-        *heads =3D (cyls_times_heads + 1023) / 1024;
+        *heads =3D DIV_ROUND_UP(cyls_times_heads, 1024);
=20
         if (*heads < 4) {
             *heads =3D 4;
@@ -813,7 +813,7 @@ static int create_dynamic_disk(BlockBackend *blk, uin=
t8_t *buf,
     offset =3D 3 * 512;
=20
     memset(buf, 0xFF, 512);
-    for (i =3D 0; i < (num_bat_entries * 4 + 511) / 512; i++) {
+    for (i =3D 0; i < DIV_ROUND_UP(num_bat_entries * 4, 512); i++) {
         ret =3D blk_pwrite(blk, offset, buf, 512, 0);
         if (ret < 0) {
             goto fail;
--=20
2.13.1.395.gf7b71de06
