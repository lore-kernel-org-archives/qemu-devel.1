Received: from eggs.gnu.org ([2001:4830:134:3::10]:60234)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1duHfd-0004SR-T5
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 08:30:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1duHfc-0005fz-LH
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 08:30:33 -0400
Received: from mail-wr0-x22f.google.com ([2a00:1450:400c:c0c::22f]:53331)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1duHfc-0005et-Fa
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 08:30:32 -0400
Received: by mail-wr0-x22f.google.com with SMTP id l22so2975168wrc.10
	for <qemu-devel@nongnu.org>; Tue, 19 Sep 2017 05:30:31 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 19 Sep 2017 14:29:30 +0200
Message-Id: <1505824179-21541-42-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1505824179-21541-1-git-send-email-pbonzini@redhat.com>
References: <1505824179-21541-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 41/50] i386/cpu/hyperv: support over 64 vcpus
 for windows guests
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Gonglei <arei.gonglei@huawei.com>

From: Gonglei <arei.gonglei@huawei.com>

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
Message-Id: <1505143227-14324-1-git-send-email-arei.gonglei@huawei.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 include/hw/i386/pc.h |  5 +++++
 target/i386/cpu.c    | 14 ++++++++++++++
 target/i386/cpu.h    |  2 ++
 target/i386/kvm.c    |  3 ++-
 4 files changed, 23 insertions(+), 1 deletion(-)

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
index 7644f6d..40c3091 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -4145,6 +4145,20 @@ static Property x86_cpu_properties[] = {
                      false),
     DEFINE_PROP_BOOL("vmware-cpuid-freq", X86CPU, vmware_cpuid_freq, true),
     DEFINE_PROP_BOOL("tcg-cpuid", X86CPU, expose_tcg, true),
+
+    /*
+     * From "Requirements for Implementing the Microsoft
+     * Hypervisor Interface":
+     * https://docs.microsoft.com/en-us/virtualization/hyper-v-on-windows/reference/tlfs
+     *
+     * "Starting with Windows Server 2012 and Windows 8, if
+     * CPUID.40000005.EAX contains a value of -1, Windows assumes that
+     * the hypervisor imposes no specific limit to the number of VPs.
+     * In this case, Windows Server 2012 guest VMs may use more than
+     * 64 VPs, up to the maximum supported number of processors applicable
+     * to the specific Windows version being used."
+     */
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
index 739334a..ee4e91f 100644
--- a/target/i386/kvm.c
+++ b/target/i386/kvm.c
@@ -786,7 +786,8 @@ int kvm_arch_init_vcpu(CPUState *cs)
 
         c = &cpuid_data.entries[cpuid_i++];
         c->function = HYPERV_CPUID_IMPLEMENT_LIMITS;
-        c->eax = 0x40;
+
+        c->eax = cpu->hv_max_vps;
         c->ebx = 0x40;
 
         kvm_base = KVM_CPUID_SIGNATURE_NEXT;
-- 
1.8.3.1
