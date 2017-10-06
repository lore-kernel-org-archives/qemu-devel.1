Received: from eggs.gnu.org ([2001:4830:134:3::10]:58834)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1e0PRC-00063E-Tj
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 06:01:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1e0PRC-0007ns-04
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 06:00:59 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51848)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1e0PRB-0007mX-QM
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 06:00:57 -0400
From: Cornelia Huck <cohuck@redhat.com>
Date: Fri,  6 Oct 2017 11:59:38 +0200
Message-Id: <20171006095956.27534-16-cohuck@redhat.com>
In-Reply-To: <20171006095956.27534-1-cohuck@redhat.com>
References: <20171006095956.27534-1-cohuck@redhat.com>
Subject: [Qemu-devel] [PULL 15/33] s390x/tcg: make testblock use the new
 _real mmu
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: qemu-devel@nongnu.org, rth@twiddle.net, agraf@suse.de, thuth@redhat.com, borntraeger@de.ibm.com, david@redhat.com, Cornelia Huck <cohuck@redhat.com>

From: David Hildenbrand <david@redhat.com>

Low address protection checks will be moved into the mmu later.

Signed-off-by: David Hildenbrand <david@redhat.com>
Message-Id: <20170926183318.12995-6-david@redhat.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Cornelia Huck <cohuck@redhat.com>
---
 target/s390x/mem_helper.c | 12 ++----------
 1 file changed, 2 insertions(+), 10 deletions(-)

diff --git a/target/s390x/mem_helper.c b/target/s390x/mem_helper.c
index b4f2779428..3650c1b678 100644
--- a/target/s390x/mem_helper.c
+++ b/target/s390x/mem_helper.c
@@ -1688,17 +1688,9 @@ uint32_t HELPER(testblock)(CPUS390XState *env, uint64_t real_addr)
 {
     uintptr_t ra = GETPC();
     CPUState *cs = CPU(s390_env_get_cpu(env));
-    uint64_t abs_addr;
     int i;
 
-    real_addr = wrap_address(env, real_addr);
-    abs_addr = mmu_real2abs(env, real_addr) & TARGET_PAGE_MASK;
-    if (!address_space_access_valid(&address_space_memory, abs_addr,
-                                    TARGET_PAGE_SIZE, true)) {
-        cpu_restore_state(cs, ra);
-        program_interrupt(env, PGM_ADDRESSING, 4);
-        return 1;
-    }
+    real_addr = wrap_address(env, real_addr) & TARGET_PAGE_MASK;
 
     /* Check low-address protection */
     if ((env->cregs[0] & CR0_LOWPROT) && real_addr < 0x2000) {
@@ -1708,7 +1700,7 @@ uint32_t HELPER(testblock)(CPUS390XState *env, uint64_t real_addr)
     }
 
     for (i = 0; i < TARGET_PAGE_SIZE; i += 8) {
-        stq_phys(cs->as, abs_addr + i, 0);
+        cpu_stq_real_ra(env, real_addr + i, 0, ra);
     }
 
     return 0;
-- 
2.13.6
