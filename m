Received: from eggs.gnu.org ([2001:4830:134:3::10]:38668)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1eX85K-00015i-2c
	for qemu-devel@nongnu.org; Thu, 04 Jan 2018 11:09:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1eX85I-0005xG-Pe
	for qemu-devel@nongnu.org; Thu, 04 Jan 2018 11:09:38 -0500
Received: from mx1.redhat.com ([209.132.183.28]:45633)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1eX85I-0005wg-J2
	for qemu-devel@nongnu.org; Thu, 04 Jan 2018 11:09:36 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id D1A855B2F9
	for <qemu-devel@nongnu.org>; Thu,  4 Jan 2018 16:09:35 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Thu,  4 Jan 2018 17:05:22 +0100
Message-Id: <20180104160523.22995-18-marcandre.lureau@redhat.com>
In-Reply-To: <20180104160523.22995-1-marcandre.lureau@redhat.com>
References: <20180104160523.22995-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v3 17/18] mips: fix potential fopen(NULL,...)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, famz@redhat.com, eblake@redhat.com, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

Spotted thanks to ASAN.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 hw/nvram/ds1225y.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/nvram/ds1225y.c b/hw/nvram/ds1225y.c
index 57d5ab2154..ad7345f288 100644
--- a/hw/nvram/ds1225y.c
+++ b/hw/nvram/ds1225y.c
@@ -80,7 +80,7 @@ static int nvram_post_load(void *opaque, int version_id=
)
     }
=20
     /* Write back nvram contents */
-    s->file =3D fopen(s->filename, "wb");
+    s->file =3D s->filename ? fopen(s->filename, "wb") : NULL;
     if (s->file) {
         /* Write back contents, as 'wb' mode cleaned the file */
         if (fwrite(s->contents, s->chip_size, 1, s->file) !=3D 1) {
@@ -126,7 +126,7 @@ static int nvram_sysbus_initfn(SysBusDevice *dev)
     sysbus_init_mmio(dev, &s->iomem);
=20
     /* Read current file */
-    file =3D fopen(s->filename, "rb");
+    file =3D s->filename ? fopen(s->filename, "rb") : NULL;
     if (file) {
         /* Read nvram contents */
         if (fread(s->contents, s->chip_size, 1, file) !=3D 1) {
--=20
2.15.1.355.g36791d7216
