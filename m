Received: from eggs.gnu.org ([2001:4830:134:3::10]:39639)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1dxCqY-00010J-RZ
	for qemu-devel@nongnu.org; Wed, 27 Sep 2017 09:57:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1dxCqX-0002TG-Vx
	for qemu-devel@nongnu.org; Wed, 27 Sep 2017 09:57:54 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56470)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1dxCqX-0002Rb-QE
	for qemu-devel@nongnu.org; Wed, 27 Sep 2017 09:57:53 -0400
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Date: Wed, 27 Sep 2017 14:57:39 +0100
Message-Id: <20170927135742.19724-5-dgilbert@redhat.com>
In-Reply-To: <20170927135742.19724-1-dgilbert@redhat.com>
References: <20170927135742.19724-1-dgilbert@redhat.com>
Subject: [Qemu-devel] [PULL 4/7] migration: Check field save returns
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: pl@kamp.de, quintela@redhat.com

From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>

Check the return values from vmstate_save_state for fields and also the
return values from 'put' for fields that use that.

Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Message-Id: <20170925112917.21340-4-dgilbert@redhat.com>
Reviewed-by: Peter Xu <peterx@redhat.com>
Reviewed-by: Cornelia Huck <cohuck@redhat.com>
Reviewed-by: Juan Quintela <quintela@redhat.com>
Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 migration/vmstate.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/migration/vmstate.c b/migration/vmstate.c
index ae8abd3c32..848e8448c6 100644
--- a/migration/vmstate.c
+++ b/migration/vmstate.c
@@ -347,6 +347,7 @@ int vmstate_save_state(QEMUFile *f, const VMStateDescription *vmsd,
             }
             for (i = 0; i < n_elems; i++) {
                 void *curr_elem = first_elem + size * i;
+                ret = 0;
 
                 vmsd_desc_field_start(vmsd, vmdesc_loop, field, i, n_elems);
                 old_offset = qemu_ftell_fast(f);
@@ -357,11 +358,19 @@ int vmstate_save_state(QEMUFile *f, const VMStateDescription *vmsd,
                 if (!curr_elem && size) {
                     /* if null pointer write placeholder and do not follow */
                     assert(field->flags & VMS_ARRAY_OF_POINTER);
-                    vmstate_info_nullptr.put(f, curr_elem, size, NULL, NULL);
+                    ret = vmstate_info_nullptr.put(f, curr_elem, size, NULL,
+                                                   NULL);
                 } else if (field->flags & VMS_STRUCT) {
-                    vmstate_save_state(f, field->vmsd, curr_elem, vmdesc_loop);
+                    ret = vmstate_save_state(f, field->vmsd, curr_elem,
+                                             vmdesc_loop);
                 } else {
-                    field->info->put(f, curr_elem, size, field, vmdesc_loop);
+                    ret = field->info->put(f, curr_elem, size, field,
+                                     vmdesc_loop);
+                }
+                if (ret) {
+                    error_report("Save of field %s/%s failed",
+                                 vmsd->name, field->name);
+                    return ret;
                 }
 
                 written_bytes = qemu_ftell_fast(f) - old_offset;
-- 
2.13.5
