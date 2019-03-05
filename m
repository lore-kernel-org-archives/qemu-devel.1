Received: from eggs.gnu.org ([209.51.188.92]:47005)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1h1ESk-0001Aj-7z
	for qemu-devel@nongnu.org; Tue, 05 Mar 2019 13:06:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1h1ESj-0002AY-7l
	for qemu-devel@nongnu.org; Tue, 05 Mar 2019 13:06:46 -0500
Received: from mx2.rt-rk.com ([89.216.37.149]:51691 helo=mail.rt-rk.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
	id 1h1ESi-00028M-6N
	for qemu-devel@nongnu.org; Tue, 05 Mar 2019 13:06:44 -0500
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
Date: Tue,  5 Mar 2019 19:05:19 +0100
Message-Id: <1551809127-3658-8-git-send-email-aleksandar.markovic@rt-rk.com>
In-Reply-To: <1551809127-3658-1-git-send-email-aleksandar.markovic@rt-rk.com>
References: <1551809127-3658-1-git-send-email-aleksandar.markovic@rt-rk.com>
Subject: [Qemu-devel] [PULL 07/15] tests/tcg: target/mips: Extend
 functionality of MSA wrapper macros
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, amarkovic@wavecomp.com

From: Aleksandar Markovic <amarkovic@wavecomp.com>

Add macros that will allow testing cases when one of the source
registers is identical to the destination register.

Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
Reviewed-by: Aleksandar Rikalo <arikalo@wavecomp.com>
Message-Id: <1551800076-8104-8-git-send-email-aleksandar.markovic@rt-rk.com>
---
 tests/tcg/mips/include/wrappers_msa.h | 51 +++++++++++++++++++++++++++++++++++
 1 file changed, 51 insertions(+)

diff --git a/tests/tcg/mips/include/wrappers_msa.h b/tests/tcg/mips/include/wrappers_msa.h
index c650ed2..9cffd55 100644
--- a/tests/tcg/mips/include/wrappers_msa.h
+++ b/tests/tcg/mips/include/wrappers_msa.h
@@ -38,6 +38,21 @@ static inline void do_msa_##suffix(void *input, void *output)          \
    );                                                                  \
 }
 
+#define DO_MSA__WD__WD(suffix, mnemonic)                               \
+static inline void do_msa_##suffix(void *input, void *output)          \
+{                                                                      \
+   __asm__ volatile (                                                  \
+      "move $t0, %0\n\t"                                               \
+      "ld.d $w11, 0($t0)\n\t"                                          \
+      #mnemonic " $w10, $w10\n\t"                                      \
+      "move $t0, %1\n\t"                                               \
+      "st.d $w10, 0($t0)\n\t"                                          \
+      :                                                                \
+      : "r" (input), "r" (output)                                      \
+      : "t0", "memory"                                                 \
+   );                                                                  \
+}
+
 DO_MSA__WD__WS(NLOC_B, nloc.b)
 DO_MSA__WD__WS(NLOC_H, nloc.h)
 DO_MSA__WD__WS(NLOC_W, nloc.w)
@@ -72,6 +87,42 @@ static inline void do_msa_##suffix(void *input1, void *input2,         \
    );                                                                  \
 }
 
+#define DO_MSA__WD__WD_WT(suffix, mnemonic)                            \
+static inline void do_msa_##suffix(void *input1, void *input2,         \
+                                   void *output)                       \
+{                                                                      \
+   __asm__ volatile (                                                  \
+      "move $t0, %0\n\t"                                               \
+      "ld.d $w11, 0($t0)\n\t"                                          \
+      "move $t0, %1\n\t"                                               \
+      "ld.d $w12, 0($t0)\n\t"                                          \
+      #mnemonic " $w10, $w10, $w12\n\t"                                \
+      "move $t0, %2\n\t"                                               \
+      "st.d $w10, 0($t0)\n\t"                                          \
+      :                                                                \
+      : "r" (input1), "r" (input2), "r" (output)                       \
+      : "t0", "memory"                                                 \
+   );                                                                  \
+}
+
+#define DO_MSA__WD__WS_WD(suffix, mnemonic)                            \
+static inline void do_msa_##suffix(void *input1, void *input2,         \
+                                   void *output)                       \
+{                                                                      \
+   __asm__ volatile (                                                  \
+      "move $t0, %0\n\t"                                               \
+      "ld.d $w11, 0($t0)\n\t"                                          \
+      "move $t0, %1\n\t"                                               \
+      "ld.d $w12, 0($t0)\n\t"                                          \
+      #mnemonic " $w10, $w11, $w10\n\t"                                \
+      "move $t0, %2\n\t"                                               \
+      "st.d $w10, 0($t0)\n\t"                                          \
+      :                                                                \
+      : "r" (input1), "r" (input2), "r" (output)                       \
+      : "t0", "memory"                                                 \
+   );                                                                  \
+}
+
 DO_MSA__WD__WS_WT(ILVEV_B, ilvev.b)
 DO_MSA__WD__WS_WT(ILVEV_H, ilvev.h)
 DO_MSA__WD__WS_WT(ILVEV_W, ilvev.w)
-- 
2.7.4
