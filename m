Received: from eggs.gnu.org ([2001:4830:134:3::10]:39924)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1cih5Z-0007zV-Jl
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 07:41:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1cih5Y-0000DK-G1
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 07:41:09 -0500
Received: from mx1.redhat.com ([209.132.183.28]:54790)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1cih5Y-0000Cr-7z
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 07:41:08 -0500
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Date: Tue, 28 Feb 2017 12:40:33 +0000
Message-Id: <20170228124056.5074-5-dgilbert@redhat.com>
In-Reply-To: <20170228124056.5074-1-dgilbert@redhat.com>
References: <20170228124056.5074-1-dgilbert@redhat.com>
Subject: [Qemu-devel] [PULL 04/27] migration/vmstate: fix array of ptr with
 nullptrs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: quintela@redhat.com, lvivier@redhat.com, marcandre.lureau@redhat.com, vsementsov@virtuozzo.com, danielhb@linux.vnet.ibm.com, pasic@linux.vnet.ibm.com, ashijeetacharya@gmail.com

From: Halil Pasic <pasic@linux.vnet.ibm.com>

Make VMS_ARRAY_OF_POINTER cope with null pointers. Previously the
reward for trying to migrate an array with some null pointers in it was
an illegal memory access, that is a swift and painless death of the
process.  Let's make vmstate cope with this scenario.

The general approach is, when we encounter a null pointer (element),
instead of following the pointer to save/load the data behind it, we
save/load a placeholder. This way we can detect if we expected a null
pointer at the load side but not null data was saved instead.

Signed-off-by: Halil Pasic <pasic@linux.vnet.ibm.com>
Reviewed-by: Guenther Hutzl <hutzl@linux.vnet.ibm.com>
Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Message-Id: <20170222160119.52771-4-pasic@linux.vnet.ibm.com>
Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 include/migration/vmstate.h |  4 ++++
 migration/vmstate.c         | 40 ++++++++++++++++++++++++++++++++++++++--
 2 files changed, 42 insertions(+), 2 deletions(-)

diff --git a/include/migration/vmstate.h b/include/migration/vmstate.h
index 63e7b02..f2dbf84 100644
--- a/include/migration/vmstate.h
+++ b/include/migration/vmstate.h
@@ -253,6 +253,10 @@ extern const VMStateInfo vmstate_info_uint16;
 extern const VMStateInfo vmstate_info_uint32;
 extern const VMStateInfo vmstate_info_uint64;
 
+/** Put this in the stream when migrating a null pointer.*/
+#define VMS_NULLPTR_MARKER (0x30U) /* '0' */
+extern const VMStateInfo vmstate_info_nullptr;
+
 extern const VMStateInfo vmstate_info_float64;
 extern const VMStateInfo vmstate_info_cpudouble;
 
diff --git a/migration/vmstate.c b/migration/vmstate.c
index 836a7a4..78b3cd4 100644
--- a/migration/vmstate.c
+++ b/migration/vmstate.c
@@ -117,7 +117,11 @@ int vmstate_load_state(QEMUFile *f, const VMStateDescription *vmsd,
                 if (field->flags & VMS_ARRAY_OF_POINTER) {
                     curr_elem = *(void **)curr_elem;
                 }
-                if (field->flags & VMS_STRUCT) {
+                if (!curr_elem) {
+                    /* if null pointer check placeholder and do not follow */
+                    assert(field->flags & VMS_ARRAY_OF_POINTER);
+                    ret = vmstate_info_nullptr.get(f, curr_elem, size, NULL);
+                } else if (field->flags & VMS_STRUCT) {
                     ret = vmstate_load_state(f, field->vmsd, curr_elem,
                                              field->vmsd->version_id);
                 } else {
@@ -332,7 +336,11 @@ void vmstate_save_state(QEMUFile *f, const VMStateDescription *vmsd,
                     assert(curr_elem);
                     curr_elem = *(void **)curr_elem;
                 }
-                if (field->flags & VMS_STRUCT) {
+                if (!curr_elem) {
+                    /* if null pointer write placeholder and do not follow */
+                    assert(field->flags & VMS_ARRAY_OF_POINTER);
+                    vmstate_info_nullptr.put(f, curr_elem, size, NULL, NULL);
+                } else if (field->flags & VMS_STRUCT) {
                     vmstate_save_state(f, field->vmsd, curr_elem, vmdesc_loop);
                 } else {
                     field->info->put(f, curr_elem, size, field, vmdesc_loop);
@@ -747,6 +755,34 @@ const VMStateInfo vmstate_info_uint64 = {
     .put  = put_uint64,
 };
 
+static int get_nullptr(QEMUFile *f, void *pv, size_t size, VMStateField *field)
+
+{
+    if (qemu_get_byte(f) == VMS_NULLPTR_MARKER) {
+        return  0;
+    }
+    error_report("vmstate: get_nullptr expected VMS_NULLPTR_MARKER");
+    return -EINVAL;
+}
+
+static int put_nullptr(QEMUFile *f, void *pv, size_t size,
+                        VMStateField *field, QJSON *vmdesc)
+
+{
+    if (pv == NULL) {
+        qemu_put_byte(f, VMS_NULLPTR_MARKER);
+        return 0;
+    }
+    error_report("vmstate: put_nullptr must be called with pv == NULL");
+    return -EINVAL;
+}
+
+const VMStateInfo vmstate_info_nullptr = {
+    .name = "uint64",
+    .get  = get_nullptr,
+    .put  = put_nullptr,
+};
+
 /* 64 bit unsigned int. See that the received value is the same than the one
    in the field */
 
-- 
2.9.3
