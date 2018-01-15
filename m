Received: from eggs.gnu.org ([2001:4830:134:3::10]:59788)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imbrenda@linux.vnet.ibm.com>) id 1eb7za-0001kf-Nz
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 11:52:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imbrenda@linux.vnet.ibm.com>) id 1eb7zW-0007G0-NH
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 11:52:14 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:46402
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imbrenda@linux.vnet.ibm.com>)
	id 1eb7zW-0007EO-HB
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 11:52:10 -0500
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w0FGdf3x119320
	for <qemu-devel@nongnu.org>; Mon, 15 Jan 2018 11:52:08 -0500
Received: from e06smtp11.uk.ibm.com (e06smtp11.uk.ibm.com [195.75.94.107])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2fgy4ku4ey-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 15 Jan 2018 11:52:08 -0500
Received: from localhost
	by e06smtp11.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <imbrenda@linux.vnet.ibm.com>;
	Mon, 15 Jan 2018 16:52:06 -0000
From: Claudio Imbrenda <imbrenda@linux.vnet.ibm.com>
Date: Mon, 15 Jan 2018 17:52:02 +0100
Message-Id: <1516035122-7617-1-git-send-email-imbrenda@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH v1 1/1] s390x: fix storage attributes migration
 for non-small guests
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: cohuck@redhat.com

Fix storage attribute migration so that it does not fail for guests
with more than a few GB of RAM. Migration itself was successful, but
storage attributes were not migrated completely.

This patch fixes the migration of all storage attributes, even when the
guest have large amounts of memory.

Signed-off-by: Claudio Imbrenda <imbrenda@linux.vnet.ibm.com>
Fixes: 903fd80b03243476 ("s390x/migration: Storage attributes device")
---
 hw/s390x/s390-stattrib-kvm.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/s390x/s390-stattrib-kvm.c b/hw/s390x/s390-stattrib-kvm.c
index 41770a7..480551c 100644
--- a/hw/s390x/s390-stattrib-kvm.c
+++ b/hw/s390x/s390-stattrib-kvm.c
@@ -116,7 +116,7 @@ static void kvm_s390_stattrib_synchronize(S390StAttribState *sa)
         for (cx = 0; cx + len <= max; cx += len) {
             clog.start_gfn = cx;
             clog.count = len;
-            clog.values = (uint64_t)(sas->incoming_buffer + cx * len);
+            clog.values = (uint64_t)(sas->incoming_buffer + cx);
             r = kvm_vm_ioctl(kvm_state, KVM_S390_SET_CMMA_BITS, &clog);
             if (r) {
                 error_report("KVM_S390_SET_CMMA_BITS failed: %s", strerror(-r));
@@ -126,7 +126,7 @@ static void kvm_s390_stattrib_synchronize(S390StAttribState *sa)
         if (cx < max) {
             clog.start_gfn = cx;
             clog.count = max - cx;
-            clog.values = (uint64_t)(sas->incoming_buffer + cx * len);
+            clog.values = (uint64_t)(sas->incoming_buffer + cx);
             r = kvm_vm_ioctl(kvm_state, KVM_S390_SET_CMMA_BITS, &clog);
             if (r) {
                 error_report("KVM_S390_SET_CMMA_BITS failed: %s", strerror(-r));
-- 
2.7.4
