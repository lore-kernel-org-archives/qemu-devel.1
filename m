Received: from eggs.gnu.org ([2001:4830:134:3::10]:45166)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1dwufo-0004T4-BQ
	for qemu-devel@nongnu.org; Tue, 26 Sep 2017 14:33:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1dwufn-0003US-D3
	for qemu-devel@nongnu.org; Tue, 26 Sep 2017 14:33:36 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58002)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <david@redhat.com>) id 1dwufn-0003UJ-6U
	for qemu-devel@nongnu.org; Tue, 26 Sep 2017 14:33:35 -0400
From: David Hildenbrand <david@redhat.com>
Date: Tue, 26 Sep 2017 20:33:16 +0200
Message-Id: <20170926183318.12995-5-david@redhat.com>
In-Reply-To: <20170926183318.12995-1-david@redhat.com>
References: <20170926183318.12995-1-david@redhat.com>
Subject: [Qemu-devel] [PATCH v1 4/6] s390x/tcg: make stora(g) use the new
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

As we properly handle the return address now, we can drop
potential_page_fault().

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 target/s390x/mem_helper.c | 8 ++------
 target/s390x/translate.c  | 2 --
 2 files changed, 2 insertions(+), 8 deletions(-)

diff --git a/target/s390x/mem_helper.c b/target/s390x/mem_helper.c
index f8525e05b3..34ffc282bf 100644
--- a/target/s390x/mem_helper.c
+++ b/target/s390x/mem_helper.c
@@ -1985,9 +1985,7 @@ uint64_t HELPER(lurag)(CPUS390XState *env, uint64_t addr)
 /* store using real address */
 void HELPER(stura)(CPUS390XState *env, uint64_t addr, uint64_t v1)
 {
-    CPUState *cs = CPU(s390_env_get_cpu(env));
-
-    stl_phys(cs->as, wrap_address(env, addr), (uint32_t)v1);
+    cpu_stl_real_ra(env, wrap_address(env, addr), (uint32_t)v1, GETPC());
 
     if ((env->psw.mask & PSW_MASK_PER) &&
         (env->cregs[9] & PER_CR9_EVENT_STORE) &&
@@ -2000,9 +1998,7 @@ void HELPER(stura)(CPUS390XState *env, uint64_t addr, uint64_t v1)
 
 void HELPER(sturg)(CPUS390XState *env, uint64_t addr, uint64_t v1)
 {
-    CPUState *cs = CPU(s390_env_get_cpu(env));
-
-    stq_phys(cs->as, wrap_address(env, addr), v1);
+    cpu_stq_real_ra(env, wrap_address(env, addr), v1, GETPC());
 
     if ((env->psw.mask & PSW_MASK_PER) &&
         (env->cregs[9] & PER_CR9_EVENT_STORE) &&
diff --git a/target/s390x/translate.c b/target/s390x/translate.c
index d0ce14d120..ee93fce482 100644
--- a/target/s390x/translate.c
+++ b/target/s390x/translate.c
@@ -4063,7 +4063,6 @@ static ExitStatus op_stnosm(DisasContext *s, DisasOps *o)
 static ExitStatus op_stura(DisasContext *s, DisasOps *o)
 {
     check_privileged(s);
-    potential_page_fault(s);
     gen_helper_stura(cpu_env, o->in2, o->in1);
     return NO_EXIT;
 }
@@ -4071,7 +4070,6 @@ static ExitStatus op_stura(DisasContext *s, DisasOps *o)
 static ExitStatus op_sturg(DisasContext *s, DisasOps *o)
 {
     check_privileged(s);
-    potential_page_fault(s);
     gen_helper_sturg(cpu_env, o->in2, o->in1);
     return NO_EXIT;
 }
-- 
2.13.5
