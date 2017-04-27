Received: from eggs.gnu.org ([2001:4830:134:3::10]:39752)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sam.bobroff@au1.ibm.com>) id 1d3czO-0006zD-Jo
	for qemu-devel@nongnu.org; Thu, 27 Apr 2017 02:33:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sam.bobroff@au1.ibm.com>) id 1d3czN-00049y-Ka
	for qemu-devel@nongnu.org; Thu, 27 Apr 2017 02:33:18 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:45027)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <sam.bobroff@au1.ibm.com>)
	id 1d3czN-00049q-CA
	for qemu-devel@nongnu.org; Thu, 27 Apr 2017 02:33:17 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v3R6T8cQ047838
	for <qemu-devel@nongnu.org>; Thu, 27 Apr 2017 02:33:16 -0400
Received: from e23smtp06.au.ibm.com (e23smtp06.au.ibm.com [202.81.31.148])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2a32j3sk2p-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 27 Apr 2017 02:33:14 -0400
Received: from localhost
	by e23smtp06.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <sam.bobroff@au1.ibm.com>;
	Thu, 27 Apr 2017 16:33:10 +1000
Date: Thu, 27 Apr 2017 16:32:03 +1000
From: Sam Bobroff <sam.bobroff@au1.ibm.com>
References: <cover.1493274659.git.sam.bobroff@au1.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1493274659.git.sam.bobroff@au1.ibm.com>
Message-Id: <20170427063203.GC11487@tungsten.ozlabs.ibm.com>
Subject: [Qemu-devel] [PATCH 2/2] ppc/xics: preserve P and Q bits for KVM
 IRQs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-ppc@nongnu.org
Cc: qemu-devel@nongnu.org, david@gibson.dropbear.id.au

Kernel commit 17d48610ae0f ("KVM: PPC: Book 3S: XICS: Implement ICS
P/Q states") added new bits to the state used by KVM IRQs. Currently,
QEMU does not preserve these bits, so migrating (or otherwise saving
and restoring) the guest state causes the P and Q bits to be cleared.

Clearing the P bit has no effect, because the kernel will set it based
on other data, but the loss of a set Q bit will cause a lost
interrupt.

This patch preserves the P and Q bits, correcting the problem.

Signed-off-by: Sam Bobroff <sam.bobroff@au1.ibm.com>
---
 hw/intc/xics_kvm.c    | 12 ++++++++++++
 include/hw/ppc/xics.h |  2 ++
 2 files changed, 14 insertions(+)

diff --git a/hw/intc/xics_kvm.c b/hw/intc/xics_kvm.c
index 03c1fc77cb..dd93531ae3 100644
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
index 9a5e715fe5..36c79eb45c 100644
--- a/include/hw/ppc/xics.h
+++ b/include/hw/ppc/xics.h
@@ -131,6 +131,8 @@ struct ICSIRQState {
 #define XICS_STATUS_SENT               0x2
 #define XICS_STATUS_REJECTED           0x4
 #define XICS_STATUS_MASKED_PENDING     0x8
+#define XICS_STATUS_PRESENTED          0x10
+#define XICS_STATUS_QUEUED             0x20
     uint8_t status;
 /* (flags & XICS_FLAGS_IRQ_MASK) == 0 means the interrupt is not allocated */
 #define XICS_FLAGS_IRQ_LSI             0x1
-- 
2.12.1.382.gc0f9c7058
