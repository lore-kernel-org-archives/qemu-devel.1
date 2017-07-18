Received: from eggs.gnu.org ([2001:4830:134:3::10]:58211)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dXTR1-0006t7-On
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 10:25:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dXTQz-0004nQ-1j
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 10:25:11 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56466)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1dXTQy-0004ld-S0
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 10:25:08 -0400
From: Cornelia Huck <cohuck@redhat.com>
Date: Tue, 18 Jul 2017 16:24:50 +0200
Message-Id: <20170718142455.32676-5-cohuck@redhat.com>
In-Reply-To: <20170718142455.32676-1-cohuck@redhat.com>
References: <20170718142455.32676-1-cohuck@redhat.com>
Subject: [Qemu-devel] [PATCH RFC v2 4/9] s390x/pci: do not advertise pci on
 non-pci builds
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: borntraeger@de.ibm.com, agraf@suse.de, thuth@redhat.com, pmorel@linux.vnet.ibm.com, zyimin@linux.vnet.ibm.com, Cornelia Huck <cohuck@redhat.com>

Only set the zpci and aen feature bits on builds that actually
support pci.

Signed-off-by: Cornelia Huck <cohuck@redhat.com>
---
 target/s390x/kvm.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/target/s390x/kvm.c b/target/s390x/kvm.c
index 831492f9a2..880eccd58a 100644
--- a/target/s390x/kvm.c
+++ b/target/s390x/kvm.c
@@ -2685,8 +2685,10 @@ void kvm_s390_get_host_cpu_model(S390CPUModel *model, Error **errp)
     }
 
     /* set zpci and aen facilities */
+#ifdef CONFIG_PCI
     set_bit(S390_FEAT_ZPCI, model->features);
     set_bit(S390_FEAT_ADAPTER_EVENT_NOTIFICATION, model->features);
+#endif
 
     if (s390_known_cpu_type(cpu_type)) {
         /* we want the exact model, even if some features are missing */
-- 
2.13.3
