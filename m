Received: from eggs.gnu.org ([2001:4830:134:3::10]:41626)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1coRI8-0003O7-Ro
	for qemu-devel@nongnu.org; Thu, 16 Mar 2017 05:01:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1coRI8-00008M-1g
	for qemu-devel@nongnu.org; Thu, 16 Mar 2017 05:01:52 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44920)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1coRI7-000085-PF
	for qemu-devel@nongnu.org; Thu, 16 Mar 2017 05:01:51 -0400
From: Juan Quintela <quintela@redhat.com>
Date: Thu, 16 Mar 2017 10:01:39 +0100
Message-Id: <20170316090141.13421-5-quintela@redhat.com>
In-Reply-To: <20170316090141.13421-1-quintela@redhat.com>
References: <20170316090141.13421-1-quintela@redhat.com>
Subject: [Qemu-devel] [PULL 4/6] vmstate: fix failed iotests case 68 and 91
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: dgilbert@redhat.com, QingFeng Hao <haoqf@linux.vnet.ibm.com>, Halil Pasic <pasic@linux.vnet.ibm.com>

From: QingFeng Hao <haoqf@linux.vnet.ibm.com>

This problem affects s390x only if we are running without KVM.
Basically, S390CPU.irqstate is unused if we do not use KVM,
and thus no buffer is allocated.
This causes size=0, first_elem=NULL and n_elems=1 in
vmstate_load_state and vmstate_save_state. And the assert fails.
With this fix we can go back to the old behavior and support
VMS_VBUFFER with size 0 and nullptr.

Signed-off-by: QingFeng Hao <haoqf@linux.vnet.ibm.com>
Signed-off-by: Halil Pasic <pasic@linux.vnet.ibm.com>
Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Signed-off-by: Juan Quintela <quintela@redhat.com>
---
 migration/vmstate.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/migration/vmstate.c b/migration/vmstate.c
index 78b3cd4..7b4a607 100644
--- a/migration/vmstate.c
+++ b/migration/vmstate.c
@@ -109,7 +109,7 @@ int vmstate_load_state(QEMUFile *f, const VMStateDescription *vmsd,
             vmstate_handle_alloc(first_elem, field, opaque);
             if (field->flags & VMS_POINTER) {
                 first_elem = *(void **)first_elem;
-                assert(first_elem  || !n_elems);
+                assert(first_elem || !n_elems || !size);
             }
             for (i = 0; i < n_elems; i++) {
                 void *curr_elem = first_elem + size * i;
@@ -117,7 +117,7 @@ int vmstate_load_state(QEMUFile *f, const VMStateDescription *vmsd,
                 if (field->flags & VMS_ARRAY_OF_POINTER) {
                     curr_elem = *(void **)curr_elem;
                 }
-                if (!curr_elem) {
+                if (!curr_elem && size) {
                     /* if null pointer check placeholder and do not follow */
                     assert(field->flags & VMS_ARRAY_OF_POINTER);
                     ret = vmstate_info_nullptr.get(f, curr_elem, size, NULL);
@@ -325,7 +325,7 @@ void vmstate_save_state(QEMUFile *f, const VMStateDescription *vmsd,
             trace_vmstate_save_state_loop(vmsd->name, field->name, n_elems);
             if (field->flags & VMS_POINTER) {
                 first_elem = *(void **)first_elem;
-                assert(first_elem  || !n_elems);
+                assert(first_elem || !n_elems || !size);
             }
             for (i = 0; i < n_elems; i++) {
                 void *curr_elem = first_elem + size * i;
@@ -336,7 +336,7 @@ void vmstate_save_state(QEMUFile *f, const VMStateDescription *vmsd,
                     assert(curr_elem);
                     curr_elem = *(void **)curr_elem;
                 }
-                if (!curr_elem) {
+                if (!curr_elem && size) {
                     /* if null pointer write placeholder and do not follow */
                     assert(field->flags & VMS_ARRAY_OF_POINTER);
                     vmstate_info_nullptr.put(f, curr_elem, size, NULL, NULL);
-- 
2.9.3
