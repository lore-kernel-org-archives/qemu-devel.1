Received: from eggs.gnu.org ([2001:4830:134:3::10]:45026)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Babu.Moger@amd.com>) id 1f0wBm-0002Mx-62
	for qemu-devel@nongnu.org; Tue, 27 Mar 2018 17:31:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <Babu.Moger@amd.com>) id 1f0wBi-0003wT-W3
	for qemu-devel@nongnu.org; Tue, 27 Mar 2018 17:31:30 -0400
Received: from mail-bn3nam01on0074.outbound.protection.outlook.com
	([104.47.33.74]:29427
	helo=NAM01-BN3-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <Babu.Moger@amd.com>) id 1f0wBi-0003vP-PH
	for qemu-devel@nongnu.org; Tue, 27 Mar 2018 17:31:26 -0400
From: Babu Moger <babu.moger@amd.com>
Date: Tue, 27 Mar 2018 17:31:07 -0400
Message-Id: <1522186271-27743-6-git-send-email-babu.moger@amd.com>
In-Reply-To: <1522186271-27743-1-git-send-email-babu.moger@amd.com>
References: <1522186271-27743-1-git-send-email-babu.moger@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v5 5/9] i386: Use the statically loaded cache
 definitions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: mst@redhat.com, marcel@redhat.com, pbonzini@redhat.com, rth@twiddle.net, ehabkost@redhat.com, mtosatti@redhat.com
Cc: qemu-devel@nongnu.org, kvm@vger.kernel.org, kash@tripleback.net, babu.moger@amd.com

Use the statically loaded cache definitions if available
and legacy-cache parameter is not set.

Signed-off-by: Babu Moger <babu.moger@amd.com>
---
 target/i386/cpu.c | 22 +++++++++++++++++-----
 1 file changed, 17 insertions(+), 5 deletions(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index f4fbe3a..738927d 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -3938,8 +3938,13 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
                (L1_ITLB_2M_ASSOC <<  8) | (L1_ITLB_2M_ENTRIES);
         *ebx = (L1_DTLB_4K_ASSOC << 24) | (L1_DTLB_4K_ENTRIES << 16) | \
                (L1_ITLB_4K_ASSOC <<  8) | (L1_ITLB_4K_ENTRIES);
-        *ecx = encode_cache_cpuid80000005(&l1d_cache_amd);
-        *edx = encode_cache_cpuid80000005(&l1i_cache_amd);
+        if (env->cache_info.valid && !cpu->legacy_cache) {
+            *ecx = encode_cache_cpuid80000005(&env->cache_info.l1d_cache);
+            *edx = encode_cache_cpuid80000005(&env->cache_info.l1i_cache);
+        } else {
+            *ecx = encode_cache_cpuid80000005(&l1d_cache_amd);
+            *edx = encode_cache_cpuid80000005(&l1i_cache_amd);
+        }
         break;
     case 0x80000006:
         /* cache info (L2 cache) */
@@ -3955,9 +3960,16 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
                (L2_DTLB_4K_ENTRIES << 16) | \
                (AMD_ENC_ASSOC(L2_ITLB_4K_ASSOC) << 12) | \
                (L2_ITLB_4K_ENTRIES);
-        encode_cache_cpuid80000006(&l2_cache_amd,
-                                   cpu->enable_l3_cache ? &l3_cache : NULL,
-                                   ecx, edx);
+        if (env->cache_info.valid && !cpu->legacy_cache) {
+            encode_cache_cpuid80000006(&env->cache_info.l2_cache,
+                                       cpu->enable_l3_cache ?
+                                       &env->cache_info.l3_cache : NULL,
+                                       ecx, edx);
+        } else {
+            encode_cache_cpuid80000006(&l2_cache_amd,
+                                       cpu->enable_l3_cache ? &l3_cache : NULL,
+                                       ecx, edx);
+        }
         break;
     case 0x80000007:
         *eax = 0;
-- 
1.8.3.1
