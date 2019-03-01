Received: from eggs.gnu.org ([209.51.188.92]:38099)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1gznhc-0005dK-O7
	for qemu-devel@nongnu.org; Fri, 01 Mar 2019 14:20:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1gznhX-0004EN-R0
	for qemu-devel@nongnu.org; Fri, 01 Mar 2019 14:20:10 -0500
Received: from mx2.rt-rk.com ([89.216.37.149]:42030 helo=mail.rt-rk.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
	id 1gznhU-00041m-Vg
	for qemu-devel@nongnu.org; Fri, 01 Mar 2019 14:20:06 -0500
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
Date: Fri,  1 Mar 2019 20:18:32 +0100
Message-Id: <1551467914-11209-9-git-send-email-aleksandar.markovic@rt-rk.com>
In-Reply-To: <1551467914-11209-1-git-send-email-aleksandar.markovic@rt-rk.com>
References: <1551467914-11209-1-git-send-email-aleksandar.markovic@rt-rk.com>
Subject: [Qemu-devel] [PATCH v5 08/10] tests/tcg: target/mips: Add wrappers
 for some MIPS64R6 instructions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: aurelien@aurel32.net, amarkovic@wavecomp.com, arikalo@wavecomp.com

From: Aleksandar Markovic <amarkovic@wavecomp.com>

Add wrappers for some MIPS64R6 instructions.

Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
---
 tests/tcg/mips/include/wrappers_mips64r6.h | 64 ++++++++++++++++++++++++++++++
 1 file changed, 64 insertions(+)
 create mode 100644 tests/tcg/mips/include/wrappers_mips64r6.h

diff --git a/tests/tcg/mips/include/wrappers_mips64r6.h b/tests/tcg/mips/include/wrappers_mips64r6.h
new file mode 100644
index 0000000..c9c34aa
--- /dev/null
+++ b/tests/tcg/mips/include/wrappers_mips64r6.h
@@ -0,0 +1,64 @@
+/*
+ *  Header file for wrappers around MIPS64R6 instructions assembler
+ *  invocations
+ *
+ *  Copyright (C) 2019  Wave Computing, Inc.
+ *  Copyright (C) 2019  Aleksandar Markovic <amarkovic@wavecomp.com>
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
+#ifndef WRAPPERS_MIPS64R6_H
+#define WRAPPERS_MIPS64R6_H
+
+
+#define DO_MIPS64R6__RD__RS(suffix, mnemonic)                          \
+static inline void do_mips64r6_##suffix(void *input, void *output)     \
+{                                                                      \
+   __asm__ volatile (                                                  \
+      "ld $t1, 0(%0)\n\t"                                              \
+      #mnemonic " $t0, $t1\n\t"                                        \
+      "sd $t0, 0(%1)\n\t"                                              \
+      :                                                                \
+      : "r" (input), "r" (output)                                      \
+      : "t0", "t1", "memory"                                           \
+   );                                                                  \
+}
+
+DO_MIPS64R6__RD__RS(DCLO, dclo)
+DO_MIPS64R6__RD__RS(DCLZ, dclz)
+DO_MIPS64R6__RD__RS(BITSWAP, bitswap)
+DO_MIPS64R6__RD__RS(DBITSWAP, dbitswap)
+
+
+#define DO_MIPS64R6__RD__RS_RT(suffix, mnemonic)                       \
+static inline void do_mips64r6_##suffix(void *input1, void *input2,    \
+                                        void *output)                  \
+{                                                                      \
+   __asm__ volatile (                                                  \
+      "ld $t1, 0(%0)\n\t"                                              \
+      "ld $t2, 0(%1)\n\t"                                              \
+      #mnemonic " $t0, $t1, $t2\n\t"                                   \
+      "sd $t0, 0(%2)\n\t"                                              \
+      :                                                                \
+      : "r" (input1), "r" (input2), "r" (output)                       \
+      : "t0", "t1", "memory"                                           \
+   );                                                                  \
+}
+
+DO_MIPS64R6__RD__RS_RT(DSLLV, dsllv)
+
+
+#endif
-- 
2.7.4
