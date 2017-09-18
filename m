Received: from eggs.gnu.org ([2001:4830:134:3::10]:37291)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <andrew.smirnov@gmail.com>) id 1du24r-0006lU-58
	for qemu-devel@nongnu.org; Mon, 18 Sep 2017 15:51:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <andrew.smirnov@gmail.com>) id 1du24q-0006Ga-8P
	for qemu-devel@nongnu.org; Mon, 18 Sep 2017 15:51:33 -0400
From: Andrey Smirnov <andrew.smirnov@gmail.com>
Date: Mon, 18 Sep 2017 12:50:44 -0700
Message-Id: <20170918195100.17593-2-andrew.smirnov@gmail.com>
In-Reply-To: <20170918195100.17593-1-andrew.smirnov@gmail.com>
References: <20170918195100.17593-1-andrew.smirnov@gmail.com>
Subject: [Qemu-devel] [PATCH 01/17] imx_fec: Do not link to netdev
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-arm@nongnu.org
Cc: Andrey Smirnov <andrew.smirnov@gmail.com>, Peter Maydell <peter.maydell@linaro.org>, Jason Wang <jasowang@redhat.com>, qemu-devel@nongnu.org, yurovsky@gmail.com

Binding to a particular netdev doesn't seem to belong to this layer
and should probably be done as a part of board or SoC specific code.

Convert all of the users of this IP block to use
qdev_set_nic_properties() instead.

Cc: Peter Maydell <peter.maydell@linaro.org>
Cc: Jason Wang <jasowang@redhat.com>
Cc: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Cc: yurovsky@gmail.com
Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
---
 hw/arm/fsl-imx6.c | 1 +
 hw/net/imx_fec.c  | 2 --
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/hw/arm/fsl-imx6.c b/hw/arm/fsl-imx6.c
index 26fd214004..2ed7146c52 100644
--- a/hw/arm/fsl-imx6.c
+++ b/hw/arm/fsl-imx6.c
@@ -385,6 +385,7 @@ static void fsl_imx6_realize(DeviceState *dev, Error **errp)
                                             spi_table[i].irq));
     }
 
+    qdev_set_nic_properties(DEVICE(&s->eth), &nd_table[0]);
     object_property_set_bool(OBJECT(&s->eth), true, "realized", &err);
     if (err) {
         error_propagate(errp, err);
diff --git a/hw/net/imx_fec.c b/hw/net/imx_fec.c
index 90e6ee35ba..88b4b049d7 100644
--- a/hw/net/imx_fec.c
+++ b/hw/net/imx_fec.c
@@ -1171,8 +1171,6 @@ static void imx_eth_realize(DeviceState *dev, Error **errp)
 
     qemu_macaddr_default_if_unset(&s->conf.macaddr);
 
-    s->conf.peers.ncs[0] = nd_table[0].netdev;
-
     s->nic = qemu_new_nic(&imx_eth_net_info, &s->conf,
                           object_get_typename(OBJECT(dev)),
                           DEVICE(dev)->id, s);
-- 
2.13.5
