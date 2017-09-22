Received: from eggs.gnu.org ([2001:4830:134:3::10]:51352)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1dvJUM-0005TA-Iu
	for qemu-devel@nongnu.org; Fri, 22 Sep 2017 04:39:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1dvJUJ-0003uX-Ff
	for qemu-devel@nongnu.org; Fri, 22 Sep 2017 04:39:10 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:51236)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <borntraeger@de.ibm.com>)
	id 1dvJUJ-0003tl-6W
	for qemu-devel@nongnu.org; Fri, 22 Sep 2017 04:39:07 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v8M8cwID093334
	for <qemu-devel@nongnu.org>; Fri, 22 Sep 2017 04:39:02 -0400
Received: from e06smtp14.uk.ibm.com (e06smtp14.uk.ibm.com [195.75.94.110])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2d4xnn1k9e-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 22 Sep 2017 04:39:02 -0400
Received: from localhost
	by e06smtp14.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <borntraeger@de.ibm.com>;
	Fri, 22 Sep 2017 09:38:59 +0100
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Fri, 22 Sep 2017 10:38:53 +0200
In-Reply-To: <20170922083855.102341-1-borntraeger@de.ibm.com>
References: <20170922083855.102341-1-borntraeger@de.ibm.com>
Message-Id: <20170922083855.102341-2-borntraeger@de.ibm.com>
Subject: [Qemu-devel] [PATCH/RFC 1/3] s390x/ais: disable ais facility as it
 is broken
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>
Cc: Richard Henderson <rth@twiddle.net>, Alexander Graf <agraf@suse.de>, Yi Min Zhao <zyimin@linux.vnet.ibm.com>, Halil Pasic <pasic@linux.vnet.ibm.com>, qemu-devel <qemu-devel@nongnu.org>, David Hildenbrand <david@redhat.com>, "Jason J . Herne" <jjherne@linux.vnet.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>

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
index 720cb1d..ebb75ca 100644
--- a/target/s390x/kvm.c
+++ b/target/s390x/kvm.c
@@ -311,8 +311,13 @@ int kvm_arch_init(MachineState *ms, KVMState *s)
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
