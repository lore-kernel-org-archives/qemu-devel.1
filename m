Received: from eggs.gnu.org ([2001:4830:134:3::10]:45794)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1e7I6k-0008VC-Q7
	for qemu-devel@nongnu.org; Wed, 25 Oct 2017 05:36:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1e7I6g-0008OF-Uw
	for qemu-devel@nongnu.org; Wed, 25 Oct 2017 05:36:18 -0400
Received: from mail-wm0-x244.google.com ([2a00:1450:400c:c09::244]:55144)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1e7I6g-0008Nc-P1
	for qemu-devel@nongnu.org; Wed, 25 Oct 2017 05:36:14 -0400
Received: by mail-wm0-x244.google.com with SMTP id r68so636357wmr.3
	for <qemu-devel@nongnu.org>; Wed, 25 Oct 2017 02:36:14 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Wed, 25 Oct 2017 11:35:12 +0200
Message-Id: <20171025093535.10175-29-richard.henderson@linaro.org>
In-Reply-To: <20171025093535.10175-1-richard.henderson@linaro.org>
References: <20171025093535.10175-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PULL 28/51] target/i386: check CF_PARALLEL instead of
 parallel_cpus
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, "Emilio G. Cota" <cota@braap.org>

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
