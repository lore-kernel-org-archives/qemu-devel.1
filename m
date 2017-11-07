Received: from eggs.gnu.org ([2001:4830:134:3::10]:36828)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1eC41n-0006XK-Cr
	for qemu-devel@nongnu.org; Tue, 07 Nov 2017 08:35:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1eC41m-0005zG-7z
	for qemu-devel@nongnu.org; Tue, 07 Nov 2017 08:34:55 -0500
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:38242)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1eC41m-0005xq-1Q
	for qemu-devel@nongnu.org; Tue, 07 Nov 2017 08:34:54 -0500
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1eC41l-0004Uq-2o
	for qemu-devel@nongnu.org; Tue, 07 Nov 2017 13:34:53 +0000
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue,  7 Nov 2017 13:35:21 +0000
Message-Id: <1510061722-14092-7-git-send-email-peter.maydell@linaro.org>
In-Reply-To: <1510061722-14092-1-git-send-email-peter.maydell@linaro.org>
References: <1510061722-14092-1-git-send-email-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PULL 6/7] hw/intc/arm_gicv3_its: Fix the VM
 termination in vm_change_state_handler()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

From: Shanker Donthineni <shankerd@codeaurora.org>

The commit cddafd8f353d ("hw/intc/arm_gicv3_its: Implement state save
/restore") breaks the backward compatibility with the older kernels
where vITS save/restore support is not available. The vmstate function
vm_change_state_handler() should not be registered if the running kernel
doesn't support ITS save/restore feature. Otherwise VM instance will be
killed whenever vmstate callback function is invoked.

Observed a virtual machine shutdown with QEMU-2.10+linux-4.11 when testing
the reboot command "virsh reboot <domain> --mode acpi" instead of reboot.

KVM Error: 'KVM_SET_DEVICE_ATTR failed: Group 4 attr 0x00000000000001'

Signed-off-by: Shanker Donthineni <shankerd@codeaurora.org>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Message-id: 1509712671-16299-1-git-send-email-shankerd@codeaurora.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/intc/arm_gicv3_its_kvm.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/intc/arm_gicv3_its_kvm.c b/hw/intc/arm_gicv3_its_kvm.c
index 39903d5..9b00ce5 100644
--- a/hw/intc/arm_gicv3_its_kvm.c
+++ b/hw/intc/arm_gicv3_its_kvm.c
@@ -111,13 +111,13 @@ static void kvm_arm_its_realize(DeviceState *dev, Error **errp)
             error_free(s->migration_blocker);
             return;
         }
+    } else {
+        qemu_add_vm_change_state_handler(vm_change_state_handler, s);
     }
 
     kvm_msi_use_devid = true;
     kvm_gsi_direct_mapping = false;
     kvm_msi_via_irqfd_allowed = kvm_irqfds_enabled();
-
-    qemu_add_vm_change_state_handler(vm_change_state_handler, s);
 }
 
 /**
-- 
2.7.4
