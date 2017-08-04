Received: from eggs.gnu.org ([2001:4830:134:3::10]:48105)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dddDG-0006HA-1h
	for qemu-devel@nongnu.org; Fri, 04 Aug 2017 10:04:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1ddaoC-0004AR-GS
	for qemu-devel@nongnu.org; Fri, 04 Aug 2017 07:31:30 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60082)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1ddaoC-00047z-70
	for qemu-devel@nongnu.org; Fri, 04 Aug 2017 07:30:24 -0400
From: Cornelia Huck <cohuck@redhat.com>
Date: Fri,  4 Aug 2017 13:29:45 +0200
Message-Id: <20170804112946.5247-9-cohuck@redhat.com>
In-Reply-To: <20170804112946.5247-1-cohuck@redhat.com>
References: <20170804112946.5247-1-cohuck@redhat.com>
Subject: [Qemu-devel] [PATCH v4 8/9] s390x/kvm: msi route fixup for non-pci
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
 target/s390x/kvm.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/target/s390x/kvm.c b/target/s390x/kvm.c
index 9de165d8b1..d8db1cbf6e 100644
--- a/target/s390x/kvm.c
+++ b/target/s390x/kvm.c
@@ -2424,6 +2424,12 @@ int kvm_arch_fixup_msi_route(struct kvm_irq_routing_entry *route,
     uint32_t idx = data >> ZPCI_MSI_VEC_BITS;
     uint32_t vec = data & ZPCI_MSI_VEC_MASK;
 
+    if (!s390_has_feat(S390_FEAT_ZPCI)) {
+        /* How can we get here without pci enabled? */
+        g_assert(false);
+        return -ENODEV;
+    }
+
     pbdev = s390_pci_find_dev_by_idx(s390_get_phb(), idx);
     if (!pbdev) {
         DPRINTF("add_msi_route no dev\n");
-- 
2.13.3
