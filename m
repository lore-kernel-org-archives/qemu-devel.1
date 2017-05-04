Received: from eggs.gnu.org ([2001:4830:134:3::10]:48273)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1d6IBs-0006vI-SV
	for qemu-devel@nongnu.org; Thu, 04 May 2017 10:57:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1d6IBn-0003AG-Sa
	for qemu-devel@nongnu.org; Thu, 04 May 2017 10:57:12 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51308)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1d6IBn-00037Z-Js
	for qemu-devel@nongnu.org; Thu, 04 May 2017 10:57:07 -0400
From: "Daniel P. Berrange" <berrange@redhat.com>
Date: Thu,  4 May 2017 15:56:58 +0100
Message-Id: <20170504145658.5506-1-berrange@redhat.com>
Subject: [Qemu-devel] [PATCH RFC] i386: expose "TCGTCGTCGTCG" in the
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>, "Richard W.M. Jones" <rjones@redhat.com>, "Daniel P. Berrange" <berrange@redhat.com>

Currently when running KVM, we expose "KVMKVMKVM\0\0\0" in
the 0x40000000 CPUID leaf. Other hypervisors (VMWare,
HyperV, Xen, BHyve) all do the same thing, which leaves
TCG as the odd one out.

The CPUID is used by software to detect when running in a
virtual environment and change behaviour in certain ways.
For example, systemd supports a ConditionVirtualization=
setting in unit files. Currently they have to resort to
custom hacks like looking for 'fw-cfg' entry in the
/proc/device-tree file. The virt-what command has the
same hacks & needs.

This change thus proposes a signature TCGTCGTCGTCG to be
reported when running under TCG.

NB1, for reasons I don't undersatnd 'cpu_x86_cpuid' function
clamps the requested CPUID leaf based on env->cpuid_level.
The latter comes from the CPU model definitions, and is
lower than 0x40000000, so the CPUID signature request just
gets turned into a completely different request. eg when
using '-cpu qemu64', the 0x40000000 request from the guest
gets clamped to 0xD and thus returns totally bogus data.
I just removed the clamping code, but someone who understands
this might have a better suggestion.

NB2, for KVM, we added a flag for '-cpu kvm=off' to let you
hide the KVMKVMKVM signature from guests. Presumably we should
add a 'tcg=off' flag for the same reason ?

Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
---
 target/i386/cpu.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 13c0985..ac2776e 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -2626,6 +2626,7 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
     X86CPU *cpu = x86_env_get_cpu(env);
     CPUState *cs = CPU(cpu);
     uint32_t pkg_offset;
+    uint32_t signature[3];
 
     /* test if maximum index reached */
     if (index & 0x80000000) {
@@ -2646,8 +2647,13 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
             }
         }
     } else {
-        if (index > env->cpuid_level)
+        /* XXX this just breaks CPUID turning guest requests
+         * into something totally different, thus returning
+         * garbage data
+         */
+        if (0 && index > env->cpuid_level) {
             index = env->cpuid_level;
+        }
     }
 
     switch(index) {
@@ -2872,6 +2878,14 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
         }
         break;
     }
+    case 0x40000000:
+        /* XXX add flag to let us hide this */
+        memcpy(signature, "TCGTCGTCGTCG", 12);
+        *eax = 0x40000001;
+        *ebx = signature[0];
+        *ecx = signature[1];
+        *edx = signature[2];
+        break;
     case 0x80000000:
         *eax = env->cpuid_xlevel;
         *ebx = env->cpuid_vendor1;
-- 
2.9.3
