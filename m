Received: from eggs.gnu.org ([209.51.188.92]:39375)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hNNPx-0002sy-Mc
	for qemu-devel@nongnu.org; Sun, 05 May 2019 16:07:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hNNPu-0006Pa-L0
	for qemu-devel@nongnu.org; Sun, 05 May 2019 16:07:24 -0400
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Date: Sun,  5 May 2019 22:06:02 +0200
Message-Id: <20190505200602.12412-6-philmd@redhat.com>
In-Reply-To: <20190505200602.12412-1-philmd@redhat.com>
References: <20190505200602.12412-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 5/5] hw/block/pflash_cfi02: Add the
 DeviceReset() handler
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

The pflash device is a child of TYPE_DEVICE, so it can implement
the DeviceReset handler. Actually it has to implement it, else
on machine reset it might stay in an incoherent state, as it has
been reported in the buglink listed below.

Add the DeviceReset handler and remove its call from the realize()
function.

Buglink: https://bugzilla.redhat.com/show_bug.cgi?id=3D1678713
Reported-by: Laszlo Ersek <lersek@redhat.com>
Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 hw/block/pflash_cfi02.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/hw/block/pflash_cfi02.c b/hw/block/pflash_cfi02.c
index f321b74433c..5af367d1563 100644
--- a/hw/block/pflash_cfi02.c
+++ b/hw/block/pflash_cfi02.c
@@ -674,6 +674,11 @@ static void pflash_cfi02_realize(DeviceState *dev, E=
rror **errp)
     pfl->cfi_table[0x3c] =3D 0x00;
 }
=20
+static void pflash_cfi02_reset(DeviceState *dev)
+{
+    pflash_reset(PFLASH_CFI02(dev));
+}
+
 static Property pflash_cfi02_properties[] =3D {
     DEFINE_PROP_DRIVE("drive", PFlashCFI02, blk),
     DEFINE_PROP_UINT32("num-blocks", PFlashCFI02, nb_blocs, 0),
@@ -701,6 +706,7 @@ static void pflash_cfi02_class_init(ObjectClass *klas=
s, void *data)
 {
     DeviceClass *dc =3D DEVICE_CLASS(klass);
=20
+    dc->reset =3D pflash_cfi02_reset;
     dc->realize =3D pflash_cfi02_realize;
     dc->unrealize =3D pflash_cfi02_unrealize;
     dc->props =3D pflash_cfi02_properties;
--=20
2.20.1
