Received: from eggs.gnu.org ([2001:4830:134:3::10]:46313)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <flukshun@gmail.com>) id 1fV5ia-0002Cn-E1
	for qemu-devel@nongnu.org; Mon, 18 Jun 2018 21:46:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <flukshun@gmail.com>) id 1fV5iZ-0000DR-Gd
	for qemu-devel@nongnu.org; Mon, 18 Jun 2018 21:46:00 -0400
Sender: fluxion <flukshun@gmail.com>
From: Michael Roth <mdroth@linux.vnet.ibm.com>
Date: Mon, 18 Jun 2018 20:42:17 -0500
Message-Id: <20180619014319.28272-52-mdroth@linux.vnet.ibm.com>
In-Reply-To: <20180619014319.28272-1-mdroth@linux.vnet.ibm.com>
References: <20180619014319.28272-1-mdroth@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH 051/113] target/i386: Fix andn instruction
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Alexandro Sanchez Bach <alexandro@phi.nz>, Paolo Bonzini <pbonzini@redhat.com>

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
(cherry picked from commit 5cd10051c2e02b7a86eae49919d6c65a87dbea46)
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 target/i386/translate.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/i386/translate.c b/target/i386/translate.c
index ed5b69d6af..b667753f46 100644
--- a/target/i386/translate.c
+++ b/target/i386/translate.c
@@ -3803,7 +3803,7 @@ static void gen_sse(CPUX86State *env, DisasContext *s, int b,
                 }
                 ot = mo_64_32(s->dflag);
                 gen_ldst_modrm(env, s, modrm, ot, OR_TMP0, 0);
-                tcg_gen_andc_tl(cpu_T0, cpu_regs[s->vex_v], cpu_T0);
+                tcg_gen_andc_tl(cpu_T0, cpu_T0, cpu_regs[s->vex_v]);
                 gen_op_mov_reg_v(ot, reg, cpu_T0);
                 gen_op_update1_cc();
                 set_cc_op(s, CC_OP_LOGICB + ot);
-- 
2.11.0
