Received: from eggs.gnu.org ([2001:4830:134:3::10]:57196)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Babu.Moger@amd.com>) id 1fGsOD-0005QW-3p
	for qemu-devel@nongnu.org; Thu, 10 May 2018 16:42:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <Babu.Moger@amd.com>) id 1fGsO9-0004Xm-9W
	for qemu-devel@nongnu.org; Thu, 10 May 2018 16:42:13 -0400
Received: from mail-sn1nam01on0069.outbound.protection.outlook.com
	([104.47.32.69]:27968
	helo=NAM01-SN1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <Babu.Moger@amd.com>) id 1fGsO9-0004XC-4V
	for qemu-devel@nongnu.org; Thu, 10 May 2018 16:42:09 -0400
From: Babu Moger <babu.moger@amd.com>
Date: Thu, 10 May 2018 15:41:46 -0500
Message-Id: <20180510204148.11687-7-babu.moger@amd.com>
In-Reply-To: <20180510204148.11687-1-babu.moger@amd.com>
References: <20180510204148.11687-1-babu.moger@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v8 6/8] i386: Add support for CPUID_8000_001E
 for AMD
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: mst@redhat.com, marcel.apfelbaum@gmail.com, pbonzini@redhat.com, rth@twiddle.net, ehabkost@redhat.com, mtosatti@redhat.com
Cc: qemu-devel@nongnu.org, kvm@vger.kernel.org, geoff@hostfission.com, kash@tripleback.net, babu.moger@amd.com

Populate threads/core_id/apic_ids/socket_id when CPUID_EXT3_TOPOEXT
feature is supported. This is required to support hyperthreading feature
on AMD CPUs. This is supported via CPUID_8000_001E extended functions.

Signed-off-by: Babu Moger <babu.moger@amd.com>
Tested-by: Geoffrey McRae <geoff@hostfission.com>
---
 include/hw/i386/topology.h | 6 ++++++
 target/i386/cpu.c          | 7 +++++++
 2 files changed, 13 insertions(+)

diff --git a/include/hw/i386/topology.h b/include/hw/i386/topology.h
index 1ebaee0f76..4af746e50c 100644
--- a/include/hw/i386/topology.h
+++ b/include/hw/i386/topology.h
@@ -145,4 +145,10 @@ static inline apic_id_t x86_apicid_from_cpu_idx(unsigned nr_cores,
     return apicid_from_topo_ids(nr_cores, nr_threads, &topo);
 }
 
+/* Definitions used on CPUID Leaf 0x8000001E */
+#define EXTENDED_APIC_ID(threads, socket_id, core_id, thread_id) \
+                        ((threads) ? \
+                         ((socket_id << 6) | (core_id << 1) | thread_id) : \
+                         ((socket_id << 6) | core_id))
+
 #endif /* HW_I386_TOPOLOGY_H */
diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 6898042787..5cfc7bb0e1 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -4072,6 +4072,13 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
             break;
         }
         break;
+    case 0x8000001E:
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
2.17.0
