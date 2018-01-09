Received: from eggs.gnu.org ([2001:4830:134:3::10]:49885)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1eYyFG-0007r9-6J
	for qemu-devel@nongnu.org; Tue, 09 Jan 2018 13:03:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1eYyF9-0002gg-Q0
	for qemu-devel@nongnu.org; Tue, 09 Jan 2018 13:03:30 -0500
Received: from mail-lf0-x244.google.com ([2a00:1450:4010:c07::244]:43898)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <jcmvbkbc@gmail.com>) id 1eYyF8-0002bv-SA
	for qemu-devel@nongnu.org; Tue, 09 Jan 2018 13:03:23 -0500
Received: by mail-lf0-x244.google.com with SMTP id z124so6482167lfd.10
	for <qemu-devel@nongnu.org>; Tue, 09 Jan 2018 10:03:21 -0800 (PST)
From: Max Filippov <jcmvbkbc@gmail.com>
Date: Tue,  9 Jan 2018 10:03:04 -0800
Message-Id: <1515520984-2873-1-git-send-email-jcmvbkbc@gmail.com>
Subject: [Qemu-devel] [PATCH v4] target/xtensa: use libisa for instruction
 decoding
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Max Filippov <jcmvbkbc@gmail.com>

Replace manual opcode analysis with libisa-based code. This makes it
possible to support variable-encoding instructions of the core ISA, like
const16, and will allow to support advanced Xtensa features, like FLIX
and TIE.

Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
---
Changes v3->v4:
- Don't use g_malloc_n, use g_new instead.

Changes v2->v3:
- drop no longer used function option_bits_enabled.

 target/xtensa/cpu.h       |    3 +
 target/xtensa/helper.c    |   37 +
 target/xtensa/translate.c | 2228 ++-------------------------------------------
 3 files changed, 124 insertions(+), 2144 deletions(-)

diff --git a/target/xtensa/cpu.h b/target/xtensa/cpu.h
index 9a34cc825e96..e93bbb3c6d1e 100644
--- a/target/xtensa/cpu.h
+++ b/target/xtensa/cpu.h
@@ -392,6 +392,9 @@ struct XtensaConfig {
     uint32_t configid[2];
 
     void *isa_internal;
+    xtensa_isa isa;
+    XtensaOpcodeOps **opcode_ops;
+    const XtensaOpcodeTranslators **opcode_translators;
 
     uint32_t clock_freq_khz;
 
diff --git a/target/xtensa/helper.c b/target/xtensa/helper.c
index 216f1988aac5..5009fecedcb0 100644
--- a/target/xtensa/helper.c
+++ b/target/xtensa/helper.c
@@ -52,10 +52,47 @@ static void xtensa_core_class_init(ObjectClass *oc, void *data)
     cc->gdb_num_core_regs = config->gdb_regmap.num_regs;
 }
 
+static void init_libisa(XtensaConfig *config)
+{
+    unsigned i, j;
+    unsigned opcodes;
+
+    config->isa = xtensa_isa_init(config->isa_internal, NULL, NULL);
+    assert(xtensa_isa_maxlength(config->isa) <= MAX_INSN_LENGTH);
+    opcodes = xtensa_isa_num_opcodes(config->isa);
+    config->opcode_ops = g_new(XtensaOpcodeOps *, opcodes);
+
+    for (i = 0; i < opcodes; ++i) {
+        const char *opc_name = xtensa_opcode_name(config->isa, i);
+        XtensaOpcodeOps *ops = NULL;
+
+        assert(xtensa_opcode_num_operands(config->isa, i) <= MAX_OPCODE_ARGS);
+        if (!config->opcode_translators) {
+            ops = xtensa_find_opcode_ops(&xtensa_core_opcodes, opc_name);
+        } else {
+            for (j = 0; !ops && config->opcode_translators[j]; ++j) {
+                ops = xtensa_find_opcode_ops(config->opcode_translators[j],
+                                             opc_name);
+            }
+        }
+#ifdef DEBUG
+        if (ops == NULL) {
+            fprintf(stderr,
+                    "opcode translator not found for %s's opcode '%s'\n",
+                    config->name, opc_name);
+        }
+#endif
+        config->opcode_ops[i] = ops;
+    }
+}
+
 void xtensa_finalize_config(XtensaConfig *config)
 {
     unsigned i, n = 0;
 
+    if (config->isa_internal) {
+        init_libisa(config);
+    }
     if (config->gdb_regmap.num_regs) {
         return;
     }
diff --git a/target/xtensa/translate.c b/target/xtensa/translate.c
index f6a53cdfc28f..cf204fcb6072 100644
--- a/target/xtensa/translate.c
+++ b/target/xtensa/translate.c
@@ -77,6 +77,8 @@ typedef struct DisasContext {
     unsigned cpenable;
 
     uint32_t *raw_arg;
+    xtensa_insnbuf insnbuf;
+    xtensa_insnbuf slotbuf;
 } DisasContext;
 
 static TCGv_i32 cpu_pc;
@@ -254,11 +256,6 @@ void xtensa_translate_init(void)
     }
 }
 
-static inline bool option_bits_enabled(DisasContext *dc, uint64_t opt)
-{
-    return xtensa_option_bits_enabled(dc->config, opt);
-}
-
 static inline bool option_enabled(DisasContext *dc, int opt)
 {
     return xtensa_option_enabled(dc->config, opt);
@@ -471,21 +468,21 @@ static void gen_jumpi_check_loop_end(DisasContext *dc, int slot)
 }
 
 static void gen_brcond(DisasContext *dc, TCGCond cond,
-        TCGv_i32 t0, TCGv_i32 t1, uint32_t offset)
+                       TCGv_i32 t0, TCGv_i32 t1, uint32_t addr)
 {
     TCGLabel *label = gen_new_label();
 
     tcg_gen_brcond_i32(cond, t0, t1, label);
     gen_jumpi_check_loop_end(dc, 0);
     gen_set_label(label);
-    gen_jumpi(dc, dc->pc + offset, 1);
+    gen_jumpi(dc, addr, 1);
 }
 
 static void gen_brcondi(DisasContext *dc, TCGCond cond,
-        TCGv_i32 t0, uint32_t t1, uint32_t offset)
+                        TCGv_i32 t0, uint32_t t1, uint32_t addr)
 {
     TCGv_i32 tmp = tcg_const_i32(t1);
-    gen_brcond(dc, cond, t0, tmp, offset);
+    gen_brcond(dc, cond, t0, tmp, addr);
     tcg_temp_free(tmp);
 }
 
@@ -947,2164 +944,98 @@ static TCGv_i32 gen_mac16_m(TCGv_i32 v, bool hi, bool is_unsigned)
     return m;
 }
 
-static inline unsigned xtensa_op0_insn_len(unsigned op0)
+static inline unsigned xtensa_op0_insn_len(DisasContext *dc, uint8_t op0)
 {
-    return op0 >= 8 ? 2 : 3;
+    return xtensa_isa_length_from_chars(dc->config->isa, &op0);
 }
 
 static void disas_xtensa_insn(CPUXtensaState *env, DisasContext *dc)
 {
-#define HAS_OPTION_BITS(opt) do { \
-        if (!option_bits_enabled(dc, opt)) { \
-            qemu_log_mask(LOG_GUEST_ERROR, "Option is not enabled %s:%d\n", \
-                          __FILE__, __LINE__); \
-            goto invalid_opcode; \
-        } \
-    } while (0)
-
-#define HAS_OPTION(opt) HAS_OPTION_BITS(XTENSA_OPTION_BIT(opt))
-
-#define TBD() qemu_log_mask(LOG_UNIMP, "TBD(pc = %08x): %s:%d\n", dc->pc, __FILE__, __LINE__)
-#define RESERVED() do { \
-        qemu_log_mask(LOG_GUEST_ERROR, "RESERVED(pc = %08x, %02x%02x%02x): %s:%d\n", \
-                      dc->pc, b0, b1, b2, __FILE__, __LINE__); \
-        goto invalid_opcode; \
-    } while (0)
-
-
-#ifdef TARGET_WORDS_BIGENDIAN
-#define OP0 (((b0) & 0xf0) >> 4)
-#define OP1 (((b2) & 0xf0) >> 4)
-#define OP2 ((b2) & 0xf)
-#define RRR_R ((b1) & 0xf)
-#define RRR_S (((b1) & 0xf0) >> 4)
-#define RRR_T ((b0) & 0xf)
-#else
-#define OP0 (((b0) & 0xf))
-#define OP1 (((b2) & 0xf))
-#define OP2 (((b2) & 0xf0) >> 4)
-#define RRR_R (((b1) & 0xf0) >> 4)
-#define RRR_S (((b1) & 0xf))
-#define RRR_T (((b0) & 0xf0) >> 4)
-#endif
-#define RRR_X ((RRR_R & 0x4) >> 2)
-#define RRR_Y ((RRR_T & 0x4) >> 2)
-#define RRR_W (RRR_R & 0x3)
-
-#define RRRN_R RRR_R
-#define RRRN_S RRR_S
-#define RRRN_T RRR_T
-
-#define RRI4_R RRR_R
-#define RRI4_S RRR_S
-#define RRI4_T RRR_T
-#ifdef TARGET_WORDS_BIGENDIAN
-#define RRI4_IMM4 ((b2) & 0xf)
-#else
-#define RRI4_IMM4 (((b2) & 0xf0) >> 4)
-#endif
-
-#define RRI8_R RRR_R
-#define RRI8_S RRR_S
-#define RRI8_T RRR_T
-#define RRI8_IMM8 (b2)
-#define RRI8_IMM8_SE ((((b2) & 0x80) ? 0xffffff00 : 0) | RRI8_IMM8)
-
-#ifdef TARGET_WORDS_BIGENDIAN
-#define RI16_IMM16 (((b1) << 8) | (b2))
-#else
-#define RI16_IMM16 (((b2) << 8) | (b1))
-#endif
-
-#ifdef TARGET_WORDS_BIGENDIAN
-#define CALL_N (((b0) & 0xc) >> 2)
-#define CALL_OFFSET ((((b0) & 0x3) << 16) | ((b1) << 8) | (b2))
-#else
-#define CALL_N (((b0) & 0x30) >> 4)
-#define CALL_OFFSET ((((b0) & 0xc0) >> 6) | ((b1) << 2) | ((b2) << 10))
-#endif
-#define CALL_OFFSET_SE \
-    (((CALL_OFFSET & 0x20000) ? 0xfffc0000 : 0) | CALL_OFFSET)
-
-#define CALLX_N CALL_N
-#ifdef TARGET_WORDS_BIGENDIAN
-#define CALLX_M ((b0) & 0x3)
-#else
-#define CALLX_M (((b0) & 0xc0) >> 6)
-#endif
-#define CALLX_S RRR_S
-
-#define BRI12_M CALLX_M
-#define BRI12_S RRR_S
-#ifdef TARGET_WORDS_BIGENDIAN
-#define BRI12_IMM12 ((((b1) & 0xf) << 8) | (b2))
-#else
-#define BRI12_IMM12 ((((b1) & 0xf0) >> 4) | ((b2) << 4))
-#endif
-#define BRI12_IMM12_SE (((BRI12_IMM12 & 0x800) ? 0xfffff000 : 0) | BRI12_IMM12)
-
-#define BRI8_M BRI12_M
-#define BRI8_R RRI8_R
-#define BRI8_S RRI8_S
-#define BRI8_IMM8 RRI8_IMM8
-#define BRI8_IMM8_SE RRI8_IMM8_SE
-
-#define RSR_SR (b1)
-
-    uint8_t b0 = cpu_ldub_code(env, dc->pc);
-    uint8_t b1 = cpu_ldub_code(env, dc->pc + 1);
-    uint8_t b2 = 0;
-    unsigned len = xtensa_op0_insn_len(OP0);
-
-    static const uint32_t B4CONST[] = {
-        0xffffffff, 1, 2, 3, 4, 5, 6, 7, 8, 10, 12, 16, 32, 64, 128, 256
-    };
-
-    static const uint32_t B4CONSTU[] = {
-        32768, 65536, 2, 3, 4, 5, 6, 7, 8, 10, 12, 16, 32, 64, 128, 256
-    };
-
-    switch (len) {
-    case 2:
-        HAS_OPTION(XTENSA_OPTION_CODE_DENSITY);
-        break;
-
-    case 3:
-        b2 = cpu_ldub_code(env, dc->pc + 2);
-        break;
+    xtensa_isa isa = dc->config->isa;
+    unsigned char b[MAX_INSN_LENGTH] = {cpu_ldub_code(env, dc->pc)};
+    unsigned len = xtensa_op0_insn_len(dc, b[0]);
+    xtensa_format fmt;
+    unsigned slot, slots;
+    unsigned i;
 
-    default:
-        RESERVED();
+    if (len == XTENSA_UNDEFINED) {
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "unknown instruction length (pc = %08x)\n",
+                      dc->pc);
+        gen_exception_cause(dc, ILLEGAL_INSTRUCTION_CAUSE);
+        return;
     }
-    dc->next_pc = dc->pc + len;
-
-    switch (OP0) {
-    case 0: /*QRST*/
-        switch (OP1) {
-        case 0: /*RST0*/
-            switch (OP2) {
-            case 0: /*ST0*/
-                if ((RRR_R & 0xc) == 0x8) {
-                    HAS_OPTION(XTENSA_OPTION_BOOLEAN);
-                }
-
-                switch (RRR_R) {
-                case 0: /*SNM0*/
-                    switch (CALLX_M) {
-                    case 0: /*ILL*/
-                        gen_exception_cause(dc, ILLEGAL_INSTRUCTION_CAUSE);
-                        break;
-
-                    case 1: /*reserved*/
-                        RESERVED();
-                        break;
-
-                    case 2: /*JR*/
-                        switch (CALLX_N) {
-                        case 0: /*RET*/
-                        case 2: /*JX*/
-                            if (gen_window_check1(dc, CALLX_S)) {
-                                gen_jump(dc, cpu_R[CALLX_S]);
-                            }
-                            break;
-
-                        case 1: /*RETWw*/
-                            HAS_OPTION(XTENSA_OPTION_WINDOWED_REGISTER);
-                            {
-                                TCGv_i32 tmp = tcg_const_i32(dc->pc);
-                                gen_helper_retw(tmp, cpu_env, tmp);
-                                gen_jump(dc, tmp);
-                                tcg_temp_free(tmp);
-                            }
-                            break;
-
-                        case 3: /*reserved*/
-                            RESERVED();
-                            break;
-                        }
-                        break;
-
-                    case 3: /*CALLX*/
-                        if (!gen_window_check2(dc, CALLX_S, CALLX_N << 2)) {
-                            break;
-                        }
-                        switch (CALLX_N) {
-                        case 0: /*CALLX0*/
-                            {
-                                TCGv_i32 tmp = tcg_temp_new_i32();
-                                tcg_gen_mov_i32(tmp, cpu_R[CALLX_S]);
-                                tcg_gen_movi_i32(cpu_R[0], dc->next_pc);
-                                gen_jump(dc, tmp);
-                                tcg_temp_free(tmp);
-                            }
-                            break;
-
-                        case 1: /*CALLX4w*/
-                        case 2: /*CALLX8w*/
-                        case 3: /*CALLX12w*/
-                            HAS_OPTION(XTENSA_OPTION_WINDOWED_REGISTER);
-                            {
-                                TCGv_i32 tmp = tcg_temp_new_i32();
-
-                                tcg_gen_mov_i32(tmp, cpu_R[CALLX_S]);
-                                gen_callw(dc, CALLX_N, tmp);
-                                tcg_temp_free(tmp);
-                            }
-                            break;
-                        }
-                        break;
-                    }
-                    break;
-
-                case 1: /*MOVSPw*/
-                    HAS_OPTION(XTENSA_OPTION_WINDOWED_REGISTER);
-                    if (gen_window_check2(dc, RRR_T, RRR_S)) {
-                        TCGv_i32 pc = tcg_const_i32(dc->pc);
-                        gen_helper_movsp(cpu_env, pc);
-                        tcg_gen_mov_i32(cpu_R[RRR_T], cpu_R[RRR_S]);
-                        tcg_temp_free(pc);
-                    }
-                    break;
-
-                case 2: /*SYNC*/
-                    switch (RRR_T) {
-                    case 0: /*ISYNC*/
-                        break;
-
-                    case 1: /*RSYNC*/
-                        break;
-
-                    case 2: /*ESYNC*/
-                        break;
-
-                    case 3: /*DSYNC*/
-                        break;
-
-                    case 8: /*EXCW*/
-                        HAS_OPTION(XTENSA_OPTION_EXCEPTION);
-                        break;
-
-                    case 12: /*MEMW*/
-                        break;
-
-                    case 13: /*EXTW*/
-                        break;
-
-                    case 15: /*NOP*/
-                        break;
-
-                    default: /*reserved*/
-                        RESERVED();
-                        break;
-                    }
-                    break;
-
-                case 3: /*RFEIx*/
-                    switch (RRR_T) {
-                    case 0: /*RFETx*/
-                        HAS_OPTION(XTENSA_OPTION_EXCEPTION);
-                        switch (RRR_S) {
-                        case 0: /*RFEx*/
-                            if (gen_check_privilege(dc)) {
-                                tcg_gen_andi_i32(cpu_SR[PS], cpu_SR[PS], ~PS_EXCM);
-                                gen_check_interrupts(dc);
-                                gen_jump(dc, cpu_SR[EPC1]);
-                            }
-                            break;
-
-                        case 1: /*RFUEx*/
-                            RESERVED();
-                            break;
-
-                        case 2: /*RFDEx*/
-                            if (gen_check_privilege(dc)) {
-                                gen_jump(dc, cpu_SR[
-                                         dc->config->ndepc ? DEPC : EPC1]);
-                            }
-                            break;
-
-                        case 4: /*RFWOw*/
-                        case 5: /*RFWUw*/
-                            HAS_OPTION(XTENSA_OPTION_WINDOWED_REGISTER);
-                            if (gen_check_privilege(dc)) {
-                                TCGv_i32 tmp = tcg_const_i32(1);
-
-                                tcg_gen_andi_i32(
-                                        cpu_SR[PS], cpu_SR[PS], ~PS_EXCM);
-                                tcg_gen_shl_i32(tmp, tmp, cpu_SR[WINDOW_BASE]);
-
-                                if (RRR_S == 4) {
-                                    tcg_gen_andc_i32(cpu_SR[WINDOW_START],
-                                            cpu_SR[WINDOW_START], tmp);
-                                } else {
-                                    tcg_gen_or_i32(cpu_SR[WINDOW_START],
-                                            cpu_SR[WINDOW_START], tmp);
-                                }
-
-                                gen_helper_restore_owb(cpu_env);
-                                gen_check_interrupts(dc);
-                                gen_jump(dc, cpu_SR[EPC1]);
-
-                                tcg_temp_free(tmp);
-                            }
-                            break;
-
-                        default: /*reserved*/
-                            RESERVED();
-                            break;
-                        }
-                        break;
-
-                    case 1: /*RFIx*/
-                        HAS_OPTION(XTENSA_OPTION_HIGH_PRIORITY_INTERRUPT);
-                        if (RRR_S >= 2 && RRR_S <= dc->config->nlevel) {
-                            if (gen_check_privilege(dc)) {
-                                tcg_gen_mov_i32(cpu_SR[PS],
-                                                cpu_SR[EPS2 + RRR_S - 2]);
-                                gen_check_interrupts(dc);
-                                gen_jump(dc, cpu_SR[EPC1 + RRR_S - 1]);
-                            }
-                        } else {
-                            qemu_log_mask(LOG_GUEST_ERROR, "RFI %d is illegal\n", RRR_S);
-                            gen_exception_cause(dc, ILLEGAL_INSTRUCTION_CAUSE);
-                        }
-                        break;
-
-                    case 2: /*RFME*/
-                        TBD();
-                        break;
-
-                    default: /*reserved*/
-                        RESERVED();
-                        break;
-
-                    }
-                    break;
-
-                case 4: /*BREAKx*/
-                    HAS_OPTION(XTENSA_OPTION_DEBUG);
-                    if (dc->debug) {
-                        gen_debug_exception(dc, DEBUGCAUSE_BI);
-                    }
-                    break;
-
-                case 5: /*SYSCALLx*/
-                    HAS_OPTION(XTENSA_OPTION_EXCEPTION);
-                    switch (RRR_S) {
-                    case 0: /*SYSCALLx*/
-                        gen_exception_cause(dc, SYSCALL_CAUSE);
-                        break;
-
-                    case 1: /*SIMCALL*/
-                        if (semihosting_enabled()) {
-                            if (gen_check_privilege(dc)) {
-                                gen_helper_simcall(cpu_env);
-                            }
-                        } else {
-                            qemu_log_mask(LOG_GUEST_ERROR, "SIMCALL but semihosting is disabled\n");
-                            gen_exception_cause(dc, ILLEGAL_INSTRUCTION_CAUSE);
-                        }
-                        break;
-
-                    default:
-                        RESERVED();
-                        break;
-                    }
-                    break;
-
-                case 6: /*RSILx*/
-                    HAS_OPTION(XTENSA_OPTION_INTERRUPT);
-                    if (gen_check_privilege(dc) &&
-                        gen_window_check1(dc, RRR_T)) {
-                        tcg_gen_mov_i32(cpu_R[RRR_T], cpu_SR[PS]);
-                        tcg_gen_andi_i32(cpu_SR[PS], cpu_SR[PS], ~PS_INTLEVEL);
-                        tcg_gen_ori_i32(cpu_SR[PS], cpu_SR[PS], RRR_S);
-                        gen_check_interrupts(dc);
-                        gen_jumpi_check_loop_end(dc, 0);
-                    }
-                    break;
-
-                case 7: /*WAITIx*/
-                    HAS_OPTION(XTENSA_OPTION_INTERRUPT);
-                    if (gen_check_privilege(dc)) {
-                        gen_waiti(dc, RRR_S);
-                    }
-                    break;
-
-                case 8: /*ANY4p*/
-                case 9: /*ALL4p*/
-                case 10: /*ANY8p*/
-                case 11: /*ALL8p*/
-                    HAS_OPTION(XTENSA_OPTION_BOOLEAN);
-                    {
-                        const unsigned shift = (RRR_R & 2) ? 8 : 4;
-                        TCGv_i32 mask = tcg_const_i32(
-                                ((1 << shift) - 1) << RRR_S);
-                        TCGv_i32 tmp = tcg_temp_new_i32();
-
-                        tcg_gen_and_i32(tmp, cpu_SR[BR], mask);
-                        if (RRR_R & 1) { /*ALL*/
-                            tcg_gen_addi_i32(tmp, tmp, 1 << RRR_S);
-                        } else { /*ANY*/
-                            tcg_gen_add_i32(tmp, tmp, mask);
-                        }
-                        tcg_gen_shri_i32(tmp, tmp, RRR_S + shift);
-                        tcg_gen_deposit_i32(cpu_SR[BR], cpu_SR[BR],
-                                tmp, RRR_T, 1);
-                        tcg_temp_free(mask);
-                        tcg_temp_free(tmp);
-                    }
-                    break;
-
-                default: /*reserved*/
-                    RESERVED();
-                    break;
-
-                }
-                break;
-
-            case 1: /*AND*/
-                if (gen_window_check3(dc, RRR_R, RRR_S, RRR_T)) {
-                    tcg_gen_and_i32(cpu_R[RRR_R], cpu_R[RRR_S], cpu_R[RRR_T]);
-                }
-                break;
-
-            case 2: /*OR*/
-                if (gen_window_check3(dc, RRR_R, RRR_S, RRR_T)) {
-                    tcg_gen_or_i32(cpu_R[RRR_R], cpu_R[RRR_S], cpu_R[RRR_T]);
-                }
-                break;
-
-            case 3: /*XOR*/
-                if (gen_window_check3(dc, RRR_R, RRR_S, RRR_T)) {
-                    tcg_gen_xor_i32(cpu_R[RRR_R], cpu_R[RRR_S], cpu_R[RRR_T]);
-                }
-                break;
-
-            case 4: /*ST1*/
-                switch (RRR_R) {
-                case 0: /*SSR*/
-                    if (gen_window_check1(dc, RRR_S)) {
-                        gen_right_shift_sar(dc, cpu_R[RRR_S]);
-                    }
-                    break;
-
-                case 1: /*SSL*/
-                    if (gen_window_check1(dc, RRR_S)) {
-                        gen_left_shift_sar(dc, cpu_R[RRR_S]);
-                    }
-                    break;
-
-                case 2: /*SSA8L*/
-                    if (gen_window_check1(dc, RRR_S)) {
-                        TCGv_i32 tmp = tcg_temp_new_i32();
-                        tcg_gen_shli_i32(tmp, cpu_R[RRR_S], 3);
-                        gen_right_shift_sar(dc, tmp);
-                        tcg_temp_free(tmp);
-                    }
-                    break;
-
-                case 3: /*SSA8B*/
-                    if (gen_window_check1(dc, RRR_S)) {
-                        TCGv_i32 tmp = tcg_temp_new_i32();
-                        tcg_gen_shli_i32(tmp, cpu_R[RRR_S], 3);
-                        gen_left_shift_sar(dc, tmp);
-                        tcg_temp_free(tmp);
-                    }
-                    break;
-
-                case 4: /*SSAI*/
-                    {
-                        TCGv_i32 tmp = tcg_const_i32(
-                                RRR_S | ((RRR_T & 1) << 4));
-                        gen_right_shift_sar(dc, tmp);
-                        tcg_temp_free(tmp);
-                    }
-                    break;
-
-                case 6: /*RER*/
-                    HAS_OPTION(XTENSA_OPTION_EXTERN_REGS);
-                    if (gen_check_privilege(dc) &&
-                        gen_window_check2(dc, RRR_S, RRR_T)) {
-                        gen_helper_rer(cpu_R[RRR_T], cpu_env, cpu_R[RRR_S]);
-                    }
-                    break;
-
-                case 7: /*WER*/
-                    HAS_OPTION(XTENSA_OPTION_EXTERN_REGS);
-                    if (gen_check_privilege(dc) &&
-                        gen_window_check2(dc, RRR_S, RRR_T)) {
-                        gen_helper_wer(cpu_env, cpu_R[RRR_T], cpu_R[RRR_S]);
-                    }
-                    break;
-
-                case 8: /*ROTWw*/
-                    HAS_OPTION(XTENSA_OPTION_WINDOWED_REGISTER);
-                    if (gen_check_privilege(dc)) {
-                        TCGv_i32 tmp = tcg_const_i32(
-                                RRR_T | ((RRR_T & 8) ? 0xfffffff0 : 0));
-                        gen_helper_rotw(cpu_env, tmp);
-                        tcg_temp_free(tmp);
-                        /* This can change tb->flags, so exit tb */
-                        gen_jumpi_check_loop_end(dc, -1);
-                    }
-                    break;
-
-                case 14: /*NSAu*/
-                    HAS_OPTION(XTENSA_OPTION_MISC_OP_NSA);
-                    if (gen_window_check2(dc, RRR_S, RRR_T)) {
-                        tcg_gen_clrsb_i32(cpu_R[RRR_T], cpu_R[RRR_S]);
-                    }
-                    break;
-
-                case 15: /*NSAUu*/
-                    HAS_OPTION(XTENSA_OPTION_MISC_OP_NSA);
-                    if (gen_window_check2(dc, RRR_S, RRR_T)) {
-                        tcg_gen_clzi_i32(cpu_R[RRR_T], cpu_R[RRR_S], 32);
-                    }
-                    break;
-
-                default: /*reserved*/
-                    RESERVED();
-                    break;
-                }
-                break;
-
-            case 5: /*TLB*/
-                HAS_OPTION_BITS(
-                        XTENSA_OPTION_BIT(XTENSA_OPTION_MMU) |
-                        XTENSA_OPTION_BIT(XTENSA_OPTION_REGION_PROTECTION) |
-                        XTENSA_OPTION_BIT(XTENSA_OPTION_REGION_TRANSLATION));
-                if (gen_check_privilege(dc) &&
-                    gen_window_check2(dc, RRR_S, RRR_T)) {
-                    TCGv_i32 dtlb = tcg_const_i32((RRR_R & 8) != 0);
-
-                    switch (RRR_R & 7) {
-                    case 3: /*RITLB0*/ /*RDTLB0*/
-                        gen_helper_rtlb0(cpu_R[RRR_T],
-                                cpu_env, cpu_R[RRR_S], dtlb);
-                        break;
-
-                    case 4: /*IITLB*/ /*IDTLB*/
-                        gen_helper_itlb(cpu_env, cpu_R[RRR_S], dtlb);
-                        /* This could change memory mapping, so exit tb */
-                        gen_jumpi_check_loop_end(dc, -1);
-                        break;
-
-                    case 5: /*PITLB*/ /*PDTLB*/
-                        tcg_gen_movi_i32(cpu_pc, dc->pc);
-                        gen_helper_ptlb(cpu_R[RRR_T],
-                                cpu_env, cpu_R[RRR_S], dtlb);
-                        break;
-
-                    case 6: /*WITLB*/ /*WDTLB*/
-                        gen_helper_wtlb(
-                                cpu_env, cpu_R[RRR_T], cpu_R[RRR_S], dtlb);
-                        /* This could change memory mapping, so exit tb */
-                        gen_jumpi_check_loop_end(dc, -1);
-                        break;
-
-                    case 7: /*RITLB1*/ /*RDTLB1*/
-                        gen_helper_rtlb1(cpu_R[RRR_T],
-                                cpu_env, cpu_R[RRR_S], dtlb);
-                        break;
-
-                    default:
-                        tcg_temp_free(dtlb);
-                        RESERVED();
-                        break;
-                    }
-                    tcg_temp_free(dtlb);
-                }
-                break;
-
-            case 6: /*RT0*/
-                if (!gen_window_check2(dc, RRR_R, RRR_T)) {
-                    break;
-                }
-                switch (RRR_S) {
-                case 0: /*NEG*/
-                    tcg_gen_neg_i32(cpu_R[RRR_R], cpu_R[RRR_T]);
-                    break;
-
-                case 1: /*ABS*/
-                    {
-                        TCGv_i32 zero = tcg_const_i32(0);
-                        TCGv_i32 neg = tcg_temp_new_i32();
-
-                        tcg_gen_neg_i32(neg, cpu_R[RRR_T]);
-                        tcg_gen_movcond_i32(TCG_COND_GE, cpu_R[RRR_R],
-                                cpu_R[RRR_T], zero, cpu_R[RRR_T], neg);
-                        tcg_temp_free(neg);
-                        tcg_temp_free(zero);
-                    }
-                    break;
-
-                default: /*reserved*/
-                    RESERVED();
-                    break;
-                }
-                break;
-
-            case 7: /*reserved*/
-                RESERVED();
-                break;
-
-            case 8: /*ADD*/
-                if (gen_window_check3(dc, RRR_R, RRR_S, RRR_T)) {
-                    tcg_gen_add_i32(cpu_R[RRR_R], cpu_R[RRR_S], cpu_R[RRR_T]);
-                }
-                break;
-
-            case 9: /*ADD**/
-            case 10:
-            case 11:
-                if (gen_window_check3(dc, RRR_R, RRR_S, RRR_T)) {
-                    TCGv_i32 tmp = tcg_temp_new_i32();
-                    tcg_gen_shli_i32(tmp, cpu_R[RRR_S], OP2 - 8);
-                    tcg_gen_add_i32(cpu_R[RRR_R], tmp, cpu_R[RRR_T]);
-                    tcg_temp_free(tmp);
-                }
-                break;
-
-            case 12: /*SUB*/
-                if (gen_window_check3(dc, RRR_R, RRR_S, RRR_T)) {
-                    tcg_gen_sub_i32(cpu_R[RRR_R], cpu_R[RRR_S], cpu_R[RRR_T]);
-                }
-                break;
-
-            case 13: /*SUB**/
-            case 14:
-            case 15:
-                if (gen_window_check3(dc, RRR_R, RRR_S, RRR_T)) {
-                    TCGv_i32 tmp = tcg_temp_new_i32();
-                    tcg_gen_shli_i32(tmp, cpu_R[RRR_S], OP2 - 12);
-                    tcg_gen_sub_i32(cpu_R[RRR_R], tmp, cpu_R[RRR_T]);
-                    tcg_temp_free(tmp);
-                }
-                break;
-            }
-            break;
-
-        case 1: /*RST1*/
-            switch (OP2) {
-            case 0: /*SLLI*/
-            case 1:
-                if (gen_window_check2(dc, RRR_R, RRR_S)) {
-                    tcg_gen_shli_i32(cpu_R[RRR_R], cpu_R[RRR_S],
-                                     32 - (RRR_T | ((OP2 & 1) << 4)));
-                }
-                break;
-
-            case 2: /*SRAI*/
-            case 3:
-                if (gen_window_check2(dc, RRR_R, RRR_T)) {
-                    tcg_gen_sari_i32(cpu_R[RRR_R], cpu_R[RRR_T],
-                                     RRR_S | ((OP2 & 1) << 4));
-                }
-                break;
-
-            case 4: /*SRLI*/
-                if (gen_window_check2(dc, RRR_R, RRR_T)) {
-                    tcg_gen_shri_i32(cpu_R[RRR_R], cpu_R[RRR_T], RRR_S);
-                }
-                break;
-
-            case 6: /*XSR*/
-                if (gen_check_sr(dc, RSR_SR, SR_X) &&
-                    (RSR_SR < 64 || gen_check_privilege(dc)) &&
-                    gen_window_check1(dc, RRR_T)) {
-                    TCGv_i32 tmp = tcg_temp_new_i32();
-                    bool rsr_end, wsr_end;
-
-                    tcg_gen_mov_i32(tmp, cpu_R[RRR_T]);
-                    rsr_end = gen_rsr(dc, cpu_R[RRR_T], RSR_SR);
-                    wsr_end = gen_wsr(dc, RSR_SR, tmp);
-                    tcg_temp_free(tmp);
-                    if (rsr_end && !wsr_end) {
-                        gen_jumpi_check_loop_end(dc, 0);
-                    }
-                }
-                break;
-
-                /*
-                 * Note: 64 bit ops are used here solely because SAR values
-                 * have range 0..63
-                 */
-#define gen_shift_reg(cmd, reg) do { \
-                    TCGv_i64 tmp = tcg_temp_new_i64(); \
-                    tcg_gen_extu_i32_i64(tmp, reg); \
-                    tcg_gen_##cmd##_i64(v, v, tmp); \
-                    tcg_gen_extrl_i64_i32(cpu_R[RRR_R], v); \
-                    tcg_temp_free_i64(v); \
-                    tcg_temp_free_i64(tmp); \
-                } while (0)
-
-#define gen_shift(cmd) gen_shift_reg(cmd, cpu_SR[SAR])
-
-            case 8: /*SRC*/
-                if (gen_window_check3(dc, RRR_R, RRR_S, RRR_T)) {
-                    TCGv_i64 v = tcg_temp_new_i64();
-                    tcg_gen_concat_i32_i64(v, cpu_R[RRR_T], cpu_R[RRR_S]);
-                    gen_shift(shr);
-                }
-                break;
-
-            case 9: /*SRL*/
-                if (!gen_window_check2(dc, RRR_R, RRR_T)) {
-                    break;
-                }
-                if (dc->sar_5bit) {
-                    tcg_gen_shr_i32(cpu_R[RRR_R], cpu_R[RRR_T], cpu_SR[SAR]);
-                } else {
-                    TCGv_i64 v = tcg_temp_new_i64();
-                    tcg_gen_extu_i32_i64(v, cpu_R[RRR_T]);
-                    gen_shift(shr);
-                }
-                break;
-
-            case 10: /*SLL*/
-                if (!gen_window_check2(dc, RRR_R, RRR_S)) {
-                    break;
-                }
-                if (dc->sar_m32_5bit) {
-                    tcg_gen_shl_i32(cpu_R[RRR_R], cpu_R[RRR_S], dc->sar_m32);
-                } else {
-                    TCGv_i64 v = tcg_temp_new_i64();
-                    TCGv_i32 s = tcg_const_i32(32);
-                    tcg_gen_sub_i32(s, s, cpu_SR[SAR]);
-                    tcg_gen_andi_i32(s, s, 0x3f);
-                    tcg_gen_extu_i32_i64(v, cpu_R[RRR_S]);
-                    gen_shift_reg(shl, s);
-                    tcg_temp_free(s);
-                }
-                break;
-
-            case 11: /*SRA*/
-                if (!gen_window_check2(dc, RRR_R, RRR_T)) {
-                    break;
-                }
-                if (dc->sar_5bit) {
-                    tcg_gen_sar_i32(cpu_R[RRR_R], cpu_R[RRR_T], cpu_SR[SAR]);
-                } else {
-                    TCGv_i64 v = tcg_temp_new_i64();
-                    tcg_gen_ext_i32_i64(v, cpu_R[RRR_T]);
-                    gen_shift(sar);
-                }
-                break;
-#undef gen_shift
-#undef gen_shift_reg
-
-            case 12: /*MUL16U*/
-                HAS_OPTION(XTENSA_OPTION_16_BIT_IMUL);
-                if (gen_window_check3(dc, RRR_R, RRR_S, RRR_T)) {
-                    TCGv_i32 v1 = tcg_temp_new_i32();
-                    TCGv_i32 v2 = tcg_temp_new_i32();
-                    tcg_gen_ext16u_i32(v1, cpu_R[RRR_S]);
-                    tcg_gen_ext16u_i32(v2, cpu_R[RRR_T]);
-                    tcg_gen_mul_i32(cpu_R[RRR_R], v1, v2);
-                    tcg_temp_free(v2);
-                    tcg_temp_free(v1);
-                }
-                break;
-
-            case 13: /*MUL16S*/
-                HAS_OPTION(XTENSA_OPTION_16_BIT_IMUL);
-                if (gen_window_check3(dc, RRR_R, RRR_S, RRR_T)) {
-                    TCGv_i32 v1 = tcg_temp_new_i32();
-                    TCGv_i32 v2 = tcg_temp_new_i32();
-                    tcg_gen_ext16s_i32(v1, cpu_R[RRR_S]);
-                    tcg_gen_ext16s_i32(v2, cpu_R[RRR_T]);
-                    tcg_gen_mul_i32(cpu_R[RRR_R], v1, v2);
-                    tcg_temp_free(v2);
-                    tcg_temp_free(v1);
-                }
-                break;
-
-            default: /*reserved*/
-                RESERVED();
-                break;
-            }
-            break;
-
-        case 2: /*RST2*/
-            if (OP2 >= 8 && !gen_window_check3(dc, RRR_R, RRR_S, RRR_T)) {
-                break;
-            }
-
-            if (OP2 >= 12) {
-                HAS_OPTION(XTENSA_OPTION_32_BIT_IDIV);
-                TCGLabel *label = gen_new_label();
-                tcg_gen_brcondi_i32(TCG_COND_NE, cpu_R[RRR_T], 0, label);
-                gen_exception_cause(dc, INTEGER_DIVIDE_BY_ZERO_CAUSE);
-                gen_set_label(label);
-            }
-
-            switch (OP2) {
-#define BOOLEAN_LOGIC(fn, r, s, t) \
-                do { \
-                    HAS_OPTION(XTENSA_OPTION_BOOLEAN); \
-                    TCGv_i32 tmp1 = tcg_temp_new_i32(); \
-                    TCGv_i32 tmp2 = tcg_temp_new_i32(); \
-                    \
-                    tcg_gen_shri_i32(tmp1, cpu_SR[BR], s); \
-                    tcg_gen_shri_i32(tmp2, cpu_SR[BR], t); \
-                    tcg_gen_##fn##_i32(tmp1, tmp1, tmp2); \
-                    tcg_gen_deposit_i32(cpu_SR[BR], cpu_SR[BR], tmp1, r, 1); \
-                    tcg_temp_free(tmp1); \
-                    tcg_temp_free(tmp2); \
-                } while (0)
-
-            case 0: /*ANDBp*/
-                BOOLEAN_LOGIC(and, RRR_R, RRR_S, RRR_T);
-                break;
-
-            case 1: /*ANDBCp*/
-                BOOLEAN_LOGIC(andc, RRR_R, RRR_S, RRR_T);
-                break;
-
-            case 2: /*ORBp*/
-                BOOLEAN_LOGIC(or, RRR_R, RRR_S, RRR_T);
-                break;
-
-            case 3: /*ORBCp*/
-                BOOLEAN_LOGIC(orc, RRR_R, RRR_S, RRR_T);
-                break;
-
-            case 4: /*XORBp*/
-                BOOLEAN_LOGIC(xor, RRR_R, RRR_S, RRR_T);
-                break;
-
-#undef BOOLEAN_LOGIC
-
-            case 8: /*MULLi*/
-                HAS_OPTION(XTENSA_OPTION_32_BIT_IMUL);
-                tcg_gen_mul_i32(cpu_R[RRR_R], cpu_R[RRR_S], cpu_R[RRR_T]);
-                break;
-
-            case 10: /*MULUHi*/
-            case 11: /*MULSHi*/
-                HAS_OPTION(XTENSA_OPTION_32_BIT_IMUL_HIGH);
-                {
-                    TCGv lo = tcg_temp_new();
-
-                    if (OP2 == 10) {
-                        tcg_gen_mulu2_i32(lo, cpu_R[RRR_R],
-                                          cpu_R[RRR_S], cpu_R[RRR_T]);
-                    } else {
-                        tcg_gen_muls2_i32(lo, cpu_R[RRR_R],
-                                          cpu_R[RRR_S], cpu_R[RRR_T]);
-                    }
-                    tcg_temp_free(lo);
-                }
-                break;
-
-            case 12: /*QUOUi*/
-                tcg_gen_divu_i32(cpu_R[RRR_R], cpu_R[RRR_S], cpu_R[RRR_T]);
-                break;
-
-            case 13: /*QUOSi*/
-            case 15: /*REMSi*/
-                {
-                    TCGLabel *label1 = gen_new_label();
-                    TCGLabel *label2 = gen_new_label();
-
-                    tcg_gen_brcondi_i32(TCG_COND_NE, cpu_R[RRR_S], 0x80000000,
-                            label1);
-                    tcg_gen_brcondi_i32(TCG_COND_NE, cpu_R[RRR_T], 0xffffffff,
-                            label1);
-                    tcg_gen_movi_i32(cpu_R[RRR_R],
-                            OP2 == 13 ? 0x80000000 : 0);
-                    tcg_gen_br(label2);
-                    gen_set_label(label1);
-                    if (OP2 == 13) {
-                        tcg_gen_div_i32(cpu_R[RRR_R],
-                                cpu_R[RRR_S], cpu_R[RRR_T]);
-                    } else {
-                        tcg_gen_rem_i32(cpu_R[RRR_R],
-                                cpu_R[RRR_S], cpu_R[RRR_T]);
-                    }
-                    gen_set_label(label2);
-                }
-                break;
-
-            case 14: /*REMUi*/
-                tcg_gen_remu_i32(cpu_R[RRR_R], cpu_R[RRR_S], cpu_R[RRR_T]);
-                break;
-
-            default: /*reserved*/
-                RESERVED();
-                break;
-            }
-            break;
-
-        case 3: /*RST3*/
-            switch (OP2) {
-            case 0: /*RSR*/
-                if (gen_check_sr(dc, RSR_SR, SR_R) &&
-                    (RSR_SR < 64 || gen_check_privilege(dc)) &&
-                    gen_window_check1(dc, RRR_T)) {
-                    if (gen_rsr(dc, cpu_R[RRR_T], RSR_SR)) {
-                        gen_jumpi_check_loop_end(dc, 0);
-                    }
-                }
-                break;
-
-            case 1: /*WSR*/
-                if (gen_check_sr(dc, RSR_SR, SR_W) &&
-                    (RSR_SR < 64 || gen_check_privilege(dc)) &&
-                    gen_window_check1(dc, RRR_T)) {
-                    gen_wsr(dc, RSR_SR, cpu_R[RRR_T]);
-                }
-                break;
-
-            case 2: /*SEXTu*/
-                HAS_OPTION(XTENSA_OPTION_MISC_OP_SEXT);
-                if (gen_window_check2(dc, RRR_R, RRR_S)) {
-                    int shift = 24 - RRR_T;
-
-                    if (shift == 24) {
-                        tcg_gen_ext8s_i32(cpu_R[RRR_R], cpu_R[RRR_S]);
-                    } else if (shift == 16) {
-                        tcg_gen_ext16s_i32(cpu_R[RRR_R], cpu_R[RRR_S]);
-                    } else {
-                        TCGv_i32 tmp = tcg_temp_new_i32();
-                        tcg_gen_shli_i32(tmp, cpu_R[RRR_S], shift);
-                        tcg_gen_sari_i32(cpu_R[RRR_R], tmp, shift);
-                        tcg_temp_free(tmp);
-                    }
-                }
-                break;
-
-            case 3: /*CLAMPSu*/
-                HAS_OPTION(XTENSA_OPTION_MISC_OP_CLAMPS);
-                if (gen_window_check2(dc, RRR_R, RRR_S)) {
-                    TCGv_i32 tmp1 = tcg_temp_new_i32();
-                    TCGv_i32 tmp2 = tcg_temp_new_i32();
-                    TCGv_i32 zero = tcg_const_i32(0);
-
-                    tcg_gen_sari_i32(tmp1, cpu_R[RRR_S], 24 - RRR_T);
-                    tcg_gen_xor_i32(tmp2, tmp1, cpu_R[RRR_S]);
-                    tcg_gen_andi_i32(tmp2, tmp2, 0xffffffff << (RRR_T + 7));
-
-                    tcg_gen_sari_i32(tmp1, cpu_R[RRR_S], 31);
-                    tcg_gen_xori_i32(tmp1, tmp1, 0xffffffff >> (25 - RRR_T));
-
-                    tcg_gen_movcond_i32(TCG_COND_EQ, cpu_R[RRR_R], tmp2, zero,
-                            cpu_R[RRR_S], tmp1);
-                    tcg_temp_free(tmp1);
-                    tcg_temp_free(tmp2);
-                    tcg_temp_free(zero);
-                }
-                break;
-
-            case 4: /*MINu*/
-            case 5: /*MAXu*/
-            case 6: /*MINUu*/
-            case 7: /*MAXUu*/
-                HAS_OPTION(XTENSA_OPTION_MISC_OP_MINMAX);
-                if (gen_window_check3(dc, RRR_R, RRR_S, RRR_T)) {
-                    static const TCGCond cond[] = {
-                        TCG_COND_LE,
-                        TCG_COND_GE,
-                        TCG_COND_LEU,
-                        TCG_COND_GEU
-                    };
-                    tcg_gen_movcond_i32(cond[OP2 - 4], cpu_R[RRR_R],
-                            cpu_R[RRR_S], cpu_R[RRR_T],
-                            cpu_R[RRR_S], cpu_R[RRR_T]);
-                }
-                break;
-
-            case 8: /*MOVEQZ*/
-            case 9: /*MOVNEZ*/
-            case 10: /*MOVLTZ*/
-            case 11: /*MOVGEZ*/
-                if (gen_window_check3(dc, RRR_R, RRR_S, RRR_T)) {
-                    static const TCGCond cond[] = {
-                        TCG_COND_EQ,
-                        TCG_COND_NE,
-                        TCG_COND_LT,
-                        TCG_COND_GE,
-                    };
-                    TCGv_i32 zero = tcg_const_i32(0);
-
-                    tcg_gen_movcond_i32(cond[OP2 - 8], cpu_R[RRR_R],
-                            cpu_R[RRR_T], zero, cpu_R[RRR_S], cpu_R[RRR_R]);
-                    tcg_temp_free(zero);
-                }
-                break;
-
-            case 12: /*MOVFp*/
-            case 13: /*MOVTp*/
-                HAS_OPTION(XTENSA_OPTION_BOOLEAN);
-                if (gen_window_check2(dc, RRR_R, RRR_S)) {
-                    TCGv_i32 zero = tcg_const_i32(0);
-                    TCGv_i32 tmp = tcg_temp_new_i32();
-
-                    tcg_gen_andi_i32(tmp, cpu_SR[BR], 1 << RRR_T);
-                    tcg_gen_movcond_i32(OP2 & 1 ? TCG_COND_NE : TCG_COND_EQ,
-                            cpu_R[RRR_R], tmp, zero,
-                            cpu_R[RRR_S], cpu_R[RRR_R]);
-
-                    tcg_temp_free(tmp);
-                    tcg_temp_free(zero);
-                }
-                break;
-
-            case 14: /*RUR*/
-                if (gen_window_check1(dc, RRR_R)) {
-                    int st = (RRR_S << 4) + RRR_T;
-                    if (uregnames[st].name) {
-                        tcg_gen_mov_i32(cpu_R[RRR_R], cpu_UR[st]);
-                    } else {
-                        qemu_log_mask(LOG_UNIMP, "RUR %d not implemented, ", st);
-                        TBD();
-                    }
-                }
-                break;
-
-            case 15: /*WUR*/
-                if (gen_window_check1(dc, RRR_T)) {
-                    if (uregnames[RSR_SR].name) {
-                        gen_wur(RSR_SR, cpu_R[RRR_T]);
-                    } else {
-                        qemu_log_mask(LOG_UNIMP, "WUR %d not implemented, ", RSR_SR);
-                        TBD();
-                    }
-                }
-                break;
 
-            }
-            break;
-
-        case 4: /*EXTUI*/
-        case 5:
-            if (gen_window_check2(dc, RRR_R, RRR_T)) {
-                int shiftimm = RRR_S | ((OP1 & 1) << 4);
-                int maskimm = (1 << (OP2 + 1)) - 1;
-
-                TCGv_i32 tmp = tcg_temp_new_i32();
-                tcg_gen_shri_i32(tmp, cpu_R[RRR_T], shiftimm);
-                tcg_gen_andi_i32(cpu_R[RRR_R], tmp, maskimm);
-                tcg_temp_free(tmp);
-            }
-            break;
-
-        case 6: /*CUST0*/
-            RESERVED();
-            break;
-
-        case 7: /*CUST1*/
-            RESERVED();
-            break;
-
-        case 8: /*LSCXp*/
-            switch (OP2) {
-            case 0: /*LSXf*/
-            case 1: /*LSXUf*/
-            case 4: /*SSXf*/
-            case 5: /*SSXUf*/
-                HAS_OPTION(XTENSA_OPTION_FP_COPROCESSOR);
-                if (gen_window_check2(dc, RRR_S, RRR_T) &&
-                    gen_check_cpenable(dc, 0)) {
-                    TCGv_i32 addr = tcg_temp_new_i32();
-                    tcg_gen_add_i32(addr, cpu_R[RRR_S], cpu_R[RRR_T]);
-                    gen_load_store_alignment(dc, 2, addr, false);
-                    if (OP2 & 0x4) {
-                        tcg_gen_qemu_st32(cpu_FR[RRR_R], addr, dc->cring);
-                    } else {
-                        tcg_gen_qemu_ld32u(cpu_FR[RRR_R], addr, dc->cring);
-                    }
-                    if (OP2 & 0x1) {
-                        tcg_gen_mov_i32(cpu_R[RRR_S], addr);
-                    }
-                    tcg_temp_free(addr);
-                }
-                break;
-
-            default: /*reserved*/
-                RESERVED();
-                break;
-            }
-            break;
-
-        case 9: /*LSC4*/
-            if (!gen_window_check2(dc, RRR_S, RRR_T)) {
-                break;
-            }
-            switch (OP2) {
-            case 0: /*L32E*/
-                HAS_OPTION(XTENSA_OPTION_WINDOWED_REGISTER);
-                if (gen_check_privilege(dc) &&
-                    gen_window_check2(dc, RRR_S, RRR_T)) {
-                    TCGv_i32 addr = tcg_temp_new_i32();
-                    tcg_gen_addi_i32(addr, cpu_R[RRR_S],
-                            (0xffffffc0 | (RRR_R << 2)));
-                    tcg_gen_qemu_ld32u(cpu_R[RRR_T], addr, dc->ring);
-                    tcg_temp_free(addr);
-                }
-                break;
-
-            case 4: /*S32E*/
-                HAS_OPTION(XTENSA_OPTION_WINDOWED_REGISTER);
-                if (gen_check_privilege(dc) &&
-                    gen_window_check2(dc, RRR_S, RRR_T)) {
-                    TCGv_i32 addr = tcg_temp_new_i32();
-                    tcg_gen_addi_i32(addr, cpu_R[RRR_S],
-                            (0xffffffc0 | (RRR_R << 2)));
-                    tcg_gen_qemu_st32(cpu_R[RRR_T], addr, dc->ring);
-                    tcg_temp_free(addr);
-                }
-                break;
-
-            case 5: /*S32N*/
-                if (gen_window_check2(dc, RRI4_S, RRI4_T)) {
-                    TCGv_i32 addr = tcg_temp_new_i32();
-
-                    tcg_gen_addi_i32(addr, cpu_R[RRI4_S], RRI4_IMM4 << 2);
-                    gen_load_store_alignment(dc, 2, addr, false);
-                    tcg_gen_qemu_st32(cpu_R[RRI4_T], addr, dc->cring);
-                    tcg_temp_free(addr);
-                }
-                break;
-
-            default:
-                RESERVED();
-                break;
-            }
-            break;
-
-        case 10: /*FP0*/
-            /*DEPBITS*/
-            if (option_enabled(dc, XTENSA_OPTION_DEPBITS)) {
-                if (!gen_window_check2(dc, RRR_S, RRR_T)) {
-                    break;
-                }
-                tcg_gen_deposit_i32(cpu_R[RRR_T], cpu_R[RRR_T], cpu_R[RRR_S],
-                                    OP2, RRR_R + 1);
-                break;
-            }
-
-            HAS_OPTION(XTENSA_OPTION_FP_COPROCESSOR);
-            switch (OP2) {
-            case 0: /*ADD.Sf*/
-                if (gen_check_cpenable(dc, 0)) {
-                    gen_helper_add_s(cpu_FR[RRR_R], cpu_env,
-                                     cpu_FR[RRR_S], cpu_FR[RRR_T]);
-                }
-                break;
-
-            case 1: /*SUB.Sf*/
-                if (gen_check_cpenable(dc, 0)) {
-                    gen_helper_sub_s(cpu_FR[RRR_R], cpu_env,
-                                     cpu_FR[RRR_S], cpu_FR[RRR_T]);
-                }
-                break;
-
-            case 2: /*MUL.Sf*/
-                if (gen_check_cpenable(dc, 0)) {
-                    gen_helper_mul_s(cpu_FR[RRR_R], cpu_env,
-                                     cpu_FR[RRR_S], cpu_FR[RRR_T]);
-                }
-                break;
-
-            case 4: /*MADD.Sf*/
-                if (gen_check_cpenable(dc, 0)) {
-                    gen_helper_madd_s(cpu_FR[RRR_R], cpu_env,
-                                      cpu_FR[RRR_R], cpu_FR[RRR_S],
-                                      cpu_FR[RRR_T]);
-                }
-                break;
-
-            case 5: /*MSUB.Sf*/
-                if (gen_check_cpenable(dc, 0)) {
-                    gen_helper_msub_s(cpu_FR[RRR_R], cpu_env,
-                                      cpu_FR[RRR_R], cpu_FR[RRR_S],
-                                      cpu_FR[RRR_T]);
-                }
-                break;
-
-            case 8: /*ROUND.Sf*/
-            case 9: /*TRUNC.Sf*/
-            case 10: /*FLOOR.Sf*/
-            case 11: /*CEIL.Sf*/
-            case 14: /*UTRUNC.Sf*/
-                if (gen_window_check1(dc, RRR_R) &&
-                    gen_check_cpenable(dc, 0)) {
-                    static const unsigned rounding_mode_const[] = {
-                        float_round_nearest_even,
-                        float_round_to_zero,
-                        float_round_down,
-                        float_round_up,
-                        [6] = float_round_to_zero,
-                    };
-                    TCGv_i32 rounding_mode = tcg_const_i32(
-                            rounding_mode_const[OP2 & 7]);
-                    TCGv_i32 scale = tcg_const_i32(RRR_T);
-
-                    if (OP2 == 14) {
-                        gen_helper_ftoui(cpu_R[RRR_R], cpu_FR[RRR_S],
-                                rounding_mode, scale);
-                    } else {
-                        gen_helper_ftoi(cpu_R[RRR_R], cpu_FR[RRR_S],
-                                rounding_mode, scale);
-                    }
-
-                    tcg_temp_free(rounding_mode);
-                    tcg_temp_free(scale);
-                }
-                break;
-
-            case 12: /*FLOAT.Sf*/
-            case 13: /*UFLOAT.Sf*/
-                if (gen_window_check1(dc, RRR_S) &&
-                    gen_check_cpenable(dc, 0)) {
-                    TCGv_i32 scale = tcg_const_i32(-RRR_T);
-
-                    if (OP2 == 13) {
-                        gen_helper_uitof(cpu_FR[RRR_R], cpu_env,
-                                cpu_R[RRR_S], scale);
-                    } else {
-                        gen_helper_itof(cpu_FR[RRR_R], cpu_env,
-                                cpu_R[RRR_S], scale);
-                    }
-                    tcg_temp_free(scale);
-                }
-                break;
-
-            case 15: /*FP1OP*/
-                switch (RRR_T) {
-                case 0: /*MOV.Sf*/
-                    if (gen_check_cpenable(dc, 0)) {
-                        tcg_gen_mov_i32(cpu_FR[RRR_R], cpu_FR[RRR_S]);
-                    }
-                    break;
-
-                case 1: /*ABS.Sf*/
-                    if (gen_check_cpenable(dc, 0)) {
-                        gen_helper_abs_s(cpu_FR[RRR_R], cpu_FR[RRR_S]);
-                    }
-                    break;
-
-                case 4: /*RFRf*/
-                    if (gen_window_check1(dc, RRR_R) &&
-                        gen_check_cpenable(dc, 0)) {
-                        tcg_gen_mov_i32(cpu_R[RRR_R], cpu_FR[RRR_S]);
-                    }
-                    break;
-
-                case 5: /*WFRf*/
-                    if (gen_window_check1(dc, RRR_S) &&
-                        gen_check_cpenable(dc, 0)) {
-                        tcg_gen_mov_i32(cpu_FR[RRR_R], cpu_R[RRR_S]);
-                    }
-                    break;
-
-                case 6: /*NEG.Sf*/
-                    if (gen_check_cpenable(dc, 0)) {
-                        gen_helper_neg_s(cpu_FR[RRR_R], cpu_FR[RRR_S]);
-                    }
-                    break;
-
-                default: /*reserved*/
-                    RESERVED();
-                    break;
-                }
-                break;
-
-            default: /*reserved*/
-                RESERVED();
-                break;
-            }
-            break;
-
-        case 11: /*FP1*/
-            /*DEPBITS*/
-            if (option_enabled(dc, XTENSA_OPTION_DEPBITS)) {
-                if (!gen_window_check2(dc, RRR_S, RRR_T)) {
-                    break;
-                }
-                tcg_gen_deposit_i32(cpu_R[RRR_T], cpu_R[RRR_T], cpu_R[RRR_S],
-                                    OP2 + 16, RRR_R + 1);
-                break;
-            }
-
-            HAS_OPTION(XTENSA_OPTION_FP_COPROCESSOR);
-
-#define gen_compare(rel, br, a, b) \
-    do { \
-        if (gen_check_cpenable(dc, 0)) { \
-            TCGv_i32 bit = tcg_const_i32(1 << br); \
-            \
-            gen_helper_##rel(cpu_env, bit, cpu_FR[a], cpu_FR[b]); \
-            tcg_temp_free(bit); \
-        } \
-    } while (0)
-
-            switch (OP2) {
-            case 1: /*UN.Sf*/
-                gen_compare(un_s, RRR_R, RRR_S, RRR_T);
-                break;
-
-            case 2: /*OEQ.Sf*/
-                gen_compare(oeq_s, RRR_R, RRR_S, RRR_T);
-                break;
-
-            case 3: /*UEQ.Sf*/
-                gen_compare(ueq_s, RRR_R, RRR_S, RRR_T);
-                break;
-
-            case 4: /*OLT.Sf*/
-                gen_compare(olt_s, RRR_R, RRR_S, RRR_T);
-                break;
-
-            case 5: /*ULT.Sf*/
-                gen_compare(ult_s, RRR_R, RRR_S, RRR_T);
-                break;
-
-            case 6: /*OLE.Sf*/
-                gen_compare(ole_s, RRR_R, RRR_S, RRR_T);
-                break;
-
-            case 7: /*ULE.Sf*/
-                gen_compare(ule_s, RRR_R, RRR_S, RRR_T);
-                break;
-
-#undef gen_compare
-
-            case 8: /*MOVEQZ.Sf*/
-            case 9: /*MOVNEZ.Sf*/
-            case 10: /*MOVLTZ.Sf*/
-            case 11: /*MOVGEZ.Sf*/
-                if (gen_window_check1(dc, RRR_T) &&
-                    gen_check_cpenable(dc, 0)) {
-                    static const TCGCond cond[] = {
-                        TCG_COND_EQ,
-                        TCG_COND_NE,
-                        TCG_COND_LT,
-                        TCG_COND_GE,
-                    };
-                    TCGv_i32 zero = tcg_const_i32(0);
-
-                    tcg_gen_movcond_i32(cond[OP2 - 8], cpu_FR[RRR_R],
-                            cpu_R[RRR_T], zero, cpu_FR[RRR_S], cpu_FR[RRR_R]);
-                    tcg_temp_free(zero);
-                }
-                break;
-
-            case 12: /*MOVF.Sf*/
-            case 13: /*MOVT.Sf*/
-                HAS_OPTION(XTENSA_OPTION_BOOLEAN);
-                if (gen_check_cpenable(dc, 0)) {
-                    TCGv_i32 zero = tcg_const_i32(0);
-                    TCGv_i32 tmp = tcg_temp_new_i32();
-
-                    tcg_gen_andi_i32(tmp, cpu_SR[BR], 1 << RRR_T);
-                    tcg_gen_movcond_i32(OP2 & 1 ? TCG_COND_NE : TCG_COND_EQ,
-                            cpu_FR[RRR_R], tmp, zero,
-                            cpu_FR[RRR_S], cpu_FR[RRR_R]);
-
-                    tcg_temp_free(tmp);
-                    tcg_temp_free(zero);
-                }
-                break;
-
-            default: /*reserved*/
-                RESERVED();
-                break;
-            }
-            break;
-
-        default: /*reserved*/
-            RESERVED();
-            break;
-        }
-        break;
-
-    case 1: /*L32R*/
-        if (gen_window_check1(dc, RRR_T)) {
-            TCGv_i32 tmp = tcg_const_i32(
-                    ((dc->tb->flags & XTENSA_TBFLAG_LITBASE) ?
-                     0 : ((dc->pc + 3) & ~3)) +
-                    (0xfffc0000 | (RI16_IMM16 << 2)));
-
-            if (dc->tb->flags & XTENSA_TBFLAG_LITBASE) {
-                tcg_gen_add_i32(tmp, tmp, dc->litbase);
-            }
-            tcg_gen_qemu_ld32u(cpu_R[RRR_T], tmp, dc->cring);
-            tcg_temp_free(tmp);
-        }
-        break;
-
-    case 2: /*LSAI*/
-#define gen_load_store(type, shift) do { \
-            if (gen_window_check2(dc, RRI8_S, RRI8_T)) { \
-                TCGv_i32 addr = tcg_temp_new_i32(); \
-                \
-                tcg_gen_addi_i32(addr, cpu_R[RRI8_S], RRI8_IMM8 << shift); \
-                if (shift) { \
-                    gen_load_store_alignment(dc, shift, addr, false); \
-                } \
-                tcg_gen_qemu_##type(cpu_R[RRI8_T], addr, dc->cring); \
-                tcg_temp_free(addr); \
-            } \
-        } while (0)
-
-        switch (RRI8_R) {
-        case 0: /*L8UI*/
-            gen_load_store(ld8u, 0);
-            break;
-
-        case 1: /*L16UI*/
-            gen_load_store(ld16u, 1);
-            break;
-
-        case 2: /*L32I*/
-            gen_load_store(ld32u, 2);
-            break;
-
-        case 4: /*S8I*/
-            gen_load_store(st8, 0);
-            break;
-
-        case 5: /*S16I*/
-            gen_load_store(st16, 1);
-            break;
-
-        case 6: /*S32I*/
-            gen_load_store(st32, 2);
-            break;
-
-#define gen_dcache_hit_test(w, shift) do { \
-            if (gen_window_check1(dc, RRI##w##_S)) { \
-                TCGv_i32 addr = tcg_temp_new_i32(); \
-                TCGv_i32 res = tcg_temp_new_i32(); \
-                tcg_gen_addi_i32(addr, cpu_R[RRI##w##_S], \
-                                 RRI##w##_IMM##w << shift); \
-                tcg_gen_qemu_ld8u(res, addr, dc->cring); \
-                tcg_temp_free(addr); \
-                tcg_temp_free(res); \
-            } \
-        } while (0)
-
-#define gen_dcache_hit_test4() gen_dcache_hit_test(4, 4)
-#define gen_dcache_hit_test8() gen_dcache_hit_test(8, 2)
-
-        case 7: /*CACHEc*/
-            if (RRI8_T < 8) {
-                HAS_OPTION(XTENSA_OPTION_DCACHE);
-            }
-
-            switch (RRI8_T) {
-            case 0: /*DPFRc*/
-                gen_window_check1(dc, RRI8_S);
-                break;
-
-            case 1: /*DPFWc*/
-                gen_window_check1(dc, RRI8_S);
-                break;
-
-            case 2: /*DPFROc*/
-                gen_window_check1(dc, RRI8_S);
-                break;
-
-            case 3: /*DPFWOc*/
-                gen_window_check1(dc, RRI8_S);
-                break;
-
-            case 4: /*DHWBc*/
-                gen_dcache_hit_test8();
-                break;
-
-            case 5: /*DHWBIc*/
-                gen_dcache_hit_test8();
-                break;
-
-            case 6: /*DHIc*/
-                if (gen_check_privilege(dc)) {
-                    gen_dcache_hit_test8();
-                }
-                break;
-
-            case 7: /*DIIc*/
-                if (gen_check_privilege(dc)) {
-                    gen_window_check1(dc, RRI8_S);
-                }
-                break;
-
-            case 8: /*DCEc*/
-                switch (OP1) {
-                case 0: /*DPFLl*/
-                    HAS_OPTION(XTENSA_OPTION_DCACHE_INDEX_LOCK);
-                    if (gen_check_privilege(dc)) {
-                        gen_dcache_hit_test4();
-                    }
-                    break;
-
-                case 2: /*DHUl*/
-                    HAS_OPTION(XTENSA_OPTION_DCACHE_INDEX_LOCK);
-                    if (gen_check_privilege(dc)) {
-                        gen_dcache_hit_test4();
-                    }
-                    break;
-
-                case 3: /*DIUl*/
-                    HAS_OPTION(XTENSA_OPTION_DCACHE_INDEX_LOCK);
-                    if (gen_check_privilege(dc)) {
-                        gen_window_check1(dc, RRI4_S);
-                    }
-                    break;
-
-                case 4: /*DIWBc*/
-                    HAS_OPTION(XTENSA_OPTION_DCACHE);
-                    if (gen_check_privilege(dc)) {
-                        gen_window_check1(dc, RRI4_S);
-                    }
-                    break;
-
-                case 5: /*DIWBIc*/
-                    HAS_OPTION(XTENSA_OPTION_DCACHE);
-                    if (gen_check_privilege(dc)) {
-                        gen_window_check1(dc, RRI4_S);
-                    }
-                    break;
-
-                default: /*reserved*/
-                    RESERVED();
-                    break;
-
-                }
-                break;
-
-#undef gen_dcache_hit_test
-#undef gen_dcache_hit_test4
-#undef gen_dcache_hit_test8
-
-#define gen_icache_hit_test(w, shift) do { \
-            if (gen_window_check1(dc, RRI##w##_S)) { \
-                TCGv_i32 addr = tcg_temp_new_i32(); \
-                tcg_gen_movi_i32(cpu_pc, dc->pc); \
-                tcg_gen_addi_i32(addr, cpu_R[RRI##w##_S], \
-                                 RRI##w##_IMM##w << shift); \
-                gen_helper_itlb_hit_test(cpu_env, addr); \
-                tcg_temp_free(addr); \
-            }\
-        } while (0)
-
-#define gen_icache_hit_test4() gen_icache_hit_test(4, 4)
-#define gen_icache_hit_test8() gen_icache_hit_test(8, 2)
-
-            case 12: /*IPFc*/
-                HAS_OPTION(XTENSA_OPTION_ICACHE);
-                gen_window_check1(dc, RRI8_S);
-                break;
-
-            case 13: /*ICEc*/
-                switch (OP1) {
-                case 0: /*IPFLl*/
-                    HAS_OPTION(XTENSA_OPTION_ICACHE_INDEX_LOCK);
-                    if (gen_check_privilege(dc)) {
-                        gen_icache_hit_test4();
-                    }
-                    break;
-
-                case 2: /*IHUl*/
-                    HAS_OPTION(XTENSA_OPTION_ICACHE_INDEX_LOCK);
-                    if (gen_check_privilege(dc)) {
-                        gen_icache_hit_test4();
-                    }
-                    break;
-
-                case 3: /*IIUl*/
-                    HAS_OPTION(XTENSA_OPTION_ICACHE_INDEX_LOCK);
-                    if (gen_check_privilege(dc)) {
-                        gen_window_check1(dc, RRI4_S);
-                    }
-                    break;
-
-                default: /*reserved*/
-                    RESERVED();
-                    break;
-                }
-                break;
-
-            case 14: /*IHIc*/
-                HAS_OPTION(XTENSA_OPTION_ICACHE);
-                gen_icache_hit_test8();
-                break;
-
-            case 15: /*IIIc*/
-                HAS_OPTION(XTENSA_OPTION_ICACHE);
-                if (gen_check_privilege(dc)) {
-                    gen_window_check1(dc, RRI8_S);
-                }
-                break;
-
-            default: /*reserved*/
-                RESERVED();
-                break;
-            }
-            break;
-
-#undef gen_icache_hit_test
-#undef gen_icache_hit_test4
-#undef gen_icache_hit_test8
-
-        case 9: /*L16SI*/
-            gen_load_store(ld16s, 1);
-            break;
-#undef gen_load_store
-
-        case 10: /*MOVI*/
-            if (gen_window_check1(dc, RRI8_T)) {
-                tcg_gen_movi_i32(cpu_R[RRI8_T],
-                                 RRI8_IMM8 | (RRI8_S << 8) |
-                                 ((RRI8_S & 0x8) ? 0xfffff000 : 0));
-            }
-            break;
-
-#define gen_load_store_no_hw_align(type) do { \
-            if (gen_window_check2(dc, RRI8_S, RRI8_T)) { \
-                TCGv_i32 addr = tcg_temp_local_new_i32(); \
-                tcg_gen_addi_i32(addr, cpu_R[RRI8_S], RRI8_IMM8 << 2); \
-                gen_load_store_alignment(dc, 2, addr, true); \
-                tcg_gen_qemu_##type(cpu_R[RRI8_T], addr, dc->cring); \
-                tcg_temp_free(addr); \
-            } \
-        } while (0)
-
-        case 11: /*L32AIy*/
-            HAS_OPTION(XTENSA_OPTION_MP_SYNCHRO);
-            gen_load_store_no_hw_align(ld32u); /*TODO acquire?*/
-            break;
-
-        case 12: /*ADDI*/
-            if (gen_window_check2(dc, RRI8_S, RRI8_T)) {
-                tcg_gen_addi_i32(cpu_R[RRI8_T], cpu_R[RRI8_S], RRI8_IMM8_SE);
-            }
-            break;
-
-        case 13: /*ADDMI*/
-            if (gen_window_check2(dc, RRI8_S, RRI8_T)) {
-                tcg_gen_addi_i32(cpu_R[RRI8_T], cpu_R[RRI8_S],
-                                 RRI8_IMM8_SE << 8);
-            }
-            break;
-
-        case 14: /*S32C1Iy*/
-            HAS_OPTION(XTENSA_OPTION_CONDITIONAL_STORE);
-            if (gen_window_check2(dc, RRI8_S, RRI8_T)) {
-                TCGLabel *label = gen_new_label();
-                TCGv_i32 tmp = tcg_temp_local_new_i32();
-                TCGv_i32 addr = tcg_temp_local_new_i32();
-                TCGv_i32 tpc;
-
-                tcg_gen_mov_i32(tmp, cpu_R[RRI8_T]);
-                tcg_gen_addi_i32(addr, cpu_R[RRI8_S], RRI8_IMM8 << 2);
-                gen_load_store_alignment(dc, 2, addr, true);
-
-                tpc = tcg_const_i32(dc->pc);
-                gen_helper_check_atomctl(cpu_env, tpc, addr);
-                tcg_gen_qemu_ld32u(cpu_R[RRI8_T], addr, dc->cring);
-                tcg_gen_brcond_i32(TCG_COND_NE, cpu_R[RRI8_T],
-                        cpu_SR[SCOMPARE1], label);
-
-                tcg_gen_qemu_st32(tmp, addr, dc->cring);
-
-                gen_set_label(label);
-                tcg_temp_free(tpc);
-                tcg_temp_free(addr);
-                tcg_temp_free(tmp);
-            }
-            break;
-
-        case 15: /*S32RIy*/
-            HAS_OPTION(XTENSA_OPTION_MP_SYNCHRO);
-            gen_load_store_no_hw_align(st32); /*TODO release?*/
-            break;
-#undef gen_load_store_no_hw_align
-
-        default: /*reserved*/
-            RESERVED();
-            break;
-        }
-        break;
-
-    case 3: /*LSCIp*/
-        switch (RRI8_R) {
-        case 0: /*LSIf*/
-        case 4: /*SSIf*/
-        case 8: /*LSIUf*/
-        case 12: /*SSIUf*/
-            HAS_OPTION(XTENSA_OPTION_FP_COPROCESSOR);
-            if (gen_window_check1(dc, RRI8_S) &&
-                gen_check_cpenable(dc, 0)) {
-                TCGv_i32 addr = tcg_temp_new_i32();
-                tcg_gen_addi_i32(addr, cpu_R[RRI8_S], RRI8_IMM8 << 2);
-                gen_load_store_alignment(dc, 2, addr, false);
-                if (RRI8_R & 0x4) {
-                    tcg_gen_qemu_st32(cpu_FR[RRI8_T], addr, dc->cring);
-                } else {
-                    tcg_gen_qemu_ld32u(cpu_FR[RRI8_T], addr, dc->cring);
-                }
-                if (RRI8_R & 0x8) {
-                    tcg_gen_mov_i32(cpu_R[RRI8_S], addr);
-                }
-                tcg_temp_free(addr);
-            }
-            break;
-
-        default: /*reserved*/
-            RESERVED();
-            break;
-        }
-        break;
-
-    case 4: /*MAC16d*/
-        HAS_OPTION(XTENSA_OPTION_MAC16);
-        {
-            enum {
-                MAC16_UMUL = 0x0,
-                MAC16_MUL  = 0x4,
-                MAC16_MULA = 0x8,
-                MAC16_MULS = 0xc,
-                MAC16_NONE = 0xf,
-            } op = OP1 & 0xc;
-            bool is_m1_sr = (OP2 & 0x3) == 2;
-            bool is_m2_sr = (OP2 & 0xc) == 0;
-            uint32_t ld_offset = 0;
-
-            if (OP2 > 9) {
-                RESERVED();
-            }
-
-            switch (OP2 & 2) {
-            case 0: /*MACI?/MACC?*/
-                is_m1_sr = true;
-                ld_offset = (OP2 & 1) ? -4 : 4;
-
-                if (OP2 >= 8) { /*MACI/MACC*/
-                    if (OP1 == 0) { /*LDINC/LDDEC*/
-                        op = MAC16_NONE;
-                    } else {
-                        RESERVED();
-                    }
-                } else if (op != MAC16_MULA) { /*MULA.*.*.LDINC/LDDEC*/
-                    RESERVED();
-                }
-                break;
-
-            case 2: /*MACD?/MACA?*/
-                if (op == MAC16_UMUL && OP2 != 7) { /*UMUL only in MACAA*/
-                    RESERVED();
-                }
-                break;
-            }
-
-            if (op != MAC16_NONE) {
-                if (!is_m1_sr && !gen_window_check1(dc, RRR_S)) {
-                    break;
-                }
-                if (!is_m2_sr && !gen_window_check1(dc, RRR_T)) {
-                    break;
-                }
-            }
-
-            if (ld_offset && !gen_window_check1(dc, RRR_S)) {
-                break;
-            }
-
-            {
-                TCGv_i32 vaddr = tcg_temp_new_i32();
-                TCGv_i32 mem32 = tcg_temp_new_i32();
-
-                if (ld_offset) {
-                    tcg_gen_addi_i32(vaddr, cpu_R[RRR_S], ld_offset);
-                    gen_load_store_alignment(dc, 2, vaddr, false);
-                    tcg_gen_qemu_ld32u(mem32, vaddr, dc->cring);
-                }
-                if (op != MAC16_NONE) {
-                    TCGv_i32 m1 = gen_mac16_m(
-                            is_m1_sr ? cpu_SR[MR + RRR_X] : cpu_R[RRR_S],
-                            OP1 & 1, op == MAC16_UMUL);
-                    TCGv_i32 m2 = gen_mac16_m(
-                            is_m2_sr ? cpu_SR[MR + 2 + RRR_Y] : cpu_R[RRR_T],
-                            OP1 & 2, op == MAC16_UMUL);
-
-                    if (op == MAC16_MUL || op == MAC16_UMUL) {
-                        tcg_gen_mul_i32(cpu_SR[ACCLO], m1, m2);
-                        if (op == MAC16_UMUL) {
-                            tcg_gen_movi_i32(cpu_SR[ACCHI], 0);
-                        } else {
-                            tcg_gen_sari_i32(cpu_SR[ACCHI], cpu_SR[ACCLO], 31);
-                        }
-                    } else {
-                        TCGv_i32 lo = tcg_temp_new_i32();
-                        TCGv_i32 hi = tcg_temp_new_i32();
-
-                        tcg_gen_mul_i32(lo, m1, m2);
-                        tcg_gen_sari_i32(hi, lo, 31);
-                        if (op == MAC16_MULA) {
-                            tcg_gen_add2_i32(cpu_SR[ACCLO], cpu_SR[ACCHI],
-                                             cpu_SR[ACCLO], cpu_SR[ACCHI],
-                                             lo, hi);
-                        } else {
-                            tcg_gen_sub2_i32(cpu_SR[ACCLO], cpu_SR[ACCHI],
-                                             cpu_SR[ACCLO], cpu_SR[ACCHI],
-                                             lo, hi);
-                        }
-                        tcg_gen_ext8s_i32(cpu_SR[ACCHI], cpu_SR[ACCHI]);
-
-                        tcg_temp_free_i32(lo);
-                        tcg_temp_free_i32(hi);
-                    }
-                    tcg_temp_free(m1);
-                    tcg_temp_free(m2);
-                }
-                if (ld_offset) {
-                    tcg_gen_mov_i32(cpu_R[RRR_S], vaddr);
-                    tcg_gen_mov_i32(cpu_SR[MR + RRR_W], mem32);
-                }
-                tcg_temp_free(vaddr);
-                tcg_temp_free(mem32);
-            }
-        }
-        break;
-
-    case 5: /*CALLN*/
-        switch (CALL_N) {
-        case 0: /*CALL0*/
-            tcg_gen_movi_i32(cpu_R[0], dc->next_pc);
-            gen_jumpi(dc, (dc->pc & ~3) + (CALL_OFFSET_SE << 2) + 4, 0);
-            break;
-
-        case 1: /*CALL4w*/
-        case 2: /*CALL8w*/
-        case 3: /*CALL12w*/
-            HAS_OPTION(XTENSA_OPTION_WINDOWED_REGISTER);
-            if (gen_window_check1(dc, CALL_N << 2)) {
-                gen_callwi(dc, CALL_N,
-                           (dc->pc & ~3) + (CALL_OFFSET_SE << 2) + 4, 0);
-            }
-            break;
+    dc->next_pc = dc->pc + len;
+    for (i = 1; i < len; ++i) {
+        b[i] = cpu_ldub_code(env, dc->pc + i);
+    }
+    xtensa_insnbuf_from_chars(isa, dc->insnbuf, b, len);
+    fmt = xtensa_format_decode(isa, dc->insnbuf);
+    if (fmt == XTENSA_UNDEFINED) {
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "unrecognized instruction format (pc = %08x)\n",
+                      dc->pc);
+        gen_exception_cause(dc, ILLEGAL_INSTRUCTION_CAUSE);
+        return;
+    }
+    slots = xtensa_format_num_slots(isa, fmt);
+    for (slot = 0; slot < slots; ++slot) {
+        xtensa_opcode opc;
+        unsigned opnd, vopnd, opnds;
+        uint32_t raw_arg[MAX_OPCODE_ARGS];
+        uint32_t arg[MAX_OPCODE_ARGS];
+        XtensaOpcodeOps *ops;
+
+        dc->raw_arg = raw_arg;
+
+        xtensa_format_get_slot(isa, fmt, slot, dc->insnbuf, dc->slotbuf);
+        opc = xtensa_opcode_decode(isa, fmt, slot, dc->slotbuf);
+        if (opc == XTENSA_UNDEFINED) {
+            qemu_log_mask(LOG_GUEST_ERROR,
+                          "unrecognized opcode in slot %d (pc = %08x)\n",
+                          slot, dc->pc);
+            gen_exception_cause(dc, ILLEGAL_INSTRUCTION_CAUSE);
+            return;
         }
-        break;
-
-    case 6: /*SI*/
-        switch (CALL_N) {
-        case 0: /*J*/
-            gen_jumpi(dc, dc->pc + 4 + CALL_OFFSET_SE, 0);
-            break;
-
-        case 1: /*BZ*/
-            if (gen_window_check1(dc, BRI12_S)) {
-                static const TCGCond cond[] = {
-                    TCG_COND_EQ, /*BEQZ*/
-                    TCG_COND_NE, /*BNEZ*/
-                    TCG_COND_LT, /*BLTZ*/
-                    TCG_COND_GE, /*BGEZ*/
-                };
-
-                gen_brcondi(dc, cond[BRI12_M & 3], cpu_R[BRI12_S], 0,
-                        4 + BRI12_IMM12_SE);
-            }
-            break;
-
-        case 2: /*BI0*/
-            if (gen_window_check1(dc, BRI8_S)) {
-                static const TCGCond cond[] = {
-                    TCG_COND_EQ, /*BEQI*/
-                    TCG_COND_NE, /*BNEI*/
-                    TCG_COND_LT, /*BLTI*/
-                    TCG_COND_GE, /*BGEI*/
-                };
-
-                gen_brcondi(dc, cond[BRI8_M & 3],
-                        cpu_R[BRI8_S], B4CONST[BRI8_R], 4 + BRI8_IMM8_SE);
-            }
-            break;
-
-        case 3: /*BI1*/
-            switch (BRI8_M) {
-            case 0: /*ENTRYw*/
-                HAS_OPTION(XTENSA_OPTION_WINDOWED_REGISTER);
-                {
-                    TCGv_i32 pc = tcg_const_i32(dc->pc);
-                    TCGv_i32 s = tcg_const_i32(BRI12_S);
-                    TCGv_i32 imm = tcg_const_i32(BRI12_IMM12 << 3);
-                    gen_helper_entry(cpu_env, pc, s, imm);
-                    tcg_temp_free(imm);
-                    tcg_temp_free(s);
-                    tcg_temp_free(pc);
-                    /* This can change tb->flags, so exit tb */
-                    gen_jumpi_check_loop_end(dc, -1);
-                }
-                break;
-
-            case 1: /*B1*/
-                switch (BRI8_R) {
-                case 0: /*BFp*/
-                case 1: /*BTp*/
-                    HAS_OPTION(XTENSA_OPTION_BOOLEAN);
-                    {
-                        TCGv_i32 tmp = tcg_temp_new_i32();
-                        tcg_gen_andi_i32(tmp, cpu_SR[BR], 1 << RRI8_S);
-                        gen_brcondi(dc,
-                                BRI8_R == 1 ? TCG_COND_NE : TCG_COND_EQ,
-                                tmp, 0, 4 + RRI8_IMM8_SE);
-                        tcg_temp_free(tmp);
-                    }
-                    break;
-
-                case 8: /*LOOP*/
-                case 9: /*LOOPNEZ*/
-                case 10: /*LOOPGTZ*/
-                    HAS_OPTION(XTENSA_OPTION_LOOP);
-                    if (gen_window_check1(dc, RRI8_S)) {
-                        uint32_t lend = dc->pc + RRI8_IMM8 + 4;
-                        TCGv_i32 tmp = tcg_const_i32(lend);
-
-                        tcg_gen_subi_i32(cpu_SR[LCOUNT], cpu_R[RRI8_S], 1);
-                        tcg_gen_movi_i32(cpu_SR[LBEG], dc->next_pc);
-                        gen_helper_wsr_lend(cpu_env, tmp);
-                        tcg_temp_free(tmp);
-
-                        if (BRI8_R > 8) {
-                            TCGLabel *label = gen_new_label();
-                            tcg_gen_brcondi_i32(
-                                    BRI8_R == 9 ? TCG_COND_NE : TCG_COND_GT,
-                                    cpu_R[RRI8_S], 0, label);
-                            gen_jumpi(dc, lend, 1);
-                            gen_set_label(label);
-                        }
-
-                        gen_jumpi(dc, dc->next_pc, 0);
-                    }
-                    break;
-
-                default: /*reserved*/
-                    RESERVED();
-                    break;
-
-                }
-                break;
-
-            case 2: /*BLTUI*/
-            case 3: /*BGEUI*/
-                if (gen_window_check1(dc, BRI8_S)) {
-                    gen_brcondi(dc, BRI8_M == 2 ? TCG_COND_LTU : TCG_COND_GEU,
-                                cpu_R[BRI8_S], B4CONSTU[BRI8_R],
-                                4 + BRI8_IMM8_SE);
+        opnds = xtensa_opcode_num_operands(isa, opc);
+
+        for (opnd = vopnd = 0; opnd < opnds; ++opnd) {
+            if (xtensa_operand_is_visible(isa, opc, opnd)) {
+                uint32_t v;
+
+                xtensa_operand_get_field(isa, opc, opnd, fmt, slot,
+                                         dc->slotbuf, &v);
+                xtensa_operand_decode(isa, opc, opnd, &v);
+                raw_arg[vopnd] = v;
+                if (xtensa_operand_is_PCrelative(isa, opc, opnd)) {
+                    xtensa_operand_undo_reloc(isa, opc, opnd, &v, dc->pc);
                 }
-                break;
+                arg[vopnd] = v;
+                ++vopnd;
             }
-            break;
-
         }
-        break;
-
-    case 7: /*B*/
-        {
-            TCGCond eq_ne = (RRI8_R & 8) ? TCG_COND_NE : TCG_COND_EQ;
-
-            switch (RRI8_R & 7) {
-            case 0: /*BNONE*/ /*BANY*/
-                if (gen_window_check2(dc, RRI8_S, RRI8_T)) {
-                    TCGv_i32 tmp = tcg_temp_new_i32();
-                    tcg_gen_and_i32(tmp, cpu_R[RRI8_S], cpu_R[RRI8_T]);
-                    gen_brcondi(dc, eq_ne, tmp, 0, 4 + RRI8_IMM8_SE);
-                    tcg_temp_free(tmp);
-                }
-                break;
-
-            case 1: /*BEQ*/ /*BNE*/
-            case 2: /*BLT*/ /*BGE*/
-            case 3: /*BLTU*/ /*BGEU*/
-                if (gen_window_check2(dc, RRI8_S, RRI8_T)) {
-                    static const TCGCond cond[] = {
-                        [1] = TCG_COND_EQ,
-                        [2] = TCG_COND_LT,
-                        [3] = TCG_COND_LTU,
-                        [9] = TCG_COND_NE,
-                        [10] = TCG_COND_GE,
-                        [11] = TCG_COND_GEU,
-                    };
-                    gen_brcond(dc, cond[RRI8_R], cpu_R[RRI8_S], cpu_R[RRI8_T],
-                            4 + RRI8_IMM8_SE);
-                }
-                break;
-
-            case 4: /*BALL*/ /*BNALL*/
-                if (gen_window_check2(dc, RRI8_S, RRI8_T)) {
-                    TCGv_i32 tmp = tcg_temp_new_i32();
-                    tcg_gen_and_i32(tmp, cpu_R[RRI8_S], cpu_R[RRI8_T]);
-                    gen_brcond(dc, eq_ne, tmp, cpu_R[RRI8_T],
-                            4 + RRI8_IMM8_SE);
-                    tcg_temp_free(tmp);
-                }
-                break;
-
-            case 5: /*BBC*/ /*BBS*/
-                if (gen_window_check2(dc, RRI8_S, RRI8_T)) {
-#ifdef TARGET_WORDS_BIGENDIAN
-                    TCGv_i32 bit = tcg_const_i32(0x80000000);
-#else
-                    TCGv_i32 bit = tcg_const_i32(0x00000001);
-#endif
-                    TCGv_i32 tmp = tcg_temp_new_i32();
-                    tcg_gen_andi_i32(tmp, cpu_R[RRI8_T], 0x1f);
-#ifdef TARGET_WORDS_BIGENDIAN
-                    tcg_gen_shr_i32(bit, bit, tmp);
-#else
-                    tcg_gen_shl_i32(bit, bit, tmp);
-#endif
-                    tcg_gen_and_i32(tmp, cpu_R[RRI8_S], bit);
-                    gen_brcondi(dc, eq_ne, tmp, 0, 4 + RRI8_IMM8_SE);
-                    tcg_temp_free(tmp);
-                    tcg_temp_free(bit);
-                }
-                break;
-
-            case 6: /*BBCI*/ /*BBSI*/
-            case 7:
-                if (gen_window_check1(dc, RRI8_S)) {
-                    TCGv_i32 tmp = tcg_temp_new_i32();
-                    tcg_gen_andi_i32(tmp, cpu_R[RRI8_S],
-#ifdef TARGET_WORDS_BIGENDIAN
-                            0x80000000 >> (((RRI8_R & 1) << 4) | RRI8_T));
-#else
-                            0x00000001 << (((RRI8_R & 1) << 4) | RRI8_T));
-#endif
-                    gen_brcondi(dc, eq_ne, tmp, 0, 4 + RRI8_IMM8_SE);
-                    tcg_temp_free(tmp);
-                }
-                break;
-
-            }
-        }
-        break;
-
-#define gen_narrow_load_store(type) do { \
-            if (gen_window_check2(dc, RRRN_S, RRRN_T)) { \
-                TCGv_i32 addr = tcg_temp_new_i32(); \
-                tcg_gen_addi_i32(addr, cpu_R[RRRN_S], RRRN_R << 2); \
-                gen_load_store_alignment(dc, 2, addr, false); \
-                tcg_gen_qemu_##type(cpu_R[RRRN_T], addr, dc->cring); \
-                tcg_temp_free(addr); \
-            } \
-        } while (0)
-
-    case 8: /*L32I.Nn*/
-        gen_narrow_load_store(ld32u);
-        break;
-
-    case 9: /*S32I.Nn*/
-        gen_narrow_load_store(st32);
-        break;
-#undef gen_narrow_load_store
-
-    case 10: /*ADD.Nn*/
-        if (gen_window_check3(dc, RRRN_R, RRRN_S, RRRN_T)) {
-            tcg_gen_add_i32(cpu_R[RRRN_R], cpu_R[RRRN_S], cpu_R[RRRN_T]);
-        }
-        break;
-
-    case 11: /*ADDI.Nn*/
-        if (gen_window_check2(dc, RRRN_R, RRRN_S)) {
-            tcg_gen_addi_i32(cpu_R[RRRN_R], cpu_R[RRRN_S],
-                             RRRN_T ? RRRN_T : -1);
-        }
-        break;
-
-    case 12: /*ST2n*/
-        if (!gen_window_check1(dc, RRRN_S)) {
-            break;
-        }
-        if (RRRN_T < 8) { /*MOVI.Nn*/
-            tcg_gen_movi_i32(cpu_R[RRRN_S],
-                    RRRN_R | (RRRN_T << 4) |
-                    ((RRRN_T & 6) == 6 ? 0xffffff80 : 0));
-        } else { /*BEQZ.Nn*/ /*BNEZ.Nn*/
-            TCGCond eq_ne = (RRRN_T & 4) ? TCG_COND_NE : TCG_COND_EQ;
-
-            gen_brcondi(dc, eq_ne, cpu_R[RRRN_S], 0,
-                    4 + (RRRN_R | ((RRRN_T & 3) << 4)));
-        }
-        break;
-
-    case 13: /*ST3n*/
-        switch (RRRN_R) {
-        case 0: /*MOV.Nn*/
-            if (gen_window_check2(dc, RRRN_S, RRRN_T)) {
-                tcg_gen_mov_i32(cpu_R[RRRN_T], cpu_R[RRRN_S]);
-            }
-            break;
-
-        case 15: /*S3*/
-            switch (RRRN_T) {
-            case 0: /*RET.Nn*/
-                gen_jump(dc, cpu_R[0]);
-                break;
-
-            case 1: /*RETW.Nn*/
-                HAS_OPTION(XTENSA_OPTION_WINDOWED_REGISTER);
-                {
-                    TCGv_i32 tmp = tcg_const_i32(dc->pc);
-                    gen_helper_retw(tmp, cpu_env, tmp);
-                    gen_jump(dc, tmp);
-                    tcg_temp_free(tmp);
-                }
-                break;
-
-            case 2: /*BREAK.Nn*/
-                HAS_OPTION(XTENSA_OPTION_DEBUG);
-                if (dc->debug) {
-                    gen_debug_exception(dc, DEBUGCAUSE_BN);
-                }
-                break;
-
-            case 3: /*NOP.Nn*/
-                break;
-
-            case 6: /*ILL.Nn*/
-                gen_exception_cause(dc, ILLEGAL_INSTRUCTION_CAUSE);
-                break;
-
-            default: /*reserved*/
-                RESERVED();
-                break;
-            }
-            break;
-
-        default: /*reserved*/
-            RESERVED();
-            break;
+        ops = dc->config->opcode_ops[opc];
+        if (ops) {
+            ops->translate(dc, arg, ops->par);
+        } else {
+            qemu_log_mask(LOG_GUEST_ERROR,
+                          "unimplemented opcode '%s' in slot %d (pc = %08x)\n",
+                          xtensa_opcode_name(isa, opc), slot, dc->pc);
+            gen_exception_cause(dc, ILLEGAL_INSTRUCTION_CAUSE);
+            return;
         }
-        break;
-
-    default: /*reserved*/
-        RESERVED();
-        break;
     }
-
     if (dc->is_jmp == DISAS_NEXT) {
         gen_check_loop_end(dc, 0);
     }
     dc->pc = dc->next_pc;
-
-    return;
-
-invalid_opcode:
-    qemu_log_mask(LOG_GUEST_ERROR, "INVALID(pc = %08x)\n", dc->pc);
-    gen_exception_cause(dc, ILLEGAL_INSTRUCTION_CAUSE);
-#undef HAS_OPTION
 }
 
 static inline unsigned xtensa_insn_len(CPUXtensaState *env, DisasContext *dc)
 {
     uint8_t b0 = cpu_ldub_code(env, dc->pc);
-    return xtensa_op0_insn_len(OP0);
+    return xtensa_op0_insn_len(dc, b0);
 }
 
 static void gen_ibreak_check(CPUXtensaState *env, DisasContext *dc)
@@ -3153,6 +1084,11 @@ void gen_intermediate_code(CPUState *cs, TranslationBlock *tb)
     dc.window = ((tb->flags & XTENSA_TBFLAG_WINDOW_MASK) >>
                  XTENSA_TBFLAG_WINDOW_SHIFT);
 
+    if (dc.config->isa) {
+        dc.insnbuf = xtensa_insnbuf_alloc(dc.config->isa);
+        dc.slotbuf = xtensa_insnbuf_alloc(dc.config->isa);
+    }
+
     init_litbase(&dc);
     init_sar_tracker(&dc);
     if (dc.icount) {
@@ -3233,6 +1169,10 @@ done:
     if (dc.icount) {
         tcg_temp_free(dc.next_icount);
     }
+    if (dc.config->isa) {
+        xtensa_insnbuf_free(dc.config->isa, dc.insnbuf);
+        xtensa_insnbuf_free(dc.config->isa, dc.slotbuf);
+    }
 
     if (tb_cflags(tb) & CF_LAST_IO) {
         gen_io_end();
-- 
2.1.4
