Received: from eggs.gnu.org ([209.51.188.92]:53838)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hCAbW-0007us-46
	for qemu-devel@nongnu.org; Thu, 04 Apr 2019 18:13:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hCAbU-0006nX-5b
	for qemu-devel@nongnu.org; Thu, 04 Apr 2019 18:13:02 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34466)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hCAbR-0006hH-Uh
	for qemu-devel@nongnu.org; Thu, 04 Apr 2019 18:12:58 -0400
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Date: Fri,  5 Apr 2019 00:12:37 +0200
Message-Id: <20190404221238.12468-4-philmd@redhat.com>
In-Reply-To: <20190404221238.12468-1-philmd@redhat.com>
References: <20190404221238.12468-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH for-4.1 3/4] hw/isa/superio: Support chipsets
 with no Floppy Disk controller
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, Thomas Huth <thuth@redhat.com>
Cc: Aurelien Jarno <aurelien@aurel32.net>, "Michael S. Tsirkin" <mst@redhat.com>, Aleksandar Markovic <amarkovic@wavecomp.com>, Aleksandar Rikalo <arikalo@wavecomp.com>, Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>

Not all Super I/O chipsets provide a Floppy Disk Controller.

Without this change, using a Super I/O with no FDC would abort QEMU with:

  Initialization of device isa-fdc failed: ISA controller does not suppor=
t DMA

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 hw/isa/isa-superio.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/hw/isa/isa-superio.c b/hw/isa/isa-superio.c
index b0761ea1f96..6956f06d529 100644
--- a/hw/isa/isa-superio.c
+++ b/hw/isa/isa-superio.c
@@ -113,7 +113,8 @@ static void isa_superio_realize(DeviceState *dev, Err=
or **errp)
     }
=20
     /* Floppy disc */
-    if (!k->floppy.is_enabled || k->floppy.is_enabled(s, 0)) {
+    if (k->floppy.count
+            && (!k->floppy.is_enabled || k->floppy.is_enabled(s, 0))) {
         isa =3D isa_create(bus, "isa-fdc");
         d =3D DEVICE(isa);
         if (k->floppy.get_iobase) {
--=20
2.20.1
