Received: from eggs.gnu.org ([208.118.235.92]:53234)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gfToE-0006pB-EA
	for qemu-devel@nongnu.org; Fri, 04 Jan 2019 13:03:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gfToD-0006MO-Jw
	for qemu-devel@nongnu.org; Fri, 04 Jan 2019 13:03:02 -0500
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Date: Fri,  4 Jan 2019 18:58:47 +0100
Message-Id: <20190104175847.6290-17-philmd@redhat.com>
In-Reply-To: <20190104175847.6290-1-philmd@redhat.com>
References: <20190104175847.6290-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 16/16] RFC hw/net/smc91c111: Convert init
 helper into an inline function
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, Thomas Huth <thuth@redhat.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, Magnus Damm <magnus.damm@gmail.com>, David Gibson <david@gibson.dropbear.id.au>, Andrew Jeffery <andrew@aj.id.au>, qemu-arm@nongnu.org, qemu-ppc@nongnu.org, Joel Stanley <joel@jms.id.au>, Peter Maydell <peter.maydell@linaro.org>, Andrzej Zaborowski <balrogg@gmail.com>, Igor Mitsyanko <i.mitsyanko@gmail.com>, Beniamino Galvani <b.galvani@gmail.com>, Michael Walle <michael@walle.cc>, Richard Henderson <rth@twiddle.net>, Jan Kiszka <jan.kiszka@web.de>, Jason Wang <jasowang@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Peter Chubb <peter.chubb@nicta.com.au>, Aurelien Jarno <aurelien@aurel32.net>, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>, Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, Rob Herring <robh@kernel.org>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
As init helper in "hw/char/pl011.h"
---
 hw/net/smc91c111.c         | 17 -----------------
 include/hw/net/smc91c111.h | 25 ++++++++++++++++++++++++-
 2 files changed, 24 insertions(+), 18 deletions(-)

diff --git a/hw/net/smc91c111.c b/hw/net/smc91c111.c
index d19ea0750d..3472852270 100644
--- a/hw/net/smc91c111.c
+++ b/hw/net/smc91c111.c
@@ -18,7 +18,6 @@
 /* Number of 2k memory pages available.  */
 #define NUM_PACKETS 4
=20
-#define TYPE_SMC91C111 "smc91c111"
 #define SMC91C111(obj) OBJECT_CHECK(smc91c111_state, (obj), TYPE_SMC91C1=
11)
=20
 typedef struct {
@@ -809,20 +808,4 @@ static void smc91c111_register_types(void)
     type_register_static(&smc91c111_info);
 }
=20
-/* Legacy helper function.  Should go away when machine config files are
-   implemented.  */
-void smc91c111_init(NICInfo *nd, uint32_t base, qemu_irq irq)
-{
-    DeviceState *dev;
-    SysBusDevice *s;
-
-    qemu_check_nic_model(nd, "smc91c111");
-    dev =3D qdev_create(NULL, TYPE_SMC91C111);
-    qdev_set_nic_properties(dev, nd);
-    qdev_init_nofail(dev);
-    s =3D SYS_BUS_DEVICE(dev);
-    sysbus_mmio_map(s, 0, base);
-    sysbus_connect_irq(s, 0, irq);
-}
-
 type_init(smc91c111_register_types)
diff --git a/include/hw/net/smc91c111.h b/include/hw/net/smc91c111.h
index 46f7d9a5d4..0a1097ddd2 100644
--- a/include/hw/net/smc91c111.h
+++ b/include/hw/net/smc91c111.h
@@ -10,9 +10,32 @@
 #ifndef HW_NET_SMC91C111_H
 #define HW_NET_SMC91C111_H
=20
+#include "hw/qdev.h"
 #include "hw/irq.h"
+#include "hw/sysbus.h"
 #include "net/net.h"
=20
-void smc91c111_init(NICInfo *, uint32_t, qemu_irq);
+#define TYPE_SMC91C111 "smc91c111"
+
+/*
+ * Legacy helper function.  Should go away when machine config files are
+ * implemented.
+ */
+static inline DeviceState *smc91c111_init(NICInfo *nd,
+                                          uint32_t base, qemu_irq irq)
+{
+    DeviceState *dev;
+    SysBusDevice *s;
+
+    qemu_check_nic_model(nd, "smc91c111");
+    dev =3D qdev_create(NULL, TYPE_SMC91C111);
+    qdev_set_nic_properties(dev, nd);
+    qdev_init_nofail(dev);
+    s =3D SYS_BUS_DEVICE(dev);
+    sysbus_mmio_map(s, 0, base);
+    sysbus_connect_irq(s, 0, irq);
+
+    return dev;
+}
=20
 #endif
--=20
2.17.2
