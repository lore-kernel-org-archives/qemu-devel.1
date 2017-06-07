Received: from eggs.gnu.org ([2001:4830:134:3::10]:33959)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dIOtP-0002t1-NJ
	for qemu-devel@nongnu.org; Tue, 06 Jun 2017 20:32:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dIOtO-00024Y-Ti
	for qemu-devel@nongnu.org; Tue, 06 Jun 2017 20:32:11 -0400
Received: from mail-qt0-x243.google.com ([2607:f8b0:400d:c0d::243]:33061)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dIOtO-00024R-PL
	for qemu-devel@nongnu.org; Tue, 06 Jun 2017 20:32:10 -0400
Received: by mail-qt0-x243.google.com with SMTP id w1so26596206qtg.0
	for <qemu-devel@nongnu.org>; Tue, 06 Jun 2017 17:32:10 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
From: Richard Henderson <rth@twiddle.net>
Date: Tue,  6 Jun 2017 17:30:44 -0700
Message-Id: <20170607003119.14778-36-rth@twiddle.net>
In-Reply-To: <20170607003119.14778-1-rth@twiddle.net>
References: <20170607003119.14778-1-rth@twiddle.net>
Subject: [Qemu-devel] [PULL v2 35/70] target/s390x: Save current ilen during
 translation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, aurelien@aurel32.net

Use this saved value instead of recomputing from next_pc difference.

Reviewed-by: David Hildenbrand <david@redhat.com>
Reviewed-by: Aurelien Jarno <aurelien@aurel32.net>
Signed-off-by: Richard Henderson <rth@twiddle.net>
---
 target/s390x/translate.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/target/s390x/translate.c b/target/s390x/translate.c
index 737b577..5c7e5c1 100644
--- a/target/s390x/translate.c
+++ b/target/s390x/translate.c
@@ -58,6 +58,7 @@ struct DisasContext {
     const DisasInsn *insn;
     DisasFields *fields;
     uint64_t pc, next_pc;
+    uint32_t ilen;
     enum cc_op cc_op;
     bool singlestep_enabled;
 };
@@ -349,7 +350,7 @@ static void gen_program_exception(DisasContext *s, int code)
     tcg_gen_st_i32(tmp, cpu_env, offsetof(CPUS390XState, int_pgm_code));
     tcg_temp_free_i32(tmp);
 
-    tmp = tcg_const_i32(s->next_pc - s->pc);
+    tmp = tcg_const_i32(s->ilen);
     tcg_gen_st_i32(tmp, cpu_env, offsetof(CPUS390XState, int_pgm_ilen));
     tcg_temp_free_i32(tmp);
 
@@ -2212,7 +2213,7 @@ static ExitStatus op_ex(DisasContext *s, DisasOps *o)
         v1 = regs[r1];
     }
 
-    ilen = tcg_const_i32(s->next_pc - s->pc);
+    ilen = tcg_const_i32(s->ilen);
     gen_helper_ex(cpu_env, ilen, v1, o->in2);
     tcg_temp_free_i32(ilen);
 
@@ -4057,7 +4058,7 @@ static ExitStatus op_svc(DisasContext *s, DisasOps *o)
     tcg_gen_st_i32(t, cpu_env, offsetof(CPUS390XState, int_svc_code));
     tcg_temp_free_i32(t);
 
-    t = tcg_const_i32(s->next_pc - s->pc);
+    t = tcg_const_i32(s->ilen);
     tcg_gen_st_i32(t, cpu_env, offsetof(CPUS390XState, int_svc_ilen));
     tcg_temp_free_i32(t);
 
@@ -5196,6 +5197,7 @@ static const DisasInsn *extract_insn(CPUS390XState *env, DisasContext *s,
     op = (insn >> 8) & 0xff;
     ilen = get_ilen(op);
     s->next_pc = s->pc + ilen;
+    s->ilen = ilen;
 
     switch (ilen) {
     case 2:
-- 
2.9.4
