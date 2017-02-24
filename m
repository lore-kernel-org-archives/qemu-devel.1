Received: from eggs.gnu.org ([2001:4830:134:3::10]:50419)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clement.deschamps@antfield.fr>) id 1chIux-0003OA-QE
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 11:40:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clement.deschamps@antfield.fr>) id 1chIuw-0001CK-Mq
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 11:40:27 -0500
From: Clement Deschamps <clement.deschamps@antfield.fr>
Date: Fri, 24 Feb 2017 17:40:19 +0100
Message-Id: <20170224164021.9066-3-clement.deschamps@antfield.fr>
In-Reply-To: <20170224164021.9066-1-clement.deschamps@antfield.fr>
References: <20170224164021.9066-1-clement.deschamps@antfield.fr>
Subject: [Qemu-devel] [PATCH v3 2/4] hw/sd: add card-reparenting function
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Clement Deschamps <clement.deschamps@antfield.fr>, qemu-arm@nongnu.org, peter.maydell@linaro.org, andrew.baumann@microsoft.com

Provide a new function sdbus_reparent_card() in sd core for reparenting
a card from a SDBus to another one.

This function is required by the raspi platform, where the two SD
controllers can be dynamically switched.

Signed-off-by: Clement Deschamps <clement.deschamps@antfield.fr>
---
 hw/sd/core.c       | 30 ++++++++++++++++++++++++++++++
 include/hw/sd/sd.h |  1 +
 2 files changed, 31 insertions(+)

diff --git a/hw/sd/core.c b/hw/sd/core.c
index 14c2bdf27b..a8f24f505f 100644
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
diff --git a/include/hw/sd/sd.h b/include/hw/sd/sd.h
index 79909b2478..54eaf9b554 100644
--- a/include/hw/sd/sd.h
+++ b/include/hw/sd/sd.h
@@ -140,6 +140,7 @@ uint8_t sdbus_read_data(SDBus *sd);
 bool sdbus_data_ready(SDBus *sd);
 bool sdbus_get_inserted(SDBus *sd);
 bool sdbus_get_readonly(SDBus *sd);
+void sdbus_reparent_card(SDBus *from, SDBus *to);
 
 /* Functions to be used by SD devices to report back to qdevified controllers */
 void sdbus_set_inserted(SDBus *sd, bool inserted);
-- 
2.11.1
