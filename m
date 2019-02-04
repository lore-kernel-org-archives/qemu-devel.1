Received: from eggs.gnu.org ([209.51.188.92]:50737)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gqnXh-0002MT-Ig
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 18:20:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gqnXf-00021g-Q7
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 18:20:45 -0500
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Date: Tue,  5 Feb 2019 00:18:14 +0100
Message-Id: <20190204231815.29661-11-philmd@redhat.com>
In-Reply-To: <20190204231815.29661-1-philmd@redhat.com>
References: <20190204231815.29661-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 10/11] hw/net/lan9118: Export TYPE_LAN9118
 and use it instead of hardcoded string
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-trivial@nongnu.org, qemu-devel@nongnu.org
Cc: Richard Henderson <rth@twiddle.net>, Andrew Jeffery <andrew@aj.id.au>, Peter Maydell <peter.maydell@linaro.org>, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>, Jan Kiszka <jan.kiszka@web.de>, Igor Mitsyanko <i.mitsyanko@gmail.com>, Michael Walle <michael@walle.cc>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, qemu-ppc@nongnu.org, Peter Chubb <peter.chubb@nicta.com.au>, Beniamino Galvani <b.galvani@gmail.com>, BALATON Zoltan <balaton@eik.bme.hu>, Magnus Damm <magnus.damm@gmail.com>, Gerd Hoffmann <kraxel@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>, Joel Stanley <joel@jms.id.au>, Andrzej Zaborowski <balrogg@gmail.com>, David Gibson <david@gibson.dropbear.id.au>, Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, qemu-arm@nongnu.org, Jason Wang <jasowang@redhat.com>, Rob Herring <robh@kernel.org>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 hw/arm/exynos4_boards.c  | 3 ++-
 hw/arm/mps2-tz.c         | 3 ++-
 hw/net/lan9118.c         | 1 -
 include/hw/net/lan9118.h | 2 ++
 4 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/hw/arm/exynos4_boards.c b/hw/arm/exynos4_boards.c
index 750162cc95..ea8100f65a 100644
--- a/hw/arm/exynos4_boards.c
+++ b/hw/arm/exynos4_boards.c
@@ -32,6 +32,7 @@
 #include "hw/arm/arm.h"
 #include "exec/address-spaces.h"
 #include "hw/arm/exynos4210.h"
+#include "hw/net/lan9118.h"
 #include "hw/boards.h"
=20
 #undef DEBUG
@@ -92,7 +93,7 @@ static void lan9215_init(uint32_t base, qemu_irq irq)
     /* This should be a 9215 but the 9118 is close enough */
     if (nd_table[0].used) {
         qemu_check_nic_model(&nd_table[0], "lan9118");
-        dev =3D qdev_create(NULL, "lan9118");
+        dev =3D qdev_create(NULL, TYPE_LAN9118);
         qdev_set_nic_properties(dev, &nd_table[0]);
         qdev_prop_set_uint32(dev, "mode_16bit", 1);
         qdev_init_nofail(dev);
diff --git a/hw/arm/mps2-tz.c b/hw/arm/mps2-tz.c
index f79f090a4a..7832408bb7 100644
--- a/hw/arm/mps2-tz.c
+++ b/hw/arm/mps2-tz.c
@@ -56,6 +56,7 @@
 #include "hw/arm/armsse.h"
 #include "hw/dma/pl080.h"
 #include "hw/ssi/pl022.h"
+#include "hw/net/lan9118.h"
 #include "net/net.h"
 #include "hw/core/split-irq.h"
=20
@@ -244,7 +245,7 @@ static MemoryRegion *make_eth_dev(MPS2TZMachineState =
*mms, void *opaque,
      * except that it doesn't support the checksum-offload feature.
      */
     qemu_check_nic_model(nd, "lan9118");
-    mms->lan9118 =3D qdev_create(NULL, "lan9118");
+    mms->lan9118 =3D qdev_create(NULL, TYPE_LAN9118);
     qdev_set_nic_properties(mms->lan9118, nd);
     qdev_init_nofail(mms->lan9118);
=20
diff --git a/hw/net/lan9118.c b/hw/net/lan9118.c
index a428b16eda..b29e3fee49 100644
--- a/hw/net/lan9118.c
+++ b/hw/net/lan9118.c
@@ -175,7 +175,6 @@ static const VMStateDescription vmstate_lan9118_packe=
t =3D {
     }
 };
=20
-#define TYPE_LAN9118 "lan9118"
 #define LAN9118(obj) OBJECT_CHECK(lan9118_state, (obj), TYPE_LAN9118)
=20
 typedef struct {
diff --git a/include/hw/net/lan9118.h b/include/hw/net/lan9118.h
index d13d8cd3d2..500acb4c14 100644
--- a/include/hw/net/lan9118.h
+++ b/include/hw/net/lan9118.h
@@ -14,6 +14,8 @@
 #include "hw/irq.h"
 #include "net/net.h"
=20
+#define TYPE_LAN9118 "lan9118"
+
 void lan9118_init(NICInfo *, uint32_t, qemu_irq);
=20
 #endif
--=20
2.20.1
