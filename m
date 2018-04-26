Received: from eggs.gnu.org ([2001:4830:134:3::10]:45077)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Babu.Moger@amd.com>) id 1fBjjj-0000Qp-T2
	for qemu-devel@nongnu.org; Thu, 26 Apr 2018 12:27:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <Babu.Moger@amd.com>) id 1fBjji-0003K9-5k
	for qemu-devel@nongnu.org; Thu, 26 Apr 2018 12:27:11 -0400
Received: from mail-sn1nam01on0066.outbound.protection.outlook.com
	([104.47.32.66]:21611
	helo=NAM01-SN1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <Babu.Moger@amd.com>) id 1fBjjh-0003Jt-VE
	for qemu-devel@nongnu.org; Thu, 26 Apr 2018 12:27:10 -0400
From: Babu Moger <babu.moger@amd.com>
Date: Thu, 26 Apr 2018 11:26:47 -0500
Message-Id: <1524760009-24710-8-git-send-email-babu.moger@amd.com>
In-Reply-To: <1524760009-24710-1-git-send-email-babu.moger@amd.com>
References: <1524760009-24710-1-git-send-email-babu.moger@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v7 7/9] i386: Add support for CPUID_8000_001E
 for AMD
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: mst@redhat.com, marcel@redhat.com, pbonzini@redhat.com, rth@twiddle.net, ehabkost@redhat.com, mtosatti@redhat.com
Cc: qemu-devel@nongnu.org, kvm@vger.kernel.org, kash@tripleback.net, geoff@hostfission.com, babu.moger@amd.com

Populate threads/core_id/apic_ids/socket_id when CPUID_EXT3_TOPOEXT
feature is supported. This is required to support hyperthreading feature
on AMD CPUs. This is supported via CPUID_8000_001E extended functions.

Signed-off-by: Babu Moger <babu.moger@amd.com>
Tested-by: Geoffrey McRae <geoff@hostfission.com>
---
 target/i386/cpu.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 1024b09..1b15023 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -315,6 +315,12 @@ static uint32_t encode_cache_cpuid80000005(CPUCacheInfo *cache)
                          (((CORES_IN_CMPLX - 1) * 2) + 1)  : \
                          (CORES_IN_CMPLX - 1))
 
+/* Definitions used on CPUID Leaf 0x8000001E */
+#define EXTENDED_APIC_ID(threads, socket_id, core_id, thread_id) \
+                        ((threads) ? \
+                         ((socket_id << 6) | (core_id << 1) | thread_id) : \
+                         ((socket_id << 6) | core_id))
+
 /*
  * Encode cache info for CPUID[0x80000006].ECX and CPUID[0x80000006].EDX
  * @l3 can be NULL.
@@ -4105,6 +4111,14 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
             break;
         }
         break;
+    case 0x8000001E:
+        assert(cpu->core_id <= 255);
+        *eax = EXTENDED_APIC_ID((cs->nr_threads - 1),
+               cpu->socket_id, cpu->core_id, cpu->thread_id);
+        *ebx = (cs->nr_threads - 1) << 8 | cpu->core_id;
+        *ecx = cpu->socket_id;
+        *edx = 0;
+        break;
     case 0xC0000000:
         *eax = env->cpuid_xlevel2;
         *ebx = 0;
-- 
2.7.4
