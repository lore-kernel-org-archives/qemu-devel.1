Received: from eggs.gnu.org ([2001:4830:134:3::10]:57332)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dDeSJ-0007ZE-QN
	for qemu-devel@nongnu.org; Wed, 24 May 2017 18:08:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dDeSI-00055c-RF
	for qemu-devel@nongnu.org; Wed, 24 May 2017 18:08:35 -0400
Received: from mail-qk0-x243.google.com ([2607:f8b0:400d:c09::243]:35939)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dDeSI-00054W-MF
	for qemu-devel@nongnu.org; Wed, 24 May 2017 18:08:34 -0400
Received: by mail-qk0-x243.google.com with SMTP id y128so28223777qka.3
	for <qemu-devel@nongnu.org>; Wed, 24 May 2017 15:08:34 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
From: Richard Henderson <rth@twiddle.net>
Date: Wed, 24 May 2017 15:08:24 -0700
Message-Id: <20170524220827.21154-2-rth@twiddle.net>
In-Reply-To: <20170524220827.21154-1-rth@twiddle.net>
References: <20170524220827.21154-1-rth@twiddle.net>
Subject: [Qemu-devel] [PATCH 1/4] target/s390x: Save current ilen during
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
Cc: thuth@redhat.com, aurelien@aurel32.net

Use this saved value instead of recomputing from next_pc difference.

Signed-off-by: Richard Henderson <rth@twiddle.net>
---
 target/s390x/translate.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/target/s390x/translate.c b/target/s390x/translate.c
index 4bd16d9..5b8333f 100644
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
 
@@ -2207,7 +2208,7 @@ static ExitStatus op_ex(DisasContext *s, DisasOps *o)
         v1 = regs[r1];
     }
 
-    ilen = tcg_const_i32(s->next_pc - s->pc);
+    ilen = tcg_const_i32(s->ilen);
     gen_helper_ex(cpu_env, ilen, v1, o->in2);
     tcg_temp_free_i32(ilen);
 
@@ -4052,7 +4053,7 @@ static ExitStatus op_svc(DisasContext *s, DisasOps *o)
     tcg_gen_st_i32(t, cpu_env, offsetof(CPUS390XState, int_svc_code));
     tcg_temp_free_i32(t);
 
-    t = tcg_const_i32(s->next_pc - s->pc);
+    t = tcg_const_i32(s->ilen);
     tcg_gen_st_i32(t, cpu_env, offsetof(CPUS390XState, int_svc_ilen));
     tcg_temp_free_i32(t);
 
@@ -5191,6 +5192,7 @@ static const DisasInsn *extract_insn(CPUS390XState *env, DisasContext *s,
     op = (insn >> 8) & 0xff;
     ilen = get_ilen(op);
     s->next_pc = s->pc + ilen;
+    s->ilen = ilen;
 
     switch (ilen) {
     case 2:
-- 
2.9.4
