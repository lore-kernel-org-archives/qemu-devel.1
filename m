Received: from eggs.gnu.org ([2001:4830:134:3::10]:52498)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1da1qi-0000PG-Vl
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 11:34:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1da1qi-0008RE-CC
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 11:34:17 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50050)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1da1qi-0008Qp-5j
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 11:34:16 -0400
From: Cornelia Huck <cohuck@redhat.com>
Date: Tue, 25 Jul 2017 17:33:29 +0200
Message-Id: <20170725153330.14966-9-cohuck@redhat.com>
In-Reply-To: <20170725153330.14966-1-cohuck@redhat.com>
References: <20170725153330.14966-1-cohuck@redhat.com>
Subject: [Qemu-devel] [PATCH v3 8/9] s390x/kvm: msi route fixup for non-pci
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

If we don't provide pci, we cannot have a pci device for which we
have to translate to adapter routes: just return -ENODEV.

Signed-off-by: Cornelia Huck <cohuck@redhat.com>
---
 target/s390x/kvm.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/target/s390x/kvm.c b/target/s390x/kvm.c
index dc3f940b95..fb3e21a3a4 100644
--- a/target/s390x/kvm.c
+++ b/target/s390x/kvm.c
@@ -2424,6 +2424,11 @@ int kvm_arch_fixup_msi_route(struct kvm_irq_routing_entry *route,
     uint32_t idx = data >> ZPCI_MSI_VEC_BITS;
     uint32_t vec = data & ZPCI_MSI_VEC_MASK;
 
+    if (!s390_has_feat(S390_FEAT_ZPCI)) {
+        DPRINTF("fixup_msi_route on non-pci machine?!\n");
+        return -ENODEV;
+    }
+
     pbdev = s390_pci_find_dev_by_idx(s390_get_phb(), idx);
     if (!pbdev) {
         DPRINTF("add_msi_route no dev\n");
-- 
2.13.3
