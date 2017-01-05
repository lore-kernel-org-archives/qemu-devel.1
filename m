Received: from eggs.gnu.org ([2001:4830:134:3::10]:35661)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alastair@au1.ibm.com>) id 1cOzmH-0001gR-Cv
	for qemu-devel@nongnu.org; Wed, 04 Jan 2017 23:35:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alastair@au1.ibm.com>) id 1cOzmE-0001Pf-6N
	for qemu-devel@nongnu.org; Wed, 04 Jan 2017 23:35:49 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:48824)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <alastair@au1.ibm.com>)
	id 1cOzmD-0001OM-Qj
	for qemu-devel@nongnu.org; Wed, 04 Jan 2017 23:35:46 -0500
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
	v054XnBB043732
	for <qemu-devel@nongnu.org>; Wed, 4 Jan 2017 23:35:44 -0500
Received: from e23smtp07.au.ibm.com (e23smtp07.au.ibm.com [202.81.31.140])
	by mx0a-001b2d01.pphosted.com with ESMTP id 27s6qcjjth-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 04 Jan 2017 23:35:44 -0500
Received: from localhost
	by e23smtp07.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <alastair@au1.ibm.com>;
	Thu, 5 Jan 2017 14:35:41 +1000
From: "Alastair D'Silva" <alastair@au1.ibm.com>
Date: Thu,  5 Jan 2017 15:34:24 +1100
In-Reply-To: <20170105043430.3176-1-alastair@au1.ibm.com>
References: <20170105043430.3176-1-alastair@au1.ibm.com>
Message-Id: <20170105043430.3176-2-alastair@au1.ibm.com>
Subject: [Qemu-devel] [PATCH v5 1/7] arm: Uniquely name imx25 I2C buses.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>
Cc: Peter Maydell <peter.maydell@linaro.org>, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>, Andrew Jeffery <andrew@aj.id.au>, Joel Stanley <joel@jms.id.au>, Alastair D'Silva <alastair@d-silva.org>

From: Alastair D'Silva <alastair@d-silva.org>

The imx25 chip provides 3 i2c buses, but they have all been named
"i2c", which makes it difficult to predict which bus a device will
be connected to when specified on the command line.

This patch addresses the issue by naming the buses uniquely:
  i2c-bus.0 i2c-bus.1 i2c-bus.2

Signed-off-by: Alastair D'Silva <alastair@d-silva.org>
---
 hw/arm/imx25_pdk.c | 2 +-
 hw/i2c/imx_i2c.c   | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/arm/imx25_pdk.c b/hw/arm/imx25_pdk.c
index 025b608..44e741f 100644
--- a/hw/arm/imx25_pdk.c
+++ b/hw/arm/imx25_pdk.c
@@ -139,7 +139,7 @@ static void imx25_pdk_init(MachineState *machine)
          * of simple qtest. See "make check" for details.
          */
         i2c_create_slave((I2CBus *)qdev_get_child_bus(DEVICE(&s->soc.i2c[0]),
-                                                      "i2c"),
+                                                      "i2c-bus.0"),
                          "ds1338", 0x68);
     }
 }
diff --git a/hw/i2c/imx_i2c.c b/hw/i2c/imx_i2c.c
index 37e5a62..6c81b98 100644
--- a/hw/i2c/imx_i2c.c
+++ b/hw/i2c/imx_i2c.c
@@ -310,7 +310,7 @@ static void imx_i2c_realize(DeviceState *dev, Error **errp)
                           IMX_I2C_MEM_SIZE);
     sysbus_init_mmio(SYS_BUS_DEVICE(dev), &s->iomem);
     sysbus_init_irq(SYS_BUS_DEVICE(dev), &s->irq);
-    s->bus = i2c_init_bus(DEVICE(dev), "i2c");
+    s->bus = i2c_init_bus(DEVICE(dev), NULL);
 }
 
 static void imx_i2c_class_init(ObjectClass *klass, void *data)
-- 
2.9.3
