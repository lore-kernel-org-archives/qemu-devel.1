Received: from eggs.gnu.org ([2001:4830:134:3::10]:42522)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1d8Lco-0002Qo-FX
	for qemu-devel@nongnu.org; Wed, 10 May 2017 03:01:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1d8Lcm-0007mz-2Y
	for qemu-devel@nongnu.org; Wed, 10 May 2017 03:01:30 -0400
From: David Gibson <david@gibson.dropbear.id.au>
Date: Wed, 10 May 2017 17:01:02 +1000
Message-Id: <20170510070115.13063-10-david@gibson.dropbear.id.au>
In-Reply-To: <20170510070115.13063-1-david@gibson.dropbear.id.au>
References: <20170510070115.13063-1-david@gibson.dropbear.id.au>
Subject: [Qemu-devel] [PULL 09/22] ppc/xics: preserve P and Q bits for KVM
 IRQs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, mdroth@linux.vnet.ibm.com, bharata@linux.vnet.ibm.com, agraf@suse.de, aik@ozlabs.ru, sjitindarsingh@gmail.com, mark.cave-ayland@ilande.co.uk, sam.bobroff@au1.ibm.com, nikunj@linux.vnet.ibm.com, clg@kaod.org, David Gibson <david@gibson.dropbear.id.au>

From: Sam Bobroff <sam.bobroff@au1.ibm.com>

Kernel commit 17d48610ae0f ("KVM: PPC: Book 3S: XICS: Implement ICS
P/Q states") added new bits to the state used by KVM IRQs. Currently,
QEMU does not preserve these bits, so migrating (or otherwise saving
and restoring) the guest state causes the P and Q bits to be cleared.

Clearing the P bit has no effect, because the kernel will set it based
on other data, but the loss of a set Q bit will cause a lost
interrupt.

This patch preserves the P and Q bits, correcting the problem.

Signed-off-by: Sam Bobroff <sam.bobroff@au1.ibm.com>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/intc/xics_kvm.c    | 12 ++++++++++++
 include/hw/ppc/xics.h |  2 ++
 2 files changed, 14 insertions(+)

diff --git a/hw/intc/xics_kvm.c b/hw/intc/xics_kvm.c
index 03c1fc7..dd93531 100644
--- a/hw/intc/xics_kvm.c
+++ b/hw/intc/xics_kvm.c
@@ -229,6 +229,12 @@ static void ics_get_kvm_state(ICSState *ics)
                     | XICS_STATUS_REJECTED;
             }
         }
+        if (state & KVM_XICS_PRESENTED) {
+                irq->status |= XICS_STATUS_PRESENTED;
+        }
+        if (state & KVM_XICS_QUEUED) {
+                irq->status |= XICS_STATUS_QUEUED;
+        }
     }
 }
 
@@ -266,6 +272,12 @@ static int ics_set_kvm_state(ICSState *ics, int version_id)
                 state |= KVM_XICS_PENDING;
             }
         }
+        if (irq->status & XICS_STATUS_PRESENTED) {
+                state |= KVM_XICS_PRESENTED;
+        }
+        if (irq->status & XICS_STATUS_QUEUED) {
+                state |= KVM_XICS_QUEUED;
+        }
 
         ret = ioctl(kernel_xics_fd, KVM_SET_DEVICE_ATTR, &attr);
         if (ret != 0) {
diff --git a/include/hw/ppc/xics.h b/include/hw/ppc/xics.h
index c215dc7..68525c8 100644
--- a/include/hw/ppc/xics.h
+++ b/include/hw/ppc/xics.h
@@ -144,6 +144,8 @@ struct ICSIRQState {
 #define XICS_STATUS_SENT               0x2
 #define XICS_STATUS_REJECTED           0x4
 #define XICS_STATUS_MASKED_PENDING     0x8
+#define XICS_STATUS_PRESENTED          0x10
+#define XICS_STATUS_QUEUED             0x20
     uint8_t status;
 /* (flags & XICS_FLAGS_IRQ_MASK) == 0 means the interrupt is not allocated */
 #define XICS_FLAGS_IRQ_LSI             0x1
-- 
2.9.3
