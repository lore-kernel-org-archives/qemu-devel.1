Received: from eggs.gnu.org ([2001:4830:134:3::10]:44872)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1eimSR-0004dJ-T0
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 14:29:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1eimSP-00054E-4W
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 14:29:39 -0500
Received: from mail-wm0-x242.google.com ([2a00:1450:400c:c09::242]:33630)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1eimSO-000541-TW
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 14:29:37 -0500
Received: by mail-wm0-x242.google.com with SMTP id x4-v6so14586036wmc.0
	for <qemu-devel@nongnu.org>; Mon, 05 Feb 2018 11:29:36 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon,  5 Feb 2018 20:28:40 +0100
Message-Id: <1517858941-5538-27-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1517858941-5538-1-git-send-email-pbonzini@redhat.com>
References: <1517858941-5538-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 26/47] ivshmem: Don't update non-existent MSI
 routes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Ladi Prosek <lprosek@redhat.com>

From: Ladi Prosek <lprosek@redhat.com>

As of commit 660c97eef6f8 ("ivshmem: use kvm irqfd for msi notifications"),
QEMU crashes with:

  kvm_irqchip_commit_routes: Assertion `ret == 0' failed.

if the ivshmem device is configured with more vectors than what the server
supports. This is caused by the ivshmem_vector_unmask() being called on
vectors that have not been initialized by ivshmem_add_kvm_msi_virq().

This commit fixes it by adding a simple check to the mask and unmask
callbacks.

Note that the opposite mismatch, if the server supplies more vectors than
what the device is configured for, is already handled and leads to output
like:

  Too many eventfd received, device has 1 vectors

To reproduce the assert, run:

  ivshmem-server -n 0

and QEMU with:

  -device ivshmem-doorbell,chardev=iv
  -chardev socket,path=/tmp/ivshmem_socket,id=iv

then load the Windows driver, at the time of writing available at:

https://github.com/virtio-win/kvm-guest-drivers-windows/tree/master/ivshmem

The issue is believed to have been masked by other guest drivers, notably
Linux ones, not enabling MSI-X on the device.

Fixes: 660c97eef6f8 ("ivshmem: use kvm irqfd for msi notifications")
Signed-off-by: Ladi Prosek <lprosek@redhat.com>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
Message-Id: <20171211072110.9058-2-lprosek@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/misc/ivshmem.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/hw/misc/ivshmem.c b/hw/misc/ivshmem.c
index 4919011..0b471d9 100644
--- a/hw/misc/ivshmem.c
+++ b/hw/misc/ivshmem.c
@@ -316,6 +316,10 @@ static int ivshmem_vector_unmask(PCIDevice *dev, unsigned vector,
     int ret;
 
     IVSHMEM_DPRINTF("vector unmask %p %d\n", dev, vector);
+    if (!v->pdev) {
+        error_report("ivshmem: vector %d route does not exist", vector);
+        return -EINVAL;
+    }
 
     ret = kvm_irqchip_update_msi_route(kvm_state, v->virq, msg, dev);
     if (ret < 0) {
@@ -330,12 +334,16 @@ static void ivshmem_vector_mask(PCIDevice *dev, unsigned vector)
 {
     IVShmemState *s = IVSHMEM_COMMON(dev);
     EventNotifier *n = &s->peers[s->vm_id].eventfds[vector];
+    MSIVector *v = &s->msi_vectors[vector];
     int ret;
 
     IVSHMEM_DPRINTF("vector mask %p %d\n", dev, vector);
+    if (!v->pdev) {
+        error_report("ivshmem: vector %d route does not exist", vector);
+        return;
+    }
 
-    ret = kvm_irqchip_remove_irqfd_notifier_gsi(kvm_state, n,
-                                                s->msi_vectors[vector].virq);
+    ret = kvm_irqchip_remove_irqfd_notifier_gsi(kvm_state, n, v->virq);
     if (ret != 0) {
         error_report("remove_irqfd_notifier_gsi failed");
     }
-- 
1.8.3.1
