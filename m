Received: from eggs.gnu.org ([2001:4830:134:3::10]:48437)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <arei.gonglei@huawei.com>) id 1drQW6-00037O-BQ
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 11:20:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <arei.gonglei@huawei.com>) id 1drQW3-00065k-6e
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 11:20:54 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:2264)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <arei.gonglei@huawei.com>) id 1drQW2-00060o-GC
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 11:20:51 -0400
From: Gonglei <arei.gonglei@huawei.com>
Date: Mon, 11 Sep 2017 23:20:27 +0800
Message-ID: <1505143227-14324-1-git-send-email-arei.gonglei@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH] i386/cpu/hyperv: support over 64 vcpus for
 windows guests
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: mst@redhat.com, pbonzini@redhat.com, rth@twiddle.net, ehabkost@redhat.com, mtosatti@redhat.com, vrozenfe@redhat.com, weidong.huang@huawei.com, Gonglei <arei.gonglei@huawei.com>

Starting with Windows Server 2012 and Windows 8, if
CPUID.40000005.EAX contains a value of -1, Windows assumes specific
limit to the number of VPs. In this case, Windows Server 2012
guest VMs may use more than 64 VPs, up to the maximum supported
number of processors applicable to the specific Windows
version being used.

https://docs.microsoft.com/en-us/virtualization/hyper-v-on-windows/reference/tlfs

For compatibility, Let's introduce a new property for X86CPU,
named "x-hv-max-vps" as Eduardo's suggestion, and set it
to 0x40 before machine 2.10.

(The "x-" prefix indicates that the property is not supposed to
be a stable user interface.)

Signed-off-by: Gonglei <arei.gonglei@huawei.com>
---
 include/hw/i386/pc.h |  5 +++++
 target/i386/cpu.c    |  1 +
 target/i386/cpu.h    |  2 ++
 target/i386/kvm.c    | 15 ++++++++++++++-
 4 files changed, 22 insertions(+), 1 deletion(-)

diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
index 8226904..087d184 100644
--- a/include/hw/i386/pc.h
+++ b/include/hw/i386/pc.h
@@ -371,6 +371,11 @@ bool e820_get_entry(int, uint32_t, uint64_t *, uint64_t *);
 
 #define PC_COMPAT_2_10 \
     HW_COMPAT_2_10 \
+    {\
+        .driver   = TYPE_X86_CPU,\
+        .property = "x-hv-max-vps",\
+        .value    = "0x40",\
+    },
 
 #define PC_COMPAT_2_9 \
     HW_COMPAT_2_9 \
diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 69676e1..2702485 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -4145,6 +4145,7 @@ static Property x86_cpu_properties[] = {
                      false),
     DEFINE_PROP_BOOL("vmware-cpuid-freq", X86CPU, vmware_cpuid_freq, true),
     DEFINE_PROP_BOOL("tcg-cpuid", X86CPU, expose_tcg, true),
+    DEFINE_PROP_INT32("x-hv-max-vps", X86CPU, hv_max_vps, -1),
     DEFINE_PROP_END_OF_LIST()
 };
 
diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index 525d35d..5c726f3 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -1282,6 +1282,8 @@ struct X86CPU {
     int32_t socket_id;
     int32_t core_id;
     int32_t thread_id;
+
+    int32_t hv_max_vps;
 };
 
 static inline X86CPU *x86_env_get_cpu(CPUX86State *env)
diff --git a/target/i386/kvm.c b/target/i386/kvm.c
index 6db7783..a898bef 100644
--- a/target/i386/kvm.c
+++ b/target/i386/kvm.c
@@ -751,7 +751,20 @@ int kvm_arch_init_vcpu(CPUState *cs)
 
         c = &cpuid_data.entries[cpuid_i++];
         c->function = HYPERV_CPUID_IMPLEMENT_LIMITS;
-        c->eax = 0x40;
+
+        /*
+         * From "Requirements for Implementing the Microsoft
+         * Hypervisor Interface":
+         * https://docs.microsoft.com/en-us/virtualization/hyper-v-on-windows/reference/tlfs
+         *
+         * "Starting with Windows Server 2012 and Windows 8, if
+         * CPUID.40000005.EAX contains a value of -1, Windows assumes
+         * specific limit to the number of VPs. In this case, Windows
+         * Server 2012 guest VMs may use more than 64 VPs, up to the
+         * maximum supported number of processors applicable to the
+         * specific Windows version being used."
+         */
+        c->eax = cpu->hv_max_vps;
         c->ebx = 0x40;
 
         kvm_base = KVM_CPUID_SIGNATURE_NEXT;
-- 
1.8.3.1
