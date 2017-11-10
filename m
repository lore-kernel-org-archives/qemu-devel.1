Received: from eggs.gnu.org ([2001:4830:134:3::10]:55207)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <gengdongjiu@huawei.com>) id 1eD7HM-0001mk-QM
	for qemu-devel@nongnu.org; Fri, 10 Nov 2017 06:15:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <gengdongjiu@huawei.com>) id 1eD7HL-000161-Fu
	for qemu-devel@nongnu.org; Fri, 10 Nov 2017 06:15:20 -0500
From: Dongjiu Geng <gengdongjiu@huawei.com>
Date: Sat, 11 Nov 2017 03:19:45 +0800
Message-ID: <1510341591-22817-7-git-send-email-gengdongjiu@huawei.com>
In-Reply-To: <1510341591-22817-1-git-send-email-gengdongjiu@huawei.com>
References: <1510341591-22817-1-git-send-email-gengdongjiu@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v12 06/12] target-arm: kvm64: detect whether
 can set vsesr_el2
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: pbonzini@redhat.com, mst@redhat.com, imammedo@redhat.com, zhaoshenglong@huawei.com, peter.maydell@linaro.org, mtosatti@redhat.com, james.morse@arm.com, lersek@redhat.com, marc.zyngier@arm.com, christoffer.dall@linaro.org, rth@twiddle.net, ehabkost@redhat.com, kvm@vger.kernel.org, guohanjun@huawei.com, lijinyue@huawei.com, huangshaoyu@huawei.com, wuquanming@huawei.com, zhengqiang10@huawei.com, linuxarm@huawei.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org

Check if kvm can support to set vsesr_el2 value for vcpu. When
guest takes a virtual SError interrupt exception, this value
will provides syndrome value reported into ESR_EL1 ISS filed.

Signed-off-by: Dongjiu Geng <gengdongjiu@huawei.com>
Signed-off-by: Quanming Wu <wuquanming@huawei.com>

---
Detect whether KVM has the capability to set ESR instead of detecting CPU RAS capability
is discussed here:

https://www.spinics.net/lists/kvm-arm/msg27150.html
https://www.spinics.net/lists/arm-kernel/msg604440.html
---
 target/arm/kvm64.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/target/arm/kvm64.c b/target/arm/kvm64.c
index a16abc8..af8ebc9 100644
--- a/target/arm/kvm64.c
+++ b/target/arm/kvm64.c
@@ -980,3 +980,9 @@ bool kvm_arm_handle_debug(CPUState *cs, struct kvm_debug_exit_arch *debug_exit)
 
     return false;
 }
+
+static bool kvm_can_set_vcpu_esr(struct KVMState *state)
+{
+    int ret = kvm_check_extension(state, KVM_CAP_ARM_INJECT_SERROR_ESR);
+    return (ret) ? true : false;
+}
-- 
1.8.3.1
