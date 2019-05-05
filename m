Received: from eggs.gnu.org ([209.51.188.92]:45859)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hNJ4W-0008OU-P2
	for qemu-devel@nongnu.org; Sun, 05 May 2019 11:29:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hNJ4V-0003SZ-UG
	for qemu-devel@nongnu.org; Sun, 05 May 2019 11:29:00 -0400
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Date: Sun,  5 May 2019 17:28:38 +0200
Message-Id: <20190505152839.18650-3-philmd@redhat.com>
In-Reply-To: <20190505152839.18650-1-philmd@redhat.com>
References: <20190505152839.18650-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 2/3] hw/ppc/40p: Move the MC146818 RTC to the
 board where it belongs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Artyom Tarasenko <atar4qemu@gmail.com>, qemu-devel@nongnu.org, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Cc: qemu-ppc@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, David Gibson <david@gibson.dropbear.id.au>, =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>

The MC146818 RTC was incorrectly added to the i82378 chipset in
commit a04ff940974a. In the next commit (506b7ddf8893) the PReP
machine use the i82378.
Since the MC146818 is specific to the PReP machine, move its use
there.

Fixes: a04ff940974a
Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 hw/isa/i82378.c | 4 ----
 hw/ppc/prep.c   | 3 +++
 2 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/hw/isa/i82378.c b/hw/isa/i82378.c
index a5d67bc6d7a..c08970b24a2 100644
--- a/hw/isa/i82378.c
+++ b/hw/isa/i82378.c
@@ -21,7 +21,6 @@
 #include "hw/pci/pci.h"
 #include "hw/i386/pc.h"
 #include "hw/timer/i8254.h"
-#include "hw/timer/mc146818rtc.h"
 #include "hw/audio/pcspk.h"
=20
 #define TYPE_I82378 "i82378"
@@ -105,9 +104,6 @@ static void i82378_realize(PCIDevice *pci, Error **er=
rp)
=20
     /* 2 82C37 (dma) */
     isa =3D isa_create_simple(isabus, "i82374");
-
-    /* timer */
-    isa_create_simple(isabus, TYPE_MC146818_RTC);
 }
=20
 static void i82378_init(Object *obj)
diff --git a/hw/ppc/prep.c b/hw/ppc/prep.c
index ebee3211480..7a0d311d43c 100644
--- a/hw/ppc/prep.c
+++ b/hw/ppc/prep.c
@@ -675,6 +675,9 @@ static void ibm_40p_init(MachineState *machine)
     qdev_prop_set_uint32(dev, "ram-size", machine->ram_size);
     qdev_init_nofail(dev);
=20
+    /* RTC */
+    isa_create_simple(isa_bus, TYPE_MC146818_RTC);
+
     /* initialize CMOS checksums */
     cmos_checksum =3D 0x6aa9;
     qbus_walk_children(BUS(isa_bus), prep_set_cmos_checksum, NULL, NULL,=
 NULL,
--=20
2.20.1
