Received: from eggs.gnu.org ([2001:4830:134:3::10]:51961)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1cgtXj-00012x-TP
	for qemu-devel@nongnu.org; Thu, 23 Feb 2017 08:34:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1cgtXg-0000az-Ph
	for qemu-devel@nongnu.org; Thu, 23 Feb 2017 08:34:47 -0500
Received: from mx1.redhat.com ([209.132.183.28]:36020)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1cgtXg-0000ac-HE
	for qemu-devel@nongnu.org; Thu, 23 Feb 2017 08:34:44 -0500
Received: from smtp.corp.redhat.com (int-mx16.intmail.prod.int.phx2.redhat.com
	[10.5.11.28])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 86253C04BD41
	for <qemu-devel@nongnu.org>; Thu, 23 Feb 2017 13:34:44 +0000 (UTC)
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Date: Thu, 23 Feb 2017 13:34:41 +0000
Message-Id: <20170223133441.16010-1-dgilbert@redhat.com>
Subject: [Qemu-devel] [PATCH] x86: Work around SMI migration breakages
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, pbonzini@redhat.com, lersek@redhat.com

From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>

Migration from a 2.3.0 qemu results in a reboot on the receiving QEMU
due to a disagreement about SM (System management) interrupts.

2.3.0 didn't have much SMI support, but it did set CPU_INTERRUPT_SMI
and this gets into the migration stream, but on 2.3.0 it
never got delivered.

~2.4.0 SMI interrupt support was added but was broken - so
that when a 2.3.0 stream was received it cleared the CPU_INTERRUPT_SMI
but never actually caused an interrupt.

The SMI delivery was recently fixed by 68c6efe07a, but the
effect now is that an incoming 2.3.0 stream takes the interrupt it
had flagged but it's bios can't actually handle it(I think
partly due to the original interrupt not being taken during boot?).
The consequence is a triple(?) fault and a reboot.

Tested from:
  2.3.1 -M 2.3.0
  2.7.0 -M 2.3.0
  2.8.0 -M 2.3.0
  2.8.0 -M 2.8.0

This corresponds to RH bugzilla entry 1420679.

Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 include/hw/i386/pc.h | 4 ++++
 target/i386/cpu.c    | 2 ++
 target/i386/cpu.h    | 3 +++
 target/i386/kvm.c    | 7 ++++++-
 4 files changed, 15 insertions(+), 1 deletion(-)

diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
index 079e8d9..cb49826 100644
--- a/include/hw/i386/pc.h
+++ b/include/hw/i386/pc.h
@@ -624,6 +624,10 @@ bool e820_get_entry(int, uint32_t, uint64_t *, uint64_t *);
         .driver   = "Broadwell-noTSX" "-" TYPE_X86_CPU,\
         .property = "xlevel",\
         .value    = stringify(0x8000000a),\
+    },{\
+        .driver = TYPE_X86_CPU,\
+        .property = "kvm-no-smi-migration",\
+        .value    = "on",\
     },
 
 #define PC_COMPAT_2_2 \
diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index fd7add2..b2058cd 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -3708,6 +3708,8 @@ static Property x86_cpu_properties[] = {
     DEFINE_PROP_BOOL("cpuid-0xb", X86CPU, enable_cpuid_0xb, true),
     DEFINE_PROP_BOOL("lmce", X86CPU, enable_lmce, false),
     DEFINE_PROP_BOOL("l3-cache", X86CPU, enable_l3_cache, true),
+    DEFINE_PROP_BOOL("kvm-no-smi-migration", X86CPU, kvm_no_smi_migration,
+                     false),
     DEFINE_PROP_BOOL("vmware-cpuid-freq", X86CPU, vmware_cpuid_freq, true),
     DEFINE_PROP_END_OF_LIST()
 };
diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index 8df124f..c5dfef8 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -1255,6 +1255,9 @@ struct X86CPU {
     /* if true override the phys_bits value with a value read from the host */
     bool host_phys_bits;
 
+    /* Stop SMI delivery for migration compatibility with old machines */
+    bool kvm_no_smi_migration;
+
     /* Number of physical address bits supported */
     uint32_t phys_bits;
 
diff --git a/target/i386/kvm.c b/target/i386/kvm.c
index 27fd050..5bfe633 100644
--- a/target/i386/kvm.c
+++ b/target/i386/kvm.c
@@ -2531,7 +2531,12 @@ static int kvm_put_vcpu_events(X86CPU *cpu, int level)
             events.smi.pending = 0;
             events.smi.latched_init = 0;
         }
-        events.flags |= KVM_VCPUEVENT_VALID_SMM;
+        /* Stop SMI delivery on old machine types to avoid a reboot
+         * on an inward migration of an old VM.
+         */
+        if (!cpu->kvm_no_smi_migration) {
+            events.flags |= KVM_VCPUEVENT_VALID_SMM;
+        }
     }
 
     if (level >= KVM_PUT_RESET_STATE) {
-- 
2.9.3
