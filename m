Received: from eggs.gnu.org ([2001:4830:134:3::10]:60480)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1dv3CF-00057b-8B
	for qemu-devel@nongnu.org; Thu, 21 Sep 2017 11:15:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1dv3CC-0006PC-JU
	for qemu-devel@nongnu.org; Thu, 21 Sep 2017 11:15:23 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:50882
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <borntraeger@de.ibm.com>)
	id 1dv3CC-0006Ox-Do
	for qemu-devel@nongnu.org; Thu, 21 Sep 2017 11:15:20 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v8LFFHkB096604
	for <qemu-devel@nongnu.org>; Thu, 21 Sep 2017 11:15:19 -0400
Received: from e06smtp10.uk.ibm.com (e06smtp10.uk.ibm.com [195.75.94.106])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2d4e1h6due-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 21 Sep 2017 11:15:18 -0400
Received: from localhost
	by e06smtp10.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <borntraeger@de.ibm.com>;
	Thu, 21 Sep 2017 16:14:51 +0100
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Thu, 21 Sep 2017 17:14:46 +0200
In-Reply-To: <20170921151446.40015-1-borntraeger@de.ibm.com>
References: <20170921151446.40015-1-borntraeger@de.ibm.com>
Message-Id: <20170921151446.40015-2-borntraeger@de.ibm.com>
Subject: [Qemu-devel] [PATCH 1/1] s390x/ais: for 2.10 stable: disable ais
 facility
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>
Cc: Michael Roth <mdroth@linux.vnet.ibm.com>, Richard Henderson <rth@twiddle.net>, Alexander Graf <agraf@suse.de>, Yi Min Zhao <zyimin@linux.vnet.ibm.com>, Halil Pasic <pasic@linux.vnet.ibm.com>, qemu-devel <qemu-devel@nongnu.org>, David Hildenbrand <david@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>

The migration interface for ais was introduced with kernel 4.13
but the capability itself had been active since 4.12. As migration
support is considered necessary lets disable ais in the 2.10
stable version. A proper fix and re-enablement will be done
for qemu 2.11.

Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
Reviewed-by: Cornelia Huck <cohuck@redhat.com>
---
 target/s390x/kvm.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/target/s390x/kvm.c b/target/s390x/kvm.c
index c4c5791..eb0dbb3 100644
--- a/target/s390x/kvm.c
+++ b/target/s390x/kvm.c
@@ -308,8 +308,13 @@ int kvm_arch_init(MachineState *ms, KVMState *s)
         }
     }
 
-    /* Try to enable AIS facility */
-    kvm_vm_enable_cap(s, KVM_CAP_S390_AIS, 0);
+    /*
+     * The migration interface for ais was introduced with kernel 4.13
+     * but the capability itself had been active since 4.12. As migration
+     * support is considered necessary let's disable ais in the 2.10
+     * machine.
+     */
+    /* kvm_vm_enable_cap(s, KVM_CAP_S390_AIS, 0); */
 
     qemu_mutex_init(&qemu_sigp_mutex);
 
-- 
2.9.4
