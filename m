Received: from eggs.gnu.org ([2001:4830:134:3::10]:51046)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <batuzovk@ispras.ru>) id 1cTPkp-0003Ha-DA
	for qemu-devel@nongnu.org; Tue, 17 Jan 2017 04:08:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <batuzovk@ispras.ru>) id 1cTPko-0003z5-IB
	for qemu-devel@nongnu.org; Tue, 17 Jan 2017 04:08:35 -0500
Received: from bran.ispras.ru ([83.149.199.196]:50408 helo=smtp.ispras.ru)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <batuzovk@ispras.ru>) id 1cTPko-0003yh-AO
	for qemu-devel@nongnu.org; Tue, 17 Jan 2017 04:08:34 -0500
From: Kirill Batuzov <batuzovk@ispras.ru>
Date: Tue, 17 Jan 2017 12:07:58 +0300
Message-Id: <1484644078-21312-19-git-send-email-batuzovk@ispras.ru>
In-Reply-To: <1484644078-21312-1-git-send-email-batuzovk@ispras.ru>
References: <1484644078-21312-1-git-send-email-batuzovk@ispras.ru>
Subject: [Qemu-devel] [PATCH 18/18] target/arm: load two consecutive 64-bits
 vector regs as a 128-bit vector reg
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <rth@twiddle.net>, Paolo Bonzini <pbonzini@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Peter Maydell <peter.maydell@linaro.org>, Andrzej Zaborowski <balrogg@gmail.com>, Kirill Batuzov <batuzovk@ispras.ru>

ARM instruction set does not have loads to 128-bit vector register (q-regs).
Instead it can read several consecutive 64-bit vector register (d-regs)
which is used by GCC to load 128-bit registers from memory.

For vector operations to work we need to detect such loads and transform them
into 128-bit loads to 128-bit temporaries.

Signed-off-by: Kirill Batuzov <batuzovk@ispras.ru>
---
 target/arm/translate.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/target/arm/translate.c b/target/arm/translate.c
index 4378d44..8b28f77 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -4748,6 +4748,19 @@ static int disas_neon_ls_insn(DisasContext *s, uint32_t insn)
                 tcg_gen_addi_i32(addr, addr, 1 << size);
             }
             if (size == 3) {
+#ifdef TCG_TARGET_HAS_REG128
+                if (rd % 2 == 0 && nregs == 2) {
+                    /* 128-bit load */
+                    if (load) {
+                        tcg_gen_qemu_ld_v128(cpu_Q[rd / 2], addr,
+                                             get_mem_index(s), MO_LE | MO_128);
+                    } else {
+                        tcg_gen_qemu_st_v128(cpu_Q[rd / 2], addr,
+                                             get_mem_index(s), MO_LE | MO_128);
+                    }
+                    break;
+                }
+#endif
                 tmp64 = tcg_temp_new_i64();
                 if (load) {
                     gen_aa32_ld64(s, tmp64, addr, get_mem_index(s));
-- 
2.1.4
