Received: from eggs.gnu.org ([2001:4830:134:3::10]:55168)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1ePX2r-0000KY-Ob
	for qemu-devel@nongnu.org; Thu, 14 Dec 2017 12:11:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1ePX2q-0007H9-VE
	for qemu-devel@nongnu.org; Thu, 14 Dec 2017 12:11:41 -0500
From: Cornelia Huck <cohuck@redhat.com>
Date: Thu, 14 Dec 2017 18:09:39 +0100
Message-Id: <20171214171004.25058-22-cohuck@redhat.com>
In-Reply-To: <20171214171004.25058-1-cohuck@redhat.com>
References: <20171214171004.25058-1-cohuck@redhat.com>
Subject: [Qemu-devel] [PULL 21/46] s390x/tcg: drop potential_page_fault()
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

Only one user left, get rid of it so we don't get any new users.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
Message-Id: <20171130162744.25442-17-david@redhat.com>
Signed-off-by: Cornelia Huck <cohuck@redhat.com>
---
 target/s390x/translate.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/target/s390x/translate.c b/target/s390x/translate.c
index 1ce1390699..26cf993405 100644
--- a/target/s390x/translate.c
+++ b/target/s390x/translate.c
@@ -240,12 +240,6 @@ static void update_cc_op(DisasContext *s)
     }
 }
 
-static void potential_page_fault(DisasContext *s)
-{
-    update_psw_addr(s);
-    update_cc_op(s);
-}
-
 static inline uint64_t ld_code2(CPUS390XState *env, uint64_t pc)
 {
     return (uint64_t)cpu_lduw_code(env, pc);
@@ -2939,7 +2933,8 @@ static ExitStatus op_lpd(DisasContext *s, DisasOps *o)
 
     /* In a parallel context, stop the world and single step.  */
     if (tb_cflags(s->tb) & CF_PARALLEL) {
-        potential_page_fault(s);
+        update_psw_addr(s);
+        update_cc_op(s);
         gen_exception(EXCP_ATOMIC);
         return EXIT_NORETURN;
     }
-- 
2.13.6
