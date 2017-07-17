Received: from eggs.gnu.org ([2001:4830:134:3::10]:34396)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dXB6k-0003EO-Np
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 14:51:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dXB6j-0003aV-KD
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 14:51:02 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42792)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1dXB6j-0003Zf-AJ
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 14:51:01 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Mon, 17 Jul 2017 15:50:39 -0300
Message-Id: <20170717185051.18740-4-ehabkost@redhat.com>
In-Reply-To: <20170717185051.18740-1-ehabkost@redhat.com>
References: <20170717185051.18740-1-ehabkost@redhat.com>
Subject: [Qemu-devel] [PULL 03/15] qdev: fix the order compat and global
 properties are applied
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, Greg Kurz <groug@kaod.org>

From: Greg Kurz <groug@kaod.org>

The current code recursively applies global properties from child up to
parent types. This can cause properties passed with the -global option to
be silently overridden by internal compat properties.

This is exactly what happened with virtio-*-pci drivers since commit:

"9a4c0e220d8a hw/virtio-pci: fix virtio behaviour"

Passing -device virtio-blk-pci.disable-modern=off had no effect on 2.6
machine types because the internal virtio-pci.disable-modern=on compat
property always prevailed.

A workaround for this was included with commit 0bcba41f ("machine:
Convert abstract typename on compat_props to subclass names").

This patch fixes the issue properly by reversing the logic: we now go
through the global property list and, for each property, we check if it
is applicable to the device.

This results in compat properties being applied first, in the order they
appear in the HW_COMPAT_* macros, followed by global properties, in the
order they appear on the command line.

Signed-off-by: Greg Kurz <groug@kaod.org>
Message-Id: <148103887228.22326.478406873609299999.stgit@bahia.lab.toulouse-stg.fr.ibm.com>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
Message-Id: <20170711004303.3902-2-ehabkost@redhat.com>
Reviewed-by: Cornelia Huck <cohuck@redhat.com>
Reviewed-by: Halil Pasic <pasic@linux.vnet.ibm.com>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 hw/core/qdev-properties.c | 15 ++-------------
 1 file changed, 2 insertions(+), 13 deletions(-)

diff --git a/hw/core/qdev-properties.c b/hw/core/qdev-properties.c
index dcecdf0..58a8f92 100644
--- a/hw/core/qdev-properties.c
+++ b/hw/core/qdev-properties.c
@@ -1149,8 +1149,7 @@ int qdev_prop_check_globals(void)
     return ret;
 }
 
-static void qdev_prop_set_globals_for_type(DeviceState *dev,
-                                           const char *typename)
+void qdev_prop_set_globals(DeviceState *dev)
 {
     GList *l;
 
@@ -1158,7 +1157,7 @@ static void qdev_prop_set_globals_for_type(DeviceState *dev,
         GlobalProperty *prop = l->data;
         Error *err = NULL;
 
-        if (strcmp(typename, prop->driver) != 0) {
+        if (object_dynamic_cast(OBJECT(dev), prop->driver) == NULL) {
             continue;
         }
         prop->used = true;
@@ -1176,16 +1175,6 @@ static void qdev_prop_set_globals_for_type(DeviceState *dev,
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
