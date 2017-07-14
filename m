Received: from eggs.gnu.org ([2001:4830:134:3::10]:42406)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1dVxYY-0000En-3i
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 06:10:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1dVxYW-00050L-VR
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 06:10:42 -0400
Received: from mail-wr0-x241.google.com ([2a00:1450:400c:c0c::241]:33580)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1dVxYW-0004zo-BN
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 06:10:40 -0400
Received: by mail-wr0-x241.google.com with SMTP id g46so1016325wrd.0
	for <qemu-devel@nongnu.org>; Fri, 14 Jul 2017 03:10:40 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Fri, 14 Jul 2017 12:10:17 +0200
Message-Id: <1500027028-4127-6-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1500027028-4127-1-git-send-email-pbonzini@redhat.com>
References: <1500027028-4127-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 44/55] qdev: Introduce DEFINE_PROP_LINK
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

This property can be used to replace the object_property_add_link in
device code, to add a link to other objects, which is a common pattern.

Signed-off-by: Fam Zheng <famz@redhat.com>
Message-Id: <20170714021509.23681-4-famz@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/core/qdev-properties.c    | 18 ++++++++++++++++++
 include/hw/qdev-core.h       |  1 +
 include/hw/qdev-properties.h |  9 +++++++++
 3 files changed, 28 insertions(+)

diff --git a/hw/core/qdev-properties.c b/hw/core/qdev-properties.c
index 113ce7d..5429c63 100644
--- a/hw/core/qdev-properties.c
+++ b/hw/core/qdev-properties.c
@@ -1214,3 +1214,21 @@ PropertyInfo qdev_prop_size = {
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
+                             child,
+                             qdev_prop_allow_set_link_before_realize,
+                             OBJ_PROP_LINK_UNREF_ON_RELEASE,
+                             errp);
+}
+
+PropertyInfo qdev_prop_link = {
+    .name = "link",
+    .create = create_link_property,
+};
diff --git a/include/hw/qdev-core.h b/include/hw/qdev-core.h
index 33518ee..08d1d2c 100644
--- a/include/hw/qdev-core.h
+++ b/include/hw/qdev-core.h
@@ -233,6 +233,7 @@ struct Property {
     int          arrayoffset;
     PropertyInfo *arrayinfo;
     int          arrayfieldsize;
+    const char   *link_type;
 };
 
 struct PropertyInfo {
diff --git a/include/hw/qdev-properties.h b/include/hw/qdev-properties.h
index 9edded2..876ba2e 100644
--- a/include/hw/qdev-properties.h
+++ b/include/hw/qdev-properties.h
@@ -30,6 +30,7 @@ extern PropertyInfo qdev_prop_pci_devfn;
 extern PropertyInfo qdev_prop_blocksize;
 extern PropertyInfo qdev_prop_pci_host_devaddr;
 extern PropertyInfo qdev_prop_arraylen;
+extern PropertyInfo qdev_prop_link;
 
 #define DEFINE_PROP(_name, _state, _field, _prop, _type) { \
         .name      = (_name),                                    \
@@ -117,6 +118,14 @@ extern PropertyInfo qdev_prop_arraylen;
         .arrayoffset = offsetof(_state, _arrayfield),                   \
         }
 
+#define DEFINE_PROP_LINK(_name, _state, _field, _type, _ptr_type) {     \
+        .name = (_name),                                                \
+        .info = &(qdev_prop_link),                                      \
+        .offset = offsetof(_state, _field)                              \
+            + type_check(_ptr_type, typeof_field(_state, _field)),      \
+        .link_type  = _type,                                            \
+        }
+
 #define DEFINE_PROP_UINT8(_n, _s, _f, _d)                       \
     DEFINE_PROP_UNSIGNED(_n, _s, _f, _d, qdev_prop_uint8, uint8_t)
 #define DEFINE_PROP_UINT16(_n, _s, _f, _d)                      \
-- 
1.8.3.1
