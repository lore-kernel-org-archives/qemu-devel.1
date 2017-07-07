Received: from eggs.gnu.org ([2001:4830:134:3::10]:36828)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dTSH4-0008Pn-VR
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 08:22:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dTSH0-0005tm-T3
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 08:22:18 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33212)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1dTSH0-0005tL-N3
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 08:22:14 -0400
From: Cornelia Huck <cohuck@redhat.com>
Date: Fri,  7 Jul 2017 14:21:58 +0200
Message-Id: <20170707122159.24714-7-cohuck@redhat.com>
In-Reply-To: <20170707122159.24714-1-cohuck@redhat.com>
References: <20170707122159.24714-1-cohuck@redhat.com>
Subject: [Qemu-devel] [PATCH RFC 6/7] s390x/kvm: msi route fixup for non-pci
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

On non-pci builds, we cannot have a pci device for which we
have to translate to adapter routes: just return -ENODEV.

Signed-off-by: Cornelia Huck <cohuck@redhat.com>
---
 target/s390x/kvm.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/target/s390x/kvm.c b/target/s390x/kvm.c
index c5c7c27a21..911b6da3f0 100644
--- a/target/s390x/kvm.c
+++ b/target/s390x/kvm.c
@@ -2351,6 +2351,7 @@ int kvm_s390_vcpu_interrupt_post_load(S390CPU *cpu)
 int kvm_arch_fixup_msi_route(struct kvm_irq_routing_entry *route,
                              uint64_t address, uint32_t data, PCIDevice *dev)
 {
+#ifdef CONFIG_PCI
     S390PCIBusDevice *pbdev;
     uint32_t idx = data >> ZPCI_MSI_VEC_BITS;
     uint32_t vec = data & ZPCI_MSI_VEC_MASK;
@@ -2371,6 +2372,9 @@ int kvm_arch_fixup_msi_route(struct kvm_irq_routing_entry *route,
     route->u.adapter.ind_offset = pbdev->routes.adapter.ind_offset;
     route->u.adapter.adapter_id = pbdev->routes.adapter.adapter_id;
     return 0;
+#else
+    return -ENODEV;
+#endif
 }
 
 int kvm_arch_add_msi_route_post(struct kvm_irq_routing_entry *route,
-- 
2.13.0
