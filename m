Received: from eggs.gnu.org ([2001:4830:134:3::10]:60154)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1dY1qM-00016S-Cn
	for qemu-devel@nongnu.org; Wed, 19 Jul 2017 23:09:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1dY1qJ-0005qX-P9
	for qemu-devel@nongnu.org; Wed, 19 Jul 2017 23:09:38 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:41237)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1dY1qJ-0005pP-If
	for qemu-devel@nongnu.org; Wed, 19 Jul 2017 23:09:35 -0400
From: "Emilio G. Cota" <cota@braap.org>
Date: Wed, 19 Jul 2017 23:09:05 -0400
Message-Id: <1500520169-23367-20-git-send-email-cota@braap.org>
In-Reply-To: <1500520169-23367-1-git-send-email-cota@braap.org>
References: <1500520169-23367-1-git-send-email-cota@braap.org>
Subject: [Qemu-devel] [PATCH v3 19/43] target/sparc: check CF_PARALLEL
 instead of parallel_cpus
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <rth@twiddle.net>

Thereby decoupling the resulting translated code from the current state
of the system.

Reviewed-by: Richard Henderson <rth@twiddle.net>
Signed-off-by: Emilio G. Cota <cota@braap.org>
---
 target/sparc/translate.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/sparc/translate.c b/target/sparc/translate.c
index 39d8494..768ce68 100644
--- a/target/sparc/translate.c
+++ b/target/sparc/translate.c
@@ -2450,7 +2450,7 @@ static void gen_ldstub_asi(DisasContext *dc, TCGv dst, TCGv addr, int insn)
     default:
         /* ??? In theory, this should be raise DAE_invalid_asi.
            But the SS-20 roms do ldstuba [%l0] #ASI_M_CTL, %o1.  */
-        if (parallel_cpus) {
+        if (tb_cflags(dc->tb) & CF_PARALLEL) {
             gen_helper_exit_atomic(cpu_env);
         } else {
             TCGv_i32 r_asi = tcg_const_i32(da.asi);
-- 
2.7.4
