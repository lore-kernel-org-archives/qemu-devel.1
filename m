Received: from eggs.gnu.org ([2001:4830:134:3::10]:43233)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pasic@linux.vnet.ibm.com>) id 1ceKv0-0000Qg-7x
	for qemu-devel@nongnu.org; Thu, 16 Feb 2017 07:12:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pasic@linux.vnet.ibm.com>) id 1ceKux-0002cl-17
	for qemu-devel@nongnu.org; Thu, 16 Feb 2017 07:12:14 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:60667
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pasic@linux.vnet.ibm.com>)
	id 1ceKuw-0002Zi-Qe
	for qemu-devel@nongnu.org; Thu, 16 Feb 2017 07:12:10 -0500
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v1GC3aZx131139
	for <qemu-devel@nongnu.org>; Thu, 16 Feb 2017 07:12:09 -0500
Received: from e06smtp09.uk.ibm.com (e06smtp09.uk.ibm.com [195.75.94.105])
	by mx0b-001b2d01.pphosted.com with ESMTP id 28n9b66pkv-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 16 Feb 2017 07:12:09 -0500
Received: from localhost
	by e06smtp09.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <pasic@linux.vnet.ibm.com>;
	Thu, 16 Feb 2017 12:12:07 -0000
From: Halil Pasic <pasic@linux.vnet.ibm.com>
Date: Thu, 16 Feb 2017 13:11:36 +0100
In-Reply-To: <20170216121140.9061-1-pasic@linux.vnet.ibm.com>
References: <20170216121140.9061-1-pasic@linux.vnet.ibm.com>
Message-Id: <20170216121140.9061-2-pasic@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH 1/5] migration/vmstate: renames in
 (load|save)_state
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: Juan Quintela <quintela@redhat.com>, Amit Shah <amit.shah@redhat.com>, Halil Pasic <pasic@linux.vnet.ibm.com>

The vmstate_(load|save)_state start out with an a void *opaque pointing
to some struct, and manipulate one or more elements of one field within
that struct.

First the field within the struct is pinpointed as opaque + offset, then
if this is a pointer the pointer is dereferenced to obtain a pointer to
the first element of the vmstate field. Pointers to further elements if
any are calculated as first_element + i * element_size (where i is the
zero based index of the element in question).

Currently base_addr and addr is used as a variable name for the pointer
to the first element and the pointer to the current element being
processed. This is suboptimal because base_addr is somewhat
counter-intuitive (because obtained as base + offset) and both base_addr
and addr not very descriptive (that we have a pointer should be clear
from the fact that it is declared as a pointer).

Let make things easier to understand by renaming base_addr to first_elem
and addr to curr_elem. This has the additional benefit of harmonizing
with other names within the scope (n_elems, vmstate_n_elems).

Signed-off-by: Halil Pasic <pasic@linux.vnet.ibm.com>
Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---

This patch roots in the difficulties I faced when trying to figure out
the code in question. In the meanwhile I'm quite fine with the current
names because I have it already figured out (after a couple of months
not looking on this code however, who knows). Thus my main motivation
is making things easier for the next new guy, but if the old guys say
not worth it I can very well accept that too.
---
 migration/vmstate.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/migration/vmstate.c b/migration/vmstate.c
index b4d8ae9..36efa80 100644
--- a/migration/vmstate.c
+++ b/migration/vmstate.c
@@ -116,21 +116,21 @@ int vmstate_load_state(QEMUFile *f, const VMStateDescription *vmsd,
              field->field_exists(opaque, version_id)) ||
             (!field->field_exists &&
              field->version_id <= version_id)) {
-            void *base_addr = vmstate_base_addr(opaque, field, true);
+            void *first_elem = vmstate_base_addr(opaque, field, true);
             int i, n_elems = vmstate_n_elems(opaque, field);
             int size = vmstate_size(opaque, field);
 
             for (i = 0; i < n_elems; i++) {
-                void *addr = base_addr + size * i;
+                void *curr_elem = first_elem + size * i;
 
                 if (field->flags & VMS_ARRAY_OF_POINTER) {
-                    addr = *(void **)addr;
+                    curr_elem = *(void **)curr_elem;
                 }
                 if (field->flags & VMS_STRUCT) {
-                    ret = vmstate_load_state(f, field->vmsd, addr,
+                    ret = vmstate_load_state(f, field->vmsd, curr_elem,
                                              field->vmsd->version_id);
                 } else {
-                   ret = field->info->get(f, addr, size, field);
+                    ret = field->info->get(f, curr_elem, size, field);
                 }
                 if (ret >= 0) {
                     ret = qemu_file_get_error(f);
@@ -321,7 +321,7 @@ void vmstate_save_state(QEMUFile *f, const VMStateDescription *vmsd,
     while (field->name) {
         if (!field->field_exists ||
             field->field_exists(opaque, vmsd->version_id)) {
-            void *base_addr = vmstate_base_addr(opaque, field, false);
+            void *first_elem = vmstate_base_addr(opaque, field, false);
             int i, n_elems = vmstate_n_elems(opaque, field);
             int size = vmstate_size(opaque, field);
             int64_t old_offset, written_bytes;
@@ -329,18 +329,18 @@ void vmstate_save_state(QEMUFile *f, const VMStateDescription *vmsd,
 
             trace_vmstate_save_state_loop(vmsd->name, field->name, n_elems);
             for (i = 0; i < n_elems; i++) {
-                void *addr = base_addr + size * i;
+                void *curr_elem = first_elem + size * i;
 
                 vmsd_desc_field_start(vmsd, vmdesc_loop, field, i, n_elems);
                 old_offset = qemu_ftell_fast(f);
-
                 if (field->flags & VMS_ARRAY_OF_POINTER) {
-                    addr = *(void **)addr;
+                    assert(curr_elem);
+                    curr_elem = *(void **)curr_elem;
                 }
                 if (field->flags & VMS_STRUCT) {
-                    vmstate_save_state(f, field->vmsd, addr, vmdesc_loop);
+                    vmstate_save_state(f, field->vmsd, curr_elem, vmdesc_loop);
                 } else {
-                    field->info->put(f, addr, size, field, vmdesc_loop);
+                    field->info->put(f, curr_elem, size, field, vmdesc_loop);
                 }
 
                 written_bytes = qemu_ftell_fast(f) - old_offset;
-- 
2.8.4
