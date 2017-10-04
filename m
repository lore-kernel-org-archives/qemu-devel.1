Received: from eggs.gnu.org ([2001:4830:134:3::10]:58681)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1dzhNQ-00061W-CR
	for qemu-devel@nongnu.org; Wed, 04 Oct 2017 06:58:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1dzhNL-0005Ih-IN
	for qemu-devel@nongnu.org; Wed, 04 Oct 2017 06:58:08 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:55874)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <borntraeger@de.ibm.com>)
	id 1dzhNK-0005Gr-Up
	for qemu-devel@nongnu.org; Wed, 04 Oct 2017 06:58:03 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v94AruFs054298
	for <qemu-devel@nongnu.org>; Wed, 4 Oct 2017 06:57:59 -0400
Received: from e06smtp10.uk.ibm.com (e06smtp10.uk.ibm.com [195.75.94.106])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2dcvyxvmmj-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 04 Oct 2017 06:57:58 -0400
Received: from localhost
	by e06smtp10.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <borntraeger@de.ibm.com>;
	Wed, 4 Oct 2017 11:57:56 +0100
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Wed,  4 Oct 2017 12:57:51 +0200
In-Reply-To: <20171004105751.24655-1-borntraeger@de.ibm.com>
References: <20171004105751.24655-1-borntraeger@de.ibm.com>
Message-Id: <20171004105751.24655-3-borntraeger@de.ibm.com>
Subject: [Qemu-devel] [PATCH v2 2/2] s390/kvm: make TOD setting failures
 fatal for migration
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, Alexander Graf <agraf@suse.de>, Thomas Huth <thuth@redhat.com>, David Hildenbrand <david@redhat.com>, Richard Henderson <rth@twiddle.net>, "Collin L. Walling" <walling@linux.vnet.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>

From: "Collin L. Walling" <walling@linux.vnet.ibm.com>

If we fail to set a proper TOD clock on the target system,  this can
already result in some problematic cases. We print several warn messages
on source and target in that case.

If kvm fails to set a nonzero epoch index, then we must ultimately fail
the migration as this will result in a giant time leap backwards. This
patch lets the migration fail if we can not set the guest time on the
target.

On failure the guest will resume normally on the original host machine.

Signed-off-by: Collin L. Walling <walling@linux.vnet.ibm.com>
Reviewed-by: Eric Farman <farman@linux.vnet.ibm.com>
Reviewed-by: Claudio Imbrenda <imbrenda@linux.vnet.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
[split failure change from epoch index change, minor fixups]
---
 hw/s390x/s390-virtio-ccw.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
index fafbc6d..b7adb93 100644
--- a/hw/s390x/s390-virtio-ccw.c
+++ b/hw/s390x/s390-virtio-ccw.c
@@ -213,13 +213,10 @@ static int gtod_load(QEMUFile *f, void *opaque, int version_id)
 
     r = s390_set_clock(&tod_high, &tod_low);
     if (r) {
-        warn_report("Unable to set guest clock for migration: %s",
-                    strerror(-r));
-        error_printf("Guest clock will not be restored "
-                     "which could cause the guest to hang.");
+        error_report("Unable to set KVM guest TOD clock: %s", strerror(-r));
     }
 
-    return 0;
+    return r;
 }
 
 static SaveVMHandlers savevm_gtod = {
-- 
2.9.4
