Received: from eggs.gnu.org ([2001:4830:134:3::10]:52496)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1e49AG-0002WF-OZ
	for qemu-devel@nongnu.org; Mon, 16 Oct 2017 13:26:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1e49AF-0003hq-OM
	for qemu-devel@nongnu.org; Mon, 16 Oct 2017 13:26:56 -0400
Received: from mail-pg0-x22b.google.com ([2607:f8b0:400e:c05::22b]:54130)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1e49AF-0003hR-Ic
	for qemu-devel@nongnu.org; Mon, 16 Oct 2017 13:26:55 -0400
Received: by mail-pg0-x22b.google.com with SMTP id s2so7347008pge.10
	for <qemu-devel@nongnu.org>; Mon, 16 Oct 2017 10:26:55 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Mon, 16 Oct 2017 10:25:48 -0700
Message-Id: <20171016172609.23422-30-richard.henderson@linaro.org>
In-Reply-To: <20171016172609.23422-1-richard.henderson@linaro.org>
References: <20171016172609.23422-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH v6 29/50] target/i386: check CF_PARALLEL
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
 target/i386/translate.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/i386/translate.c b/target/i386/translate.c
index f60582082e..6663cd1db8 100644
--- a/target/i386/translate.c
+++ b/target/i386/translate.c
@@ -5265,7 +5265,7 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
             if (!(s->cpuid_ext_features & CPUID_EXT_CX16))
                 goto illegal_op;
             gen_lea_modrm(env, s, modrm);
-            if ((s->prefix & PREFIX_LOCK) && parallel_cpus) {
+            if ((s->prefix & PREFIX_LOCK) && (tb_cflags(s->base.tb) & CF_PARALLEL)) {
                 gen_helper_cmpxchg16b(cpu_env, cpu_A0);
             } else {
                 gen_helper_cmpxchg16b_unlocked(cpu_env, cpu_A0);
@@ -5276,7 +5276,7 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
             if (!(s->cpuid_features & CPUID_CX8))
                 goto illegal_op;
             gen_lea_modrm(env, s, modrm);
-            if ((s->prefix & PREFIX_LOCK) && parallel_cpus) {
+            if ((s->prefix & PREFIX_LOCK) && (tb_cflags(s->base.tb) & CF_PARALLEL)) {
                 gen_helper_cmpxchg8b(cpu_env, cpu_A0);
             } else {
                 gen_helper_cmpxchg8b_unlocked(cpu_env, cpu_A0);
-- 
2.13.6
