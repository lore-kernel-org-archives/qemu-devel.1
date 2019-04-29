Received: from eggs.gnu.org ([209.51.188.92]:34429)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hL9et-0004uX-AG
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 13:01:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hL9er-0006mr-OU
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 13:01:39 -0400
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e]:40485)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hL9eq-0006fx-6N
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 13:01:36 -0400
Received: by mail-wr1-x42e.google.com with SMTP id h4so17116702wre.7
	for <qemu-devel@nongnu.org>; Mon, 29 Apr 2019 10:01:26 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
	by smtp.gmail.com with ESMTPSA id a13sm36896wmj.39.2019.04.29.10.01.23
	for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Mon, 29 Apr 2019 10:01:24 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 29 Apr 2019 18:00:29 +0100
Message-Id: <20190429170030.11323-42-peter.maydell@linaro.org>
In-Reply-To: <20190429170030.11323-1-peter.maydell@linaro.org>
References: <20190429170030.11323-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 41/42] hw/net/lan9118: Export TYPE_LAN9118 and
 use it instead of hardcoded string
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

From: Philippe Mathieu-Daudé <philmd@redhat.com>

Reviewed-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Message-id: 20190412165416.7977-12-philmd@redhat.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/hw/net/lan9118.h | 2 ++
 hw/arm/exynos4_boards.c  | 3 ++-
 hw/arm/mps2-tz.c         | 3 ++-
 hw/net/lan9118.c         | 1 -
 4 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/include/hw/net/lan9118.h b/include/hw/net/lan9118.h
index d13d8cd3d22..500acb4c143 100644
--- a/include/hw/net/lan9118.h
+++ b/include/hw/net/lan9118.h
@@ -14,6 +14,8 @@
 #include "hw/irq.h"
 #include "net/net.h"
 
+#define TYPE_LAN9118 "lan9118"
+
 void lan9118_init(NICInfo *, uint32_t, qemu_irq);
 
 #endif
diff --git a/hw/arm/exynos4_boards.c b/hw/arm/exynos4_boards.c
index 750162cc95a..ea8100f65a8 100644
--- a/hw/arm/exynos4_boards.c
+++ b/hw/arm/exynos4_boards.c
@@ -32,6 +32,7 @@
 #include "hw/arm/arm.h"
 #include "exec/address-spaces.h"
 #include "hw/arm/exynos4210.h"
+#include "hw/net/lan9118.h"
 #include "hw/boards.h"
 
 #undef DEBUG
@@ -92,7 +93,7 @@ static void lan9215_init(uint32_t base, qemu_irq irq)
     /* This should be a 9215 but the 9118 is close enough */
     if (nd_table[0].used) {
         qemu_check_nic_model(&nd_table[0], "lan9118");
-        dev = qdev_create(NULL, "lan9118");
+        dev = qdev_create(NULL, TYPE_LAN9118);
         qdev_set_nic_properties(dev, &nd_table[0]);
         qdev_prop_set_uint32(dev, "mode_16bit", 1);
         qdev_init_nofail(dev);
diff --git a/hw/arm/mps2-tz.c b/hw/arm/mps2-tz.c
index f79f090a4ac..7832408bb70 100644
--- a/hw/arm/mps2-tz.c
+++ b/hw/arm/mps2-tz.c
@@ -56,6 +56,7 @@
 #include "hw/arm/armsse.h"
 #include "hw/dma/pl080.h"
 #include "hw/ssi/pl022.h"
+#include "hw/net/lan9118.h"
 #include "net/net.h"
 #include "hw/core/split-irq.h"
 
@@ -244,7 +245,7 @@ static MemoryRegion *make_eth_dev(MPS2TZMachineState *mms, void *opaque,
      * except that it doesn't support the checksum-offload feature.
      */
     qemu_check_nic_model(nd, "lan9118");
-    mms->lan9118 = qdev_create(NULL, "lan9118");
+    mms->lan9118 = qdev_create(NULL, TYPE_LAN9118);
     qdev_set_nic_properties(mms->lan9118, nd);
     qdev_init_nofail(mms->lan9118);
 
diff --git a/hw/net/lan9118.c b/hw/net/lan9118.c
index a428b16eda5..b29e3fee49f 100644
--- a/hw/net/lan9118.c
+++ b/hw/net/lan9118.c
@@ -175,7 +175,6 @@ static const VMStateDescription vmstate_lan9118_packet = {
     }
 };
 
-#define TYPE_LAN9118 "lan9118"
 #define LAN9118(obj) OBJECT_CHECK(lan9118_state, (obj), TYPE_LAN9118)
 
 typedef struct {
-- 
2.20.1
