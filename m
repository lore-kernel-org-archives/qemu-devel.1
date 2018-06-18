Received: from eggs.gnu.org ([2001:4830:134:3::10]:49859)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fUlEc-0005P2-30
	for qemu-devel@nongnu.org; Sun, 17 Jun 2018 23:53:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fUlEa-00042l-0j
	for qemu-devel@nongnu.org; Sun, 17 Jun 2018 23:53:42 -0400
From: David Gibson <david@gibson.dropbear.id.au>
Date: Mon, 18 Jun 2018 13:53:11 +1000
Message-Id: <20180618035324.19907-16-david@gibson.dropbear.id.au>
In-Reply-To: <20180618035324.19907-1-david@gibson.dropbear.id.au>
References: <20180618035324.19907-1-david@gibson.dropbear.id.au>
Subject: [Qemu-devel] [PULL 15/28] mos6522: expose mos6522_update_irq()
 through MOS6522DeviceClass
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, groug@kaod.org, clg@kaod.org, agraf@suse.de, aik@ozlabs.ru, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, David Gibson <david@gibson.dropbear.id.au>

From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>

In the case where we have an interrupt generated externally from inputs to
bits 1 and 2 of port A and/or port B, it is necessary to expose
mos6522_update_irq() so it can be called by the interrupt source.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/misc/mos6522.c         | 1 +
 include/hw/misc/mos6522.h | 1 +
 2 files changed, 2 insertions(+)

diff --git a/hw/misc/mos6522.c b/hw/misc/mos6522.c
index 8d5b419825..14cff26c61 100644
--- a/hw/misc/mos6522.c
+++ b/hw/misc/mos6522.c
@@ -463,6 +463,7 @@ static void mos6522_class_init(ObjectClass *oc, void *data)
     mdc->set_sr_int = mos6522_set_sr_int;
     mdc->portB_write = mos6522_portB_write;
     mdc->portA_write = mos6522_portA_write;
+    mdc->update_irq = mos6522_update_irq;
     mdc->get_timer1_counter_value = mos6522_get_counter_value;
     mdc->get_timer2_counter_value = mos6522_get_counter_value;
     mdc->get_timer1_load_time = mos6522_get_load_time;
diff --git a/include/hw/misc/mos6522.h b/include/hw/misc/mos6522.h
index f52b41920b..03d9f0c059 100644
--- a/include/hw/misc/mos6522.h
+++ b/include/hw/misc/mos6522.h
@@ -134,6 +134,7 @@ typedef struct MOS6522DeviceClass {
     void (*set_sr_int)(MOS6522State *dev);
     void (*portB_write)(MOS6522State *dev);
     void (*portA_write)(MOS6522State *dev);
+    void (*update_irq)(MOS6522State *dev);
     /* These are used to influence the CUDA MacOS timebase calibration */
     uint64_t (*get_timer1_counter_value)(MOS6522State *dev, MOS6522Timer *ti);
     uint64_t (*get_timer2_counter_value)(MOS6522State *dev, MOS6522Timer *ti);
-- 
2.17.1
