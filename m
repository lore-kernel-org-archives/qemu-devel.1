Received: from eggs.gnu.org ([2001:4830:134:3::10]:60389)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1duHfk-0004Yi-4B
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 08:30:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1duHfd-0005hb-Rc
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 08:30:40 -0400
Received: from mail-wr0-x244.google.com ([2a00:1450:400c:c0c::244]:35314)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1duHfd-0005gO-Kr
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 08:30:33 -0400
Received: by mail-wr0-x244.google.com with SMTP id n64so2147786wrb.2
	for <qemu-devel@nongnu.org>; Tue, 19 Sep 2017 05:30:33 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 19 Sep 2017 14:29:32 +0200
Message-Id: <1505824179-21541-44-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1505824179-21541-1-git-send-email-pbonzini@redhat.com>
References: <1505824179-21541-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 43/50] update-linux-headers: prepare for
 hyperv.h removal
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Roman Kagan <rkagan@virtuozzo.com>

From: Roman Kagan <rkagan@virtuozzo.com>

All definitions related to Hyper-V emulation are now taken from the QEMU
own header, so the one imported from the kernel is no longer needed.

Unfortunately it's included by kvm_para.h.

So, until this is fixed in the kernel, teach the header harvesting
script to substitute kernel's hyperv.h with a dummy.

Signed-off-by: Roman Kagan <rkagan@virtuozzo.com>
Message-Id: <20170713201522.13765-3-rkagan@virtuozzo.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 scripts/update-linux-headers.sh |  4 +++-
 target/i386/hyperv-proto.h      |  3 +++
 target/i386/kvm.c               | 17 +++++------------
 3 files changed, 11 insertions(+), 13 deletions(-)

diff --git a/scripts/update-linux-headers.sh b/scripts/update-linux-headers.sh
index 2f906c4..ad80fe3 100755
--- a/scripts/update-linux-headers.sh
+++ b/scripts/update-linux-headers.sh
@@ -104,7 +104,9 @@ for arch in $ARCHLIST; do
         cp "$tmpdir/include/asm/unistd-common.h" "$output/linux-headers/asm-arm/"
     fi
     if [ $arch = x86 ]; then
-        cp_portable "$tmpdir/include/asm/hyperv.h" "$output/include/standard-headers/asm-x86/"
+        cat <<-EOF >"$output/include/standard-headers/asm-x86/hyperv.h"
+        /* this is a temporary placeholder until kvm_para.h stops including it */
+        EOF
         cp "$tmpdir/include/asm/unistd_32.h" "$output/linux-headers/asm-x86/"
         cp "$tmpdir/include/asm/unistd_x32.h" "$output/linux-headers/asm-x86/"
         cp "$tmpdir/include/asm/unistd_64.h" "$output/linux-headers/asm-x86/"
diff --git a/target/i386/hyperv-proto.h b/target/i386/hyperv-proto.h
index 1b3fa6e..cb4d7f2 100644
--- a/target/i386/hyperv-proto.h
+++ b/target/i386/hyperv-proto.h
@@ -34,6 +34,8 @@
 #define HV_VP_INDEX_AVAILABLE        (1u << 6)
 #define HV_RESET_AVAILABLE           (1u << 7)
 #define HV_REFERENCE_TSC_AVAILABLE   (1u << 9)
+#define HV_ACCESS_FREQUENCY_MSRS     (1u << 11)
+
 
 /*
  * HV_CPUID_FEATURES.EDX bits
@@ -44,6 +46,7 @@
 #define HV_CPU_DYNAMIC_PARTITIONING_AVAILABLE   (1u << 3)
 #define HV_HYPERCALL_PARAMS_XMM_AVAILABLE       (1u << 4)
 #define HV_GUEST_IDLE_STATE_AVAILABLE           (1u << 5)
+#define HV_FREQUENCY_MSRS_AVAILABLE             (1u << 8)
 #define HV_GUEST_CRASH_MSR_AVAILABLE            (1u << 10)
 
 /*
diff --git a/target/i386/kvm.c b/target/i386/kvm.c
index 0498ab7..b1e32e9 100644
--- a/target/i386/kvm.c
+++ b/target/i386/kvm.c
@@ -639,21 +639,14 @@ static int hyperv_handle_properties(CPUState *cs)
         env->features[FEAT_HYPERV_EAX] |= HV_APIC_ACCESS_AVAILABLE;
     }
     if (cpu->hyperv_time) {
-<<<<<<< HEAD
-        env->features[FEAT_HYPERV_EAX] |= HV_X64_MSR_HYPERCALL_AVAILABLE;
-        env->features[FEAT_HYPERV_EAX] |= HV_X64_MSR_TIME_REF_COUNT_AVAILABLE;
-        env->features[FEAT_HYPERV_EAX] |= HV_X64_MSR_REFERENCE_TSC_AVAILABLE;
-
-        if (has_msr_hv_frequencies && tsc_is_stable_and_known(env)) {
-            env->features[FEAT_HYPERV_EAX] |= HV_X64_ACCESS_FREQUENCY_MSRS;
-            env->features[FEAT_HYPERV_EDX] |=
-                HV_FEATURE_FREQUENCY_MSRS_AVAILABLE;
-        }
-=======
         env->features[FEAT_HYPERV_EAX] |= HV_HYPERCALL_AVAILABLE;
         env->features[FEAT_HYPERV_EAX] |= HV_TIME_REF_COUNT_AVAILABLE;
         env->features[FEAT_HYPERV_EAX] |= HV_REFERENCE_TSC_AVAILABLE;
->>>>>>> hyperv: add header with protocol definitions
+
+        if (has_msr_hv_frequencies && tsc_is_stable_and_known(env)) {
+            env->features[FEAT_HYPERV_EAX] |= HV_ACCESS_FREQUENCY_MSRS;
+            env->features[FEAT_HYPERV_EDX] |= HV_FREQUENCY_MSRS_AVAILABLE;
+        }
     }
     if (cpu->hyperv_crash && has_msr_hv_crash) {
         env->features[FEAT_HYPERV_EDX] |= HV_GUEST_CRASH_MSR_AVAILABLE;
-- 
1.8.3.1
