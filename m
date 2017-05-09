Received: from eggs.gnu.org ([2001:4830:134:3::10]:58220)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1d85B6-0002hH-9z
	for qemu-devel@nongnu.org; Tue, 09 May 2017 09:27:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1d85B4-000863-SS
	for qemu-devel@nongnu.org; Tue, 09 May 2017 09:27:48 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50292)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1d85B4-00085C-Iy
	for qemu-devel@nongnu.org; Tue, 09 May 2017 09:27:46 -0400
From: "Daniel P. Berrange" <berrange@redhat.com>
Date: Tue,  9 May 2017 14:27:36 +0100
Message-Id: <20170509132736.10071-3-berrange@redhat.com>
In-Reply-To: <20170509132736.10071-1-berrange@redhat.com>
References: <20170509132736.10071-1-berrange@redhat.com>
Subject: [Qemu-devel] [PATCH v4 2/2] i386: expose "TCGTCGTCGTCG" in the
 0x40000000 CPUID leaf
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>, "Daniel P. Berrange" <berrange@redhat.com>

Currently when running KVM, we expose "KVMKVMKVM\0\0\0" in
the 0x40000000 CPUID leaf. Other hypervisors (VMWare,
HyperV, Xen, BHyve) all do the same thing, which leaves
TCG as the odd one out.

The CPUID signature is used by software to detect which
virtual environment they are running in and (potentially)
change behaviour in certain ways. For example, systemd
supports a ConditionVirtualization= setting in unit files.
The virt-what command can also report the virt type it is
running on

Currently both these apps have to resort to custom hacks
like looking for 'fw-cfg' entry in the /proc/device-tree
file to identify TCG.

This change thus proposes a signature "TCGTCGTCGTCG" to be
reported when running under TCG.

To hide this, the -cpu option tcg-cpuid=off can be used.

Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
---
 include/hw/i386/pc.h |  5 +++++
 target/i386/cpu.c    | 28 ++++++++++++++++++++++++++++
 target/i386/cpu.h    |  1 +
 3 files changed, 34 insertions(+)

diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
index f278b3a..3aec60f 100644
--- a/include/hw/i386/pc.h
+++ b/include/hw/i386/pc.h
@@ -376,6 +376,11 @@ bool e820_get_entry(int, uint32_t, uint64_t *, uint64_t *);
 #define PC_COMPAT_2_8 \
     HW_COMPAT_2_8 \
     {\
+        .driver   = TYPE_X86_CPU,\
+        .property = "tcg-cpuid",\
+        .value    = "off",\
+    },\
+    {\
         .driver   = "kvmclock",\
         .property = "x-mach-use-reliable-get-clock",\
         .value    = "off",\
diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 8cb4af4..edf451c 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -2627,12 +2627,15 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
     CPUState *cs = CPU(cpu);
     uint32_t pkg_offset;
     uint32_t limit;
+    uint32_t signature[3];
 
     /* Calculate & apply limits for different index ranges */
     if (index >= 0xC0000000) {
         limit = env->cpuid_xlevel2;
     } else if (index >= 0x80000000) {
         limit = env->cpuid_xlevel;
+    } else if (index >= 0x40000000) {
+        limit = 0x40000001;
     } else {
         limit = env->cpuid_level;
     }
@@ -2867,6 +2870,30 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
         }
         break;
     }
+    case 0x40000000:
+        /*
+         * CPUID code in kvm_arch_init_vcpu() ignores stuff
+         * set here, but we restrict to TCG none the less.
+         */
+        if (tcg_enabled() && cpu->expose_tcg) {
+            memcpy(signature, "TCGTCGTCGTCG", 12);
+            *eax = 0x40000001;
+            *ebx = signature[0];
+            *ecx = signature[1];
+            *edx = signature[2];
+        } else {
+            *eax = 0;
+            *ebx = 0;
+            *ecx = 0;
+            *edx = 0;
+        }
+        break;
+    case 0x40000001:
+        *eax = 0;
+        *ebx = 0;
+        *ecx = 0;
+        *edx = 0;
+        break;
     case 0x80000000:
         *eax = env->cpuid_xlevel;
         *ebx = env->cpuid_vendor1;
@@ -4008,6 +4035,7 @@ static Property x86_cpu_properties[] = {
     DEFINE_PROP_BOOL("kvm-no-smi-migration", X86CPU, kvm_no_smi_migration,
                      false),
     DEFINE_PROP_BOOL("vmware-cpuid-freq", X86CPU, vmware_cpuid_freq, true),
+    DEFINE_PROP_BOOL("tcg-cpuid", X86CPU, expose_tcg, true),
     DEFINE_PROP_END_OF_LIST()
 };
 
diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index c4602ca..c25f0ce 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -1216,6 +1216,7 @@ struct X86CPU {
     bool check_cpuid;
     bool enforce_cpuid;
     bool expose_kvm;
+    bool expose_tcg;
     bool migratable;
     bool max_features; /* Enable all supported features automatically */
     uint32_t apic_id;
-- 
2.9.3
