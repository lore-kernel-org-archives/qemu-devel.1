Received: from eggs.gnu.org ([209.51.188.92]:36032)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hNPR1-0004Nd-4X
	for qemu-devel@nongnu.org; Sun, 05 May 2019 18:16:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hNPQx-0008Or-38
	for qemu-devel@nongnu.org; Sun, 05 May 2019 18:16:37 -0400
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Date: Mon,  6 May 2019 00:15:35 +0200
Message-Id: <20190505221544.31568-5-philmd@redhat.com>
In-Reply-To: <20190505221544.31568-1-philmd@redhat.com>
References: <20190505221544.31568-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 04/13] hw/block/pflash_cfi02: Fix debug format
 string
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

Always compile the debug code to prevent format string to bitrot.

Signed-off-by: Stephen Checkoway <stephen.checkoway@oberlin.edu>
Message-Id: <20190426162624.55977-3-stephen.checkoway@oberlin.edu>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Tested-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
[PMD: Extracted from bigger patch, use PRIx32]
Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 hw/block/pflash_cfi02.c | 16 +++++++---------
 1 file changed, 7 insertions(+), 9 deletions(-)

diff --git a/hw/block/pflash_cfi02.c b/hw/block/pflash_cfi02.c
index f2c6201f813..f88e09cebaa 100644
--- a/hw/block/pflash_cfi02.c
+++ b/hw/block/pflash_cfi02.c
@@ -46,15 +46,13 @@
 #include "hw/sysbus.h"
 #include "trace.h"
=20
-//#define PFLASH_DEBUG
-#ifdef PFLASH_DEBUG
+#define PFLASH_DEBUG false
 #define DPRINTF(fmt, ...)                                  \
 do {                                                       \
-    fprintf(stderr, "PFLASH: " fmt , ## __VA_ARGS__);       \
+    if (PFLASH_DEBUG) {                                    \
+        fprintf(stderr, "PFLASH: " fmt, ## __VA_ARGS__);   \
+    }                                                      \
 } while (0)
-#else
-#define DPRINTF(fmt, ...) do { } while (0)
-#endif
=20
 #define PFLASH_LAZY_ROMD_THRESHOLD 42
=20
@@ -220,14 +218,14 @@ static uint32_t pflash_read(PFlashCFI02 *pfl, hwadd=
r offset,
         default:
             goto flash_read;
         }
-        DPRINTF("%s: ID " TARGET_FMT_plx " %x\n", __func__, boff, ret);
+        DPRINTF("%s: ID " TARGET_FMT_plx " %" PRIx32 "\n", __func__, bof=
f, ret);
         break;
     case 0xA0:
     case 0x10:
     case 0x30:
         /* Status register read */
         ret =3D pfl->status;
-        DPRINTF("%s: status %x\n", __func__, ret);
+        DPRINTF("%s: status %" PRIx32 "\n", __func__, ret);
         /* Toggle bit 6 */
         pfl->status ^=3D 0x40;
         break;
@@ -277,7 +275,7 @@ static void pflash_write(PFlashCFI02 *pfl, hwaddr off=
set,
     trace_pflash_write(offset, value, width, pfl->wcycle);
     offset &=3D pfl->chip_len - 1;
=20
-    DPRINTF("%s: offset " TARGET_FMT_plx " %08x %d\n", __func__,
+    DPRINTF("%s: offset " TARGET_FMT_plx " %08" PRIx32 " %d\n", __func__=
,
             offset, value, width);
     boff =3D offset & (pfl->sector_len - 1);
     if (pfl->width =3D=3D 2)
--=20
2.20.1
