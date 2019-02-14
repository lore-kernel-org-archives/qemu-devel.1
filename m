Received: from eggs.gnu.org ([209.51.188.92]:35571)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1guL75-0004cX-ID
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 12:47:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1guL73-0004KG-Kl
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 12:47:55 -0500
Received: from mx2.rt-rk.com ([89.216.37.149]:52322 helo=mail.rt-rk.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
	id 1guL73-0004FM-BA
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 12:47:53 -0500
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
Date: Thu, 14 Feb 2019 18:47:19 +0100
Message-Id: <1550166444-22882-11-git-send-email-aleksandar.markovic@rt-rk.com>
In-Reply-To: <1550166444-22882-1-git-send-email-aleksandar.markovic@rt-rk.com>
References: <1550166444-22882-1-git-send-email-aleksandar.markovic@rt-rk.com>
Subject: [Qemu-devel] [PULL 10/15] tests/tcg: target/mips: Add wrappers for
 MSA bit counting instructions
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

Add a header that contains wrappers around MSA instructions assembler
invocations. For now, only bit counting instructions (NLOC, NLZC, and
PCNT; each in four data format flavors) are supported.

Reviewed-by: Aleksandar Rikalo <arikalo@wavecomp.com>
Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
---
 tests/tcg/mips/include/wrappers_msa.h | 57 +++++++++++++++++++++++++++++++++++
 1 file changed, 57 insertions(+)
 create mode 100644 tests/tcg/mips/include/wrappers_msa.h

diff --git a/tests/tcg/mips/include/wrappers_msa.h b/tests/tcg/mips/include/wrappers_msa.h
new file mode 100644
index 0000000..8f8d00b
--- /dev/null
+++ b/tests/tcg/mips/include/wrappers_msa.h
@@ -0,0 +1,57 @@
+/*
+ *  Header file for wrappers around MSA instructions assembler invocations
+ *
+ *  Copyright (C) 2018  Wave Computing, Inc.
+ *  Copyright (C) 2018  Aleksandar Markovic <amarkovic@wavecomp.com>
+ *
+ *  This program is free software: you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License as published by
+ *  the Free Software Foundation, either version 2 of the License, or
+ *  (at your option) any later version.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License
+ *  along with this program.  If not, see <https://www.gnu.org/licenses/>.
+ *
+ */
+
+#ifndef WRAPPERS_MSA_H
+#define WRAPPERS_MSA_H
+
+
+#define DO_MSA__WD__WS(suffix, mnemonic)                               \
+static inline void do_msa_##suffix(void *input, void *output)          \
+{                                                                      \
+   __asm__ volatile (                                                  \
+      "move $t0, %0\n\t"                                               \
+      "ld.d $w11, 0($t0)\n\t"                                          \
+      #mnemonic " $w10, $w11\n\t"                                      \
+      "move $t0, %1\n\t"                                               \
+      "st.d $w10, 0($t0)\n\t"                                          \
+      :                                                                \
+      : "r" (input), "r" (output)                                      \
+      : "t0", "memory"                                                 \
+   );                                                                  \
+}
+
+DO_MSA__WD__WS(NLOC_B, nloc.b)
+DO_MSA__WD__WS(NLOC_H, nloc.h)
+DO_MSA__WD__WS(NLOC_W, nloc.w)
+DO_MSA__WD__WS(NLOC_D, nloc.d)
+
+DO_MSA__WD__WS(NLZC_B, nlzc.b)
+DO_MSA__WD__WS(NLZC_H, nlzc.h)
+DO_MSA__WD__WS(NLZC_W, nlzc.w)
+DO_MSA__WD__WS(NLZC_D, nlzc.d)
+
+DO_MSA__WD__WS(PCNT_B, pcnt.b)
+DO_MSA__WD__WS(PCNT_H, pcnt.h)
+DO_MSA__WD__WS(PCNT_W, pcnt.w)
+DO_MSA__WD__WS(PCNT_D, pcnt.d)
+
+
+#endif
-- 
2.7.4
