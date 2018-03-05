Received: from eggs.gnu.org ([2001:4830:134:3::10]:34914)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Babu.Moger@amd.com>) id 1eswZN-00057n-Q6
	for qemu-devel@nongnu.org; Mon, 05 Mar 2018 15:18:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <Babu.Moger@amd.com>) id 1eswZK-00011h-G6
	for qemu-devel@nongnu.org; Mon, 05 Mar 2018 15:18:49 -0500
Received: from mail-cys01nam02on0074.outbound.protection.outlook.com
	([104.47.37.74]:61218
	helo=NAM02-CY1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <Babu.Moger@amd.com>) id 1eswZK-00011K-6D
	for qemu-devel@nongnu.org; Mon, 05 Mar 2018 15:18:46 -0500
From: Babu Moger <babu.moger@amd.com>
Date: Mon,  5 Mar 2018 15:18:25 -0500
Message-Id: <1520281107-5115-4-git-send-email-babu.moger@amd.com>
In-Reply-To: <1520281107-5115-1-git-send-email-babu.moger@amd.com>
References: <1520281107-5115-1-git-send-email-babu.moger@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v3 3/5] target/i386: Add support for
 CPUID_8000_001E for AMD
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: pbonzini@redhat.com, rth@twiddle.net, ehabkost@redhat.com, rkrcmar@redhat.com
Cc: mtosatti@redhat.com, qemu-devel@nongnu.org, kvm@vger.kernel.org, Gary.Hook@amd.com, Thomas.Lendacky@amd.com, babu.moger@amd.com

From: Stanislav Lanci <pixo@polepetko.eu>

Populate threads/core_id/apic_ids/socket_id when CPUID_EXT3_TOPOEXT
feature is supported. This is required to support hyperthreading feature
on AMD CPUs. This is supported via CPUID_8000_001E extended functions.

Signed-off-by: Stanislav Lanci <pixo@polepetko.eu>
Signed-off-by: Babu Moger <babu.moger@amd.com>
---
 target/i386/cpu.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 1485175..555ab83 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -3666,6 +3666,15 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
             *edx = 0;
         }
         break;
+    case 0x8000001E:
+        if (env->features[FEAT_8000_0001_ECX] & CPUID_EXT3_TOPOEXT) {
+            assert(cpu->core_id <= 255);
+            *eax = cpu->apic_id;
+            *ebx = (cs->nr_threads - 1) << 8 | cpu->core_id;
+            *ecx = cpu->socket_id;
+            *edx = 0;
+        }
+        break;
     case 0xC0000000:
         *eax = env->cpuid_xlevel2;
         *ebx = 0;
-- 
1.8.3.1
