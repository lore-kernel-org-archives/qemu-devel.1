Received: from eggs.gnu.org ([2001:4830:134:3::10]:36105)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1f4Utg-0007l6-Lx
	for qemu-devel@nongnu.org; Fri, 06 Apr 2018 13:11:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1f4Utd-0007DL-KV
	for qemu-devel@nongnu.org; Fri, 06 Apr 2018 13:11:32 -0400
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Fri,  6 Apr 2018 19:11:03 +0200
Message-Id: <1523034681-33787-3-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1523034681-33787-1-git-send-email-pbonzini@redhat.com>
References: <1523034681-33787-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 02/20] target/i386: Fix andn instruction
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Alexandro Sanchez Bach <alexandro@phi.nz>, qemu-stable@nongnu.org

From: Alexandro Sanchez Bach <alexandro@phi.nz>

In commit 7073fbada733c8d10992f00772c9b9299d740e9b, the `andn` instruction
was implemented via `tcg_gen_andc` but passes the operands in the wrong
order:
- X86 defines `andn dest,src1,src2` as: dest = ~src1 & src2
- TCG defines `andc dest,src1,src2` as: dest = src1 & ~src2

The following simple test shows the issue:

    #include <stdio.h>
    #include <stdint.h>

    int main(void) {
        uint32_t ret = 0;
        __asm (
            "mov $0xFF00, %%ecx\n"
            "mov $0x0F0F, %%eax\n"
            "andn %%ecx, %%eax, %%ecx\n"
            "mov %%ecx, %0\n"
          : "=r" (ret));
        printf("%08X\n", ret);
        return 0;
    }

This patch fixes the problem by simply swapping the order of the two last
arguments in `tcg_gen_andc_tl`.

Reported-by: Alexandro Sanchez Bach <alexandro@phi.nz>
Signed-off-by: Alexandro Sanchez Bach <alexandro@phi.nz>
Cc: qemu-stable@nongnu.org
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/translate.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/i386/translate.c b/target/i386/translate.c
index 0135415..3b7ce92 100644
--- a/target/i386/translate.c
+++ b/target/i386/translate.c
@@ -3802,7 +3802,7 @@ static void gen_sse(CPUX86State *env, DisasContext *s, int b,
                 }
                 ot = mo_64_32(s->dflag);
                 gen_ldst_modrm(env, s, modrm, ot, OR_TMP0, 0);
-                tcg_gen_andc_tl(cpu_T0, cpu_regs[s->vex_v], cpu_T0);
+                tcg_gen_andc_tl(cpu_T0, cpu_T0, cpu_regs[s->vex_v]);
                 gen_op_mov_reg_v(ot, reg, cpu_T0);
                 gen_op_update1_cc();
                 set_cc_op(s, CC_OP_LOGICB + ot);
-- 
1.8.3.1
