Received: from eggs.gnu.org ([2001:4830:134:3::10]:59218)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1dX5Oi-00081L-5t
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 08:45:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1dX5Oh-0002LR-1H
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 08:45:12 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:37639)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1dX5Og-00029H-Oh
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 08:45:10 -0400
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.84_2)
	(envelope-from <pm215@archaic.org.uk>) id 1dX5OS-0003Rl-52
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 13:44:56 +0100
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 17 Jul 2017 13:44:38 +0100
Message-Id: <1500295494-8991-3-git-send-email-peter.maydell@linaro.org>
In-Reply-To: <1500295494-8991-1-git-send-email-peter.maydell@linaro.org>
References: <1500295494-8991-1-git-send-email-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 02/18] qdev: support properties which don't set
 a default value
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

In some situations it's useful to have a qdev property which doesn't
automatically set its default value when qdev_property_add_static is
called (for instance when the default value is not constant).

Support this by adding a flag to the Property struct indicating
whether to set the default value.  This replaces the existing test
for whether the PropertyInfo set_default_value function pointer is
NULL, and we set the .set_default field to true for all those cases
of struct Property which use a PropertyInfo with a non-NULL
set_default_value, so behaviour remains the same as before.

This gives us the semantics of:
 * if .set_default is true, then .info->set_default_value must
   be not NULL, and .defval is used as the the default value of
   the property
 * otherwise, the property system does not set any default, and
   the field will retain whatever initial value it was given by
   the device's .instance_init method

We define two new macros DEFINE_PROP_SIGNED_NODEFAULT and
DEFINE_PROP_UNSIGNED_NODEFAULT, to cover the most plausible use cases
of wanting to set an integer property with no default value.

Suggested-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
Message-id: 1499788408-10096-3-git-send-email-peter.maydell@linaro.org
---
 include/hw/qdev-core.h       | 10 ++++++++++
 include/hw/qdev-properties.h | 20 ++++++++++++++++++++
 hw/core/qdev.c               |  2 +-
 3 files changed, 31 insertions(+), 1 deletion(-)

diff --git a/include/hw/qdev-core.h b/include/hw/qdev-core.h
index 5348815..ae31728 100644
--- a/include/hw/qdev-core.h
+++ b/include/hw/qdev-core.h
@@ -221,11 +221,21 @@ struct BusState {
     QLIST_ENTRY(BusState) sibling;
 };
 
+/**
+ * Property:
+ * @set_default: true if the default value should be set from @defval,
+ *    in which case @info->set_default_value must not be NULL
+ *    (if false then no default value is set by the property system
+ *     and the field retains whatever value it was given by instance_init).
+ * @defval: default value for the property. This is used only if @set_default
+ *     is true.
+ */
 struct Property {
     const char   *name;
     const PropertyInfo *info;
     ptrdiff_t    offset;
     uint8_t      bitnr;
+    bool         set_default;
     union {
         int64_t i;
         uint64_t u;
diff --git a/include/hw/qdev-properties.h b/include/hw/qdev-properties.h
index 12c0c7b..3929796 100644
--- a/include/hw/qdev-properties.h
+++ b/include/hw/qdev-properties.h
@@ -44,15 +44,24 @@ extern const PropertyInfo qdev_prop_link;
         .info      = &(_prop),                                          \
         .offset    = offsetof(_state, _field)                           \
             + type_check(_type,typeof_field(_state, _field)),           \
+        .set_default = true,                                            \
         .defval.i  = (_type)_defval,                                    \
         }
 
+#define DEFINE_PROP_SIGNED_NODEFAULT(_name, _state, _field, _prop, _type) { \
+        .name      = (_name),                                           \
+        .info      = &(_prop),                                          \
+        .offset    = offsetof(_state, _field)                           \
+            + type_check(_type, typeof_field(_state, _field)),          \
+        }
+
 #define DEFINE_PROP_BIT(_name, _state, _field, _bit, _defval) {  \
         .name      = (_name),                                    \
         .info      = &(qdev_prop_bit),                           \
         .bitnr    = (_bit),                                      \
         .offset    = offsetof(_state, _field)                    \
             + type_check(uint32_t,typeof_field(_state, _field)), \
+        .set_default = true,                                     \
         .defval.u  = (bool)_defval,                              \
         }
 
@@ -61,15 +70,24 @@ extern const PropertyInfo qdev_prop_link;
         .info      = &(_prop),                                          \
         .offset    = offsetof(_state, _field)                           \
             + type_check(_type, typeof_field(_state, _field)),          \
+        .set_default = true,                                            \
         .defval.u  = (_type)_defval,                                    \
         }
 
+#define DEFINE_PROP_UNSIGNED_NODEFAULT(_name, _state, _field, _prop, _type) { \
+        .name      = (_name),                                           \
+        .info      = &(_prop),                                          \
+        .offset    = offsetof(_state, _field)                           \
+            + type_check(_type, typeof_field(_state, _field)),          \
+        }
+
 #define DEFINE_PROP_BIT64(_name, _state, _field, _bit, _defval) {       \
         .name      = (_name),                                           \
         .info      = &(qdev_prop_bit64),                                \
         .bitnr    = (_bit),                                             \
         .offset    = offsetof(_state, _field)                           \
             + type_check(uint64_t, typeof_field(_state, _field)),       \
+        .set_default = true,                                            \
         .defval.u  = (bool)_defval,                                     \
         }
 
@@ -78,6 +96,7 @@ extern const PropertyInfo qdev_prop_link;
         .info      = &(qdev_prop_bool),                          \
         .offset    = offsetof(_state, _field)                    \
             + type_check(bool, typeof_field(_state, _field)),    \
+        .set_default = true,                                     \
         .defval.u    = (bool)_defval,                            \
         }
 
@@ -111,6 +130,7 @@ extern const PropertyInfo qdev_prop_link;
                           _arrayfield, _arrayprop, _arraytype) {        \
         .name = (PROP_ARRAY_LEN_PREFIX _name),                          \
         .info = &(qdev_prop_arraylen),                                  \
+        .set_default = true,                                            \
         .defval.u = 0,                                                  \
         .offset = offsetof(_state, _field)                              \
             + type_check(uint32_t, typeof_field(_state, _field)),       \
diff --git a/hw/core/qdev.c b/hw/core/qdev.c
index ec63fe0..606ab53 100644
--- a/hw/core/qdev.c
+++ b/hw/core/qdev.c
@@ -800,7 +800,7 @@ void qdev_property_add_static(DeviceState *dev, Property *prop,
                                     prop->info->description,
                                     &error_abort);
 
-    if (prop->info->set_default_value) {
+    if (prop->set_default) {
         prop->info->set_default_value(obj, prop);
     }
 }
-- 
2.7.4
