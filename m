Received: from eggs.gnu.org ([2001:4830:134:3::10]:57533)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mjt@tls.msk.ru>) id 1dwFbD-0002pK-Vk
	for qemu-devel@nongnu.org; Sun, 24 Sep 2017 18:42:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mjt@tls.msk.ru>) id 1dwFbA-00082s-3c
	for qemu-devel@nongnu.org; Sun, 24 Sep 2017 18:42:08 -0400
From: Michael Tokarev <mjt@tls.msk.ru>
Date: Mon, 25 Sep 2017 00:22:37 +0300
Message-Id: <0aa6d8d3063477e615da8b9ff12e5bff9b0ac9bd.1506288070.git.mjt@msgid.tls.msk.ru>
In-Reply-To: <cover.1506288070.git.mjt@msgid.tls.msk.ru>
References: <cover.1506288070.git.mjt@msgid.tls.msk.ru>
In-Reply-To: <cover.1506288070.git.mjt@msgid.tls.msk.ru>
References: <cover.1506288070.git.mjt@msgid.tls.msk.ru>
Subject: [Qemu-devel] [PULL 19/31] aux-to-i2c-bridge: don't allow user to
 create one
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: KONRAD Frederic <frederic.konrad@adacore.com>, qemu-trivial@nongnu.org, Michael Tokarev <mjt@tls.msk.ru>

From: KONRAD Frederic <frederic.konrad@adacore.com>

This device is private and is created once per aux-bus.
So don't allow the user to create one from command-line.

Reported-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: KONRAD Frederic <frederic.konrad@adacore.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
---
 hw/misc/auxbus.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/hw/misc/auxbus.c b/hw/misc/auxbus.c
index 8a90ddda84..1182745044 100644
--- a/hw/misc/auxbus.c
+++ b/hw/misc/auxbus.c
@@ -210,6 +210,16 @@ struct AUXTOI2CState {
     I2CBus *i2c_bus;
 };
 
+static void aux_bridge_class_init(ObjectClass *oc, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(oc);
+
+    /* This device is private and is created only once for each
+     * aux-bus in aux_init_bus(..). So don't allow the user to add one.
+     */
+    dc->user_creatable = false;
+}
+
 static void aux_bridge_init(Object *obj)
 {
     AUXTOI2CState *s = AUXTOI2C(obj);
@@ -225,6 +235,7 @@ static inline I2CBus *aux_bridge_get_i2c_bus(AUXTOI2CState *bridge)
 static const TypeInfo aux_to_i2c_type_info = {
     .name = TYPE_AUXTOI2C,
     .parent = TYPE_DEVICE,
+    .class_init = aux_bridge_class_init,
     .instance_size = sizeof(AUXTOI2CState),
     .instance_init = aux_bridge_init
 };
-- 
2.11.0
