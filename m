Received: from eggs.gnu.org ([2001:4830:134:3::10]:60505)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <haoqf@linux.vnet.ibm.com>) id 1cmCPV-0002VI-Vy
	for qemu-devel@nongnu.org; Thu, 09 Mar 2017 23:44:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <haoqf@linux.vnet.ibm.com>) id 1cmCPS-0001IK-2q
	for qemu-devel@nongnu.org; Thu, 09 Mar 2017 23:44:14 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:39604)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <haoqf@linux.vnet.ibm.com>)
	id 1cmCPR-0001Hl-Pj
	for qemu-devel@nongnu.org; Thu, 09 Mar 2017 23:44:10 -0500
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v2A4he79049357
	for <qemu-devel@nongnu.org>; Thu, 9 Mar 2017 23:44:08 -0500
Received: from e06smtp11.uk.ibm.com (e06smtp11.uk.ibm.com [195.75.94.107])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2937kmve8y-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 09 Mar 2017 23:44:08 -0500
Received: from localhost
	by e06smtp11.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <haoqf@linux.vnet.ibm.com>;
	Fri, 10 Mar 2017 04:44:05 -0000
From: QingFeng Hao <haoqf@linux.vnet.ibm.com>
Date: Fri, 10 Mar 2017 05:44:02 +0100
In-Reply-To: <20170310044402.38880-1-haoqf@linux.vnet.ibm.com>
References: <20170310044402.38880-1-haoqf@linux.vnet.ibm.com>
Message-Id: <20170310044402.38880-2-haoqf@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH v1 1/1] vmstate: fix failed iotests case 68 and
 91
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: borntraeger@de.ibm.com, cornelia.huck@de.ibm.com, pasic@linux.vnet.ibm.com, liujbjl@linux.vnet.ibm.com, kwolf@redhat.com, famz@redhat.com, mreitz@redhat.com, dgilbert@redhat.com, quintela@redhat.com

This problem affects s390x only if we are running without KVM.
Basically, S390CPU.irqstate is unused if we do not use KVM,
and thus no buffer is allocated.
This causes size=0, first_elem=NULL and n_elems=1 in
vmstate_load_state and vmstate_save_state. And the assert fails.
With this fix we can go back to the old behavior and support
VMS_VBUFFER with size 0 and nullptr.

Signed-off-by: QingFeng Hao <haoqf@linux.vnet.ibm.com>
Signed-off-by: Halil Pasic <pasic@linux.vnet.ibm.com>
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
1.8.3.1
