Received: from eggs.gnu.org ([2001:4830:134:3::10]:53695)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <brijesh.singh@amd.com>) id 1er90W-0001Xm-Fx
	for qemu-devel@nongnu.org; Wed, 28 Feb 2018 16:11:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <brijesh.singh@amd.com>) id 1er90S-00066U-BX
	for qemu-devel@nongnu.org; Wed, 28 Feb 2018 16:11:24 -0500
Received: from mail-dm3nam03on0060.outbound.protection.outlook.com
	([104.47.41.60]:17929
	helo=NAM03-DM3-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <brijesh.singh@amd.com>)
	id 1er90S-00064W-2C
	for qemu-devel@nongnu.org; Wed, 28 Feb 2018 16:11:20 -0500
From: Brijesh Singh <brijesh.singh@amd.com>
Date: Wed, 28 Feb 2018 15:10:25 -0600
Message-Id: <20180228211028.83970-26-brijesh.singh@amd.com>
In-Reply-To: <20180228211028.83970-1-brijesh.singh@amd.com>
References: <20180228211028.83970-1-brijesh.singh@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v10 25/28] cpu/i386: populate CPUID 0x8000_001F
 when SEV is active
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Alistair Francis <alistair.francis@xilinx.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Cornelia Huck <cornelia.huck@de.ibm.com>, "Daniel P . Berrange" <berrange@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>, Eduardo Habkost <ehabkost@redhat.com>, Eric Blake <eblake@redhat.com>, kvm@vger.kernel.org, Marcel Apfelbaum <marcel@redhat.com>, Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Peter Maydell <peter.maydell@linaro.org>, Richard Henderson <richard.henderson@linaro.org>, Stefan Hajnoczi <stefanha@gmail.com>, Thomas Lendacky <Thomas.Lendacky@amd.com>, Borislav Petkov <bp@suse.de>, Alexander Graf <agraf@suse.de>, Bruce Rogers <brogers@suse.com>, Brijesh Singh <brijesh.singh@amd.com>, Richard Henderson <rth@twiddle.net>

When SEV is enabled, CPUID 0x8000_001F should provide additional
information regarding the feature (such as which page table bit is used
to mark the pages as encrypted etc).

The details for memory encryption CPUID is available in AMD APM
(https://support.amd.com/TechDocs/24594.pdf) Section E.4.17

Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Richard Henderson <rth@twiddle.net>
Cc: Eduardo Habkost <ehabkost@redhat.com>
Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
---
 target/i386/cpu.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index b5e431e769da..7a3cec59402b 100644
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
@@ -4041,6 +4049,11 @@ static void x86_cpu_expand_features(X86CPU *cpu, Error **errp)
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
2.14.3
