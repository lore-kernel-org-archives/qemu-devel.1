Return-Path: <SRS0=rlpO=32=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,URIBL_SBL,URIBL_SBL_A,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D91EC35247
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 21:58:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AC268214AF
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 21:58:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="ZcYuOAoL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC268214AF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gmx.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46908 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1izp9y-0007RE-No
	for qemu-devel@archiver.kernel.org; Thu, 06 Feb 2020 16:58:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37935)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <n54@gmx.com>) id 1izoma-0000Fw-7J
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 16:34:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <n54@gmx.com>) id 1izomW-000707-2a
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 16:33:56 -0500
Received: from mout.gmx.net ([212.227.17.20]:42325)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <n54@gmx.com>) id 1izomV-0006rF-JJ
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 16:33:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
 s=badeba3b8450; t=1581024808;
 bh=a2F0qr52TkRe1SZ0/ZT8wBLkX80C6cksx9lBt/HD+Us=;
 h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
 b=ZcYuOAoLazYAE99uvbVTQ1SE9wbsUx2Sw55WgFJaY7RMK5foIlkpjcFZV7b12Vb20
 /+PZAAQqv9ta2qTMilG2IJCzHPrtdIfoH/RU4c420tHnn8tvjM9Oo239Qb6FbPHX5I
 hamm4ZWZnGFfkx/c6uYIddGwuYgPz9jPBNx3IKhg=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from localhost.localdomain ([89.71.135.231]) by mail.gmx.com
 (mrgmx105 [212.227.17.174]) with ESMTPSA (Nemesis) id
 1M6lpG-1isghq11PK-008H2m; Thu, 06 Feb 2020 22:33:28 +0100
From: Kamil Rytarowski <n54@gmx.com>
To: rth@twiddle.net, ehabkost@redhat.com, slp@redhat.com, pbonzini@redhat.com,
 peter.maydell@linaro.org, philmd@redhat.com, max@m00nbsd.net,
 jmcneill@invisible.ca
Subject: [PATCH v4 3/4] Introduce the NVMM impl
Date: Thu,  6 Feb 2020 22:32:31 +0100
Message-Id: <20200206213232.1918-4-n54@gmx.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200206213232.1918-1-n54@gmx.com>
References: <20200206115731.13552-1-n54@gmx.com>
 <20200206213232.1918-1-n54@gmx.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:a8xJ/NYy2xAOev3t3WHrEnvsD4ScD1BFxy0IGzT9oXCqrnzdxsD
 oVgP4djg5PvQNW/gL2uYXjT9Bn5TWo3c8nCZHViSBL4dMnmQRS/EaWlfUYxGAekGSQ49Qxk
 Jb9PhJnzB8JaboRSCmRXLrYYRwH+oFItc12jLRFkwHQ6oxFaiBk0/BxMEnWwnpg/RFlMR0f
 Qs3ojMWj0vjJP8GWqLbqw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:TiisJwSgG4I=:Zt9qf0sMCZkNWLYLhwufwL
 1GO6nN883sGx+LBQZRRKqmaTvkWu39zKwbUh0CsHNmFlFsVWjCvsXwMOQdNusDGETm86JEuoJ
 PeXjtIbqmNzlIRSOhRZgpVNTOxEwTHr1s42FIsZHpksFg+u14+G+/+BpDZ5jiIn8dVrq7Tvck
 Sqd5iGXic1lVxlD0wwe2CghzPXP+Y2IKGuxmz57fghJDZcXxQw4QSN7FEoG/p31k8+MYihAKQ
 Gjm6UqvxHPLrVh8JPsvRDoP/uPOg7HDY7rZP7LDWtkRC1myCY5V/gZDTuC2PGufhYcPJhhVc4
 S6iwMGnsRgTZWbjs+RL5Fo3yPACjusT+fcZmz9PGtU1PcmRMR/hDJIULfKY+K5PFnxyc0TQvZ
 lb6u0Hi8GtaCJTZo/H6bwyGUkhLax36/SEwypVcESUdVqWMeUWRoK/EM+GzEKTnAGxtqqSudu
 X0aNGcyc1mTg1gprXswnbVpUmCaWqQvYLc0yky0ReoL/NgYLeNwq1TGr9W2A291YrVzWS72JB
 Jbddryif2vh9GQErnFO039tXSQh1TCGN0PvNcqAui6a2OZeLzodipSXffFrumbniBA8lxC0Pn
 3GaBWX46DgHT/SRfBs6QftuSD/9OuUuXxTB8MD2hE0Lqkr1qNUs+Q6OdwzXS7SnrkxSGeXg12
 tICHYFvTgnFxo1FL15Frrqz0SJFYh9ZYS7EZ+xv95AyFHNZjLrH2i74gonCE/O9PG4lRlVUVQ
 LgEGMaJRvpMUgqM9J46OVCm43sIq00ieDi9Vf71Qegbs3iTD2MAlfRV+yv8V/ySbLw0M9spCD
 MLIXw8p1Xgdl3B+1sYTkq6/fHdfWbV+QF5PIjwztAUHTUbUW0d4JW5han8qexSHbi16/I9RZm
 sp0bZuJgzSWJTIBWBfN8IdcG/+bhtv0ybD1j7eJMIDWarDuMW0gh0/TcCL2jRLTHqBNtf0kXs
 bh1DY+gW+ZgXWKGlXTb1O3APXsOvwoFGUGLkD5NTCFuHZgys+O40482Ib3zLZvnjy7mAM98t0
 OsHGuIPuHWeaZOE4M6kAIZyISUSJl6q3zKIFrjJbSe6K1fqAldnIPbJP6HxZB8IQ5vLomBoNv
 iO0RcuA+qQgfCHrBaAINPUpHK4mbvcQzqvOfdcLAO41d+iiBUOlVnGRLJ3LcPjMWIZX7k69/Q
 wmDEfPA1wt6SNVdi6y+dQ1SrDF4jYQsq7Bw/oadbEF5KDEv9w540qDRJ5o9qtq9sMKX0c=
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 212.227.17.20
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Kamil Rytarowski <n54@gmx.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Maxime Villard <max@m00nbsd.net>

Implements the NetBSD Virtual Machine Monitor (NVMM) target. Which
acts as a hypervisor accelerator for QEMU on the NetBSD platform. This ena=
bles
QEMU much greater speed over the emulated x86_64 path's that are taken on
NetBSD today.

Signed-off-by: Maxime Villard <max@m00nbsd.net>
Signed-off-by: Kamil Rytarowski <n54@gmx.com>
Reviewed-by: Sergio Lopez <slp@redhat.com>
Tested-by: Jared McNeill <jmcneill@invisible.ca>
=2D--
 target/i386/Makefile.objs |    1 +
 target/i386/nvmm-all.c    | 1226 +++++++++++++++++++++++++++++++++++++
 2 files changed, 1227 insertions(+)
 create mode 100644 target/i386/nvmm-all.c

diff --git a/target/i386/Makefile.objs b/target/i386/Makefile.objs
index 48e0c28434..bdcdb32e93 100644
=2D-- a/target/i386/Makefile.objs
+++ b/target/i386/Makefile.objs
@@ -17,6 +17,7 @@ obj-$(CONFIG_HAX) +=3D hax-all.o hax-mem.o hax-posix.o
 endif
 obj-$(CONFIG_HVF) +=3D hvf/
 obj-$(CONFIG_WHPX) +=3D whpx-all.o
+obj-$(CONFIG_NVMM) +=3D nvmm-all.o
 endif
 obj-$(CONFIG_SEV) +=3D sev.o
 obj-$(call lnot,$(CONFIG_SEV)) +=3D sev-stub.o
diff --git a/target/i386/nvmm-all.c b/target/i386/nvmm-all.c
new file mode 100644
index 0000000000..a21908f46a
=2D-- /dev/null
+++ b/target/i386/nvmm-all.c
@@ -0,0 +1,1226 @@
+/*
+ * Copyright (c) 2018-2019 Maxime Villard, All rights reserved.
+ *
+ * NetBSD Virtual Machine Monitor (NVMM) accelerator for QEMU.
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or lat=
er.
+ * See the COPYING file in the top-level directory.
+ */
+
+#include "qemu/osdep.h"
+#include "cpu.h"
+#include "exec/address-spaces.h"
+#include "exec/ioport.h"
+#include "qemu-common.h"
+#include "strings.h"
+#include "sysemu/accel.h"
+#include "sysemu/nvmm.h"
+#include "sysemu/runstate.h"
+#include "sysemu/sysemu.h"
+#include "sysemu/cpus.h"
+#include "qemu/main-loop.h"
+#include "qemu/error-report.h"
+#include "qemu/queue.h"
+#include "qapi/error.h"
+#include "migration/blocker.h"
+
+#include <nvmm.h>
+
+struct qemu_vcpu {
+    struct nvmm_vcpu vcpu;
+    uint8_t tpr;
+    bool stop;
+
+    /* Window-exiting for INTs/NMIs. */
+    bool int_window_exit;
+    bool nmi_window_exit;
+
+    /* The guest is in an interrupt shadow (POP SS, etc). */
+    bool int_shadow;
+};
+
+struct qemu_machine {
+    struct nvmm_capability cap;
+    struct nvmm_machine mach;
+};
+
+/* ----------------------------------------------------------------------=
---- */
+
+static bool nvmm_allowed;
+static struct qemu_machine qemu_mach;
+
+static struct qemu_vcpu *
+get_qemu_vcpu(CPUState *cpu)
+{
+    return (struct qemu_vcpu *)cpu->hax_vcpu;
+}
+
+static struct nvmm_machine *
+get_nvmm_mach(void)
+{
+    return &qemu_mach.mach;
+}
+
+/* ----------------------------------------------------------------------=
---- */
+
+static void
+nvmm_set_segment(struct nvmm_x64_state_seg *nseg, const SegmentCache *qse=
g)
+{
+    uint32_t attrib =3D qseg->flags;
+
+    nseg->selector =3D qseg->selector;
+    nseg->limit =3D qseg->limit;
+    nseg->base =3D qseg->base;
+    nseg->attrib.type =3D __SHIFTOUT(attrib, DESC_TYPE_MASK);
+    nseg->attrib.s =3D __SHIFTOUT(attrib, DESC_S_MASK);
+    nseg->attrib.dpl =3D __SHIFTOUT(attrib, DESC_DPL_MASK);
+    nseg->attrib.p =3D __SHIFTOUT(attrib, DESC_P_MASK);
+    nseg->attrib.avl =3D __SHIFTOUT(attrib, DESC_AVL_MASK);
+    nseg->attrib.l =3D __SHIFTOUT(attrib, DESC_L_MASK);
+    nseg->attrib.def =3D __SHIFTOUT(attrib, DESC_B_MASK);
+    nseg->attrib.g =3D __SHIFTOUT(attrib, DESC_G_MASK);
+}
+
+static void
+nvmm_set_registers(CPUState *cpu)
+{
+    struct CPUX86State *env =3D (CPUArchState *)cpu->env_ptr;
+    struct nvmm_machine *mach =3D get_nvmm_mach();
+    struct qemu_vcpu *qcpu =3D get_qemu_vcpu(cpu);
+    struct nvmm_vcpu *vcpu =3D &qcpu->vcpu;
+    struct nvmm_x64_state *state =3D vcpu->state;
+    uint64_t bitmap;
+    size_t i;
+    int ret;
+
+    assert(cpu_is_stopped(cpu) || qemu_cpu_is_self(cpu));
+
+    /* GPRs. */
+    state->gprs[NVMM_X64_GPR_RAX] =3D env->regs[R_EAX];
+    state->gprs[NVMM_X64_GPR_RCX] =3D env->regs[R_ECX];
+    state->gprs[NVMM_X64_GPR_RDX] =3D env->regs[R_EDX];
+    state->gprs[NVMM_X64_GPR_RBX] =3D env->regs[R_EBX];
+    state->gprs[NVMM_X64_GPR_RSP] =3D env->regs[R_ESP];
+    state->gprs[NVMM_X64_GPR_RBP] =3D env->regs[R_EBP];
+    state->gprs[NVMM_X64_GPR_RSI] =3D env->regs[R_ESI];
+    state->gprs[NVMM_X64_GPR_RDI] =3D env->regs[R_EDI];
+#ifdef TARGET_X86_64
+    state->gprs[NVMM_X64_GPR_R8]  =3D env->regs[R_R8];
+    state->gprs[NVMM_X64_GPR_R9]  =3D env->regs[R_R9];
+    state->gprs[NVMM_X64_GPR_R10] =3D env->regs[R_R10];
+    state->gprs[NVMM_X64_GPR_R11] =3D env->regs[R_R11];
+    state->gprs[NVMM_X64_GPR_R12] =3D env->regs[R_R12];
+    state->gprs[NVMM_X64_GPR_R13] =3D env->regs[R_R13];
+    state->gprs[NVMM_X64_GPR_R14] =3D env->regs[R_R14];
+    state->gprs[NVMM_X64_GPR_R15] =3D env->regs[R_R15];
+#endif
+
+    /* RIP and RFLAGS. */
+    state->gprs[NVMM_X64_GPR_RIP] =3D env->eip;
+    state->gprs[NVMM_X64_GPR_RFLAGS] =3D env->eflags;
+
+    /* Segments. */
+    nvmm_set_segment(&state->segs[NVMM_X64_SEG_CS], &env->segs[R_CS]);
+    nvmm_set_segment(&state->segs[NVMM_X64_SEG_DS], &env->segs[R_DS]);
+    nvmm_set_segment(&state->segs[NVMM_X64_SEG_ES], &env->segs[R_ES]);
+    nvmm_set_segment(&state->segs[NVMM_X64_SEG_FS], &env->segs[R_FS]);
+    nvmm_set_segment(&state->segs[NVMM_X64_SEG_GS], &env->segs[R_GS]);
+    nvmm_set_segment(&state->segs[NVMM_X64_SEG_SS], &env->segs[R_SS]);
+
+    /* Special segments. */
+    nvmm_set_segment(&state->segs[NVMM_X64_SEG_GDT], &env->gdt);
+    nvmm_set_segment(&state->segs[NVMM_X64_SEG_LDT], &env->ldt);
+    nvmm_set_segment(&state->segs[NVMM_X64_SEG_TR], &env->tr);
+    nvmm_set_segment(&state->segs[NVMM_X64_SEG_IDT], &env->idt);
+
+    /* Control registers. */
+    state->crs[NVMM_X64_CR_CR0] =3D env->cr[0];
+    state->crs[NVMM_X64_CR_CR2] =3D env->cr[2];
+    state->crs[NVMM_X64_CR_CR3] =3D env->cr[3];
+    state->crs[NVMM_X64_CR_CR4] =3D env->cr[4];
+    state->crs[NVMM_X64_CR_CR8] =3D qcpu->tpr;
+    state->crs[NVMM_X64_CR_XCR0] =3D env->xcr0;
+
+    /* Debug registers. */
+    state->drs[NVMM_X64_DR_DR0] =3D env->dr[0];
+    state->drs[NVMM_X64_DR_DR1] =3D env->dr[1];
+    state->drs[NVMM_X64_DR_DR2] =3D env->dr[2];
+    state->drs[NVMM_X64_DR_DR3] =3D env->dr[3];
+    state->drs[NVMM_X64_DR_DR6] =3D env->dr[6];
+    state->drs[NVMM_X64_DR_DR7] =3D env->dr[7];
+
+    /* FPU. */
+    state->fpu.fx_cw =3D env->fpuc;
+    state->fpu.fx_sw =3D (env->fpus & ~0x3800) | ((env->fpstt & 0x7) << 1=
1);
+    state->fpu.fx_tw =3D 0;
+    for (i =3D 0; i < 8; i++) {
+        state->fpu.fx_tw |=3D (!env->fptags[i]) << i;
+    }
+    state->fpu.fx_opcode =3D env->fpop;
+    state->fpu.fx_ip.fa_64 =3D env->fpip;
+    state->fpu.fx_dp.fa_64 =3D env->fpdp;
+    state->fpu.fx_mxcsr =3D env->mxcsr;
+    state->fpu.fx_mxcsr_mask =3D 0x0000FFFF;
+    assert(sizeof(state->fpu.fx_87_ac) =3D=3D sizeof(env->fpregs));
+    memcpy(state->fpu.fx_87_ac, env->fpregs, sizeof(env->fpregs));
+    for (i =3D 0; i < 16; i++) {
+        memcpy(&state->fpu.fx_xmm[i].xmm_bytes[0],
+            &env->xmm_regs[i].ZMM_Q(0), 8);
+        memcpy(&state->fpu.fx_xmm[i].xmm_bytes[8],
+            &env->xmm_regs[i].ZMM_Q(1), 8);
+    }
+
+    /* MSRs. */
+    state->msrs[NVMM_X64_MSR_EFER] =3D env->efer;
+    state->msrs[NVMM_X64_MSR_STAR] =3D env->star;
+#ifdef TARGET_X86_64
+    state->msrs[NVMM_X64_MSR_LSTAR] =3D env->lstar;
+    state->msrs[NVMM_X64_MSR_CSTAR] =3D env->cstar;
+    state->msrs[NVMM_X64_MSR_SFMASK] =3D env->fmask;
+    state->msrs[NVMM_X64_MSR_KERNELGSBASE] =3D env->kernelgsbase;
+#endif
+    state->msrs[NVMM_X64_MSR_SYSENTER_CS]  =3D env->sysenter_cs;
+    state->msrs[NVMM_X64_MSR_SYSENTER_ESP] =3D env->sysenter_esp;
+    state->msrs[NVMM_X64_MSR_SYSENTER_EIP] =3D env->sysenter_eip;
+    state->msrs[NVMM_X64_MSR_PAT] =3D env->pat;
+    state->msrs[NVMM_X64_MSR_TSC] =3D env->tsc;
+
+    bitmap =3D
+        NVMM_X64_STATE_SEGS |
+        NVMM_X64_STATE_GPRS |
+        NVMM_X64_STATE_CRS  |
+        NVMM_X64_STATE_DRS  |
+        NVMM_X64_STATE_MSRS |
+        NVMM_X64_STATE_FPU;
+
+    ret =3D nvmm_vcpu_setstate(mach, vcpu, bitmap);
+    if (ret =3D=3D -1) {
+        error_report("NVMM: Failed to set virtual processor context,"
+            " error=3D%d", errno);
+    }
+}
+
+static void
+nvmm_get_segment(SegmentCache *qseg, const struct nvmm_x64_state_seg *nse=
g)
+{
+    qseg->selector =3D nseg->selector;
+    qseg->limit =3D nseg->limit;
+    qseg->base =3D nseg->base;
+
+    qseg->flags =3D
+        __SHIFTIN((uint32_t)nseg->attrib.type, DESC_TYPE_MASK) |
+        __SHIFTIN((uint32_t)nseg->attrib.s, DESC_S_MASK) |
+        __SHIFTIN((uint32_t)nseg->attrib.dpl, DESC_DPL_MASK) |
+        __SHIFTIN((uint32_t)nseg->attrib.p, DESC_P_MASK) |
+        __SHIFTIN((uint32_t)nseg->attrib.avl, DESC_AVL_MASK) |
+        __SHIFTIN((uint32_t)nseg->attrib.l, DESC_L_MASK) |
+        __SHIFTIN((uint32_t)nseg->attrib.def, DESC_B_MASK) |
+        __SHIFTIN((uint32_t)nseg->attrib.g, DESC_G_MASK);
+}
+
+static void
+nvmm_get_registers(CPUState *cpu)
+{
+    struct CPUX86State *env =3D (CPUArchState *)cpu->env_ptr;
+    struct nvmm_machine *mach =3D get_nvmm_mach();
+    struct qemu_vcpu *qcpu =3D get_qemu_vcpu(cpu);
+    struct nvmm_vcpu *vcpu =3D &qcpu->vcpu;
+    X86CPU *x86_cpu =3D X86_CPU(cpu);
+    struct nvmm_x64_state *state =3D vcpu->state;
+    uint64_t bitmap, tpr;
+    size_t i;
+    int ret;
+
+    assert(cpu_is_stopped(cpu) || qemu_cpu_is_self(cpu));
+
+    bitmap =3D
+        NVMM_X64_STATE_SEGS |
+        NVMM_X64_STATE_GPRS |
+        NVMM_X64_STATE_CRS  |
+        NVMM_X64_STATE_DRS  |
+        NVMM_X64_STATE_MSRS |
+        NVMM_X64_STATE_FPU;
+
+    ret =3D nvmm_vcpu_getstate(mach, vcpu, bitmap);
+    if (ret =3D=3D -1) {
+        error_report("NVMM: Failed to get virtual processor context,"
+            " error=3D%d", errno);
+    }
+
+    /* GPRs. */
+    env->regs[R_EAX] =3D state->gprs[NVMM_X64_GPR_RAX];
+    env->regs[R_ECX] =3D state->gprs[NVMM_X64_GPR_RCX];
+    env->regs[R_EDX] =3D state->gprs[NVMM_X64_GPR_RDX];
+    env->regs[R_EBX] =3D state->gprs[NVMM_X64_GPR_RBX];
+    env->regs[R_ESP] =3D state->gprs[NVMM_X64_GPR_RSP];
+    env->regs[R_EBP] =3D state->gprs[NVMM_X64_GPR_RBP];
+    env->regs[R_ESI] =3D state->gprs[NVMM_X64_GPR_RSI];
+    env->regs[R_EDI] =3D state->gprs[NVMM_X64_GPR_RDI];
+#ifdef TARGET_X86_64
+    env->regs[R_R8]  =3D state->gprs[NVMM_X64_GPR_R8];
+    env->regs[R_R9]  =3D state->gprs[NVMM_X64_GPR_R9];
+    env->regs[R_R10] =3D state->gprs[NVMM_X64_GPR_R10];
+    env->regs[R_R11] =3D state->gprs[NVMM_X64_GPR_R11];
+    env->regs[R_R12] =3D state->gprs[NVMM_X64_GPR_R12];
+    env->regs[R_R13] =3D state->gprs[NVMM_X64_GPR_R13];
+    env->regs[R_R14] =3D state->gprs[NVMM_X64_GPR_R14];
+    env->regs[R_R15] =3D state->gprs[NVMM_X64_GPR_R15];
+#endif
+
+    /* RIP and RFLAGS. */
+    env->eip =3D state->gprs[NVMM_X64_GPR_RIP];
+    env->eflags =3D state->gprs[NVMM_X64_GPR_RFLAGS];
+
+    /* Segments. */
+    nvmm_get_segment(&env->segs[R_ES], &state->segs[NVMM_X64_SEG_ES]);
+    nvmm_get_segment(&env->segs[R_CS], &state->segs[NVMM_X64_SEG_CS]);
+    nvmm_get_segment(&env->segs[R_SS], &state->segs[NVMM_X64_SEG_SS]);
+    nvmm_get_segment(&env->segs[R_DS], &state->segs[NVMM_X64_SEG_DS]);
+    nvmm_get_segment(&env->segs[R_FS], &state->segs[NVMM_X64_SEG_FS]);
+    nvmm_get_segment(&env->segs[R_GS], &state->segs[NVMM_X64_SEG_GS]);
+
+    /* Special segments. */
+    nvmm_get_segment(&env->gdt, &state->segs[NVMM_X64_SEG_GDT]);
+    nvmm_get_segment(&env->ldt, &state->segs[NVMM_X64_SEG_LDT]);
+    nvmm_get_segment(&env->tr, &state->segs[NVMM_X64_SEG_TR]);
+    nvmm_get_segment(&env->idt, &state->segs[NVMM_X64_SEG_IDT]);
+
+    /* Control registers. */
+    env->cr[0] =3D state->crs[NVMM_X64_CR_CR0];
+    env->cr[2] =3D state->crs[NVMM_X64_CR_CR2];
+    env->cr[3] =3D state->crs[NVMM_X64_CR_CR3];
+    env->cr[4] =3D state->crs[NVMM_X64_CR_CR4];
+    tpr =3D state->crs[NVMM_X64_CR_CR8];
+    if (tpr !=3D qcpu->tpr) {
+        qcpu->tpr =3D tpr;
+        cpu_set_apic_tpr(x86_cpu->apic_state, tpr);
+    }
+    env->xcr0 =3D state->crs[NVMM_X64_CR_XCR0];
+
+    /* Debug registers. */
+    env->dr[0] =3D state->drs[NVMM_X64_DR_DR0];
+    env->dr[1] =3D state->drs[NVMM_X64_DR_DR1];
+    env->dr[2] =3D state->drs[NVMM_X64_DR_DR2];
+    env->dr[3] =3D state->drs[NVMM_X64_DR_DR3];
+    env->dr[6] =3D state->drs[NVMM_X64_DR_DR6];
+    env->dr[7] =3D state->drs[NVMM_X64_DR_DR7];
+
+    /* FPU. */
+    env->fpuc =3D state->fpu.fx_cw;
+    env->fpstt =3D (state->fpu.fx_sw >> 11) & 0x7;
+    env->fpus =3D state->fpu.fx_sw & ~0x3800;
+    for (i =3D 0; i < 8; i++) {
+        env->fptags[i] =3D !((state->fpu.fx_tw >> i) & 1);
+    }
+    env->fpop =3D state->fpu.fx_opcode;
+    env->fpip =3D state->fpu.fx_ip.fa_64;
+    env->fpdp =3D state->fpu.fx_dp.fa_64;
+    env->mxcsr =3D state->fpu.fx_mxcsr;
+    assert(sizeof(state->fpu.fx_87_ac) =3D=3D sizeof(env->fpregs));
+    memcpy(env->fpregs, state->fpu.fx_87_ac, sizeof(env->fpregs));
+    for (i =3D 0; i < 16; i++) {
+        memcpy(&env->xmm_regs[i].ZMM_Q(0),
+            &state->fpu.fx_xmm[i].xmm_bytes[0], 8);
+        memcpy(&env->xmm_regs[i].ZMM_Q(1),
+            &state->fpu.fx_xmm[i].xmm_bytes[8], 8);
+    }
+
+    /* MSRs. */
+    env->efer =3D state->msrs[NVMM_X64_MSR_EFER];
+    env->star =3D state->msrs[NVMM_X64_MSR_STAR];
+#ifdef TARGET_X86_64
+    env->lstar =3D state->msrs[NVMM_X64_MSR_LSTAR];
+    env->cstar =3D state->msrs[NVMM_X64_MSR_CSTAR];
+    env->fmask =3D state->msrs[NVMM_X64_MSR_SFMASK];
+    env->kernelgsbase =3D state->msrs[NVMM_X64_MSR_KERNELGSBASE];
+#endif
+    env->sysenter_cs  =3D state->msrs[NVMM_X64_MSR_SYSENTER_CS];
+    env->sysenter_esp =3D state->msrs[NVMM_X64_MSR_SYSENTER_ESP];
+    env->sysenter_eip =3D state->msrs[NVMM_X64_MSR_SYSENTER_EIP];
+    env->pat =3D state->msrs[NVMM_X64_MSR_PAT];
+    env->tsc =3D state->msrs[NVMM_X64_MSR_TSC];
+
+    x86_update_hflags(env);
+}
+
+static bool
+nvmm_can_take_int(CPUState *cpu)
+{
+    struct CPUX86State *env =3D (CPUArchState *)cpu->env_ptr;
+    struct qemu_vcpu *qcpu =3D get_qemu_vcpu(cpu);
+    struct nvmm_vcpu *vcpu =3D &qcpu->vcpu;
+    struct nvmm_machine *mach =3D get_nvmm_mach();
+
+    if (qcpu->int_window_exit) {
+        return false;
+    }
+
+    if (qcpu->int_shadow || !(env->eflags & IF_MASK)) {
+        struct nvmm_x64_state *state =3D vcpu->state;
+
+        /* Exit on interrupt window. */
+        nvmm_vcpu_getstate(mach, vcpu, NVMM_X64_STATE_INTR);
+        state->intr.int_window_exiting =3D 1;
+        nvmm_vcpu_setstate(mach, vcpu, NVMM_X64_STATE_INTR);
+
+        return false;
+    }
+
+    return true;
+}
+
+static bool
+nvmm_can_take_nmi(CPUState *cpu)
+{
+    struct qemu_vcpu *qcpu =3D get_qemu_vcpu(cpu);
+
+    /*
+     * Contrary to INTs, NMIs always schedule an exit when they are
+     * completed. Therefore, if window-exiting is enabled, it means
+     * NMIs are blocked.
+     */
+    if (qcpu->nmi_window_exit) {
+        return false;
+    }
+
+    return true;
+}
+
+/*
+ * Called before the VCPU is run. We inject events generated by the I/O
+ * thread, and synchronize the guest TPR.
+ */
+static void
+nvmm_vcpu_pre_run(CPUState *cpu)
+{
+    struct CPUX86State *env =3D (CPUArchState *)cpu->env_ptr;
+    struct nvmm_machine *mach =3D get_nvmm_mach();
+    struct qemu_vcpu *qcpu =3D get_qemu_vcpu(cpu);
+    struct nvmm_vcpu *vcpu =3D &qcpu->vcpu;
+    X86CPU *x86_cpu =3D X86_CPU(cpu);
+    struct nvmm_x64_state *state =3D vcpu->state;
+    struct nvmm_vcpu_event *event =3D vcpu->event;
+    bool has_event =3D false;
+    bool sync_tpr =3D false;
+    uint8_t tpr;
+    int ret;
+
+    qemu_mutex_lock_iothread();
+
+    tpr =3D cpu_get_apic_tpr(x86_cpu->apic_state);
+    if (tpr !=3D qcpu->tpr) {
+        qcpu->tpr =3D tpr;
+        sync_tpr =3D true;
+    }
+
+    /*
+     * Force the VCPU out of its inner loop to process any INIT requests
+     * or commit pending TPR access.
+     */
+    if (cpu->interrupt_request & (CPU_INTERRUPT_INIT | CPU_INTERRUPT_TPR)=
) {
+        cpu->exit_request =3D 1;
+    }
+
+    if (!has_event && (cpu->interrupt_request & CPU_INTERRUPT_NMI)) {
+        if (nvmm_can_take_nmi(cpu)) {
+            cpu->interrupt_request &=3D ~CPU_INTERRUPT_NMI;
+            event->type =3D NVMM_VCPU_EVENT_INTR;
+            event->vector =3D 2;
+            has_event =3D true;
+        }
+    }
+
+    if (!has_event && (cpu->interrupt_request & CPU_INTERRUPT_HARD)) {
+        if (nvmm_can_take_int(cpu)) {
+            cpu->interrupt_request &=3D ~CPU_INTERRUPT_HARD;
+            event->type =3D NVMM_VCPU_EVENT_INTR;
+            event->vector =3D cpu_get_pic_interrupt(env);
+            has_event =3D true;
+        }
+    }
+
+    /* Don't want SMIs. */
+    if (cpu->interrupt_request & CPU_INTERRUPT_SMI) {
+        cpu->interrupt_request &=3D ~CPU_INTERRUPT_SMI;
+    }
+
+    if (sync_tpr) {
+        ret =3D nvmm_vcpu_getstate(mach, vcpu, NVMM_X64_STATE_CRS);
+        if (ret =3D=3D -1) {
+            error_report("NVMM: Failed to get CPU state,"
+                " error=3D%d", errno);
+        }
+
+        state->crs[NVMM_X64_CR_CR8] =3D qcpu->tpr;
+
+        ret =3D nvmm_vcpu_setstate(mach, vcpu, NVMM_X64_STATE_CRS);
+        if (ret =3D=3D -1) {
+            error_report("NVMM: Failed to set CPU state,"
+                " error=3D%d", errno);
+        }
+    }
+
+    if (has_event) {
+        ret =3D nvmm_vcpu_inject(mach, vcpu);
+        if (ret =3D=3D -1) {
+            error_report("NVMM: Failed to inject event,"
+                " error=3D%d", errno);
+        }
+    }
+
+    qemu_mutex_unlock_iothread();
+}
+
+/*
+ * Called after the VCPU ran. We synchronize the host view of the TPR and
+ * RFLAGS.
+ */
+static void
+nvmm_vcpu_post_run(CPUState *cpu, struct nvmm_vcpu_exit *exit)
+{
+    struct qemu_vcpu *qcpu =3D get_qemu_vcpu(cpu);
+    struct CPUX86State *env =3D (CPUArchState *)cpu->env_ptr;
+    X86CPU *x86_cpu =3D X86_CPU(cpu);
+    uint64_t tpr;
+
+    env->eflags =3D exit->exitstate.rflags;
+    qcpu->int_shadow =3D exit->exitstate.int_shadow;
+    qcpu->int_window_exit =3D exit->exitstate.int_window_exiting;
+    qcpu->nmi_window_exit =3D exit->exitstate.nmi_window_exiting;
+
+    tpr =3D exit->exitstate.cr8;
+    if (qcpu->tpr !=3D tpr) {
+        qcpu->tpr =3D tpr;
+        qemu_mutex_lock_iothread();
+        cpu_set_apic_tpr(x86_cpu->apic_state, qcpu->tpr);
+        qemu_mutex_unlock_iothread();
+    }
+}
+
+/* ----------------------------------------------------------------------=
---- */
+
+static void
+nvmm_io_callback(struct nvmm_io *io)
+{
+    MemTxAttrs attrs =3D { 0 };
+    int ret;
+
+    ret =3D address_space_rw(&address_space_io, io->port, attrs, io->data=
,
+        io->size, !io->in);
+    if (ret !=3D MEMTX_OK) {
+        error_report("NVMM: I/O Transaction Failed "
+            "[%s, port=3D%u, size=3D%zu]", (io->in ? "in" : "out"),
+            io->port, io->size);
+    }
+
+    /* Needed, otherwise infinite loop. */
+    current_cpu->vcpu_dirty =3D false;
+}
+
+static void
+nvmm_mem_callback(struct nvmm_mem *mem)
+{
+    cpu_physical_memory_rw(mem->gpa, mem->data, mem->size, mem->write);
+
+    /* XXX Needed, otherwise infinite loop. */
+    current_cpu->vcpu_dirty =3D false;
+}
+
+static struct nvmm_assist_callbacks nvmm_callbacks =3D {
+    .io =3D nvmm_io_callback,
+    .mem =3D nvmm_mem_callback
+};
+
+/* ----------------------------------------------------------------------=
---- */
+
+static int
+nvmm_handle_mem(struct nvmm_machine *mach, struct nvmm_vcpu *vcpu)
+{
+    int ret;
+
+    ret =3D nvmm_assist_mem(mach, vcpu);
+    if (ret =3D=3D -1) {
+        error_report("NVMM: Mem Assist Failed [gpa=3D%p]",
+            (void *)vcpu->exit->u.mem.gpa);
+    }
+
+    return ret;
+}
+
+static int
+nvmm_handle_io(struct nvmm_machine *mach, struct nvmm_vcpu *vcpu)
+{
+    int ret;
+
+    ret =3D nvmm_assist_io(mach, vcpu);
+    if (ret =3D=3D -1) {
+        error_report("NVMM: I/O Assist Failed [port=3D%d]",
+            (int)vcpu->exit->u.io.port);
+    }
+
+    return ret;
+}
+
+static int
+nvmm_handle_rdmsr(struct nvmm_machine *mach, CPUState *cpu,
+    struct nvmm_vcpu_exit *exit)
+{
+    struct qemu_vcpu *qcpu =3D get_qemu_vcpu(cpu);
+    struct nvmm_vcpu *vcpu =3D &qcpu->vcpu;
+    X86CPU *x86_cpu =3D X86_CPU(cpu);
+    struct nvmm_x64_state *state =3D vcpu->state;
+    uint64_t val;
+    int ret;
+
+    switch (exit->u.rdmsr.msr) {
+    case MSR_IA32_APICBASE:
+        val =3D cpu_get_apic_base(x86_cpu->apic_state);
+        break;
+    case MSR_MTRRcap:
+    case MSR_MTRRdefType:
+    case MSR_MCG_CAP:
+    case MSR_MCG_STATUS:
+        val =3D 0;
+        break;
+    default: /* More MSRs to add? */
+        val =3D 0;
+        error_report("NVMM: Unexpected RDMSR 0x%x, ignored",
+            exit->u.rdmsr.msr);
+        break;
+    }
+
+    ret =3D nvmm_vcpu_getstate(mach, vcpu, NVMM_X64_STATE_GPRS);
+    if (ret =3D=3D -1) {
+        return -1;
+    }
+
+    state->gprs[NVMM_X64_GPR_RAX] =3D (val & 0xFFFFFFFF);
+    state->gprs[NVMM_X64_GPR_RDX] =3D (val >> 32);
+    state->gprs[NVMM_X64_GPR_RIP] =3D exit->u.rdmsr.npc;
+
+    ret =3D nvmm_vcpu_setstate(mach, vcpu, NVMM_X64_STATE_GPRS);
+    if (ret =3D=3D -1) {
+        return -1;
+    }
+
+    return 0;
+}
+
+static int
+nvmm_handle_wrmsr(struct nvmm_machine *mach, CPUState *cpu,
+    struct nvmm_vcpu_exit *exit)
+{
+    struct qemu_vcpu *qcpu =3D get_qemu_vcpu(cpu);
+    struct nvmm_vcpu *vcpu =3D &qcpu->vcpu;
+    X86CPU *x86_cpu =3D X86_CPU(cpu);
+    struct nvmm_x64_state *state =3D vcpu->state;
+    uint64_t val;
+    int ret;
+
+    val =3D exit->u.wrmsr.val;
+
+    switch (exit->u.wrmsr.msr) {
+    case MSR_IA32_APICBASE:
+        cpu_set_apic_base(x86_cpu->apic_state, val);
+        break;
+    case MSR_MTRRdefType:
+    case MSR_MCG_STATUS:
+        break;
+    default: /* More MSRs to add? */
+        error_report("NVMM: Unexpected WRMSR 0x%x [val=3D0x%lx], ignored"=
,
+            exit->u.wrmsr.msr, val);
+        break;
+    }
+
+    ret =3D nvmm_vcpu_getstate(mach, vcpu, NVMM_X64_STATE_GPRS);
+    if (ret =3D=3D -1) {
+        return -1;
+    }
+
+    state->gprs[NVMM_X64_GPR_RIP] =3D exit->u.wrmsr.npc;
+
+    ret =3D nvmm_vcpu_setstate(mach, vcpu, NVMM_X64_STATE_GPRS);
+    if (ret =3D=3D -1) {
+        return -1;
+    }
+
+    return 0;
+}
+
+static int
+nvmm_handle_halted(struct nvmm_machine *mach, CPUState *cpu,
+    struct nvmm_vcpu_exit *exit)
+{
+    struct CPUX86State *env =3D (CPUArchState *)cpu->env_ptr;
+    int ret =3D 0;
+
+    qemu_mutex_lock_iothread();
+
+    if (!((cpu->interrupt_request & CPU_INTERRUPT_HARD) &&
+          (env->eflags & IF_MASK)) &&
+        !(cpu->interrupt_request & CPU_INTERRUPT_NMI)) {
+        cpu->exception_index =3D EXCP_HLT;
+        cpu->halted =3D true;
+        ret =3D 1;
+    }
+
+    qemu_mutex_unlock_iothread();
+
+    return ret;
+}
+
+static int
+nvmm_inject_ud(struct nvmm_machine *mach, struct nvmm_vcpu *vcpu)
+{
+    struct nvmm_vcpu_event *event =3D vcpu->event;
+
+    event->type =3D NVMM_VCPU_EVENT_EXCP;
+    event->vector =3D 6;
+    event->u.excp.error =3D 0;
+
+    return nvmm_vcpu_inject(mach, vcpu);
+}
+
+static int
+nvmm_vcpu_loop(CPUState *cpu)
+{
+    struct CPUX86State *env =3D (CPUArchState *)cpu->env_ptr;
+    struct nvmm_machine *mach =3D get_nvmm_mach();
+    struct qemu_vcpu *qcpu =3D get_qemu_vcpu(cpu);
+    struct nvmm_vcpu *vcpu =3D &qcpu->vcpu;
+    X86CPU *x86_cpu =3D X86_CPU(cpu);
+    struct nvmm_vcpu_exit *exit =3D vcpu->exit;
+    int ret;
+
+    /*
+     * Some asynchronous events must be handled outside of the inner
+     * VCPU loop. They are handled here.
+     */
+    if (cpu->interrupt_request & CPU_INTERRUPT_INIT) {
+        nvmm_cpu_synchronize_state(cpu);
+        do_cpu_init(x86_cpu);
+        /* set int/nmi windows back to the reset state */
+    }
+    if (cpu->interrupt_request & CPU_INTERRUPT_POLL) {
+        cpu->interrupt_request &=3D ~CPU_INTERRUPT_POLL;
+        apic_poll_irq(x86_cpu->apic_state);
+    }
+    if (((cpu->interrupt_request & CPU_INTERRUPT_HARD) &&
+         (env->eflags & IF_MASK)) ||
+        (cpu->interrupt_request & CPU_INTERRUPT_NMI)) {
+        cpu->halted =3D false;
+    }
+    if (cpu->interrupt_request & CPU_INTERRUPT_SIPI) {
+        nvmm_cpu_synchronize_state(cpu);
+        do_cpu_sipi(x86_cpu);
+    }
+    if (cpu->interrupt_request & CPU_INTERRUPT_TPR) {
+        cpu->interrupt_request &=3D ~CPU_INTERRUPT_TPR;
+        nvmm_cpu_synchronize_state(cpu);
+        apic_handle_tpr_access_report(x86_cpu->apic_state, env->eip,
+            env->tpr_access_type);
+    }
+
+    if (cpu->halted) {
+        cpu->exception_index =3D EXCP_HLT;
+        atomic_set(&cpu->exit_request, false);
+        return 0;
+    }
+
+    qemu_mutex_unlock_iothread();
+    cpu_exec_start(cpu);
+
+    /*
+     * Inner VCPU loop.
+     */
+    do {
+        if (cpu->vcpu_dirty) {
+            nvmm_set_registers(cpu);
+            cpu->vcpu_dirty =3D false;
+        }
+
+        if (qcpu->stop) {
+            cpu->exception_index =3D EXCP_INTERRUPT;
+            qcpu->stop =3D false;
+            ret =3D 1;
+            break;
+        }
+
+        nvmm_vcpu_pre_run(cpu);
+
+        if (atomic_read(&cpu->exit_request)) {
+            qemu_cpu_kick_self();
+        }
+
+        ret =3D nvmm_vcpu_run(mach, vcpu);
+        if (ret =3D=3D -1) {
+            error_report("NVMM: Failed to exec a virtual processor,"
+                " error=3D%d", errno);
+            break;
+        }
+
+        nvmm_vcpu_post_run(cpu, exit);
+
+        switch (exit->reason) {
+        case NVMM_VCPU_EXIT_NONE:
+            break;
+        case NVMM_VCPU_EXIT_MEMORY:
+            ret =3D nvmm_handle_mem(mach, vcpu);
+            break;
+        case NVMM_VCPU_EXIT_IO:
+            ret =3D nvmm_handle_io(mach, vcpu);
+            break;
+        case NVMM_VCPU_EXIT_INT_READY:
+        case NVMM_VCPU_EXIT_NMI_READY:
+        case NVMM_VCPU_EXIT_TPR_CHANGED:
+            break;
+        case NVMM_VCPU_EXIT_HALTED:
+            ret =3D nvmm_handle_halted(mach, cpu, exit);
+            break;
+        case NVMM_VCPU_EXIT_SHUTDOWN:
+            qemu_system_reset_request(SHUTDOWN_CAUSE_GUEST_RESET);
+            cpu->exception_index =3D EXCP_INTERRUPT;
+            ret =3D 1;
+            break;
+        case NVMM_VCPU_EXIT_RDMSR:
+            ret =3D nvmm_handle_rdmsr(mach, cpu, exit);
+            break;
+        case NVMM_VCPU_EXIT_WRMSR:
+            ret =3D nvmm_handle_wrmsr(mach, cpu, exit);
+            break;
+        case NVMM_VCPU_EXIT_MONITOR:
+        case NVMM_VCPU_EXIT_MWAIT:
+            ret =3D nvmm_inject_ud(mach, vcpu);
+            break;
+        default:
+            error_report("NVMM: Unexpected VM exit code 0x%lx [hw=3D0x%lx=
]",
+                exit->reason, exit->u.inv.hwcode);
+            nvmm_get_registers(cpu);
+            qemu_mutex_lock_iothread();
+            qemu_system_guest_panicked(cpu_get_crash_info(cpu));
+            qemu_mutex_unlock_iothread();
+            ret =3D -1;
+            break;
+        }
+    } while (ret =3D=3D 0);
+
+    cpu_exec_end(cpu);
+    qemu_mutex_lock_iothread();
+    current_cpu =3D cpu;
+
+    atomic_set(&cpu->exit_request, false);
+
+    return ret < 0;
+}
+
+/* ----------------------------------------------------------------------=
---- */
+
+static void
+do_nvmm_cpu_synchronize_state(CPUState *cpu, run_on_cpu_data arg)
+{
+    nvmm_get_registers(cpu);
+    cpu->vcpu_dirty =3D true;
+}
+
+static void
+do_nvmm_cpu_synchronize_post_reset(CPUState *cpu, run_on_cpu_data arg)
+{
+    nvmm_set_registers(cpu);
+    cpu->vcpu_dirty =3D false;
+}
+
+static void
+do_nvmm_cpu_synchronize_post_init(CPUState *cpu, run_on_cpu_data arg)
+{
+    nvmm_set_registers(cpu);
+    cpu->vcpu_dirty =3D false;
+}
+
+static void
+do_nvmm_cpu_synchronize_pre_loadvm(CPUState *cpu, run_on_cpu_data arg)
+{
+    cpu->vcpu_dirty =3D true;
+}
+
+void nvmm_cpu_synchronize_state(CPUState *cpu)
+{
+    if (!cpu->vcpu_dirty) {
+        run_on_cpu(cpu, do_nvmm_cpu_synchronize_state, RUN_ON_CPU_NULL);
+    }
+}
+
+void nvmm_cpu_synchronize_post_reset(CPUState *cpu)
+{
+    run_on_cpu(cpu, do_nvmm_cpu_synchronize_post_reset, RUN_ON_CPU_NULL);
+}
+
+void nvmm_cpu_synchronize_post_init(CPUState *cpu)
+{
+    run_on_cpu(cpu, do_nvmm_cpu_synchronize_post_init, RUN_ON_CPU_NULL);
+}
+
+void nvmm_cpu_synchronize_pre_loadvm(CPUState *cpu)
+{
+    run_on_cpu(cpu, do_nvmm_cpu_synchronize_pre_loadvm, RUN_ON_CPU_NULL);
+}
+
+/* ----------------------------------------------------------------------=
---- */
+
+static Error *nvmm_migration_blocker;
+
+static void
+nvmm_ipi_signal(int sigcpu)
+{
+    struct qemu_vcpu *qcpu;
+
+    if (current_cpu) {
+        qcpu =3D get_qemu_vcpu(current_cpu);
+        qcpu->stop =3D true;
+    }
+}
+
+static void
+nvmm_init_cpu_signals(void)
+{
+    struct sigaction sigact;
+    sigset_t set;
+
+    /* Install the IPI handler. */
+    memset(&sigact, 0, sizeof(sigact));
+    sigact.sa_handler =3D nvmm_ipi_signal;
+    sigaction(SIG_IPI, &sigact, NULL);
+
+    /* Allow IPIs on the current thread. */
+    sigprocmask(SIG_BLOCK, NULL, &set);
+    sigdelset(&set, SIG_IPI);
+    pthread_sigmask(SIG_SETMASK, &set, NULL);
+}
+
+int
+nvmm_init_vcpu(CPUState *cpu)
+{
+    struct nvmm_machine *mach =3D get_nvmm_mach();
+    struct nvmm_vcpu_conf_cpuid cpuid;
+    struct nvmm_vcpu_conf_tpr tpr;
+    Error *local_error =3D NULL;
+    struct qemu_vcpu *qcpu;
+    int ret, err;
+
+    nvmm_init_cpu_signals();
+
+    if (nvmm_migration_blocker =3D=3D NULL) {
+        error_setg(&nvmm_migration_blocker,
+            "NVMM: Migration not supported");
+
+        (void)migrate_add_blocker(nvmm_migration_blocker, &local_error);
+        if (local_error) {
+            error_report_err(local_error);
+            migrate_del_blocker(nvmm_migration_blocker);
+            error_free(nvmm_migration_blocker);
+            return -EINVAL;
+        }
+    }
+
+    qcpu =3D g_malloc0(sizeof(*qcpu));
+    if (qcpu =3D=3D NULL) {
+        error_report("NVMM: Failed to allocate VCPU context.");
+        return -ENOMEM;
+    }
+
+    ret =3D nvmm_vcpu_create(mach, cpu->cpu_index, &qcpu->vcpu);
+    if (ret =3D=3D -1) {
+        err =3D errno;
+        error_report("NVMM: Failed to create a virtual processor,"
+            " error=3D%d", err);
+        g_free(qcpu);
+        return -err;
+    }
+
+    memset(&cpuid, 0, sizeof(cpuid));
+    cpuid.mask =3D 1;
+    cpuid.leaf =3D 0x00000001;
+    cpuid.u.mask.set.edx =3D CPUID_MCE | CPUID_MCA | CPUID_MTRR;
+    ret =3D nvmm_vcpu_configure(mach, &qcpu->vcpu, NVMM_VCPU_CONF_CPUID,
+        &cpuid);
+    if (ret =3D=3D -1) {
+        err =3D errno;
+        error_report("NVMM: Failed to configure a virtual processor,"
+            " error=3D%d", err);
+        g_free(qcpu);
+        return -err;
+    }
+
+    ret =3D nvmm_vcpu_configure(mach, &qcpu->vcpu, NVMM_VCPU_CONF_CALLBAC=
KS,
+        &nvmm_callbacks);
+    if (ret =3D=3D -1) {
+        err =3D errno;
+        error_report("NVMM: Failed to configure a virtual processor,"
+            " error=3D%d", err);
+        g_free(qcpu);
+        return -err;
+    }
+
+    if (qemu_mach.cap.arch.vcpu_conf_support & NVMM_CAP_ARCH_VCPU_CONF_TP=
R) {
+        memset(&tpr, 0, sizeof(tpr));
+        tpr.exit_changed =3D 1;
+        ret =3D nvmm_vcpu_configure(mach, &qcpu->vcpu, NVMM_VCPU_CONF_TPR=
, &tpr);
+        if (ret =3D=3D -1) {
+            err =3D errno;
+            error_report("NVMM: Failed to configure a virtual processor,"
+                " error=3D%d", err);
+            g_free(qcpu);
+            return -err;
+        }
+    }
+
+    cpu->vcpu_dirty =3D true;
+    cpu->hax_vcpu =3D (struct hax_vcpu_state *)qcpu;
+
+    return 0;
+}
+
+int
+nvmm_vcpu_exec(CPUState *cpu)
+{
+    int ret, fatal;
+
+    while (1) {
+        if (cpu->exception_index >=3D EXCP_INTERRUPT) {
+            ret =3D cpu->exception_index;
+            cpu->exception_index =3D -1;
+            break;
+        }
+
+        fatal =3D nvmm_vcpu_loop(cpu);
+
+        if (fatal) {
+            error_report("NVMM: Failed to execute a VCPU.");
+            abort();
+        }
+    }
+
+    return ret;
+}
+
+void
+nvmm_destroy_vcpu(CPUState *cpu)
+{
+    struct nvmm_machine *mach =3D get_nvmm_mach();
+    struct qemu_vcpu *qcpu =3D get_qemu_vcpu(cpu);
+
+    nvmm_vcpu_destroy(mach, &qcpu->vcpu);
+    g_free(cpu->hax_vcpu);
+}
+
+/* ----------------------------------------------------------------------=
---- */
+
+static void
+nvmm_update_mapping(hwaddr start_pa, ram_addr_t size, uintptr_t hva,
+    bool add, bool rom, const char *name)
+{
+    struct nvmm_machine *mach =3D get_nvmm_mach();
+    int ret, prot;
+
+    if (add) {
+        prot =3D PROT_READ | PROT_EXEC;
+        if (!rom) {
+            prot |=3D PROT_WRITE;
+        }
+        ret =3D nvmm_gpa_map(mach, hva, start_pa, size, prot);
+    } else {
+        ret =3D nvmm_gpa_unmap(mach, hva, start_pa, size);
+    }
+
+    if (ret =3D=3D -1) {
+        error_report("NVMM: Failed to %s GPA range '%s' PA:%p, "
+            "Size:%p bytes, HostVA:%p, error=3D%d",
+            (add ? "map" : "unmap"), name, (void *)(uintptr_t)start_pa,
+            (void *)size, (void *)hva, errno);
+    }
+}
+
+static void
+nvmm_process_section(MemoryRegionSection *section, int add)
+{
+    MemoryRegion *mr =3D section->mr;
+    hwaddr start_pa =3D section->offset_within_address_space;
+    ram_addr_t size =3D int128_get64(section->size);
+    unsigned int delta;
+    uintptr_t hva;
+
+    if (!memory_region_is_ram(mr)) {
+        return;
+    }
+
+    /* Adjust start_pa and size so that they are page-aligned. */
+    delta =3D qemu_real_host_page_size - (start_pa & ~qemu_real_host_page=
_mask);
+    delta &=3D ~qemu_real_host_page_mask;
+    if (delta > size) {
+        return;
+    }
+    start_pa +=3D delta;
+    size -=3D delta;
+    size &=3D qemu_real_host_page_mask;
+    if (!size || (start_pa & ~qemu_real_host_page_mask)) {
+        return;
+    }
+
+    hva =3D (uintptr_t)memory_region_get_ram_ptr(mr) +
+        section->offset_within_region + delta;
+
+    nvmm_update_mapping(start_pa, size, hva, add,
+        memory_region_is_rom(mr), mr->name);
+}
+
+static void
+nvmm_region_add(MemoryListener *listener, MemoryRegionSection *section)
+{
+    memory_region_ref(section->mr);
+    nvmm_process_section(section, 1);
+}
+
+static void
+nvmm_region_del(MemoryListener *listener, MemoryRegionSection *section)
+{
+    nvmm_process_section(section, 0);
+    memory_region_unref(section->mr);
+}
+
+static void
+nvmm_transaction_begin(MemoryListener *listener)
+{
+    /* nothing */
+}
+
+static void
+nvmm_transaction_commit(MemoryListener *listener)
+{
+    /* nothing */
+}
+
+static void
+nvmm_log_sync(MemoryListener *listener, MemoryRegionSection *section)
+{
+    MemoryRegion *mr =3D section->mr;
+
+    if (!memory_region_is_ram(mr)) {
+        return;
+    }
+
+    memory_region_set_dirty(mr, 0, int128_get64(section->size));
+}
+
+static MemoryListener nvmm_memory_listener =3D {
+    .begin =3D nvmm_transaction_begin,
+    .commit =3D nvmm_transaction_commit,
+    .region_add =3D nvmm_region_add,
+    .region_del =3D nvmm_region_del,
+    .log_sync =3D nvmm_log_sync,
+    .priority =3D 10,
+};
+
+static void
+nvmm_ram_block_added(RAMBlockNotifier *n, void *host, size_t size)
+{
+    struct nvmm_machine *mach =3D get_nvmm_mach();
+    uintptr_t hva =3D (uintptr_t)host;
+    int ret;
+
+    ret =3D nvmm_hva_map(mach, hva, size);
+
+    if (ret =3D=3D -1) {
+        error_report("NVMM: Failed to map HVA, HostVA:%p "
+            "Size:%p bytes, error=3D%d",
+            (void *)hva, (void *)size, errno);
+    }
+}
+
+static struct RAMBlockNotifier nvmm_ram_notifier =3D {
+    .ram_block_added =3D nvmm_ram_block_added
+};
+
+/* ----------------------------------------------------------------------=
---- */
+
+static void
+nvmm_handle_interrupt(CPUState *cpu, int mask)
+{
+    cpu->interrupt_request |=3D mask;
+
+    if (!qemu_cpu_is_self(cpu)) {
+        qemu_cpu_kick(cpu);
+    }
+}
+
+/* ----------------------------------------------------------------------=
---- */
+
+static int
+nvmm_accel_init(MachineState *ms)
+{
+    int ret, err;
+
+    ret =3D nvmm_init();
+    if (ret =3D=3D -1) {
+        err =3D errno;
+        error_report("NVMM: Initialization failed, error=3D%d", errno);
+        return -err;
+    }
+
+    ret =3D nvmm_capability(&qemu_mach.cap);
+    if (ret =3D=3D -1) {
+        err =3D errno;
+        error_report("NVMM: Unable to fetch capability, error=3D%d", errn=
o);
+        return -err;
+    }
+    if (qemu_mach.cap.version !=3D 1) {
+        error_report("NVMM: Unsupported version %u", qemu_mach.cap.versio=
n);
+        return -EPROGMISMATCH;
+    }
+    if (qemu_mach.cap.state_size !=3D sizeof(struct nvmm_x64_state)) {
+        error_report("NVMM: Wrong state size %u", qemu_mach.cap.state_siz=
e);
+        return -EPROGMISMATCH;
+    }
+
+    ret =3D nvmm_machine_create(&qemu_mach.mach);
+    if (ret =3D=3D -1) {
+        err =3D errno;
+        error_report("NVMM: Machine creation failed, error=3D%d", errno);
+        return -err;
+    }
+
+    memory_listener_register(&nvmm_memory_listener, &address_space_memory=
);
+    ram_block_notifier_add(&nvmm_ram_notifier);
+
+    cpu_interrupt_handler =3D nvmm_handle_interrupt;
+
+    printf("NetBSD Virtual Machine Monitor accelerator is operational\n")=
;
+    return 0;
+}
+
+int
+nvmm_enabled(void)
+{
+    return nvmm_allowed;
+}
+
+static void
+nvmm_accel_class_init(ObjectClass *oc, void *data)
+{
+    AccelClass *ac =3D ACCEL_CLASS(oc);
+    ac->name =3D "NVMM";
+    ac->init_machine =3D nvmm_accel_init;
+    ac->allowed =3D &nvmm_allowed;
+}
+
+static const TypeInfo nvmm_accel_type =3D {
+    .name =3D ACCEL_CLASS_NAME("nvmm"),
+    .parent =3D TYPE_ACCEL,
+    .class_init =3D nvmm_accel_class_init,
+};
+
+static void
+nvmm_type_init(void)
+{
+    type_register_static(&nvmm_accel_type);
+}
+
+type_init(nvmm_type_init);
=2D-
2.25.0


