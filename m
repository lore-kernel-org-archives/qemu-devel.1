Received: from eggs.gnu.org ([2001:4830:134:3::10]:37513)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1exvLT-0007VX-9m
	for qemu-devel@nongnu.org; Mon, 19 Mar 2018 10:01:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1exvLO-00059w-FL
	for qemu-devel@nongnu.org; Mon, 19 Mar 2018 10:01:03 -0400
From: Thomas Huth <thuth@redhat.com>
Date: Mon, 19 Mar 2018 15:00:46 +0100
Message-Id: <1521468046-10400-1-git-send-email-thuth@redhat.com>
Subject: [Qemu-devel] [PATCH for-2.12] hw/misc/macio: Fix crash when listing
 device properties of macio device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, David Gibson <david@gibson.dropbear.id.au>
Cc: qemu-ppc@nongnu.org, Alexander Graf <agraf@suse.de>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>

The macio-newworld device can currently be used to abort QEMU unexpectedly:

$ ppc-softmmu/qemu-system-ppc -S -M ref405ep,accel=qtest -qmp stdio
{"QMP": {"version": {"qemu": {"micro": 50, "minor": 11, "major": 2},
 "package": "build-all"}, "capabilities": []}}
{ 'execute': 'qmp_capabilities' }
{"return": {}}
{ 'execute': 'device-list-properties',
  'arguments': {'typename': 'macio-newworld'}}
Unexpected error in qemu_chr_fe_init() at chardev/char-fe.c:222:
Device 'serial0' is in use
Aborted (core dumped)

qdev properties should be set during realize(), not during instance_init(),
so move the related code there to fix this problem.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 hw/misc/macio/macio.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/hw/misc/macio/macio.c b/hw/misc/macio/macio.c
index 454244f..b74a657 100644
--- a/hw/misc/macio/macio.c
+++ b/hw/misc/macio/macio.c
@@ -115,6 +115,13 @@ static void macio_common_realize(PCIDevice *d, Error **errp)
     memory_region_add_subregion(&s->bar, 0x16000,
                                 sysbus_mmio_get_region(sysbus_dev, 0));
 
+    qdev_prop_set_uint32(DEVICE(&s->escc), "disabled", 0);
+    qdev_prop_set_uint32(DEVICE(&s->escc), "frequency", ESCC_CLOCK);
+    qdev_prop_set_uint32(DEVICE(&s->escc), "it_shift", 4);
+    qdev_prop_set_chr(DEVICE(&s->escc), "chrA", serial_hds[0]);
+    qdev_prop_set_chr(DEVICE(&s->escc), "chrB", serial_hds[1]);
+    qdev_prop_set_uint32(DEVICE(&s->escc), "chnBtype", escc_serial);
+    qdev_prop_set_uint32(DEVICE(&s->escc), "chnAtype", escc_serial);
     object_property_set_bool(OBJECT(&s->escc), true, "realized", &err);
     if (err) {
         error_propagate(errp, err);
@@ -341,13 +348,6 @@ static void macio_instance_init(Object *obj)
     object_property_add_child(obj, "dbdma", OBJECT(&s->dbdma), NULL);
 
     object_initialize(&s->escc, sizeof(s->escc), TYPE_ESCC);
-    qdev_prop_set_uint32(DEVICE(&s->escc), "disabled", 0);
-    qdev_prop_set_uint32(DEVICE(&s->escc), "frequency", ESCC_CLOCK);
-    qdev_prop_set_uint32(DEVICE(&s->escc), "it_shift", 4);
-    qdev_prop_set_chr(DEVICE(&s->escc), "chrA", serial_hds[0]);
-    qdev_prop_set_chr(DEVICE(&s->escc), "chrB", serial_hds[1]);
-    qdev_prop_set_uint32(DEVICE(&s->escc), "chnBtype", escc_serial);
-    qdev_prop_set_uint32(DEVICE(&s->escc), "chnAtype", escc_serial);
     qdev_set_parent_bus(DEVICE(&s->escc), sysbus_get_default());
     object_property_add_child(obj, "escc", OBJECT(&s->escc), NULL);
 }
-- 
1.8.3.1
