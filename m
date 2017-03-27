Received: from eggs.gnu.org ([2001:4830:134:3::10]:49771)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <agraf@suse.de>) id 1csVbQ-00071Y-PH
	for qemu-devel@nongnu.org; Mon, 27 Mar 2017 10:26:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <agraf@suse.de>) id 1csVbN-0007Ek-Jc
	for qemu-devel@nongnu.org; Mon, 27 Mar 2017 10:26:36 -0400
Received: from mx2.suse.de ([195.135.220.15]:52123)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <agraf@suse.de>) id 1csVbN-0007EX-DL
	for qemu-devel@nongnu.org; Mon, 27 Mar 2017 10:26:33 -0400
From: Alexander Graf <agraf@suse.de>
Date: Mon, 27 Mar 2017 16:26:50 +0200
Message-Id: <1490624810-44752-1-git-send-email-agraf@suse.de>
Subject: [Qemu-devel] [PATCH] i386: Allow monitor / mwait cpuid override
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>

KVM allows trap and emulate (read: NOP) of the MONITOR and MWAIT
instructions. There is work undergoing to enable actual execution
of these inside of KVM, but nobody really wants to expose the feature
to the guest by default, as it would eat up all of the host CPU.

So today there is no streamlined way to actually notify the guest that
it's ok to execute MONITOR / MWAIT, even when we want to explicitly
leave the guest in guest context.

This patch adds a new -cpu parameter called "mwait" which - when
enabled - force enables the MONITOR / MWAIT CPUID flag, even when
the underlying accel framework does not explicitly advertise support.

With that in place, we can explicitly allow users to specify that
they want have the guest execute MONITOR / MWAIT in its idle loop.

Signed-off-by: Alexander Graf <agraf@suse.de>
---
 target/i386/cpu.c | 5 +++++
 target/i386/cpu.h | 1 +
 2 files changed, 6 insertions(+)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 7aa7622..c44020b 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -3460,6 +3460,10 @@ static int x86_cpu_filter_features(X86CPU *cpu)
             x86_cpu_get_supported_feature_word(w, false);
         uint32_t requested_features = env->features[w];
         env->features[w] &= host_feat;
+        if (cpu->expose_monitor && (w == FEAT_1_ECX)) {
+            /* Force monitor feature in */
+            env->features[w] |= CPUID_EXT_MONITOR;
+        }
         cpu->filtered_features[w] = requested_features & ~env->features[w];
         if (cpu->filtered_features[w]) {
             rv = 1;
@@ -3988,6 +3992,7 @@ static Property x86_cpu_properties[] = {
     DEFINE_PROP_BOOL("check", X86CPU, check_cpuid, true),
     DEFINE_PROP_BOOL("enforce", X86CPU, enforce_cpuid, false),
     DEFINE_PROP_BOOL("kvm", X86CPU, expose_kvm, true),
+    DEFINE_PROP_BOOL("mwait", X86CPU, expose_monitor, false),
     DEFINE_PROP_UINT32("phys-bits", X86CPU, phys_bits, 0),
     DEFINE_PROP_BOOL("host-phys-bits", X86CPU, host_phys_bits, false),
     DEFINE_PROP_BOOL("fill-mtrr-mask", X86CPU, fill_mtrr_mask, true),
diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index 07401ad..7400d00 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -1214,6 +1214,7 @@ struct X86CPU {
     bool check_cpuid;
     bool enforce_cpuid;
     bool expose_kvm;
+    bool expose_monitor;
     bool migratable;
     bool max_features; /* Enable all supported features automatically */
     uint32_t apic_id;
-- 
1.8.5.6
