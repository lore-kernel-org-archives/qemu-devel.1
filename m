Received: from eggs.gnu.org ([2001:4830:134:3::10]:52080)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1eZd3y-0007Pd-Ni
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 08:38:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1eZd3x-0008Uq-NB
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 08:38:34 -0500
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:45844)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1eZd3x-0008UD-Fg
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 08:38:33 -0500
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1eZd3w-0005fF-FO
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 13:38:32 +0000
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 11 Jan 2018 13:38:06 +0000
Message-Id: <1515677902-23436-11-git-send-email-peter.maydell@linaro.org>
In-Reply-To: <1515677902-23436-1-git-send-email-peter.maydell@linaro.org>
References: <1515677902-23436-1-git-send-email-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 10/26] imx_fec: Do not link to netdev
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

From: Andrey Smirnov <andrew.smirnov@gmail.com>

Binding to a particular netdev doesn't seem to belong to this layer
and should probably be done as a part of board or SoC specific code.

Convert all of the users of this IP block to use
qdev_set_nic_properties() instead.

Cc: Peter Maydell <peter.maydell@linaro.org>
Cc: Jason Wang <jasowang@redhat.com>
Cc: Philippe Mathieu-Daudé <f4bug@amsat.org>
Cc: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Cc: yurovsky@gmail.com
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/fsl-imx6.c | 1 +
 hw/net/imx_fec.c  | 2 --
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/hw/arm/fsl-imx6.c b/hw/arm/fsl-imx6.c
index 59ef33e..b0d4088 100644
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
index 90e6ee3..88b4b04 100644
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
2.7.4
