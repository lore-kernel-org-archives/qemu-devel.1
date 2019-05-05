Received: from eggs.gnu.org ([209.51.188.92]:39339)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hNNPt-0002n8-MI
	for qemu-devel@nongnu.org; Sun, 05 May 2019 16:07:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hNNPq-00066p-Dl
	for qemu-devel@nongnu.org; Sun, 05 May 2019 16:07:20 -0400
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Date: Sun,  5 May 2019 22:06:01 +0200
Message-Id: <20190505200602.12412-5-philmd@redhat.com>
In-Reply-To: <20190505200602.12412-1-philmd@redhat.com>
References: <20190505200602.12412-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 4/5] hw/block/pflash_cfi02: Extract the
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
 hw/block/pflash_cfi02.c | 25 +++++++++++++++----------
 1 file changed, 15 insertions(+), 10 deletions(-)

diff --git a/hw/block/pflash_cfi02.c b/hw/block/pflash_cfi02.c
index f2c6201f813..f321b74433c 100644
--- a/hw/block/pflash_cfi02.c
+++ b/hw/block/pflash_cfi02.c
@@ -120,6 +120,17 @@ static void pflash_register_memory(PFlashCFI02 *pfl,=
 int rom_mode)
     pfl->rom_mode =3D rom_mode;
 }
=20
+static void pflash_reset(PFlashCFI02 *pfl)
+{
+    trace_pflash_reset();
+    timer_del(&pfl->timer);
+    pfl->bypass =3D 0;
+    pfl->wcycle =3D 0;
+    pfl->cmd =3D 0;
+    pfl->status =3D 0;
+    pflash_register_memory(pfl, 1);
+}
+
 static void pflash_timer (void *opaque)
 {
     PFlashCFI02 *pfl =3D opaque;
@@ -129,11 +140,10 @@ static void pflash_timer (void *opaque)
     pfl->status ^=3D 0x80;
     if (pfl->bypass) {
         pfl->wcycle =3D 2;
+        pfl->cmd =3D 0;
     } else {
-        pflash_register_memory(pfl, 1);
-        pfl->wcycle =3D 0;
+        pflash_reset(pfl);
     }
-    pfl->cmd =3D 0;
 }
=20
 static uint32_t pflash_read(PFlashCFI02 *pfl, hwaddr offset,
@@ -481,10 +491,7 @@ static void pflash_write(PFlashCFI02 *pfl, hwaddr of=
fset,
=20
     /* Reset flash */
  reset_flash:
-    trace_pflash_reset();
-    pfl->bypass =3D 0;
-    pfl->wcycle =3D 0;
-    pfl->cmd =3D 0;
+    pflash_reset(pfl);
     return;
=20
  do_bypass:
@@ -588,9 +595,7 @@ static void pflash_cfi02_realize(DeviceState *dev, Er=
ror **errp)
     sysbus_init_mmio(SYS_BUS_DEVICE(dev), &pfl->mem);
=20
     timer_init_ns(&pfl->timer, QEMU_CLOCK_VIRTUAL, pflash_timer, pfl);
-    pfl->wcycle =3D 0;
-    pfl->cmd =3D 0;
-    pfl->status =3D 0;
+    pflash_reset(pfl);
     /* Hardcoded CFI table (mostly from SG29 Spansion flash) */
     /* Standard "QRY" string */
     pfl->cfi_table[0x10] =3D 'Q';
--=20
2.20.1
