Received: from eggs.gnu.org ([2001:4830:134:3::10]:47229)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dQCPO-0003B7-0x
	for qemu-devel@nongnu.org; Wed, 28 Jun 2017 08:49:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dQCPK-0001Ei-VS
	for qemu-devel@nongnu.org; Wed, 28 Jun 2017 08:49:26 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60484)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1dQCPK-0001EP-Mh
	for qemu-devel@nongnu.org; Wed, 28 Jun 2017 08:49:22 -0400
From: Fam Zheng <famz@redhat.com>
Date: Wed, 28 Jun 2017 20:48:47 +0800
Message-Id: <20170628124850.12821-5-famz@redhat.com>
In-Reply-To: <20170628124850.12821-1-famz@redhat.com>
References: <20170628124850.12821-1-famz@redhat.com>
Subject: [Qemu-devel] [PATCH 4/7] qdev: Introduce DEFINE_PROP_LINK
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, Markus Armbruster <armbru@redhat.com>

This property can be used to replace the object_property_add_link in
device code, to add a link to other objects.

It's implemented by creating a wrapper property that basically forwards
operations to a QOM "link-FOO" property, which handles the check
callback and flags. The feature that is missing from QOM is the dynamic
child pointer which is done in the added code with the usual "offset"
approach.

Signed-off-by: Fam Zheng <famz@redhat.com>
---
 hw/core/qdev-properties.c    | 81 ++++++++++++++++++++++++++++++++++++++++++++
 include/hw/qdev-core.h       |  3 ++
 include/hw/qdev-properties.h | 11 ++++++
 3 files changed, 95 insertions(+)

diff --git a/hw/core/qdev-properties.c b/hw/core/qdev-properties.c
index 68cd653..3801379 100644
--- a/hw/core/qdev-properties.c
+++ b/hw/core/qdev-properties.c
@@ -1192,3 +1192,84 @@ PropertyInfo qdev_prop_size = {
     .set = set_size,
     .set_default_value = set_default_value_uint,
 };
+
+/* --- object link property --- */
+
+static ObjectProperty *link_property_get_or_create(Object *obj, Property *prop,
+                                                   Error **errp)
+{
+    Error *local_err = NULL;
+    Object **child = qdev_get_prop_ptr(DEVICE(obj), prop);
+    char *link_prop_name = g_strdup_printf("link-%s", prop->name);
+    ObjectProperty *op = object_property_find(obj, link_prop_name, NULL);
+
+    if (op) {
+        goto out;
+    }
+    object_property_add_link(obj, link_prop_name, prop->link.type,
+                             child, prop->link.check,
+                             prop->link.flags, &local_err);
+
+    if (local_err) {
+        error_propagate(errp, local_err);
+        goto out;
+    }
+    op = object_property_find(obj, link_prop_name, errp);
+out:
+    g_free(link_prop_name);
+    return op;
+}
+
+static void get_link_property(Object *obj, Visitor *v,
+                              const char *name, void *opaque,
+                              Error **errp)
+{
+    Property *prop = opaque;
+    ObjectProperty *op = link_property_get_or_create(obj, prop, NULL);
+    char *link_prop_name;
+
+    if (!op) {
+        return;
+    }
+    link_prop_name = g_strdup_printf("link-%s", name);
+    object_get_link_property(obj, v, link_prop_name, op->opaque, errp);
+    g_free(link_prop_name);
+}
+
+static void set_link_property(Object *obj, Visitor *v,
+                              const char *name, void *opaque,
+                              Error **errp)
+{
+    Object *target;
+    Property *prop = opaque;
+    Object **link_ptr = qdev_get_prop_ptr(DEVICE(obj), prop);
+    ObjectProperty *op = link_property_get_or_create(obj, prop, errp);
+    char *link_prop_name;
+    Error *local_err = NULL;
+
+    if (!op) {
+        return;
+    }
+
+    link_prop_name = g_strdup_printf("link-%s", name);
+    object_set_link_property(obj, v, link_prop_name, op->opaque, &local_err);
+    if (local_err) {
+        error_propagate(errp, local_err);
+        goto out;
+    }
+    target = object_property_get_link(obj, link_prop_name, &local_err);
+    if (local_err) {
+        error_propagate(errp, local_err);
+        goto out;
+    }
+    *link_ptr = target;
+
+out:
+    g_free(link_prop_name);
+}
+
+PropertyInfo qdev_prop_link = {
+    .name = "link",
+    .get = get_link_property,
+    .set = set_link_property,
+};
diff --git a/include/hw/qdev-core.h b/include/hw/qdev-core.h
index 9d7c1c0..a520226 100644
--- a/include/hw/qdev-core.h
+++ b/include/hw/qdev-core.h
@@ -233,6 +233,9 @@ struct Property {
     int          arrayoffset;
     PropertyInfo *arrayinfo;
     int          arrayfieldsize;
+    /* Only @check and @flags are used; @child is unuseful because we need a
+     * dynamic pointer in @obj as derived from @offset. */
+    LinkProperty link;
 };
 
 struct PropertyInfo {
diff --git a/include/hw/qdev-properties.h b/include/hw/qdev-properties.h
index 39bf4b2..c9ccc9e 100644
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
+        .link.type  = _type,                                            \
+        }
+
 #define DEFINE_PROP_UINT8(_n, _s, _f, _d)                       \
     DEFINE_PROP_UNSIGNED(_n, _s, _f, _d, qdev_prop_uint8, uint8_t)
 #define DEFINE_PROP_UINT16(_n, _s, _f, _d)                      \
-- 
2.9.4
