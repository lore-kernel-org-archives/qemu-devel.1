Received: from eggs.gnu.org ([2001:4830:134:3::10]:58814)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1e0PRB-00062G-86
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 06:01:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1e0PRA-0007lB-6M
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 06:00:57 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41860)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1e0PR9-0007kV-W7
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 06:00:56 -0400
From: Cornelia Huck <cohuck@redhat.com>
Date: Fri,  6 Oct 2017 11:59:37 +0200
Message-Id: <20171006095956.27534-15-cohuck@redhat.com>
In-Reply-To: <20171006095956.27534-1-cohuck@redhat.com>
References: <20171006095956.27534-1-cohuck@redhat.com>
Subject: [Qemu-devel] [PULL 14/33] s390x/tcg: make stora(g) use the new
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

As we properly handle the return address now, we can drop
potential_page_fault().

Signed-off-by: David Hildenbrand <david@redhat.com>
Message-Id: <20170926183318.12995-5-david@redhat.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Cornelia Huck <cohuck@redhat.com>
---
 target/s390x/mem_helper.c | 8 ++------
 target/s390x/translate.c  | 2 --
 2 files changed, 2 insertions(+), 8 deletions(-)

diff --git a/target/s390x/mem_helper.c b/target/s390x/mem_helper.c
index bc50bc0686..b4f2779428 100644
--- a/target/s390x/mem_helper.c
+++ b/target/s390x/mem_helper.c
@@ -1970,9 +1970,7 @@ uint64_t HELPER(lurag)(CPUS390XState *env, uint64_t addr)
 /* store using real address */
 void HELPER(stura)(CPUS390XState *env, uint64_t addr, uint64_t v1)
 {
-    CPUState *cs = CPU(s390_env_get_cpu(env));
-
-    stl_phys(cs->as, wrap_address(env, addr), (uint32_t)v1);
+    cpu_stl_real_ra(env, wrap_address(env, addr), (uint32_t)v1, GETPC());
 
     if ((env->psw.mask & PSW_MASK_PER) &&
         (env->cregs[9] & PER_CR9_EVENT_STORE) &&
@@ -1985,9 +1983,7 @@ void HELPER(stura)(CPUS390XState *env, uint64_t addr, uint64_t v1)
 
 void HELPER(sturg)(CPUS390XState *env, uint64_t addr, uint64_t v1)
 {
-    CPUState *cs = CPU(s390_env_get_cpu(env));
-
-    stq_phys(cs->as, wrap_address(env, addr), v1);
+    cpu_stq_real_ra(env, wrap_address(env, addr), v1, GETPC());
 
     if ((env->psw.mask & PSW_MASK_PER) &&
         (env->cregs[9] & PER_CR9_EVENT_STORE) &&
diff --git a/target/s390x/translate.c b/target/s390x/translate.c
index f64a31760e..9ef95141f9 100644
--- a/target/s390x/translate.c
+++ b/target/s390x/translate.c
@@ -4126,7 +4126,6 @@ static ExitStatus op_stnosm(DisasContext *s, DisasOps *o)
 static ExitStatus op_stura(DisasContext *s, DisasOps *o)
 {
     check_privileged(s);
-    potential_page_fault(s);
     gen_helper_stura(cpu_env, o->in2, o->in1);
     return NO_EXIT;
 }
@@ -4134,7 +4133,6 @@ static ExitStatus op_stura(DisasContext *s, DisasOps *o)
 static ExitStatus op_sturg(DisasContext *s, DisasOps *o)
 {
     check_privileged(s);
-    potential_page_fault(s);
     gen_helper_sturg(cpu_env, o->in2, o->in1);
     return NO_EXIT;
 }
-- 
2.13.6
