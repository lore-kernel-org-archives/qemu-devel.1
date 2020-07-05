Return-Path: <SRS0=SLMP=AQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF148C433E0
	for <qemu-devel@archiver.kernel.org>; Sun,  5 Jul 2020 14:13:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 977C520724
	for <qemu-devel@archiver.kernel.org>; Sun,  5 Jul 2020 14:13:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 977C520724
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=tuxfamily.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55616 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1js5Ox-0001JG-TA
	for qemu-devel@archiver.kernel.org; Sun, 05 Jul 2020 10:13:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54082)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <th.huth@gmail.com>) id 1js5F4-0007G5-Qs
 for qemu-devel@nongnu.org; Sun, 05 Jul 2020 10:03:38 -0400
Received: from mail-ed1-f54.google.com ([209.85.208.54]:35800)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <th.huth@gmail.com>) id 1js5F2-0008Ir-Re
 for qemu-devel@nongnu.org; Sun, 05 Jul 2020 10:03:38 -0400
Received: by mail-ed1-f54.google.com with SMTP id e15so32269755edr.2
 for <qemu-devel@nongnu.org>; Sun, 05 Jul 2020 07:03:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=ThWs2npuFTs2QlG7jMRjwGBF/50VJaTE25uW1p4Dj7s=;
 b=RwglIldGScgynuq5i10c3YHWPLZHo+FUTalKz5uHnMByU6xcdnQMrU6uvFiNRBUehZ
 5OEbTzNQhLbtLKFQZKw6tODt6YvzcKQ6KfY5JnJahor7X0uxjoT4QSxLf1CDe/VHypOr
 FDzJes6nsj05Fh/0LyzTrHDzR/5kehxDbO66kQM/ApzraEAtuinZ3H46qjel0pC1tyeR
 8Uj8kAsnZBm25iVplrND7VSbW3pYXMjwR5TKD9lwIf0/Ff2eZgCXLrWAWFZ/y42lvrPO
 lAiuw/5RhX6POpvMGqxkbX6pH0kwkYtwXW5Pm2BhxILj3P/QWaarzpAFYWbuNhh8c7Hs
 Jk6g==
X-Gm-Message-State: AOAM530JeyUAP24HnntKPthLkUyK5plrOxFJT2SA6qlfp8b/BQEPrVUk
 CzVYXFCgdGHCTJN0wBfuWO5ueoyQ
X-Google-Smtp-Source: ABdhPJztJ8zRw6HKeFbiR+SxdglqciotcfbNPdQNhGfeYui1KAN+g/+jOMeTp3urkSIjewcLy5kR3w==
X-Received: by 2002:a50:ab52:: with SMTP id t18mr51817527edc.195.1593957814991; 
 Sun, 05 Jul 2020 07:03:34 -0700 (PDT)
Received: from thl530.multi.box (pd9e83654.dip0.t-ipconnect.de.
 [217.232.54.84])
 by smtp.gmail.com with ESMTPSA id bq8sm10941776ejb.103.2020.07.05.07.03.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 05 Jul 2020 07:03:34 -0700 (PDT)
From: Thomas Huth <huth@tuxfamily.org>
To: qemu-devel@nongnu.org, Michael Rolnik <mrolnik@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Richard Henderson <rth@twiddle.net>
Subject: [PATCH rc6 09/30] target/avr: Add instruction helpers
Date: Sun,  5 Jul 2020 16:02:54 +0200
Message-Id: <20200705140315.260514-10-huth@tuxfamily.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200705140315.260514-1-huth@tuxfamily.org>
References: <20200705140315.260514-1-huth@tuxfamily.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=209.85.208.54; envelope-from=th.huth@gmail.com;
 helo=mail-ed1-f54.google.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/05 10:03:35
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -8
X-Spam_score: -0.9
X-Spam_bar: /
X-Spam_report: (-0.9 / 5.0 requ) BAYES_00=-1.9, FREEMAIL_FORGED_FROMDOMAIN=1,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Cc: Sarah Harris <S.E.Harris@kent.ac.uk>
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
Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Reviewed-by: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Signed-off-by: Thomas Huth <huth@tuxfamily.org>
---
 target/avr/helper.c | 203 ++++++++++++++++++++++++++++++++++++++++++++
 target/avr/helper.h |  29 +++++++
 2 files changed, 232 insertions(+)
 create mode 100644 target/avr/helper.h

diff --git a/target/avr/helper.c b/target/avr/helper.c
index 354def2a65..c582312d66 100644
--- a/target/avr/helper.c
+++ b/target/avr/helper.c
@@ -137,3 +137,206 @@ bool avr_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
 
     return true;
 }
+
+/*
+ *  helpers
+ */
+
+void helper_sleep(CPUAVRState *env)
+{
+    CPUState *cs = env_cpu(env);
+
+    cs->exception_index = EXCP_HLT;
+    cpu_loop_exit(cs);
+}
+
+void helper_unsupported(CPUAVRState *env)
+{
+    CPUState *cs = env_cpu(env);
+
+    /*
+     *  I count not find what happens on the real platform, so
+     *  it's EXCP_DEBUG for meanwhile
+     */
+    cs->exception_index = EXCP_DEBUG;
+    if (qemu_loglevel_mask(LOG_UNIMP)) {
+        qemu_log("UNSUPPORTED\n");
+        cpu_dump_state(cs, stderr, 0);
+    }
+    cpu_loop_exit(cs);
+}
+
+void helper_debug(CPUAVRState *env)
+{
+    CPUState *cs = env_cpu(env);
+
+    cs->exception_index = EXCP_DEBUG;
+    cpu_loop_exit(cs);
+}
+
+void helper_break(CPUAVRState *env)
+{
+    CPUState *cs = env_cpu(env);
+
+    cs->exception_index = EXCP_DEBUG;
+    cpu_loop_exit(cs);
+}
+
+void helper_wdr(CPUAVRState *env)
+{
+    CPUState *cs = env_cpu(env);
+
+    /* WD is not implemented yet, placeholder */
+    cs->exception_index = EXCP_DEBUG;
+    cpu_loop_exit(cs);
+}
+
+/*
+ * This function implements IN instruction
+ *
+ * It does the following
+ * a.  if an IO register belongs to CPU, its value is read and returned
+ * b.  otherwise io address is translated to mem address and physical memory
+ *     is read.
+ * c.  it caches the value for sake of SBI, SBIC, SBIS & CBI implementation
+ *
+ */
+target_ulong helper_inb(CPUAVRState *env, uint32_t port)
+{
+    target_ulong data = 0;
+
+    switch (port) {
+    case 0x38: /* RAMPD */
+        data = 0xff & (env->rampD >> 16);
+        break;
+    case 0x39: /* RAMPX */
+        data = 0xff & (env->rampX >> 16);
+        break;
+    case 0x3a: /* RAMPY */
+        data = 0xff & (env->rampY >> 16);
+        break;
+    case 0x3b: /* RAMPZ */
+        data = 0xff & (env->rampZ >> 16);
+        break;
+    case 0x3c: /* EIND */
+        data = 0xff & (env->eind >> 16);
+        break;
+    case 0x3d: /* SPL */
+        data = env->sp & 0x00ff;
+        break;
+    case 0x3e: /* SPH */
+        data = env->sp >> 8;
+        break;
+    case 0x3f: /* SREG */
+        data = cpu_get_sreg(env);
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
+ *  a.  if an IO register belongs to CPU, its value is written into the register
+ *  b.  otherwise io address is translated to mem address and physical memory
+ *      is written.
+ *  c.  it caches the value for sake of SBI, SBIC, SBIS & CBI implementation
+ *
+ */
+void helper_outb(CPUAVRState *env, uint32_t port, uint32_t data)
+{
+    data &= 0x000000ff;
+
+    switch (port) {
+    case 0x38: /* RAMPD */
+        if (avr_feature(env, AVR_FEATURE_RAMPD)) {
+            env->rampD = (data & 0xff) << 16;
+        }
+        break;
+    case 0x39: /* RAMPX */
+        if (avr_feature(env, AVR_FEATURE_RAMPX)) {
+            env->rampX = (data & 0xff) << 16;
+        }
+        break;
+    case 0x3a: /* RAMPY */
+        if (avr_feature(env, AVR_FEATURE_RAMPY)) {
+            env->rampY = (data & 0xff) << 16;
+        }
+        break;
+    case 0x3b: /* RAMPZ */
+        if (avr_feature(env, AVR_FEATURE_RAMPZ)) {
+            env->rampZ = (data & 0xff) << 16;
+        }
+        break;
+    case 0x3c: /* EIDN */
+        env->eind = (data & 0xff) << 16;
+        break;
+    case 0x3d: /* SPL */
+        env->sp = (env->sp & 0xff00) | (data);
+        break;
+    case 0x3e: /* SPH */
+        if (avr_feature(env, AVR_FEATURE_2_BYTE_SP)) {
+            env->sp = (env->sp & 0x00ff) | (data << 8);
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
+ *  this function implements LD instruction when there is a posibility to read
+ *  from a CPU register
+ */
+target_ulong helper_fullrd(CPUAVRState *env, uint32_t addr)
+{
+    uint8_t data;
+
+    env->fullacc = false;
+
+    if (addr < NUMBER_OF_CPU_REGISTERS) {
+        /* CPU registers */
+        data = env->r[addr];
+    } else if (addr < NUMBER_OF_CPU_REGISTERS + NUMBER_OF_IO_REGISTERS) {
+        /* IO registers */
+        data = helper_inb(env, addr - NUMBER_OF_CPU_REGISTERS);
+    } else {
+        /* memory */
+        cpu_physical_memory_read(OFFSET_DATA + addr, &data, 1);
+    }
+    return data;
+}
+
+/*
+ *  this function implements ST instruction when there is a posibility to write
+ *  into a CPU register
+ */
+void helper_fullwr(CPUAVRState *env, uint32_t data, uint32_t addr)
+{
+    env->fullacc = false;
+
+    /* Following logic assumes this: */
+    assert(OFFSET_CPU_REGISTERS == OFFSET_DATA);
+    assert(OFFSET_IO_REGISTERS == OFFSET_CPU_REGISTERS +
+            NUMBER_OF_CPU_REGISTERS);
+
+    if (addr < NUMBER_OF_CPU_REGISTERS) {
+        /* CPU registers */
+        env->r[addr] = data;
+    } else if (addr < NUMBER_OF_CPU_REGISTERS + NUMBER_OF_IO_REGISTERS) {
+        /* IO registers */
+        helper_outb(env, addr - NUMBER_OF_CPU_REGISTERS, data);
+    } else {
+        /* memory */
+        cpu_physical_memory_write(OFFSET_DATA + addr, &data, 1);
+    }
+}
diff --git a/target/avr/helper.h b/target/avr/helper.h
new file mode 100644
index 0000000000..bf087504a8
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
-- 
2.26.2


