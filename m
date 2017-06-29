Received: from eggs.gnu.org ([2001:4830:134:3::10]:59285)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dQURs-00042z-Av
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 04:05:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dQURp-0003NR-0s
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 04:05:12 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58142)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1dQURo-0003Mg-OI
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 04:05:08 -0400
From: Fam Zheng <famz@redhat.com>
Date: Thu, 29 Jun 2017 16:04:48 +0800
Message-Id: <20170629080452.26470-4-famz@redhat.com>
In-Reply-To: <20170629080452.26470-1-famz@redhat.com>
References: <20170629080452.26470-1-famz@redhat.com>
Subject: [Qemu-devel] [PATCH v2 3/7] qdev: Introduce PropertyInfo.create
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: "Dr . David Alan Gilbert" <dgilbert@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>, Markus Armbruster <armbru@redhat.com>

This allows property implementation to provide a specialized property
creation method.

Update conditions guarding property types accordingly.

Signed-off-by: Fam Zheng <famz@redhat.com>
---
 hw/core/qdev.c         | 31 +++++++++++++++++++------------
 include/hw/qdev-core.h |  1 +
 2 files changed, 20 insertions(+), 12 deletions(-)

diff --git a/hw/core/qdev.c b/hw/core/qdev.c
index 849952a..ec63fe0 100644
--- a/hw/core/qdev.c
+++ b/hw/core/qdev.c
@@ -744,6 +744,10 @@ static void qdev_property_add_legacy(DeviceState *dev, Property *prop,
         return;
     }
 
+    if (prop->info->create) {
+        return;
+    }
+
     name = g_strdup_printf("legacy-%s", prop->name);
     object_property_add(OBJECT(dev), name, "str",
                         prop->info->print ? qdev_get_legacy_property : prop->info->get,
@@ -770,20 +774,23 @@ void qdev_property_add_static(DeviceState *dev, Property *prop,
     Error *local_err = NULL;
     Object *obj = OBJECT(dev);
 
-    /*
-     * TODO qdev_prop_ptr does not have getters or setters.  It must
-     * go now that it can be replaced with links.  The test should be
-     * removed along with it: all static properties are read/write.
-     */
-    if (!prop->info->get && !prop->info->set) {
-        return;
+    if (prop->info->create) {
+        prop->info->create(obj, prop, &local_err);
+    } else {
+        /*
+         * TODO qdev_prop_ptr does not have getters or setters.  It must
+         * go now that it can be replaced with links.  The test should be
+         * removed along with it: all static properties are read/write.
+         */
+        if (!prop->info->get && !prop->info->set) {
+            return;
+        }
+        object_property_add(obj, prop->name, prop->info->name,
+                            prop->info->get, prop->info->set,
+                            prop->info->release,
+                            prop, &local_err);
     }
 
-    object_property_add(obj, prop->name, prop->info->name,
-                        prop->info->get, prop->info->set,
-                        prop->info->release,
-                        prop, &local_err);
-
     if (local_err) {
         error_propagate(errp, local_err);
         return;
diff --git a/include/hw/qdev-core.h b/include/hw/qdev-core.h
index 9d7c1c0..33518ee 100644
--- a/include/hw/qdev-core.h
+++ b/include/hw/qdev-core.h
@@ -241,6 +241,7 @@ struct PropertyInfo {
     const char * const *enum_table;
     int (*print)(DeviceState *dev, Property *prop, char *dest, size_t len);
     void (*set_default_value)(Object *obj, const Property *prop);
+    void (*create)(Object *obj, Property *prop, Error **errp);
     ObjectPropertyAccessor *get;
     ObjectPropertyAccessor *set;
     ObjectPropertyRelease *release;
-- 
2.9.4
