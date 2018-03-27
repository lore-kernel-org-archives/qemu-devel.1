Received: from eggs.gnu.org ([2001:4830:134:3::10]:45529)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1f0pO9-000340-MY
	for qemu-devel@nongnu.org; Tue, 27 Mar 2018 10:15:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1f0pO5-0006WD-NP
	for qemu-devel@nongnu.org; Tue, 27 Mar 2018 10:15:49 -0400
From: Eric Auger <eric.auger@redhat.com>
Date: Tue, 27 Mar 2018 16:15:17 +0200
Message-Id: <1522160122-10744-4-git-send-email-eric.auger@redhat.com>
In-Reply-To: <1522160122-10744-1-git-send-email-eric.auger@redhat.com>
References: <1522160122-10744-1-git-send-email-eric.auger@redhat.com>
Subject: [Qemu-devel] [RFC 3/8] kvm: Expose kvm_max_vcpus()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org, peter.maydell@linaro.org
Cc: drjones@redhat.com, wei@redhat.com, marc.zyngier@arm.com, cdall@kernel.org, zhaoshenglong@huawei.com

Make kvm_max_vcpus() public so that the machines can query this information
easily.

Signed-off-by: Eric Auger <eric.auger@redhat.com>
---
 accel/kvm/kvm-all.c    | 2 +-
 accel/stubs/kvm-stub.c | 5 +++++
 include/sysemu/kvm.h   | 7 +++++++
 3 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index ffee68e..b04f4ef 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -1462,7 +1462,7 @@ static int kvm_recommended_vcpus(KVMState *s)
     return (ret) ? ret : 4;
 }
 
-static int kvm_max_vcpus(KVMState *s)
+int kvm_max_vcpus(KVMState *s)
 {
     int ret = kvm_check_extension(s, KVM_CAP_MAX_VCPUS);
     return (ret) ? ret : kvm_recommended_vcpus(s);
diff --git a/accel/stubs/kvm-stub.c b/accel/stubs/kvm-stub.c
index 02d5170..e816050 100644
--- a/accel/stubs/kvm-stub.c
+++ b/accel/stubs/kvm-stub.c
@@ -170,4 +170,9 @@ bool kvm_arm_supports_user_irq(void)
 {
     return false;
 }
+
+int kvm_max_vcpus(KVMState *s)
+{
+    return -ENOSYS;
+}
 #endif
diff --git a/include/sysemu/kvm.h b/include/sysemu/kvm.h
index 23669c4..1e7c621 100644
--- a/include/sysemu/kvm.h
+++ b/include/sysemu/kvm.h
@@ -546,6 +546,13 @@ int kvm_set_one_reg(CPUState *cs, uint64_t id, void *source);
  * Returns: 0 on success, or a negative errno on failure.
  */
 int kvm_get_one_reg(CPUState *cs, uint64_t id, void *target);
+
+/**
+ * kvm_max_vcpus - return the number of supported vcpus
+ * @s: The KVMState pointer
+ */
+int kvm_max_vcpus(KVMState *s);
+
 struct ppc_radix_page_info *kvm_get_radix_page_info(void);
 int kvm_get_max_memslots(void);
 #endif
-- 
2.5.5
