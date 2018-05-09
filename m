Received: from eggs.gnu.org ([2001:4830:134:3::10]:43298)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mjc@sifive.com>) id 1fGM69-0003Y8-F7
	for qemu-devel@nongnu.org; Wed, 09 May 2018 06:13:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mjc@sifive.com>) id 1fGM67-0006rV-RY
	for qemu-devel@nongnu.org; Wed, 09 May 2018 06:13:25 -0400
Received: from mail-pf0-x243.google.com ([2607:f8b0:400e:c00::243]:43032)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mjc@sifive.com>) id 1fGM67-0006qo-Kx
	for qemu-devel@nongnu.org; Wed, 09 May 2018 06:13:23 -0400
Received: by mail-pf0-x243.google.com with SMTP id j20so11083311pff.10
	for <qemu-devel@nongnu.org>; Wed, 09 May 2018 03:13:23 -0700 (PDT)
From: Michael Clark <mjc@sifive.com>
Date: Wed,  9 May 2018 22:11:48 +1200
Message-Id: <1525860713-3476-2-git-send-email-mjc@sifive.com>
In-Reply-To: <1525860713-3476-1-git-send-email-mjc@sifive.com>
References: <1525860713-3476-1-git-send-email-mjc@sifive.com>
Subject: [Qemu-devel] [PATCH v1 1/6] target/riscv: avoid integer overflow in
 next_page PC check
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: patches@groups.riscv.org, "Emilio G. Cota" <cota@braap.org>, Michael Clark <mjc@sifive.com>, Palmer Dabbelt <palmer@sifive.com>, Sagar Karandikar <sagark@eecs.berkeley.edu>, Bastian Koppelmann <kbastian@mail.uni-paderborn.de>

From: "Emilio G. Cota" <cota@braap.org>

If the PC is in the last page of the address space, next_page_start
overflows to 0. Fix it.

Reported-by: Richard Henderson <richard.henderson@linaro.org>
Suggested-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Michael Clark <mjc@sifive.com>
Acked-by: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
Cc: Michael Clark <mjc@sifive.com>
Cc: Palmer Dabbelt <palmer@sifive.com>
Cc: Sagar Karandikar <sagark@eecs.berkeley.edu>
Cc: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
Signed-off-by: Emilio G. Cota <cota@braap.org>
---
 target/riscv/translate.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/target/riscv/translate.c b/target/riscv/translate.c
index c0e6a044d383..a98033ca77ca 100644
--- a/target/riscv/translate.c
+++ b/target/riscv/translate.c
@@ -1850,11 +1850,11 @@ void gen_intermediate_code(CPUState *cs, TranslationBlock *tb)
     CPURISCVState *env = cs->env_ptr;
     DisasContext ctx;
     target_ulong pc_start;
-    target_ulong next_page_start;
+    target_ulong page_start;
     int num_insns;
     int max_insns;
     pc_start = tb->pc;
-    next_page_start = (pc_start & TARGET_PAGE_MASK) + TARGET_PAGE_SIZE;
+    page_start = pc_start & TARGET_PAGE_MASK;
     ctx.pc = pc_start;
 
     /* once we have GDB, the rest of the translate.c implementation should be
@@ -1904,7 +1904,7 @@ void gen_intermediate_code(CPUState *cs, TranslationBlock *tb)
         if (cs->singlestep_enabled) {
             break;
         }
-        if (ctx.pc >= next_page_start) {
+        if (ctx.pc - page_start >= TARGET_PAGE_SIZE) {
             break;
         }
         if (tcg_op_buf_full()) {
-- 
2.7.0
