Received: from eggs.gnu.org ([2001:4830:134:3::10]:41731)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mail@kitsu.me>) id 1f4Re1-0000CJ-Du
	for qemu-devel@nongnu.org; Fri, 06 Apr 2018 09:43:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mail@kitsu.me>) id 1f4Rdy-0003uo-8z
	for qemu-devel@nongnu.org; Fri, 06 Apr 2018 09:43:09 -0400
Received: from forward103j.mail.yandex.net ([5.45.198.246]:49922)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mail@kitsu.me>) id 1f4Rdx-0003uC-NT
	for qemu-devel@nongnu.org; Fri, 06 Apr 2018 09:43:06 -0400
From: Eugene Minibaev <mail@kitsu.me>
Date: Fri,  6 Apr 2018 16:41:52 +0300
Message-Id: <20180406134152.17181-1-mail@kitsu.me>
Subject: [Qemu-devel] [PATCH] Add missing bit for SSE instr in VEX decoding
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, rth@twiddle.net, ehabkost@redhat.com

Signed-off-by: Eugene Minibaev <mail@kitsu.me>
---
It seems that x86 vector instructions encoded in VEX are not properly
decoded because of missing bit, here is the example:

IN:
0x08048060:  c5 f9 6f c1              vmovdqa  %xmm1, %xmm0
0x08048064:  b8 01 00 00 00           movl     $1, %eax
0x08048069:  bb 00 00 00 00           movl     $0, %ebx
0x0804806e:  cd 80                    int      $0x80

OUT: [size=191]
0x604370c0:  41 8b 6e ec              movl     -0x14(%r14), %ebp
0x604370c4:  85 ed                    testl    %ebp, %ebp
0x604370c6:  0f 8c a9 00 00 00        jl       0x60437175
0x604370cc:  41 8b 6e 08              movl     8(%r14), %ebp
0x604370d0:  0f b7 ed                 movzwl   %bp, %ebp
0x604370d3:  49 8b fe                 movq     %r14, %rdi
0x604370d6:  8b f5                    movl     %ebp, %esi
0x604370d8:  e8 24 7f cd ff           callq    0x6010f001
0x604370dd:  41 8b 6e 18              movl     0x18(%r14), %ebp
0x604370e1:  65 67 0f b7 6d 00        movzwl   %gs:(%ebp), %ebp
0x604370e7:  41 8b 5e 08              movl     8(%r14), %ebx
0x604370eb:  0f b7 db                 movzwl   %bx, %ebx
0x604370ee:  49 8b fe                 movq     %r14, %rdi
0x604370f1:  8b f3                    movl     %ebx, %esi
0x604370f3:  8b d5                    movl     %ebp, %edx
0x604370f5:  e8 b1 06 cd ff           callq    0x601077ab
0x604370fa:  41 8b 6e 38              movl     0x38(%r14), %ebp
0x604370fe:  d1 e5                    shll     $1, %ebp
0x60437100:  41 8b 5e 18              movl     0x18(%r14), %ebx
...
0x6043716b:  ba 02 00 00 00           movl     $2, %edx     
0x60437170:  e8 20 8d cb ff           callq    0x600efe95            
0x60437175:  b8 43 70 43 60           movl     $0x60437043, %eax
0x6043717a:  e9 99 fe ff ff           jmp      0x60437018   
                                                        
qemu: uncaught target signal 11 (Segmentation fault) - core dumped
make: *** [Makefile:6: run] Segmentation fault (core dumped)
---
 target/i386/translate.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/i386/translate.c b/target/i386/translate.c
index 0135415d92..e2ce7e4061 100644
--- a/target/i386/translate.c
+++ b/target/i386/translate.c
@@ -4564,7 +4564,7 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
             rex_r = (~vex2 >> 4) & 8;
             if (b == 0xc5) {
                 vex3 = vex2;
-                b = x86_ldub_code(env, s);
+                b = x86_ldub_code(env, s) | 0x100;
             } else {
 #ifdef TARGET_X86_64
                 s->rex_x = (~vex2 >> 3) & 8;
-- 
2.16.3
