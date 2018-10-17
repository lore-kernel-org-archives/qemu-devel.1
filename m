Received: from eggs.gnu.org ([2001:4830:134:3::10]:56025)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peng.hao2@zte.com.cn>) id 1gChP0-0004D2-Fu
	for qemu-devel@nongnu.org; Wed, 17 Oct 2018 04:42:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peng.hao2@zte.com.cn>) id 1gChOv-0007uN-SP
	for qemu-devel@nongnu.org; Wed, 17 Oct 2018 04:42:02 -0400
Received: from out1.zte.com.cn ([202.103.147.172]:58332 helo=mxct.zte.com.cn)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peng.hao2@zte.com.cn>)
	id 1gChOv-0007PP-BJ
	for qemu-devel@nongnu.org; Wed, 17 Oct 2018 04:41:57 -0400
From: Peng Hao <peng.hao2@zte.com.cn>
Date: Thu, 18 Oct 2018 00:52:53 +0800
Message-Id: <1539795177-21038-2-git-send-email-peng.hao2@zte.com.cn>
In-Reply-To: <1539795177-21038-1-git-send-email-peng.hao2@zte.com.cn>
References: <1539795177-21038-1-git-send-email-peng.hao2@zte.com.cn>
Subject: [Qemu-devel] [PATCH V6 1/5] target/i386 : add coalesced pio support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: pbonzini@redhat.com, rkrcmar@redhat.com, mst@redhat.com, ehabkost@redhat.com
Cc: qemu-devel@nongnu.org, kvm@vger.kernel.org, Peng Hao <peng.hao2@zte.com.cn>

add coalesced_pio's struct and KVM_CAP_COALESCED_PIO header.

Signed-off-by: Peng Hao <peng.hao2@zte.com.cn>
---
 accel/kvm/kvm-all.c       | 4 ++--
 linux-headers/linux/kvm.h | 9 ++++++++-
 2 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index de12f78..29d208d 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -537,7 +537,7 @@ static void kvm_coalesce_mmio_region(MemoryListener *listener,
 
         zone.addr = start;
         zone.size = size;
-        zone.pad = 0;
+        zone.pio = 0;
 
         (void)kvm_vm_ioctl(s, KVM_REGISTER_COALESCED_MMIO, &zone);
     }
@@ -554,7 +554,7 @@ static void kvm_uncoalesce_mmio_region(MemoryListener *listener,
 
         zone.addr = start;
         zone.size = size;
-        zone.pad = 0;
+        zone.pio = 0;
 
         (void)kvm_vm_ioctl(s, KVM_UNREGISTER_COALESCED_MMIO, &zone);
     }
diff --git a/linux-headers/linux/kvm.h b/linux-headers/linux/kvm.h
index 83ba4eb..b5d4289 100644
--- a/linux-headers/linux/kvm.h
+++ b/linux-headers/linux/kvm.h
@@ -420,13 +420,19 @@ struct kvm_run {
 struct kvm_coalesced_mmio_zone {
 	__u64 addr;
 	__u32 size;
-	__u32 pad;
+	union {
+		__u32 pad;
+		__u32 pio;
+	};
 };
 
 struct kvm_coalesced_mmio {
 	__u64 phys_addr;
 	__u32 len;
+	unino {
 	__u32 pad;
+	__u32 pio;
+	};
 	__u8  data[8];
 };
 
@@ -953,6 +959,7 @@ struct kvm_ppc_resize_hpt {
 #define KVM_CAP_NESTED_STATE 157
 #define KVM_CAP_ARM_INJECT_SERROR_ESR 158
 #define KVM_CAP_MSR_PLATFORM_INFO 159
+#define KVM_CAP_COALESCED_PIO 160
 
 #ifdef KVM_CAP_IRQ_ROUTING
 
-- 
1.8.3.1
