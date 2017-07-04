Received: from eggs.gnu.org ([2001:4830:134:3::10]:41556)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dSHZ0-0003nH-7H
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 02:43:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dSHYw-0002u2-Rb
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 02:43:58 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49432)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1dSHYw-0002sl-Hl
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 02:43:54 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 65588C0587DE
	for <qemu-devel@nongnu.org>; Tue,  4 Jul 2017 06:43:53 +0000 (UTC)
From: Fam Zheng <famz@redhat.com>
Date: Tue,  4 Jul 2017 14:43:28 +0800
Message-Id: <20170704064347.7022-2-famz@redhat.com>
In-Reply-To: <20170704064347.7022-1-famz@redhat.com>
References: <20170704064347.7022-1-famz@redhat.com>
Subject: [Qemu-devel] [PATCH v3 01/20] qom: enforce readonly nature of
 link's check callback
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

From: Igor Mammedov <imammedo@redhat.com>

link's check callback is supposed to verify/permit setting it,
however currently nothing restricts it from misusing it
and modifying target object from within.
Make sure that readonly semantics are checked by compiler
to prevent callback's misuse.

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
Signed-off-by: Fam Zheng <famz@redhat.com>
---
 hw/core/qdev-properties.c    | 3 ++-
 hw/display/xlnx_dp.c         | 2 +-
 hw/ipmi/ipmi.c               | 2 +-
 hw/mem/pc-dimm.c             | 2 +-
 hw/misc/ivshmem.c            | 2 +-
 hw/virtio/virtio-crypto.c    | 2 +-
 include/hw/qdev-properties.h | 3 ++-
 include/qom/object.h         | 6 +++---
 qom/object.c                 | 8 ++++----
 9 files changed, 16 insertions(+), 14 deletions(-)

diff --git a/hw/core/qdev-properties.c b/hw/core/qdev-properties.c
index f11d578..113ce7d 100644
--- a/hw/core/qdev-properties.c
+++ b/hw/core/qdev-properties.c
@@ -25,7 +25,8 @@ void qdev_prop_set_after_realize(DeviceState *dev, const char *name,
     }
 }
 
-void qdev_prop_allow_set_link_before_realize(Object *obj, const char *name,
+void qdev_prop_allow_set_link_before_realize(const Object *obj,
+                                             const char *name,
                                              Object *val, Error **errp)
 {
     DeviceState *dev = DEVICE(obj);
diff --git a/hw/display/xlnx_dp.c b/hw/display/xlnx_dp.c
index f7b7b80..e99bba4 100644
--- a/hw/display/xlnx_dp.c
+++ b/hw/display/xlnx_dp.c
@@ -515,7 +515,7 @@ static void xlnx_dp_aux_set_command(XlnxDPState *s, uint32_t value)
     s->core_registers[DP_INTERRUPT_SIGNAL_STATE] |= 0x04;
 }
 
-static void xlnx_dp_set_dpdma(Object *obj, const char *name, Object *val,
+static void xlnx_dp_set_dpdma(const Object *obj, const char *name, Object *val,
                               Error **errp)
 {
     XlnxDPState *s = XLNX_DP(obj);
diff --git a/hw/ipmi/ipmi.c b/hw/ipmi/ipmi.c
index afafe14..b27babd 100644
--- a/hw/ipmi/ipmi.c
+++ b/hw/ipmi/ipmi.c
@@ -90,7 +90,7 @@ static TypeInfo ipmi_interface_type_info = {
     .class_init = ipmi_interface_class_init,
 };
 
-static void isa_ipmi_bmc_check(Object *obj, const char *name,
+static void isa_ipmi_bmc_check(const Object *obj, const char *name,
                                Object *val, Error **errp)
 {
     IPMIBmc *bmc = IPMI_BMC(val);
diff --git a/hw/mem/pc-dimm.c b/hw/mem/pc-dimm.c
index b72258e..5e23495 100644
--- a/hw/mem/pc-dimm.c
+++ b/hw/mem/pc-dimm.c
@@ -367,7 +367,7 @@ static void pc_dimm_get_size(Object *obj, Visitor *v, const char *name,
     visit_type_uint64(v, name, &value, errp);
 }
 
-static void pc_dimm_check_memdev_is_busy(Object *obj, const char *name,
+static void pc_dimm_check_memdev_is_busy(const Object *obj, const char *name,
                                       Object *val, Error **errp)
 {
     Error *local_err = NULL;
diff --git a/hw/misc/ivshmem.c b/hw/misc/ivshmem.c
index 2f0819d..97beaf6 100644
--- a/hw/misc/ivshmem.c
+++ b/hw/misc/ivshmem.c
@@ -1009,7 +1009,7 @@ static const TypeInfo ivshmem_common_info = {
     .class_init    = ivshmem_common_class_init,
 };
 
-static void ivshmem_check_memdev_is_busy(Object *obj, const char *name,
+static void ivshmem_check_memdev_is_busy(const Object *obj, const char *name,
                                          Object *val, Error **errp)
 {
     if (host_memory_backend_is_mapped(MEMORY_BACKEND(val))) {
diff --git a/hw/virtio/virtio-crypto.c b/hw/virtio/virtio-crypto.c
index 0353eb6..2590893 100644
--- a/hw/virtio/virtio-crypto.c
+++ b/hw/virtio/virtio-crypto.c
@@ -889,7 +889,7 @@ static void virtio_crypto_class_init(ObjectClass *klass, void *data)
 }
 
 static void
-virtio_crypto_check_cryptodev_is_used(Object *obj, const char *name,
+virtio_crypto_check_cryptodev_is_used(const Object *obj, const char *name,
                                       Object *val, Error **errp)
 {
     if (cryptodev_backend_is_used(CRYPTODEV_BACKEND(val))) {
diff --git a/include/hw/qdev-properties.h b/include/hw/qdev-properties.h
index 0604c33..9edded2 100644
--- a/include/hw/qdev-properties.h
+++ b/include/hw/qdev-properties.h
@@ -272,7 +272,8 @@ void qdev_prop_set_after_realize(DeviceState *dev, const char *name,
  * This function should be used as the check() argument to
  * object_property_add_link().
  */
-void qdev_prop_allow_set_link_before_realize(Object *obj, const char *name,
+void qdev_prop_allow_set_link_before_realize(const Object *obj,
+                                             const char *name,
                                              Object *val, Error **errp);
 
 #endif
diff --git a/include/qom/object.h b/include/qom/object.h
index abaeb8c..1b82899 100644
--- a/include/qom/object.h
+++ b/include/qom/object.h
@@ -764,7 +764,7 @@ ObjectClass *object_get_class(Object *obj);
  *
  * Returns: The QOM typename of @obj.
  */
-const char *object_get_typename(Object *obj);
+const char *object_get_typename(const Object *obj);
 
 /**
  * type_register_static:
@@ -1319,7 +1319,7 @@ typedef enum {
  * callback function.  It allows the link property to be set and never returns
  * an error.
  */
-void object_property_allow_set_link(Object *, const char *,
+void object_property_allow_set_link(const Object *, const char *,
                                     Object *, Error **);
 
 /**
@@ -1352,7 +1352,7 @@ void object_property_allow_set_link(Object *, const char *,
  */
 void object_property_add_link(Object *obj, const char *name,
                               const char *type, Object **child,
-                              void (*check)(Object *obj, const char *name,
+                              void (*check)(const Object *obj, const char *name,
                                             Object *val, Error **errp),
                               ObjectPropertyLinkFlags flags,
                               Error **errp);
diff --git a/qom/object.c b/qom/object.c
index 5f6fdfa..dfdbd50 100644
--- a/qom/object.c
+++ b/qom/object.c
@@ -740,7 +740,7 @@ out:
     return ret;
 }
 
-const char *object_get_typename(Object *obj)
+const char *object_get_typename(const Object *obj)
 {
     return obj->class->type->name;
 }
@@ -1428,7 +1428,7 @@ out:
     g_free(type);
 }
 
-void object_property_allow_set_link(Object *obj, const char *name,
+void object_property_allow_set_link(const Object *obj, const char *name,
                                     Object *val, Error **errp)
 {
     /* Allow the link to be set, always */
@@ -1436,7 +1436,7 @@ void object_property_allow_set_link(Object *obj, const char *name,
 
 typedef struct {
     Object **child;
-    void (*check)(Object *, const char *, Object *, Error **);
+    void (*check)(const Object *, const char *, Object *, Error **);
     ObjectPropertyLinkFlags flags;
 } LinkProperty;
 
@@ -1552,7 +1552,7 @@ static void object_release_link_property(Object *obj, const char *name,
 
 void object_property_add_link(Object *obj, const char *name,
                               const char *type, Object **child,
-                              void (*check)(Object *, const char *,
+                              void (*check)(const Object *, const char *,
                                             Object *, Error **),
                               ObjectPropertyLinkFlags flags,
                               Error **errp)
-- 
2.9.4
