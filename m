Received: from eggs.gnu.org ([2001:4830:134:3::10]:46208)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1dWpmb-0001Aq-I6
	for qemu-devel@nongnu.org; Sun, 16 Jul 2017 16:04:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1dWpmV-0008Je-EQ
	for qemu-devel@nongnu.org; Sun, 16 Jul 2017 16:04:49 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:39555)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1dWpmV-0008II-BS
	for qemu-devel@nongnu.org; Sun, 16 Jul 2017 16:04:43 -0400
From: "Emilio G. Cota" <cota@braap.org>
Date: Sun, 16 Jul 2017 16:04:00 -0400
Message-Id: <1500235468-15341-18-git-send-email-cota@braap.org>
In-Reply-To: <1500235468-15341-1-git-send-email-cota@braap.org>
References: <1500235468-15341-1-git-send-email-cota@braap.org>
Subject: [Qemu-devel] [PATCH v2 17/45] target/i386: check CF_PARALLEL
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

Signed-off-by: Emilio G. Cota <cota@braap.org>
---
 target/i386/translate.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/i386/translate.c b/target/i386/translate.c
index 291c577..c5e4d77 100644
--- a/target/i386/translate.c
+++ b/target/i386/translate.c
@@ -5263,7 +5263,7 @@ static target_ulong disas_insn(CPUX86State *env, DisasContext *s,
             if (!(s->cpuid_ext_features & CPUID_EXT_CX16))
                 goto illegal_op;
             gen_lea_modrm(env, s, modrm);
-            if ((s->prefix & PREFIX_LOCK) && parallel_cpus) {
+            if ((s->prefix & PREFIX_LOCK) && s->tb->cflags & CF_PARALLEL) {
                 gen_helper_cmpxchg16b(cpu_env, cpu_A0);
             } else {
                 gen_helper_cmpxchg16b_unlocked(cpu_env, cpu_A0);
@@ -5274,7 +5274,7 @@ static target_ulong disas_insn(CPUX86State *env, DisasContext *s,
             if (!(s->cpuid_features & CPUID_CX8))
                 goto illegal_op;
             gen_lea_modrm(env, s, modrm);
-            if ((s->prefix & PREFIX_LOCK) && parallel_cpus) {
+            if ((s->prefix & PREFIX_LOCK) && s->tb->cflags & CF_PARALLEL) {
                 gen_helper_cmpxchg8b(cpu_env, cpu_A0);
             } else {
                 gen_helper_cmpxchg8b_unlocked(cpu_env, cpu_A0);
-- 
2.7.4
