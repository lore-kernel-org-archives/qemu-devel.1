Received: from eggs.gnu.org ([2001:4830:134:3::10]:59359)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dQUS1-00048M-Gk
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 04:05:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dQURr-0003PJ-R0
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 04:05:21 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36882)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1dQURr-0003Or-Ih
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 04:05:11 -0400
From: Fam Zheng <famz@redhat.com>
Date: Thu, 29 Jun 2017 16:04:49 +0800
Message-Id: <20170629080452.26470-5-famz@redhat.com>
In-Reply-To: <20170629080452.26470-1-famz@redhat.com>
References: <20170629080452.26470-1-famz@redhat.com>
Subject: [Qemu-devel] [PATCH v2 4/7] qdev: Introduce DEFINE_PROP_LINK
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

This property can be used to replace the object_property_add_link in
device code, to add a link to other objects, which is a common pattern.

Signed-off-by: Fam Zheng <famz@redhat.com>
---
 hw/core/qdev-properties.c    | 16 ++++++++++++++++
 include/hw/qdev-core.h       |  5 +++++
 include/hw/qdev-properties.h | 11 +++++++++++
 3 files changed, 32 insertions(+)

diff --git a/hw/core/qdev-properties.c b/hw/core/qdev-properties.c
index 68cd653..7c11eb8 100644
--- a/hw/core/qdev-properties.c
+++ b/hw/core/qdev-properties.c
@@ -1192,3 +1192,19 @@ PropertyInfo qdev_prop_size = {
     .set = set_size,
     .set_default_value = set_default_value_uint,
 };
+
+/* --- object link property --- */
+
+static void create_link_property(Object *obj, Property *prop, Error **errp)
+{
+    Object **child = qdev_get_prop_ptr(DEVICE(obj), prop);
+
+    object_property_add_link(obj, prop->name, prop->link_type,
+                             child, prop->link.check,
+                             prop->link.flags, errp);
+}
+
+PropertyInfo qdev_prop_link = {
+    .name = "link",
+    .create = create_link_property,
+};
diff --git a/include/hw/qdev-core.h b/include/hw/qdev-core.h
index 33518ee..40afb3d 100644
--- a/include/hw/qdev-core.h
+++ b/include/hw/qdev-core.h
@@ -5,6 +5,7 @@
 #include "qemu/option.h"
 #include "qemu/bitmap.h"
 #include "qom/object.h"
+#include "qom/link-property.h"
 #include "hw/irq.h"
 #include "hw/hotplug.h"
 
@@ -233,6 +234,10 @@ struct Property {
     int          arrayoffset;
     PropertyInfo *arrayinfo;
     int          arrayfieldsize;
+    /* Only @check and @flags are used; @child is unuseful because we need a
+     * dynamic pointer in @obj as derived from @offset. */
+    LinkProperty link;
+    const char   *link_type;
 };
 
 struct PropertyInfo {
diff --git a/include/hw/qdev-properties.h b/include/hw/qdev-properties.h
index 39bf4b2..767c10b 100644
--- a/include/hw/qdev-properties.h
+++ b/include/hw/qdev-properties.h
@@ -30,6 +30,7 @@ extern PropertyInfo qdev_prop_pci_devfn;
 extern PropertyInfo qdev_prop_blocksize;
 extern PropertyInfo qdev_prop_pci_host_devaddr;
 extern PropertyInfo qdev_prop_arraylen;
+extern PropertyInfo qdev_prop_link;
 
 #define DEFINE_PROP(_name, _state, _field, _prop, _type) { \
         .name      = (_name),                                    \
@@ -117,6 +118,16 @@ extern PropertyInfo qdev_prop_arraylen;
         .arrayoffset = offsetof(_state, _arrayfield),                   \
         }
 
+#define DEFINE_PROP_LINK(_name, _state, _field, _type, _check, _flags) {\
+        .name = (_name),                                                \
+        .info = &(qdev_prop_link),                                      \
+        .offset = offsetof(_state, _field)                              \
+            + type_check(Object *, typeof_field(_state, _field)),       \
+        .link.check = _check,                                           \
+        .link.flags = _flags,                                           \
+        .link_type  = _type,                                            \
+        }
+
 #define DEFINE_PROP_UINT8(_n, _s, _f, _d)                       \
     DEFINE_PROP_UNSIGNED(_n, _s, _f, _d, qdev_prop_uint8, uint8_t)
 #define DEFINE_PROP_UINT16(_n, _s, _f, _d)                      \
-- 
2.9.4
