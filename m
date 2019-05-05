Received: from eggs.gnu.org ([209.51.188.92]:36203)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hNPRA-0004XY-Hz
	for qemu-devel@nongnu.org; Sun, 05 May 2019 18:16:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hNPR9-0000Gv-Jx
	for qemu-devel@nongnu.org; Sun, 05 May 2019 18:16:48 -0400
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Date: Mon,  6 May 2019 00:15:41 +0200
Message-Id: <20190505221544.31568-11-philmd@redhat.com>
In-Reply-To: <20190505221544.31568-1-philmd@redhat.com>
References: <20190505221544.31568-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 10/13] hw/block/pflash_cfi02: Extract the
 pflash_data_read() function
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

Extract the code block in a new function, remove a goto statement.

Signed-off-by: Stephen Checkoway <stephen.checkoway@oberlin.edu>
Message-Id: <20190426162624.55977-3-stephen.checkoway@oberlin.edu>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Tested-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
[PMD: Extracted from bigger patch, remove the XXX tracing comment]
Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 hw/block/pflash_cfi02.c | 44 ++++++++++++++++++++++-------------------
 1 file changed, 24 insertions(+), 20 deletions(-)

diff --git a/hw/block/pflash_cfi02.c b/hw/block/pflash_cfi02.c
index 2777167af11..adfa39f9b5e 100644
--- a/hw/block/pflash_cfi02.c
+++ b/hw/block/pflash_cfi02.c
@@ -164,12 +164,33 @@ static void pflash_timer (void *opaque)
     pfl->cmd =3D 0;
 }
=20
+/*
+ * Read data from flash.
+ */
+static uint64_t pflash_data_read(PFlashCFI02 *pfl, hwaddr offset,
+                                 unsigned int width)
+{
+    uint8_t *p =3D (uint8_t *)pfl->storage + offset;
+    uint64_t ret =3D pfl->be ? ldn_be_p(p, width) : ldn_le_p(p, width);
+    switch (width) {
+    case 1:
+        trace_pflash_data_read8(offset, ret);
+        break;
+    case 2:
+        trace_pflash_data_read16(offset, ret);
+        break;
+    case 4:
+        trace_pflash_data_read32(offset, ret);
+        break;
+    }
+    return ret;
+}
+
 static uint32_t pflash_read(PFlashCFI02 *pfl, hwaddr offset,
                             int width, int be)
 {
     hwaddr boff;
     uint32_t ret;
-    uint8_t *p;
=20
     ret =3D -1;
     trace_pflash_read(offset, pfl->cmd, width, pfl->wcycle);
@@ -194,25 +215,8 @@ static uint32_t pflash_read(PFlashCFI02 *pfl, hwaddr=
 offset,
     case 0x80:
         /* We accept reads during second unlock sequence... */
     case 0x00:
-    flash_read:
         /* Flash area read */
-        p =3D (uint8_t *)pfl->storage + offset;
-        if (pfl->be) {
-            ret =3D ldn_be_p(p, width);
-        } else {
-            ret =3D ldn_le_p(p, width);
-        }
-        switch (width) {
-        case 1:
-            trace_pflash_data_read8(offset, ret);
-            break;
-        case 2:
-            trace_pflash_data_read16(offset, ret);
-            break;
-        case 4:
-            trace_pflash_data_read32(offset, ret);
-            break;
-        }
+        ret =3D pflash_data_read(pfl, offset, width);
         break;
     case 0x90:
         /* flash ID read */
@@ -232,7 +236,7 @@ static uint32_t pflash_read(PFlashCFI02 *pfl, hwaddr =
offset,
             }
             /* Fall through to data read. */
         default:
-            goto flash_read;
+            ret =3D pflash_data_read(pfl, offset, width);
         }
         DPRINTF("%s: ID " TARGET_FMT_plx " %" PRIx32 "\n", __func__, bof=
f, ret);
         break;
--=20
2.20.1
