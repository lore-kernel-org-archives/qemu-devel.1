Received: from eggs.gnu.org ([208.118.235.92]:50305)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gbtmb-0006ST-5h
	for qemu-devel@nongnu.org; Tue, 25 Dec 2018 15:58:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gbtmZ-0000Oh-I3
	for qemu-devel@nongnu.org; Tue, 25 Dec 2018 15:58:32 -0500
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d]:44002)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gbtmY-0000NM-Ke
	for qemu-devel@nongnu.org; Tue, 25 Dec 2018 15:58:31 -0500
Received: by mail-pf1-x42d.google.com with SMTP id w73so7068947pfk.10
	for <qemu-devel@nongnu.org>; Tue, 25 Dec 2018 12:58:30 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Wed, 26 Dec 2018 07:55:09 +1100
Message-Id: <20181225205529.10874-23-richard.henderson@linaro.org>
In-Reply-To: <20181225205529.10874-1-richard.henderson@linaro.org>
References: <20181225205529.10874-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PULL 22/42] disas: Add RISC-V support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, Alistair Francis <Alistair.Francis@wdc.com>, Alistair Francis <alistair.francis@wdc.com>, Michael Clark <mjc@sifive.com>

From: Alistair Francis <Alistair.Francis@wdc.com>

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
Signed-off-by: Michael Clark <mjc@sifive.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <caa478c8987d6042434bb9582017cdf0ea192208.1545246859.git.alistair.francis@wdc.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 disas.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/disas.c b/disas.c
index f9c517b358..d9aa713a40 100644
--- a/disas.c
+++ b/disas.c
@@ -522,8 +522,14 @@ void disas(FILE *out, void *code, unsigned long size)
 # ifdef _ARCH_PPC64
     s.info.cap_mode = CS_MODE_64;
 # endif
-#elif defined(__riscv__)
-    print_insn = print_insn_riscv;
+#elif defined(__riscv) && defined(CONFIG_RISCV_DIS)
+#if defined(_ILP32) || (__riscv_xlen == 32)
+    print_insn = print_insn_riscv32;
+#elif defined(_LP64)
+    print_insn = print_insn_riscv64;
+#else
+#error unsupported RISC-V ABI
+#endif
 #elif defined(__aarch64__) && defined(CONFIG_ARM_A64_DIS)
     print_insn = print_insn_arm_a64;
     s.info.cap_arch = CS_ARCH_ARM64;
-- 
2.17.2
