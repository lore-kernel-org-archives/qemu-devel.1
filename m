Received: from eggs.gnu.org ([2001:4830:134:3::10]:35894)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1e4qy7-0003XY-KL
	for qemu-devel@nongnu.org; Wed, 18 Oct 2017 12:13:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1e4qy6-0002BT-JQ
	for qemu-devel@nongnu.org; Wed, 18 Oct 2017 12:13:19 -0400
Received: from mail-wm0-x241.google.com ([2a00:1450:400c:c09::241]:53411)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1e4qy6-0002Ac-DO
	for qemu-devel@nongnu.org; Wed, 18 Oct 2017 12:13:18 -0400
Received: by mail-wm0-x241.google.com with SMTP id q132so11154409wmd.2
	for <qemu-devel@nongnu.org>; Wed, 18 Oct 2017 09:13:18 -0700 (PDT)
Received: from 640k.lan (94-39-155-245.adsl-ull.clienti.tiscali.it.
	[94.39.155.245])
	by smtp.gmail.com with ESMTPSA id 69sm13436794wmm.2.2017.10.18.09.13.16
	for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Wed, 18 Oct 2017 09:13:16 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Wed, 18 Oct 2017 18:12:07 +0200
Message-Id: <1508343141-31835-16-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1508343141-31835-1-git-send-email-pbonzini@redhat.com>
References: <1508343141-31835-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 15/29] target/i386: trap on instructions longer
 than >15 bytes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Besides being more correct, arbitrarily long instruction allow the
generation of a translation block that spans three pages.  This
confuses the generator and even allows ring 3 code to poison the
translation block cache and inject code into other processes that are
in guest ring 3.

This is an improved (and more invasive) fix for commit 30663fd ("tcg/i386:
Check the size of instruction being translated", 2017-03-24).  In addition
to being more precise (and generating the right exception, which is #GP
rather than #UD), it distinguishes better between page faults and too long
instructions, as shown by this test case:

    #include <sys/mman.h>
    #include <string.h>
    #include <stdio.h>

    int main()
    {
            char *x = mmap(NULL, 8192, PROT_READ|PROT_WRITE|PROT_EXEC,
                           MAP_PRIVATE|MAP_ANON, -1, 0);
            memset(x, 0x66, 4096);
            x[4096] = 0x90;
            x[4097] = 0xc3;
            char *i = x + 4096 - 15;
            mprotect(x + 4096, 4096, PROT_READ|PROT_WRITE);
            ((void(*)(void)) i) ();
    }

... which produces a #GP without the mprotect, and a #PF with it.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/translate.c | 29 ++++++++++++++++++++++-------
 1 file changed, 22 insertions(+), 7 deletions(-)

diff --git a/target/i386/translate.c b/target/i386/translate.c
index 4a938c2..5f24a2d 100644
--- a/target/i386/translate.c
+++ b/target/i386/translate.c
@@ -136,6 +136,7 @@ typedef struct DisasContext {
     int cpuid_ext3_features;
     int cpuid_7_0_ebx_features;
     int cpuid_xsave_features;
+    sigjmp_buf jmpbuf;
 } DisasContext;
 
 static void gen_eob(DisasContext *s);
@@ -1863,11 +1864,27 @@ static void gen_shifti(DisasContext *s1, int op, TCGMemOp ot, int d, int c)
     }
 }
 
+#define X86_MAX_INSN_LENGTH 15
+
 static uint64_t advance_pc(CPUX86State *env, DisasContext *s, int num_bytes)
 {
     uint64_t pc = s->pc;
 
     s->pc += num_bytes;
+    if (unlikely(s->pc - s->pc_start > X86_MAX_INSN_LENGTH)) {
+        /* If the instruction's 16th byte is on a different page than the 1st, a
+         * page fault on the second page wins over the general protection fault
+         * caused by the instruction being too long.
+         * This can happen even if the operand is only one byte long!
+         */
+        if (((s->pc - 1) ^ (pc - 1)) & TARGET_PAGE_MASK) {
+            volatile uint8_t unused =
+                cpu_ldub_code(env, (s->pc - 1) & TARGET_PAGE_MASK);
+            (void) unused;
+        }
+        siglongjmp(s->jmpbuf, 1);
+    }
+
     return pc;
 }
 
@@ -4463,14 +4480,12 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
     s->rip_offset = 0; /* for relative ip address */
     s->vex_l = 0;
     s->vex_v = 0;
- next_byte:
-    /* x86 has an upper limit of 15 bytes for an instruction. Since we
-     * do not want to decode and generate IR for an illegal
-     * instruction, the following check limits the instruction size to
-     * 25 bytes: 14 prefix + 1 opc + 6 (modrm+sib+ofs) + 4 imm */
-    if (s->pc - pc_start > 14) {
-        goto illegal_op;
+    if (sigsetjmp(s->jmpbuf, 0) != 0) {
+        gen_exception(s, EXCP0D_GPF, pc_start - s->cs_base);
+        return s->pc;
     }
+
+ next_byte:
     b = x86_ldub_code(env, s);
     /* Collect prefixes.  */
     switch (b) {
-- 
1.8.3.1
