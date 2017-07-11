Received: from eggs.gnu.org ([2001:4830:134:3::10]:55499)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dUjGl-0004hG-Ow
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 20:43:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dUjGk-0007nr-2I
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 20:43:15 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53346)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1dUjGj-0007nh-S7
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 20:43:13 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Mon, 10 Jul 2017 21:43:01 -0300
Message-Id: <20170711004303.3902-2-ehabkost@redhat.com>
In-Reply-To: <20170711004303.3902-1-ehabkost@redhat.com>
References: <20170711004303.3902-1-ehabkost@redhat.com>
Subject: [Qemu-devel] [PATCH 1/3] qdev: fix the order compat and global
 properties are applied
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Marcel Apfelbaum <marcel@redhat.com>, Halil Pasic <pasic@linux.vnet.ibm.com>, Cornelia Huck <cohuck@redhat.com>, Greg Kurz <groug@kaod.org>

From: Greg Kurz <groug@kaod.org>

The current code recursively applies global properties from child up to
parent types. This can cause properties passed with the -global option to
be silently overridden by internal compat properties.

This is exactly what happens with virtio-*-pci drivers since commit:

"9a4c0e220d8a hw/virtio-pci: fix virtio behaviour"

Passing -device virtio-blk-pci.disable-modern=off has no effect on 2.6
machine types because the internal virtio-pci.disable-modern=on compat
property always prevail.

This patch fixes the issue by reversing the logic: we now go through the
global property list and, for each property, we check if it is applicable
to the device.

This result in compat properties being applied first, in the order they
appear in the HW_COMPAT_* macros, followed by global properties, in they
order appear on the command line.

Signed-off-by: Greg Kurz <groug@kaod.org>
Message-Id: <148103887228.22326.478406873609299999.stgit@bahia.lab.toulouse-stg.fr.ibm.com>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 hw/core/qdev-properties.c | 15 ++-------------
 1 file changed, 2 insertions(+), 13 deletions(-)

diff --git a/hw/core/qdev-properties.c b/hw/core/qdev-properties.c
index f11d578..41cca9d 100644
--- a/hw/core/qdev-properties.c
+++ b/hw/core/qdev-properties.c
@@ -1148,8 +1148,7 @@ int qdev_prop_check_globals(void)
     return ret;
 }
 
-static void qdev_prop_set_globals_for_type(DeviceState *dev,
-                                           const char *typename)
+void qdev_prop_set_globals(DeviceState *dev)
 {
     GList *l;
 
@@ -1157,7 +1156,7 @@ static void qdev_prop_set_globals_for_type(DeviceState *dev,
         GlobalProperty *prop = l->data;
         Error *err = NULL;
 
-        if (strcmp(typename, prop->driver) != 0) {
+        if (object_dynamic_cast(OBJECT(dev), prop->driver) == NULL) {
             continue;
         }
         prop->used = true;
@@ -1175,16 +1174,6 @@ static void qdev_prop_set_globals_for_type(DeviceState *dev,
     }
 }
 
-void qdev_prop_set_globals(DeviceState *dev)
-{
-    ObjectClass *class = object_get_class(OBJECT(dev));
-
-    do {
-        qdev_prop_set_globals_for_type(dev, object_class_get_name(class));
-        class = object_class_get_parent(class);
-    } while (class);
-}
-
 /* --- 64bit unsigned int 'size' type --- */
 
 static void get_size(Object *obj, Visitor *v, const char *name, void *opaque,
-- 
2.9.4
