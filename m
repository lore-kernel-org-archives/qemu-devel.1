Received: from eggs.gnu.org ([2001:4830:134:3::10]:52593)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1e49AN-0002cv-3y
	for qemu-devel@nongnu.org; Mon, 16 Oct 2017 13:27:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1e49AL-0003mc-1g
	for qemu-devel@nongnu.org; Mon, 16 Oct 2017 13:27:03 -0400
Received: from mail-pf0-x233.google.com ([2607:f8b0:400e:c00::233]:43803)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1e49AK-0003lt-Rx
	for qemu-devel@nongnu.org; Mon, 16 Oct 2017 13:27:00 -0400
Received: by mail-pf0-x233.google.com with SMTP id a8so15844580pfc.0
	for <qemu-devel@nongnu.org>; Mon, 16 Oct 2017 10:27:00 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Mon, 16 Oct 2017 10:25:52 -0700
Message-Id: <20171016172609.23422-34-richard.henderson@linaro.org>
In-Reply-To: <20171016172609.23422-1-richard.henderson@linaro.org>
References: <20171016172609.23422-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH v6 33/50] target/sparc: check CF_PARALLEL
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
Cc: cota@braap.org

From: "Emilio G. Cota" <cota@braap.org>

Thereby decoupling the resulting translated code from the current state
of the system.

Reviewed-by: Richard Henderson <rth@twiddle.net>
Signed-off-by: Emilio G. Cota <cota@braap.org>
---
 target/sparc/translate.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/sparc/translate.c b/target/sparc/translate.c
index 05414ce8a8..0669d4e8e5 100644
--- a/target/sparc/translate.c
+++ b/target/sparc/translate.c
@@ -2442,7 +2442,7 @@ static void gen_ldstub_asi(DisasContext *dc, TCGv dst, TCGv addr, int insn)
     default:
         /* ??? In theory, this should be raise DAE_invalid_asi.
            But the SS-20 roms do ldstuba [%l0] #ASI_M_CTL, %o1.  */
-        if (parallel_cpus) {
+        if (tb_cflags(dc->tb) & CF_PARALLEL) {
             gen_helper_exit_atomic(cpu_env);
         } else {
             TCGv_i32 r_asi = tcg_const_i32(da.asi);
-- 
2.13.6
