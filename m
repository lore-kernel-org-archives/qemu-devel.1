Received: from eggs.gnu.org ([2001:4830:134:3::10]:33103)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lprosek@redhat.com>) id 1eOIOx-0000Cs-Qj
	for qemu-devel@nongnu.org; Mon, 11 Dec 2017 02:21:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lprosek@redhat.com>) id 1eOIOw-0003mV-Vk
	for qemu-devel@nongnu.org; Mon, 11 Dec 2017 02:21:23 -0500
Received: from mx1.redhat.com ([209.132.183.28]:34320)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lprosek@redhat.com>) id 1eOIOw-0003ls-Pa
	for qemu-devel@nongnu.org; Mon, 11 Dec 2017 02:21:22 -0500
From: Ladi Prosek <lprosek@redhat.com>
Date: Mon, 11 Dec 2017 08:21:10 +0100
Message-Id: <20171211072110.9058-5-lprosek@redhat.com>
In-Reply-To: <20171211072110.9058-1-lprosek@redhat.com>
References: <20171211072110.9058-1-lprosek@redhat.com>
Subject: [Qemu-devel] [PATCH v4 4/4] ivshmem: Disable irqfd on device reset
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, armbru@redhat.com, marcandre.lureau@redhat.com, geoff@hostfission.com, eblake@redhat.com

The effects of ivshmem_enable_irqfd() was not undone on device reset.

This manifested as:
ivshmem_add_kvm_msi_virq: Assertion `!s->msi_vectors[vector].pdev' failed.

when irqfd was enabled before reset and then enabled again after reset, making
ivshmem_enable_irqfd() run for the second time.

To reproduce, run:

  ivshmem-server

and QEMU with:

  -device ivshmem-doorbell,chardev=iv
  -chardev socket,path=/tmp/ivshmem_socket,id=iv

then install the Windows driver, at the time of writing available at:

https://github.com/virtio-win/kvm-guest-drivers-windows/tree/master/ivshmem

and crash-reboot the guest by inducing a BSOD.

Signed-off-by: Ladi Prosek <lprosek@redhat.com>
---
 hw/misc/ivshmem.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/hw/misc/ivshmem.c b/hw/misc/ivshmem.c
index d1bb246d12..9c7e74ef12 100644
--- a/hw/misc/ivshmem.c
+++ b/hw/misc/ivshmem.c
@@ -758,10 +758,14 @@ static void ivshmem_msix_vector_use(IVShmemState *s)
     }
 }
 
+static void ivshmem_disable_irqfd(IVShmemState *s);
+
 static void ivshmem_reset(DeviceState *d)
 {
     IVShmemState *s = IVSHMEM_COMMON(d);
 
+    ivshmem_disable_irqfd(s);
+
     s->intrstatus = 0;
     s->intrmask = 0;
     if (ivshmem_has_feature(s, IVSHMEM_MSI)) {
-- 
2.13.6
