Received: from eggs.gnu.org ([2001:4830:134:3::10]:34502)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dXB6y-0003PO-0s
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 14:51:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dXB6x-0003pQ-1O
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 14:51:16 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40628)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1dXB6w-0003ns-OS
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 14:51:14 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Mon, 17 Jul 2017 15:50:46 -0300
Message-Id: <20170717185051.18740-11-ehabkost@redhat.com>
In-Reply-To: <20170717185051.18740-1-ehabkost@redhat.com>
References: <20170717185051.18740-1-ehabkost@redhat.com>
Subject: [Qemu-devel] [PULL 10/15] i386: expose "TCGTCGTCGTCG" in the
 0x40000000 CPUID leaf
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, "Daniel P. Berrange" <berrange@redhat.com>

From: "Daniel P. Berrange" <berrange@redhat.com>

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
Message-Id: <20170509132736.10071-3-berrange@redhat.com>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 include/hw/i386/pc.h |  5 +++++
 target/i386/cpu.h    |  1 +
 target/i386/cpu.c    | 28 ++++++++++++++++++++++++++++
 3 files changed, 34 insertions(+)

diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
index f48d167..d80859b 100644
--- a/include/hw/i386/pc.h
+++ b/include/hw/i386/pc.h
@@ -380,6 +380,11 @@ bool e820_get_entry(int, uint32_t, uint64_t *, uint64_t *);
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
diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index 7a228af..0518673 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -1218,6 +1218,7 @@ struct X86CPU {
     bool check_cpuid;
     bool enforce_cpuid;
     bool expose_kvm;
+    bool expose_tcg;
     bool migratable;
     bool max_features; /* Enable all supported features automatically */
     uint32_t apic_id;
diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 4de91d5..71983ef 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -2632,12 +2632,15 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
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
@@ -2872,6 +2875,30 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
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
@@ -4018,6 +4045,7 @@ static Property x86_cpu_properties[] = {
     DEFINE_PROP_BOOL("kvm-no-smi-migration", X86CPU, kvm_no_smi_migration,
                      false),
     DEFINE_PROP_BOOL("vmware-cpuid-freq", X86CPU, vmware_cpuid_freq, true),
+    DEFINE_PROP_BOOL("tcg-cpuid", X86CPU, expose_tcg, true),
     DEFINE_PROP_END_OF_LIST()
 };
 
-- 
2.9.4
