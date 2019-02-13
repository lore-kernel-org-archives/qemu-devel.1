Received: from eggs.gnu.org ([209.51.188.92]:48553)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1gtwG5-0004yq-Bm
	for qemu-devel@nongnu.org; Wed, 13 Feb 2019 10:15:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1gtwG4-0000Xl-C9
	for qemu-devel@nongnu.org; Wed, 13 Feb 2019 10:15:33 -0500
Received: from mx2.rt-rk.com ([89.216.37.149]:52982 helo=mail.rt-rk.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
	id 1gtwG0-0000MF-LI
	for qemu-devel@nongnu.org; Wed, 13 Feb 2019 10:15:32 -0500
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
Date: Wed, 13 Feb 2019 16:14:56 +0100
Message-Id: <1550070897-5013-7-git-send-email-aleksandar.markovic@rt-rk.com>
In-Reply-To: <1550070897-5013-1-git-send-email-aleksandar.markovic@rt-rk.com>
References: <1550070897-5013-1-git-send-email-aleksandar.markovic@rt-rk.com>
Subject: [Qemu-devel] [PATCH v2 6/7] tests/tcg: target/mips: Add wrappers
 for MSA interleave instructions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: aurelien@aurel32.net, amarkovic@wavecomp.com, arikalo@wavecomp.com, alex.bennee@linaro.org

From: Aleksandar Markovic <amarkovic@wavecomp.com>

Add wrappers for MSA interleave instructions.

Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
---
 tests/tcg/mips/include/wrappers_msa.h | 39 +++++++++++++++++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/tests/tcg/mips/include/wrappers_msa.h b/tests/tcg/mips/include/wrappers_msa.h
index 8f8d00b..3017ed5 100644
--- a/tests/tcg/mips/include/wrappers_msa.h
+++ b/tests/tcg/mips/include/wrappers_msa.h
@@ -54,4 +54,43 @@ DO_MSA__WD__WS(PCNT_W, pcnt.w)
 DO_MSA__WD__WS(PCNT_D, pcnt.d)
 
 
+#define DO_MSA__WD__WS_WT(suffix, mnemonic)                            \
+static inline void do_msa_##suffix(void *input1, void *input2,         \
+                                   void *output)                       \
+{                                                                      \
+   __asm__ volatile (                                                  \
+      "move $t0, %0\n\t"                                               \
+      "ld.d $w11, 0($t0)\n\t"                                          \
+      "move $t0, %1\n\t"                                               \
+      "ld.d $w12, 0($t0)\n\t"                                          \
+      #mnemonic " $w10, $w11, $w12\n\t"                                \
+      "move $t0, %2\n\t"                                               \
+      "st.d $w10, 0($t0)\n\t"                                          \
+      :                                                                \
+      : "r" (input1), "r" (input2), "r" (output)                       \
+      : "t0", "memory"                                                 \
+   );                                                                  \
+}
+
+DO_MSA__WD__WS_WT(ILVEV_B, ilvev.b)
+DO_MSA__WD__WS_WT(ILVEV_H, ilvev.h)
+DO_MSA__WD__WS_WT(ILVEV_W, ilvev.w)
+DO_MSA__WD__WS_WT(ILVEV_D, ilvev.d)
+
+DO_MSA__WD__WS_WT(ILVOD_B, ilvod.b)
+DO_MSA__WD__WS_WT(ILVOD_H, ilvod.h)
+DO_MSA__WD__WS_WT(ILVOD_W, ilvod.w)
+DO_MSA__WD__WS_WT(ILVOD_D, ilvod.d)
+
+DO_MSA__WD__WS_WT(ILVL_B, ilvl.b)
+DO_MSA__WD__WS_WT(ILVL_H, ilvl.h)
+DO_MSA__WD__WS_WT(ILVL_W, ilvl.w)
+DO_MSA__WD__WS_WT(ILVL_D, ilvl.d)
+
+DO_MSA__WD__WS_WT(ILVR_B, ilvr.b)
+DO_MSA__WD__WS_WT(ILVR_H, ilvr.h)
+DO_MSA__WD__WS_WT(ILVR_W, ilvr.w)
+DO_MSA__WD__WS_WT(ILVR_D, ilvr.d)
+
+
 #endif
-- 
2.7.4
