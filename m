Received: from eggs.gnu.org ([2001:4830:134:3::10]:44898)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1eimST-0004f7-F4
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 14:29:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1eimSS-00055R-F2
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 14:29:41 -0500
Received: from mail-wr0-x244.google.com ([2a00:1450:400c:c0c::244]:44261)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1eimSS-000559-7n
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 14:29:40 -0500
Received: by mail-wr0-x244.google.com with SMTP id v31so30823550wrc.11
	for <qemu-devel@nongnu.org>; Mon, 05 Feb 2018 11:29:40 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon,  5 Feb 2018 20:28:43 +0100
Message-Id: <1517858941-5538-30-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1517858941-5538-1-git-send-email-pbonzini@redhat.com>
References: <1517858941-5538-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 29/47] ivshmem: Disable irqfd on device reset
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
Message-Id: <20171211072110.9058-5-lprosek@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/misc/ivshmem.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/hw/misc/ivshmem.c b/hw/misc/ivshmem.c
index fe1d8d1..16f0370 100644
--- a/hw/misc/ivshmem.c
+++ b/hw/misc/ivshmem.c
@@ -757,10 +757,14 @@ static void ivshmem_msix_vector_use(IVShmemState *s)
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
1.8.3.1
