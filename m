Return-Path: <SRS0=msIk=TG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F742C04A6B
	for <qemu-devel@archiver.kernel.org>; Mon,  6 May 2019 13:22:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B8A9E206A3
	for <qemu-devel@archiver.kernel.org>; Mon,  6 May 2019 13:22:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B8A9E206A3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=users.sourceforge.jp
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:56547 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hNdZk-0007No-Pj
	for qemu-devel@archiver.kernel.org; Mon, 06 May 2019 09:22:36 -0400
Received: from eggs.gnu.org ([209.51.188.92]:32900)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ysato@users.sourceforge.jp>) id 1hNdSO-0001fV-Bt
	for qemu-devel@nongnu.org; Mon, 06 May 2019 09:15:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ysato@users.sourceforge.jp>) id 1hNdSL-0000HP-Aa
	for qemu-devel@nongnu.org; Mon, 06 May 2019 09:15:00 -0400
Received: from mail03.asahi-net.or.jp ([202.224.55.15]:48626)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ysato@users.sourceforge.jp>) id 1hNdSK-0000Gf-Rh
	for qemu-devel@nongnu.org; Mon, 06 May 2019 09:14:57 -0400
Received: from h61-195-96-97.vps.ablenet.jp (h61-195-96-97.vps.ablenet.jp
	[61.195.96.97]) (Authenticated sender: PQ4Y-STU)
	by mail03.asahi-net.or.jp (Postfix) with ESMTPA id 83E053F643;
	Mon,  6 May 2019 22:14:54 +0900 (JST)
Received: from ysato.dip.jp (ZM005235.ppp.dion.ne.jp [222.8.5.235])
	by h61-195-96-97.vps.ablenet.jp (Postfix) with ESMTPSA id 03B54240087; 
	Mon,  6 May 2019 22:14:53 +0900 (JST)
From: Yoshinori Sato <ysato@users.sourceforge.jp>
To: qemu-devel@nongnu.org
Date: Mon,  6 May 2019 22:14:33 +0900
Message-Id: <20190506131444.120869-3-ysato@users.sourceforge.jp>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20190506131444.120869-1-ysato@users.sourceforge.jp>
References: <20190506131444.120869-1-ysato@users.sourceforge.jp>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 202.224.55.15
Subject: [Qemu-devel] [PATCH v9 02/13] target/rx: TCG helper
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: peter.maydell@linaro.org, richard.henderson@linaro.org,
	Yoshinori Sato <ysato@users.sourceforge.jp>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Yoshinori Sato <ysato@users.sourceforge.jp>
---
 target/rx/helper.h    |  31 ++++
 target/rx/helper.c    | 148 ++++++++++++++++
 target/rx/op_helper.c | 481 ++++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 660 insertions(+)
 create mode 100644 target/rx/helper.h
 create mode 100644 target/rx/helper.c
 create mode 100644 target/rx/op_helper.c

diff --git a/target/rx/helper.h b/target/rx/helper.h
new file mode 100644
index 0000000000..f0b7ebbbf7
--- /dev/null
+++ b/target/rx/helper.h
@@ -0,0 +1,31 @@
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
+DEF_HELPER_2(set_fpsw, void, env, i32)
+DEF_HELPER_FLAGS_2(racw, TCG_CALL_NO_WG, void, env, i32)
+DEF_HELPER_FLAGS_2(set_psw_rte, TCG_CALL_NO_WG, void, env, i32)
+DEF_HELPER_FLAGS_2(set_psw, TCG_CALL_NO_WG, void, env, i32)
+DEF_HELPER_1(pack_psw, i32, env)
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
+DEF_HELPER_1(satr, void, env)
diff --git a/target/rx/helper.c b/target/rx/helper.c
new file mode 100644
index 0000000000..8e598c9c1d
--- /dev/null
+++ b/target/rx/helper.c
@@ -0,0 +1,148 @@
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
+#include "qemu/bitops.h"
+#include "cpu.h"
+#include "exec/log.h"
+#include "exec/cpu_ldst.h"
+#include "sysemu/sysemu.h"
+
+void rx_cpu_unpack_psw(CPURXState *env, uint32_t psw, int rte)
+{
+    if (env->psw_pm == 0) {
+        env->psw_ipl = FIELD_EX32(psw, PSW, IPL);
+        if (rte) {
+            /* PSW.PM can write RTE and RTFI */
+            env->psw_pm = FIELD_EX32(psw, PSW, PM);
+        }
+        env->psw_u = FIELD_EX32(psw, PSW, U);
+        env->psw_i = FIELD_EX32(psw, PSW, I);
+    }
+    env->psw_o = FIELD_EX32(psw, PSW, O) << 31;
+    env->psw_s = FIELD_EX32(psw, PSW, S) << 31;
+    env->psw_z = 1 - FIELD_EX32(psw, PSW, Z);
+    env->psw_c = FIELD_EX32(psw, PSW, C);
+}
+
+#define INT_FLAGS (CPU_INTERRUPT_HARD | CPU_INTERRUPT_FIR)
+void rx_cpu_do_interrupt(CPUState *cs)
+{
+    RXCPU *cpu = RXCPU(cs);
+    CPURXState *env = &cpu->env;
+    int do_irq = cs->interrupt_request & INT_FLAGS;
+    uint32_t save_psw;
+
+    env->in_sleep = 0;
+
+    if (env->psw_u) {
+        env->usp = env->regs[0];
+    } else {
+        env->isp = env->regs[0];
+    }
+    save_psw = rx_cpu_pack_psw(env);
+    env->psw_pm = env->psw_i = env->psw_u = 0;
+
+    if (do_irq) {
+        if (do_irq & CPU_INTERRUPT_FIR) {
+            env->bpc = env->pc;
+            env->bpsw = save_psw;
+            env->pc = env->fintv;
+            env->psw_ipl = 15;
+            cs->interrupt_request &= ~CPU_INTERRUPT_FIR;
+            qemu_set_irq(env->ack, env->ack_irq);
+            qemu_log_mask(CPU_LOG_INT, "fast interrupt raised\n");
+        } else if (do_irq & CPU_INTERRUPT_HARD) {
+            env->isp -= 4;
+            cpu_stl_all(env, env->isp, save_psw);
+            env->isp -= 4;
+            cpu_stl_all(env, env->isp, env->pc);
+            env->pc = cpu_ldl_all(env, env->intb + env->ack_irq * 4);
+            env->psw_ipl = env->ack_ipl;
+            cs->interrupt_request &= ~CPU_INTERRUPT_HARD;
+            qemu_set_irq(env->ack, env->ack_irq);
+            qemu_log_mask(CPU_LOG_INT,
+                          "interrupt 0x%02x raised\n", env->ack_irq);
+        }
+    } else {
+        uint32_t vec = cs->exception_index;
+        const char *expname = "unknown exception";
+
+        env->isp -= 4;
+        cpu_stl_all(env, env->isp, save_psw);
+        env->isp -= 4;
+        cpu_stl_all(env, env->isp, env->pc);
+
+        if (vec < 0x100) {
+            env->pc = cpu_ldl_all(env, 0xffffffc0 + vec * 4);
+        } else {
+            env->pc = cpu_ldl_all(env, env->intb + (vec & 0xff) * 4);
+        }
+        switch (vec) {
+        case 20:
+            expname = "previlage violation";
+            break;
+        case 21:
+            expname = "access exception";
+            break;
+        case 23:
+            expname = "illegal instruction";
+            break;
+        case 25:
+            expname = "fpu exception";
+            break;
+        case 30:
+            expname = "NMI interrupt";
+            break;
+        case 0x100 ... 0x1ff:
+            expname = "unconditional trap";
+        }
+        qemu_log_mask(CPU_LOG_INT, "exception 0x%02x [%s] raised\n",
+                      (vec & 0xff), expname);
+    }
+    env->regs[0] = env->isp;
+}
+
+bool rx_cpu_exec_interrupt(CPUState *cs, int interrupt_request)
+{
+    RXCPU *cpu = RXCPU(cs);
+    CPURXState *env = &cpu->env;
+    int accept = 0;
+    /* hardware interrupt (Normal) */
+    if ((interrupt_request & CPU_INTERRUPT_HARD) &&
+        env->psw_i && (env->psw_ipl < env->req_ipl)) {
+        env->ack_irq = env->req_irq;
+        env->ack_ipl = env->req_ipl;
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
diff --git a/target/rx/op_helper.c b/target/rx/op_helper.c
new file mode 100644
index 0000000000..9a460070e9
--- /dev/null
+++ b/target/rx/op_helper.c
@@ -0,0 +1,481 @@
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
+#include "qemu/bitops.h"
+#include "cpu.h"
+#include "exec/exec-all.h"
+#include "exec/helper-proto.h"
+#include "exec/cpu_ldst.h"
+#include "fpu/softfloat.h"
+
+static inline void QEMU_NORETURN raise_exception(CPURXState *env, int index,
+                                                 uintptr_t retaddr);
+
+static void _set_psw(CPURXState *env, uint32_t psw, uint32_t rte)
+{
+    uint32_t prev_u;
+    prev_u = env->psw_u;
+    rx_cpu_unpack_psw(env, psw, rte);
+    if (prev_u != env->psw_u) {
+        /* switch r0  */
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
+void helper_set_psw(CPURXState *env, uint32_t psw)
+{
+    _set_psw(env, psw, 0);
+}
+
+void helper_set_psw_rte(CPURXState *env, uint32_t psw)
+{
+    _set_psw(env, psw, 1);
+}
+
+uint32_t helper_pack_psw(CPURXState *env)
+{
+    return rx_cpu_pack_psw(env);
+}
+
+#define SET_FPSW(b)                                             \
+    do {                                                        \
+        env->fpsw = FIELD_DP32(env->fpsw, FPSW, C ## b, 1);     \
+        if (!FIELD_EX32(env->fpsw, FPSW, E ## b)) {             \
+            env->fpsw = FIELD_DP32(env->fpsw, FPSW, F ## b, 1); \
+        }                                                       \
+    } while (0)
+
+/* fp operations */
+static void update_fpsw(CPURXState *env, float32 ret, uintptr_t retaddr)
+{
+    int xcpt, cause, enable;
+
+    env->psw_z = ret & ~(1 << 31); /* mask sign bit */
+    env->psw_s = ret;
+
+    xcpt = get_float_exception_flags(&env->fp_status);
+
+    /* Clear the cause entries */
+    env->fpsw = FIELD_DP32(env->fpsw, FPSW, CAUSE, 0);
+
+    /* set FPSW */
+    if (unlikely(xcpt)) {
+        if (xcpt & float_flag_invalid) {
+            SET_FPSW(V);
+        }
+        if (xcpt & float_flag_divbyzero) {
+            SET_FPSW(Z);
+        }
+        if (xcpt & float_flag_overflow) {
+            SET_FPSW(O);
+        }
+        if (xcpt & float_flag_underflow) {
+            SET_FPSW(U);
+        }
+        if (xcpt & float_flag_inexact) {
+            SET_FPSW(X);
+        }
+        if ((xcpt & (float_flag_input_denormal
+                     | float_flag_output_denormal))
+            && !FIELD_EX32(env->fpsw, FPSW, DN)) {
+            env->fpsw = FIELD_DP32(env->fpsw, FPSW, CE, 1);
+        }
+
+        /* update FPSW_FLAG_S */
+        if (FIELD_EX32(env->fpsw, FPSW, FLAGS) != 0) {
+            env->fpsw = FIELD_DP32(env->fpsw, FPSW, FS, 1);
+        }
+
+        /* Generate an exception if enabled */
+        cause = FIELD_EX32(env->fpsw, FPSW, CAUSE);
+        enable = FIELD_EX32(env->fpsw, FPSW, ENABLE);
+        enable |= 1 << 5; /* CE always enabled */
+        if (cause & enable) {
+            raise_exception(env, 21, retaddr);
+        }
+    }
+}
+
+void helper_set_fpsw(CPURXState *env, uint32_t val)
+{
+    static const int roundmode[] = {
+        float_round_nearest_even,
+        float_round_to_zero,
+        float_round_up,
+        float_round_down,
+    };
+    uint32_t fpsw = env->fpsw;
+    fpsw |= 0x7fffff03;
+    val &= ~0x80000000;
+    fpsw &= val;
+    FIELD_DP32(fpsw, FPSW, FS, FIELD_EX32(fpsw, FPSW, FLAGS) != 0);
+    env->fpsw = fpsw;
+    set_float_rounding_mode(roundmode[FIELD_EX32(env->fpsw, FPSW, RM)],
+                            &env->fp_status);
+}
+
+#define FLOATOP(op, func)                                           \
+    float32 helper_##op(CPURXState *env, float32 t0, float32 t1)    \
+    {                                                               \
+        float32 ret;                                                \
+        ret = func(t0, t1, &env->fp_status);                        \
+        update_fpsw(env, *(uint32_t *)&ret, GETPC());               \
+        return ret;                                                 \
+    }
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
+    env->psw_z = 1;
+    env->psw_s = env->psw_o = 0;
+    switch (st) {
+    case float_relation_equal:
+        env->psw_z = 0;
+        break;
+    case float_relation_less:
+        env->psw_s = -1;
+        break;
+    case float_relation_unordered:
+        env->psw_o = -1;
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
+    update_fpsw(env, ret, GETPC());
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
+    env->psw_z = tmp0 - tmp1;
+    env->psw_c = (tmp0 >= tmp1);
+}
+
+static uint32_t (* const cpu_ldufn[])(CPUArchState *env,
+                                     target_ulong ptr,
+                                     uintptr_t retaddr) = {
+    cpu_ldub_data_ra, cpu_lduw_data_ra, cpu_ldl_data_ra,
+};
+
+static uint32_t (* const cpu_ldfn[])(CPUArchState *env,
+                                     target_ulong ptr,
+                                     uintptr_t retaddr) = {
+    cpu_ldub_data_ra, cpu_lduw_data_ra, cpu_ldl_data_ra,
+};
+
+static void (* const cpu_stfn[])(CPUArchState *env,
+                                 target_ulong ptr,
+                                 uint32_t val,
+                                 uintptr_t retaddr) = {
+    cpu_stb_data_ra, cpu_stw_data_ra, cpu_stl_data_ra,
+};
+
+void helper_sstr(CPURXState *env, uint32_t sz)
+{
+    tcg_debug_assert(sz < 3);
+    while (env->regs[3] != 0) {
+        cpu_stfn[sz](env, env->regs[1], env->regs[2], GETPC());
+        env->regs[1] += 1 << sz;
+        env->regs[3]--;
+    }
+}
+
+#define OP_SMOVU 1
+#define OP_SMOVF 0
+#define OP_SMOVB 2
+
+static void smov(uint32_t mode, CPURXState *env)
+{
+    uint8_t tmp;
+    int dir;
+
+    dir = (mode & OP_SMOVB) ? -1 : 1;
+    while (env->regs[3] != 0) {
+        tmp = cpu_ldub_data_ra(env, env->regs[2], GETPC());
+        cpu_stb_data_ra(env, env->regs[1], tmp, GETPC());
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
+
+void helper_suntil(CPURXState *env, uint32_t sz)
+{
+    uint32_t tmp;
+    tcg_debug_assert(sz < 3);
+    if (env->regs[3] == 0) {
+        return ;
+    }
+    while (env->regs[3] != 0) {
+        tmp = cpu_ldufn[sz](env, env->regs[1], GETPC());
+        env->regs[1] += 1 << sz;
+        env->regs[3]--;
+        if (tmp == env->regs[2]) {
+            break;
+        }
+    }
+    env->psw_z = tmp - env->regs[2];
+    env->psw_c = (tmp <= env->regs[2]);
+}
+
+void helper_swhile(CPURXState *env, uint32_t sz)
+{
+    uint32_t tmp;
+    tcg_debug_assert(sz < 3);
+    if (env->regs[3] == 0) {
+        return ;
+    }
+    while (env->regs[3] != 0) {
+        tmp = cpu_ldufn[sz](env, env->regs[1], GETPC());
+        env->regs[1] += 1 << sz;
+        env->regs[3]--;
+        if (tmp != env->regs[2]) {
+            break;
+        }
+    }
+    env->psw_z = env->regs[3];
+    env->psw_c = (tmp <= env->regs[2]);
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
+        tmp0 = cpu_ldfn[sz](env, env->regs[1], GETPC());
+        tmp1 = cpu_ldfn[sz](env, env->regs[2], GETPC());
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
+    env->psw_s = result_h;
+    env->psw_o = (result_h != 0 && result_h != -1) << 31;
+    env->regs[6] = result_h;
+    env->regs[5] = result_l >> 32;
+    env->regs[4] = result_l & 0xffffffff;
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
+void helper_satr(CPURXState *env)
+{
+    if (env->psw_o >> 31) {
+        if ((int)env->psw_s < 0) {
+            env->regs[6] = 0x00000000;
+            env->regs[5] = 0x7fffffff;
+            env->regs[4] = 0xffffffff;
+        } else {
+            env->regs[6] = 0xffffffff;
+            env->regs[5] = 0x80000000;
+            env->regs[4] = 0x00000000;
+        }
+    }
+}
+
+/* div */
+uint32_t helper_div(CPURXState *env, uint32_t num, uint32_t den)
+{
+    uint32_t ret = num;
+    if (!((num == INT_MIN && den == -1) || den == 0)) {
+        ret = (int32_t)num / (int32_t)den;
+        env->psw_o = 0;
+    } else {
+        env->psw_o = -1;
+    }
+    return ret;
+}
+
+uint32_t helper_divu(CPURXState *env, uint32_t num, uint32_t den)
+{
+    uint32_t ret = num;
+    if (den != 0) {
+        ret = num / den;
+        env->psw_o = 0;
+    } else {
+        env->psw_o = -1;
+    }
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
+    raise_exception(env, 0x100 + vec, 0);
+}
+
+void QEMU_NORETURN helper_rxbrk(CPURXState *env)
+{
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


