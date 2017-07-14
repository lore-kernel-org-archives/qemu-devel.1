Received: from eggs.gnu.org ([2001:4830:134:3::10]:42364)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1dVxYW-0000Ch-0Y
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 06:10:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1dVxYU-0004z5-T1
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 06:10:39 -0400
Received: from mail-wr0-x241.google.com ([2a00:1450:400c:c0c::241]:35202)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1dVxYU-0004yg-MH
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 06:10:38 -0400
Received: by mail-wr0-x241.google.com with SMTP id y28so6807203wrd.2
	for <qemu-devel@nongnu.org>; Fri, 14 Jul 2017 03:10:38 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Fri, 14 Jul 2017 12:10:16 +0200
Message-Id: <1500027028-4127-5-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1500027028-4127-1-git-send-email-pbonzini@redhat.com>
References: <1500027028-4127-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 43/55] qdev: Introduce PropertyInfo.create
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Fam Zheng <famz@redhat.com>

From: Fam Zheng <famz@redhat.com>

This allows property implementation to provide a specialized property
creation method.

Update conditions guarding property types accordingly.

Signed-off-by: Fam Zheng <famz@redhat.com>
Message-Id: <20170714021509.23681-3-famz@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/core/qdev.c         | 31 +++++++++++++++++++------------
 include/hw/qdev-core.h |  1 +
 qmp.c                  |  2 +-
 3 files changed, 21 insertions(+), 13 deletions(-)

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
diff --git a/qmp.c b/qmp.c
index 84a4f29..e6b68fe 100644
--- a/qmp.c
+++ b/qmp.c
@@ -480,7 +480,7 @@ static DevicePropertyInfo *make_device_property_info(ObjectClass *klass,
              * for removal.  This conditional should be removed along with
              * it.
              */
-            if (!prop->info->set) {
+            if (!prop->info->set && !prop->info->create) {
                 return NULL;           /* no way to set it, don't show */
             }
 
-- 
1.8.3.1
