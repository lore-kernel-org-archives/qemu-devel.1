Received: from eggs.gnu.org ([2001:4830:134:3::10]:52358)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <brijesh.singh@amd.com>) id 1clj6t-0006uA-CH
	for qemu-devel@nongnu.org; Wed, 08 Mar 2017 16:27:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <brijesh.singh@amd.com>) id 1clj6q-0005l8-7x
	for qemu-devel@nongnu.org; Wed, 08 Mar 2017 16:27:03 -0500
Received: from mail-bl2nam02on0087.outbound.protection.outlook.com
	([104.47.38.87]:47277
	helo=NAM02-BL2-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <brijesh.singh@amd.com>)
	id 1clj6q-0005kz-07
	for qemu-devel@nongnu.org; Wed, 08 Mar 2017 16:27:00 -0500
From: Brijesh Singh <brijesh.singh@amd.com>
Date: Wed, 8 Mar 2017 15:54:20 -0500
Message-ID: <148900646027.27090.10825101032119361281.stgit@brijesh-build-machine>
In-Reply-To: <148900626714.27090.1616990932333159904.stgit@brijesh-build-machine>
References: <148900626714.27090.1616990932333159904.stgit@brijesh-build-machine>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [RFC PATCH v4 18/20] target/i386: add cpuid Fn8000_001f
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: ehabkost@redhat.com, crosthwaite.peter@gmail.com, armbru@redhat.com, mst@redhat.com, p.fedin@samsung.com, qemu-devel@nongnu.org, lcapitulino@redhat.com, pbonzini@redhat.com, rth@twiddle.net
Cc: Thomas.Lendacky@amd.com, brijesh.singh@amd.com

Fn8000_001f cpuid provides the memory encryption (aka C-bit) location
in a page table for the SEV-enabled guest.

Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
---
 target/i386/cpu.c |    6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index fba9212..44662eb 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -40,6 +40,7 @@
 #include "qapi/visitor.h"
 #include "qom/qom-qobject.h"
 #include "sysemu/arch_init.h"
+#include "sysemu/sev.h"
 
 #if defined(CONFIG_KVM)
 #include <linux/kvm_para.h>
@@ -2966,6 +2967,11 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
             *edx = 0;
         }
         break;
+    case 0x8000001F:
+        if (sev_enabled()) {
+            host_cpuid(index, 0, eax, ebx, ecx, edx);
+        }
+        break;
     case 0xC0000000:
         *eax = env->cpuid_xlevel2;
         *ebx = 0;
