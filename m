Received: from eggs.gnu.org ([2001:4830:134:3::10]:45831)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1duJzP-00045l-O0
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 10:59:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1duJzK-0000Z9-Id
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 10:59:07 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45380)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1duJzK-0000Yj-Ch
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 10:59:02 -0400
From: Cornelia Huck <cohuck@redhat.com>
Date: Tue, 19 Sep 2017 16:56:18 +0200
Message-Id: <20170919145636.9389-21-cohuck@redhat.com>
In-Reply-To: <20170919145636.9389-1-cohuck@redhat.com>
References: <20170919145636.9389-1-cohuck@redhat.com>
Subject: [Qemu-devel] [PULL 20/38] target/s390x: use program_interrupt() in
 per_check_exception()
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

Clean it up by reusing program_interrupt(). Add a concern regarding
ilen.

Signed-off-by: David Hildenbrand <david@redhat.com>
Message-Id: <20170913132417.24384-11-david@redhat.com>
Signed-off-by: Cornelia Huck <cohuck@redhat.com>
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
