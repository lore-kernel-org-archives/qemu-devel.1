Received: from eggs.gnu.org ([2001:4830:134:3::10]:33294)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pasic@linux.vnet.ibm.com>) id 1dOPt3-0005zn-RR
	for qemu-devel@nongnu.org; Fri, 23 Jun 2017 10:48:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pasic@linux.vnet.ibm.com>) id 1dOPt0-0001qD-C3
	for qemu-devel@nongnu.org; Fri, 23 Jun 2017 10:48:41 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:47328)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pasic@linux.vnet.ibm.com>)
	id 1dOPt0-0001pK-1j
	for qemu-devel@nongnu.org; Fri, 23 Jun 2017 10:48:38 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v5NEmWEs014939
	for <qemu-devel@nongnu.org>; Fri, 23 Jun 2017 10:48:34 -0400
Received: from e06smtp12.uk.ibm.com (e06smtp12.uk.ibm.com [195.75.94.108])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2b8yue86us-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 23 Jun 2017 10:48:33 -0400
Received: from localhost
	by e06smtp12.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <pasic@linux.vnet.ibm.com>;
	Fri, 23 Jun 2017 15:48:28 +0100
From: Halil Pasic <pasic@linux.vnet.ibm.com>
Date: Fri, 23 Jun 2017 16:48:23 +0200
Message-Id: <20170623144823.42936-1-pasic@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH 1/1] vmstate: error hint for failed equal checks
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>, "Jason J . Herne" <jjherne@linux.vnet.ibm.com>, Juan Quintela <quintela@redhat.com>, qemu-devel@nongnu.org, Halil Pasic <pasic@linux.vnet.ibm.com>

In some cases a failing VMSTATE_*_EQUAL does not mean we detected a bug,
but it's actually the best we can do. Especially in these cases a verbose
error message is required.

Let's introduce infrastructure for specifying a error hint to be used if
equal check fails. Let's do this by adding a parameter to the _EQUAL
macros called _err_hint. Also change all current users to pass NULL as
last parameter so nothing changes for them.

Signed-off-by: Halil Pasic <pasic@linux.vnet.ibm.com>

---

I have  already had an RFC series prior to this patch trying to do the
same: https://lists.gnu.org/archive/html/qemu-devel/2017-06/msg01413.html
We decided with the migration maintainers to rather add an parameter
than introduce a load of new macros. All the other feedback from there
was incorporated too. The RFC also contains the direct motivation for
this change, which is vmstate conversion of virtio-ccw, and is intended
to happen on top of this.
---
 hw/display/virtio-gpu.c     |  2 +-
 hw/nvram/eeprom93xx.c       |  2 +-
 hw/pci/pci.c                |  2 +-
 hw/pci/pcie_aer.c           |  2 +-
 include/migration/vmstate.h | 51 +++++++++++++++++++++++++++++++--------------
 migration/vmstate-types.c   | 15 +++++++++++++
 6 files changed, 54 insertions(+), 20 deletions(-)

diff --git a/hw/display/virtio-gpu.c b/hw/display/virtio-gpu.c
index 58dc0b2737..0506d2c1b0 100644
--- a/hw/display/virtio-gpu.c
+++ b/hw/display/virtio-gpu.c
@@ -962,7 +962,7 @@ static const VMStateDescription vmstate_virtio_gpu_scanouts = {
     .version_id = 1,
     .fields = (VMStateField[]) {
         VMSTATE_INT32(enable, struct VirtIOGPU),
-        VMSTATE_UINT32_EQUAL(conf.max_outputs, struct VirtIOGPU),
+        VMSTATE_UINT32_EQUAL(conf.max_outputs, struct VirtIOGPU, NULL),
         VMSTATE_STRUCT_VARRAY_UINT32(scanout, struct VirtIOGPU,
                                      conf.max_outputs, 1,
                                      vmstate_virtio_gpu_scanout,
diff --git a/hw/nvram/eeprom93xx.c b/hw/nvram/eeprom93xx.c
index 848692abc0..2fd0e3c29f 100644
--- a/hw/nvram/eeprom93xx.c
+++ b/hw/nvram/eeprom93xx.c
@@ -143,7 +143,7 @@ static const VMStateDescription vmstate_eeprom = {
         VMSTATE_UINT8(addrbits, eeprom_t),
         VMSTATE_UINT16_HACK_TEST(size, eeprom_t, is_old_eeprom_version),
         VMSTATE_UNUSED_TEST(is_old_eeprom_version, 1),
-        VMSTATE_UINT16_EQUAL_V(size, eeprom_t, EEPROM_VERSION),
+        VMSTATE_UINT16_EQUAL_V(size, eeprom_t, EEPROM_VERSION, NULL),
         VMSTATE_UINT16(data, eeprom_t),
         VMSTATE_VARRAY_UINT16_UNSAFE(contents, eeprom_t, size, 0,
                                      vmstate_info_uint16, uint16_t),
diff --git a/hw/pci/pci.c b/hw/pci/pci.c
index 98ccc27533..b7fee4bdf2 100644
--- a/hw/pci/pci.c
+++ b/hw/pci/pci.c
@@ -74,7 +74,7 @@ static const VMStateDescription vmstate_pcibus = {
     .version_id = 1,
     .minimum_version_id = 1,
     .fields = (VMStateField[]) {
-        VMSTATE_INT32_EQUAL(nirq, PCIBus),
+        VMSTATE_INT32_EQUAL(nirq, PCIBus, NULL),
         VMSTATE_VARRAY_INT32(irq_count, PCIBus,
                              nirq, 0, vmstate_info_int32,
                              int32_t),
diff --git a/hw/pci/pcie_aer.c b/hw/pci/pcie_aer.c
index 828052b0c0..97200742b4 100644
--- a/hw/pci/pcie_aer.c
+++ b/hw/pci/pcie_aer.c
@@ -813,7 +813,7 @@ const VMStateDescription vmstate_pcie_aer_log = {
     .minimum_version_id = 1,
     .fields = (VMStateField[]) {
         VMSTATE_UINT16(log_num, PCIEAERLog),
-        VMSTATE_UINT16_EQUAL(log_max, PCIEAERLog),
+        VMSTATE_UINT16_EQUAL(log_max, PCIEAERLog, NULL),
         VMSTATE_VALIDATE("log_num <= log_max", pcie_aer_state_log_num_valid),
         VMSTATE_STRUCT_VARRAY_POINTER_UINT16(log, PCIEAERLog, log_num,
                               vmstate_pcie_aer_err, PCIEAERErr),
diff --git a/include/migration/vmstate.h b/include/migration/vmstate.h
index e85fbd81fc..85e43da568 100644
--- a/include/migration/vmstate.h
+++ b/include/migration/vmstate.h
@@ -155,6 +155,7 @@ typedef enum {
 
 struct VMStateField {
     const char *name;
+    const char *err_hint;
     size_t offset;
     size_t size;
     size_t start;
@@ -256,6 +257,18 @@ extern const VMStateInfo vmstate_info_qtailq;
     .offset       = vmstate_offset_value(_state, _field, _type),     \
 }
 
+#define VMSTATE_SINGLE_FULL(_field, _state, _test, _version, _info,  \
+                            _type, _err_hint) {                      \
+    .name         = (stringify(_field)),                             \
+    .err_hint     = (_err_hint),                                     \
+    .version_id   = (_version),                                      \
+    .field_exists = (_test),                                         \
+    .size         = sizeof(_type),                                   \
+    .info         = &(_info),                                        \
+    .flags        = VMS_SINGLE,                                      \
+    .offset       = vmstate_offset_value(_state, _field, _type),     \
+}
+
 /* Validate state using a boolean predicate. */
 #define VMSTATE_VALIDATE(_name, _test) { \
     .name         = (_name),                                         \
@@ -762,29 +775,35 @@ extern const VMStateInfo vmstate_info_qtailq;
 #define VMSTATE_UINT64(_f, _s)                                        \
     VMSTATE_UINT64_V(_f, _s, 0)
 
-#define VMSTATE_UINT8_EQUAL(_f, _s)                                   \
-    VMSTATE_SINGLE(_f, _s, 0, vmstate_info_uint8_equal, uint8_t)
+#define VMSTATE_UINT8_EQUAL(_f, _s, _err_hint)                        \
+    VMSTATE_SINGLE_FULL(_f, _s, 0, 0,                                 \
+                        vmstate_info_uint8_equal, uint8_t, _err_hint)
 
-#define VMSTATE_UINT16_EQUAL(_f, _s)                                  \
-    VMSTATE_SINGLE(_f, _s, 0, vmstate_info_uint16_equal, uint16_t)
+#define VMSTATE_UINT16_EQUAL(_f, _s, _err_hint)                       \
+    VMSTATE_SINGLE_FULL(_f, _s, 0, 0,                                 \
+                        vmstate_info_uint16_equal, uint16_t, _err_hint)
 
-#define VMSTATE_UINT16_EQUAL_V(_f, _s, _v)                            \
-    VMSTATE_SINGLE(_f, _s, _v, vmstate_info_uint16_equal, uint16_t)
+#define VMSTATE_UINT16_EQUAL_V(_f, _s, _v, _err_hint)                 \
+    VMSTATE_SINGLE_FULL(_f, _s, 0,  _v,                               \
+                        vmstate_info_uint16_equal, uint16_t, _err_hint)
 
-#define VMSTATE_INT32_EQUAL(_f, _s)                                   \
-    VMSTATE_SINGLE(_f, _s, 0, vmstate_info_int32_equal, int32_t)
+#define VMSTATE_INT32_EQUAL(_f, _s, _err_hint)                        \
+    VMSTATE_SINGLE_FULL(_f, _s, 0, 0,                                 \
+                        vmstate_info_int32_equal, int32_t, _err_hint)
 
-#define VMSTATE_UINT32_EQUAL_V(_f, _s, _v)                            \
-    VMSTATE_SINGLE(_f, _s, _v, vmstate_info_uint32_equal, uint32_t)
+#define VMSTATE_UINT32_EQUAL_V(_f, _s, _v, _err_hint)                 \
+    VMSTATE_SINGLE_FULL(_f, _s, 0,  _v,                               \
+                        vmstate_info_uint32_equal, uint32_t, _err_hint)
 
-#define VMSTATE_UINT32_EQUAL(_f, _s)                                  \
-    VMSTATE_UINT32_EQUAL_V(_f, _s, 0)
+#define VMSTATE_UINT32_EQUAL(_f, _s, _err_hint)                       \
+    VMSTATE_UINT32_EQUAL_V(_f, _s, 0, _err_hint)
 
-#define VMSTATE_UINT64_EQUAL_V(_f, _s, _v)                            \
-    VMSTATE_SINGLE(_f, _s, _v, vmstate_info_uint64_equal, uint64_t)
+#define VMSTATE_UINT64_EQUAL_V(_f, _s, _v, _err_hint)                 \
+    VMSTATE_SINGLE_FULL(_f, _s, 0,  _v,                               \
+                        vmstate_info_uint64_equal, uint64_t, _err_hint)
 
-#define VMSTATE_UINT64_EQUAL(_f, _s)                                  \
-    VMSTATE_UINT64_EQUAL_V(_f, _s, 0)
+#define VMSTATE_UINT64_EQUAL(_f, _s, _err_hint)                       \
+    VMSTATE_UINT64_EQUAL_V(_f, _s, 0, _err_hint)
 
 #define VMSTATE_INT32_POSITIVE_LE(_f, _s)                             \
     VMSTATE_SINGLE(_f, _s, 0, vmstate_info_int32_le, int32_t)
diff --git a/migration/vmstate-types.c b/migration/vmstate-types.c
index 02f05a3359..c056c98bdb 100644
--- a/migration/vmstate-types.c
+++ b/migration/vmstate-types.c
@@ -126,6 +126,9 @@ static int get_int32_equal(QEMUFile *f, void *pv, size_t size,
         return 0;
     }
     error_report("%" PRIx32 " != %" PRIx32, *v, v2);
+    if (field->err_hint) {
+        error_printf("%s\n", field->err_hint);
+    }
     return -EINVAL;
 }
 
@@ -267,6 +270,9 @@ static int get_uint32_equal(QEMUFile *f, void *pv, size_t size,
         return 0;
     }
     error_report("%" PRIx32 " != %" PRIx32, *v, v2);
+    if (field->err_hint) {
+        error_printf("%s\n", field->err_hint);
+    }
     return -EINVAL;
 }
 
@@ -341,6 +347,9 @@ static int get_uint64_equal(QEMUFile *f, void *pv, size_t size,
         return 0;
     }
     error_report("%" PRIx64 " != %" PRIx64, *v, v2);
+    if (field->err_hint) {
+        error_printf("%s\n", field->err_hint);
+    }
     return -EINVAL;
 }
 
@@ -364,6 +373,9 @@ static int get_uint8_equal(QEMUFile *f, void *pv, size_t size,
         return 0;
     }
     error_report("%x != %x", *v, v2);
+    if (field->err_hint) {
+        error_printf("%s\n", field->err_hint);
+    }
     return -EINVAL;
 }
 
@@ -387,6 +399,9 @@ static int get_uint16_equal(QEMUFile *f, void *pv, size_t size,
         return 0;
     }
     error_report("%x != %x", *v, v2);
+    if (field->err_hint) {
+        error_printf("%s\n", field->err_hint);
+    }
     return -EINVAL;
 }
 
-- 
2.11.2
