Received: from eggs.gnu.org ([2001:4830:134:3::10]:58825)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <janne.huttunen@nokia.com>) id 1cnqCe-00035V-VN
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 13:25:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <janne.huttunen@nokia.com>) id 1cnqCb-0006OO-1l
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 13:25:45 -0400
Received: from mail-he1eur01on0131.outbound.protection.outlook.com
	([104.47.0.131]:23108
	helo=EUR01-HE1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <janne.huttunen@nokia.com>)
	id 1cnqCa-0006MT-DC
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 13:25:40 -0400
From: Janne Huttunen <janne.huttunen@nokia.com>
Date: Tue, 14 Mar 2017 14:50:09 +0200
Message-ID: <b2cf1008ef518efeecd539d2481d1a255b27c7d5.1489494746.git.janne.huttunen@nokia.com>
In-Reply-To: <cover.1489494746.git.janne.huttunen@nokia.com>
References: <cover.1489494746.git.janne.huttunen@nokia.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [RFC][PATCH 2/6] Re-factor bootdevice list handling,
 pt2.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: janne.huttunen@nokia.com

Store the list head into the property structure. This allows the callback
functions to access the correct list even when there are multiple lists.

Signed-off-by: Janne Huttunen <janne.huttunen@nokia.com>
---
 bootdevice.c | 36 ++++++++++++++++++++++++------------
 1 file changed, 24 insertions(+), 12 deletions(-)

diff --git a/bootdevice.c b/bootdevice.c
index a29d43b..30e98ae 100644
--- a/bootdevice.c
+++ b/bootdevice.c
@@ -33,6 +33,13 @@
 typedef struct FWBootEntry FWBootEntry;
 typedef QTAILQ_HEAD(, FWBootEntry) FWBootList;
 
+typedef struct {
+    FWBootList *bootlist;
+    int32_t *bootindex;
+    const char *suffix;
+    DeviceState *dev;
+} BootIndexProperty;
+
 struct FWBootEntry {
     QTAILQ_ENTRY(FWBootEntry) link;
     int32_t bootindex;
@@ -288,12 +295,6 @@ char *get_boot_devices_list(size_t *size, bool ignore_suffixes)
     return list;
 }
 
-typedef struct {
-    int32_t *bootindex;
-    const char *suffix;
-    DeviceState *dev;
-} BootIndexProperty;
-
 static void device_get_bootindex(Object *obj, Visitor *v, const char *name,
                                  void *opaque, Error **errp)
 {
@@ -313,14 +314,15 @@ static void device_set_bootindex(Object *obj, Visitor *v, const char *name,
         goto out;
     }
     /* check whether bootindex is present in fw_boot_order list  */
-    check_boot_index(boot_index, &local_err);
+    do_check_boot_index(prop->bootlist, boot_index, &local_err);
     if (local_err) {
         goto out;
     }
     /* change bootindex to a new one */
     *prop->bootindex = boot_index;
 
-    add_boot_device_path(*prop->bootindex, prop->dev, prop->suffix);
+    do_add_boot_device_path(prop->bootlist, *prop->bootindex,
+                            prop->dev, prop->suffix);
 
 out:
     error_propagate(errp, local_err);
@@ -332,17 +334,19 @@ static void property_release_bootindex(Object *obj, const char *name,
 {
     BootIndexProperty *prop = opaque;
 
-    del_boot_device_path(prop->dev, prop->suffix);
+    do_del_boot_device_path(prop->bootlist, prop->dev, prop->suffix);
     g_free(prop);
 }
 
-void device_add_bootindex_property(Object *obj, int32_t *bootindex,
-                                   const char *name, const char *suffix,
-                                   DeviceState *dev, Error **errp)
+static void do_add_bootindex_prop(FWBootList *bootlist,
+                                  Object *obj, int32_t *bootindex,
+                                  const char *name, const char *suffix,
+                                  DeviceState *dev, Error **errp)
 {
     Error *local_err = NULL;
     BootIndexProperty *prop = g_malloc0(sizeof(*prop));
 
+    prop->bootlist = bootlist;
     prop->bootindex = bootindex;
     prop->suffix = suffix;
     prop->dev = dev;
@@ -361,3 +365,11 @@ void device_add_bootindex_property(Object *obj, int32_t *bootindex,
     /* initialize devices' bootindex property to -1 */
     object_property_set_int(obj, -1, name, NULL);
 }
+
+void device_add_bootindex_property(Object *obj, int32_t *bootindex,
+                                   const char *name, const char *suffix,
+                                   DeviceState *dev, Error **errp)
+{
+    do_add_bootindex_prop(&fw_boot_order, obj, bootindex,
+                          name, suffix, dev, errp);
+}
-- 
2.7.4
