Received: from eggs.gnu.org ([209.51.188.92]:35465)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1h1C6A-0002Qi-3j
	for qemu-devel@nongnu.org; Tue, 05 Mar 2019 10:35:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1h1C65-0002yY-0b
	for qemu-devel@nongnu.org; Tue, 05 Mar 2019 10:35:16 -0500
Received: from mx2.rt-rk.com ([89.216.37.149]:54818 helo=mail.rt-rk.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
	id 1h1C64-0002o2-D1
	for qemu-devel@nongnu.org; Tue, 05 Mar 2019 10:35:12 -0500
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
Date: Tue,  5 Mar 2019 16:34:30 +0100
Message-Id: <1551800076-8104-9-git-send-email-aleksandar.markovic@rt-rk.com>
In-Reply-To: <1551800076-8104-1-git-send-email-aleksandar.markovic@rt-rk.com>
References: <1551800076-8104-1-git-send-email-aleksandar.markovic@rt-rk.com>
Subject: [Qemu-devel] [PATCH v8 08/14] tests/tcg: target/mips: Add wrappers
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
Reviewed-by: Aleksandar Rikalo <arikalo@wavecomp.com>
---
 tests/tcg/mips/include/wrappers_mips64r6.h | 83 ++++++++++++++++++++++++++++++
 1 file changed, 83 insertions(+)
 create mode 100644 tests/tcg/mips/include/wrappers_mips64r6.h

diff --git a/tests/tcg/mips/include/wrappers_mips64r6.h b/tests/tcg/mips/include/wrappers_mips64r6.h
new file mode 100644
index 0000000..d1e5edb
--- /dev/null
+++ b/tests/tcg/mips/include/wrappers_mips64r6.h
@@ -0,0 +1,83 @@
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
+static inline void do_mips64r6_##suffix(const void *input,             \
+                                        void *output)                  \
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
+DO_MIPS64R6__RD__RS(CLO, clo)
+DO_MIPS64R6__RD__RS(CLZ, clz)
+DO_MIPS64R6__RD__RS(DCLO, dclo)
+DO_MIPS64R6__RD__RS(DCLZ, dclz)
+
+DO_MIPS64R6__RD__RS(BITSWAP, bitswap)
+DO_MIPS64R6__RD__RS(DBITSWAP, dbitswap)
+
+
+#define DO_MIPS64R6__RD__RS_RT(suffix, mnemonic)                       \
+static inline void do_mips64r6_##suffix(const void *input1,            \
+                                        const void *input2,            \
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
+DO_MIPS64R6__RD__RS_RT(SLLV, sllv)
+DO_MIPS64R6__RD__RS_RT(SRLV, srlv)
+DO_MIPS64R6__RD__RS_RT(SRAV, srav)
+DO_MIPS64R6__RD__RS_RT(DSLLV, dsllv)
+DO_MIPS64R6__RD__RS_RT(DSRLV, dsrlv)
+DO_MIPS64R6__RD__RS_RT(DSRAV, dsrav)
+
+DO_MIPS64R6__RD__RS_RT(MUL, mul)
+DO_MIPS64R6__RD__RS_RT(MUH, muh)
+DO_MIPS64R6__RD__RS_RT(MULU, mulu)
+DO_MIPS64R6__RD__RS_RT(MUHU, muhu)
+DO_MIPS64R6__RD__RS_RT(DMUL, dmul)
+DO_MIPS64R6__RD__RS_RT(DMUH, dmuh)
+DO_MIPS64R6__RD__RS_RT(DMULU, dmulu)
+DO_MIPS64R6__RD__RS_RT(DMUHU, dmuhu)
+
+
+#endif
-- 
2.7.4
