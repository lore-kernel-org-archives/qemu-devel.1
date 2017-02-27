Received: from eggs.gnu.org ([2001:4830:134:3::10]:52057)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1ciPfg-0002NG-JM
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 13:05:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1ciPfe-0001ub-UQ
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 13:05:16 -0500
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:48679)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1ciPfe-0001rj-L7
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 13:05:14 -0500
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.84_2)
	(envelope-from <pm215@archaic.org.uk>) id 1ciPfd-0002Rk-Hb
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 18:05:13 +0000
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 27 Feb 2017 18:04:55 +0000
Message-Id: <1488218699-31035-27-git-send-email-peter.maydell@linaro.org>
In-Reply-To: <1488218699-31035-1-git-send-email-peter.maydell@linaro.org>
References: <1488218699-31035-1-git-send-email-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PULL 26/30] hw/sd: add card-reparenting function
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

From: Clement Deschamps <clement.deschamps@antfield.fr>

Provide a new function sdbus_reparent_card() in sd core for reparenting
a card from a SDBus to another one.

This function is required by the raspi platform, where the two SD
controllers can be dynamically switched.

Signed-off-by: Clement Deschamps <clement.deschamps@antfield.fr>
Message-id: 20170224164021.9066-3-clement.deschamps@antfield.fr
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
[PMM: added a doc comment to the header file]
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/hw/sd/sd.h | 11 +++++++++++
 hw/sd/core.c       | 30 ++++++++++++++++++++++++++++++
 2 files changed, 41 insertions(+)

diff --git a/include/hw/sd/sd.h b/include/hw/sd/sd.h
index 79909b2..96caefe 100644
--- a/include/hw/sd/sd.h
+++ b/include/hw/sd/sd.h
@@ -140,6 +140,17 @@ uint8_t sdbus_read_data(SDBus *sd);
 bool sdbus_data_ready(SDBus *sd);
 bool sdbus_get_inserted(SDBus *sd);
 bool sdbus_get_readonly(SDBus *sd);
+/**
+ * sdbus_reparent_card: Reparent an SD card from one controller to another
+ * @from: controller bus to remove card from
+ * @to: controller bus to move card to
+ *
+ * Reparent an SD card, effectively unplugging it from one controller
+ * and inserting it into another. This is useful for SoCs like the
+ * bcm2835 which have two SD controllers and connect a single SD card
+ * to them, selected by the guest reprogramming GPIO line routing.
+ */
+void sdbus_reparent_card(SDBus *from, SDBus *to);
 
 /* Functions to be used by SD devices to report back to qdevified controllers */
 void sdbus_set_inserted(SDBus *sd, bool inserted);
diff --git a/hw/sd/core.c b/hw/sd/core.c
index 14c2bdf..a8f24f5 100644
--- a/hw/sd/core.c
+++ b/hw/sd/core.c
@@ -131,6 +131,36 @@ void sdbus_set_readonly(SDBus *sdbus, bool readonly)
     }
 }
 
+void sdbus_reparent_card(SDBus *from, SDBus *to)
+{
+    BusChild *kid = QTAILQ_FIRST(&from->qbus.children);
+    SDState *card;
+    SDCardClass *sc;
+    bool readonly;
+
+    /* We directly reparent the card object rather than implementing this
+     * as a hotpluggable connection because we don't want to expose SD cards
+     * to users as being hotpluggable, and we can get away with it in this
+     * limited use case. This could perhaps be implemented more cleanly in
+     * future by adding support to the hotplug infrastructure for "device
+     * can be hotplugged only via code, not by user".
+     */
+
+    if (!kid) {
+        return;
+    }
+
+    card = SD_CARD(kid->child);
+    sc = SD_CARD_GET_CLASS(card);
+    readonly = sc->get_readonly(card);
+
+    sdbus_set_inserted(from, false);
+    object_unparent(OBJECT(kid));
+    qdev_set_parent_bus(DEVICE(card), &to->qbus);
+    sdbus_set_inserted(to, true);
+    sdbus_set_readonly(to, readonly);
+}
+
 static const TypeInfo sd_bus_info = {
     .name = TYPE_SD_BUS,
     .parent = TYPE_BUS,
-- 
2.7.4
