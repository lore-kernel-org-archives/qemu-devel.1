Received: from eggs.gnu.org ([2001:4830:134:3::10]:47369)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mrolnik@gmail.com>) id 1dJ2Vn-0005yM-Gg
	for qemu-devel@nongnu.org; Thu, 08 Jun 2017 14:50:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mrolnik@gmail.com>) id 1dJ2Vl-0001Ry-Op
	for qemu-devel@nongnu.org; Thu, 08 Jun 2017 14:50:27 -0400
Received: from mail-wm0-x243.google.com ([2a00:1450:400c:c09::243]:34134)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mrolnik@gmail.com>) id 1dJ2Vl-0001Rh-BO
	for qemu-devel@nongnu.org; Thu, 08 Jun 2017 14:50:25 -0400
Received: by mail-wm0-x243.google.com with SMTP id 70so8662173wme.1
	for <qemu-devel@nongnu.org>; Thu, 08 Jun 2017 11:50:25 -0700 (PDT)
From: Michael Rolnik <mrolnik@gmail.com>
Date: Thu,  8 Jun 2017 21:49:44 +0300
Message-Id: <20170608184944.19406-10-mrolnik@gmail.com>
In-Reply-To: <20170608184944.19406-1-mrolnik@gmail.com>
References: <20170608184944.19406-1-mrolnik@gmail.com>
Subject: [Qemu-devel] [PATCH RFC v19 09/13] target-avr: adding instruction
 decoder
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: anichang@protonmail.ch, Michael Rolnik <mrolnik@gmail.com>, Richard Henderson <rth@twiddle.net>

Signed-off-by: Michael Rolnik <mrolnik@gmail.com>
Message-Id: <1471522070-77598-10-git-send-email-mrolnik@gmail.com>
Signed-off-by: Richard Henderson <rth@twiddle.net>
---
 target/avr/Makefile.objs |   1 +
 target/avr/decode.c      | 691 +++++++++++++++++++++++++++++++++++++++++++++++
 target/avr/translate.c   |   2 +
 3 files changed, 694 insertions(+)
 create mode 100644 target/avr/decode.c

diff --git a/target/avr/Makefile.objs b/target/avr/Makefile.objs
index a448792ff3..9848b1cb4c 100644
--- a/target/avr/Makefile.objs
+++ b/target/avr/Makefile.objs
@@ -21,4 +21,5 @@
 obj-y += translate.o cpu.o helper.o
 obj-y += gdbstub.o
 obj-y += translate-inst.o
+obj-y += decode.o
 obj-$(CONFIG_SOFTMMU) += machine.o
diff --git a/target/avr/decode.c b/target/avr/decode.c
new file mode 100644
index 0000000000..2d2e54e448
--- /dev/null
+++ b/target/avr/decode.c
@@ -0,0 +1,691 @@
+/*
+ * QEMU AVR CPU
+ *
+ * Copyright (c) 2016 Michael Rolnik
+ *
+ * This library is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU Lesser General Public
+ * License as published by the Free Software Foundation; either
+ * version 2.1 of the License, or (at your option) any later version.
+ *
+ * This library is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * Lesser General Public License for more details.
+ *
+ * You should have received a copy of the GNU Lesser General Public
+ * License along with this library; if not, see
+ * <http://www.gnu.org/licenses/lgpl-2.1.html>
+ */
+
+#include <stdint.h>
+#include "translate.h"
+
+void avr_decode(uint32_t pc, uint32_t *l, uint32_t c, translate_function_t *t)
+{
+    uint32_t opc = extract32(c, 0, 16);
+    switch (opc & 0x0000d000) {
+        case 0x00000000: {
+            switch (opc & 0x00002c00) {
+                case 0x00000000: {
+                    switch (opc & 0x00000300) {
+                        case 0x00000000: {
+                            *l = 16;
+                            *t = &avr_translate_NOP;
+                            break;
+                        }
+                        case 0x00000100: {
+                            *l = 16;
+                            *t = &avr_translate_MOVW;
+                            break;
+                        }
+                        case 0x00000200: {
+                            *l = 16;
+                            *t = &avr_translate_MULS;
+                            break;
+                        }
+                        case 0x00000300: {
+                            switch (opc & 0x00000088) {
+                                case 0x00000000: {
+                                    *l = 16;
+                                    *t = &avr_translate_MULSU;
+                                    break;
+                                }
+                                case 0x00000008: {
+                                    *l = 16;
+                                    *t = &avr_translate_FMUL;
+                                    break;
+                                }
+                                case 0x00000080: {
+                                    *l = 16;
+                                    *t = &avr_translate_FMULS;
+                                    break;
+                                }
+                                case 0x00000088: {
+                                    *l = 16;
+                                    *t = &avr_translate_FMULSU;
+                                    break;
+                                }
+                            }
+                            break;
+                        }
+                    }
+                    break;
+                }
+                case 0x00000400: {
+                    *l = 16;
+                    *t = &avr_translate_CPC;
+                    break;
+                }
+                case 0x00000800: {
+                    *l = 16;
+                    *t = &avr_translate_SBC;
+                    break;
+                }
+                case 0x00000c00: {
+                    *l = 16;
+                    *t = &avr_translate_ADD;
+                    break;
+                }
+                case 0x00002000: {
+                    *l = 16;
+                    *t = &avr_translate_AND;
+                    break;
+                }
+                case 0x00002400: {
+                    *l = 16;
+                    *t = &avr_translate_EOR;
+                    break;
+                }
+                case 0x00002800: {
+                    *l = 16;
+                    *t = &avr_translate_OR;
+                    break;
+                }
+                case 0x00002c00: {
+                    *l = 16;
+                    *t = &avr_translate_MOV;
+                    break;
+                }
+            }
+            break;
+        }
+        case 0x00001000: {
+            switch (opc & 0x00002000) {
+                case 0x00000000: {
+                    switch (opc & 0x00000c00) {
+                        case 0x00000000: {
+                            *l = 16;
+                            *t = &avr_translate_CPSE;
+                            break;
+                        }
+                        case 0x00000400: {
+                            *l = 16;
+                            *t = &avr_translate_CP;
+                            break;
+                        }
+                        case 0x00000800: {
+                            *l = 16;
+                            *t = &avr_translate_SUB;
+                            break;
+                        }
+                        case 0x00000c00: {
+                            *l = 16;
+                            *t = &avr_translate_ADC;
+                            break;
+                        }
+                    }
+                    break;
+                }
+                case 0x00002000: {
+                    *l = 16;
+                    *t = &avr_translate_CPI;
+                    break;
+                }
+            }
+            break;
+        }
+        case 0x00004000: {
+            switch (opc & 0x00002000) {
+                case 0x00000000: {
+                    *l = 16;
+                    *t = &avr_translate_SBCI;
+                    break;
+                }
+                case 0x00002000: {
+                    *l = 16;
+                    *t = &avr_translate_ORI;
+                    break;
+                }
+            }
+            break;
+        }
+        case 0x00005000: {
+            switch (opc & 0x00002000) {
+                case 0x00000000: {
+                    *l = 16;
+                    *t = &avr_translate_SUBI;
+                    break;
+                }
+                case 0x00002000: {
+                    *l = 16;
+                    *t = &avr_translate_ANDI;
+                    break;
+                }
+            }
+            break;
+        }
+        case 0x00008000: {
+            switch (opc & 0x00000208) {
+                case 0x00000000: {
+                    *l = 16;
+                    *t = &avr_translate_LDDZ;
+                    break;
+                }
+                case 0x00000008: {
+                    *l = 16;
+                    *t = &avr_translate_LDDY;
+                    break;
+                }
+                case 0x00000200: {
+                    *l = 16;
+                    *t = &avr_translate_STDZ;
+                    break;
+                }
+                case 0x00000208: {
+                    *l = 16;
+                    *t = &avr_translate_STDY;
+                    break;
+                }
+            }
+            break;
+        }
+        case 0x00009000: {
+            switch (opc & 0x00002800) {
+                case 0x00000000: {
+                    switch (opc & 0x00000600) {
+                        case 0x00000000: {
+                            switch (opc & 0x0000000f) {
+                                case 0x00000000: {
+                                    *l = 32;
+                                    *t = &avr_translate_LDS;
+                                    break;
+                                }
+                                case 0x00000001: {
+                                    *l = 16;
+                                    *t = &avr_translate_LDZ2;
+                                    break;
+                                }
+                                case 0x00000002: {
+                                    *l = 16;
+                                    *t = &avr_translate_LDZ3;
+                                    break;
+                                }
+                                case 0x00000003: {
+                                    break;
+                                }
+                                case 0x00000004: {
+                                    *l = 16;
+                                    *t = &avr_translate_LPM2;
+                                    break;
+                                }
+                                case 0x00000005: {
+                                    *l = 16;
+                                    *t = &avr_translate_LPMX;
+                                    break;
+                                }
+                                case 0x00000006: {
+                                    *l = 16;
+                                    *t = &avr_translate_ELPM2;
+                                    break;
+                                }
+                                case 0x00000007: {
+                                    *l = 16;
+                                    *t = &avr_translate_ELPMX;
+                                    break;
+                                }
+                                case 0x00000008: {
+                                    break;
+                                }
+                                case 0x00000009: {
+                                    *l = 16;
+                                    *t = &avr_translate_LDY2;
+                                    break;
+                                }
+                                case 0x0000000a: {
+                                    *l = 16;
+                                    *t = &avr_translate_LDY3;
+                                    break;
+                                }
+                                case 0x0000000b: {
+                                    break;
+                                }
+                                case 0x0000000c: {
+                                    *l = 16;
+                                    *t = &avr_translate_LDX1;
+                                    break;
+                                }
+                                case 0x0000000d: {
+                                    *l = 16;
+                                    *t = &avr_translate_LDX2;
+                                    break;
+                                }
+                                case 0x0000000e: {
+                                    *l = 16;
+                                    *t = &avr_translate_LDX3;
+                                    break;
+                                }
+                                case 0x0000000f: {
+                                    *l = 16;
+                                    *t = &avr_translate_POP;
+                                    break;
+                                }
+                            }
+                            break;
+                        }
+                        case 0x00000200: {
+                            switch (opc & 0x0000000f) {
+                                case 0x00000000: {
+                                    *l = 32;
+                                    *t = &avr_translate_STS;
+                                    break;
+                                }
+                                case 0x00000001: {
+                                    *l = 16;
+                                    *t = &avr_translate_STZ2;
+                                    break;
+                                }
+                                case 0x00000002: {
+                                    *l = 16;
+                                    *t = &avr_translate_STZ3;
+                                    break;
+                                }
+                                case 0x00000003: {
+                                    break;
+                                }
+                                case 0x00000004: {
+                                    *l = 16;
+                                    *t = &avr_translate_XCH;
+                                    break;
+                                }
+                                case 0x00000005: {
+                                    *l = 16;
+                                    *t = &avr_translate_LAS;
+                                    break;
+                                }
+                                case 0x00000006: {
+                                    *l = 16;
+                                    *t = &avr_translate_LAC;
+                                    break;
+                                }
+                                case 0x00000007: {
+                                    *l = 16;
+                                    *t = &avr_translate_LAT;
+                                    break;
+                                }
+                                case 0x00000008: {
+                                    break;
+                                }
+                                case 0x00000009: {
+                                    *l = 16;
+                                    *t = &avr_translate_STY2;
+                                    break;
+                                }
+                                case 0x0000000a: {
+                                    *l = 16;
+                                    *t = &avr_translate_STY3;
+                                    break;
+                                }
+                                case 0x0000000b: {
+                                    break;
+                                }
+                                case 0x0000000c: {
+                                    *l = 16;
+                                    *t = &avr_translate_STX1;
+                                    break;
+                                }
+                                case 0x0000000d: {
+                                    *l = 16;
+                                    *t = &avr_translate_STX2;
+                                    break;
+                                }
+                                case 0x0000000e: {
+                                    *l = 16;
+                                    *t = &avr_translate_STX3;
+                                    break;
+                                }
+                                case 0x0000000f: {
+                                    *l = 16;
+                                    *t = &avr_translate_PUSH;
+                                    break;
+                                }
+                            }
+                            break;
+                        }
+                        case 0x00000400: {
+                            switch (opc & 0x0000000e) {
+                                case 0x00000000: {
+                                    switch (opc & 0x00000001) {
+                                        case 0x00000000: {
+                                            *l = 16;
+                                            *t = &avr_translate_COM;
+                                            break;
+                                        }
+                                        case 0x00000001: {
+                                            *l = 16;
+                                            *t = &avr_translate_NEG;
+                                            break;
+                                        }
+                                    }
+                                    break;
+                                }
+                                case 0x00000002: {
+                                    switch (opc & 0x00000001) {
+                                        case 0x00000000: {
+                                            *l = 16;
+                                            *t = &avr_translate_SWAP;
+                                            break;
+                                        }
+                                        case 0x00000001: {
+                                            *l = 16;
+                                            *t = &avr_translate_INC;
+                                            break;
+                                        }
+                                    }
+                                    break;
+                                }
+                                case 0x00000004: {
+                                    *l = 16;
+                                    *t = &avr_translate_ASR;
+                                    break;
+                                }
+                                case 0x00000006: {
+                                    switch (opc & 0x00000001) {
+                                        case 0x00000000: {
+                                            *l = 16;
+                                            *t = &avr_translate_LSR;
+                                            break;
+                                        }
+                                        case 0x00000001: {
+                                            *l = 16;
+                                            *t = &avr_translate_ROR;
+                                            break;
+                                        }
+                                    }
+                                    break;
+                                }
+                                case 0x00000008: {
+                                    switch (opc & 0x00000181) {
+                                        case 0x00000000: {
+                                            *l = 16;
+                                            *t = &avr_translate_BSET;
+                                            break;
+                                        }
+                                        case 0x00000001: {
+                                            switch (opc & 0x00000010) {
+                                                case 0x00000000: {
+                                                    *l = 16;
+                                                    *t = &avr_translate_IJMP;
+                                                    break;
+                                                }
+                                                case 0x00000010: {
+                                                    *l = 16;
+                                                    *t = &avr_translate_EIJMP;
+                                                    break;
+                                                }
+                                            }
+                                            break;
+                                        }
+                                        case 0x00000080: {
+                                            *l = 16;
+                                            *t = &avr_translate_BCLR;
+                                            break;
+                                        }
+                                        case 0x00000081: {
+                                            break;
+                                        }
+                                        case 0x00000100: {
+                                            switch (opc & 0x00000010) {
+                                                case 0x00000000: {
+                                                    *l = 16;
+                                                    *t = &avr_translate_RET;
+                                                    break;
+                                                }
+                                                case 0x00000010: {
+                                                    *l = 16;
+                                                    *t = &avr_translate_RETI;
+                                                    break;
+                                                }
+                                            }
+                                            break;
+                                        }
+                                        case 0x00000101: {
+                                            switch (opc & 0x00000010) {
+                                                case 0x00000000: {
+                                                    *l = 16;
+                                                    *t = &avr_translate_ICALL;
+                                                    break;
+                                                }
+                                                case 0x00000010: {
+                                                    *l = 16;
+                                                    *t = &avr_translate_EICALL;
+                                                    break;
+                                                }
+                                            }
+                                            break;
+                                        }
+                                        case 0x00000180: {
+                                            switch (opc & 0x00000070) {
+                                                case 0x00000000: {
+                                                    *l = 16;
+                                                    *t = &avr_translate_SLEEP;
+                                                    break;
+                                                }
+                                                case 0x00000010: {
+                                                    *l = 16;
+                                                    *t = &avr_translate_BREAK;
+                                                    break;
+                                                }
+                                                case 0x00000020: {
+                                                    *l = 16;
+                                                    *t = &avr_translate_WDR;
+                                                    break;
+                                                }
+                                                case 0x00000030: {
+                                                    break;
+                                                }
+                                                case 0x00000040: {
+                                                    *l = 16;
+                                                    *t = &avr_translate_LPM1;
+                                                    break;
+                                                }
+                                                case 0x00000050: {
+                                                    *l = 16;
+                                                    *t = &avr_translate_ELPM1;
+                                                    break;
+                                                }
+                                                case 0x00000060: {
+                                                    *l = 16;
+                                                    *t = &avr_translate_SPM;
+                                                    break;
+                                                }
+                                                case 0x00000070: {
+                                                    *l = 16;
+                                                    *t = &avr_translate_SPMX;
+                                                    break;
+                                                }
+                                            }
+                                            break;
+                                        }
+                                        case 0x00000181: {
+                                            break;
+                                        }
+                                    }
+                                    break;
+                                }
+                                case 0x0000000a: {
+                                    switch (opc & 0x00000001) {
+                                        case 0x00000000: {
+                                            *l = 16;
+                                            *t = &avr_translate_DEC;
+                                            break;
+                                        }
+                                        case 0x00000001: {
+                                            *l = 16;
+                                            *t = &avr_translate_DES;
+                                            break;
+                                        }
+                                    }
+                                    break;
+                                }
+                                case 0x0000000c: {
+                                    *l = 32;
+                                    *t = &avr_translate_JMP;
+                                    break;
+                                }
+                                case 0x0000000e: {
+                                    *l = 32;
+                                    *t = &avr_translate_CALL;
+                                    break;
+                                }
+                            }
+                            break;
+                        }
+                        case 0x00000600: {
+                            switch (opc & 0x00000100) {
+                                case 0x00000000: {
+                                    *l = 16;
+                                    *t = &avr_translate_ADIW;
+                                    break;
+                                }
+                                case 0x00000100: {
+                                    *l = 16;
+                                    *t = &avr_translate_SBIW;
+                                    break;
+                                }
+                            }
+                            break;
+                        }
+                    }
+                    break;
+                }
+                case 0x00000800: {
+                    switch (opc & 0x00000400) {
+                        case 0x00000000: {
+                            switch (opc & 0x00000300) {
+                                case 0x00000000: {
+                                    *l = 16;
+                                    *t = &avr_translate_CBI;
+                                    break;
+                                }
+                                case 0x00000100: {
+                                    *l = 16;
+                                    *t = &avr_translate_SBIC;
+                                    break;
+                                }
+                                case 0x00000200: {
+                                    *l = 16;
+                                    *t = &avr_translate_SBI;
+                                    break;
+                                }
+                                case 0x00000300: {
+                                    *l = 16;
+                                    *t = &avr_translate_SBIS;
+                                    break;
+                                }
+                            }
+                            break;
+                        }
+                        case 0x00000400: {
+                            *l = 16;
+                            *t = &avr_translate_MUL;
+                            break;
+                        }
+                    }
+                    break;
+                }
+                case 0x00002000: {
+                    *l = 16;
+                    *t = &avr_translate_IN;
+                    break;
+                }
+                case 0x00002800: {
+                    *l = 16;
+                    *t = &avr_translate_OUT;
+                    break;
+                }
+            }
+            break;
+        }
+        case 0x0000c000: {
+            switch (opc & 0x00002000) {
+                case 0x00000000: {
+                    *l = 16;
+                    *t = &avr_translate_RJMP;
+                    break;
+                }
+                case 0x00002000: {
+                    *l = 16;
+                    *t = &avr_translate_LDI;
+                    break;
+                }
+            }
+            break;
+        }
+        case 0x0000d000: {
+            switch (opc & 0x00002000) {
+                case 0x00000000: {
+                    *l = 16;
+                    *t = &avr_translate_RCALL;
+                    break;
+                }
+                case 0x00002000: {
+                    switch (opc & 0x00000c00) {
+                        case 0x00000000: {
+                            *l = 16;
+                            *t = &avr_translate_BRBS;
+                            break;
+                        }
+                        case 0x00000400: {
+                            *l = 16;
+                            *t = &avr_translate_BRBC;
+                            break;
+                        }
+                        case 0x00000800: {
+                            switch (opc & 0x00000200) {
+                                case 0x00000000: {
+                                    *l = 16;
+                                    *t = &avr_translate_BLD;
+                                    break;
+                                }
+                                case 0x00000200: {
+                                    *l = 16;
+                                    *t = &avr_translate_BST;
+                                    break;
+                                }
+                            }
+                            break;
+                        }
+                        case 0x00000c00: {
+                            switch (opc & 0x00000200) {
+                                case 0x00000000: {
+                                    *l = 16;
+                                    *t = &avr_translate_SBRC;
+                                    break;
+                                }
+                                case 0x00000200: {
+                                    *l = 16;
+                                    *t = &avr_translate_SBRS;
+                                    break;
+                                }
+                            }
+                            break;
+                        }
+                    }
+                    break;
+                }
+            }
+            break;
+        }
+    }
+}
diff --git a/target/avr/translate.c b/target/avr/translate.c
index daf4a6afc7..d6f1f71ebc 100644
--- a/target/avr/translate.c
+++ b/target/avr/translate.c
@@ -90,6 +90,8 @@ static void decode_opc(AVRCPU *cpu, DisasContext *ctx, InstInfo *inst)
     inst->length = 16;
     inst->translate = NULL;
 
+    avr_decode(inst->cpc, &inst->length, inst->opcode, &inst->translate);
+
     if (inst->length == 16) {
         inst->npc = inst->cpc + 1;
         /* get opcode as 16bit value */
-- 
2.11.0 (Apple Git-81)
