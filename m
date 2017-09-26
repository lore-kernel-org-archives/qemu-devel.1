Received: from eggs.gnu.org ([2001:4830:134:3::10]:45149)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1dwufj-0004Pf-Ec
	for qemu-devel@nongnu.org; Tue, 26 Sep 2017 14:33:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1dwufi-0003TY-Ks
	for qemu-devel@nongnu.org; Tue, 26 Sep 2017 14:33:31 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47914)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <david@redhat.com>) id 1dwufi-0003TN-FD
	for qemu-devel@nongnu.org; Tue, 26 Sep 2017 14:33:30 -0400
From: David Hildenbrand <david@redhat.com>
Date: Tue, 26 Sep 2017 20:33:15 +0200
Message-Id: <20170926183318.12995-4-david@redhat.com>
In-Reply-To: <20170926183318.12995-1-david@redhat.com>
References: <20170926183318.12995-1-david@redhat.com>
Subject: [Qemu-devel] [PATCH v1 3/6] s390x/tcg: make lura(g) use the new
 _real mmu.
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

Looks like, lurag was not loading 64bit but only 32bit.

As we properly handle the return address now, we can drop
potential_page_fault().

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 target/s390x/mem_helper.c | 7 ++-----
 target/s390x/translate.c  | 2 --
 2 files changed, 2 insertions(+), 7 deletions(-)

diff --git a/target/s390x/mem_helper.c b/target/s390x/mem_helper.c
index ec4760e390..f8525e05b3 100644
--- a/target/s390x/mem_helper.c
+++ b/target/s390x/mem_helper.c
@@ -1973,16 +1973,13 @@ void HELPER(purge)(CPUS390XState *env)
 /* load using real address */
 uint64_t HELPER(lura)(CPUS390XState *env, uint64_t addr)
 {
-    CPUState *cs = CPU(s390_env_get_cpu(env));
 
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
index 5abd34fb34..d0ce14d120 100644
--- a/target/s390x/translate.c
+++ b/target/s390x/translate.c
@@ -2915,7 +2915,6 @@ static ExitStatus op_lpq(DisasContext *s, DisasOps *o)
 static ExitStatus op_lura(DisasContext *s, DisasOps *o)
 {
     check_privileged(s);
-    potential_page_fault(s);
     gen_helper_lura(o->out, cpu_env, o->in2);
     return NO_EXIT;
 }
@@ -2923,7 +2922,6 @@ static ExitStatus op_lura(DisasContext *s, DisasOps *o)
 static ExitStatus op_lurag(DisasContext *s, DisasOps *o)
 {
     check_privileged(s);
-    potential_page_fault(s);
     gen_helper_lurag(o->out, cpu_env, o->in2);
     return NO_EXIT;
 }
-- 
2.13.5
