Received: from eggs.gnu.org ([209.51.188.92]:49488)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ysato@users.sourceforge.jp>) id 1gzy4S-0002vM-II
	for qemu-devel@nongnu.org; Sat, 02 Mar 2019 01:24:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ysato@users.sourceforge.jp>) id 1gzy25-0002xl-5o
	for qemu-devel@nongnu.org; Sat, 02 Mar 2019 01:22:04 -0500
Received: from mail03.asahi-net.or.jp ([202.224.55.15]:37172)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ysato@users.sourceforge.jp>) id 1gzy23-0002tU-4V
	for qemu-devel@nongnu.org; Sat, 02 Mar 2019 01:22:00 -0500
From: Yoshinori Sato <ysato@users.sourceforge.jp>
Date: Sat,  2 Mar 2019 15:21:29 +0900
Message-Id: <20190302062138.10713-3-ysato@users.sourceforge.jp>
In-Reply-To: <20190302062138.10713-1-ysato@users.sourceforge.jp>
References: <20190122121413.31437-1-ysato@users.sourceforge.jp>
	<20190302062138.10713-1-ysato@users.sourceforge.jp>
Subject: [Qemu-devel] [PATCH RFC v3 02/11] target/rx: TCG helper
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>, peter.maydell@linaro.org, richard.henderson@linaro.org

Signed-off-by: Yoshinori Sato <ysato@users.sourceforge.jp>
---
 target/rx/helper.c    | 252 +++++++++++++++++++++
 target/rx/helper.h    |  39 ++++
 target/rx/op_helper.c | 602 ++++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 893 insertions(+)
 create mode 100644 target/rx/helper.c
 create mode 100644 target/rx/helper.h
 create mode 100644 target/rx/op_helper.c

diff --git a/target/rx/helper.c b/target/rx/helper.c
new file mode 100644
index 0000000000..9b0d0eacb4
--- /dev/null
+++ b/target/rx/helper.c
@@ -0,0 +1,252 @@
+/*
+ *  RX emulation
+ *
+ *  Copyright (c) 2019 Yoshinori Sato
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms and conditions of the GNU General Public License,
+ * version 2 or later, as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope it will be useful, but WITHOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
+ * more details.
+ *
+ * You should have received a copy of the GNU General Public License along with
+ * this program.  If not, see <http://www.gnu.org/licenses/>.
+ */
+
+#include "qemu/osdep.h"
+
+#include "cpu.h"
+#include "exec/log.h"
+#include "exec/cpu_ldst.h"
+#include "sysemu/sysemu.h"
+
+uint32_t update_psw_o(CPURXState *env)
+{
+    int o;
+
+    switch (env->psw_op) {
+    case RX_PSW_OP_NONE:
+        return env->psw_o;
+    case RX_PSW_OP_ADD: {
+        uint32_t r1, r2;
+        r1 = ~(env->psw_v[0] ^ env->psw_v[1]);
+        r2 = (env->psw_v[0] ^ env->psw_v[2]);
+        o = (r1 & r2) >> 31;
+        break;
+    }
+    case RX_PSW_OP_SUB: {
+        uint32_t r1, r2;
+        r1 = (env->psw_v[0] ^ env->psw_v[1]);
+        r2 = (env->psw_v[0] ^ env->psw_v[2]);
+        o = (r1 & r2) >> 31;
+        break;
+    }
+    case RX_PSW_OP_SHLL: {
+        uint32_t m, v;
+        m = (1 << env->psw_v[1]) - 1;
+        v = env->psw_v[0] >> (32 - env->psw_v[1]);
+        o = (v == 0) || (v == m);
+        break;
+    }
+    default:
+        g_assert_not_reached();
+        return -1;
+    }
+    env->psw_o = o;
+    env->psw_op = RX_PSW_OP_NONE;
+    return o;
+}
+
+uint32_t rx_get_psw_low(CPURXState *env)
+{
+    return (update_psw_o(env) << 3) |
+        (env->psw_s << 2) |
+        (env->psw_z << 1) |
+        (env->psw_c << 0);
+}
+
+uint32_t psw_cond(CPURXState *env, uint32_t cond)
+{
+    uint32_t c, z, s, o;
+
+    switch (cond) {
+    case 0: /* z */
+        return env->psw_z != 0;
+    case 1: /* nz */
+        return env->psw_z == 0;
+    case 2: /* c */
+        return env->psw_c != 0;
+    case 3: /* nc */
+        return env->psw_c == 0;
+    case 4: /* gtu (C&^Z) == 1 */
+    case 5: /* leu (C&^Z) == 0 */
+        c = env->psw_c != 0;
+        z = env->psw_z != 0;
+        return (c && !z) == (5 - cond);
+    case 6: /* pz (S == 0) */
+        return env->psw_s == 0;
+    case 7: /* n (S == 1) */
+        return env->psw_s != 0;
+    case 8: /* ge (S^O)==0 */
+    case 9: /* lt (S^O)==1 */
+        s = env->psw_s != 0;
+        o = update_psw_o(env);
+        return (s | o) == (cond - 8);
+    case 10: /* gt ((S^O)|Z)==0 */
+    case 11: /* le ((S^O)|Z)==1 */
+        s = env->psw_s != 0;
+        o = update_psw_o(env);
+        z = env->psw_z != 0;
+        return ((s ^ o) | z) == (cond - 10);
+    case 12: /* o */
+        return update_psw_o(env) != 0;
+    case 13: /* no */
+        return update_psw_o(env) == 0;
+    case 14: /* always true */
+        return 1;
+    case 15:
+        return 0;
+    default:
+        g_assert_not_reached();
+        return -1;
+    }
+}
+
+void rx_cpu_unpack_psw(CPURXState *env, int all)
+{
+    if (env->psw_pm == 0) {
+        env->psw_ipl = (env->psw >> 24) & 15;
+        if (all) {
+            env->psw_pm = (env->psw >> 20) & 1;
+        }
+        env->psw_u =  (env->psw >> 17) & 1;
+        env->psw_i =  (env->psw >> 16) & 1;
+    }
+    env->psw_o =  (env->psw >> 3) & 1;
+    env->psw_s =  (env->psw >> 2) & 1;
+    env->psw_z =  (env->psw >> 1) & 1;
+    env->psw_c =  (env->psw >> 0) & 1;
+    env->psw_op = RX_PSW_OP_NONE;
+}
+
+void rx_cpu_do_interrupt(CPUState *cs)
+{
+    RXCPU *cpu = RXCPU(cs);
+    CPURXState *env = &cpu->env;
+    int do_irq = cs->interrupt_request &
+        (CPU_INTERRUPT_HARD | CPU_INTERRUPT_SOFT | CPU_INTERRUPT_FIR);
+    int irq_vector = -1;
+
+    env->in_sleep = 0;
+
+    if (do_irq & CPU_INTERRUPT_HARD) {
+        irq_vector = env->irq;
+        cs->interrupt_request &= ~CPU_INTERRUPT_HARD;
+    }
+    if (irq_vector == -1 && do_irq & CPU_INTERRUPT_SOFT) {
+        irq_vector = env->sirq;
+        cs->interrupt_request &= ~CPU_INTERRUPT_SOFT;
+    }
+
+    if (qemu_loglevel_mask(CPU_LOG_INT)) {
+        if (cs->exception_index < 0x100) {
+            const char *expname;
+            switch (cs->exception_index) {
+            case 20:
+                expname = "previlage_violation";
+                break;
+            case 21:
+                expname = "access_exception";
+                break;
+            case 23:
+                expname = "illegal_instruction";
+                break;
+            case 25:
+                expname = "fpu_exception";
+                break;
+            case 30:
+                expname = "NMI_interrupt";
+                break;
+            }
+            qemu_log("exception 0x%02x [%s] raised\n",
+                     cs->exception_index, expname);
+        } else {
+            if (do_irq & CPU_INTERRUPT_FIR)
+                qemu_log("fast interrupt raised\n");
+            else
+                qemu_log("interrupt 0x%02x raised\n",
+                         irq_vector);
+        }
+        log_cpu_state(cs, 0);
+    }
+    if (env->psw_u) {
+        env->usp = env->regs[0];
+    } else {
+        env->isp = env->regs[0];
+    }
+    update_psw_o(env);
+    env->psw = pack_psw(env);
+    if ((do_irq & CPU_INTERRUPT_FIR) == 0) {
+        env->isp -= 4;
+        cpu_stl_all(env, env->isp, env->psw);
+        env->isp -= 4;
+        cpu_stl_all(env, env->isp, env->pc);
+    } else {
+        env->bpc = env->pc;
+        env->bpsw = env->psw;
+    }
+    env->psw_pm = env->psw_i = env->psw_u = 0;
+    env->regs[0] = env->isp;
+    if (do_irq) {
+        if (do_irq & CPU_INTERRUPT_FIR) {
+            env->pc = env->fintv;
+            env->psw_ipl = 15;
+            cs->interrupt_request &= ~CPU_INTERRUPT_FIR;
+            qemu_set_irq(env->ack, 0);
+            return;
+        } else if (do_irq & CPU_INTERRUPT_HARD) {
+            env->psw_ipl = env->intlevel;
+            qemu_set_irq(env->ack, 0);
+        }
+        env->pc = cpu_ldl_all(env, env->intb + irq_vector * 4);
+        return;
+    } else {
+        uint32_t vec = cs->exception_index;
+        env->pc = cpu_ldl_all(env, 0xffffffc0 + vec * 4);
+        return;
+    }
+}
+
+bool rx_cpu_exec_interrupt(CPUState *cs, int interrupt_request)
+{
+    RXCPU *cpu = RXCPU(cs);
+    CPURXState *env = &cpu->env;
+    int accept = 0;
+    /* software interrupt */
+    if (interrupt_request & CPU_INTERRUPT_SOFT) {
+        accept = 1;
+    }
+    /* hardware interrupt (Normal) */
+    if ((interrupt_request & CPU_INTERRUPT_HARD) &&
+        env->psw_i && (env->psw_ipl < env->intlevel)) {
+        accept = 1;
+    }
+    /* hardware interrupt (FIR) */
+    if ((interrupt_request & CPU_INTERRUPT_FIR) &&
+        env->psw_i && (env->psw_ipl < 15)) {
+        accept = 1;
+    }
+    if (accept) {
+        rx_cpu_do_interrupt(cs);
+        return true;
+    }
+    return false;
+}
+
+hwaddr rx_cpu_get_phys_page_debug(CPUState *cs, vaddr addr)
+{
+    return addr;
+}
diff --git a/target/rx/helper.h b/target/rx/helper.h
new file mode 100644
index 0000000000..06a3d29486
--- /dev/null
+++ b/target/rx/helper.h
@@ -0,0 +1,39 @@
+DEF_HELPER_1(raise_illegal_instruction, noreturn, env)
+DEF_HELPER_1(raise_access_fault, noreturn, env)
+DEF_HELPER_1(raise_privilege_violation, noreturn, env)
+DEF_HELPER_1(wait, noreturn, env)
+DEF_HELPER_1(debug, noreturn, env)
+DEF_HELPER_2(rxint, noreturn, env, i32)
+DEF_HELPER_1(rxbrk, noreturn, env)
+DEF_HELPER_FLAGS_3(fadd, TCG_CALL_NO_WG, f32, env, f32, f32)
+DEF_HELPER_FLAGS_3(fsub, TCG_CALL_NO_WG, f32, env, f32, f32)
+DEF_HELPER_FLAGS_3(fmul, TCG_CALL_NO_WG, f32, env, f32, f32)
+DEF_HELPER_FLAGS_3(fdiv, TCG_CALL_NO_WG, f32, env, f32, f32)
+DEF_HELPER_FLAGS_3(fcmp, TCG_CALL_NO_WG, void, env, f32, f32)
+DEF_HELPER_FLAGS_2(ftoi, TCG_CALL_NO_WG, i32, env, f32)
+DEF_HELPER_FLAGS_2(round, TCG_CALL_NO_WG, i32, env, f32)
+DEF_HELPER_FLAGS_2(itof, TCG_CALL_NO_WG, f32, env, i32)
+DEF_HELPER_FLAGS_2(racw, TCG_CALL_NO_WG, void, env, i32)
+DEF_HELPER_1(psw_o, i32, env)
+DEF_HELPER_3(mvtc, void, env, i32, i32)
+DEF_HELPER_2(mvfc, i32, env, i32)
+DEF_HELPER_FLAGS_2(sccond, TCG_CALL_NO_WG, i32, env, i32)
+DEF_HELPER_FLAGS_4(brcond, TCG_CALL_NO_WG, i32, env, i32, i32, i32)
+DEF_HELPER_FLAGS_4(bmcond, TCG_CALL_NO_WG, i32, env, i32, i32, i32)
+DEF_HELPER_1(unpack_psw, void, env)
+DEF_HELPER_FLAGS_3(div, TCG_CALL_NO_WG, i32, env, i32, i32)
+DEF_HELPER_FLAGS_3(divu, TCG_CALL_NO_WG, i32, env, i32, i32)
+DEF_HELPER_FLAGS_1(scmpu, TCG_CALL_NO_WG, void, env)
+DEF_HELPER_1(smovu, void, env)
+DEF_HELPER_1(smovf, void, env)
+DEF_HELPER_1(smovb, void, env)
+DEF_HELPER_2(sstr, void, env, i32)
+DEF_HELPER_FLAGS_2(swhile, TCG_CALL_NO_WG, void, env, i32)
+DEF_HELPER_FLAGS_2(suntil, TCG_CALL_NO_WG, void, env, i32)
+DEF_HELPER_FLAGS_2(rmpa, TCG_CALL_NO_WG, void, env, i32)
+DEF_HELPER_2(mulhi, void, env, i32)
+DEF_HELPER_2(mullo, void, env, i32)
+DEF_HELPER_2(machi, void, env, i32)
+DEF_HELPER_2(maclo, void, env, i32)
+DEF_HELPER_2(sat, void, env, i32)
+DEF_HELPER_1(satr, void, env)
diff --git a/target/rx/op_helper.c b/target/rx/op_helper.c
new file mode 100644
index 0000000000..572e0df45e
--- /dev/null
+++ b/target/rx/op_helper.c
@@ -0,0 +1,602 @@
+/*
+ *  RX helper functions
+ *
+ *  Copyright (c) 2019 Yoshinori Sato
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms and conditions of the GNU General Public License,
+ * version 2 or later, as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope it will be useful, but WITHOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
+ * more details.
+ *
+ * You should have received a copy of the GNU General Public License along with
+ * this program.  If not, see <http://www.gnu.org/licenses/>.
+ */
+
+#include "qemu/osdep.h"
+
+#include "cpu.h"
+#include "exec/exec-all.h"
+#include "exec/helper-proto.h"
+#include "exec/cpu_ldst.h"
+#include "fpu/softfloat.h"
+
+#define OP_SMOVU 1
+#define OP_SMOVF 0
+#define OP_SMOVB 2
+
+#define OP_SWHILE 0
+#define OP_SUNTIL 4
+
+static void set_fpmode(CPURXState *env, uint32_t val);
+static inline void QEMU_NORETURN raise_exception(CPURXState *env, int index,
+                                                 uintptr_t retaddr);
+
+/* psw operations */
+uint32_t helper_psw_o(CPURXState *env)
+{
+    return update_psw_o(env);
+}
+
+uint32_t helper_brcond(CPURXState *env, uint32_t cond, uint32_t t, uint32_t f)
+{
+    return psw_cond(env, cond) ? t : f;
+}
+
+uint32_t helper_sccond(CPURXState *env, uint32_t cond)
+{
+    return psw_cond(env, cond);
+}
+
+uint32_t helper_bmcond(CPURXState *env, uint32_t src,
+                       uint32_t bit, uint32_t cond)
+{
+    uint32_t mask = 1 << bit;
+    if (psw_cond(env, cond)) {
+        return src |= mask;
+    } else {
+        return src &= ~mask;
+    }
+}
+
+uint32_t helper_mvfc(CPURXState *env, uint32_t cr)
+{
+    switch (cr) {
+    case 0:
+        update_psw_o(env);
+        return pack_psw(env);
+    case 2:
+        return env->psw_u ? env->regs[0] : env->usp;
+    case 3:
+        return env->fpsw;
+    case 8:
+        return env->bpsw;
+    case 9:
+        return env->bpc;
+    case 10:
+        return env->psw_u ? env->isp : env->regs[0];
+    case 11:
+        return env->fintv;
+    case 12:
+        return env->intb;
+    default:
+        g_assert_not_reached();
+        return -1;
+    }
+}
+
+void helper_mvtc(CPURXState *env, uint32_t cr, uint32_t val)
+{
+    switch (cr) {
+    case 0:
+        env->psw = val;
+        rx_cpu_unpack_psw(env, 0);
+        break;
+    case 2:
+        env->usp = val;;
+        if (env->psw_u) {
+            env->regs[0] = val;
+        }
+        break;
+    case 3:
+        env->fpsw = val;
+        set_fpmode(env, val);
+        break;
+    case 8:
+        env->bpsw = val;
+        break;
+    case 9:
+        env->bpc = val;
+        break;
+    case 10:
+        env->isp = val;
+        if (!env->psw_u) {
+            env->regs[0] = val;
+        }
+        break;
+    case 11:
+        env->fintv = val;
+        break;
+    case 12:
+        env->intb = val;
+        break;
+    default:
+        g_assert_not_reached();
+    }
+}
+
+void helper_unpack_psw(CPURXState *env)
+{
+    uint32_t prev_u;
+    prev_u = env->psw_u;
+    rx_cpu_unpack_psw(env, 1);
+    if (prev_u != env->psw_u) {
+        if (env->psw_u) {
+            env->isp = env->regs[0];
+            env->regs[0] = env->usp;
+        } else {
+            env->usp = env->regs[0];
+            env->regs[0] = env->isp;
+        }
+    }
+}
+
+/* fp operations */
+static void update_fpsw(CPURXState *env, float32 ret, uintptr_t retaddr)
+{
+    int xcpt, cause, enable;
+
+    env->psw_z = (*((uint32_t *)&ret) == 0); \
+    env->psw_s = (*((uint32_t *)&ret) >= 0x80000000UL); \
+
+    xcpt = get_float_exception_flags(&env->fp_status);
+
+    /* Clear the cause entries */
+    env->fpsw &= ~FPSW_CAUSE_MASK;
+
+    if (unlikely(xcpt)) {
+        if (xcpt & float_flag_invalid) {
+            env->fpsw |= FPSW_CAUSE_V;
+        }
+        if (xcpt & float_flag_divbyzero) {
+            env->fpsw |= FPSW_CAUSE_Z;
+        }
+        if (xcpt & float_flag_overflow) {
+            env->fpsw |= FPSW_CAUSE_O;
+        }
+        if (xcpt & float_flag_underflow) {
+            env->fpsw |= FPSW_CAUSE_U;
+        }
+        if (xcpt & float_flag_inexact) {
+            env->fpsw |= FPSW_CAUSE_X;
+        }
+
+        /* Accumulate in flag entries */
+        env->fpsw |= (env->fpsw & FPSW_CAUSE_MASK)
+                      << (FPSW_FLAG_SHIFT - FPSW_CAUSE_SHIFT);
+        env->fpsw |= ((env->fpsw >> FPSW_FLAG_V) |
+                      (env->fpsw >> FPSW_FLAG_O) |
+                      (env->fpsw >> FPSW_FLAG_Z) |
+                      (env->fpsw >> FPSW_FLAG_U) |
+                      (env->fpsw >> FPSW_FLAG_X)) << FPSW_FLAG_S;
+
+        /* Generate an exception if enabled */
+        cause = (env->fpsw & FPSW_CAUSE_MASK) >> FPSW_CAUSE_SHIFT;
+        enable = (env->fpsw & FPSW_ENABLE_MASK) >> FPSW_ENABLE_SHIFT;
+        if (cause & enable) {
+            raise_exception(env, 21, retaddr);
+        }
+    }
+}
+
+static void set_fpmode(CPURXState *env, uint32_t val)
+{
+    static const int roundmode[] = {
+        float_round_nearest_even,
+        float_round_to_zero,
+        float_round_up,
+        float_round_down,
+    };
+    env->fpsw = val & FPSW_MASK;
+    set_float_rounding_mode(roundmode[val & FPSW_RM_MASK],
+                            &env->fp_status);
+    set_flush_to_zero((val & FPSW_DN) != 0, &env->fp_status);
+}
+
+#define FLOATOP(op, func)                                           \
+float32 helper_##op(CPURXState *env, float32 t0, float32 t1) \
+{ \
+    float32 ret; \
+    ret = func(t0, t1, &env->fp_status); \
+    update_fpsw(env, *(uint32_t *)&ret, GETPC());        \
+    return ret; \
+}
+
+FLOATOP(fadd, float32_add)
+FLOATOP(fsub, float32_sub)
+FLOATOP(fmul, float32_mul)
+FLOATOP(fdiv, float32_div)
+
+void helper_fcmp(CPURXState *env, float32 t0, float32 t1)
+{
+    int st;
+    st = float32_compare(t0, t1, &env->fp_status);
+    update_fpsw(env, 0, GETPC());
+    env->psw_z = env->psw_s = env->psw_o = 0;
+    env->psw_op = RX_PSW_OP_NONE;
+    switch (st) {
+    case float_relation_equal:
+        env->psw_z = 1;
+        break;
+    case float_relation_less:
+        env->psw_s = 1;
+        break;
+    case float_relation_unordered:
+        env->psw_o = 1;
+        break;
+    }
+}
+
+uint32_t helper_ftoi(CPURXState *env, float32 t0)
+{
+    uint32_t ret;
+    ret = float32_to_int32_round_to_zero(t0, &env->fp_status);
+    update_fpsw(env, ret, GETPC());
+    return ret;
+}
+
+uint32_t helper_round(CPURXState *env, float32 t0)
+{
+    uint32_t ret;
+    ret = float32_to_int32(t0, &env->fp_status);
+    update_fpsw(env, ret, GETPC());
+    return ret;
+}
+
+float32 helper_itof(CPURXState *env, uint32_t t0)
+{
+    float32 ret;
+    ret = int32_to_float32(t0, &env->fp_status);
+    update_fpsw(env, *(uint32_t *)&ret, GETPC());
+    return ret;
+}
+
+/* string operations */
+void helper_scmpu(CPURXState *env)
+{
+    uint8_t tmp0, tmp1;
+    if (env->regs[3] == 0) {
+        return;
+    }
+    while (env->regs[3] != 0) {
+        tmp0 = cpu_ldub_data_ra(env, env->regs[1]++, GETPC());
+        tmp1 = cpu_ldub_data_ra(env, env->regs[2]++, GETPC());
+        env->regs[3]--;
+        if (tmp0 != tmp1 || tmp0 == '\0') {
+            break;
+        }
+    }
+    env->psw_z = (tmp0 == tmp1);
+    env->psw_c = (tmp0 >= tmp1);
+}
+
+void helper_sstr(CPURXState *env, uint32_t sz)
+{
+    while (env->regs[3] != 0) {
+        switch (sz) {
+        case 0:
+            cpu_stb_data_ra(env, env->regs[1], env->regs[2], GETPC());
+            break;
+        case 1:
+            cpu_stw_data_ra(env, env->regs[1], env->regs[2], GETPC());
+            break;
+        case 2:
+            cpu_stl_data_ra(env, env->regs[1], env->regs[2], GETPC());
+            break;
+        }
+        env->regs[1] += (1 << sz);
+        env->regs[3]--;
+    }
+}
+
+static void smov(uint32_t mode, CPURXState *env)
+{
+    uint8_t tmp;
+    int dir;
+
+    dir = (mode & OP_SMOVB) ? -1 : 1;
+    while (env->regs[3] != 0) {
+        tmp = cpu_ldub_data_ra(env, env->regs[2], env->pc);
+        cpu_stb_data_ra(env, env->regs[1], tmp, env->pc);
+        env->regs[1] += dir;
+        env->regs[2] += dir;
+        env->regs[3]--;
+        if ((mode & OP_SMOVU) && tmp == 0) {
+            break;
+        }
+    }
+}
+
+void helper_smovu(CPURXState *env)
+{
+    smov(OP_SMOVU, env);
+}
+
+void helper_smovf(CPURXState *env)
+{
+    smov(OP_SMOVF, env);
+}
+
+void helper_smovb(CPURXState *env)
+{
+    smov(OP_SMOVB, env);
+}
+
+static uint32_t (* const ld[])(CPUArchState *env,
+                               target_ulong ptr,
+                               uintptr_t retaddr) = {
+    cpu_ldub_data_ra, cpu_lduw_data_ra, cpu_ldl_data_ra,
+};
+
+static void rx_search(uint32_t mode, int sz, CPURXState *env)
+{
+    uint32_t tmp;
+
+    while (env->regs[3] != 0) {
+        tmp = ld[sz](env, env->regs[1], env->pc);
+        env->regs[1] += 1 << (mode % 4);
+        env->regs[3]--;
+        if ((mode == OP_SWHILE && tmp != env->regs[2]) ||
+            (mode == OP_SUNTIL && tmp == env->regs[2])) {
+            break;
+        }
+    }
+    env->psw_z = (mode == OP_SUNTIL) ?
+        (tmp == env->regs[2]) : (env->regs[3] == 0);
+    env->psw_c = (tmp <= env->regs[2]);
+}
+
+void helper_suntil(CPURXState *env, uint32_t sz)
+{
+    rx_search(OP_SUNTIL, sz, env);
+}
+
+void helper_swhile(CPURXState *env, uint32_t sz)
+{
+    rx_search(OP_SWHILE, sz, env);
+}
+
+/* accumlator operations */
+void helper_rmpa(CPURXState *env, uint32_t sz)
+{
+    uint64_t result_l, prev;
+    int32_t result_h;
+    int64_t tmp0, tmp1;
+
+    if (env->regs[3] == 0) {
+        return;
+    }
+    result_l = env->regs[5];
+    result_l <<= 32;
+    result_l |= env->regs[4];
+    result_h = env->regs[6];
+    env->psw_o = 0;
+
+    while (env->regs[3] != 0) {
+        tmp0 = ld[sz](env, env->regs[1], env->pc);
+        tmp1 = ld[sz](env, env->regs[2], env->pc);
+        tmp0 *= tmp1;
+        prev = result_l;
+        result_l += tmp0;
+        /* carry / bollow */
+        if (tmp0 < 0) {
+            if (prev > result_l) {
+                result_h--;
+            }
+        } else {
+            if (prev < result_l) {
+                result_h++;
+            }
+        }
+
+        env->regs[1] += 1 << sz;
+        env->regs[2] += 1 << sz;
+    }
+    env->psw_s = (result_h < 0);
+    env->psw_o = (result_h != 0 && result_h != -1);
+    env->psw_op = RX_PSW_OP_NONE;
+    env->regs[6] = result_h;
+    env->regs[5] = result_l >> 32;
+    env->regs[4] = result_l & 0xffffffff;
+}
+
+void helper_mulhi(CPURXState *env, uint32_t regs)
+{
+    int rs, rs2;
+    long long tmp0, tmp1;
+
+    rs = (regs >> 4) & 15;
+    rs2 = regs & 15;
+
+    tmp0 = env->regs[rs] >> 16;
+    tmp1 = env->regs[rs2] >> 16;
+    env->acc = (tmp0 * tmp1) << 16;
+}
+
+void helper_mullo(CPURXState *env, uint32_t regs)
+{
+    int rs, rs2;
+    long long tmp0, tmp1;
+
+    rs = (regs >> 4) & 15;
+    rs2 = regs & 15;
+
+    tmp0 = env->regs[rs] & 0xffff;
+    tmp1 = env->regs[rs2] & 0xffff;
+    env->acc = (tmp0 * tmp1) << 16;
+}
+
+void helper_machi(CPURXState *env, uint32_t regs)
+{
+    int rs, rs2;
+    long long tmp0, tmp1;
+
+    rs = (regs >> 4) & 15;
+    rs2 = regs & 15;
+
+    tmp0 = env->regs[rs] >> 16;
+    tmp1 = env->regs[rs2] >> 16;
+    env->acc += (tmp0 * tmp1) << 16;
+}
+
+void helper_maclo(CPURXState *env, uint32_t regs)
+{
+    int rs, rs2;
+    long long tmp0, tmp1;
+
+    rs = (regs >> 4) & 15;
+    rs2 = regs & 15;
+
+    tmp0 = env->regs[rs] & 0xffff;
+    tmp1 = env->regs[rs2] & 0xffff;
+    env->acc += (tmp0 * tmp1) << 16;
+}
+
+void helper_racw(CPURXState *env, uint32_t imm)
+{
+    int64_t acc;
+    acc = env->acc;
+    acc <<= (imm + 1);
+    acc += 0x0000000080000000LL;
+    if (acc > 0x00007fff00000000LL) {
+        acc = 0x00007fff00000000LL;
+    } else if (acc < -0x800000000000LL) {
+        acc = -0x800000000000LL;
+    } else {
+        acc &= 0xffffffff00000000LL;
+    }
+    env->acc = acc;
+}
+
+void helper_sat(CPURXState *env, uint32_t reg)
+{
+    uint32_t o;
+    o = update_psw_o(env);
+    if (o == 1 && env->psw_s == 1) {
+        env->regs[reg] = 0x7fffffff;
+    } else if (o == 1 && env->psw_s == 0) {
+        env->regs[reg] = 0x80000000;
+    }
+}
+
+void helper_satr(CPURXState *env)
+{
+    uint32_t o;
+    o = update_psw_o(env);
+    if (o == 1 && env->psw_s == 1) {
+        env->regs[4] = 0x00000000;
+        env->regs[5] = 0x7fffffff;
+        env->regs[6] = 0xffffffff;
+    } else if (o == 1 && env->psw_s == 0) {
+        env->regs[4] = 0xffffffff;
+        env->regs[5] = 0x80000000;
+        env->regs[6] = 0x00000000;
+    }
+}
+
+/* div */
+uint32_t helper_div(CPURXState *env, uint32_t num, uint32_t den)
+{
+    uint32_t ret = num;
+    if (den != 0) {
+        ret = (int32_t)num / (int32_t)den;
+    }
+    env->psw_o = (ret == 0 || den == 0);
+    env->psw_op = RX_PSW_OP_NONE;
+    return ret;
+}
+
+uint32_t helper_divu(CPURXState *env, uint32_t num, uint32_t den)
+{
+    uint32_t ret = num;
+    if (den != 0) {
+        ret = num / den;
+    }
+    env->psw_o = (den == 0);
+    env->psw_op = RX_PSW_OP_NONE;
+    return ret;
+}
+
+/* exception */
+static inline void QEMU_NORETURN raise_exception(CPURXState *env, int index,
+                                                 uintptr_t retaddr)
+{
+    CPUState *cs = CPU(rx_env_get_cpu(env));
+
+    cs->exception_index = index;
+    cpu_loop_exit_restore(cs, retaddr);
+}
+
+void QEMU_NORETURN helper_raise_privilege_violation(CPURXState *env)
+{
+    raise_exception(env, 20, GETPC());
+}
+
+void QEMU_NORETURN helper_raise_access_fault(CPURXState *env)
+{
+    raise_exception(env, 21, GETPC());
+}
+
+void QEMU_NORETURN helper_raise_illegal_instruction(CPURXState *env)
+{
+    raise_exception(env, 23, GETPC());
+}
+
+void QEMU_NORETURN helper_wait(CPURXState *env)
+{
+    CPUState *cs = CPU(rx_env_get_cpu(env));
+
+    cs->halted = 1;
+    env->in_sleep = 1;
+    raise_exception(env, EXCP_HLT, 0);
+}
+
+void QEMU_NORETURN helper_debug(CPURXState *env)
+{
+    CPUState *cs = CPU(rx_env_get_cpu(env));
+
+    cs->exception_index = EXCP_DEBUG;
+    cpu_loop_exit(cs);
+}
+
+void QEMU_NORETURN helper_rxint(CPURXState *env, uint32_t vec)
+{
+    CPUState *cs = CPU(rx_env_get_cpu(env));
+
+    cs->interrupt_request |= CPU_INTERRUPT_SOFT;
+    env->sirq = vec;
+    raise_exception(env, 0x100, 0);
+}
+
+void QEMU_NORETURN helper_rxbrk(CPURXState *env)
+{
+    CPUState *cs = CPU(rx_env_get_cpu(env));
+
+    cs->interrupt_request |= CPU_INTERRUPT_SOFT;
+    env->sirq = 0;
+    raise_exception(env, 0x100, 0);
+}
+
+void tlb_fill(CPUState *cs, target_ulong addr, int size,
+              MMUAccessType access_type, int mmu_idx, uintptr_t retaddr)
+{
+    uint32_t address, physical, prot;
+
+    /* Linear mapping */
+    address = physical = addr & TARGET_PAGE_MASK;
+    prot = PAGE_READ | PAGE_WRITE | PAGE_EXEC;
+    tlb_set_page(cs, address, physical, prot, mmu_idx, TARGET_PAGE_SIZE);
+}
-- 
2.11.0
