Return-Path: <SRS0=2niX=33=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD938C35247
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2020 02:11:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 858FF21D7D
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2020 02:11:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 858FF21D7D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rt-rk.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49088 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1izt6o-0001L0-J4
	for qemu-devel@archiver.kernel.org; Thu, 06 Feb 2020 21:11:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59768)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aleksandar.markovic@rt-rk.com>) id 1izsvk-0006Fc-IH
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 20:59:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.markovic@rt-rk.com>) id 1izsvi-0001Ig-4p
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 20:59:40 -0500
Received: from mx2.rt-rk.com ([89.216.37.149]:53086 helo=mail.rt-rk.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
 id 1izsvh-00018S-OY
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 20:59:38 -0500
Received: from localhost (localhost [127.0.0.1])
 by mail.rt-rk.com (Postfix) with ESMTP id D36181A2102;
 Fri,  7 Feb 2020 02:58:22 +0100 (CET)
X-Virus-Scanned: amavisd-new at rt-rk.com
Received: from rtrkw774-lin.domain.local (rtrkw774-lin.domain.local
 [10.10.14.106])
 by mail.rt-rk.com (Postfix) with ESMTPSA id 7580C1A20C9;
 Fri,  7 Feb 2020 02:58:22 +0100 (CET)
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
To: qemu-devel@nongnu.org
Subject: [PATCH rc5 09/32] target/avr: Add instruction helpers
Date: Fri,  7 Feb 2020 02:57:37 +0100
Message-Id: <1581040680-308-10-git-send-email-aleksandar.markovic@rt-rk.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1581040680-308-1-git-send-email-aleksandar.markovic@rt-rk.com>
References: <1581040680-308-1-git-send-email-aleksandar.markovic@rt-rk.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [fuzzy]
X-Received-From: 89.216.37.149
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
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Michael Rolnik <mrolnik@gmail.com>,
 Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Michael Rolnik <mrolnik@gmail.com>

Add helpers for instructions that need to interact with QEMU. Also,
add stubs for unimplemented instructions. Instructions SPM and WDR
are left unimplemented because they require emulation of complex
peripherals. The implementation of instruction SLEEP is very limited
due to the lack of peripherals to generate wake interrupts. Memory
access instructions are implemented here because some address ranges
actually refer to CPU registers.

Signed-off-by: Michael Rolnik <mrolnik@gmail.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Tested-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Reviewed-by: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
---
 target/avr/helper.h |  29 ++++++++
 target/avr/helper.c | 203 ++++++++++++++++++++++++++++++++++++++++++++++=
++++++
 MAINTAINERS         |   1 +
 3 files changed, 233 insertions(+)
 create mode 100644 target/avr/helper.h

diff --git a/target/avr/helper.h b/target/avr/helper.h
new file mode 100644
index 0000000..bf08750
--- /dev/null
+++ b/target/avr/helper.h
@@ -0,0 +1,29 @@
+/*
+ * QEMU AVR CPU
+ *
+ * Copyright (c) 2019 Michael Rolnik
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
+DEF_HELPER_1(wdr, void, env)
+DEF_HELPER_1(debug, void, env)
+DEF_HELPER_1(break, void, env)
+DEF_HELPER_1(sleep, void, env)
+DEF_HELPER_1(unsupported, void, env)
+DEF_HELPER_3(outb, void, env, i32, i32)
+DEF_HELPER_2(inb, tl, env, i32)
+DEF_HELPER_3(fullwr, void, env, i32, i32)
+DEF_HELPER_2(fullrd, tl, env, i32)
diff --git a/target/avr/helper.c b/target/avr/helper.c
index 354def2..c582312 100644
--- a/target/avr/helper.c
+++ b/target/avr/helper.c
@@ -137,3 +137,206 @@ bool avr_cpu_tlb_fill(CPUState *cs, vaddr address, =
int size,
=20
     return true;
 }
+
+/*
+ *  helpers
+ */
+
+void helper_sleep(CPUAVRState *env)
+{
+    CPUState *cs =3D env_cpu(env);
+
+    cs->exception_index =3D EXCP_HLT;
+    cpu_loop_exit(cs);
+}
+
+void helper_unsupported(CPUAVRState *env)
+{
+    CPUState *cs =3D env_cpu(env);
+
+    /*
+     *  I count not find what happens on the real platform, so
+     *  it's EXCP_DEBUG for meanwhile
+     */
+    cs->exception_index =3D EXCP_DEBUG;
+    if (qemu_loglevel_mask(LOG_UNIMP)) {
+        qemu_log("UNSUPPORTED\n");
+        cpu_dump_state(cs, stderr, 0);
+    }
+    cpu_loop_exit(cs);
+}
+
+void helper_debug(CPUAVRState *env)
+{
+    CPUState *cs =3D env_cpu(env);
+
+    cs->exception_index =3D EXCP_DEBUG;
+    cpu_loop_exit(cs);
+}
+
+void helper_break(CPUAVRState *env)
+{
+    CPUState *cs =3D env_cpu(env);
+
+    cs->exception_index =3D EXCP_DEBUG;
+    cpu_loop_exit(cs);
+}
+
+void helper_wdr(CPUAVRState *env)
+{
+    CPUState *cs =3D env_cpu(env);
+
+    /* WD is not implemented yet, placeholder */
+    cs->exception_index =3D EXCP_DEBUG;
+    cpu_loop_exit(cs);
+}
+
+/*
+ * This function implements IN instruction
+ *
+ * It does the following
+ * a.  if an IO register belongs to CPU, its value is read and returned
+ * b.  otherwise io address is translated to mem address and physical me=
mory
+ *     is read.
+ * c.  it caches the value for sake of SBI, SBIC, SBIS & CBI implementat=
ion
+ *
+ */
+target_ulong helper_inb(CPUAVRState *env, uint32_t port)
+{
+    target_ulong data =3D 0;
+
+    switch (port) {
+    case 0x38: /* RAMPD */
+        data =3D 0xff & (env->rampD >> 16);
+        break;
+    case 0x39: /* RAMPX */
+        data =3D 0xff & (env->rampX >> 16);
+        break;
+    case 0x3a: /* RAMPY */
+        data =3D 0xff & (env->rampY >> 16);
+        break;
+    case 0x3b: /* RAMPZ */
+        data =3D 0xff & (env->rampZ >> 16);
+        break;
+    case 0x3c: /* EIND */
+        data =3D 0xff & (env->eind >> 16);
+        break;
+    case 0x3d: /* SPL */
+        data =3D env->sp & 0x00ff;
+        break;
+    case 0x3e: /* SPH */
+        data =3D env->sp >> 8;
+        break;
+    case 0x3f: /* SREG */
+        data =3D cpu_get_sreg(env);
+        break;
+    default:
+        /* not a special register, pass to normal memory access */
+        cpu_physical_memory_read(OFFSET_IO_REGISTERS + port, &data, 1);
+    }
+
+    return data;
+}
+
+/*
+ *  This function implements OUT instruction
+ *
+ *  It does the following
+ *  a.  if an IO register belongs to CPU, its value is written into the =
register
+ *  b.  otherwise io address is translated to mem address and physical m=
emory
+ *      is written.
+ *  c.  it caches the value for sake of SBI, SBIC, SBIS & CBI implementa=
tion
+ *
+ */
+void helper_outb(CPUAVRState *env, uint32_t port, uint32_t data)
+{
+    data &=3D 0x000000ff;
+
+    switch (port) {
+    case 0x38: /* RAMPD */
+        if (avr_feature(env, AVR_FEATURE_RAMPD)) {
+            env->rampD =3D (data & 0xff) << 16;
+        }
+        break;
+    case 0x39: /* RAMPX */
+        if (avr_feature(env, AVR_FEATURE_RAMPX)) {
+            env->rampX =3D (data & 0xff) << 16;
+        }
+        break;
+    case 0x3a: /* RAMPY */
+        if (avr_feature(env, AVR_FEATURE_RAMPY)) {
+            env->rampY =3D (data & 0xff) << 16;
+        }
+        break;
+    case 0x3b: /* RAMPZ */
+        if (avr_feature(env, AVR_FEATURE_RAMPZ)) {
+            env->rampZ =3D (data & 0xff) << 16;
+        }
+        break;
+    case 0x3c: /* EIDN */
+        env->eind =3D (data & 0xff) << 16;
+        break;
+    case 0x3d: /* SPL */
+        env->sp =3D (env->sp & 0xff00) | (data);
+        break;
+    case 0x3e: /* SPH */
+        if (avr_feature(env, AVR_FEATURE_2_BYTE_SP)) {
+            env->sp =3D (env->sp & 0x00ff) | (data << 8);
+        }
+        break;
+    case 0x3f: /* SREG */
+        cpu_set_sreg(env, data);
+        break;
+    default:
+        /* not a special register, pass to normal memory access */
+        cpu_physical_memory_write(OFFSET_IO_REGISTERS + port, &data, 1);
+    }
+}
+
+/*
+ *  this function implements LD instruction when there is a posibility t=
o read
+ *  from a CPU register
+ */
+target_ulong helper_fullrd(CPUAVRState *env, uint32_t addr)
+{
+    uint8_t data;
+
+    env->fullacc =3D false;
+
+    if (addr < NUMBER_OF_CPU_REGISTERS) {
+        /* CPU registers */
+        data =3D env->r[addr];
+    } else if (addr < NUMBER_OF_CPU_REGISTERS + NUMBER_OF_IO_REGISTERS) =
{
+        /* IO registers */
+        data =3D helper_inb(env, addr - NUMBER_OF_CPU_REGISTERS);
+    } else {
+        /* memory */
+        cpu_physical_memory_read(OFFSET_DATA + addr, &data, 1);
+    }
+    return data;
+}
+
+/*
+ *  this function implements ST instruction when there is a posibility t=
o write
+ *  into a CPU register
+ */
+void helper_fullwr(CPUAVRState *env, uint32_t data, uint32_t addr)
+{
+    env->fullacc =3D false;
+
+    /* Following logic assumes this: */
+    assert(OFFSET_CPU_REGISTERS =3D=3D OFFSET_DATA);
+    assert(OFFSET_IO_REGISTERS =3D=3D OFFSET_CPU_REGISTERS +
+            NUMBER_OF_CPU_REGISTERS);
+
+    if (addr < NUMBER_OF_CPU_REGISTERS) {
+        /* CPU registers */
+        env->r[addr] =3D data;
+    } else if (addr < NUMBER_OF_CPU_REGISTERS + NUMBER_OF_IO_REGISTERS) =
{
+        /* IO registers */
+        helper_outb(env, addr - NUMBER_OF_CPU_REGISTERS, data);
+    } else {
+        /* memory */
+        cpu_physical_memory_write(OFFSET_DATA + addr, &data, 1);
+    }
+}
diff --git a/MAINTAINERS b/MAINTAINERS
index ef7b51f..3d83ed0 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -172,6 +172,7 @@ F: target/avr/cpu-param.h
 F: target/avr/cpu-qom.h
 F: target/avr/cpu.h
 F: target/avr/cpu.c
+F: target/avr/helper.h
 F: target/avr/helper.c
 F: target/avr/gdbstub.c
 F: target/avr/machine.c
--=20
2.7.4


