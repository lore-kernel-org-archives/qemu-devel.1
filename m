Received: from eggs.gnu.org ([209.51.188.92]:45802)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1gqfaa-00066J-EB
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 09:51:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1gqfTS-0005a3-34
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 09:43:51 -0500
Received: from mail-qt1-f169.google.com ([209.85.160.169]:46915)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1gqfTR-0005ZC-Qh
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 09:43:49 -0500
Received: by mail-qt1-f169.google.com with SMTP id y20so31168qtm.13
	for <qemu-devel@nongnu.org>; Mon, 04 Feb 2019 06:43:49 -0800 (PST)
Date: Mon, 4 Feb 2019 09:43:46 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20190204142638.27021-15-mst@redhat.com>
References: <20190204142638.27021-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190204142638.27021-1-mst@redhat.com>
Subject: [Qemu-devel] [PULL 14/25] i386/kvm: ignore masked irqs when update
 msi routes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Peter Xu <peterx@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>, kvm@vger.kernel.org

From: Peter Xu <peterx@redhat.com>

When we are with intel-iommu device and with IR on, KVM will register
an IEC notifier to detect interrupt updates from the guest and we'll
kick off kvm_update_msi_routes_all() when it happens to make sure
kernel IRQ cache is matching the latest.

Though, kvm_update_msi_routes_all() is buggy in that it ignored the
mask bit of either MSI/MSIX messages and it tries to translate the
message even if the corresponding message was already masked by the
guest driver (hence the MSI/MSIX message will be invalid).

Without this patch, we can receive an error message when we reboot a
guest with both an assigned vfio-pci device and intel-iommu enabled:

  qemu-system-x86_64: vtd_interrupt_remap_msi: MSI address low 32 bit invalid: 0x0

The error does not affect functionality of the guest since when we
failed to translate we'll just silently continue (which makes sense
since crashing the VM for this seems even worse), but still it's
better to fix it up.

Signed-off-by: Peter Xu <peterx@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 target/i386/kvm.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/target/i386/kvm.c b/target/i386/kvm.c
index 9af4542fb8..beae1b99da 100644
--- a/target/i386/kvm.c
+++ b/target/i386/kvm.c
@@ -3894,7 +3894,7 @@ static QLIST_HEAD(, MSIRouteEntry) msi_route_list = \
 static void kvm_update_msi_routes_all(void *private, bool global,
                                       uint32_t index, uint32_t mask)
 {
-    int cnt = 0;
+    int cnt = 0, vector;
     MSIRouteEntry *entry;
     MSIMessage msg;
     PCIDevice *dev;
@@ -3902,11 +3902,19 @@ static void kvm_update_msi_routes_all(void *private, bool global,
     /* TODO: explicit route update */
     QLIST_FOREACH(entry, &msi_route_list, list) {
         cnt++;
+        vector = entry->vector;
         dev = entry->dev;
-        if (!msix_enabled(dev) && !msi_enabled(dev)) {
+        if (msix_enabled(dev) && !msix_is_masked(dev, vector)) {
+            msg = msix_get_message(dev, vector);
+        } else if (msi_enabled(dev) && !msi_is_masked(dev, vector)) {
+            msg = msi_get_message(dev, vector);
+        } else {
+            /*
+             * Either MSI/MSIX is disabled for the device, or the
+             * specific message was masked out.  Skip this one.
+             */
             continue;
         }
-        msg = pci_get_msi_message(dev, entry->vector);
         kvm_irqchip_update_msi_route(kvm_state, entry->virq, msg, dev);
     }
     kvm_irqchip_commit_routes(kvm_state);
-- 
MST
