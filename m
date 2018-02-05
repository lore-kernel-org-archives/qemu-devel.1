Received: from eggs.gnu.org ([2001:4830:134:3::10]:57563)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ppandit@redhat.com>) id 1eia7I-00027X-QH
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 01:19:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ppandit@redhat.com>) id 1eia7E-0002Jo-Hi
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 01:19:00 -0500
Received: from mx1.redhat.com ([209.132.183.28]:43216)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ppandit@redhat.com>) id 1eia7E-0002IR-Am
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 01:18:56 -0500
From: P J P <ppandit@redhat.com>
Date: Mon,  5 Feb 2018 11:48:49 +0530
Message-Id: <20180205061849.17696-1-ppandit@redhat.com>
Subject: [Qemu-devel] [PATCH] kvm: check dev parameter when updating msi
 route
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Qemu Developers <qemu-devel@nongnu.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Guoxiang Niu <niuguoxiang@huawei.com>, =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>, Prasad J Pandit <pjp@fedoraproject.org>

From: Prasad J Pandit <pjp@fedoraproject.org>

When updating message signalled interrupt(MSI) route in routine
kvm_irqchip_update_msi_route, device parameter could be null.
Add check to avoid null dereference.

Reported-by: Guoxiang Niu <niuguoxiang@huawei.com>
Signed-off-by: Prasad J Pandit <pjp@fedoraproject.org>
---
 accel/kvm/kvm-all.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index f290f487a5..cb7613d282 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -1167,7 +1167,7 @@ int kvm_irqchip_add_msi_route(KVMState *s, int vector, PCIDevice *dev)
     kroute.u.msi.address_lo = (uint32_t)msg.address;
     kroute.u.msi.address_hi = msg.address >> 32;
     kroute.u.msi.data = le32_to_cpu(msg.data);
-    if (pci_available && kvm_msi_devid_required()) {
+    if (pci_available && dev && kvm_msi_devid_required()) {
         kroute.flags = KVM_MSI_VALID_DEVID;
         kroute.u.msi.devid = pci_requester_id(dev);
     }
@@ -1205,7 +1205,7 @@ int kvm_irqchip_update_msi_route(KVMState *s, int virq, MSIMessage msg,
     kroute.u.msi.address_lo = (uint32_t)msg.address;
     kroute.u.msi.address_hi = msg.address >> 32;
     kroute.u.msi.data = le32_to_cpu(msg.data);
-    if (pci_available && kvm_msi_devid_required()) {
+    if (pci_available && dev && kvm_msi_devid_required()) {
         kroute.flags = KVM_MSI_VALID_DEVID;
         kroute.u.msi.devid = pci_requester_id(dev);
     }
-- 
2.14.3
