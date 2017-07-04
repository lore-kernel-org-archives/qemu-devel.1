Received: from eggs.gnu.org ([2001:4830:134:3::10]:41582)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dSHZ2-0003qQ-1K
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 02:44:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dSHZ1-0002wl-5T
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 02:43:59 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49546)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1dSHZ0-0002w4-Rs
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 02:43:59 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id C83CEC0587FA
	for <qemu-devel@nongnu.org>; Tue,  4 Jul 2017 06:43:57 +0000 (UTC)
From: Fam Zheng <famz@redhat.com>
Date: Tue,  4 Jul 2017 14:43:30 +0800
Message-Id: <20170704064347.7022-4-famz@redhat.com>
In-Reply-To: <20170704064347.7022-1-famz@redhat.com>
References: <20170704064347.7022-1-famz@redhat.com>
Subject: [Qemu-devel] [PATCH v3 03/20] qdev: Introduce DEFINE_PROP_LINK
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>

This property can be used to replace the object_property_add_link in
device code, to add a link to other objects, which is a common pattern.

Signed-off-by: Fam Zheng <famz@redhat.com>
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
index 9edded2..b150378 100644
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
 
+#define DEFINE_PROP_LINK(_name, _state, _field, _type) {\
+        .name = (_name),                                                \
+        .info = &(qdev_prop_link),                                      \
+        .offset = offsetof(_state, _field)                              \
+            + type_check(Object *, typeof_field(_state, _field)),       \
+        .link_type  = _type,                                            \
+        }
+
 #define DEFINE_PROP_UINT8(_n, _s, _f, _d)                       \
     DEFINE_PROP_UNSIGNED(_n, _s, _f, _d, qdev_prop_uint8, uint8_t)
 #define DEFINE_PROP_UINT16(_n, _s, _f, _d)                      \
-- 
2.9.4
