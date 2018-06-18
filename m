Received: from eggs.gnu.org ([2001:4830:134:3::10]:44106)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1fUyEK-0002RC-S8
	for qemu-devel@nongnu.org; Mon, 18 Jun 2018 13:46:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1fUyEJ-0004m3-Ck
	for qemu-devel@nongnu.org; Mon, 18 Jun 2018 13:46:16 -0400
Received: from chuckie.co.uk ([82.165.15.123]:45020
	helo=s16892447.onlinehome-server.info)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mark.cave-ayland@ilande.co.uk>)
	id 1fUyEJ-0004fa-4l
	for qemu-devel@nongnu.org; Mon, 18 Jun 2018 13:46:15 -0400
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Date: Mon, 18 Jun 2018 18:45:36 +0100
Message-Id: <20180618174538.30092-2-mark.cave-ayland@ilande.co.uk>
In-Reply-To: <20180618174538.30092-1-mark.cave-ayland@ilande.co.uk>
References: <20180618174538.30092-1-mark.cave-ayland@ilande.co.uk>
Subject: [Qemu-devel] [PULL 1/3] hw/sparc64/sun4u: Fix introspection by
 converting prom instance_init to realize
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, peter.maydell@linaro.org

From: Thomas Huth <thuth@redhat.com>

The instance_init function of devices should always succeed to be able
to introspect the device. However, the instance_init function of the
"openprom" device can currently fail, for example like this:

$ echo "{'execute':'qmp_capabilities'}"\
       "{'execute':'device-list-properties',"\
       " 'arguments':{'typename':'openprom'}}" \
       | sparc64-softmmu/qemu-system-sparc64 -M sun4v,accel=qtest -qmp stdio
{"QMP": {"version": {"qemu": {"micro": 91, "minor": 11, "major": 2},
 "package": "build-all"}, "capabilities": []}}
{"return": {}}
RAMBlock "sun4u.prom" already registered, abort!
Aborted (core dumped)

This should not happen. Fix this problem by moving the affected code from
instance_init into a realize function instead.

Signed-off-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
---
 hw/sparc64/sun4u.c | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/hw/sparc64/sun4u.c b/hw/sparc64/sun4u.c
index 1bede85370..3975a7b65a 100644
--- a/hw/sparc64/sun4u.c
+++ b/hw/sparc64/sun4u.c
@@ -425,13 +425,19 @@ static void prom_init(hwaddr addr, const char *bios_name)
     }
 }
 
-static void prom_init1(Object *obj)
+static void prom_realize(DeviceState *ds, Error **errp)
 {
-    PROMState *s = OPENPROM(obj);
-    SysBusDevice *dev = SYS_BUS_DEVICE(obj);
+    PROMState *s = OPENPROM(ds);
+    SysBusDevice *dev = SYS_BUS_DEVICE(ds);
+    Error *local_err = NULL;
+
+    memory_region_init_ram_nomigrate(&s->prom, OBJECT(ds), "sun4u.prom",
+                                     PROM_SIZE_MAX, &local_err);
+    if (local_err) {
+        error_propagate(errp, local_err);
+        return;
+    }
 
-    memory_region_init_ram_nomigrate(&s->prom, obj, "sun4u.prom", PROM_SIZE_MAX,
-                           &error_fatal);
     vmstate_register_ram_global(&s->prom);
     memory_region_set_readonly(&s->prom, true);
     sysbus_init_mmio(dev, &s->prom);
@@ -446,6 +452,7 @@ static void prom_class_init(ObjectClass *klass, void *data)
     DeviceClass *dc = DEVICE_CLASS(klass);
 
     dc->props = prom_properties;
+    dc->realize = prom_realize;
 }
 
 static const TypeInfo prom_info = {
@@ -453,7 +460,6 @@ static const TypeInfo prom_info = {
     .parent        = TYPE_SYS_BUS_DEVICE,
     .instance_size = sizeof(PROMState),
     .class_init    = prom_class_init,
-    .instance_init = prom_init1,
 };
 
 
-- 
2.11.0
