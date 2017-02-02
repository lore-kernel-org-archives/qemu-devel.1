Received: from eggs.gnu.org ([2001:4830:134:3::10]:35430)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <batuzovk@ispras.ru>) id 1cZIU7-0005RI-PN
	for qemu-devel@nongnu.org; Thu, 02 Feb 2017 09:35:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <batuzovk@ispras.ru>) id 1cZIU0-0005Ry-HR
	for qemu-devel@nongnu.org; Thu, 02 Feb 2017 09:35:39 -0500
Received: from bran.ispras.ru ([83.149.199.196]:39800 helo=smtp.ispras.ru)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <batuzovk@ispras.ru>) id 1cZIU0-0005OW-7l
	for qemu-devel@nongnu.org; Thu, 02 Feb 2017 09:35:32 -0500
From: Kirill Batuzov <batuzovk@ispras.ru>
Date: Thu,  2 Feb 2017 17:34:58 +0300
Message-Id: <1486046099-17726-21-git-send-email-batuzovk@ispras.ru>
In-Reply-To: <1486046099-17726-1-git-send-email-batuzovk@ispras.ru>
References: <1486046099-17726-1-git-send-email-batuzovk@ispras.ru>
Subject: [Qemu-devel] [PATCH v2.1 20/21] target/arm: load two consecutive
 64-bits vector regs as a 128-bit vector reg
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <rth@twiddle.net>, Paolo Bonzini <pbonzini@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Peter Maydell <peter.maydell@linaro.org>, Andrzej Zaborowski <balrogg@gmail.com>, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Kirill Batuzov <batuzovk@ispras.ru>

ARM instruction set does not have loads to 128-bit vector register (q-regs).
Instead it can read several consecutive 64-bit vector register (d-regs)
which is used by GCC to load 128-bit registers from memory.

For vector operations to work we need to detect such loads and transform them
into 128-bit loads to 128-bit temporaries.

Signed-off-by: Kirill Batuzov <batuzovk@ispras.ru>
---
 target/arm/translate.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/target/arm/translate.c b/target/arm/translate.c
index 90e14df..5bd0b1c 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -4710,6 +4710,21 @@ static int disas_neon_ls_insn(DisasContext *s, uint32_t insn)
                 tcg_gen_addi_i32(addr, addr, 1 << size);
             }
             if (size == 3) {
+#ifdef TCG_TARGET_HAS_REG128
+                if (rd % 2 == 0 && nregs == 2) {
+                    TCGv aa32addr = gen_aa32_addr(s, addr, MO_TE | MO_128);
+                    /* 128-bit load */
+                    if (load) {
+                        tcg_gen_qemu_ld_v128(cpu_Q[rd / 2], aa32addr,
+                                             get_mem_index(s), MO_TE | MO_128);
+                    } else {
+                        tcg_gen_qemu_st_v128(cpu_Q[rd / 2], aa32addr,
+                                             get_mem_index(s), MO_TE | MO_128);
+                    }
+                    tcg_temp_free(aa32addr);
+                    break;
+                }
+#endif
                 tmp64 = tcg_temp_new_i64();
                 if (load) {
                     gen_aa32_ld64(s, tmp64, addr, get_mem_index(s));
-- 
2.1.4
