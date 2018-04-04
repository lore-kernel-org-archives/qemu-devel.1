Received: from eggs.gnu.org ([2001:4830:134:3::10]:45735)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1f3m5P-0000t4-VX
	for qemu-devel@nongnu.org; Wed, 04 Apr 2018 13:20:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1f3m5O-0000oa-Qa
	for qemu-devel@nongnu.org; Wed, 04 Apr 2018 13:20:39 -0400
From: Thomas Huth <thuth@redhat.com>
Date: Wed,  4 Apr 2018 19:20:20 +0200
Message-Id: <1522862420-7484-1-git-send-email-thuth@redhat.com>
Subject: [Qemu-devel] [PATCH for-2.12] hw/arm/allwinner-a10: Do not use
 nd_table in instance_init function
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Beniamino Galvani <b.galvani@gmail.com>, Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org

The instance_init function of a device can be called at any time, even
if the device is not going to be used (i.e. not going to be realized).
So a instance_init function must not do things that could cause QEMU
to exit, like calling qemu_check_nic_model(&nd_table[0], ...) for example.
But this is what the instance_init function of the allwinner-a10 device
is currently doing - and this causes QEMU to quit unexpectedly when
you run the 'device-list-properties' QMP command for example:

$ echo "{'execute':'qmp_capabilities'}"\
       "{'execute':'device-list-properties',"\
       " 'arguments':{'typename':'allwinner-a10'}}" \
       | arm-softmmu/qemu-system-arm -M mps2-an505,accel=qtest -qmp stdio
{"QMP": {"version": {"qemu": {"micro": 91, "minor": 11, "major": 2},
 "package": "build-all"}, "capabilities": []}}
{"return": {}}
Unsupported NIC model: lan9118

... and QEMU quits after printing the last line (which should not happen
just because of running 'device-list-properties' here).

And with the cubieboard, this even causes QEMU to abort():

$ echo "{'execute':'qmp_capabilities'}"\
       "{'execute':'device-list-properties',"\
       " 'arguments':{'typename':'allwinner-a10'}}" \
       | arm-softmmu/qemu-system-arm -M cubieboard,accel=qtest -qmp stdio
{"QMP": {"version": {"qemu": {"micro": 91, "minor": 11, "major": 2},
 "package": "build-all"}, "capabilities": []}}
{"return": {}}
Unexpected error in error_set_from_qdev_prop_error() at hw/core/qdev-properties.c:1095:
Property 'allwinner-emac.netdev' can't take value 'hub0port0', it's in use
Aborted (core dumped)

To fix the problem we've got to move the offending code to the realize
function instead.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 I know, an even cleaner fix would likely be to remove serial_hds and
 nd_table from the device completely and wire it up from the board code
 instead - but that's a major rework compared to this simple fix here,
 which we likely should avoid at this point in time of the hard freeze
 period.

 hw/arm/allwinner-a10.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/hw/arm/allwinner-a10.c b/hw/arm/allwinner-a10.c
index 43a3f01..5dbbacb 100644
--- a/hw/arm/allwinner-a10.c
+++ b/hw/arm/allwinner-a10.c
@@ -38,11 +38,6 @@ static void aw_a10_init(Object *obj)
 
     object_initialize(&s->emac, sizeof(s->emac), TYPE_AW_EMAC);
     qdev_set_parent_bus(DEVICE(&s->emac), sysbus_get_default());
-    /* FIXME use qdev NIC properties instead of nd_table[] */
-    if (nd_table[0].used) {
-        qemu_check_nic_model(&nd_table[0], TYPE_AW_EMAC);
-        qdev_set_nic_properties(DEVICE(&s->emac), &nd_table[0]);
-    }
 
     object_initialize(&s->sata, sizeof(s->sata), TYPE_ALLWINNER_AHCI);
     qdev_set_parent_bus(DEVICE(&s->sata), sysbus_get_default());
@@ -91,6 +86,11 @@ static void aw_a10_realize(DeviceState *dev, Error **errp)
     sysbus_connect_irq(sysbusdev, 4, s->irq[67]);
     sysbus_connect_irq(sysbusdev, 5, s->irq[68]);
 
+    /* FIXME use qdev NIC properties instead of nd_table[] */
+    if (nd_table[0].used) {
+        qemu_check_nic_model(&nd_table[0], TYPE_AW_EMAC);
+        qdev_set_nic_properties(DEVICE(&s->emac), &nd_table[0]);
+    }
     object_property_set_bool(OBJECT(&s->emac), true, "realized", &err);
     if (err != NULL) {
         error_propagate(errp, err);
@@ -118,7 +118,7 @@ static void aw_a10_class_init(ObjectClass *oc, void *data)
     DeviceClass *dc = DEVICE_CLASS(oc);
 
     dc->realize = aw_a10_realize;
-    /* Reason: Uses serial_hds in realize and nd_table in instance_init */
+    /* Reason: Uses serial_hds and nd_table in realize function */
     dc->user_creatable = false;
 }
 
-- 
1.8.3.1
