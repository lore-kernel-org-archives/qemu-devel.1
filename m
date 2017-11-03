Received: from eggs.gnu.org ([2001:4830:134:3::10]:48063)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <shankerd@codeaurora.org>) id 1eAbEo-0000my-3p
	for qemu-devel@nongnu.org; Fri, 03 Nov 2017 08:38:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <shankerd@codeaurora.org>) id 1eAbEn-0002Xr-7I
	for qemu-devel@nongnu.org; Fri, 03 Nov 2017 08:38:18 -0400
From: Shanker Donthineni <shankerd@codeaurora.org>
Date: Fri,  3 Nov 2017 07:37:51 -0500
Message-Id: <1509712671-16299-1-git-send-email-shankerd@codeaurora.org>
Subject: [Qemu-devel] [PATCH] hw/intc/arm_gicv3_its: Fix the VM termination
 in vm_change_state_handler()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Auger <eric.auger@redhat.com>, Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-arm <qemu-arm@nongnu.org>, qemu-devel <qemu-devel@nongnu.org>, Shanker Donthineni <shankerd@codeaurora.org>

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
Qualcomm Datacenter Technologies, Inc. on behalf of the Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
