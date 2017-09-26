Received: from eggs.gnu.org ([2001:4830:134:3::10]:45184)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1dwufq-0004Uf-7c
	for qemu-devel@nongnu.org; Tue, 26 Sep 2017 14:33:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1dwufp-0003V0-Fv
	for qemu-devel@nongnu.org; Tue, 26 Sep 2017 14:33:38 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42424)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <david@redhat.com>) id 1dwufp-0003Ul-AO
	for qemu-devel@nongnu.org; Tue, 26 Sep 2017 14:33:37 -0400
From: David Hildenbrand <david@redhat.com>
Date: Tue, 26 Sep 2017 20:33:17 +0200
Message-Id: <20170926183318.12995-6-david@redhat.com>
In-Reply-To: <20170926183318.12995-1-david@redhat.com>
References: <20170926183318.12995-1-david@redhat.com>
Subject: [Qemu-devel] [PATCH v1 5/6] s390x/tcg: make testblock use the new
 _real mmu
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: thuth@redhat.com, cohuck@redhat.com, Christian Borntraeger <borntraeger@de.ibm.com>, Alexander Graf <agraf@suse.de>, Richard Henderson <rth@twiddle.net>, David Hildenbrand <david@redhat.com>

Low address protection checks will be moved into the mmu later.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 target/s390x/mem_helper.c | 12 ++----------
 1 file changed, 2 insertions(+), 10 deletions(-)

diff --git a/target/s390x/mem_helper.c b/target/s390x/mem_helper.c
index 34ffc282bf..4cf4f29171 100644
--- a/target/s390x/mem_helper.c
+++ b/target/s390x/mem_helper.c
@@ -1702,17 +1702,9 @@ uint32_t HELPER(testblock)(CPUS390XState *env, uint64_t real_addr)
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
@@ -1722,7 +1714,7 @@ uint32_t HELPER(testblock)(CPUS390XState *env, uint64_t real_addr)
     }
 
     for (i = 0; i < TARGET_PAGE_SIZE; i += 8) {
-        stq_phys(cs->as, abs_addr + i, 0);
+        cpu_stq_real_ra(env, real_addr + i, 0, ra);
     }
 
     return 0;
-- 
2.13.5
