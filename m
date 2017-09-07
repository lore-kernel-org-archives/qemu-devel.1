Received: from eggs.gnu.org ([2001:4830:134:3::10]:38955)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1dq3Bo-0004G4-OZ
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 16:14:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1dq3Bk-0002Gu-5O
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 16:14:16 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59438)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <david@redhat.com>) id 1dq3Bj-0002GY-Vc
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 16:14:12 -0400
From: David Hildenbrand <david@redhat.com>
Date: Thu,  7 Sep 2017 22:13:24 +0200
Message-Id: <20170907201335.13956-11-david@redhat.com>
In-Reply-To: <20170907201335.13956-1-david@redhat.com>
References: <20170907201335.13956-1-david@redhat.com>
Subject: [Qemu-devel] [PATCH v3 10/21] target/s390x: use program_interrupt()
 in per_check_exception()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>, thuth@redhat.com, cohuck@redhat.com, david@redhat.com, borntraeger@de.ibm.com, Alexander Graf <agraf@suse.de>, Eduardo Habkost <ehabkost@redhat.com>, Matthew Rosato <mjrosato@linux.vnet.ibm.com>

Clean it up by reusing program_interrupt(). Add a concern regarding
ilen.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 target/s390x/misc_helper.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/target/s390x/misc_helper.c b/target/s390x/misc_helper.c
index 8b07535b02..f3624d75eb 100644
--- a/target/s390x/misc_helper.c
+++ b/target/s390x/misc_helper.c
@@ -447,14 +447,17 @@ void HELPER(chsc)(CPUS390XState *env, uint64_t inst)
 #ifndef CONFIG_USER_ONLY
 void HELPER(per_check_exception)(CPUS390XState *env)
 {
-    CPUState *cs = CPU(s390_env_get_cpu(env));
+    uint32_t ilen;
 
     if (env->per_perc_atmid) {
-        env->int_pgm_code = PGM_PER;
-        env->int_pgm_ilen = get_ilen(cpu_ldub_code(env, env->per_address));
-
-        cs->exception_index = EXCP_PGM;
-        cpu_loop_exit(cs);
+        /*
+         * FIXME: ILEN_AUTO is most probably the right thing to use. ilen
+         * always has to match the instruction referenced in the PSW. E.g.
+         * if a PER interrupt is triggered via EXECUTE, we have to use ilen
+         * of EXECUTE, while per_address contains the target of EXECUTE.
+         */
+        ilen = get_ilen(cpu_ldub_code(env, env->per_address));
+        program_interrupt(env, PGM_PER, ilen);
     }
 }
 
-- 
2.13.5
