Received: from eggs.gnu.org ([2001:4830:134:3::10]:51564)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1edamn-0001l9-Ez
	for qemu-devel@nongnu.org; Mon, 22 Jan 2018 07:01:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1edamj-0005vd-IE
	for qemu-devel@nongnu.org; Mon, 22 Jan 2018 07:01:13 -0500
From: Cornelia Huck <cohuck@redhat.com>
Date: Mon, 22 Jan 2018 13:00:41 +0100
Message-Id: <20180122120045.13538-6-cohuck@redhat.com>
In-Reply-To: <20180122120045.13538-1-cohuck@redhat.com>
References: <20180122120045.13538-1-cohuck@redhat.com>
Subject: [Qemu-devel] [PULL 5/9] s390x: fix storage attributes migration for
 non-small guests
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: qemu-devel@nongnu.org, qemu-s390x@nongnu.org, rth@twiddle.net, agraf@suse.de, thuth@redhat.com, borntraeger@de.ibm.com, david@redhat.com, Claudio Imbrenda <imbrenda@linux.vnet.ibm.com>, qemu-stable@nongnu.org, Cornelia Huck <cohuck@redhat.com>

From: Claudio Imbrenda <imbrenda@linux.vnet.ibm.com>

Fix storage attribute migration so that it does not fail for guests
with more than a few GB of RAM.
With such guests, the index in the buffer would go out of bounds,
usually by large amounts, thus receiving -EFAULT from the kernel.
Migration itself would be successful, but storage attributes would then
not be migrated completely.

This patch fixes the out of bounds access, and thus migration of all
storage attributes when the guest have large amounts of memory.

Cc: qemu-stable@nongnu.org
Signed-off-by: Claudio Imbrenda <imbrenda@linux.vnet.ibm.com>
Fixes: 903fd80b03243476 ("s390x/migration: Storage attributes device")
Message-Id: <1516297904-18188-1-git-send-email-imbrenda@linux.vnet.ibm.com>
Reviewed-by: Christian Borntraeger <borntraeger@de.ibm.com>
Signed-off-by: Cornelia Huck <cohuck@redhat.com>
---
 hw/s390x/s390-stattrib-kvm.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/s390x/s390-stattrib-kvm.c b/hw/s390x/s390-stattrib-kvm.c
index 41770a7dec..480551c3db 100644
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
2.13.6
