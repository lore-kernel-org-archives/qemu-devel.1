Received: from eggs.gnu.org ([2001:4830:134:3::10]:47926)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eRijI-0004bc-W2
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 13:04:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eRijC-0002h9-Q8
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 13:04:32 -0500
Received: from mx1.redhat.com ([209.132.183.28]:59106)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1eRijC-0002fU-7w
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 13:04:26 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 57421C047B65
	for <qemu-devel@nongnu.org>; Wed, 20 Dec 2017 18:04:25 +0000 (UTC)
Received: from donizetti.redhat.com (ovpn-116-46.ams2.redhat.com
	[10.36.116.46])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 58D0138181
	for <qemu-devel@nongnu.org>; Wed, 20 Dec 2017 18:04:24 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Wed, 20 Dec 2017 19:03:55 +0100
Message-Id: <20171220180358.29316-17-pbonzini@redhat.com>
In-Reply-To: <20171220180358.29316-1-pbonzini@redhat.com>
References: <20171220180358.29316-1-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 16/19] i386: hvf: simplify flag handling
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Remove much indirection and duplicate code, and provide a cleaner interface
out of x86_flags.c.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/hvf/x86_emu.c   |  93 +++++-------------
 target/i386/hvf/x86_flags.c | 235 +++++++++++++++++++++-----------------------
 target/i386/hvf/x86_flags.h | 173 ++------------------------------
 3 files changed, 144 insertions(+), 357 deletions(-)

diff --git a/target/i386/hvf/x86_emu.c b/target/i386/hvf/x86_emu.c
index 5ecabc4230..31b0807add 100644
--- a/target/i386/hvf/x86_emu.c
+++ b/target/i386/hvf/x86_emu.c
@@ -49,7 +49,7 @@
 void hvf_handle_io(struct CPUState *cpu, uint16_t port, void *data,
                    int direction, int size, uint32_t count);
 
-#define EXEC_2OP_LOGIC_CMD(env, decode, cmd, FLAGS_FUNC, save_res) \
+#define EXEC_2OP_FLAGS_CMD(env, decode, cmd, FLAGS_FUNC, save_res) \
 {                                                       \
     fetch_operands(env, decode, 2, true, true, false);  \
     switch (decode->operand_size) {                     \
@@ -61,7 +61,7 @@ void hvf_handle_io(struct CPUState *cpu, uint16_t port, void *data,
         if (save_res) {                              \
             write_val_ext(env, decode->op[0].ptr, diff, 1);  \
         } \
-        FLAGS_FUNC##_8(diff);                       \
+        FLAGS_FUNC##8(env, v1, v2, diff);           \
         break;                                      \
     }                                               \
     case 2:                                        \
@@ -72,7 +72,7 @@ void hvf_handle_io(struct CPUState *cpu, uint16_t port, void *data,
         if (save_res) {                              \
             write_val_ext(env, decode->op[0].ptr, diff, 2); \
         } \
-        FLAGS_FUNC##_16(diff);                      \
+        FLAGS_FUNC##16(env, v1, v2, diff);          \
         break;                                      \
     }                                               \
     case 4:                                        \
@@ -83,7 +83,7 @@ void hvf_handle_io(struct CPUState *cpu, uint16_t port, void *data,
         if (save_res) {                              \
             write_val_ext(env, decode->op[0].ptr, diff, 4); \
         } \
-        FLAGS_FUNC##_32(diff);                      \
+        FLAGS_FUNC##32(env, v1, v2, diff);          \
         break;                                      \
     }                                               \
     default:                                        \
@@ -91,49 +91,6 @@ void hvf_handle_io(struct CPUState *cpu, uint16_t port, void *data,
     }                                                   \
 }                                                       \
 
-
-#define EXEC_2OP_ARITH_CMD(env, decode, cmd, FLAGS_FUNC, save_res) \
-{                                                       \
-    fetch_operands(env, decode, 2, true, true, false);  \
-    switch (decode->operand_size) {                     \
-    case 1:                                         \
-    {                                               \
-        uint8_t v1 = (uint8_t)decode->op[0].val;    \
-        uint8_t v2 = (uint8_t)decode->op[1].val;    \
-        uint8_t diff = v1 cmd v2;                   \
-        if (save_res) {                              \
-            write_val_ext(env, decode->op[0].ptr, diff, 1);  \
-        } \
-        FLAGS_FUNC##_8(v1, v2, diff);               \
-        break;                                      \
-    }                                               \
-    case 2:                                        \
-    {                                               \
-        uint16_t v1 = (uint16_t)decode->op[0].val;  \
-        uint16_t v2 = (uint16_t)decode->op[1].val;  \
-        uint16_t diff = v1 cmd v2;                  \
-        if (save_res) {                              \
-            write_val_ext(env, decode->op[0].ptr, diff, 2); \
-        } \
-        FLAGS_FUNC##_16(v1, v2, diff);              \
-        break;                                      \
-    }                                               \
-    case 4:                                        \
-    {                                               \
-        uint32_t v1 = (uint32_t)decode->op[0].val;  \
-        uint32_t v2 = (uint32_t)decode->op[1].val;  \
-        uint32_t diff = v1 cmd v2;                  \
-        if (save_res) {                              \
-            write_val_ext(env, decode->op[0].ptr, diff, 4); \
-        } \
-        FLAGS_FUNC##_32(v1, v2, diff);              \
-        break;                                      \
-    }                                               \
-    default:                                        \
-        VM_PANIC("bad size\n");                    \
-    }                                                   \
-}
-
 addr_t read_reg(CPUX86State *env, int reg, int size)
 {
     switch (size) {
@@ -315,49 +272,49 @@ static void exec_mov(struct CPUX86State *env, struct x86_decode *decode)
 
 static void exec_add(struct CPUX86State *env, struct x86_decode *decode)
 {
-    EXEC_2OP_ARITH_CMD(env, decode, +, SET_FLAGS_OSZAPC_ADD, true);
+    EXEC_2OP_FLAGS_CMD(env, decode, +, SET_FLAGS_OSZAPC_ADD, true);
     RIP(env) += decode->len;
 }
 
 static void exec_or(struct CPUX86State *env, struct x86_decode *decode)
 {
-    EXEC_2OP_LOGIC_CMD(env, decode, |, SET_FLAGS_OSZAPC_LOGIC, true);
+    EXEC_2OP_FLAGS_CMD(env, decode, |, SET_FLAGS_OSZAPC_LOGIC, true);
     RIP(env) += decode->len;
 }
 
 static void exec_adc(struct CPUX86State *env, struct x86_decode *decode)
 {
-    EXEC_2OP_ARITH_CMD(env, decode, +get_CF(env)+, SET_FLAGS_OSZAPC_ADD, true);
+    EXEC_2OP_FLAGS_CMD(env, decode, +get_CF(env)+, SET_FLAGS_OSZAPC_ADD, true);
     RIP(env) += decode->len;
 }
 
 static void exec_sbb(struct CPUX86State *env, struct x86_decode *decode)
 {
-    EXEC_2OP_ARITH_CMD(env, decode, -get_CF(env)-, SET_FLAGS_OSZAPC_SUB, true);
+    EXEC_2OP_FLAGS_CMD(env, decode, -get_CF(env)-, SET_FLAGS_OSZAPC_SUB, true);
     RIP(env) += decode->len;
 }
 
 static void exec_and(struct CPUX86State *env, struct x86_decode *decode)
 {
-    EXEC_2OP_LOGIC_CMD(env, decode, &, SET_FLAGS_OSZAPC_LOGIC, true);
+    EXEC_2OP_FLAGS_CMD(env, decode, &, SET_FLAGS_OSZAPC_LOGIC, true);
     RIP(env) += decode->len;
 }
 
 static void exec_sub(struct CPUX86State *env, struct x86_decode *decode)
 {
-    EXEC_2OP_ARITH_CMD(env, decode, -, SET_FLAGS_OSZAPC_SUB, true);
+    EXEC_2OP_FLAGS_CMD(env, decode, -, SET_FLAGS_OSZAPC_SUB, true);
     RIP(env) += decode->len;
 }
 
 static void exec_xor(struct CPUX86State *env, struct x86_decode *decode)
 {
-    EXEC_2OP_LOGIC_CMD(env, decode, ^, SET_FLAGS_OSZAPC_LOGIC, true);
+    EXEC_2OP_FLAGS_CMD(env, decode, ^, SET_FLAGS_OSZAPC_LOGIC, true);
     RIP(env) += decode->len;
 }
 
 static void exec_neg(struct CPUX86State *env, struct x86_decode *decode)
 {
-    /*EXEC_2OP_ARITH_CMD(env, decode, -, SET_FLAGS_OSZAPC_SUB, false);*/
+    /*EXEC_2OP_FLAGS_CMD(env, decode, -, SET_FLAGS_OSZAPC_SUB, false);*/
     int32_t val;
     fetch_operands(env, decode, 2, true, true, false);
 
@@ -365,11 +322,11 @@ static void exec_neg(struct CPUX86State *env, struct x86_decode *decode)
     write_val_ext(env, decode->op[1].ptr, val, decode->operand_size);
 
     if (4 == decode->operand_size) {
-        SET_FLAGS_OSZAPC_SUB_32(0, 0 - val, val);
+        SET_FLAGS_OSZAPC_SUB32(env, 0, 0 - val, val);
     } else if (2 == decode->operand_size) {
-        SET_FLAGS_OSZAPC_SUB_16(0, 0 - val, val);
+        SET_FLAGS_OSZAPC_SUB16(env, 0, 0 - val, val);
     } else if (1 == decode->operand_size) {
-        SET_FLAGS_OSZAPC_SUB_8(0, 0 - val, val);
+        SET_FLAGS_OSZAPC_SUB8(env, 0, 0 - val, val);
     } else {
         VM_PANIC("bad op size\n");
     }
@@ -380,7 +337,7 @@ static void exec_neg(struct CPUX86State *env, struct x86_decode *decode)
 
 static void exec_cmp(struct CPUX86State *env, struct x86_decode *decode)
 {
-    EXEC_2OP_ARITH_CMD(env, decode, -, SET_FLAGS_OSZAPC_SUB, false);
+    EXEC_2OP_FLAGS_CMD(env, decode, -, SET_FLAGS_OSZAPC_SUB, false);
     RIP(env) += decode->len;
 }
 
@@ -389,7 +346,7 @@ static void exec_inc(struct CPUX86State *env, struct x86_decode *decode)
     decode->op[1].type = X86_VAR_IMMEDIATE;
     decode->op[1].val = 0;
 
-    EXEC_2OP_ARITH_CMD(env, decode, +1+, SET_FLAGS_OSZAP_ADD, true);
+    EXEC_2OP_FLAGS_CMD(env, decode, +1+, SET_FLAGS_OSZAP_ADD, true);
 
     RIP(env) += decode->len;
 }
@@ -399,13 +356,13 @@ static void exec_dec(struct CPUX86State *env, struct x86_decode *decode)
     decode->op[1].type = X86_VAR_IMMEDIATE;
     decode->op[1].val = 0;
 
-    EXEC_2OP_ARITH_CMD(env, decode, -1-, SET_FLAGS_OSZAP_SUB, true);
+    EXEC_2OP_FLAGS_CMD(env, decode, -1-, SET_FLAGS_OSZAP_SUB, true);
     RIP(env) += decode->len;
 }
 
 static void exec_tst(struct CPUX86State *env, struct x86_decode *decode)
 {
-    EXEC_2OP_LOGIC_CMD(env, decode, &, SET_FLAGS_OSZAPC_LOGIC, false);
+    EXEC_2OP_FLAGS_CMD(env, decode, &, SET_FLAGS_OSZAPC_LOGIC, false);
     RIP(env) += decode->len;
 }
 
@@ -612,7 +569,7 @@ static void exec_cmps_single(struct CPUX86State *env, struct x86_decode *decode)
     decode->op[1].type = X86_VAR_IMMEDIATE;
     decode->op[1].val = read_val_ext(env, dst_addr, decode->operand_size);
 
-    EXEC_2OP_ARITH_CMD(env, decode, -, SET_FLAGS_OSZAPC_SUB, false);
+    EXEC_2OP_FLAGS_CMD(env, decode, -, SET_FLAGS_OSZAPC_SUB, false);
 
     string_increment_reg(env, R_ESI, decode);
     string_increment_reg(env, R_EDI, decode);
@@ -661,7 +618,7 @@ static void exec_scas_single(struct CPUX86State *env, struct x86_decode *decode)
     decode->op[1].type = X86_VAR_IMMEDIATE;
     vmx_read_mem(ENV_GET_CPU(env), &decode->op[1].val, addr, decode->operand_size);
 
-    EXEC_2OP_ARITH_CMD(env, decode, -, SET_FLAGS_OSZAPC_SUB, false);
+    EXEC_2OP_FLAGS_CMD(env, decode, -, SET_FLAGS_OSZAPC_SUB, false);
     string_increment_reg(env, R_EDI, decode);
 }
 
@@ -996,7 +953,7 @@ void exec_shl(struct CPUX86State *env, struct x86_decode *decode)
         }
 
         write_val_ext(env, decode->op[0].ptr, res, 1);
-        SET_FLAGS_OSZAPC_LOGIC_8(res);
+        SET_FLAGS_OSZAPC_LOGIC8(env, 0, 0, res);
         SET_FLAGS_OxxxxC(env, of, cf);
         break;
     }
@@ -1012,7 +969,7 @@ void exec_shl(struct CPUX86State *env, struct x86_decode *decode)
         }
 
         write_val_ext(env, decode->op[0].ptr, res, 2);
-        SET_FLAGS_OSZAPC_LOGIC_16(res);
+        SET_FLAGS_OSZAPC_LOGIC16(env, 0, 0, res);
         SET_FLAGS_OxxxxC(env, of, cf);
         break;
     }
@@ -1021,7 +978,7 @@ void exec_shl(struct CPUX86State *env, struct x86_decode *decode)
         uint32_t res = decode->op[0].val << count;
 
         write_val_ext(env, decode->op[0].ptr, res, 4);
-        SET_FLAGS_OSZAPC_LOGIC_32(res);
+        SET_FLAGS_OSZAPC_LOGIC32(env, 0, 0, res);
         cf = (decode->op[0].val >> (32 - count)) & 0x1;
         of = cf ^ (res >> 31); /* of = cf ^ result31 */
         SET_FLAGS_OxxxxC(env, of, cf);
@@ -1393,7 +1350,7 @@ static void exec_xchg(struct CPUX86State *env, struct x86_decode *decode)
 
 static void exec_xadd(struct CPUX86State *env, struct x86_decode *decode)
 {
-    EXEC_2OP_ARITH_CMD(env, decode, +, SET_FLAGS_OSZAPC_ADD, true);
+    EXEC_2OP_FLAGS_CMD(env, decode, +, SET_FLAGS_OSZAPC_ADD, true);
     write_val_ext(env, decode->op[1].ptr, decode->op[0].val,
                   decode->operand_size);
 
diff --git a/target/i386/hvf/x86_flags.c b/target/i386/hvf/x86_flags.c
index ea25a3b26f..b0686c7962 100644
--- a/target/i386/hvf/x86_flags.c
+++ b/target/i386/hvf/x86_flags.c
@@ -28,6 +28,91 @@
 #include "x86_flags.h"
 #include "x86.h"
 
+
+/* this is basically bocsh code */
+
+#define LF_SIGN_BIT     31
+
+#define LF_BIT_SD      (0)          /* lazy Sign Flag Delta            */
+#define LF_BIT_AF      (3)          /* lazy Adjust flag                */
+#define LF_BIT_PDB     (8)          /* lazy Parity Delta Byte (8 bits) */
+#define LF_BIT_CF      (31)         /* lazy Carry Flag                 */
+#define LF_BIT_PO      (30)         /* lazy Partial Overflow = CF ^ OF */
+
+#define LF_MASK_SD     (0x01 << LF_BIT_SD)
+#define LF_MASK_AF     (0x01 << LF_BIT_AF)
+#define LF_MASK_PDB    (0xFF << LF_BIT_PDB)
+#define LF_MASK_CF     (0x01 << LF_BIT_CF)
+#define LF_MASK_PO     (0x01 << LF_BIT_PO)
+
+#define ADD_COUT_VEC(op1, op2, result) \
+   (((op1) & (op2)) | (((op1) | (op2)) & (~(result))))
+
+#define SUB_COUT_VEC(op1, op2, result) \
+   (((~(op1)) & (op2)) | (((~(op1)) ^ (op2)) & (result)))
+
+#define GET_ADD_OVERFLOW(op1, op2, result, mask) \
+   ((((op1) ^ (result)) & ((op2) ^ (result))) & (mask))
+
+/* ******************* */
+/* OSZAPC */
+/* ******************* */
+
+/* size, carries, result */
+#define SET_FLAGS_OSZAPC_SIZE(size, lf_carries, lf_result) { \
+    addr_t temp = ((lf_carries) & (LF_MASK_AF)) | \
+    (((lf_carries) >> (size - 2)) << LF_BIT_PO); \
+    env->hvf_emul->lflags.result = (addr_t)(int##size##_t)(lf_result); \
+    if ((size) == 32) { \
+        temp = ((lf_carries) & ~(LF_MASK_PDB | LF_MASK_SD)); \
+    } else if ((size) == 16) { \
+        temp = ((lf_carries) & (LF_MASK_AF)) | ((lf_carries) << 16); \
+    } else if ((size) == 8)  { \
+        temp = ((lf_carries) & (LF_MASK_AF)) | ((lf_carries) << 24); \
+    } else { \
+        VM_PANIC("unimplemented");  \
+    } \
+    env->hvf_emul->lflags.auxbits = (addr_t)(uint32_t)temp; \
+}
+
+/* carries, result */
+#define SET_FLAGS_OSZAPC_8(carries, result) \
+    SET_FLAGS_OSZAPC_SIZE(8, carries, result)
+#define SET_FLAGS_OSZAPC_16(carries, result) \
+    SET_FLAGS_OSZAPC_SIZE(16, carries, result)
+#define SET_FLAGS_OSZAPC_32(carries, result) \
+    SET_FLAGS_OSZAPC_SIZE(32, carries, result)
+
+/* ******************* */
+/* OSZAP */
+/* ******************* */
+/* size, carries, result */
+#define SET_FLAGS_OSZAP_SIZE(size, lf_carries, lf_result) { \
+    addr_t temp = ((lf_carries) & (LF_MASK_AF)) | \
+    (((lf_carries) >> (size - 2)) << LF_BIT_PO); \
+    if ((size) == 32) { \
+        temp = ((lf_carries) & ~(LF_MASK_PDB | LF_MASK_SD)); \
+    } else if ((size) == 16) { \
+        temp = ((lf_carries) & (LF_MASK_AF)) | ((lf_carries) << 16); \
+    } else if ((size) == 8) { \
+        temp = ((lf_carries) & (LF_MASK_AF)) | ((lf_carries) << 24); \
+    } else { \
+        VM_PANIC("unimplemented");      \
+    } \
+    env->hvf_emul->lflags.result = (addr_t)(int##size##_t)(lf_result); \
+    addr_t delta_c = (env->hvf_emul->lflags.auxbits ^ temp) & LF_MASK_CF; \
+    delta_c ^= (delta_c >> 1); \
+    env->hvf_emul->lflags.auxbits = (addr_t)(uint32_t)(temp ^ delta_c); \
+}
+
+/* carries, result */
+#define SET_FLAGS_OSZAP_8(carries, result) \
+    SET_FLAGS_OSZAP_SIZE(8, carries, result)
+#define SET_FLAGS_OSZAP_16(carries, result) \
+    SET_FLAGS_OSZAP_SIZE(16, carries, result)
+#define SET_FLAGS_OSZAP_32(carries, result) \
+    SET_FLAGS_OSZAP_SIZE(32, carries, result)
+
 void SET_FLAGS_OxxxxC(CPUX86State *env, uint32_t new_of, uint32_t new_cf)
 {
     uint32_t temp_po = new_of ^ new_cf;
@@ -39,178 +124,92 @@ void SET_FLAGS_OxxxxC(CPUX86State *env, uint32_t new_of, uint32_t new_cf)
 void SET_FLAGS_OSZAPC_SUB32(CPUX86State *env, uint32_t v1, uint32_t v2,
                             uint32_t diff)
 {
-    SET_FLAGS_OSZAPC_SUB_32(v1, v2, diff);
+    SET_FLAGS_OSZAPC_32(SUB_COUT_VEC(v1, v2, diff), diff);
 }
 
 void SET_FLAGS_OSZAPC_SUB16(CPUX86State *env, uint16_t v1, uint16_t v2,
                             uint16_t diff)
 {
-    SET_FLAGS_OSZAPC_SUB_16(v1, v2, diff);
+    SET_FLAGS_OSZAPC_16(SUB_COUT_VEC(v1, v2, diff), diff);
 }
 
 void SET_FLAGS_OSZAPC_SUB8(CPUX86State *env, uint8_t v1, uint8_t v2,
                             uint8_t diff)
 {
-    SET_FLAGS_OSZAPC_SUB_8(v1, v2, diff);
+    SET_FLAGS_OSZAPC_8(SUB_COUT_VEC(v1, v2, diff), diff);
 }
 
 void SET_FLAGS_OSZAPC_ADD32(CPUX86State *env, uint32_t v1, uint32_t v2,
                             uint32_t diff)
 {
-    SET_FLAGS_OSZAPC_ADD_32(v1, v2, diff);
+    SET_FLAGS_OSZAPC_32(ADD_COUT_VEC(v1, v2, diff), diff);
 }
 
 void SET_FLAGS_OSZAPC_ADD16(CPUX86State *env, uint16_t v1, uint16_t v2,
                             uint16_t diff)
 {
-    SET_FLAGS_OSZAPC_ADD_16(v1, v2, diff);
+    SET_FLAGS_OSZAPC_16(ADD_COUT_VEC(v1, v2, diff), diff);
 }
 
 void SET_FLAGS_OSZAPC_ADD8(CPUX86State *env, uint8_t v1, uint8_t v2,
                             uint8_t diff)
 {
-    SET_FLAGS_OSZAPC_ADD_8(v1, v2, diff);
+    SET_FLAGS_OSZAPC_8(ADD_COUT_VEC(v1, v2, diff), diff);
 }
 
 void SET_FLAGS_OSZAP_SUB32(CPUX86State *env, uint32_t v1, uint32_t v2,
                             uint32_t diff)
 {
-    SET_FLAGS_OSZAP_SUB_32(v1, v2, diff);
+    SET_FLAGS_OSZAP_32(SUB_COUT_VEC(v1, v2, diff), diff);
 }
 
 void SET_FLAGS_OSZAP_SUB16(CPUX86State *env, uint16_t v1, uint16_t v2,
                             uint16_t diff)
 {
-    SET_FLAGS_OSZAP_SUB_16(v1, v2, diff);
+    SET_FLAGS_OSZAP_16(SUB_COUT_VEC(v1, v2, diff), diff);
 }
 
 void SET_FLAGS_OSZAP_SUB8(CPUX86State *env, uint8_t v1, uint8_t v2,
                             uint8_t diff)
 {
-    SET_FLAGS_OSZAP_SUB_8(v1, v2, diff);
+    SET_FLAGS_OSZAP_8(SUB_COUT_VEC(v1, v2, diff), diff);
 }
 
 void SET_FLAGS_OSZAP_ADD32(CPUX86State *env, uint32_t v1, uint32_t v2,
                             uint32_t diff)
 {
-    SET_FLAGS_OSZAP_ADD_32(v1, v2, diff);
+    SET_FLAGS_OSZAP_32(ADD_COUT_VEC(v1, v2, diff), diff);
 }
 
 void SET_FLAGS_OSZAP_ADD16(CPUX86State *env, uint16_t v1, uint16_t v2,
                             uint16_t diff)
 {
-    SET_FLAGS_OSZAP_ADD_16(v1, v2, diff);
+    SET_FLAGS_OSZAP_16(ADD_COUT_VEC(v1, v2, diff), diff);
 }
 
 void SET_FLAGS_OSZAP_ADD8(CPUX86State *env, uint8_t v1, uint8_t v2,
                             uint8_t diff)
 {
-    SET_FLAGS_OSZAP_ADD_8(v1, v2, diff);
-}
-
-
-void SET_FLAGS_OSZAPC_LOGIC32(CPUX86State *env, uint32_t diff)
-{
-    SET_FLAGS_OSZAPC_LOGIC_32(diff);
-}
-
-void SET_FLAGS_OSZAPC_LOGIC16(CPUX86State *env, uint16_t diff)
-{
-    SET_FLAGS_OSZAPC_LOGIC_16(diff);
-}
-
-void SET_FLAGS_OSZAPC_LOGIC8(CPUX86State *env, uint8_t diff)
-{
-    SET_FLAGS_OSZAPC_LOGIC_8(diff);
-}
-
-void SET_FLAGS_SHR32(CPUX86State *env, uint32_t v, int count, uint32_t res)
-{
-    int cf = (v >> (count - 1)) & 0x1;
-    int of = (((res << 1) ^ res) >> 31);
-
-    SET_FLAGS_OSZAPC_LOGIC_32(res);
-    SET_FLAGS_OxxxxC(env, of, cf);
-}
-
-void SET_FLAGS_SHR16(CPUX86State *env, uint16_t v, int count, uint16_t res)
-{
-    int cf = (v >> (count - 1)) & 0x1;
-    int of = (((res << 1) ^ res) >> 15);
-
-    SET_FLAGS_OSZAPC_LOGIC_16(res);
-    SET_FLAGS_OxxxxC(env, of, cf);
-}
-
-void SET_FLAGS_SHR8(CPUX86State *env, uint8_t v, int count, uint8_t res)
-{
-    int cf = (v >> (count - 1)) & 0x1;
-    int of = (((res << 1) ^ res) >> 7);
-
-    SET_FLAGS_OSZAPC_LOGIC_8(res);
-    SET_FLAGS_OxxxxC(env, of, cf);
-}
-
-void SET_FLAGS_SAR32(CPUX86State *env, int32_t v, int count, uint32_t res)
-{
-    int cf = (v >> (count - 1)) & 0x1;
-
-    SET_FLAGS_OSZAPC_LOGIC_32(res);
-    SET_FLAGS_OxxxxC(env, 0, cf);
+    SET_FLAGS_OSZAP_8(ADD_COUT_VEC(v1, v2, diff), diff);
 }
 
-void SET_FLAGS_SAR16(CPUX86State *env, int16_t v, int count, uint16_t res)
-{
-    int cf = (v >> (count - 1)) & 0x1;
-
-    SET_FLAGS_OSZAPC_LOGIC_16(res);
-    SET_FLAGS_OxxxxC(env, 0, cf);
-}
 
-void SET_FLAGS_SAR8(CPUX86State *env, int8_t v, int count, uint8_t res)
+void SET_FLAGS_OSZAPC_LOGIC32(CPUX86State *env, uint32_t v1, uint32_t v2,
+                              uint32_t diff)
 {
-    int cf = (v >> (count - 1)) & 0x1;
-
-    SET_FLAGS_OSZAPC_LOGIC_8(res);
-    SET_FLAGS_OxxxxC(env, 0, cf);
+    SET_FLAGS_OSZAPC_32(0, diff);
 }
 
-
-void SET_FLAGS_SHL32(CPUX86State *env, uint32_t v, int count, uint32_t res)
+void SET_FLAGS_OSZAPC_LOGIC16(CPUX86State *env, uint16_t v1, uint16_t v2,
+                              uint16_t diff)
 {
-    int of, cf;
-
-    cf = (v >> (32 - count)) & 0x1;
-    of = cf ^ (res >> 31);
-
-    SET_FLAGS_OSZAPC_LOGIC_32(res);
-    SET_FLAGS_OxxxxC(env, of, cf);
+    SET_FLAGS_OSZAPC_16(0, diff);
 }
 
-void SET_FLAGS_SHL16(CPUX86State *env, uint16_t v, int count, uint16_t res)
+void SET_FLAGS_OSZAPC_LOGIC8(CPUX86State *env, uint8_t v1, uint8_t v2,
+                             uint8_t diff)
 {
-    int of = 0, cf = 0;
-
-    if (count <= 16) {
-        cf = (v >> (16 - count)) & 0x1;
-        of = cf ^ (res >> 15);
-    }
-
-    SET_FLAGS_OSZAPC_LOGIC_16(res);
-    SET_FLAGS_OxxxxC(env, of, cf);
-}
-
-void SET_FLAGS_SHL8(CPUX86State *env, uint8_t v, int count, uint8_t res)
-{
-    int of = 0, cf = 0;
-
-    if (count <= 8) {
-        cf = (v >> (8 - count)) & 0x1;
-        of = cf ^ (res >> 7);
-    }
-
-    SET_FLAGS_OSZAPC_LOGIC_8(res);
-    SET_FLAGS_OxxxxC(env, of, cf);
+    SET_FLAGS_OSZAPC_8(0, diff);
 }
 
 bool get_PF(CPUX86State *env)
@@ -228,34 +227,26 @@ void set_PF(CPUX86State *env, bool val)
     env->hvf_emul->lflags.auxbits |= (temp << LF_BIT_PDB);
 }
 
-bool _get_OF(CPUX86State *env)
-{
-    return ((env->hvf_emul->lflags.auxbits + (1U << LF_BIT_PO)) >> LF_BIT_CF) & 1;
-}
-
 bool get_OF(CPUX86State *env)
 {
-    return _get_OF(env);
-}
-
-bool _get_CF(CPUX86State *env)
-{
-    return (env->hvf_emul->lflags.auxbits >> LF_BIT_CF) & 1;
+    return ((env->hvf_emul->lflags.auxbits + (1U << LF_BIT_PO)) >> LF_BIT_CF) & 1;
 }
 
 bool get_CF(CPUX86State *env)
 {
-    return _get_CF(env);
+    return (env->hvf_emul->lflags.auxbits >> LF_BIT_CF) & 1;
 }
 
 void set_OF(CPUX86State *env, bool val)
 {
-    SET_FLAGS_OxxxxC(env, val, _get_CF(env));
+    bool old_cf = get_CF(env);
+    SET_FLAGS_OxxxxC(env, val, old_cf);
 }
 
 void set_CF(CPUX86State *env, bool val)
 {
-    SET_FLAGS_OxxxxC(env, _get_OF(env), (val));
+    bool old_of = get_OF(env);
+    SET_FLAGS_OxxxxC(env, old_of, val);
 }
 
 bool get_AF(CPUX86State *env)
@@ -266,7 +257,7 @@ bool get_AF(CPUX86State *env)
 void set_AF(CPUX86State *env, bool val)
 {
     env->hvf_emul->lflags.auxbits &= ~(LF_MASK_AF);
-    env->hvf_emul->lflags.auxbits |= (val) << LF_BIT_AF;
+    env->hvf_emul->lflags.auxbits |= val << LF_BIT_AF;
 }
 
 bool get_ZF(CPUX86State *env)
diff --git a/target/i386/hvf/x86_flags.h b/target/i386/hvf/x86_flags.h
index 3e487535ea..13e5d5bd1a 100644
--- a/target/i386/hvf/x86_flags.h
+++ b/target/i386/hvf/x86_flags.h
@@ -25,156 +25,6 @@
 
 #include "x86_gen.h"
 #include "cpu.h"
-
-/* this is basically bocsh code */
-
-#define LF_SIGN_BIT     31
-
-#define LF_BIT_SD      (0)          /* lazy Sign Flag Delta            */
-#define LF_BIT_AF      (3)          /* lazy Adjust flag                */
-#define LF_BIT_PDB     (8)          /* lazy Parity Delta Byte (8 bits) */
-#define LF_BIT_CF      (31)         /* lazy Carry Flag                 */
-#define LF_BIT_PO      (30)         /* lazy Partial Overflow = CF ^ OF */
-
-#define LF_MASK_SD     (0x01 << LF_BIT_SD)
-#define LF_MASK_AF     (0x01 << LF_BIT_AF)
-#define LF_MASK_PDB    (0xFF << LF_BIT_PDB)
-#define LF_MASK_CF     (0x01 << LF_BIT_CF)
-#define LF_MASK_PO     (0x01 << LF_BIT_PO)
-
-#define ADD_COUT_VEC(op1, op2, result) \
-   (((op1) & (op2)) | (((op1) | (op2)) & (~(result))))
-
-#define SUB_COUT_VEC(op1, op2, result) \
-   (((~(op1)) & (op2)) | (((~(op1)) ^ (op2)) & (result)))
-
-#define GET_ADD_OVERFLOW(op1, op2, result, mask) \
-   ((((op1) ^ (result)) & ((op2) ^ (result))) & (mask))
-
-/* ******************* */
-/* OSZAPC */
-/* ******************* */
-
-/* size, carries, result */
-#define SET_FLAGS_OSZAPC_SIZE(size, lf_carries, lf_result) { \
-    addr_t temp = ((lf_carries) & (LF_MASK_AF)) | \
-    (((lf_carries) >> (size - 2)) << LF_BIT_PO); \
-    env->hvf_emul->lflags.result = (addr_t)(int##size##_t)(lf_result); \
-    if ((size) == 32) { \
-        temp = ((lf_carries) & ~(LF_MASK_PDB | LF_MASK_SD)); \
-    } else if ((size) == 16) { \
-        temp = ((lf_carries) & (LF_MASK_AF)) | ((lf_carries) << 16); \
-    } else if ((size) == 8)  { \
-        temp = ((lf_carries) & (LF_MASK_AF)) | ((lf_carries) << 24); \
-    } else { \
-        VM_PANIC("unimplemented");  \
-    } \
-    env->hvf_emul->lflags.auxbits = (addr_t)(uint32_t)temp; \
-}
-
-/* carries, result */
-#define SET_FLAGS_OSZAPC_8(carries, result) \
-    SET_FLAGS_OSZAPC_SIZE(8, carries, result)
-#define SET_FLAGS_OSZAPC_16(carries, result) \
-    SET_FLAGS_OSZAPC_SIZE(16, carries, result)
-#define SET_FLAGS_OSZAPC_32(carries, result) \
-    SET_FLAGS_OSZAPC_SIZE(32, carries, result)
-
-/* result */
-#define SET_FLAGS_OSZAPC_LOGIC_8(result_8) \
-    SET_FLAGS_OSZAPC_8(0, (result_8))
-#define SET_FLAGS_OSZAPC_LOGIC_16(result_16) \
-    SET_FLAGS_OSZAPC_16(0, (result_16))
-#define SET_FLAGS_OSZAPC_LOGIC_32(result_32) \
-    SET_FLAGS_OSZAPC_32(0, (result_32))
-#define SET_FLAGS_OSZAPC_LOGIC_SIZE(size, result) {             \
-    if (32 == size) { \
-        SET_FLAGS_OSZAPC_LOGIC_32(result); \
-    } else if (16 == size) { \
-        SET_FLAGS_OSZAPC_LOGIC_16(result); \
-    } else if (8 == size) { \
-        SET_FLAGS_OSZAPC_LOGIC_8(result); \
-    } else { \
-        VM_PANIC("unimplemented");                            \
-    } \
-}
-
-/* op1, op2, result */
-#define SET_FLAGS_OSZAPC_ADD_8(op1_8, op2_8, sum_8) \
-    SET_FLAGS_OSZAPC_8(ADD_COUT_VEC((op1_8), (op2_8), (sum_8)), (sum_8))
-#define SET_FLAGS_OSZAPC_ADD_16(op1_16, op2_16, sum_16) \
-    SET_FLAGS_OSZAPC_16(ADD_COUT_VEC((op1_16), (op2_16), (sum_16)), (sum_16))
-#define SET_FLAGS_OSZAPC_ADD_32(op1_32, op2_32, sum_32) \
-    SET_FLAGS_OSZAPC_32(ADD_COUT_VEC((op1_32), (op2_32), (sum_32)), (sum_32))
-
-/* op1, op2, result */
-#define SET_FLAGS_OSZAPC_SUB_8(op1_8, op2_8, diff_8) \
-    SET_FLAGS_OSZAPC_8(SUB_COUT_VEC((op1_8), (op2_8), (diff_8)), (diff_8))
-#define SET_FLAGS_OSZAPC_SUB_16(op1_16, op2_16, diff_16) \
-    SET_FLAGS_OSZAPC_16(SUB_COUT_VEC((op1_16), (op2_16), (diff_16)), (diff_16))
-#define SET_FLAGS_OSZAPC_SUB_32(op1_32, op2_32, diff_32) \
-    SET_FLAGS_OSZAPC_32(SUB_COUT_VEC((op1_32), (op2_32), (diff_32)), (diff_32))
-
-/* ******************* */
-/* OSZAP */
-/* ******************* */
-/* size, carries, result */
-#define SET_FLAGS_OSZAP_SIZE(size, lf_carries, lf_result) { \
-    addr_t temp = ((lf_carries) & (LF_MASK_AF)) | \
-    (((lf_carries) >> (size - 2)) << LF_BIT_PO); \
-    if ((size) == 32) { \
-        temp = ((lf_carries) & ~(LF_MASK_PDB | LF_MASK_SD)); \
-    } else if ((size) == 16) { \
-        temp = ((lf_carries) & (LF_MASK_AF)) | ((lf_carries) << 16); \
-    } else if ((size) == 8) { \
-        temp = ((lf_carries) & (LF_MASK_AF)) | ((lf_carries) << 24); \
-    } else { \
-        VM_PANIC("unimplemented");      \
-    } \
-    env->hvf_emul->lflags.result = (addr_t)(int##size##_t)(lf_result); \
-    addr_t delta_c = (env->hvf_emul->lflags.auxbits ^ temp) & LF_MASK_CF; \
-    delta_c ^= (delta_c >> 1); \
-    env->hvf_emul->lflags.auxbits = (addr_t)(uint32_t)(temp ^ delta_c); \
-}
-
-/* carries, result */
-#define SET_FLAGS_OSZAP_8(carries, result) \
-    SET_FLAGS_OSZAP_SIZE(8, carries, result)
-#define SET_FLAGS_OSZAP_16(carries, result) \
-    SET_FLAGS_OSZAP_SIZE(16, carries, result)
-#define SET_FLAGS_OSZAP_32(carries, result) \
-    SET_FLAGS_OSZAP_SIZE(32, carries, result)
-
-/* op1, op2, result */
-#define SET_FLAGS_OSZAP_ADD_8(op1_8, op2_8, sum_8) \
-    SET_FLAGS_OSZAP_8(ADD_COUT_VEC((op1_8), (op2_8), (sum_8)), (sum_8))
-#define SET_FLAGS_OSZAP_ADD_16(op1_16, op2_16, sum_16) \
-    SET_FLAGS_OSZAP_16(ADD_COUT_VEC((op1_16), (op2_16), (sum_16)), (sum_16))
-#define SET_FLAGS_OSZAP_ADD_32(op1_32, op2_32, sum_32) \
-    SET_FLAGS_OSZAP_32(ADD_COUT_VEC((op1_32), (op2_32), (sum_32)), (sum_32))
-
-/* op1, op2, result */
-#define SET_FLAGS_OSZAP_SUB_8(op1_8, op2_8, diff_8) \
-    SET_FLAGS_OSZAP_8(SUB_COUT_VEC((op1_8), (op2_8), (diff_8)), (diff_8))
-#define SET_FLAGS_OSZAP_SUB_16(op1_16, op2_16, diff_16) \
-    SET_FLAGS_OSZAP_16(SUB_COUT_VEC((op1_16), (op2_16), (diff_16)), (diff_16))
-#define SET_FLAGS_OSZAP_SUB_32(op1_32, op2_32, diff_32) \
-    SET_FLAGS_OSZAP_32(SUB_COUT_VEC((op1_32), (op2_32), (diff_32)), (diff_32))
-
-/* ******************* */
-/* OSZAxC */
-/* ******************* */
-/* size, carries, result */
-#define SET_FLAGS_OSZAxC_LOGIC_SIZE(size, lf_result) { \
-    bool saved_PF = getB_PF(); \
-    SET_FLAGS_OSZAPC_SIZE(size, (int##size##_t)(0), lf_result); \
-    set_PF(saved_PF); \
-}
-
-/* result */
-#define SET_FLAGS_OSZAxC_LOGIC_32(result_32) \
-    SET_FLAGS_OSZAxC_LOGIC_SIZE(32, (result_32))
-
 void lflags_to_rflags(CPUX86State *env);
 void rflags_to_lflags(CPUX86State *env);
 
@@ -221,22 +71,11 @@ void SET_FLAGS_OSZAP_ADD16(CPUX86State *env, uint16_t v1, uint16_t v2,
 void SET_FLAGS_OSZAP_ADD8(CPUX86State *env, uint8_t v1, uint8_t v2,
                           uint8_t diff);
 
-void SET_FLAGS_OSZAPC_LOGIC32(CPUX86State *env, uint32_t diff);
-void SET_FLAGS_OSZAPC_LOGIC16(CPUX86State *env, uint16_t diff);
-void SET_FLAGS_OSZAPC_LOGIC8(CPUX86State *env, uint8_t diff);
-
-void SET_FLAGS_SHR32(CPUX86State *env, uint32_t v, int count, uint32_t res);
-void SET_FLAGS_SHR16(CPUX86State *env, uint16_t v, int count, uint16_t res);
-void SET_FLAGS_SHR8(CPUX86State *env, uint8_t v, int count, uint8_t res);
-
-void SET_FLAGS_SAR32(CPUX86State *env, int32_t v, int count, uint32_t res);
-void SET_FLAGS_SAR16(CPUX86State *env, int16_t v, int count, uint16_t res);
-void SET_FLAGS_SAR8(CPUX86State *env, int8_t v, int count, uint8_t res);
-
-void SET_FLAGS_SHL32(CPUX86State *env, uint32_t v, int count, uint32_t res);
-void SET_FLAGS_SHL16(CPUX86State *env, uint16_t v, int count, uint16_t res);
-void SET_FLAGS_SHL8(CPUX86State *env, uint8_t v, int count, uint8_t res);
+void SET_FLAGS_OSZAPC_LOGIC32(CPUX86State *env, uint32_t v1, uint32_t v2,
+                              uint32_t diff);
+void SET_FLAGS_OSZAPC_LOGIC16(CPUX86State *env, uint16_t v1, uint16_t v2,
+                              uint16_t diff);
+void SET_FLAGS_OSZAPC_LOGIC8(CPUX86State *env, uint8_t v1, uint8_t v2,
+                             uint8_t diff);
 
-bool _get_OF(CPUX86State *env);
-bool _get_CF(CPUX86State *env);
 #endif /* __X86_FLAGS_H__ */
-- 
2.14.3
