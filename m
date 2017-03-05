Received: from eggs.gnu.org ([2001:4830:134:3::10]:51112)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <krzk@kernel.org>) id 1ckdzS-0004om-Ny
	for qemu-devel@nongnu.org; Sun, 05 Mar 2017 16:46:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <krzk@kernel.org>) id 1ckdzP-0006Qb-Il
	for qemu-devel@nongnu.org; Sun, 05 Mar 2017 16:46:54 -0500
Received: from mail.kernel.org ([198.145.29.136]:56642)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <krzk@kernel.org>) id 1ckdzP-0006Or-90
	for qemu-devel@nongnu.org; Sun, 05 Mar 2017 16:46:51 -0500
From: Krzysztof Kozlowski <krzk@kernel.org>
Date: Sun,  5 Mar 2017 23:46:33 +0200
Message-Id: <20170305214633.19844-1-krzk@kernel.org>
Subject: [Qemu-devel] [PATCH] qdev: Constify data pointed by few arguments
 and local variables
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Max Reitz <mreitz@redhat.com>, Markus Armbruster <armbru@redhat.com>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Alex Williamson <alex.williamson@redhat.com>, qemu-devel@nongnu.org
Cc: Krzysztof Kozlowski <krzk@kernel.org>

In few places the function arguments and local variables are not
modifying data passed through pointers so this can be made const for
code safeness.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 hw/core/qdev-properties-system.c |  6 +++---
 hw/core/qdev-properties.c        |  7 ++++---
 include/hw/qdev-properties.h     | 11 +++++++----
 3 files changed, 14 insertions(+), 10 deletions(-)

diff --git a/hw/core/qdev-properties-system.c b/hw/core/qdev-properties-system.c
index c34be1c1bace..abbf3ef754d8 100644
--- a/hw/core/qdev-properties-system.c
+++ b/hw/core/qdev-properties-system.c
@@ -405,7 +405,7 @@ void qdev_prop_set_drive(DeviceState *dev, const char *name,
     if (value) {
         ref = blk_name(value);
         if (!*ref) {
-            BlockDriverState *bs = blk_bs(value);
+            const BlockDriverState *bs = blk_bs(value);
             if (bs) {
                 ref = bdrv_get_node_name(bs);
             }
@@ -416,7 +416,7 @@ void qdev_prop_set_drive(DeviceState *dev, const char *name,
 }
 
 void qdev_prop_set_chr(DeviceState *dev, const char *name,
-                       Chardev *value)
+                       const Chardev *value)
 {
     assert(!value || value->label);
     object_property_set_str(OBJECT(dev),
@@ -424,7 +424,7 @@ void qdev_prop_set_chr(DeviceState *dev, const char *name,
 }
 
 void qdev_prop_set_netdev(DeviceState *dev, const char *name,
-                          NetClientState *value)
+                          const NetClientState *value)
 {
     assert(!value || value->name);
     object_property_set_str(OBJECT(dev),
diff --git a/hw/core/qdev-properties.c b/hw/core/qdev-properties.c
index 6ab4265eb478..34ec10f0caac 100644
--- a/hw/core/qdev-properties.c
+++ b/hw/core/qdev-properties.c
@@ -1010,7 +1010,8 @@ void qdev_prop_set_string(DeviceState *dev, const char *name, const char *value)
     object_property_set_str(OBJECT(dev), value, name, &error_abort);
 }
 
-void qdev_prop_set_macaddr(DeviceState *dev, const char *name, uint8_t *value)
+void qdev_prop_set_macaddr(DeviceState *dev, const char *name,
+                           const uint8_t *value)
 {
     char str[2 * 6 + 5 + 1];
     snprintf(str, sizeof(str), "%02x:%02x:%02x:%02x:%02x:%02x",
@@ -1028,10 +1029,10 @@ void qdev_prop_set_enum(DeviceState *dev, const char *name, int value)
                             name, &error_abort);
 }
 
-void qdev_prop_set_ptr(DeviceState *dev, const char *name, void *value)
+void qdev_prop_set_ptr(DeviceState *dev, const char *name, const void *value)
 {
     Property *prop;
-    void **ptr;
+    const void **ptr;
 
     prop = qdev_prop_find(dev, name);
     assert(prop && prop->info == &qdev_prop_ptr);
diff --git a/include/hw/qdev-properties.h b/include/hw/qdev-properties.h
index 7ac315331aa0..659561daad0d 100644
--- a/include/hw/qdev-properties.h
+++ b/include/hw/qdev-properties.h
@@ -184,14 +184,17 @@ void qdev_prop_set_uint32(DeviceState *dev, const char *name, uint32_t value);
 void qdev_prop_set_int32(DeviceState *dev, const char *name, int32_t value);
 void qdev_prop_set_uint64(DeviceState *dev, const char *name, uint64_t value);
 void qdev_prop_set_string(DeviceState *dev, const char *name, const char *value);
-void qdev_prop_set_chr(DeviceState *dev, const char *name, Chardev *value);
-void qdev_prop_set_netdev(DeviceState *dev, const char *name, NetClientState *value);
+void qdev_prop_set_chr(DeviceState *dev, const char *name,
+                       const Chardev *value);
+void qdev_prop_set_netdev(DeviceState *dev, const char *name,
+                          const NetClientState *value);
 void qdev_prop_set_drive(DeviceState *dev, const char *name,
                          BlockBackend *value, Error **errp);
-void qdev_prop_set_macaddr(DeviceState *dev, const char *name, uint8_t *value);
+void qdev_prop_set_macaddr(DeviceState *dev, const char *name,
+                           const uint8_t *value);
 void qdev_prop_set_enum(DeviceState *dev, const char *name, int value);
 /* FIXME: Remove opaque pointer properties.  */
-void qdev_prop_set_ptr(DeviceState *dev, const char *name, void *value);
+void qdev_prop_set_ptr(DeviceState *dev, const char *name, const void *value);
 
 void qdev_prop_register_global(GlobalProperty *prop);
 void qdev_prop_register_global_list(GlobalProperty *props);
-- 
2.9.3
