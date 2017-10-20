Received: from eggs.gnu.org ([2001:4830:134:3::10]:44548)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1e5gbG-0006FG-Ul
	for qemu-devel@nongnu.org; Fri, 20 Oct 2017 19:21:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1e5gbF-0007nX-Hg
	for qemu-devel@nongnu.org; Fri, 20 Oct 2017 19:21:10 -0400
Received: from mail-pf0-x244.google.com ([2607:f8b0:400e:c00::244]:43670)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1e5gbF-0007nL-BS
	for qemu-devel@nongnu.org; Fri, 20 Oct 2017 19:21:09 -0400
Received: by mail-pf0-x244.google.com with SMTP id a8so13074290pfc.0
	for <qemu-devel@nongnu.org>; Fri, 20 Oct 2017 16:21:09 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Fri, 20 Oct 2017 16:20:00 -0700
Message-Id: <20171020232023.15010-30-richard.henderson@linaro.org>
In-Reply-To: <20171020232023.15010-1-richard.henderson@linaro.org>
References: <20171020232023.15010-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH v7 29/52] target/i386: check CF_PARALLEL
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
Cc: cota@braap.org, f4bug@amsat.org, pbonzini@redhat.com

From: "Emilio G. Cota" <cota@braap.org>

Thereby decoupling the resulting translated code from the current state
of the system.

Reviewed-by: Richard Henderson <rth@twiddle.net>
Signed-off-by: Emilio G. Cota <cota@braap.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/i386/translate.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/i386/translate.c b/target/i386/translate.c
index 2e2e0dbddc..70ba0b2d5a 100644
--- a/target/i386/translate.c
+++ b/target/i386/translate.c
@@ -5307,7 +5307,7 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
             if (!(s->cpuid_ext_features & CPUID_EXT_CX16))
                 goto illegal_op;
             gen_lea_modrm(env, s, modrm);
-            if ((s->prefix & PREFIX_LOCK) && parallel_cpus) {
+            if ((s->prefix & PREFIX_LOCK) && (tb_cflags(s->base.tb) & CF_PARALLEL)) {
                 gen_helper_cmpxchg16b(cpu_env, cpu_A0);
             } else {
                 gen_helper_cmpxchg16b_unlocked(cpu_env, cpu_A0);
@@ -5318,7 +5318,7 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
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
