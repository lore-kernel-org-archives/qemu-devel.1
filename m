Received: from eggs.gnu.org ([2001:4830:134:3::10]:47528)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gHGqo-0001NS-2q
	for qemu-devel@nongnu.org; Mon, 29 Oct 2018 19:21:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gHGqn-0000FV-7e
	for qemu-devel@nongnu.org; Mon, 29 Oct 2018 19:21:37 -0400
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Date: Tue, 30 Oct 2018 00:21:00 +0100
Message-Id: <20181029232100.8454-4-philmd@redhat.com>
In-Reply-To: <20181029232100.8454-1-philmd@redhat.com>
References: <20181029232100.8454-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 3/3] arm: exynos4: Add dma support for smdkc210
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, Guenter Roeck <linux@roeck-us.net>, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, Igor Mitsyanko <i.mitsyanko@gmail.com>, Alistair Francis <alistair@alistair23.me>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>

From: Guenter Roeck <linux@roeck-us.net>

QEMU already supports pl330. Instantiate it for smdkc210.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
[PMD: Use pl330_init from "hw/dma/pl330.h"]
Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 hw/arm/exynos4_boards.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/hw/arm/exynos4_boards.c b/hw/arm/exynos4_boards.c
index 750162cc95..b36f407a52 100644
--- a/hw/arm/exynos4_boards.c
+++ b/hw/arm/exynos4_boards.c
@@ -32,6 +32,7 @@
 #include "hw/arm/arm.h"
 #include "exec/address-spaces.h"
 #include "hw/arm/exynos4210.h"
+#include "hw/dma/pl330.h"
 #include "hw/boards.h"
=20
 #undef DEBUG
@@ -49,6 +50,9 @@
 #endif
=20
 #define SMDK_LAN9118_BASE_ADDR      0x05000000
+#define SMDK_PL330_BASE0_ADDR       0x12680000
+#define SMDK_PL330_BASE1_ADDR       0x12690000
+#define SMDK_PL330_BASE2_ADDR       0x12850000
=20
 typedef enum Exynos4BoardType {
     EXYNOS4_BOARD_NURI,
@@ -171,6 +175,14 @@ static void smdkc210_init(MachineState *machine)
=20
     lan9215_init(SMDK_LAN9118_BASE_ADDR,
             qemu_irq_invert(s->soc->irq_table[exynos4210_get_irq(37, 1)]=
));
+
+    pl330_init(SMDK_PL330_BASE0_ADDR,
+            qemu_irq_invert(s->soc->irq_table[exynos4210_get_irq(35, 1)]=
), 32);
+    pl330_init(SMDK_PL330_BASE1_ADDR,
+            qemu_irq_invert(s->soc->irq_table[exynos4210_get_irq(36, 1)]=
), 32);
+    pl330_init(SMDK_PL330_BASE2_ADDR,
+            qemu_irq_invert(s->soc->irq_table[exynos4210_get_irq(34, 1)]=
), 1);
+
     arm_load_kernel(ARM_CPU(first_cpu), &exynos4_board_binfo);
 }
=20
--=20
2.17.2
