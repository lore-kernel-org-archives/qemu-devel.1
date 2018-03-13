Received: from eggs.gnu.org ([2001:4830:134:3::10]:60868)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1evjUn-0001Ur-OW
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 08:57:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1evjUm-0000v6-5f
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 08:57:37 -0400
Received: from mail-wr0-x243.google.com ([2a00:1450:400c:c0c::243]:46809)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1evjUl-0000uV-Vr
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 08:57:36 -0400
Received: by mail-wr0-x243.google.com with SMTP id m12so22359448wrm.13
	for <qemu-devel@nongnu.org>; Tue, 13 Mar 2018 05:57:35 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 13 Mar 2018 13:56:34 +0100
Message-Id: <1520945798-50640-19-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1520945798-50640-1-git-send-email-pbonzini@redhat.com>
References: <1520945798-50640-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 18/22] cpu/i386: populate CPUID 0x8000_001F when
 SEV is active
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Brijesh Singh <brijesh.singh@amd.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>

From: Brijesh Singh <brijesh.singh@amd.com>

When SEV is enabled, CPUID 0x8000_001F should provide additional
information regarding the feature (such as which page table bit is used
to mark the pages as encrypted etc).

The details for memory encryption CPUID is available in AMD APM
(https://support.amd.com/TechDocs/24594.pdf) Section E.4.17

Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Richard Henderson <rth@twiddle.net>
Cc: Eduardo Habkost <ehabkost@redhat.com>
Reviewed-by: Eduardo Habkost <ehabkost@redhat.com>
Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/cpu.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 8ee0140..01607dd 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -26,6 +26,7 @@
 #include "sysemu/hvf.h"
 #include "sysemu/cpus.h"
 #include "kvm_i386.h"
+#include "sev_i386.h"
 
 #include "qemu/error-report.h"
 #include "qemu/option.h"
@@ -3612,6 +3613,13 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
         *ecx = 0;
         *edx = 0;
         break;
+    case 0x8000001F:
+        *eax = sev_enabled() ? 0x2 : 0;
+        *ebx = sev_get_cbit_position();
+        *ebx |= sev_get_reduced_phys_bits() << 6;
+        *ecx = 0;
+        *edx = 0;
+        break;
     default:
         /* reserved values: zero */
         *eax = 0;
@@ -4042,6 +4050,11 @@ static void x86_cpu_expand_features(X86CPU *cpu, Error **errp)
         if (env->features[FEAT_8000_0001_ECX] & CPUID_EXT3_SVM) {
             x86_cpu_adjust_level(cpu, &env->cpuid_min_xlevel, 0x8000000A);
         }
+
+        /* SEV requires CPUID[0x8000001F] */
+        if (sev_enabled()) {
+            x86_cpu_adjust_level(cpu, &env->cpuid_min_xlevel, 0x8000001F);
+        }
     }
 
     /* Set cpuid_*level* based on cpuid_min_*level, if not explicitly set */
-- 
1.8.3.1
