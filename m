Received: from eggs.gnu.org ([209.51.188.92]:38276)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hLhRN-0006Px-SH
	for qemu-devel@nongnu.org; Wed, 01 May 2019 01:06:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hLhRK-0002qs-Qz
	for qemu-devel@nongnu.org; Wed, 01 May 2019 01:05:57 -0400
Received: from mail-pf1-x441.google.com ([2607:f8b0:4864:20::441]:34455)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hLhRK-0002qg-LO
	for qemu-devel@nongnu.org; Wed, 01 May 2019 01:05:54 -0400
Received: by mail-pf1-x441.google.com with SMTP id b3so8156766pfd.1
	for <qemu-devel@nongnu.org>; Tue, 30 Apr 2019 22:05:54 -0700 (PDT)
Received: from localhost.localdomain (97-113-189-189.tukw.qwest.net.
	[97.113.189.189]) by smtp.gmail.com with ESMTPSA id
	t127sm9687251pfb.106.2019.04.30.22.05.52 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Tue, 30 Apr 2019 22:05:52 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Tue, 30 Apr 2019 22:05:15 -0700
Message-Id: <20190501050536.15580-9-richard.henderson@linaro.org>
In-Reply-To: <20190501050536.15580-1-richard.henderson@linaro.org>
References: <20190501050536.15580-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH v2 08/29] tcg: Promote tcg_out_{dup,
 dupi}_vec to backend interface
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

The i386 backend already has these functions, and the aarch64
backend could easily split out one.  Nothing is done with these
functions yet, but this will aid register allocation of
INDEX_op_dup_vec in a later patch.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/aarch64/tcg-target.inc.c | 12 ++++++++++--
 tcg/i386/tcg-target.inc.c    |  3 ++-
 tcg/tcg.c                    | 14 ++++++++++++++
 3 files changed, 26 insertions(+), 3 deletions(-)

diff --git a/tcg/aarch64/tcg-target.inc.c b/tcg/aarch64/tcg-target.inc.c
index ee89734318..e443b5df23 100644
--- a/tcg/aarch64/tcg-target.inc.c
+++ b/tcg/aarch64/tcg-target.inc.c
@@ -799,7 +799,7 @@ static void tcg_out_logicali(TCGContext *s, AArch64Insn insn, TCGType ext,
 }
 
 static void tcg_out_dupi_vec(TCGContext *s, TCGType type,
-                             TCGReg rd, uint64_t v64)
+                             TCGReg rd, tcg_target_long v64)
 {
     int op, cmode, imm8;
 
@@ -814,6 +814,14 @@ static void tcg_out_dupi_vec(TCGContext *s, TCGType type,
     }
 }
 
+static bool tcg_out_dup_vec(TCGContext *s, TCGType type, unsigned vece,
+                            TCGReg rd, TCGReg rs)
+{
+    int is_q = type - TCG_TYPE_V64;
+    tcg_out_insn(s, 3605, DUP, is_q, rd, rs, 1 << vece, 0);
+    return true;
+}
+
 static void tcg_out_movi(TCGContext *s, TCGType type, TCGReg rd,
                          tcg_target_long value)
 {
@@ -2201,7 +2209,7 @@ static void tcg_out_vec_op(TCGContext *s, TCGOpcode opc,
         tcg_out_insn(s, 3617, NOT, is_q, 0, a0, a1);
         break;
     case INDEX_op_dup_vec:
-        tcg_out_insn(s, 3605, DUP, is_q, a0, a1, 1 << vece, 0);
+        tcg_out_dup_vec(s, type, vece, a0, a1);
         break;
     case INDEX_op_shli_vec:
         tcg_out_insn(s, 3614, SHL, is_q, a0, a1, a2 + (8 << vece));
diff --git a/tcg/i386/tcg-target.inc.c b/tcg/i386/tcg-target.inc.c
index 1198c76392..0d621670c7 100644
--- a/tcg/i386/tcg-target.inc.c
+++ b/tcg/i386/tcg-target.inc.c
@@ -855,7 +855,7 @@ static bool tcg_out_mov(TCGContext *s, TCGType type, TCGReg ret, TCGReg arg)
     return true;
 }
 
-static void tcg_out_dup_vec(TCGContext *s, TCGType type, unsigned vece,
+static bool tcg_out_dup_vec(TCGContext *s, TCGType type, unsigned vece,
                             TCGReg r, TCGReg a)
 {
     if (have_avx2) {
@@ -888,6 +888,7 @@ static void tcg_out_dup_vec(TCGContext *s, TCGType type, unsigned vece,
             g_assert_not_reached();
         }
     }
+    return true;
 }
 
 static void tcg_out_dupi_vec(TCGContext *s, TCGType type,
diff --git a/tcg/tcg.c b/tcg/tcg.c
index 68d86361e2..3ef4d3478d 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -109,10 +109,24 @@ static void tcg_out_movi(TCGContext *s, TCGType type,
 static void tcg_out_op(TCGContext *s, TCGOpcode opc, const TCGArg *args,
                        const int *const_args);
 #if TCG_TARGET_MAYBE_vec
+static bool tcg_out_dup_vec(TCGContext *s, TCGType type, unsigned vece,
+                            TCGReg dst, TCGReg src);
+static void tcg_out_dupi_vec(TCGContext *s, TCGType type,
+                             TCGReg dst, tcg_target_long arg);
 static void tcg_out_vec_op(TCGContext *s, TCGOpcode opc, unsigned vecl,
                            unsigned vece, const TCGArg *args,
                            const int *const_args);
 #else
+static inline bool tcg_out_dup_vec(TCGContext *s, TCGType type, unsigned vece,
+                                   TCGReg dst, TCGReg src)
+{
+    g_assert_not_reached();
+}
+static inline void tcg_out_dupi_vec(TCGContext *s, TCGType type,
+                                    TCGReg dst, tcg_target_long arg)
+{
+    g_assert_not_reached();
+}
 static inline void tcg_out_vec_op(TCGContext *s, TCGOpcode opc, unsigned vecl,
                                   unsigned vece, const TCGArg *args,
                                   const int *const_args)
-- 
2.17.1
