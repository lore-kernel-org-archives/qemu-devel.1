Received: from eggs.gnu.org ([2001:4830:134:3::10]:34965)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1emgYH-0006Ca-G5
	for qemu-devel@nongnu.org; Fri, 16 Feb 2018 08:59:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1emgYG-00007U-Ea
	for qemu-devel@nongnu.org; Fri, 16 Feb 2018 08:59:49 -0500
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:46480)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1emgYG-0008PP-5n
	for qemu-devel@nongnu.org; Fri, 16 Feb 2018 08:59:48 -0500
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 16 Feb 2018 13:45:16 +0000
Message-Id: <20180216134516.6269-3-peter.maydell@linaro.org>
In-Reply-To: <20180216134516.6269-1-peter.maydell@linaro.org>
References: <20180216134516.6269-1-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PATCH 2/2] hw/arm/bcm2835_peripherals: Use
 sysbus_init_child()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: patches@linaro.org, Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>

Use the new sysbus_init_child() function rather than
opencoding the init-and-parent operations.

This commit was created with coccinelle:
spatch --in-place -sp_file sysbus-init-child.spatch --keep-comments hw/arm/bcm2835_peripherals.c

and the following spatch file:
@@
expression CHILD, CHILDTYPE, POBJ, CHILDNAME, ERREXPR;
@@
- object_initialize(&CHILD, sizeof(CHILD), CHILDTYPE);
- object_property_add_child(POBJ, CHILDNAME, OBJECT(&CHILD), ERREXPR);
- qdev_set_parent_bus(DEVICE(&CHILD), sysbus_get_default());
+ sysbus_init_child(POBJ, CHILDNAME, &CHILD, sizeof(CHILD), CHILDTYPE);

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/bcm2835_peripherals.c | 36 ++++++++++++------------------------
 1 file changed, 12 insertions(+), 24 deletions(-)

diff --git a/hw/arm/bcm2835_peripherals.c b/hw/arm/bcm2835_peripherals.c
index 13b63970d7..7968d611ef 100644
--- a/hw/arm/bcm2835_peripherals.c
+++ b/hw/arm/bcm2835_peripherals.c
@@ -41,9 +41,7 @@ static void bcm2835_peripherals_init(Object *obj)
                        MBOX_CHAN_COUNT << MBOX_AS_CHAN_SHIFT);
 
     /* Interrupt Controller */
-    object_initialize(&s->ic, sizeof(s->ic), TYPE_BCM2835_IC);
-    object_property_add_child(obj, "ic", OBJECT(&s->ic), NULL);
-    qdev_set_parent_bus(DEVICE(&s->ic), sysbus_get_default());
+    sysbus_init_child(obj, "ic", &s->ic, sizeof(s->ic), TYPE_BCM2835_IC);
 
     /* UART0 */
     s->uart0 = SYS_BUS_DEVICE(object_new("pl011"));
@@ -51,14 +49,11 @@ static void bcm2835_peripherals_init(Object *obj)
     qdev_set_parent_bus(DEVICE(s->uart0), sysbus_get_default());
 
     /* AUX / UART1 */
-    object_initialize(&s->aux, sizeof(s->aux), TYPE_BCM2835_AUX);
-    object_property_add_child(obj, "aux", OBJECT(&s->aux), NULL);
-    qdev_set_parent_bus(DEVICE(&s->aux), sysbus_get_default());
+    sysbus_init_child(obj, "aux", &s->aux, sizeof(s->aux), TYPE_BCM2835_AUX);
 
     /* Mailboxes */
-    object_initialize(&s->mboxes, sizeof(s->mboxes), TYPE_BCM2835_MBOX);
-    object_property_add_child(obj, "mbox", OBJECT(&s->mboxes), NULL);
-    qdev_set_parent_bus(DEVICE(&s->mboxes), sysbus_get_default());
+    sysbus_init_child(obj, "mbox", &s->mboxes, sizeof(s->mboxes),
+                      TYPE_BCM2835_MBOX);
 
     object_property_add_const_link(OBJECT(&s->mboxes), "mbox-mr",
                                    OBJECT(&s->mbox_mr), &error_abort);
@@ -86,32 +81,25 @@ static void bcm2835_peripherals_init(Object *obj)
                                    OBJECT(&s->gpu_bus_mr), &error_abort);
 
     /* Random Number Generator */
-    object_initialize(&s->rng, sizeof(s->rng), TYPE_BCM2835_RNG);
-    object_property_add_child(obj, "rng", OBJECT(&s->rng), NULL);
-    qdev_set_parent_bus(DEVICE(&s->rng), sysbus_get_default());
+    sysbus_init_child(obj, "rng", &s->rng, sizeof(s->rng), TYPE_BCM2835_RNG);
 
     /* Extended Mass Media Controller */
-    object_initialize(&s->sdhci, sizeof(s->sdhci), TYPE_SYSBUS_SDHCI);
-    object_property_add_child(obj, "sdhci", OBJECT(&s->sdhci), NULL);
-    qdev_set_parent_bus(DEVICE(&s->sdhci), sysbus_get_default());
+    sysbus_init_child(obj, "sdhci", &s->sdhci, sizeof(s->sdhci),
+                      TYPE_SYSBUS_SDHCI);
 
     /* SDHOST */
-    object_initialize(&s->sdhost, sizeof(s->sdhost), TYPE_BCM2835_SDHOST);
-    object_property_add_child(obj, "sdhost", OBJECT(&s->sdhost), NULL);
-    qdev_set_parent_bus(DEVICE(&s->sdhost), sysbus_get_default());
+    sysbus_init_child(obj, "sdhost", &s->sdhost, sizeof(s->sdhost),
+                      TYPE_BCM2835_SDHOST);
 
     /* DMA Channels */
-    object_initialize(&s->dma, sizeof(s->dma), TYPE_BCM2835_DMA);
-    object_property_add_child(obj, "dma", OBJECT(&s->dma), NULL);
-    qdev_set_parent_bus(DEVICE(&s->dma), sysbus_get_default());
+    sysbus_init_child(obj, "dma", &s->dma, sizeof(s->dma), TYPE_BCM2835_DMA);
 
     object_property_add_const_link(OBJECT(&s->dma), "dma-mr",
                                    OBJECT(&s->gpu_bus_mr), &error_abort);
 
     /* GPIO */
-    object_initialize(&s->gpio, sizeof(s->gpio), TYPE_BCM2835_GPIO);
-    object_property_add_child(obj, "gpio", OBJECT(&s->gpio), NULL);
-    qdev_set_parent_bus(DEVICE(&s->gpio), sysbus_get_default());
+    sysbus_init_child(obj, "gpio", &s->gpio, sizeof(s->gpio),
+                      TYPE_BCM2835_GPIO);
 
     object_property_add_const_link(OBJECT(&s->gpio), "sdbus-sdhci",
                                    OBJECT(&s->sdhci.sdbus), &error_abort);
-- 
2.16.1
