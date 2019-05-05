Received: from eggs.gnu.org ([209.51.188.92]:36167)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hNPR8-0004UM-P0
	for qemu-devel@nongnu.org; Sun, 05 May 2019 18:16:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hNPR7-0000Dr-RL
	for qemu-devel@nongnu.org; Sun, 05 May 2019 18:16:46 -0400
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Date: Mon,  6 May 2019 00:15:40 +0200
Message-Id: <20190505221544.31568-10-philmd@redhat.com>
In-Reply-To: <20190505221544.31568-1-philmd@redhat.com>
References: <20190505221544.31568-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 09/13] hw/block/pflash_cfi02: Use the ldst API
 in pflash_read()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, Stephen Checkoway <stephen.checkoway@oberlin.edu>
Cc: Markus Armbruster <armbru@redhat.com>, Max Reitz <mreitz@redhat.com>, Thomas Huth <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, qemu-block@nongnu.org, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>

The load/store API eases code review.

Signed-off-by: Stephen Checkoway <stephen.checkoway@oberlin.edu>
Message-Id: <20190426162624.55977-3-stephen.checkoway@oberlin.edu>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Tested-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
[PMD: Extracted from bigger patch]
Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 hw/block/pflash_cfi02.c | 26 ++++++--------------------
 1 file changed, 6 insertions(+), 20 deletions(-)

diff --git a/hw/block/pflash_cfi02.c b/hw/block/pflash_cfi02.c
index 69e0086324e..2777167af11 100644
--- a/hw/block/pflash_cfi02.c
+++ b/hw/block/pflash_cfi02.c
@@ -196,34 +196,20 @@ static uint32_t pflash_read(PFlashCFI02 *pfl, hwadd=
r offset,
     case 0x00:
     flash_read:
         /* Flash area read */
-        p =3D pfl->storage;
+        p =3D (uint8_t *)pfl->storage + offset;
+        if (pfl->be) {
+            ret =3D ldn_be_p(p, width);
+        } else {
+            ret =3D ldn_le_p(p, width);
+        }
         switch (width) {
         case 1:
-            ret =3D p[offset];
             trace_pflash_data_read8(offset, ret);
             break;
         case 2:
-            if (be) {
-                ret =3D p[offset] << 8;
-                ret |=3D p[offset + 1];
-            } else {
-                ret =3D p[offset];
-                ret |=3D p[offset + 1] << 8;
-            }
             trace_pflash_data_read16(offset, ret);
             break;
         case 4:
-            if (be) {
-                ret =3D p[offset] << 24;
-                ret |=3D p[offset + 1] << 16;
-                ret |=3D p[offset + 2] << 8;
-                ret |=3D p[offset + 3];
-            } else {
-                ret =3D p[offset];
-                ret |=3D p[offset + 1] << 8;
-                ret |=3D p[offset + 2] << 16;
-                ret |=3D p[offset + 3] << 24;
-            }
             trace_pflash_data_read32(offset, ret);
             break;
         }
--=20
2.20.1
