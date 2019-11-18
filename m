Return-Path: <SRS0=aBJE=ZL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 638F5C432C0
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Nov 2019 00:00:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 06B4D2230B
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Nov 2019 00:00:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="KnQ9fKk7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 06B4D2230B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=quicinc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40584 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iWqw5-0003vN-7y
	for qemu-devel@archiver.kernel.org; Mon, 18 Nov 2019 19:00:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:54436)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <tsimpson@qualcomm.com>) id 1iWqvE-0003SD-C0
 for qemu-devel@nongnu.org; Mon, 18 Nov 2019 18:59:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <tsimpson@qualcomm.com>) id 1iWqv6-0004RP-Pd
 for qemu-devel@nongnu.org; Mon, 18 Nov 2019 18:59:07 -0500
Received: from alexa-out-sd-02.qualcomm.com ([199.106.114.39]:31308)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <tsimpson@qualcomm.com>)
 id 1iWqv6-0004Qp-6Q
 for qemu-devel@nongnu.org; Mon, 18 Nov 2019 18:59:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
 t=1574121540; x=1605657540;
 h=from:to:cc:subject:date:message-id;
 bh=y9aOrU4n8MXZrK+NYeryXL/L2Dmv22ou1ZDfNHMaycc=;
 b=KnQ9fKk7M+rOi/V5CMktZafd/NOghej2aMYy718YPFg7NSYK6LFupavr
 IPX+SyEY+6iLvFtSVnjVXBZCr29qxvsx8xM8D47t8AwgRx1B9Gv+C/4SI
 qoQdTrNm7Uoc62ncZ08mKNxIv3Kv4kQVtLv/Dfuwe1982PGADV1YSO8q5 M=;
Received: from unknown (HELO ironmsg02-sd.qualcomm.com) ([10.53.140.142])
 by alexa-out-sd-02.qualcomm.com with ESMTP; 18 Nov 2019 15:58:57 -0800
IronPort-SDR: Pj1G5RPDze2tNN5ob2vH8kzBEGrnUgGovN3Z4IkvyWanWbqxaNZfcqwXfFCFWUDqJR3vK4uywP
 bWNTD7h6HW151Ovgf0ITIzQyPhFP1Lez+erwitj2yeDESeQSRIH7U9MJsX9v3EsnIm+dnoXRra
 67cCfujR1oSgKLU+ZQ0oKU7w6lVyrOX+URRqDtEA7gM2AcxwYBlMfQntbc8cLSDN0hpVcI/Y0m
 WTlaCowAnm9dTboCfuMpSgLfEZ7eLXICtj3slz0chl2WMcI+TplrFYUoC50JWg8RPqpyamQpQF
 WT5eTBQfr91ywChKUBZXUhmt
Received: from vu-tsimpson-aus.qualcomm.com (HELO
 vu-tsimpson1-aus.qualcomm.com) ([10.222.150.1])
 by ironmsg02-sd.qualcomm.com with ESMTP; 18 Nov 2019 15:58:56 -0800
Received: by vu-tsimpson1-aus.qualcomm.com (Postfix, from userid 47164)
 id 0D4B68DC; Mon, 18 Nov 2019 17:58:55 -0600 (CST)
From: Taylor Simpson <tsimpson@quicinc.com>
To: laurent@vivier.eu,
	riku.voipio@iki.fi,
	qemu-devel@nongnu.org
Subject: [PATCH] Add minimal Hexagon target - First in a series of patches -
 linux-user changes + linux-user/hexagon + skeleton of target/hexagon - Files
 in target/hexagon/imported are from another project and therefore do not
 conform to qemu coding standards
Date: Mon, 18 Nov 2019 17:58:17 -0600
Message-Id: <1574121497-2433-1-git-send-email-tsimpson@quicinc.com>
X-Mailer: git-send-email 2.7.4
X-detected-operating-system: by eggs.gnu.org: FreeBSD 9.x [fuzzy]
X-Received-From: 199.106.114.39
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
Cc: Taylor Simpson <tsimpson@quicinc.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Taylor Simpson <tsimpson@quicinc.com>
---
 configure                                   |   9 +
 default-configs/hexagon-linux-user.mak      |   1 +
 include/elf.h                               |   2 +
 linux-user/elfload.c                        |  16 ++
 linux-user/hexagon/cpu_loop.c               | 103 +++++++++
 linux-user/hexagon/signal.c                 | 276 +++++++++++++++++++++++
 linux-user/hexagon/sockbits.h               |   3 +
 linux-user/hexagon/syscall_nr.h             | 331 ++++++++++++++++++++++++++++
 linux-user/hexagon/target_cpu.h             |  35 +++
 linux-user/hexagon/target_elf.h             |  24 ++
 linux-user/hexagon/target_fcntl.h           |   3 +
 linux-user/hexagon/target_signal.h          |  19 ++
 linux-user/hexagon/target_structs.h         |  31 +++
 linux-user/hexagon/target_syscall.h         |  17 ++
 linux-user/hexagon/termbits.h               | 231 +++++++++++++++++++
 linux-user/signal.c                         |   8 +
 linux-user/syscall.c                        |   2 +
 linux-user/syscall_defs.h                   |  33 +++
 target/hexagon/Makefile.objs                |   6 +
 target/hexagon/cpu-param.h                  |  11 +
 target/hexagon/cpu.c                        | 283 ++++++++++++++++++++++++
 target/hexagon/cpu.h                        | 146 ++++++++++++
 target/hexagon/cpu_bits.h                   |  15 ++
 target/hexagon/helper.h                     |   3 +
 target/hexagon/imported/global_types.h      |  25 +++
 target/hexagon/imported/iss_ver_registers.h | 183 +++++++++++++++
 target/hexagon/imported/max.h               |  78 +++++++
 target/hexagon/imported/regs.h              |  19 ++
 target/hexagon/op_helper.c                  |  29 +++
 target/hexagon/translate.c                  | 220 ++++++++++++++++++
 target/hexagon/translate.h                  |  22 ++
 31 files changed, 2184 insertions(+)
 create mode 100644 default-configs/hexagon-linux-user.mak
 create mode 100644 linux-user/hexagon/cpu_loop.c
 create mode 100644 linux-user/hexagon/signal.c
 create mode 100644 linux-user/hexagon/sockbits.h
 create mode 100644 linux-user/hexagon/syscall_nr.h
 create mode 100644 linux-user/hexagon/target_cpu.h
 create mode 100644 linux-user/hexagon/target_elf.h
 create mode 100644 linux-user/hexagon/target_fcntl.h
 create mode 100644 linux-user/hexagon/target_signal.h
 create mode 100644 linux-user/hexagon/target_structs.h
 create mode 100644 linux-user/hexagon/target_syscall.h
 create mode 100644 linux-user/hexagon/termbits.h
 create mode 100644 target/hexagon/Makefile.objs
 create mode 100644 target/hexagon/cpu-param.h
 create mode 100644 target/hexagon/cpu.c
 create mode 100644 target/hexagon/cpu.h
 create mode 100644 target/hexagon/cpu_bits.h
 create mode 100644 target/hexagon/helper.h
 create mode 100644 target/hexagon/imported/global_types.h
 create mode 100644 target/hexagon/imported/iss_ver_registers.h
 create mode 100644 target/hexagon/imported/max.h
 create mode 100644 target/hexagon/imported/regs.h
 create mode 100644 target/hexagon/op_helper.c
 create mode 100644 target/hexagon/translate.c
 create mode 100644 target/hexagon/translate.h

diff --git a/configure b/configure
index efe165e..e15ef8c 100755
--- a/configure
+++ b/configure
@@ -7739,6 +7739,12 @@ case "$target_name" in
     bflt="yes"
     mttcg="yes"
   ;;
+  hexagon)
+    TARGET_BASE_ARCH=hexagon
+    TARGET_ABI_DIR=hexagon
+    mttcg=yes
+    target_compiler=$cross_cc_hexagon
+  ;;
   *)
     error_exit "Unsupported target CPU"
   ;;
@@ -7902,6 +7908,9 @@ for i in $ARCH $TARGET_BASE_ARCH ; do
   xtensa*)
     disas_config "XTENSA"
   ;;
+  hexagon)
+    disas_config "HEXAGON"
+  ;;
   esac
 done
 if test "$tcg_interpreter" = "yes" ; then
diff --git a/default-configs/hexagon-linux-user.mak b/default-configs/hexagon-linux-user.mak
new file mode 100644
index 0000000..ad55af0
--- /dev/null
+++ b/default-configs/hexagon-linux-user.mak
@@ -0,0 +1 @@
+# Default configuration for hexagon-linux-user
diff --git a/include/elf.h b/include/elf.h
index 3501e0c..efd1ad2 100644
--- a/include/elf.h
+++ b/include/elf.h
@@ -170,6 +170,8 @@ typedef struct mips_elf_abiflags_v0 {
 
 #define EM_UNICORE32    110     /* UniCore32 */
 
+#define EM_HEXAGON     164     /* Qualcomm Hexagon */
+
 #define EM_RISCV        243     /* RISC-V */
 
 #define EM_NANOMIPS     249     /* Wave Computing nanoMIPS */
diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index f6693e5..9d9542a 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -1504,6 +1504,22 @@ static void elf_core_copy_regs(target_elf_gregset_t *regs,
 
 #endif /* TARGET_XTENSA */
 
+#ifdef TARGET_HEXAGON
+
+#define ELF_START_MMAP 0x20000000
+
+#define ELF_CLASS       ELFCLASS32
+#define ELF_ARCH        EM_HEXAGON
+
+static inline void init_thread(struct target_pt_regs *regs,
+                               struct image_info *infop)
+{
+    regs->sepc = infop->entry;
+    regs->sp = infop->start_stack;
+}
+
+#endif /* TARGET_HEXAGON */
+
 #ifndef ELF_PLATFORM
 #define ELF_PLATFORM (NULL)
 #endif
diff --git a/linux-user/hexagon/cpu_loop.c b/linux-user/hexagon/cpu_loop.c
new file mode 100644
index 0000000..ad5977d
--- /dev/null
+++ b/linux-user/hexagon/cpu_loop.c
@@ -0,0 +1,103 @@
+/*
+ *  qemu user cpu loop
+ *
+ *  Copyright (c) 2003-2008 Fabrice Bellard
+ *  Copyright (c) 2019 Qualcomm Innovation Center, Inc. All Rights Reserved.
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License as published by
+ *  the Free Software Foundation; either version 2 of the License, or
+ *  (at your option) any later version.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License
+ *  along with this program; if not, see <http://www.gnu.org/licenses/>.
+ */
+
+#include "qemu/osdep.h"
+#include "qemu.h"
+#include "cpu_loop-common.h"
+#include "translate.h"
+
+void cpu_loop(CPUHexagonState *env)
+{
+    CPUState *cs = CPU(hexagon_env_get_cpu(env));
+    int trapnr;
+    target_ulong syscallnum;
+    target_ulong ret;
+
+    for (;;) {
+        cpu_exec_start(cs);
+        trapnr = cpu_exec(cs);
+        cpu_exec_end(cs);
+        process_queued_cpu_work(cs);
+
+        switch (trapnr) {
+        case EXCP_INTERRUPT:
+            /* just indicate that signals should be handled asap */
+            break;
+        case HEX_EXCP_TRAP0:
+            syscallnum = env->gpr[6];
+            env->gpr[HEX_REG_PC] += 4;
+#ifdef DEBUG_HEX
+            printf("syscall %d (%d, %d, %d, %d, %d, %d)\n",
+                             syscallnum,
+                             env->gpr[0],
+                             env->gpr[1],
+                             env->gpr[2],
+                             env->gpr[3],
+                             env->gpr[4],
+                             env->gpr[5]);
+#endif
+            ret = do_syscall(env,
+                             syscallnum,
+                             env->gpr[0],
+                             env->gpr[1],
+                             env->gpr[2],
+                             env->gpr[3],
+                             env->gpr[4],
+                             env->gpr[5],
+                             0, 0);
+            if (ret == -TARGET_ERESTARTSYS) {
+#ifdef DEBUG_HEX
+                printf("\tSyscall %d returned -TARGET_ERESTARTSYS\n",
+                    syscallnum);
+#endif
+                env->gpr[HEX_REG_PC] -= 4;
+            } else if (ret != -TARGET_QEMU_ESIGRETURN) {
+#ifdef DEBUG_HEX
+                printf("\tSyscall %d returned %d\n", syscallnum, ret);
+#endif
+                env->gpr[0] = ret;
+            }
+#ifdef DEBUG_HEX
+            else {
+                printf("\tSyscall %d returned -TARGET_QEMU_ESIGRETURN\n",
+                       syscallnum);
+            }
+#endif
+            break;
+        case HEX_EXCP_TRAP1:
+            EXCP_DUMP(env, "\nqemu: trap1 exception %#x - aborting\n",
+                     trapnr);
+            exit(EXIT_FAILURE);
+            break;
+        default:
+            EXCP_DUMP(env, "\nqemu: unhandled CPU exception %#x - aborting\n",
+                     trapnr);
+            exit(EXIT_FAILURE);
+        }
+
+        process_pending_signals(env);
+    }
+}
+
+void target_cpu_copy_regs(CPUArchState *env, struct target_pt_regs *regs)
+{
+    env->gpr[HEX_REG_PC] = regs->sepc;
+    env->gpr[HEX_REG_SP] = regs->sp;
+}
diff --git a/linux-user/hexagon/signal.c b/linux-user/hexagon/signal.c
new file mode 100644
index 0000000..e67c085
--- /dev/null
+++ b/linux-user/hexagon/signal.c
@@ -0,0 +1,276 @@
+/*
+ *  Emulation of Linux signals
+ *
+ *  Copyright (c) 2003 Fabrice Bellard
+ *  Copyright (c) 2019 Qualcomm Innovation Center, Inc. All Rights Reserved.
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License as published by
+ *  the Free Software Foundation; either version 2 of the License, or
+ *  (at your option) any later version.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License
+ *  along with this program; if not, see <http://www.gnu.org/licenses/>.
+ */
+#include "qemu/osdep.h"
+#include "qemu.h"
+#include "signal-common.h"
+#include "linux-user/trace.h"
+
+struct target_sigcontext {
+    target_ulong r0,  r1,  r2,  r3;
+    target_ulong r4,  r5,  r6,  r7;
+    target_ulong r8,  r9, r10, r11;
+    target_ulong r12, r13, r14, r15;
+    target_ulong r16, r17, r18, r19;
+    target_ulong r20, r21, r22, r23;
+    target_ulong r24, r25, r26, r27;
+    target_ulong r28, r29, r30, r31;
+    target_ulong sa0;
+    target_ulong lc0;
+    target_ulong sa1;
+    target_ulong lc1;
+    target_ulong m0;
+    target_ulong m1;
+    target_ulong usr;
+    target_ulong p3_0;
+    target_ulong gp;
+    target_ulong ugp;
+    target_ulong pc;
+    target_ulong cause;
+    target_ulong badva;
+    target_ulong pad1;
+    target_ulong pad2;
+    target_ulong pad3;
+};
+
+struct target_ucontext {
+    unsigned long uc_flags;
+    target_ulong uc_link; /* target pointer */
+    target_stack_t uc_stack;
+    struct target_sigcontext uc_mcontext;
+    target_sigset_t uc_sigmask;
+};
+
+struct target_rt_sigframe {
+    uint32_t tramp[2];
+    struct target_siginfo info;
+    struct target_ucontext uc;
+};
+
+static abi_ulong get_sigframe(struct target_sigaction *ka,
+                              CPUHexagonState *regs, size_t framesize)
+{
+    abi_ulong sp = get_sp_from_cpustate(regs);
+
+    /* This is the X/Open sanctioned signal stack switching.  */
+    sp = target_sigsp(sp, ka) - framesize;
+
+    sp &= ~7UL; /* align sp on 8-byte boundary */
+
+    return sp;
+}
+
+static void setup_sigcontext(struct target_sigcontext *sc, CPUHexagonState *env)
+{
+    __put_user(env->gpr[HEX_REG_R00], &sc->r0);
+    __put_user(env->gpr[HEX_REG_R01], &sc->r1);
+    __put_user(env->gpr[HEX_REG_R02], &sc->r2);
+    __put_user(env->gpr[HEX_REG_R03], &sc->r3);
+    __put_user(env->gpr[HEX_REG_R04], &sc->r4);
+    __put_user(env->gpr[HEX_REG_R05], &sc->r5);
+    __put_user(env->gpr[HEX_REG_R06], &sc->r6);
+    __put_user(env->gpr[HEX_REG_R07], &sc->r7);
+    __put_user(env->gpr[HEX_REG_R08], &sc->r8);
+    __put_user(env->gpr[HEX_REG_R09], &sc->r9);
+    __put_user(env->gpr[HEX_REG_R10], &sc->r10);
+    __put_user(env->gpr[HEX_REG_R11], &sc->r11);
+    __put_user(env->gpr[HEX_REG_R12], &sc->r12);
+    __put_user(env->gpr[HEX_REG_R13], &sc->r13);
+    __put_user(env->gpr[HEX_REG_R14], &sc->r14);
+    __put_user(env->gpr[HEX_REG_R15], &sc->r15);
+    __put_user(env->gpr[HEX_REG_R16], &sc->r16);
+    __put_user(env->gpr[HEX_REG_R17], &sc->r17);
+    __put_user(env->gpr[HEX_REG_R18], &sc->r18);
+    __put_user(env->gpr[HEX_REG_R19], &sc->r19);
+    __put_user(env->gpr[HEX_REG_R20], &sc->r20);
+    __put_user(env->gpr[HEX_REG_R21], &sc->r21);
+    __put_user(env->gpr[HEX_REG_R22], &sc->r22);
+    __put_user(env->gpr[HEX_REG_R23], &sc->r23);
+    __put_user(env->gpr[HEX_REG_R24], &sc->r24);
+    __put_user(env->gpr[HEX_REG_R25], &sc->r25);
+    __put_user(env->gpr[HEX_REG_R26], &sc->r26);
+    __put_user(env->gpr[HEX_REG_R27], &sc->r27);
+    __put_user(env->gpr[HEX_REG_R28], &sc->r28);
+    __put_user(env->gpr[HEX_REG_R29], &sc->r29);
+    __put_user(env->gpr[HEX_REG_R30], &sc->r30);
+    __put_user(env->gpr[HEX_REG_R31], &sc->r31);
+    __put_user(env->gpr[HEX_REG_SA0], &sc->sa0);
+    __put_user(env->gpr[HEX_REG_LC0], &sc->lc0);
+    __put_user(env->gpr[HEX_REG_SA1], &sc->sa1);
+    __put_user(env->gpr[HEX_REG_LC1], &sc->lc1);
+    __put_user(env->gpr[HEX_REG_M0], &sc->m0);
+    __put_user(env->gpr[HEX_REG_M1], &sc->m1);
+    __put_user(env->gpr[HEX_REG_USR], &sc->usr);
+    __put_user(env->gpr[HEX_REG_P3_0], &sc->p3_0);
+    __put_user(env->gpr[HEX_REG_GP], &sc->gp);
+    __put_user(env->gpr[HEX_REG_UGP], &sc->ugp);
+    __put_user(env->gpr[HEX_REG_PC], &sc->pc);
+}
+
+static void setup_ucontext(struct target_ucontext *uc,
+                           CPUHexagonState *env, target_sigset_t *set)
+{
+    __put_user(0,    &(uc->uc_flags));
+    __put_user(0,    &(uc->uc_link));
+
+    target_save_altstack(&uc->uc_stack, env);
+
+    int i;
+    for (i = 0; i < TARGET_NSIG_WORDS; i++) {
+        __put_user(set->sig[i], &(uc->uc_sigmask.sig[i]));
+    }
+
+    setup_sigcontext(&uc->uc_mcontext, env);
+}
+
+static inline void install_sigtramp(uint32_t *tramp)
+{
+    __put_user(0x7800d166, tramp + 0); /*  { r6=#__NR_rt_sigreturn } */
+    __put_user(0x5400c004, tramp + 1); /*  { trap0(#1) } */
+}
+
+void setup_rt_frame(int sig, struct target_sigaction *ka,
+                    target_siginfo_t *info,
+                    target_sigset_t *set, CPUHexagonState *env)
+{
+    abi_ulong frame_addr;
+    struct target_rt_sigframe *frame;
+
+    frame_addr = get_sigframe(ka, env, sizeof(*frame));
+    trace_user_setup_rt_frame(env, frame_addr);
+
+    if (!lock_user_struct(VERIFY_WRITE, frame, frame_addr, 0)) {
+        goto badframe;
+    }
+
+    setup_ucontext(&frame->uc, env, set);
+    tswap_siginfo(&frame->info, info);
+    install_sigtramp(frame->tramp);
+
+    env->gpr[HEX_REG_PC] = ka->_sa_handler;
+    env->gpr[HEX_REG_SP] = frame_addr;
+    env->gpr[HEX_REG_R00] = sig;
+    env->gpr[HEX_REG_R01] =
+        frame_addr + offsetof(struct target_rt_sigframe, info);
+    env->gpr[HEX_REG_R02] =
+        frame_addr + offsetof(struct target_rt_sigframe, uc);
+    env->gpr[HEX_REG_LR] =
+        frame_addr + offsetof(struct target_rt_sigframe, tramp);
+
+    return;
+
+badframe:
+    unlock_user_struct(frame, frame_addr, 1);
+    if (sig == TARGET_SIGSEGV) {
+        ka->_sa_handler = TARGET_SIG_DFL;
+    }
+    force_sig(TARGET_SIGSEGV);
+}
+
+static void restore_sigcontext(CPUHexagonState *env,
+                               struct target_sigcontext *sc)
+{
+    __get_user(env->gpr[HEX_REG_R00], &sc->r0);
+    __get_user(env->gpr[HEX_REG_R01], &sc->r1);
+    __get_user(env->gpr[HEX_REG_R02], &sc->r2);
+    __get_user(env->gpr[HEX_REG_R03], &sc->r3);
+    __get_user(env->gpr[HEX_REG_R04], &sc->r4);
+    __get_user(env->gpr[HEX_REG_R05], &sc->r5);
+    __get_user(env->gpr[HEX_REG_R06], &sc->r6);
+    __get_user(env->gpr[HEX_REG_R07], &sc->r7);
+    __get_user(env->gpr[HEX_REG_R08], &sc->r8);
+    __get_user(env->gpr[HEX_REG_R09], &sc->r9);
+    __get_user(env->gpr[HEX_REG_R10], &sc->r10);
+    __get_user(env->gpr[HEX_REG_R11], &sc->r11);
+    __get_user(env->gpr[HEX_REG_R12], &sc->r12);
+    __get_user(env->gpr[HEX_REG_R13], &sc->r13);
+    __get_user(env->gpr[HEX_REG_R14], &sc->r14);
+    __get_user(env->gpr[HEX_REG_R15], &sc->r15);
+    __get_user(env->gpr[HEX_REG_R16], &sc->r16);
+    __get_user(env->gpr[HEX_REG_R17], &sc->r17);
+    __get_user(env->gpr[HEX_REG_R18], &sc->r18);
+    __get_user(env->gpr[HEX_REG_R19], &sc->r19);
+    __get_user(env->gpr[HEX_REG_R20], &sc->r20);
+    __get_user(env->gpr[HEX_REG_R21], &sc->r21);
+    __get_user(env->gpr[HEX_REG_R22], &sc->r22);
+    __get_user(env->gpr[HEX_REG_R23], &sc->r23);
+    __get_user(env->gpr[HEX_REG_R24], &sc->r24);
+    __get_user(env->gpr[HEX_REG_R25], &sc->r25);
+    __get_user(env->gpr[HEX_REG_R26], &sc->r26);
+    __get_user(env->gpr[HEX_REG_R27], &sc->r27);
+    __get_user(env->gpr[HEX_REG_R28], &sc->r28);
+    __get_user(env->gpr[HEX_REG_R29], &sc->r29);
+    __get_user(env->gpr[HEX_REG_R30], &sc->r30);
+    __get_user(env->gpr[HEX_REG_R31], &sc->r31);
+    __get_user(env->gpr[HEX_REG_SA0], &sc->sa0);
+    __get_user(env->gpr[HEX_REG_LC0], &sc->lc0);
+    __get_user(env->gpr[HEX_REG_SA1], &sc->sa1);
+    __get_user(env->gpr[HEX_REG_LC1], &sc->lc1);
+    __get_user(env->gpr[HEX_REG_M0], &sc->m0);
+    __get_user(env->gpr[HEX_REG_M1], &sc->m1);
+    __get_user(env->gpr[HEX_REG_USR], &sc->usr);
+    __get_user(env->gpr[HEX_REG_P3_0], &sc->p3_0);
+    __get_user(env->gpr[HEX_REG_GP], &sc->gp);
+    __get_user(env->gpr[HEX_REG_UGP], &sc->ugp);
+    __get_user(env->gpr[HEX_REG_PC], &sc->pc);
+}
+
+static void restore_ucontext(CPUHexagonState *env, struct target_ucontext *uc)
+{
+    sigset_t blocked;
+    target_sigset_t target_set;
+    int i;
+
+    target_sigemptyset(&target_set);
+    for (i = 0; i < TARGET_NSIG_WORDS; i++) {
+        __get_user(target_set.sig[i], &(uc->uc_sigmask.sig[i]));
+    }
+
+    target_to_host_sigset_internal(&blocked, &target_set);
+    set_sigmask(&blocked);
+
+    restore_sigcontext(env, &uc->uc_mcontext);
+}
+
+long do_rt_sigreturn(CPUHexagonState *env)
+{
+    struct target_rt_sigframe *frame;
+    abi_ulong frame_addr;
+
+    frame_addr = env->gpr[HEX_REG_SP];
+    trace_user_do_sigreturn(env, frame_addr);
+    if (!lock_user_struct(VERIFY_READ, frame, frame_addr, 1)) {
+        goto badframe;
+    }
+
+    restore_ucontext(env, &frame->uc);
+
+    if (do_sigaltstack(frame_addr + offsetof(struct target_rt_sigframe,
+            uc.uc_stack), 0, get_sp_from_cpustate(env)) == -EFAULT) {
+        goto badframe;
+    }
+
+    unlock_user_struct(frame, frame_addr, 0);
+    return -TARGET_QEMU_ESIGRETURN;
+
+badframe:
+    unlock_user_struct(frame, frame_addr, 0);
+    force_sig(TARGET_SIGSEGV);
+    return 0;
+}
diff --git a/linux-user/hexagon/sockbits.h b/linux-user/hexagon/sockbits.h
new file mode 100644
index 0000000..85bd64a
--- /dev/null
+++ b/linux-user/hexagon/sockbits.h
@@ -0,0 +1,3 @@
+/* Copyright (c) 2019 Qualcomm Innovation Center, Inc. All Rights Reserved. */
+
+#include "../generic/sockbits.h"
diff --git a/linux-user/hexagon/syscall_nr.h b/linux-user/hexagon/syscall_nr.h
new file mode 100644
index 0000000..1587cbd
--- /dev/null
+++ b/linux-user/hexagon/syscall_nr.h
@@ -0,0 +1,331 @@
+/* Copyright (c) 2019 Qualcomm Innovation Center, Inc. All Rights Reserved. */
+
+/*
+ * Syscall numbers
+ */
+
+#define  TARGET_NR_io_setup 0
+#define  TARGET_NR_io_destroy 1
+#define  TARGET_NR_io_submit 2
+#define  TARGET_NR_io_cancel 3
+#define  TARGET_NR_io_getevents 4
+#define  TARGET_NR_setxattr 5
+#define  TARGET_NR_lsetxattr 6
+#define  TARGET_NR_fsetxattr 7
+#define  TARGET_NR_getxattr 8
+#define  TARGET_NR_lgetxattr 9
+#define  TARGET_NR_fgetxattr 10
+#define  TARGET_NR_listxattr 11
+#define  TARGET_NR_llistxattr 12
+#define  TARGET_NR_flistxattr 13
+#define  TARGET_NR_removexattr 14
+#define  TARGET_NR_lremovexattr 15
+#define  TARGET_NR_fremovexattr 16
+#define  TARGET_NR_getcwd 17
+#define  TARGET_NR_lookup_dcookie 18
+#define  TARGET_NR_eventfd2 19
+#define  TARGET_NR_epoll_create1 20
+#define  TARGET_NR_epoll_ctl 21
+#define  TARGET_NR_epoll_pwait 22
+#define  TARGET_NR_dup 23
+#define  TARGET_NR_dup3 24
+#define  TARGET_NR3264_fcntl 25
+#define  TARGET_NR_inotify_init1 26
+#define  TARGET_NR_inotify_add_watch 27
+#define  TARGET_NR_inotify_rm_watch 28
+#define  TARGET_NR_ioctl 29
+#define  TARGET_NR_ioprio_set 30
+#define  TARGET_NR_ioprio_get 31
+#define  TARGET_NR_flock 32
+#define  TARGET_NR_mknodat 33
+#define  TARGET_NR_mkdirat 34
+#define  TARGET_NR_unlinkat 35
+#define  TARGET_NR_symlinkat 36
+#define  TARGET_NR_linkat 37
+#define  TARGET_NR_renameat 38
+#define  TARGET_NR_umount2 39
+#define  TARGET_NR_mount 40
+#define  TARGET_NR_pivot_root 41
+#define  TARGET_NR_nfsservctl 42
+#define  TARGET_NR3264_statfs 43
+#define  TARGET_NR_statfs TARGET_NR3264_statfs
+#define  TARGET_NR3264_fstatfs 44
+#define  TARGET_NR3264_truncate 45
+#define  TARGET_NR3264_ftruncate 46
+#define  TARGET_NR_fallocate 47
+#define  TARGET_NR_faccessat 48
+#define  TARGET_NR_chdir 49
+#define  TARGET_NR_fchdir 50
+#define  TARGET_NR_chroot 51
+#define  TARGET_NR_fchmod 52
+#define  TARGET_NR_fchmodat 53
+#define  TARGET_NR_fchownat 54
+#define  TARGET_NR_fchown 55
+#define  TARGET_NR_openat 56
+#define  TARGET_NR_close 57
+#define  TARGET_NR_vhangup 58
+#define  TARGET_NR_pipe2 59
+#define  TARGET_NR_quotactl 60
+#define  TARGET_NR_getdents64 61
+#define  TARGET_NR3264_lseek 62
+#define  TARGET_NR_read 63
+#define  TARGET_NR_write 64
+#define  TARGET_NR_readv 65
+#define  TARGET_NR_writev 66
+#define  TARGET_NR_pread64 67
+#define  TARGET_NR_pwrite64 68
+#define  TARGET_NR_preadv 69
+#define  TARGET_NR_pwritev 70
+#define  TARGET_NR3264_sendfile 71
+#define  TARGET_NR_pselect6 72
+#define  TARGET_NR_ppoll 73
+#define  TARGET_NR_signalfd4 74
+#define  TARGET_NR_vmsplice 75
+#define  TARGET_NR_splice 76
+#define  TARGET_NR_tee 77
+#define  TARGET_NR_readlinkat 78
+#define  TARGET_NR3264_fstatat 79
+#define  TARGET_NR3264_fstat 80
+#define  TARGET_NR_fstat  TARGET_NR3264_fstat
+#define  TARGET_NR_sync 81
+#define  TARGET_NR_fsync 82
+#define  TARGET_NR_fdatasync 83
+#define  TARGET_NR_sync_file_range 84
+#define  TARGET_NR_timerfd_create 85
+#define  TARGET_NR_timerfd_settime 86
+#define  TARGET_NR_timerfd_gettime 87
+#define  TARGET_NR_utimensat 88
+#define  TARGET_NR_acct 89
+#define  TARGET_NR_capget 90
+#define  TARGET_NR_capset 91
+#define  TARGET_NR_personality 92
+#define  TARGET_NR_exit 93
+#define  TARGET_NR_exit_group 94
+#define  TARGET_NR_waitid 95
+#define  TARGET_NR_set_tid_address 96
+#define  TARGET_NR_unshare 97
+#define  TARGET_NR_futex 98
+#define  TARGET_NR_set_robust_list 99
+#define  TARGET_NR_get_robust_list 100
+#define  TARGET_NR_nanosleep 101
+#define  TARGET_NR_getitimer 102
+#define  TARGET_NR_setitimer 103
+#define  TARGET_NR_kexec_load 104
+#define  TARGET_NR_init_module 105
+#define  TARGET_NR_delete_module 106
+#define  TARGET_NR_timer_create 107
+#define  TARGET_NR_timer_gettime 108
+#define  TARGET_NR_timer_getoverrun 109
+#define  TARGET_NR_timer_settime 110
+#define  TARGET_NR_timer_delete 111
+#define  TARGET_NR_clock_settime 112
+#define  TARGET_NR_clock_gettime 113
+#define  TARGET_NR_clock_getres 114
+#define  TARGET_NR_clock_nanosleep 115
+#define  TARGET_NR_syslog 116
+#define  TARGET_NR_ptrace 117
+#define  TARGET_NR_sched_setparam 118
+#define  TARGET_NR_sched_setscheduler 119
+#define  TARGET_NR_sched_getscheduler 120
+#define  TARGET_NR_sched_getparam 121
+#define  TARGET_NR_sched_setaffinity 122
+#define  TARGET_NR_sched_getaffinity 123
+#define  TARGET_NR_sched_yield 124
+#define  TARGET_NR_sched_get_priority_max 125
+#define  TARGET_NR_sched_get_priority_min 126
+#define  TARGET_NR_sched_rr_get_interval 127
+#define  TARGET_NR_restart_syscall 128
+#define  TARGET_NR_kill 129
+#define  TARGET_NR_tkill 130
+#define  TARGET_NR_tgkill 131
+#define  TARGET_NR_sigaltstack 132
+#define  TARGET_NR_rt_sigsuspend 133
+#define  TARGET_NR_rt_sigaction 134
+#define  TARGET_NR_rt_sigprocmask 135
+#define  TARGET_NR_rt_sigpending 136
+#define  TARGET_NR_rt_sigtimedwait 137
+#define  TARGET_NR_rt_sigqueueinfo 138
+#define  TARGET_NR_rt_sigreturn 139
+#define  TARGET_NR_setpriority 140
+#define  TARGET_NR_getpriority 141
+#define  TARGET_NR_reboot 142
+#define  TARGET_NR_setregid 143
+#define  TARGET_NR_setgid 144
+#define  TARGET_NR_setreuid 145
+#define  TARGET_NR_setuid 146
+#define  TARGET_NR_setresuid 147
+#define  TARGET_NR_getresuid 148
+#define  TARGET_NR_setresgid 149
+#define  TARGET_NR_getresgid 150
+#define  TARGET_NR_setfsuid 151
+#define  TARGET_NR_setfsgid 152
+#define  TARGET_NR_times 153
+#define  TARGET_NR_setpgid 154
+#define  TARGET_NR_getpgid 155
+#define  TARGET_NR_getsid 156
+#define  TARGET_NR_setsid 157
+#define  TARGET_NR_getgroups 158
+#define  TARGET_NR_setgroups 159
+#define  TARGET_NR_uname 160
+#define  TARGET_NR_sethostname 161
+#define  TARGET_NR_setdomainname 162
+#define  TARGET_NR_getrlimit 163
+#define  TARGET_NR_setrlimit 164
+#define  TARGET_NR_getrusage 165
+#define  TARGET_NR_umask 166
+#define  TARGET_NR_prctl 167
+#define  TARGET_NR_getcpu 168
+#define  TARGET_NR_gettimeofday 169
+#define  TARGET_NR_settimeofday 170
+#define  TARGET_NR_adjtimex 171
+#define  TARGET_NR_getpid 172
+#define  TARGET_NR_getppid 173
+#define  TARGET_NR_getuid 174
+#define  TARGET_NR_geteuid 175
+#define  TARGET_NR_getgid 176
+#define  TARGET_NR_getegid 177
+#define  TARGET_NR_gettid 178
+#define  TARGET_NR_sysinfo 179
+#define  TARGET_NR_mq_open 180
+#define  TARGET_NR_mq_unlink 181
+#define  TARGET_NR_mq_timedsend 182
+#define  TARGET_NR_mq_timedreceive 183
+#define  TARGET_NR_mq_notify 184
+#define  TARGET_NR_mq_getsetattr 185
+#define  TARGET_NR_msgget 186
+#define  TARGET_NR_msgctl 187
+#define  TARGET_NR_msgrcv 188
+#define  TARGET_NR_msgsnd 189
+#define  TARGET_NR_semget 190
+#define  TARGET_NR_semctl 191
+#define  TARGET_NR_semtimedop 192
+#define  TARGET_NR_semop 193
+#define  TARGET_NR_shmget 194
+#define  TARGET_NR_shmctl 195
+#define  TARGET_NR_shmat 196
+#define  TARGET_NR_shmdt 197
+#define  TARGET_NR_socket 198
+#define  TARGET_NR_socketpair 199
+#define  TARGET_NR_bind 200
+#define  TARGET_NR_listen 201
+#define  TARGET_NR_accept 202
+#define  TARGET_NR_connect 203
+#define  TARGET_NR_getsockname 204
+#define  TARGET_NR_getpeername 205
+#define  TARGET_NR_sendto 206
+#define  TARGET_NR_recvfrom 207
+#define  TARGET_NR_setsockopt 208
+#define  TARGET_NR_getsockopt 209
+#define  TARGET_NR_shutdown 210
+#define  TARGET_NR_sendmsg 211
+#define  TARGET_NR_recvmsg 212
+#define  TARGET_NR_readahead 213
+#define  TARGET_NR_brk 214
+#define  TARGET_NR_munmap 215
+#define  TARGET_NR_mremap 216
+#define  TARGET_NR_add_key 217
+#define  TARGET_NR_request_key 218
+#define  TARGET_NR_keyctl 219
+#define  TARGET_NR_clone 220
+#define  TARGET_NR_execve 221
+#define  TARGET_NR3264_mmap 222
+#define  TARGET_NR3264_fadvise64 223
+#define  TARGET_NR_swapon 224
+#define  TARGET_NR_swapoff 225
+#define  TARGET_NR_mprotect 226
+#define  TARGET_NR_msync 227
+#define  TARGET_NR_mlock 228
+#define  TARGET_NR_munlock 229
+#define  TARGET_NR_mlockall 230
+#define  TARGET_NR_munlockall 231
+#define  TARGET_NR_mincore 232
+#define  TARGET_NR_madvise 233
+#define  TARGET_NR_remap_file_pages 234
+#define  TARGET_NR_mbind 235
+#define  TARGET_NR_get_mempolicy 236
+#define  TARGET_NR_set_mempolicy 237
+#define  TARGET_NR_migrate_pages 238
+#define  TARGET_NR_move_pages 239
+#define  TARGET_NR_rt_tgsigqueueinfo 240
+#define  TARGET_NR_perf_event_open 241
+#define  TARGET_NR_accept4 242
+#define  TARGET_NR_recvmmsg 243
+#define  TARGET_NR_arch_specific_syscall 244
+#define  TARGET_NR_wait4 260
+#define  TARGET_NR_prlimit64 261
+#define  TARGET_NR_fanotify_init 262
+#define  TARGET_NR_fanotify_mark 263
+#define  TARGET_NR_name_to_handle_at         264
+#define  TARGET_NR_open_by_handle_at         265
+#define  TARGET_NR_clock_adjtime 266
+#define  TARGET_NR_syncfs 267
+#define  TARGET_NR_setns 268
+#define  TARGET_NR_sendmmsg 269
+#define  TARGET_NR_process_vm_readv 270
+#define  TARGET_NR_process_vm_writev 271
+#define  TARGET_NR_kcmp 272
+#define  TARGET_NR_finit_module 273
+#define  TARGET_NR_sched_setattr 274
+#define  TARGET_NR_sched_getattr 275
+#define  TARGET_NR_renameat2 276
+#define  TARGET_NR_seccomp 277
+#define  TARGET_NR_getrandom 278
+#define  TARGET_NR_memfd_create 279
+#define  TARGET_NR_bpf 280
+#define  TARGET_NR_execveat 281
+#define  TARGET_NR_open 1024
+#define  TARGET_NR_link 1025
+#define  TARGET_NR_unlink 1026
+#define  TARGET_NR_mknod 1027
+#define  TARGET_NR_chmod 1028
+#define  TARGET_NR_chown 1029
+#define  TARGET_NR_mkdir 1030
+#define  TARGET_NR_rmdir 1031
+#define  TARGET_NR_lchown 1032
+#define  TARGET_NR_access 1033
+#define  TARGET_NR_rename 1034
+#define  TARGET_NR_readlink 1035
+#define  TARGET_NR_symlink 1036
+#define  TARGET_NR_utimes 1037
+#define  TARGET_NR3264_stat 1038
+#define  TARGET_NR3264_lstat 1039
+#define  TARGET_NR_pipe 1040
+#define  TARGET_NR_dup2 1041
+#define  TARGET_NR_epoll_create 1042
+#define  TARGET_NR_inotify_init 1043
+#define  TARGET_NR_eventfd 1044
+#define  TARGET_NR_signalfd 1045
+#define  TARGET_NR_alarm 1059
+#define  TARGET_NR_getpgrp 1060
+#define  TARGET_NR_pause 1061
+#define  TARGET_NR_time 1062
+#define  TARGET_NR_utime 1063
+#define  TARGET_NR_creat 1064
+#define  TARGET_NR_getdents 1065
+#define  TARGET_NR_futimesat 1066
+#define  TARGET_NR_select 1067
+#define  TARGET_NR_poll 1068
+#define  TARGET_NR_epoll_wait 1069
+#define  TARGET_NR_ustat 1070
+#define  TARGET_NR_vfork 1071
+#define  TARGET_NR_oldwait4 1072
+#define  TARGET_NR_recv 1073
+#define  TARGET_NR_send 1074
+#define  TARGET_NR_bdflush 1075
+#define  TARGET_NR_umount 1076
+#define  TARGET_NR_uselib 1077
+#define  TARGET_NR__sysctl 1078
+#define  TARGET_NR_fork 1079
+#define  TARGET_NR_syscalls (TARGET_NR_fork + 1)
+#define  TARGET_NR_fstatfs  TARGET_NR3264_fstatfs
+#define  TARGET_NR_truncate64  TARGET_NR3264_truncate
+#define  TARGET_NR_ftruncate64  TARGET_NR3264_ftruncate
+#define  TARGET_NR_sendfile  TARGET_NR3264_sendfile
+#define  TARGET_NR_newfstatat  TARGET_NR3264_fstatat
+#define  TARGET_NR_lstat  TARGET_NR3264_lstat
+#define  TARGET_NR_fcntl64  TARGET_NR3264_fcntl
+#define  TARGET_NR__llseek  TARGET_NR3264_lseek
+#define  TARGET_NR_mmap2  TARGET_NR3264_mmap
+#define  TARGET_NR_fadvise64_64  TARGET_NR3264_fadvise64
+#define  TARGET_NR_stat64  TARGET_NR3264_stat
+
diff --git a/linux-user/hexagon/target_cpu.h b/linux-user/hexagon/target_cpu.h
new file mode 100644
index 0000000..c151363
--- /dev/null
+++ b/linux-user/hexagon/target_cpu.h
@@ -0,0 +1,35 @@
+/* Copyright (c) 2019 Qualcomm Innovation Center, Inc. All Rights Reserved. */
+
+#ifndef TARGET_CPU_H
+#define TARGET_CPU_H
+
+static inline void cpu_clone_regs_child(CPUHexagonState *env,
+                                        target_ulong newsp, unsigned flags)
+{
+#ifdef DEBUG_HEX
+    printf("cpu_clone_regs 0x%x\n", newsp);
+#endif
+    if (newsp) {
+        env->gpr[HEX_REG_SP] = newsp;
+    }
+    env->gpr[0] = 0;
+}
+
+static inline void cpu_clone_regs_parent(CPUHexagonState *env, unsigned flags)
+{
+}
+
+static inline void cpu_set_tls(CPUHexagonState *env, target_ulong newtls)
+{
+#ifdef DEBUG_HEX
+    printf("cpu_set_tls 0x%x\n", newtls);
+#endif
+    env->gpr[HEX_REG_UGP] = newtls;
+}
+
+static inline abi_ulong get_sp_from_cpustate(CPUHexagonState *state)
+{
+    return state->gpr[HEX_REG_SP];
+}
+
+#endif
diff --git a/linux-user/hexagon/target_elf.h b/linux-user/hexagon/target_elf.h
new file mode 100644
index 0000000..6466e0a
--- /dev/null
+++ b/linux-user/hexagon/target_elf.h
@@ -0,0 +1,24 @@
+/* Copyright (c) 2019 Qualcomm Innovation Center, Inc. All Rights Reserved. */
+
+#ifndef HEXAGON_TARGET_ELF_H
+#define HEXAGON_TARGET_ELF_H
+
+static inline const char *cpu_get_model(uint32_t eflags)
+{
+    /* For now, treat anything newer than v60 as a v67 */
+    /* FIXME - Disable instructions that are newer than the specified arch */
+    if (eflags == 0x04 ||    /* v5  */
+        eflags == 0x05 ||    /* v55 */
+        eflags == 0x60 ||    /* v60 */
+        eflags == 0x61 ||    /* v61 */
+        eflags == 0x62 ||    /* v62 */
+        eflags == 0x65 ||    /* v65 */
+        eflags == 0x66 ||    /* v66 */
+        eflags == 0x67) {    /* v67 */
+        return "v67";
+    }
+    printf("eflags = 0x%x\n", eflags);
+    return "unknown";
+}
+
+#endif
diff --git a/linux-user/hexagon/target_fcntl.h b/linux-user/hexagon/target_fcntl.h
new file mode 100644
index 0000000..a2961fd
--- /dev/null
+++ b/linux-user/hexagon/target_fcntl.h
@@ -0,0 +1,3 @@
+/* Copyright (c) 2019 Qualcomm Innovation Center, Inc. All Rights Reserved. */
+
+#include "../generic/fcntl.h"
diff --git a/linux-user/hexagon/target_signal.h b/linux-user/hexagon/target_signal.h
new file mode 100644
index 0000000..add626d
--- /dev/null
+++ b/linux-user/hexagon/target_signal.h
@@ -0,0 +1,19 @@
+/* Copyright (c) 2019 Qualcomm Innovation Center, Inc. All Rights Reserved. */
+
+#ifndef TARGET_SIGNAL_H
+#define TARGET_SIGNAL_H
+
+typedef struct target_sigaltstack {
+    abi_ulong ss_sp;
+    abi_int ss_flags;
+    abi_ulong ss_size;
+} target_stack_t;
+
+#define TARGET_SS_ONSTACK 1
+#define TARGET_SS_DISABLE 2
+
+#define TARGET_MINSIGSTKSZ 2048
+
+#include "../generic/signal.h"
+
+#endif /* TARGET_SIGNAL_H */
diff --git a/linux-user/hexagon/target_structs.h b/linux-user/hexagon/target_structs.h
new file mode 100644
index 0000000..8ac5838
--- /dev/null
+++ b/linux-user/hexagon/target_structs.h
@@ -0,0 +1,31 @@
+/* Copyright (c) 2019 Qualcomm Innovation Center, Inc. All Rights Reserved. */
+
+/*
+ * Hexagon specific structures for linux-user
+ */
+#ifndef TARGET_STRUCTS_H
+#define TARGET_STRUCTS_H
+
+struct target_ipc_perm {
+    abi_int __key;
+    abi_int uid;
+    abi_int gid;
+    abi_int cuid;
+    abi_int cgid;
+    abi_ushort mode;
+    abi_ushort __pad1;
+    abi_ushort __seq;
+};
+
+struct target_shmid_ds {
+    struct target_ipc_perm shm_perm;
+    abi_long shm_segsz;
+    abi_ulong shm_atime;
+    abi_ulong shm_dtime;
+    abi_ulong shm_ctime;
+    abi_int shm_cpid;
+    abi_int shm_lpid;
+    abi_ulong shm_nattch;
+};
+
+#endif
diff --git a/linux-user/hexagon/target_syscall.h b/linux-user/hexagon/target_syscall.h
new file mode 100644
index 0000000..1d8de9a
--- /dev/null
+++ b/linux-user/hexagon/target_syscall.h
@@ -0,0 +1,17 @@
+/* Copyright (c) 2019 Qualcomm Innovation Center, Inc. All Rights Reserved. */
+
+#ifndef TARGET_SYSCALL_H
+#define TARGET_SYSCALL_H
+
+struct target_pt_regs {
+    abi_long sepc;
+    abi_long sp;
+};
+
+#define UNAME_MACHINE "hexagon"
+#define UNAME_MINIMUM_RELEASE "4.15.0"
+
+#define TARGET_MLOCKALL_MCL_CURRENT 1
+#define TARGET_MLOCKALL_MCL_FUTURE  2
+
+#endif
diff --git a/linux-user/hexagon/termbits.h b/linux-user/hexagon/termbits.h
new file mode 100644
index 0000000..6ac6581
--- /dev/null
+++ b/linux-user/hexagon/termbits.h
@@ -0,0 +1,231 @@
+/* from asm/termbits.h */
+/* Copied/modified from i386 */
+
+#define TARGET_NCCS 32
+
+struct target_termios {
+    unsigned int c_iflag;               /* input mode flags */
+    unsigned int c_oflag;               /* output mode flags */
+    unsigned int c_cflag;               /* control mode flags */
+    unsigned int c_lflag;               /* local mode flags */
+    unsigned char c_line;                    /* line discipline */
+    unsigned char c_cc[TARGET_NCCS];                /* control characters */
+};
+
+/* c_iflag bits */
+#define TARGET_IGNBRK  0000001
+#define TARGET_BRKINT  0000002
+#define TARGET_IGNPAR  0000004
+#define TARGET_PARMRK  0000010
+#define TARGET_INPCK   0000020
+#define TARGET_ISTRIP  0000040
+#define TARGET_INLCR   0000100
+#define TARGET_IGNCR   0000200
+#define TARGET_ICRNL   0000400
+#define TARGET_IUCLC   0001000
+#define TARGET_IXON    0002000
+#define TARGET_IXANY   0004000
+#define TARGET_IXOFF   0010000
+#define TARGET_IMAXBEL 0020000
+#define TARGET_IUTF8   0040000
+
+/* c_oflag bits */
+#define TARGET_OPOST   0000001
+#define TARGET_OLCUC   0000002
+#define TARGET_ONLCR   0000004
+#define TARGET_OCRNL   0000010
+#define TARGET_ONOCR   0000020
+#define TARGET_ONLRET  0000040
+#define TARGET_OFILL   0000100
+#define TARGET_OFDEL   0000200
+#define TARGET_NLDLY   0000400
+#define   TARGET_NL0   0000000
+#define   TARGET_NL1   0000400
+#define TARGET_CRDLY   0003000
+#define   TARGET_CR0   0000000
+#define   TARGET_CR1   0001000
+#define   TARGET_CR2   0002000
+#define   TARGET_CR3   0003000
+#define TARGET_TABDLY  0014000
+#define   TARGET_TAB0  0000000
+#define   TARGET_TAB1  0004000
+#define   TARGET_TAB2  0010000
+#define   TARGET_TAB3  0014000
+#define   TARGET_XTABS 0014000
+#define TARGET_BSDLY   0020000
+#define   TARGET_BS0   0000000
+#define   TARGET_BS1   0020000
+#define TARGET_VTDLY   0040000
+#define   TARGET_VT0   0000000
+#define   TARGET_VT1   0040000
+#define TARGET_FFDLY   0100000
+#define   TARGET_FF0   0000000
+#define   TARGET_FF1   0100000
+
+/* c_cflag bit meaning */
+#define TARGET_CBAUD   0010017
+#define  TARGET_B0     0000000         /* hang up */
+#define  TARGET_B50    0000001
+#define  TARGET_B75    0000002
+#define  TARGET_B110   0000003
+#define  TARGET_B134   0000004
+#define  TARGET_B150   0000005
+#define  TARGET_B200   0000006
+#define  TARGET_B300   0000007
+#define  TARGET_B600   0000010
+#define  TARGET_B1200  0000011
+#define  TARGET_B1800  0000012
+#define  TARGET_B2400  0000013
+#define  TARGET_B4800  0000014
+#define  TARGET_B9600  0000015
+#define  TARGET_B19200 0000016
+#define  TARGET_B38400 0000017
+#define TARGET_EXTA B19200
+#define TARGET_EXTB B38400
+#define TARGET_CSIZE   0000060
+#define   TARGET_CS5   0000000
+#define   TARGET_CS6   0000020
+#define   TARGET_CS7   0000040
+#define   TARGET_CS8   0000060
+#define TARGET_CSTOPB  0000100
+#define TARGET_CREAD   0000200
+#define TARGET_PARENB  0000400
+#define TARGET_PARODD  0001000
+#define TARGET_HUPCL   0002000
+#define TARGET_CLOCAL  0004000
+#define TARGET_CBAUDEX 0010000
+#define  TARGET_B57600  0010001
+#define  TARGET_B115200 0010002
+#define  TARGET_B230400 0010003
+#define  TARGET_B460800 0010004
+#define  TARGET_B500000 0010005
+#define  TARGET_B576000 0010006
+#define  TARGET_B921600 0010007
+#define  TARGET_B1000000 0010010
+#define  TARGET_B1152000 0010011
+#define  TARGET_B1500000 0010012
+#define  TARGET_B2000000 0010013
+#define  TARGET_B2500000 0010014
+#define  TARGET_B3000000 0010015
+#define  TARGET_B3500000 0010016
+#define  TARGET_B4000000 0010017
+#define TARGET_CIBAUD    002003600000  /* input baud rate (not used) */
+#define TARGET_CMSPAR    010000000000  /* mark or space (stick) parity */
+#define TARGET_CRTSCTS   020000000000  /* flow control */
+
+/* c_lflag bits */
+#define TARGET_ISIG    0000001
+#define TARGET_ICANON  0000002
+#define TARGET_XCASE   0000004
+#define TARGET_ECHO    0000010
+#define TARGET_ECHOE   0000020
+#define TARGET_ECHOK   0000040
+#define TARGET_ECHONL  0000100
+#define TARGET_NOFLSH  0000200
+#define TARGET_TOSTOP  0000400
+#define TARGET_ECHOCTL 0001000
+#define TARGET_ECHOPRT 0002000
+#define TARGET_ECHOKE  0004000
+#define TARGET_FLUSHO  0010000
+#define TARGET_PENDIN  0040000
+#define TARGET_IEXTEN  0100000
+
+/* c_cc character offsets */
+#define TARGET_VINTR    0
+#define TARGET_VQUIT    1
+#define TARGET_VERASE   2
+#define TARGET_VKILL    3
+#define TARGET_VEOF     4
+#define TARGET_VTIME    5
+#define TARGET_VMIN     6
+#define TARGET_VSWTC    7
+#define TARGET_VSTART   8
+#define TARGET_VSTOP    9
+#define TARGET_VSUSP    10
+#define TARGET_VEOL     11
+#define TARGET_VREPRINT 12
+#define TARGET_VDISCARD 13
+#define TARGET_VWERASE  14
+#define TARGET_VLNEXT   15
+#define TARGET_VEOL2    16
+
+/* ioctls */
+
+#define TARGET_TCGETS           0x5401
+#define TARGET_TCSETS           0x5402
+#define TARGET_TCSETSW          0x5403
+#define TARGET_TCSETSF          0x5404
+#define TARGET_TCGETA           0x5405
+#define TARGET_TCSETA           0x5406
+#define TARGET_TCSETAW          0x5407
+#define TARGET_TCSETAF          0x5408
+#define TARGET_TCSBRK           0x5409
+#define TARGET_TCXONC           0x540A
+#define TARGET_TCFLSH           0x540B
+
+#define TARGET_TIOCEXCL         0x540C
+#define TARGET_TIOCNXCL         0x540D
+#define TARGET_TIOCSCTTY        0x540E
+#define TARGET_TIOCGPGRP        0x540F
+#define TARGET_TIOCSPGRP        0x5410
+#define TARGET_TIOCOUTQ         0x5411
+#define TARGET_TIOCSTI          0x5412
+#define TARGET_TIOCGWINSZ       0x5413
+#define TARGET_TIOCSWINSZ       0x5414
+#define TARGET_TIOCMGET         0x5415
+#define TARGET_TIOCMBIS         0x5416
+#define TARGET_TIOCMBIC         0x5417
+#define TARGET_TIOCMSET         0x5418
+#define TARGET_TIOCGSOFTCAR     0x5419
+#define TARGET_TIOCSSOFTCAR     0x541A
+#define TARGET_FIONREAD         0x541B
+#define TARGET_TIOCINQ          TARGET_FIONREAD
+#define TARGET_TIOCLINUX        0x541C
+#define TARGET_TIOCCONS         0x541D
+#define TARGET_TIOCGSERIAL      0x541E
+#define TARGET_TIOCSSERIAL      0x541F
+#define TARGET_TIOCPKT          0x5420
+#define TARGET_FIONBIO          0x5421
+#define TARGET_TIOCNOTTY        0x5422
+#define TARGET_TIOCSETD         0x5423
+#define TARGET_TIOCGETD         0x5424
+#define TARGET_TCSBRKP          0x5425     /* Needed for POSIX tcsendbreak() */
+#define TARGET_TIOCTTYGSTRUCT   0x5426     /* For debugging only */
+#define TARGET_TIOCSBRK         0x5427     /* BSD compatibility */
+#define TARGET_TIOCCBRK         0x5428     /* BSD compatibility */
+#define TARGET_TIOCGSID         0x5429     /* Return the session ID of FD */
+/* Get Pty Number (of pty-mux device) */
+#define TARGET_TIOCGPTN         TARGET_IOR('T', 0x30, unsigned int)
+#define TARGET_TIOCSPTLCK       TARGET_IOW('T', 0x31, int) /* Lock/unlock Pty */
+#define TARGET_TIOCGPTPEER      TARGET_IO('T', 0x41) /* Safely open the slave */
+
+#define TARGET_FIONCLEX         0x5450  /* these numbers need to be adjusted. */
+#define TARGET_FIOCLEX          0x5451
+#define TARGET_FIOASYNC         0x5452
+#define TARGET_TIOCSERCONFIG    0x5453
+#define TARGET_TIOCSERGWILD     0x5454
+#define TARGET_TIOCSERSWILD     0x5455
+#define TARGET_TIOCGLCKTRMIOS   0x5456
+#define TARGET_TIOCSLCKTRMIOS   0x5457
+#define TARGET_TIOCSERGSTRUCT   0x5458 /* For debugging only */
+#define TARGET_TIOCSERGETLSR   0x5459 /* Get line status register */
+#define TARGET_TIOCSERGETMULTI 0x545A /* Get multiport config  */
+#define TARGET_TIOCSERSETMULTI 0x545B /* Set multiport config */
+
+/* wait for a change on serial input line(s) */
+#define TARGET_TIOCMIWAIT      0x545C
+/* read serial port inline interrupt counts */
+#define TARGET_TIOCGICOUNT     0x545D
+#define TARGET_TIOCGHAYESESP   0x545E  /* Get Hayes ESP configuration */
+#define TARGET_TIOCSHAYESESP   0x545F  /* Set Hayes ESP configuration */
+
+/* Used for packet mode */
+#define TARGET_TIOCPKT_DATA              0
+#define TARGET_TIOCPKT_FLUSHREAD         1
+#define TARGET_TIOCPKT_FLUSHWRITE        2
+#define TARGET_TIOCPKT_STOP              4
+#define TARGET_TIOCPKT_START             8
+#define TARGET_TIOCPKT_NOSTOP           16
+#define TARGET_TIOCPKT_DOSTOP           32
+
+#define TARGET_TIOCSER_TEMT    0x01    /* Transmitter physically empty */
diff --git a/linux-user/signal.c b/linux-user/signal.c
index 5ca6d62..ce3d27f 100644
--- a/linux-user/signal.c
+++ b/linux-user/signal.c
@@ -72,6 +72,14 @@ static uint8_t host_to_target_signal_table[_NSIG] = {
        over a single host signal.  */
     [__SIGRTMIN] = __SIGRTMAX,
     [__SIGRTMAX] = __SIGRTMIN,
+#ifdef TARGET_HEXAGON
+    /*
+     * Hexagon uses the same signal for pthread cancel as the host pthreads,
+     * so cannot be overridden.
+     * Therefore, we map Hexagon signal to a different host signal.
+     */
+    [__SIGRTMAX - 1] = __SIGRTMIN + 1,
+#endif
 };
 static uint8_t target_to_host_signal_table[_NSIG];
 
diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index ab9d933..a5ca2ec 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -507,6 +507,8 @@ static inline int regpairs_aligned(void *cpu_env, int num)
 }
 #elif defined(TARGET_XTENSA)
 static inline int regpairs_aligned(void *cpu_env, int num) { return 1; }
+#elif defined(TARGET_HEXAGON)
+static inline int regpairs_aligned(void *cpu_env, int num) { return 1; }
 #else
 static inline int regpairs_aligned(void *cpu_env, int num) { return 0; }
 #endif
diff --git a/linux-user/syscall_defs.h b/linux-user/syscall_defs.h
index 98c2119..1c80773 100644
--- a/linux-user/syscall_defs.h
+++ b/linux-user/syscall_defs.h
@@ -102,6 +102,14 @@
 #define TARGET_IOC_WRITE  2U
 #define TARGET_IOC_READ   1U
 
+#elif defined(TARGET_HEXAGON)
+
+#define TARGET_IOC_SIZEBITS     14
+
+#define TARGET_IOC_NONE   0U
+#define TARGET_IOC_WRITE  1U
+#define TARGET_IOC_READ          2U
+
 #else
 #error unsupported CPU
 #endif
@@ -2085,6 +2093,31 @@ struct target_stat64 {
     uint64_t   st_ino;
 };
 
+#elif defined(TARGET_HEXAGON)
+
+struct target_stat {
+    unsigned long long st_dev;
+    unsigned long long st_ino;
+    unsigned int st_mode;
+    unsigned int st_nlink;
+    unsigned int st_uid;
+    unsigned int st_gid;
+    unsigned long long st_rdev;
+    target_ulong __pad1;
+    long long st_size;
+    target_long st_blksize;
+    int __pad2;
+    long long st_blocks;
+
+    target_long target_st_atime;
+    target_long target_st_atime_nsec;
+    target_long target_st_mtime;
+    target_long target_st_mtime_nsec;
+    target_long target_st_ctime;
+    target_long target_st_ctime_nsec;
+    int __unused[2];
+};
+
 #else
 #error unsupported CPU
 #endif
diff --git a/target/hexagon/Makefile.objs b/target/hexagon/Makefile.objs
new file mode 100644
index 0000000..dfab6ee
--- /dev/null
+++ b/target/hexagon/Makefile.objs
@@ -0,0 +1,6 @@
+obj-y += \
+    cpu.o \
+    translate.o \
+    op_helper.o
+
+CFLAGS += -I$(SRC_PATH)/target/hexagon/imported
diff --git a/target/hexagon/cpu-param.h b/target/hexagon/cpu-param.h
new file mode 100644
index 0000000..6cfe93f
--- /dev/null
+++ b/target/hexagon/cpu-param.h
@@ -0,0 +1,11 @@
+/* Copyright (c) 2019 Qualcomm Innovation Center, Inc. All Rights Reserved. */
+
+
+#ifndef HEXAGON_CPU_PARAM_H
+#define HEXAGON_CPU_PARAM_H
+
+# define TARGET_PHYS_ADDR_SPACE_BITS 36
+
+#define NB_MMU_MODES 1
+
+#endif
diff --git a/target/hexagon/cpu.c b/target/hexagon/cpu.c
new file mode 100644
index 0000000..03e989c
--- /dev/null
+++ b/target/hexagon/cpu.c
@@ -0,0 +1,283 @@
+/* Copyright (c) 2019 Qualcomm Innovation Center, Inc. All Rights Reserved. */
+
+/*
+ * QEMU Hexagon
+ */
+
+#include "qemu/osdep.h"
+#include "qemu/log.h"
+#include "cpu.h"
+#include "exec/exec-all.h"
+#include "qapi/error.h"
+#include "migration/vmstate.h"
+
+static void hexagon_v67_cpu_init(Object *obj)
+{
+}
+
+static ObjectClass *hexagon_cpu_class_by_name(const char *cpu_model)
+{
+    ObjectClass *oc;
+    char *typename;
+    char **cpuname;
+
+    cpuname = g_strsplit(cpu_model, ",", 1);
+    typename = g_strdup_printf(HEXAGON_CPU_TYPE_NAME("%s"), cpuname[0]);
+    oc = object_class_by_name(typename);
+    g_strfreev(cpuname);
+    g_free(typename);
+    if (!oc || !object_class_dynamic_cast(oc, TYPE_HEXAGON_CPU) ||
+        object_class_is_abstract(oc)) {
+        return NULL;
+    }
+    return oc;
+}
+
+const char * const hexagon_regnames[] = {
+   "r0", "r1",  "r2",  "r3",  "r4",   "r5",  "r6",  "r7",
+   "r8", "r9",  "r10", "r11", "r12",  "r13", "r14", "r15",
+  "r16", "r17", "r18", "r19", "r20",  "r21", "r22", "r23",
+  "r24", "r25", "r26", "r27", "r28",  "r29", "r30", "r31",
+  "sa0", "lc0", "sa1", "lc1", "p3_0", "c5",  "m0",  "m1",
+  "usr", "pc",  "ugp", "gp",  "cs0",  "cs1", "c14", "c15",
+  "c16", "c17", "c18", "c19", "c20",  "c21", "c22", "c23",
+  "c24", "c25", "c26", "c27", "c28",  "c29", "c30", "c31",
+};
+
+const char * const hexagon_prednames[] = {
+  "p0 ", "p1 ", "p2 ", "p3 "
+};
+
+static inline target_ulong hack_stack_ptrs(CPUHexagonState *env,
+                                           target_ulong addr)
+{
+    target_ulong stack_start = env->stack_start;
+    target_ulong stack_size = 0x10000;
+    target_ulong stack_adjust = env->stack_adjust;
+
+    if (stack_start + 0x1000 >= addr && addr >= (stack_start - stack_size)) {
+        return addr - stack_adjust;
+    }
+    return addr;
+}
+
+static void print_reg(FILE *f, CPUHexagonState *env, int regnum)
+{
+    fprintf(f, "  %s = 0x" TARGET_FMT_lx "\n",
+        hexagon_regnames[regnum],
+        regnum < 32 ? hack_stack_ptrs(env, env->gpr[regnum])
+                    : env->gpr[regnum]);
+}
+
+static void hexagon_dump(CPUHexagonState *env, FILE *f)
+{
+    static target_ulong last_pc;
+    int i;
+
+    /*
+     * When comparing with LLDB, it doesn't step through single-cycle
+     * hardware loops the same way.  So, we just skip them here
+     */
+    if (env->gpr[HEX_REG_PC] == last_pc) {
+        return;
+    }
+    last_pc = env->gpr[HEX_REG_PC];
+    fprintf(f, "General Purpose Registers = {\n");
+    for (i = 0; i < 32; i++) {
+        print_reg(f, env, i);
+    }
+    print_reg(f, env, HEX_REG_SA0);
+    print_reg(f, env, HEX_REG_LC0);
+    print_reg(f, env, HEX_REG_SA1);
+    print_reg(f, env, HEX_REG_LC1);
+    print_reg(f, env, HEX_REG_M0);
+    print_reg(f, env, HEX_REG_M1);
+    print_reg(f, env, HEX_REG_USR);
+    print_reg(f, env, HEX_REG_P3_0);
+#ifdef FIXME
+    /*
+     * LLDB bug swaps gp and ugp
+     * FIXME when the LLDB bug is fixed
+     */
+    print_reg(f, env, HEX_REG_GP);
+    print_reg(f, env, HEX_REG_UGP);
+#else
+    fprintf(f, "  %s = 0x" TARGET_FMT_lx "\n",
+        hexagon_regnames[HEX_REG_GP],
+        hack_stack_ptrs(env, env->gpr[HEX_REG_UGP]));
+    fprintf(f, "  %s = 0x" TARGET_FMT_lx "\n",
+        hexagon_regnames[HEX_REG_UGP],
+        hack_stack_ptrs(env, env->gpr[HEX_REG_GP]));
+#endif
+    print_reg(f, env, HEX_REG_PC);
+#ifdef FIXME
+    /*
+     * Not modelled in qemu, print junk to minimize the diff's
+     * with LLDB output
+     */
+    print_reg(f, env, HEX_REG_CAUSE);
+    print_reg(f, env, HEX_REG_BADVA);
+    print_reg(f, env, HEX_REG_CS0);
+    print_reg(f, env, HEX_REG_CS1);
+#else
+    fprintf(f, "  cause = 0x000000db\n");
+    fprintf(f, "  badva = 0x00000000\n");
+    fprintf(f, "  cs0 = 0x00000000\n");
+    fprintf(f, "  cs1 = 0x00000000\n");
+#endif
+    fprintf(f, "}\n");
+}
+
+static void hexagon_dump_state(CPUState *cs, FILE *f, int flags)
+{
+    HexagonCPU *cpu = HEXAGON_CPU(cs);
+    CPUHexagonState *env = &cpu->env;
+
+    hexagon_dump(env, f);
+}
+
+void hexagon_debug(CPUHexagonState *env)
+{
+    hexagon_dump(env, stdout);
+}
+
+static void hexagon_cpu_set_pc(CPUState *cs, vaddr value)
+{
+    HexagonCPU *cpu = HEXAGON_CPU(cs);
+    CPUHexagonState *env = &cpu->env;
+    env->gpr[HEX_REG_PC] = value;
+}
+
+static void hexagon_cpu_synchronize_from_tb(CPUState *cs, TranslationBlock *tb)
+{
+    HexagonCPU *cpu = HEXAGON_CPU(cs);
+    CPUHexagonState *env = &cpu->env;
+    env->gpr[HEX_REG_PC] = tb->pc;
+}
+
+static bool hexagon_cpu_has_work(CPUState *cs)
+{
+    return true;
+}
+
+void restore_state_to_opc(CPUHexagonState *env, TranslationBlock *tb,
+                          target_ulong *data)
+{
+    env->gpr[HEX_REG_PC] = data[0];
+}
+
+static void hexagon_cpu_reset(CPUState *cs)
+{
+    HexagonCPU *cpu = HEXAGON_CPU(cs);
+    HexagonCPUClass *mcc = HEXAGON_CPU_GET_CLASS(cpu);
+
+    mcc->parent_reset(cs);
+}
+
+static void hexagon_cpu_disas_set_info(CPUState *s, disassemble_info *info)
+{
+    printf("ERROR: disas_set_info not implemented\n");
+    g_assert_not_reached();
+}
+
+static void hexagon_cpu_realize(DeviceState *dev, Error **errp)
+{
+    CPUState *cs = CPU(dev);
+    HexagonCPUClass *mcc = HEXAGON_CPU_GET_CLASS(dev);
+    Error *local_err = NULL;
+
+    cpu_exec_realizefn(cs, &local_err);
+    if (local_err != NULL) {
+        error_propagate(errp, local_err);
+        return;
+    }
+
+    qemu_init_vcpu(cs);
+    cpu_reset(cs);
+
+    mcc->parent_realize(dev, errp);
+}
+
+static void hexagon_cpu_init(Object *obj)
+{
+    HexagonCPU *cpu = HEXAGON_CPU(obj);
+
+    cpu_set_cpustate_pointers(cpu);
+}
+
+static bool hexagon_tlb_fill(CPUState *cs, vaddr address, int size,
+                             MMUAccessType access_type, int mmu_idx,
+                             bool probe, uintptr_t retaddr)
+{
+#ifdef CONFIG_USER_ONLY
+    switch (access_type) {
+    case MMU_INST_FETCH:
+        cs->exception_index = HEX_EXCP_FETCH_NO_UPAGE;
+        break;
+    case MMU_DATA_LOAD:
+        cs->exception_index = HEX_EXCP_PRIV_NO_UREAD;
+        break;
+    case MMU_DATA_STORE:
+        cs->exception_index = HEX_EXCP_PRIV_NO_UWRITE;
+        break;
+    }
+    cpu_loop_exit_restore(cs, retaddr);
+#else
+#error System mode not implemented for Hexagon
+#endif
+}
+
+static const VMStateDescription vmstate_hexagon_cpu = {
+    .name = "cpu",
+    .unmigratable = 1,
+};
+
+static void hexagon_cpu_class_init(ObjectClass *c, void *data)
+{
+    HexagonCPUClass *mcc = HEXAGON_CPU_CLASS(c);
+    CPUClass *cc = CPU_CLASS(c);
+    DeviceClass *dc = DEVICE_CLASS(c);
+
+    mcc->parent_realize = dc->realize;
+    dc->realize = hexagon_cpu_realize;
+
+    mcc->parent_reset = cc->reset;
+    cc->reset = hexagon_cpu_reset;
+
+    cc->class_by_name = hexagon_cpu_class_by_name;
+    cc->has_work = hexagon_cpu_has_work;
+    cc->dump_state = hexagon_dump_state;
+    cc->set_pc = hexagon_cpu_set_pc;
+    cc->synchronize_from_tb = hexagon_cpu_synchronize_from_tb;
+    cc->gdb_core_xml_file = "hexagon-core.xml";
+    cc->gdb_stop_before_watchpoint = true;
+    cc->disas_set_info = hexagon_cpu_disas_set_info;
+#ifdef CONFIG_TCG
+    cc->tcg_initialize = hexagon_translate_init;
+    cc->tlb_fill = hexagon_tlb_fill;
+#endif
+    /* For now, mark unmigratable: */
+    cc->vmsd = &vmstate_hexagon_cpu;
+}
+
+#define DEFINE_CPU(type_name, initfn)      \
+    {                                      \
+        .name = type_name,                 \
+        .parent = TYPE_HEXAGON_CPU,        \
+        .instance_init = initfn            \
+    }
+
+static const TypeInfo hexagon_cpu_type_infos[] = {
+    {
+        .name = TYPE_HEXAGON_CPU,
+        .parent = TYPE_CPU,
+        .instance_size = sizeof(HexagonCPU),
+        .instance_init = hexagon_cpu_init,
+        .abstract = true,
+        .class_size = sizeof(HexagonCPUClass),
+        .class_init = hexagon_cpu_class_init,
+    },
+    DEFINE_CPU(TYPE_HEXAGON_CPU_V67,              hexagon_v67_cpu_init),
+};
+
+DEFINE_TYPES(hexagon_cpu_type_infos)
diff --git a/target/hexagon/cpu.h b/target/hexagon/cpu.h
new file mode 100644
index 0000000..35dddf6
--- /dev/null
+++ b/target/hexagon/cpu.h
@@ -0,0 +1,146 @@
+/* Copyright (c) 2019 Qualcomm Innovation Center, Inc. All Rights Reserved. */
+
+/*
+ * HEXAGON CPU
+ *
+ */
+
+#ifndef HEXAGON_CPU_H
+#define HEXAGON_CPU_H
+
+/* FIXME - Change this to a command-line option */
+#ifdef FIXME
+#define DEBUG_HEX
+#endif
+#ifdef FIXME
+#define COUNT_HEX_HELPERS
+#endif
+
+/* Forward declaration needed by some of the header files */
+typedef struct CPUHexagonState CPUHexagonState;
+
+#include <fenv.h>
+#include "qemu/osdep.h"
+#include "global_types.h"
+#include "max.h"
+#include "iss_ver_registers.h"
+
+#define TARGET_PAGE_BITS 16     /* 64K pages */
+/*
+ * For experimenting with oslib (4K pages)
+ * #define TARGET_PAGE_BITS 12
+ */
+#define TARGET_LONG_BITS 32
+#define TARGET_VIRT_ADDR_SPACE_BITS 32
+
+#include <time.h>
+#include "qemu/compiler.h"
+#include "qemu-common.h"
+#include "exec/cpu-defs.h"
+#include "regs.h"
+
+#define TYPE_HEXAGON_CPU "hexagon-cpu"
+
+#define HEXAGON_CPU_TYPE_SUFFIX "-" TYPE_HEXAGON_CPU
+#define HEXAGON_CPU_TYPE_NAME(name) (name HEXAGON_CPU_TYPE_SUFFIX)
+#define CPU_RESOLVING_TYPE TYPE_HEXAGON_CPU
+
+#define TYPE_HEXAGON_CPU_V67             HEXAGON_CPU_TYPE_NAME("v67")
+
+#define MMU_USER_IDX 0
+
+#define TRANSLATE_FAIL 1
+#define TRANSLATE_SUCCESS 0
+
+struct MemLog {
+    vaddr_t va;
+    size1u_t width;
+    size4u_t data32;
+    size8u_t data64;
+};
+
+struct CPUHexagonState {
+    target_ulong gpr[TOTAL_PER_THREAD_REGS];
+    target_ulong pred[NUM_PREGS];
+
+    /* For comparing with LLDB on target - see hack_stack_ptrs function */
+    target_ulong stack_start;
+    target_ulong stack_adjust;
+};
+
+#define HEXAGON_CPU_CLASS(klass) \
+    OBJECT_CLASS_CHECK(HexagonCPUClass, (klass), TYPE_HEXAGON_CPU)
+#define HEXAGON_CPU(obj) \
+    OBJECT_CHECK(HexagonCPU, (obj), TYPE_HEXAGON_CPU)
+#define HEXAGON_CPU_GET_CLASS(obj) \
+    OBJECT_GET_CLASS(HexagonCPUClass, (obj), TYPE_HEXAGON_CPU)
+
+typedef struct HexagonCPUClass {
+    /*< private >*/
+    CPUClass parent_class;
+    /*< public >*/
+    DeviceRealize parent_realize;
+    void (*parent_reset)(CPUState *cpu);
+} HexagonCPUClass;
+
+typedef struct HexagonCPU {
+    /*< private >*/
+    CPUState parent_obj;
+    /*< public >*/
+    CPUNegativeOffsetState neg;
+    CPUHexagonState env;
+} HexagonCPU;
+
+static inline HexagonCPU *hexagon_env_get_cpu(CPUHexagonState *env)
+{
+    return container_of(env, HexagonCPU, env);
+}
+
+
+#include "cpu_bits.h"
+
+extern const char * const hexagon_regnames[];
+extern const char * const hexagon_prednames[];
+
+#define ENV_GET_CPU(e)  CPU(hexagon_env_get_cpu(e))
+#define ENV_OFFSET      offsetof(HexagonCPU, env)
+
+int hexagon_gdb_read_register(CPUState *cpu, uint8_t *buf, int reg);
+int hexagon_gdb_write_register(CPUState *cpu, uint8_t *buf, int reg);
+
+#define cpu_signal_handler cpu_hexagon_signal_handler
+
+int cpu_hexagon_signal_handler(int host_signum, void *pinfo, void *puc);
+
+void QEMU_NORETURN do_raise_exception_err(CPUHexagonState *env,
+                                          uint32_t exception, uintptr_t pc);
+
+#define TB_FLAGS_MMU_MASK  3
+
+static inline void cpu_get_tb_cpu_state(CPUHexagonState *env, target_ulong *pc,
+                                        target_ulong *cs_base, uint32_t *flags)
+{
+    *pc = env->gpr[HEX_REG_PC];
+    *cs_base = 0;
+#ifdef CONFIG_USER_ONLY
+    *flags = 0;
+#else
+#error System mode not supported on Hexagon yet
+#endif
+}
+
+void hexagon_translate_init(void);
+void hexagon_debug(CPUHexagonState *env);
+void hexagon_debug_vreg(CPUHexagonState *env, int regnum);
+void hexagon_debug_qreg(CPUHexagonState *env, int regnum);
+
+typedef struct CPUHexagonState CPUArchState;
+typedef HexagonCPU ArchCPU;
+
+#ifdef COUNT_HEX_HELPERS
+extern void print_helper_counts(void);
+#endif
+
+#include "exec/cpu-all.h"
+
+#endif /* HEXAGON_CPU_H */
diff --git a/target/hexagon/cpu_bits.h b/target/hexagon/cpu_bits.h
new file mode 100644
index 0000000..043f2b5
--- /dev/null
+++ b/target/hexagon/cpu_bits.h
@@ -0,0 +1,15 @@
+/* Copyright (c) 2019 Qualcomm Innovation Center, Inc. All Rights Reserved. */
+
+#ifndef HEXAGON_CPU_BITS_H
+#define HEXAGON_CPU_BITS_H
+
+#define HEX_EXCP_FETCH_NO_UPAGE  0x012
+#define HEX_EXCP_PRIV_NO_UREAD   0x024
+#define HEX_EXCP_PRIV_NO_UWRITE  0x025
+
+#define HEX_EXCP_TRAP0           0x172
+#define HEX_EXCP_TRAP1           0x173
+#define HEX_EXCP_SC4             0x100
+#define HEX_EXCP_SC8             0x200
+
+#endif
diff --git a/target/hexagon/helper.h b/target/hexagon/helper.h
new file mode 100644
index 0000000..76e34f8
--- /dev/null
+++ b/target/hexagon/helper.h
@@ -0,0 +1,3 @@
+/* Copyright (c) 2019 Qualcomm Innovation Center, Inc. All Rights Reserved. */
+
+DEF_HELPER_2(raise_exception, noreturn, env, i32)
diff --git a/target/hexagon/imported/global_types.h b/target/hexagon/imported/global_types.h
new file mode 100644
index 0000000..b4f4371
--- /dev/null
+++ b/target/hexagon/imported/global_types.h
@@ -0,0 +1,25 @@
+/* Copyright (c) 2019 Qualcomm Innovation Center, Inc. All Rights Reserved. */
+
+
+#ifndef _GLOBAL_TYPES_H_
+#define _GLOBAL_TYPES_H_ 1
+
+
+typedef unsigned char size1u_t;
+typedef char size1s_t;
+typedef unsigned short int size2u_t;
+typedef short size2s_t;
+typedef unsigned int size4u_t;
+typedef int size4s_t;
+typedef unsigned long long int size8u_t;
+typedef long long int size8s_t;
+typedef size8u_t paddr_t;
+typedef size4u_t vaddr_t;
+typedef size8u_t pcycles_t;
+
+typedef struct size16s {
+    size8s_t hi;
+    size8u_t lo;
+} size16s_t;
+
+#endif /* _GLOBAL_TYPES_H_ */
diff --git a/target/hexagon/imported/iss_ver_registers.h b/target/hexagon/imported/iss_ver_registers.h
new file mode 100644
index 0000000..08e34d2
--- /dev/null
+++ b/target/hexagon/imported/iss_ver_registers.h
@@ -0,0 +1,183 @@
+/* Copyright (c) 2019 Qualcomm Innovation Center, Inc. All Rights Reserved. */
+
+#define HEX_REG_R00 0
+#define HEX_REG_R01 1
+#define HEX_REG_R02 2
+#define HEX_REG_R03 3
+#define HEX_REG_R04 4
+#define HEX_REG_R05 5
+#define HEX_REG_R06 6
+#define HEX_REG_R07 7
+#define HEX_REG_R08 8
+#define HEX_REG_R09 9
+#define HEX_REG_R10 10
+#define HEX_REG_R11 11
+#define HEX_REG_R12 12
+#define HEX_REG_R13 13
+#define HEX_REG_R14 14
+#define HEX_REG_R15 15
+#define HEX_REG_R16 16
+#define HEX_REG_R17 17
+#define HEX_REG_R18 18
+#define HEX_REG_R19 19
+#define HEX_REG_R20 20
+#define HEX_REG_R21 21
+#define HEX_REG_R22 22
+#define HEX_REG_R23 23
+#define HEX_REG_R24 24
+#define HEX_REG_R25 25
+#define HEX_REG_R26 26
+#define HEX_REG_R27 27
+#define HEX_REG_R28 28
+#define HEX_REG_R29 29
+#define HEX_REG_SP 29
+#define HEX_REG_FP 30
+#define HEX_REG_R30 30
+#define HEX_REG_LR 31
+#define HEX_REG_R31 31
+#define HEX_REG_SA0 32
+#define HEX_REG_LC0 33
+#define HEX_REG_SA1 34
+#define HEX_REG_LC1 35
+#define HEX_REG_P3_0 36
+#define HEX_REG_M0 38
+#define HEX_REG_M1 39
+#define HEX_REG_USR 40
+#define HEX_REG_PC 41
+#define HEX_REG_UGP 42
+#define HEX_REG_GP 43
+#define HEX_REG_CS0 44
+#define HEX_REG_CS1 45
+#define HEX_REG_UPCYCLELO 46
+#define HEX_REG_UPCYCLEHI 47
+#define HEX_REG_FRAMELIMIT 48
+#define HEX_REG_FRAMEKEY 49
+#define HEX_REG_PKTCNTLO 50
+#define HEX_REG_PKTCNTHI 51
+/* Use reserved control registers for qemu execution counts */
+#define HEX_REG_QEMU_PKT_CNT 52
+#define HEX_REG_QEMU_INSN_CNT 53
+#define HEX_REG_QEMU_HVX_CNT 54
+#define HEX_REG_UTIMERLO 62
+#define HEX_REG_UTIMERHI 63
+#define HEX_REG_SGP0 64
+#define HEX_REG_SGP1 65
+#define HEX_REG_STID 66
+#define HEX_REG_ELR 67
+#define HEX_REG_BADVA0 68
+#define HEX_REG_BADVA1 69
+#define HEX_REG_SSR 70
+#define HEX_REG_CCR 71
+#define HEX_REG_HTID 72
+#define HEX_REG_BADVA 73
+#define HEX_REG_IMASK 74
+#define HEX_REG_GEVB 75
+
+/*
+ * Not used in qemu
+ */
+#ifdef FIXME
+// New interrupts, keep old defines for the time being
+#define HEX_REG_GELR 80
+#define HEX_REG_GSR 81 
+#define HEX_REG_GOSP 82
+#define HEX_REG_GBADVA 83
+
+#define HEX_REG_G0 80
+#define HEX_REG_G1 81
+#define HEX_REG_G2 82
+#define HEX_REG_G3 83
+
+#define HEX_REG_G4 84
+#define HEX_REG_G5 85
+#define HEX_REG_G6 86
+#define HEX_REG_G7 87
+#define HEX_REG_G8 88
+#define HEX_REG_G9 89
+#define HEX_REG_G10 90
+#define HEX_REG_G11 91
+#define HEX_REG_G12 92
+#define HEX_REG_G13 93
+#define HEX_REG_G14 94
+#define HEX_REG_G15 95
+#define HEX_REG_G16 96
+#define HEX_REG_G17 97
+#define HEX_REG_G18 98
+#define HEX_REG_G19 99
+#define HEX_REG_G20 100
+#define HEX_REG_G21 101
+#define HEX_REG_G22 102
+#define HEX_REG_G23 103
+#define HEX_REG_G24 104
+#define HEX_REG_G25 105
+#define HEX_REG_G26 106
+#define HEX_REG_G27 107
+#define HEX_REG_G28 108
+#define HEX_REG_G29 109
+#define HEX_REG_G30 110
+#define HEX_REG_G31 111
+#define GREG_EVB 0
+#define GREG_MODECTL 1
+#define GREG_SYSCFG 2
+#define GREG_EVB1 3
+#define GREG_IPENDAD 4
+#define GREG_VID 5
+#define GREG_VID1 6
+#define GREG_BESTWAIT 7
+#define GREG_SCHEDCFG 9
+#define GREG_CFGBASE 11
+#define GREG_DIAG 12
+#define GREG_REV 13
+#define GREG_PCYCLELO 14
+#define GREG_PCYCLEHI 15
+#define GREG_ISDBST 16
+#define GREG_ISDBCFG0 17
+#define GREG_ISDBCFG1 18
+#define GREG_LIVELOCK 19
+#define GREG_BRKPTPC0 20
+#define GREG_BRKPTCFG0 21
+#define GREG_BRKPTPC1 22
+#define GREG_BRKPTCFG1 23
+#define GREG_ISDBMBXIN 24
+#define GREG_ISDBMBXOUT 25
+#define GREG_ISDBEN 26
+#define GREG_ISDBGPR 27
+#define GREG_PMUCNT4 28
+#define GREG_PMUCNT5 29
+#define GREG_PMUCNT6 30
+#define GREG_PMUCNT7 31
+#define GREG_PMUCNT0 32
+#define GREG_PMUCNT1 33
+#define GREG_PMUCNT2 34
+#define GREG_PMUCNT3 35
+#define GREG_PMUEVTCFG 36
+#define GREG_PMUSTID0 37
+#define GREG_PMUEVTCFG1 38
+#define GREG_PMUSTID1 39
+#define GREG_TIMERLO 40
+#define GREG_TIMERHI 41
+#define GREG_PMUCFG 42
+#define GREG_AVS 43
+// GREG_AVS renamed to GREG_RGDR2 in v67
+#define GREG_RGDR2 43
+#define GREG_RGDR 44
+#define GREG_TURKEY 45
+#define GREG_DUCK 46
+#define GREG_CHICKEN 47
+#define GREG_COMMIT1T 48
+#define GREG_COMMIT2T 49
+#define GREG_COMMIT3T 50
+#define GREG_COMMIT4T 51
+#define GREG_COMMIT5T 52
+#define GREG_COMMIT6T 53
+#define GREG_PCYCLE1T 54
+#define GREG_PCYCLE2T 55
+#define GREG_PCYCLE3T 56
+#define GREG_PCYCLE4T 57
+#define GREG_PCYCLE5T 58
+#define GREG_PCYCLE6T 59
+#define GREG_STFINST  60
+#define GREG_ISDBCMD  61
+#define GREG_ISDBVER  62
+#define GREG_BRKPTINFO 63
+#endif
diff --git a/target/hexagon/imported/max.h b/target/hexagon/imported/max.h
new file mode 100644
index 0000000..62af24d
--- /dev/null
+++ b/target/hexagon/imported/max.h
@@ -0,0 +1,78 @@
+/* Copyright (c) 2019 Qualcomm Innovation Center, Inc. All Rights Reserved. */
+
+/*
+ *
+ * This file contains architecture parameters
+ *
+ * 
+ *
+ */
+
+#ifndef _MAX_H
+#define _MAX_H
+
+
+#define INSTRUCTIONS_MAX 7		/* 2 pairs + loopend */
+#define LOOPNEST_MAX 2
+#define IMMEDS_MAX 2
+
+
+#define MAX_CORES 4				/* Cores per shared L2 */
+#define MAX_CLUSTERS 2
+#define MAX_THREADS_PER_CLUSTER 4
+#define THREADS_PER_CORE (MAX_CLUSTERS * MAX_THREADS_PER_CLUSTER)		/* HW threads in a core */
+#define THREADS_MAX (MAX_CORES * THREADS_PER_CORE)
+#define DMA_MAX THREADS_MAX  // DMA: make this independent
+#define MAX_EXT_CONTEXTS 4
+#define MAX_L2_INTERLEAVES 2
+#define MAX_VFIFO_COUNT 4
+
+#define SLOTS_MAX 4
+
+/* #define PROCESSORS_MAX 1 */
+#define REG_WRITES_MAX 32		/*?? */
+#define PRED_WRITES_MAX 5		/* 4 insns + endloop */
+#define STORES_MAX 2
+#define LOADS_MAX 2
+#define MAX_PRED 4
+
+#define PACKET_BYTES_MAX 16
+#define MAX_TLB_ENTRIES 320
+#define DTLB_ENTRIES 16
+#define ITLB_ENTRIES 16
+#define MAX_N_GRANULES 4		/* Max of number of granules of all caches */
+
+/* FMC */
+#define FAST_MEM_CACHE_SIZE (256)
+
+/* IIC stuff */
+#define IIC_TAGS_MAX (1024*128)	/* 1MB = 2^20 bytes */
+#define IIC_DATA_IN_BYTES_MAX (1024*1024*4)
+
+#define MAX_TLB_GUESS_ENTRIES (1024)	// power of 2
+
+/* IICTLB */
+#define IICTLB_PAGE_BITS 12
+#define IICTLB_ENTRIES 64
+#define IICTLB_PAGE_SIZE (1024*4)
+#define NUM_MEM_UTLB_ENTRIES 8
+
+#define MAX_L1S_SIZE (1024*1024)
+
+#define REG_OPERANDS_MAX 5
+#define SUB_IMMEDS_MAX 4		/* number of immediate fragments within insn */
+
+#define MAX_SUPPORTED_BUSES 4
+
+#define MAX_HISTO_BUCKETS 256
+
+/* Trace input format */
+//#define QTRACE_HEADER_SIZE_MAX 50 /* at most 50 chars in header */
+
+#define MAX_PMU_REGISTERS 8
+#define EXEC_PIPE_DEPTH 3
+#define MAX_L2_INTERLEAVE 2
+#define MAX_BP_QUEUE_SIZE 16
+#define MAX_CMT_WINDOW 10
+#define MAX_BRANCHES_PER_PACKET 2
+#endif							/* _MAX_H */
diff --git a/target/hexagon/imported/regs.h b/target/hexagon/imported/regs.h
new file mode 100644
index 0000000..89d4f57
--- /dev/null
+++ b/target/hexagon/imported/regs.h
@@ -0,0 +1,19 @@
+/* Copyright (c) 2019 Qualcomm Innovation Center, Inc. All Rights Reserved. */
+
+
+/*
+ * There are 32 general user regs and up to 32 user control regs.
+ */
+
+
+#ifndef _REGS_H
+#define _REGS_H
+
+#define NUM_GEN_REGS 32
+#define NUM_PREGS 4
+/* user + guest + per-thread supervisor + A regs */
+#define NUM_PER_THREAD_CR (32 + 32 + 16 + 48)
+#define TOTAL_PER_THREAD_REGS 64
+#define NUM_GLOBAL_REGS (128 + 32) /* + A regs */
+
+#endif
diff --git a/target/hexagon/op_helper.c b/target/hexagon/op_helper.c
new file mode 100644
index 0000000..d26ba66
--- /dev/null
+++ b/target/hexagon/op_helper.c
@@ -0,0 +1,29 @@
+/* Copyright (c) 2019 Qualcomm Innovation Center, Inc. All Rights Reserved. */
+
+/*
+ * Hexagon helpers
+ */
+
+#include "qemu/osdep.h"
+#include "qemu/log.h"
+#include "tcg-op.h"
+#include "cpu.h"
+#include "qemu/main-loop.h"
+#include "exec/exec-all.h"
+#include "exec/helper-proto.h"
+
+/* Exceptions processing helpers */
+void QEMU_NORETURN do_raise_exception_err(CPUHexagonState *env,
+                                          uint32_t exception, uintptr_t pc)
+{
+    CPUState *cs = CPU(hexagon_env_get_cpu(env));
+    qemu_log_mask(CPU_LOG_INT, "%s: %d\n", __func__, exception);
+    cs->exception_index = exception;
+    cpu_loop_exit_restore(cs, pc);
+}
+
+void helper_raise_exception(CPUHexagonState *env, uint32_t exception)
+{
+    do_raise_exception_err(env, exception, 0);
+}
+
diff --git a/target/hexagon/translate.c b/target/hexagon/translate.c
new file mode 100644
index 0000000..26e6c4a
--- /dev/null
+++ b/target/hexagon/translate.c
@@ -0,0 +1,220 @@
+/* Copyright (c) 2019 Qualcomm Innovation Center, Inc. All Rights Reserved. */
+
+/*
+ * Hexagon translation
+ */
+
+#include "qemu/osdep.h"
+#include "qemu/log.h"
+#include "cpu.h"
+#include "tcg-op.h"
+#include "disas/disas.h"
+#include "exec/cpu_ldst.h"
+#include "exec/exec-all.h"
+#include "exec/helper-proto.h"
+#include "exec/helper-gen.h"
+#include "translate.h"
+#include "regs.h"
+
+#include "exec/translator.h"
+#include "exec/log.h"
+
+TCGv hex_gpr[TOTAL_PER_THREAD_REGS];
+TCGv hex_pred[NUM_PREGS];
+
+
+#include "exec/gen-icount.h"
+
+void gen_exception(int excp)
+{
+    TCGv_i32 helper_tmp = tcg_const_i32(excp);
+    gen_helper_raise_exception(cpu_env, helper_tmp);
+    tcg_temp_free_i32(helper_tmp);
+}
+
+void gen_exception_debug(void)
+{
+    gen_exception(EXCP_DEBUG);
+}
+
+static void decode_packet(CPUHexagonState *env, DisasContext *ctx)
+{
+    size4u_t words[4];
+    int i;
+    /* Brute force way to make sure current PC is set */
+    tcg_gen_movi_tl(hex_gpr[HEX_REG_PC], ctx->base.pc_next);
+
+    for (i = 0; i < 4; i++) {
+        words[i] = cpu_ldl_code(env, ctx->base.pc_next + i * sizeof(size4u_t));
+    }
+    /*
+     * Brute force just enough to get the first program to execute.
+     */
+    switch (words[0]) {
+    case 0x7800c806:                                /* r6 = #64 */
+        tcg_gen_movi_tl(hex_gpr[6], 64);
+        ctx->base.pc_next += 4;
+        break;
+    case 0x7800c020:                                /* r0 = #1 */
+        tcg_gen_movi_tl(hex_gpr[0], 1);
+        ctx->base.pc_next += 4;
+        break;
+    case 0x00044002:
+        if (words[1] == 0x7800c001) {               /* r1 = ##0x400080 */
+            tcg_gen_movi_tl(hex_gpr[1], 0x400080);
+            ctx->base.pc_next += 8;
+        } else {
+            printf("ERROR: Unknown instruction 0x%x\n", words[1]);
+            g_assert_not_reached();
+        }
+        break;
+    case 0x7800c0e2:                                /* r2 = #7 */
+        tcg_gen_movi_tl(hex_gpr[2], 7);
+        ctx->base.pc_next += 4;
+        break;
+    case 0x5400c004:                               /* trap0(#1) */
+    {
+        TCGv excp_trap0 = tcg_const_tl(HEX_EXCP_TRAP0);
+        gen_helper_raise_exception(cpu_env, excp_trap0);
+        tcg_temp_free(excp_trap0);
+        ctx->base.pc_next += 4;
+        break;
+    }
+    case 0x7800cbc6:                               /* r6 = #94 */
+        tcg_gen_movi_tl(hex_gpr[6], 94);
+        ctx->base.pc_next += 4;
+        break;
+    case 0x7800cba6:                               /* r6 = #93 */
+        tcg_gen_movi_tl(hex_gpr[6], 93);
+        ctx->base.pc_next += 4;
+        break;
+    case 0x7800c000:                               /* r0 = #0 */
+        tcg_gen_movi_tl(hex_gpr[0], 0);
+        ctx->base.pc_next += 4;
+        break;
+    default:
+        ctx->base.is_jmp = DISAS_TOO_MANY;
+        ctx->base.pc_next += 4;
+    }
+}
+
+static void hexagon_tr_init_disas_context(DisasContextBase *dcbase,
+                                          CPUState *cs)
+{
+    DisasContext *ctx = container_of(dcbase, DisasContext, base);
+
+    ctx->mem_idx = ctx->base.tb->flags & TB_FLAGS_MMU_MASK;
+}
+
+static void hexagon_tr_tb_start(DisasContextBase *db, CPUState *cpu)
+{
+}
+
+static void hexagon_tr_insn_start(DisasContextBase *dcbase, CPUState *cpu)
+{
+    DisasContext *ctx = container_of(dcbase, DisasContext, base);
+
+    tcg_gen_insn_start(ctx->base.pc_next);
+}
+
+static bool hexagon_tr_breakpoint_check(DisasContextBase *dcbase, CPUState *cpu,
+                                        const CPUBreakpoint *bp)
+{
+    DisasContext *ctx = container_of(dcbase, DisasContext, base);
+
+    tcg_gen_movi_tl(hex_gpr[HEX_REG_PC], ctx->base.pc_next);
+    ctx->base.is_jmp = DISAS_NORETURN;
+    gen_exception_debug();
+    /*
+     * The address covered by the breakpoint must be included in
+     * [tb->pc, tb->pc + tb->size) in order to for it to be
+     * properly cleared -- thus we increment the PC here so that
+     * the logic setting tb->size below does the right thing.
+     */
+    ctx->base.pc_next += 4;
+    return true;
+}
+
+
+static void hexagon_tr_translate_packet(DisasContextBase *dcbase, CPUState *cpu)
+{
+    DisasContext *ctx = container_of(dcbase, DisasContext, base);
+    CPUHexagonState *env = cpu->env_ptr;
+
+    decode_packet(env, ctx);
+
+    if (ctx->base.is_jmp == DISAS_NEXT) {
+        target_ulong page_start;
+
+        page_start = ctx->base.pc_first & TARGET_PAGE_MASK;
+        if (ctx->base.pc_next - page_start >= TARGET_PAGE_SIZE) {
+            ctx->base.is_jmp = DISAS_TOO_MANY;
+        }
+
+#ifdef DEBUG_HEX
+        /* When debugging, force the end of the TB after each packet */
+        if (ctx->base.pc_next - ctx->base.pc_first >= 0x04) {
+            ctx->base.is_jmp = DISAS_TOO_MANY;
+        }
+#endif
+    }
+}
+
+static void hexagon_tr_tb_stop(DisasContextBase *dcbase, CPUState *cpu)
+{
+    DisasContext *ctx = container_of(dcbase, DisasContext, base);
+
+    switch (ctx->base.is_jmp) {
+    case DISAS_TOO_MANY:
+        tcg_gen_movi_tl(hex_gpr[HEX_REG_PC], ctx->base.pc_next);
+        if (ctx->base.singlestep_enabled) {
+            gen_exception_debug();
+        } else {
+            tcg_gen_exit_tb(NULL, 0);
+        }
+        break;
+    case DISAS_NORETURN:
+        break;
+    default:
+        g_assert_not_reached();
+    }
+}
+
+static void hexagon_tr_disas_log(const DisasContextBase *dcbase, CPUState *cpu)
+{
+    qemu_log("IN: %s\n", lookup_symbol(dcbase->pc_first));
+    log_target_disas(cpu, dcbase->pc_first, dcbase->tb->size);
+}
+
+
+static const TranslatorOps hexagon_tr_ops = {
+    .init_disas_context = hexagon_tr_init_disas_context,
+    .tb_start           = hexagon_tr_tb_start,
+    .insn_start         = hexagon_tr_insn_start,
+    .breakpoint_check   = hexagon_tr_breakpoint_check,
+    .translate_insn     = hexagon_tr_translate_packet,
+    .tb_stop            = hexagon_tr_tb_stop,
+    .disas_log          = hexagon_tr_disas_log,
+};
+
+void gen_intermediate_code(CPUState *cs, TranslationBlock *tb, int max_insns)
+{
+    DisasContext ctx;
+
+    translator_loop(&hexagon_tr_ops, &ctx.base, cs, tb, max_insns);
+}
+
+void hexagon_translate_init(void)
+{
+    int i;
+
+    for (i = 0; i < TOTAL_PER_THREAD_REGS; i++) {
+        hex_gpr[i] = tcg_global_mem_new(cpu_env,
+            offsetof(CPUHexagonState, gpr[i]), hexagon_regnames[i]);
+    }
+    for (i = 0; i < NUM_PREGS; i++) {
+        hex_pred[i] = tcg_global_mem_new(cpu_env,
+            offsetof(CPUHexagonState, pred[i]), hexagon_prednames[i]);
+    }
+}
+
diff --git a/target/hexagon/translate.h b/target/hexagon/translate.h
new file mode 100644
index 0000000..c63421e
--- /dev/null
+++ b/target/hexagon/translate.h
@@ -0,0 +1,22 @@
+/* Copyright (c) 2019 Qualcomm Innovation Center, Inc. All Rights Reserved. */
+
+#ifndef TRANSLATE_H
+#define TRANSLATE_H
+
+#include "cpu.h"
+#include "exec/translator.h"
+#include "exec/helper-proto.h"
+#include "exec/helper-gen.h"
+
+typedef struct DisasContext {
+    DisasContextBase base;
+    uint32_t mem_idx;
+} DisasContext;
+
+extern TCGv hex_gpr[TOTAL_PER_THREAD_REGS];
+extern TCGv hex_pred[NUM_PREGS];
+
+extern void gen_exception(int excp);
+extern void gen_exception_debug(void);
+
+#endif
-- 
2.7.4


