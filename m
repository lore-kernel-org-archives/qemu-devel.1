Received: from eggs.gnu.org ([2001:4830:134:3::10]:39905)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1cih5X-0007xr-SY
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 07:41:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1cih5W-0000CZ-HT
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 07:41:07 -0500
Received: from mx1.redhat.com ([209.132.183.28]:42666)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1cih5W-0000CL-8g
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 07:41:06 -0500
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Date: Tue, 28 Feb 2017 12:40:32 +0000
Message-Id: <20170228124056.5074-4-dgilbert@redhat.com>
In-Reply-To: <20170228124056.5074-1-dgilbert@redhat.com>
References: <20170228124056.5074-1-dgilbert@redhat.com>
Subject: [Qemu-devel] [PULL 03/27] migration/vmstate: split up
 vmstate_base_addr
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

Currently vmstate_base_addr does several things: it pinpoints the field
within the struct, possibly allocates memory and possibly does the first
pointer dereference. Obviously allocation is needed only for load.

Let us split up the functionality in vmstate_base_addr and move the
address manipulations (that is everything but the allocation logic) to
load and save so it becomes more obvious what is actually going on. Like
this all the address calculations (and the handling of the flags
controlling these) is in one place and the sequence is more obvious.

The newly introduced function vmstate_handle_alloc also fixes the
allocation for the unused VMS_VBUFFER|VMS_MULTIPLY|VMS_ALLOC scenario
and is substantially simpler than the original vmstate_base_addr.

In load and save some asserts are added so it's easier to debug
situations where we would end up with a null pointer dereference.

Signed-off-by: Halil Pasic <pasic@linux.vnet.ibm.com>
Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Message-Id: <20170222160119.52771-3-pasic@linux.vnet.ibm.com>
Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 migration/vmstate.c | 39 +++++++++++++++++----------------------
 1 file changed, 17 insertions(+), 22 deletions(-)

diff --git a/migration/vmstate.c b/migration/vmstate.c
index 36efa80..836a7a4 100644
--- a/migration/vmstate.c
+++ b/migration/vmstate.c
@@ -52,29 +52,15 @@ static int vmstate_size(void *opaque, VMStateField *field)
     return size;
 }
 
-static void *vmstate_base_addr(void *opaque, VMStateField *field, bool alloc)
+static void vmstate_handle_alloc(void *ptr, VMStateField *field, void *opaque)
 {
-    void *base_addr = opaque + field->offset;
-
-    if (field->flags & VMS_POINTER) {
-        if (alloc && (field->flags & VMS_ALLOC)) {
-            gsize size = 0;
-            if (field->flags & VMS_VBUFFER) {
-                size = vmstate_size(opaque, field);
-            } else {
-                int n_elems = vmstate_n_elems(opaque, field);
-                if (n_elems) {
-                    size = n_elems * field->size;
-                }
-            }
-            if (size) {
-                *(void **)base_addr = g_malloc(size);
-            }
+    if (field->flags & VMS_POINTER && field->flags & VMS_ALLOC) {
+        gsize size = vmstate_size(opaque, field);
+        size *= vmstate_n_elems(opaque, field);
+        if (size) {
+            *(void **)ptr = g_malloc(size);
         }
-        base_addr = *(void **)base_addr;
     }
-
-    return base_addr;
 }
 
 int vmstate_load_state(QEMUFile *f, const VMStateDescription *vmsd,
@@ -116,10 +102,15 @@ int vmstate_load_state(QEMUFile *f, const VMStateDescription *vmsd,
              field->field_exists(opaque, version_id)) ||
             (!field->field_exists &&
              field->version_id <= version_id)) {
-            void *first_elem = vmstate_base_addr(opaque, field, true);
+            void *first_elem = opaque + field->offset;
             int i, n_elems = vmstate_n_elems(opaque, field);
             int size = vmstate_size(opaque, field);
 
+            vmstate_handle_alloc(first_elem, field, opaque);
+            if (field->flags & VMS_POINTER) {
+                first_elem = *(void **)first_elem;
+                assert(first_elem  || !n_elems);
+            }
             for (i = 0; i < n_elems; i++) {
                 void *curr_elem = first_elem + size * i;
 
@@ -321,13 +312,17 @@ void vmstate_save_state(QEMUFile *f, const VMStateDescription *vmsd,
     while (field->name) {
         if (!field->field_exists ||
             field->field_exists(opaque, vmsd->version_id)) {
-            void *first_elem = vmstate_base_addr(opaque, field, false);
+            void *first_elem = opaque + field->offset;
             int i, n_elems = vmstate_n_elems(opaque, field);
             int size = vmstate_size(opaque, field);
             int64_t old_offset, written_bytes;
             QJSON *vmdesc_loop = vmdesc;
 
             trace_vmstate_save_state_loop(vmsd->name, field->name, n_elems);
+            if (field->flags & VMS_POINTER) {
+                first_elem = *(void **)first_elem;
+                assert(first_elem  || !n_elems);
+            }
             for (i = 0; i < n_elems; i++) {
                 void *curr_elem = first_elem + size * i;
 
-- 
2.9.3
