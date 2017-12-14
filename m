Received: from eggs.gnu.org ([2001:4830:134:3::10]:54859)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1ePX2b-0008TF-8o
	for qemu-devel@nongnu.org; Thu, 14 Dec 2017 12:11:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1ePX2a-00071C-8J
	for qemu-devel@nongnu.org; Thu, 14 Dec 2017 12:11:25 -0500
From: Cornelia Huck <cohuck@redhat.com>
Date: Thu, 14 Dec 2017 18:09:35 +0100
Message-Id: <20171214171004.25058-18-cohuck@redhat.com>
In-Reply-To: <20171214171004.25058-1-cohuck@redhat.com>
References: <20171214171004.25058-1-cohuck@redhat.com>
Subject: [Qemu-devel] [PULL 17/46] s390x/tcg: use s390_program_interrupt()
 in per_check_exception()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: qemu-devel@nongnu.org, qemu-s390x@nongnu.org, rth@twiddle.net, agraf@suse.de, thuth@redhat.com, borntraeger@de.ibm.com, david@redhat.com, Cornelia Huck <cohuck@redhat.com>

From: David Hildenbrand <david@redhat.com>

We can now drop updating the cc.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: David Hildenbrand <david@redhat.com>
Message-Id: <20171130162744.25442-13-david@redhat.com>
Signed-off-by: Cornelia Huck <cohuck@redhat.com>
---
 target/s390x/misc_helper.c | 2 +-
 target/s390x/translate.c   | 3 ---
 2 files changed, 1 insertion(+), 4 deletions(-)

diff --git a/target/s390x/misc_helper.c b/target/s390x/misc_helper.c
index ee6179ef89..a911bff706 100644
--- a/target/s390x/misc_helper.c
+++ b/target/s390x/misc_helper.c
@@ -412,7 +412,7 @@ void HELPER(per_check_exception)(CPUS390XState *env)
          * of EXECUTE, while per_address contains the target of EXECUTE.
          */
         ilen = get_ilen(cpu_ldub_code(env, env->per_address));
-        program_interrupt(env, PGM_PER, ilen);
+        s390_program_interrupt(env, PGM_PER, ilen, GETPC());
     }
 }
 
diff --git a/target/s390x/translate.c b/target/s390x/translate.c
index cf8ffa217e..f26fa64a78 100644
--- a/target/s390x/translate.c
+++ b/target/s390x/translate.c
@@ -5837,9 +5837,6 @@ static ExitStatus translate_one(CPUS390XState *env, DisasContext *s)
             tcg_gen_movi_i64(psw_addr, s->next_pc);
         }
 
-        /* Save off cc.  */
-        update_cc_op(s);
-
         /* Call the helper to check for a possible PER exception.  */
         gen_helper_per_check_exception(cpu_env);
     }
-- 
2.13.6
