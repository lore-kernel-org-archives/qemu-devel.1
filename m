Received: from eggs.gnu.org ([209.51.188.92]:51716)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gtYiL-0002QZ-BG
	for qemu-devel@nongnu.org; Tue, 12 Feb 2019 09:07:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gtYiF-0007GY-1v
	for qemu-devel@nongnu.org; Tue, 12 Feb 2019 09:07:09 -0500
Received: from mx1.redhat.com ([209.132.183.28]:38612)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gtYiE-0007Ct-On
	for qemu-devel@nongnu.org; Tue, 12 Feb 2019 09:07:02 -0500
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Date: Tue, 12 Feb 2019 15:06:21 +0100
Message-Id: <20190212140621.17009-4-philmd@redhat.com>
In-Reply-To: <20190212140621.17009-1-philmd@redhat.com>
References: <20190212140621.17009-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 3/3] i386/kvm: ignore masked irqs when update
 msi routes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org
Cc: Changpeng Liu <changpeng.liu@intel.com>, Peter Xu <peterx@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>, "open list:X86" <kvm@vger.kernel.org>

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

  qemu-system-x86_64: vtd_interrupt_remap_msi: MSI address low 32 bit inv=
alid: 0x0

The error does not affect functionality of the guest since when we
failed to translate we'll just silently continue (which makes sense
since crashing the VM for this seems even worse), but still it's
better to fix it up.

Signed-off-by: Peter Xu <peterx@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Message-Id: <20190116030815.27273-5-peterx@redhat.com>
[PMD: this patch was first (incorrectly) introduced as a56de056c91f8]
Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 target/i386/kvm.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/target/i386/kvm.c b/target/i386/kvm.c
index 9af4542fb8..beae1b99da 100644
--- a/target/i386/kvm.c
+++ b/target/i386/kvm.c
@@ -3894,7 +3894,7 @@ static QLIST_HEAD(, MSIRouteEntry) msi_route_list =3D=
 \
 static void kvm_update_msi_routes_all(void *private, bool global,
                                       uint32_t index, uint32_t mask)
 {
-    int cnt =3D 0;
+    int cnt =3D 0, vector;
     MSIRouteEntry *entry;
     MSIMessage msg;
     PCIDevice *dev;
@@ -3902,11 +3902,19 @@ static void kvm_update_msi_routes_all(void *priva=
te, bool global,
     /* TODO: explicit route update */
     QLIST_FOREACH(entry, &msi_route_list, list) {
         cnt++;
+        vector =3D entry->vector;
         dev =3D entry->dev;
-        if (!msix_enabled(dev) && !msi_enabled(dev)) {
+        if (msix_enabled(dev) && !msix_is_masked(dev, vector)) {
+            msg =3D msix_get_message(dev, vector);
+        } else if (msi_enabled(dev) && !msi_is_masked(dev, vector)) {
+            msg =3D msi_get_message(dev, vector);
+        } else {
+            /*
+             * Either MSI/MSIX is disabled for the device, or the
+             * specific message was masked out.  Skip this one.
+             */
             continue;
         }
-        msg =3D pci_get_msi_message(dev, entry->vector);
         kvm_irqchip_update_msi_route(kvm_state, entry->virq, msg, dev);
     }
     kvm_irqchip_commit_routes(kvm_state);
--=20
2.20.1
