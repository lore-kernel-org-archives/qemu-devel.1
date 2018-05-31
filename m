Received: from eggs.gnu.org ([2001:4830:134:3::10]:59686)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fORC9-0006ta-E7
	for qemu-devel@nongnu.org; Thu, 31 May 2018 13:17:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fORC7-0005HW-7n
	for qemu-devel@nongnu.org; Thu, 31 May 2018 13:17:01 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:59788 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1fORC7-0005GP-2Y
	for qemu-devel@nongnu.org; Thu, 31 May 2018 13:16:59 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
	[10.11.54.5])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id BB99340201A0
	for <qemu-devel@nongnu.org>; Thu, 31 May 2018 17:16:58 +0000 (UTC)
Received: from donizetti.redhat.com (ovpn-117-47.ams2.redhat.com
	[10.36.117.47])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 1D21263F50
	for <qemu-devel@nongnu.org>; Thu, 31 May 2018 17:16:57 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu, 31 May 2018 19:16:56 +0200
Message-Id: <20180531171656.21855-2-pbonzini@redhat.com>
In-Reply-To: <20180531171656.21855-1-pbonzini@redhat.com>
References: <20180531171253.21012-1-pbonzini@redhat.com>
	<20180531171656.21855-1-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 38/53] vmstate: Add a VSTRUCT type
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

From: Corey Minyard <cminyard@mvista.com>

The VMS_STRUCT has no way to specify which version of a structure
to use.  Add a type and a new field to allow the specific version
of a structure to be used.

Signed-off-by: Corey Minyard <cminyard@mvista.com>
Message-Id: <1524670052-28373-2-git-send-email-minyard@acm.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 include/migration/vmstate.h | 45 +++++++++++++++++++++++++++++++++++++
 migration/vmstate.c         | 25 +++++++++++++++++----
 2 files changed, 66 insertions(+), 4 deletions(-)

diff --git a/include/migration/vmstate.h b/include/migration/vmstate.h
index df463fd33d..efa0a1150e 100644
--- a/include/migration/vmstate.h
+++ b/include/migration/vmstate.h
@@ -143,6 +143,11 @@ enum VMStateFlags {
      * to determine the number of entries in the array. Only valid in
      * combination with one of VMS_VARRAY*. */
     VMS_MULTIPLY_ELEMENTS = 0x4000,
+
+    /* A structure field that is like VMS_STRUCT, but uses
+     * VMStateField.struct_version_id to tell which version of the
+     * structure we are referencing to use. */
+    VMS_VSTRUCT           = 0x8000,
 };
 
 typedef enum {
@@ -167,6 +172,7 @@ struct VMStateField {
     enum VMStateFlags flags;
     const VMStateDescription *vmsd;
     int version_id;
+    int struct_version_id;
     bool (*field_exists)(void *opaque, int version_id);
 };
 
@@ -248,6 +254,25 @@ extern const VMStateInfo vmstate_info_qtailq;
     vmstate_offset_array(_state, _field, uint8_t,                    \
                          sizeof(typeof_field(_state, _field)))
 
+/* In the macros below, if there is a _version, that means the macro's
+ * field will be processed only if the version being received is >=
+ * the _version specified.  In general, if you add a new field, you
+ * would increment the structure's version and put that version
+ * number into the new field so it would only be processed with the
+ * new version.
+ *
+ * In particular, for VMSTATE_STRUCT() and friends the _version does
+ * *NOT* pick the version of the sub-structure.  It works just as
+ * specified above.  The version of the top-level structure received
+ * is passed down to all sub-structures.  This means that the
+ * sub-structures must have version that are compatible with all the
+ * structures that use them.
+ *
+ * If you want to specify the version of the sub-structure, use
+ * VMSTATE_VSTRUCT(), which allows the specific sub-structure version
+ * to be directly specified.
+ */
+
 #define VMSTATE_SINGLE_TEST(_field, _state, _test, _version, _info, _type) { \
     .name         = (stringify(_field)),                             \
     .version_id   = (_version),                                      \
@@ -395,6 +420,17 @@ extern const VMStateInfo vmstate_info_qtailq;
     .offset     = offsetof(_state, _field),                          \
 }
 
+#define VMSTATE_VSTRUCT_TEST(_field, _state, _test, _version, _vmsd, _type, _struct_version) { \
+    .name         = (stringify(_field)),                             \
+    .version_id   = (_version),                                      \
+    .struct_version_id = (_struct_version),                          \
+    .field_exists = (_test),                                         \
+    .vmsd         = &(_vmsd),                                        \
+    .size         = sizeof(_type),                                   \
+    .flags        = VMS_VSTRUCT,                                     \
+    .offset       = vmstate_offset_value(_state, _field, _type),     \
+}
+
 #define VMSTATE_STRUCT_TEST(_field, _state, _test, _version, _vmsd, _type) { \
     .name         = (stringify(_field)),                             \
     .version_id   = (_version),                                      \
@@ -712,6 +748,13 @@ extern const VMStateInfo vmstate_info_qtailq;
 #define VMSTATE_SINGLE(_field, _state, _version, _info, _type)        \
     VMSTATE_SINGLE_TEST(_field, _state, NULL, _version, _info, _type)
 
+#define VMSTATE_VSTRUCT(_field, _state, _vmsd, _type, _struct_version)\
+    VMSTATE_VSTRUCT_TEST(_field, _state, NULL, 0, _vmsd, _type, _struct_version)
+
+#define VMSTATE_VSTRUCT_V(_field, _state, _version, _vmsd, _type, _struct_version) \
+    VMSTATE_VSTRUCT_TEST(_field, _state, NULL, _version, _vmsd, _type, \
+                         _struct_version)
+
 #define VMSTATE_STRUCT(_field, _state, _version, _vmsd, _type)        \
     VMSTATE_STRUCT_TEST(_field, _state, NULL, _version, _vmsd, _type)
 
@@ -1000,6 +1043,8 @@ int vmstate_load_state(QEMUFile *f, const VMStateDescription *vmsd,
                        void *opaque, int version_id);
 int vmstate_save_state(QEMUFile *f, const VMStateDescription *vmsd,
                        void *opaque, QJSON *vmdesc);
+int vmstate_save_state_v(QEMUFile *f, const VMStateDescription *vmsd,
+                         void *opaque, QJSON *vmdesc, int version_id);
 
 bool vmstate_save_needed(const VMStateDescription *vmsd, void *opaque);
 
diff --git a/migration/vmstate.c b/migration/vmstate.c
index 0b3282c9df..f0b07f4ea1 100644
--- a/migration/vmstate.c
+++ b/migration/vmstate.c
@@ -136,6 +136,9 @@ int vmstate_load_state(QEMUFile *f, const VMStateDescription *vmsd,
                 } else if (field->flags & VMS_STRUCT) {
                     ret = vmstate_load_state(f, field->vmsd, curr_elem,
                                              field->vmsd->version_id);
+                } else if (field->flags & VMS_VSTRUCT) {
+                    ret = vmstate_load_state(f, field->vmsd, curr_elem,
+                                             field->struct_version_id);
                 } else {
                     ret = field->info->get(f, curr_elem, size, field);
                 }
@@ -209,6 +212,8 @@ static const char *vmfield_get_type_name(VMStateField *field)
 
     if (field->flags & VMS_STRUCT) {
         type = "struct";
+    } else if (field->flags & VMS_VSTRUCT) {
+        type = "vstruct";
     } else if (field->info->name) {
         type = field->info->name;
     }
@@ -309,7 +314,13 @@ bool vmstate_save_needed(const VMStateDescription *vmsd, void *opaque)
 
 
 int vmstate_save_state(QEMUFile *f, const VMStateDescription *vmsd,
-                        void *opaque, QJSON *vmdesc)
+                       void *opaque, QJSON *vmdesc_id)
+{
+    return vmstate_save_state_v(f, vmsd, opaque, vmdesc_id, vmsd->version_id);
+}
+
+int vmstate_save_state_v(QEMUFile *f, const VMStateDescription *vmsd,
+                         void *opaque, QJSON *vmdesc, int version_id)
 {
     int ret = 0;
     VMStateField *field = vmsd->fields;
@@ -327,13 +338,15 @@ int vmstate_save_state(QEMUFile *f, const VMStateDescription *vmsd,
 
     if (vmdesc) {
         json_prop_str(vmdesc, "vmsd_name", vmsd->name);
-        json_prop_int(vmdesc, "version", vmsd->version_id);
+        json_prop_int(vmdesc, "version", version_id);
         json_start_array(vmdesc, "fields");
     }
 
     while (field->name) {
-        if (!field->field_exists ||
-            field->field_exists(opaque, vmsd->version_id)) {
+        if ((field->field_exists &&
+             field->field_exists(opaque, version_id)) ||
+            (!field->field_exists &&
+             field->version_id <= version_id)) {
             void *first_elem = opaque + field->offset;
             int i, n_elems = vmstate_n_elems(opaque, field);
             int size = vmstate_size(opaque, field);
@@ -363,6 +376,10 @@ int vmstate_save_state(QEMUFile *f, const VMStateDescription *vmsd,
                 } else if (field->flags & VMS_STRUCT) {
                     ret = vmstate_save_state(f, field->vmsd, curr_elem,
                                              vmdesc_loop);
+                } else if (field->flags & VMS_VSTRUCT) {
+                    ret = vmstate_save_state_v(f, field->vmsd, curr_elem,
+                                               vmdesc_loop,
+                                               field->struct_version_id);
                 } else {
                     ret = field->info->put(f, curr_elem, size, field,
                                      vmdesc_loop);
-- 
2.17.0
