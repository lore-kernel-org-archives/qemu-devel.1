Received: from eggs.gnu.org ([2001:4830:134:3::10]:52926)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1ddap2-0004Bx-2g
	for qemu-devel@nongnu.org; Fri, 04 Aug 2017 07:32:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1ddanx-0003hi-Ld
	for qemu-devel@nongnu.org; Fri, 04 Aug 2017 07:31:15 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40024)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1ddanx-0003fk-EI
	for qemu-devel@nongnu.org; Fri, 04 Aug 2017 07:30:09 -0400
From: Cornelia Huck <cohuck@redhat.com>
Date: Fri,  4 Aug 2017 13:29:41 +0200
Message-Id: <20170804112946.5247-5-cohuck@redhat.com>
In-Reply-To: <20170804112946.5247-1-cohuck@redhat.com>
References: <20170804112946.5247-1-cohuck@redhat.com>
Subject: [Qemu-devel] [PATCH v4 4/9] s390x/pci: do not advertise pci on
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
Cc: borntraeger@de.ibm.com, agraf@suse.de, thuth@redhat.com, david@redhat.com, pmorel@linux.vnet.ibm.com, zyimin@linux.vnet.ibm.com, Cornelia Huck <cohuck@redhat.com>

Only set the zpci feature bit on builds that actually support pci.

Signed-off-by: Cornelia Huck <cohuck@redhat.com>
---
 target/s390x/kvm.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/target/s390x/kvm.c b/target/s390x/kvm.c
index c4c5791d27..bc62bba5b7 100644
--- a/target/s390x/kvm.c
+++ b/target/s390x/kvm.c
@@ -2662,7 +2662,9 @@ void kvm_s390_get_host_cpu_model(S390CPUModel *model, Error **errp)
     }
 
     /* We emulate a zPCI bus and AEN, therefore we don't need HW support */
-    set_bit(S390_FEAT_ZPCI, model->features);
+    if (pci_available) {
+        set_bit(S390_FEAT_ZPCI, model->features);
+    }
     set_bit(S390_FEAT_ADAPTER_EVENT_NOTIFICATION, model->features);
 
     if (s390_known_cpu_type(cpu_type)) {
-- 
2.13.3
