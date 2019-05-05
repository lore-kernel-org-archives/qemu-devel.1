Received: from eggs.gnu.org ([209.51.188.92]:36085)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hNPR4-0004Rr-Nk
	for qemu-devel@nongnu.org; Sun, 05 May 2019 18:16:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hNPR0-0008UU-VC
	for qemu-devel@nongnu.org; Sun, 05 May 2019 18:16:40 -0400
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Date: Mon,  6 May 2019 00:15:36 +0200
Message-Id: <20190505221544.31568-6-philmd@redhat.com>
In-Reply-To: <20190505221544.31568-1-philmd@redhat.com>
References: <20190505221544.31568-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 05/13] hw/block/pflash_cfi02: Add an enum to
 define the write cycles
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

No change in functionality is intended with this commit.

Signed-off-by: Stephen Checkoway <stephen.checkoway@oberlin.edu>
Message-Id: <20190426162624.55977-3-stephen.checkoway@oberlin.edu>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Tested-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
[PMD: Extracted from bigger patch]
Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 hw/block/pflash_cfi02.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/hw/block/pflash_cfi02.c b/hw/block/pflash_cfi02.c
index f88e09cebaa..b27796d74d2 100644
--- a/hw/block/pflash_cfi02.c
+++ b/hw/block/pflash_cfi02.c
@@ -56,6 +56,11 @@ do {                                                  =
     \
=20
 #define PFLASH_LAZY_ROMD_THRESHOLD 42
=20
+/* Special write cycles for CFI queries. */
+enum {
+    WCYCLE_CFI          =3D 7,
+};
+
 struct PFlashCFI02 {
     /*< private >*/
     SysBusDevice parent_obj;
@@ -293,7 +298,7 @@ static void pflash_write(PFlashCFI02 *pfl, hwaddr off=
set,
         if (boff =3D=3D 0x55 && cmd =3D=3D 0x98) {
         enter_CFI_mode:
             /* Enter CFI query mode */
-            pfl->wcycle =3D 7;
+            pfl->wcycle =3D WCYCLE_CFI;
             pfl->cmd =3D 0x98;
             return;
         }
@@ -465,7 +470,7 @@ static void pflash_write(PFlashCFI02 *pfl, hwaddr off=
set,
             goto reset_flash;
         }
         break;
-    case 7: /* Special value for CFI queries */
+    case WCYCLE_CFI: /* Special value for CFI queries */
         DPRINTF("%s: invalid write in CFI query mode\n", __func__);
         goto reset_flash;
     default:
--=20
2.20.1
