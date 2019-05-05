Received: from eggs.gnu.org ([209.51.188.92]:39196)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hNNPK-0002F0-I7
	for qemu-devel@nongnu.org; Sun, 05 May 2019 16:06:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hNNPJ-000497-Lh
	for qemu-devel@nongnu.org; Sun, 05 May 2019 16:06:46 -0400
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Date: Sun,  5 May 2019 22:05:59 +0200
Message-Id: <20190505200602.12412-3-philmd@redhat.com>
In-Reply-To: <20190505200602.12412-1-philmd@redhat.com>
References: <20190505200602.12412-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 2/5] hw/block/pflash_cfi01: Extract the
 pflash_reset() code
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-stable@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Stephen Checkoway <stephen.checkoway@oberlin.edu>, Kevin Wolf <kwolf@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Laszlo Ersek <lersek@redhat.com>, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Max Reitz <mreitz@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>, qemu-block@nongnu.org, Wei Yang <richardw.yang@linux.intel.com>, Gerd Hoffmann <kraxel@redhat.com>, Markus Armbruster <armbru@redhat.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>

The reset() code is used in various places, refactor it.

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 hw/block/pflash_cfi01.c | 21 ++++++++++++---------
 1 file changed, 12 insertions(+), 9 deletions(-)

diff --git a/hw/block/pflash_cfi01.c b/hw/block/pflash_cfi01.c
index 6dc04f156a7..073cd14978f 100644
--- a/hw/block/pflash_cfi01.c
+++ b/hw/block/pflash_cfi01.c
@@ -108,6 +108,15 @@ static const VMStateDescription vmstate_pflash =3D {
     }
 };
=20
+static void pflash_reset(PFlashCFI01 *pfl)
+{
+    trace_pflash_reset();
+    pfl->wcycle =3D 0;
+    pfl->cmd =3D 0;
+    pfl->status =3D 0;
+    memory_region_rom_device_set_romd(&pfl->mem, true);
+}
+
 /* Perform a CFI query based on the bank width of the flash.
  * If this code is called we know we have a device_width set for
  * this flash.
@@ -275,8 +284,7 @@ static uint32_t pflash_read(PFlashCFI01 *pfl, hwaddr =
offset,
     default:
         /* This should never happen : reset state & treat it as a read *=
/
         DPRINTF("%s: unknown command state: %x\n", __func__, pfl->cmd);
-        pfl->wcycle =3D 0;
-        pfl->cmd =3D 0;
+        pflash_reset(pfl);
         /* fall through to read code */
     case 0x00:
         /* Flash area read */
@@ -639,10 +647,7 @@ static void pflash_write(PFlashCFI01 *pfl, hwaddr of=
fset,
                   "\n", __func__, offset, pfl->wcycle, pfl->cmd, value);
=20
  reset_flash:
-    trace_pflash_reset();
-    memory_region_rom_device_set_romd(&pfl->mem, true);
-    pfl->wcycle =3D 0;
-    pfl->cmd =3D 0;
+    pflash_reset(pfl);
 }
=20
=20
@@ -757,9 +762,7 @@ static void pflash_cfi01_realize(DeviceState *dev, Er=
ror **errp)
         pfl->max_device_width =3D pfl->device_width;
     }
=20
-    pfl->wcycle =3D 0;
-    pfl->cmd =3D 0;
-    pfl->status =3D 0;
+    pflash_reset(pfl);
     /* Hardcoded CFI table */
     /* Standard "QRY" string */
     pfl->cfi_table[0x10] =3D 'Q';
--=20
2.20.1
