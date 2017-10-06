Received: from eggs.gnu.org ([2001:4830:134:3::10]:58812)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1e0PRB-00062E-7T
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 06:00:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1e0PR8-0007jY-BV
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 06:00:57 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53036)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1e0PR8-0007ip-4t
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 06:00:54 -0400
From: Cornelia Huck <cohuck@redhat.com>
Date: Fri,  6 Oct 2017 11:59:36 +0200
Message-Id: <20171006095956.27534-14-cohuck@redhat.com>
In-Reply-To: <20171006095956.27534-1-cohuck@redhat.com>
References: <20171006095956.27534-1-cohuck@redhat.com>
Subject: [Qemu-devel] [PULL 13/33] s390x/tcg: make lura(g) use the new _real
 mmu.
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

Looks like, lurag was not loading 64bit but only 32bit.

As we properly handle the return address now, we can drop
potential_page_fault().

Signed-off-by: David Hildenbrand <david@redhat.com>
Message-Id: <20170926183318.12995-4-david@redhat.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Cornelia Huck <cohuck@redhat.com>
---
 target/s390x/mem_helper.c | 8 ++------
 target/s390x/translate.c  | 2 --
 2 files changed, 2 insertions(+), 8 deletions(-)

diff --git a/target/s390x/mem_helper.c b/target/s390x/mem_helper.c
index a254613dc2..bc50bc0686 100644
--- a/target/s390x/mem_helper.c
+++ b/target/s390x/mem_helper.c
@@ -1959,16 +1959,12 @@ void HELPER(purge)(CPUS390XState *env)
 /* load using real address */
 uint64_t HELPER(lura)(CPUS390XState *env, uint64_t addr)
 {
-    CPUState *cs = CPU(s390_env_get_cpu(env));
-
-    return (uint32_t)ldl_phys(cs->as, wrap_address(env, addr));
+    return cpu_ldl_real_ra(env, wrap_address(env, addr), GETPC());
 }
 
 uint64_t HELPER(lurag)(CPUS390XState *env, uint64_t addr)
 {
-    CPUState *cs = CPU(s390_env_get_cpu(env));
-
-    return ldq_phys(cs->as, wrap_address(env, addr));
+    return cpu_ldq_real_ra(env, wrap_address(env, addr), GETPC());
 }
 
 /* store using real address */
diff --git a/target/s390x/translate.c b/target/s390x/translate.c
index 78ffd8ff24..f64a31760e 100644
--- a/target/s390x/translate.c
+++ b/target/s390x/translate.c
@@ -2967,7 +2967,6 @@ static ExitStatus op_lpq(DisasContext *s, DisasOps *o)
 static ExitStatus op_lura(DisasContext *s, DisasOps *o)
 {
     check_privileged(s);
-    potential_page_fault(s);
     gen_helper_lura(o->out, cpu_env, o->in2);
     return NO_EXIT;
 }
@@ -2975,7 +2974,6 @@ static ExitStatus op_lura(DisasContext *s, DisasOps *o)
 static ExitStatus op_lurag(DisasContext *s, DisasOps *o)
 {
     check_privileged(s);
-    potential_page_fault(s);
     gen_helper_lurag(o->out, cpu_env, o->in2);
     return NO_EXIT;
 }
-- 
2.13.6
