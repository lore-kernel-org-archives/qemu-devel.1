Return-Path: <SRS0=mO9Z=3M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61EBFC32771
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 00:10:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 055D02064C
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 00:10:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GD9+k16u"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 055D02064C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48716 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iuQ57-0007uQ-O3
	for qemu-devel@archiver.kernel.org; Wed, 22 Jan 2020 19:10:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:54471)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iuPz3-0001uz-HI
 for qemu-devel@nongnu.org; Wed, 22 Jan 2020 19:04:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iuPyq-0001rV-Kn
 for qemu-devel@nongnu.org; Wed, 22 Jan 2020 19:04:26 -0500
Received: from mail-pj1-f68.google.com ([209.85.216.68]:39386)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iuPyq-0001qn-8S
 for qemu-devel@nongnu.org; Wed, 22 Jan 2020 19:04:16 -0500
Received: by mail-pj1-f68.google.com with SMTP id e11so327072pjt.4
 for <qemu-devel@nongnu.org>; Wed, 22 Jan 2020 16:04:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=KeodLGG/x2AvQv7njqgNVswfkO+gng4MaBNpKnswz6M=;
 b=GD9+k16u0FJu1BKZmRiFoukcOKn3wShwRXnryiLwhQ+TXruXSoYMHgJ6sjC1l8fqPK
 PMZpdDDEfecJ9DKsfEOWTEDlEvdnZ13OFGf4aR1tmha7ylxU6uvc0EG/eUV6hh3i/yas
 /XexcEbj0eA4Bia666A85sIHSH07ppueqBn2XREb1hv1fiJjEoWu4RNzlpssi1i9VQPi
 zzKYt+RMsF+MKJuu00QmMWFWzGLGJJO9NK6xL2FjNRi8SHoxOt3/ZaYunI34ItdOeI23
 t6tw9zWtYmGLQF/AAii2SG482BjUx0w2Ll1Oa9Q3jadCqo23zneouJXiKhp+jA/kWOs8
 JmOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=KeodLGG/x2AvQv7njqgNVswfkO+gng4MaBNpKnswz6M=;
 b=LKqr2FWSCGTHgneTnnflHQDnqU3DD6+BcRcFRDT3EHbD8TGjaVnOxgIZOwsRdWiBIt
 NKn4uMX+sn1IOtS0awwMO6FlydWahYU/0U7A//sg/A4NUD/2T2zFs/OaU6hWV5OrDYRP
 xNgiM4MMz1qEmYrWV6VBb6N9Rsn+MbXkAzka6igQa+NKZOjjHxxisgNdJ4iDI3jI8/x6
 kt0qQ+nuET2Ida6ekCrEZb9pyRuv9nWVR+aMJIVPgsFjCp1r8Fux+1/KpFgTwOd5nu2L
 oemj80Gtw20hjrCfuEw7bvVpKABZvY1MCfVxHxi8SBLKfzLmPX8RhXklcKSK4DWzgIIa
 XvWw==
X-Gm-Message-State: APjAAAVyTXi+2sfQ1Q08pgZGGP7Ai/xZcBAR/HtwudbkVEMceAY6OvcP
 XAuo/E39QgetrOCe9013ReAxJUQqoQs=
X-Google-Smtp-Source: APXvYqwPJCpQnsxvzzMh2b9WiBdULiYRJf1C7EpbGHzgtiJcD1xWQeNZhhjgc+Omzivx6jwRSj2kXw==
X-Received: by 2002:a17:902:6904:: with SMTP id
 j4mr13979589plk.88.1579737793528; 
 Wed, 22 Jan 2020 16:03:13 -0800 (PST)
Received: from localhost.localdomain (rrcs-173-198-77-92.west.biz.rr.com.
 [173.198.77.92])
 by smtp.gmail.com with ESMTPSA id b21sm84521pfp.0.2020.01.22.16.03.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Jan 2020 16:03:12 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH rc1 01/24] target/avr: Add outward facing interfaces and core
 CPU logic
Date: Wed, 22 Jan 2020 14:02:44 -1000
Message-Id: <20200123000307.11541-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200123000307.11541-1-richard.henderson@linaro.org>
References: <20200123000307.11541-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.216.68
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
Cc: thuth@redhat.com, me@xcancerberox.com.ar, S.E.Harris@kent.ac.uk,
 dovgaluk@ispras.ru, imammedo@redhat.com, mrolnik@gmail.com,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 aleksandar.m.mail@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Michael Rolnik <mrolnik@gmail.com>

This includes:
- CPU data structures
- object model classes and functions
- migration functions
- GDB hooks

Co-developed-by: Michael Rolnik <mrolnik@gmail.com>
Co-developed-by: Sarah Harris <S.E.Harris@kent.ac.uk>
Signed-off-by: Michael Rolnik <mrolnik@gmail.com>
Signed-off-by: Sarah Harris <S.E.Harris@kent.ac.uk>
Signed-off-by: Michael Rolnik <mrolnik@gmail.com>
Acked-by: Igor Mammedov <imammedo@redhat.com>
Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Message-Id: <20200118191416.19934-2-mrolnik@gmail.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/avr/cpu-param.h |  37 ++
 target/avr/cpu-qom.h   |  54 +++
 target/avr/cpu.h       | 258 +++++++++++++
 target/avr/cpu.c       | 826 +++++++++++++++++++++++++++++++++++++++++
 target/avr/gdbstub.c   |  84 +++++
 target/avr/machine.c   | 121 ++++++
 gdb-xml/avr-cpu.xml    |  49 +++
 7 files changed, 1429 insertions(+)
 create mode 100644 target/avr/cpu-param.h
 create mode 100644 target/avr/cpu-qom.h
 create mode 100644 target/avr/cpu.h
 create mode 100644 target/avr/cpu.c
 create mode 100644 target/avr/gdbstub.c
 create mode 100644 target/avr/machine.c
 create mode 100644 gdb-xml/avr-cpu.xml

diff --git a/target/avr/cpu-param.h b/target/avr/cpu-param.h
new file mode 100644
index 0000000000..0c29ce4223
--- /dev/null
+++ b/target/avr/cpu-param.h
@@ -0,0 +1,37 @@
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
+#ifndef AVR_CPU_PARAM_H
+#define AVR_CPU_PARAM_H
+
+#define TARGET_LONG_BITS 32
+/*
+ * TARGET_PAGE_BITS cannot be more than 8 bits because
+ * 1.  all IO registers occupy [0x0000 .. 0x00ff] address range, and they
+ *     should be implemented as a device and not memory
+ * 2.  SRAM starts at the address 0x0100
+ */
+#define TARGET_PAGE_BITS 8
+#define TARGET_PHYS_ADDR_SPACE_BITS 24
+#define TARGET_VIRT_ADDR_SPACE_BITS 24
+#define NB_MMU_MODES 2
+
+
+#endif
diff --git a/target/avr/cpu-qom.h b/target/avr/cpu-qom.h
new file mode 100644
index 0000000000..e28b58c897
--- /dev/null
+++ b/target/avr/cpu-qom.h
@@ -0,0 +1,54 @@
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
+#ifndef QEMU_AVR_QOM_H
+#define QEMU_AVR_QOM_H
+
+#include "hw/core/cpu.h"
+
+#define TYPE_AVR_CPU "avr-cpu"
+
+#define AVR_CPU_CLASS(klass) \
+    OBJECT_CLASS_CHECK(AVRCPUClass, (klass), TYPE_AVR_CPU)
+#define AVR_CPU(obj) \
+    OBJECT_CHECK(AVRCPU, (obj), TYPE_AVR_CPU)
+#define AVR_CPU_GET_CLASS(obj) \
+    OBJECT_GET_CLASS(AVRCPUClass, (obj), TYPE_AVR_CPU)
+
+/**
+ *  AVRCPUClass:
+ *  @parent_realize: The parent class' realize handler.
+ *  @parent_reset: The parent class' reset handler.
+ *  @vr: Version Register value.
+ *
+ *  A AVR CPU model.
+ */
+typedef struct AVRCPUClass {
+    /*< private >*/
+    CPUClass parent_class;
+    /*< public >*/
+    DeviceRealize parent_realize;
+    void (*parent_reset)(CPUState *cpu);
+} AVRCPUClass;
+
+typedef struct AVRCPU AVRCPU;
+
+
+#endif /* !defined (QEMU_AVR_CPU_QOM_H) */
diff --git a/target/avr/cpu.h b/target/avr/cpu.h
new file mode 100644
index 0000000000..b74bcf01ae
--- /dev/null
+++ b/target/avr/cpu.h
@@ -0,0 +1,258 @@
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
+#ifndef QEMU_AVR_CPU_H
+#define QEMU_AVR_CPU_H
+
+#include "cpu-qom.h"
+#include "exec/cpu-defs.h"
+
+#define TCG_GUEST_DEFAULT_MO 0
+#define AVR_CPU_TYPE_SUFFIX "-" TYPE_AVR_CPU
+#define AVR_CPU_TYPE_NAME(name) (name AVR_CPU_TYPE_SUFFIX)
+#define CPU_RESOLVING_TYPE TYPE_AVR_CPU
+
+/*
+ * AVR has two memory spaces, data & code.
+ * e.g. both have 0 address
+ * ST/LD instructions access data space
+ * LPM/SPM and instruction fetching access code memory space
+ */
+#define MMU_CODE_IDX 0
+#define MMU_DATA_IDX 1
+
+#define EXCP_RESET 1
+#define EXCP_INT(n) (EXCP_RESET + (n) + 1)
+
+/* Number of CPU registers */
+#define NUMBER_OF_CPU_REGISTERS 32
+/* Number of IO registers accessible by ld/st/in/out */
+#define NUMBER_OF_IO_REGISTERS 64
+
+/*
+ * Offsets of AVR memory regions in host memory space.
+ *
+ * This is needed because the AVR has separate code and data address
+ * spaces that both have start from zero but have to go somewhere in
+ * host memory.
+ *
+ * It's also useful to know where some things are, like the IO registers.
+ */
+/* Flash program memory */
+#define OFFSET_CODE 0x00000000
+/* CPU registers, IO registers, and SRAM */
+#define OFFSET_DATA 0x00800000
+/* CPU registers specifically, these are mapped at the start of data */
+#define OFFSET_CPU_REGISTERS OFFSET_DATA
+/*
+ * IO registers, including status register, stack pointer, and memory
+ * mapped peripherals, mapped just after CPU registers
+ */
+#define OFFSET_IO_REGISTERS (OFFSET_DATA + NUMBER_OF_CPU_REGISTERS)
+
+#define EF_AVR_MACH 0x7F
+
+typedef enum AVRFeature {
+    AVR_FEATURE_SRAM,
+
+    AVR_FEATURE_1_BYTE_PC,
+    AVR_FEATURE_2_BYTE_PC,
+    AVR_FEATURE_3_BYTE_PC,
+
+    AVR_FEATURE_1_BYTE_SP,
+    AVR_FEATURE_2_BYTE_SP,
+
+    AVR_FEATURE_BREAK,
+    AVR_FEATURE_DES,
+    AVR_FEATURE_RMW, /* Read Modify Write - XCH LAC LAS LAT */
+
+    AVR_FEATURE_EIJMP_EICALL,
+    AVR_FEATURE_IJMP_ICALL,
+    AVR_FEATURE_JMP_CALL,
+
+    AVR_FEATURE_ADIW_SBIW,
+
+    AVR_FEATURE_SPM,
+    AVR_FEATURE_SPMX,
+
+    AVR_FEATURE_ELPMX,
+    AVR_FEATURE_ELPM,
+    AVR_FEATURE_LPMX,
+    AVR_FEATURE_LPM,
+
+    AVR_FEATURE_MOVW,
+    AVR_FEATURE_MUL,
+    AVR_FEATURE_RAMPD,
+    AVR_FEATURE_RAMPX,
+    AVR_FEATURE_RAMPY,
+    AVR_FEATURE_RAMPZ,
+} AVRFeature;
+
+typedef struct CPUAVRState CPUAVRState;
+
+struct CPUAVRState {
+    uint32_t pc_w; /* 0x003fffff up to 22 bits */
+
+    uint32_t sregC; /* 0x00000001 1 bit */
+    uint32_t sregZ; /* 0x00000001 1 bit */
+    uint32_t sregN; /* 0x00000001 1 bit */
+    uint32_t sregV; /* 0x00000001 1 bit */
+    uint32_t sregS; /* 0x00000001 1 bit */
+    uint32_t sregH; /* 0x00000001 1 bit */
+    uint32_t sregT; /* 0x00000001 1 bit */
+    uint32_t sregI; /* 0x00000001 1 bit */
+
+    uint32_t rampD; /* 0x00ff0000 8 bits */
+    uint32_t rampX; /* 0x00ff0000 8 bits */
+    uint32_t rampY; /* 0x00ff0000 8 bits */
+    uint32_t rampZ; /* 0x00ff0000 8 bits */
+    uint32_t eind; /* 0x00ff0000 8 bits */
+
+    uint32_t r[NUMBER_OF_CPU_REGISTERS]; /* 8 bits each */
+    uint32_t sp; /* 16 bits */
+
+    uint32_t skip; /* if set skip instruction */
+
+    uint64_t intsrc; /* interrupt sources */
+    bool fullacc; /* CPU/MEM if true MEM only otherwise */
+
+    uint32_t features;
+};
+
+/**
+ *  AVRCPU:
+ *  @env: #CPUAVRState
+ *
+ *  A AVR CPU.
+ */
+typedef struct AVRCPU {
+    /*< private >*/
+    CPUState parent_obj;
+    /*< public >*/
+
+    CPUNegativeOffsetState neg;
+    CPUAVRState env;
+} AVRCPU;
+
+#ifndef CONFIG_USER_ONLY
+extern const struct VMStateDescription vms_avr_cpu;
+#endif
+
+void avr_cpu_do_interrupt(CPUState *cpu);
+bool avr_cpu_exec_interrupt(CPUState *cpu, int int_req);
+hwaddr avr_cpu_get_phys_page_debug(CPUState *cpu, vaddr addr);
+int avr_cpu_gdb_read_register(CPUState *cpu, uint8_t *buf, int reg);
+int avr_cpu_gdb_write_register(CPUState *cpu, uint8_t *buf, int reg);
+
+static inline int avr_feature(CPUAVRState *env, AVRFeature feature)
+{
+    return (env->features & (1U << feature)) != 0;
+}
+
+static inline void avr_set_feature(CPUAVRState *env, int feature)
+{
+    env->features |= (1U << feature);
+}
+
+#define cpu_list avr_cpu_list
+#define cpu_signal_handler cpu_avr_signal_handler
+#define cpu_mmu_index avr_cpu_mmu_index
+
+static inline int avr_cpu_mmu_index(CPUAVRState *env, bool ifetch)
+{
+    return ifetch ? MMU_CODE_IDX : MMU_DATA_IDX;
+}
+
+void avr_cpu_tcg_init(void);
+
+void avr_cpu_list(void);
+int cpu_avr_exec(CPUState *cpu);
+int cpu_avr_signal_handler(int host_signum, void *pinfo, void *puc);
+int avr_cpu_handle_mmu_fault(CPUState *cpu, vaddr address, int size,
+                                int rw, int mmu_idx);
+int avr_cpu_memory_rw_debug(CPUState *cs, vaddr address, uint8_t *buf,
+                                int len, bool is_write);
+
+enum {
+    TB_FLAGS_FULL_ACCESS = 1,
+    TB_FLAGS_SKIP = 2,
+};
+
+static inline void cpu_get_tb_cpu_state(CPUAVRState *env, target_ulong *pc,
+                                target_ulong *cs_base, uint32_t *pflags)
+{
+    uint32_t flags = 0;
+
+    *pc = env->pc_w * 2;
+    *cs_base = 0;
+
+    if (env->fullacc) {
+        flags |= TB_FLAGS_FULL_ACCESS;
+    }
+    if (env->skip) {
+        flags |= TB_FLAGS_SKIP;
+    }
+
+    *pflags = flags;
+}
+
+static inline int cpu_interrupts_enabled(CPUAVRState *env)
+{
+    return env->sregI != 0;
+}
+
+static inline uint8_t cpu_get_sreg(CPUAVRState *env)
+{
+    uint8_t sreg;
+    sreg = (env->sregC) << 0
+         | (env->sregZ) << 1
+         | (env->sregN) << 2
+         | (env->sregV) << 3
+         | (env->sregS) << 4
+         | (env->sregH) << 5
+         | (env->sregT) << 6
+         | (env->sregI) << 7;
+    return sreg;
+}
+
+static inline void cpu_set_sreg(CPUAVRState *env, uint8_t sreg)
+{
+    env->sregC = (sreg >> 0) & 0x01;
+    env->sregZ = (sreg >> 1) & 0x01;
+    env->sregN = (sreg >> 2) & 0x01;
+    env->sregV = (sreg >> 3) & 0x01;
+    env->sregS = (sreg >> 4) & 0x01;
+    env->sregH = (sreg >> 5) & 0x01;
+    env->sregT = (sreg >> 6) & 0x01;
+    env->sregI = (sreg >> 7) & 0x01;
+}
+
+bool avr_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
+                        MMUAccessType access_type, int mmu_idx,
+                        bool probe, uintptr_t retaddr);
+
+typedef CPUAVRState CPUArchState;
+typedef AVRCPU ArchCPU;
+
+#include "exec/cpu-all.h"
+
+const char *avr_flags_to_cpu_type(uint32_t flags, const char *def_cpu_type);
+
+#endif /* !defined (QEMU_AVR_CPU_H) */
diff --git a/target/avr/cpu.c b/target/avr/cpu.c
new file mode 100644
index 0000000000..c74c5106fe
--- /dev/null
+++ b/target/avr/cpu.c
@@ -0,0 +1,826 @@
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
+#include "qemu/osdep.h"
+#include "qapi/error.h"
+#include "qemu/qemu-print.h"
+#include "exec/exec-all.h"
+#include "cpu.h"
+#include "disas/dis-asm.h"
+
+static void avr_cpu_set_pc(CPUState *cs, vaddr value)
+{
+    AVRCPU *cpu = AVR_CPU(cs);
+
+    cpu->env.pc_w = value / 2; /* internally PC points to words */
+}
+
+static bool avr_cpu_has_work(CPUState *cs)
+{
+    AVRCPU *cpu = AVR_CPU(cs);
+    CPUAVRState *env = &cpu->env;
+
+    return (cs->interrupt_request & (CPU_INTERRUPT_HARD | CPU_INTERRUPT_RESET))
+            && cpu_interrupts_enabled(env);
+}
+
+static void avr_cpu_synchronize_from_tb(CPUState *cs, TranslationBlock *tb)
+{
+    AVRCPU *cpu = AVR_CPU(cs);
+    CPUAVRState *env = &cpu->env;
+
+    env->pc_w = tb->pc / 2; /* internally PC points to words */
+}
+
+static void avr_cpu_reset(CPUState *cs)
+{
+    AVRCPU *cpu = AVR_CPU(cs);
+    AVRCPUClass *mcc = AVR_CPU_GET_CLASS(cpu);
+    CPUAVRState *env = &cpu->env;
+
+    mcc->parent_reset(cs);
+
+    env->pc_w = 0;
+    env->sregI = 1;
+    env->sregC = 0;
+    env->sregZ = 0;
+    env->sregN = 0;
+    env->sregV = 0;
+    env->sregS = 0;
+    env->sregH = 0;
+    env->sregT = 0;
+
+    env->rampD = 0;
+    env->rampX = 0;
+    env->rampY = 0;
+    env->rampZ = 0;
+    env->eind = 0;
+    env->sp = 0;
+
+    env->skip = 0;
+
+    memset(env->r, 0, sizeof(env->r));
+
+    tlb_flush(cs);
+}
+
+static void avr_cpu_disas_set_info(CPUState *cpu, disassemble_info *info)
+{
+    info->mach = bfd_arch_avr;
+    info->print_insn = NULL;
+}
+
+static void avr_cpu_realizefn(DeviceState *dev, Error **errp)
+{
+    CPUState *cs = CPU(dev);
+    AVRCPUClass *mcc = AVR_CPU_GET_CLASS(dev);
+    Error *local_err = NULL;
+
+    cpu_exec_realizefn(cs, &local_err);
+    if (local_err != NULL) {
+        error_propagate(errp, local_err);
+        return;
+    }
+    qemu_init_vcpu(cs);
+    cpu_reset(cs);
+
+    mcc->parent_realize(dev, errp);
+}
+
+static void avr_cpu_set_int(void *opaque, int irq, int level)
+{
+    AVRCPU *cpu = opaque;
+    CPUAVRState *env = &cpu->env;
+    CPUState *cs = CPU(cpu);
+
+    uint64_t mask = (1ull << irq);
+    if (level) {
+        env->intsrc |= mask;
+        cpu_interrupt(cs, CPU_INTERRUPT_HARD);
+    } else {
+        env->intsrc &= ~mask;
+        if (env->intsrc == 0) {
+            cpu_reset_interrupt(cs, CPU_INTERRUPT_HARD);
+        }
+    }
+}
+
+static void avr_cpu_initfn(Object *obj)
+{
+    AVRCPU *cpu = AVR_CPU(obj);
+
+    cpu_set_cpustate_pointers(cpu);
+
+#ifndef CONFIG_USER_ONLY
+    /* Set the number of interrupts supported by the CPU. */
+    qdev_init_gpio_in(DEVICE(cpu), avr_cpu_set_int,
+            sizeof(cpu->env.intsrc) * 8);
+#endif
+}
+
+static ObjectClass *avr_cpu_class_by_name(const char *cpu_model)
+{
+    ObjectClass *oc;
+
+    oc = object_class_by_name(cpu_model);
+    if (object_class_dynamic_cast(oc, TYPE_AVR_CPU) == NULL ||
+        object_class_is_abstract(oc)) {
+        oc = NULL;
+    }
+    return oc;
+}
+
+static void avr_cpu_dump_state(CPUState *cs, FILE *f, int flags)
+{
+    AVRCPU *cpu = AVR_CPU(cs);
+    CPUAVRState *env = &cpu->env;
+    int i;
+
+    qemu_fprintf(f, "\n");
+    qemu_fprintf(f, "PC:    %06x\n", env->pc_w);
+    qemu_fprintf(f, "SP:      %04x\n", env->sp);
+    qemu_fprintf(f, "rampD:     %02x\n", env->rampD >> 16);
+    qemu_fprintf(f, "rampX:     %02x\n", env->rampX >> 16);
+    qemu_fprintf(f, "rampY:     %02x\n", env->rampY >> 16);
+    qemu_fprintf(f, "rampZ:     %02x\n", env->rampZ >> 16);
+    qemu_fprintf(f, "EIND:      %02x\n", env->eind >> 16);
+    qemu_fprintf(f, "X:       %02x%02x\n", env->r[27], env->r[26]);
+    qemu_fprintf(f, "Y:       %02x%02x\n", env->r[29], env->r[28]);
+    qemu_fprintf(f, "Z:       %02x%02x\n", env->r[31], env->r[30]);
+    qemu_fprintf(f, "SREG:    [ %c %c %c %c %c %c %c %c ]\n",
+                        env->sregI ? 'I' : '-',
+                        env->sregT ? 'T' : '-',
+                        env->sregH ? 'H' : '-',
+                        env->sregS ? 'S' : '-',
+                        env->sregV ? 'V' : '-',
+                        env->sregN ? '-' : 'N', /* Zf has negative logic */
+                        env->sregZ ? 'Z' : '-',
+                        env->sregC ? 'I' : '-');
+    qemu_fprintf(f, "SKIP:    %02x\n", env->skip);
+
+    qemu_fprintf(f, "\n");
+    for (i = 0; i < ARRAY_SIZE(env->r); i++) {
+        qemu_fprintf(f, "R[%02d]:  %02x   ", i, env->r[i]);
+
+        if ((i % 8) == 7) {
+            qemu_fprintf(f, "\n");
+        }
+    }
+    qemu_fprintf(f, "\n");
+}
+
+static void avr_cpu_class_init(ObjectClass *oc, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(oc);
+    CPUClass *cc = CPU_CLASS(oc);
+    AVRCPUClass *mcc = AVR_CPU_CLASS(oc);
+
+    mcc->parent_realize = dc->realize;
+    dc->realize = avr_cpu_realizefn;
+
+    mcc->parent_reset = cc->reset;
+    cc->reset = avr_cpu_reset;
+
+    cc->class_by_name = avr_cpu_class_by_name;
+
+    cc->has_work = avr_cpu_has_work;
+    cc->do_interrupt = avr_cpu_do_interrupt;
+    cc->cpu_exec_interrupt = avr_cpu_exec_interrupt;
+    cc->dump_state = avr_cpu_dump_state;
+    cc->set_pc = avr_cpu_set_pc;
+#if !defined(CONFIG_USER_ONLY)
+    cc->memory_rw_debug = avr_cpu_memory_rw_debug;
+#endif
+#ifdef CONFIG_USER_ONLY
+    cc->handle_mmu_fault = avr_cpu_handle_mmu_fault;
+#else
+    cc->get_phys_page_debug = avr_cpu_get_phys_page_debug;
+    cc->vmsd = &vms_avr_cpu;
+#endif
+    cc->disas_set_info = avr_cpu_disas_set_info;
+    cc->tlb_fill = avr_cpu_tlb_fill;
+    cc->tcg_initialize = avr_cpu_tcg_init;
+    cc->synchronize_from_tb = avr_cpu_synchronize_from_tb;
+    cc->gdb_read_register = avr_cpu_gdb_read_register;
+    cc->gdb_write_register = avr_cpu_gdb_write_register;
+    cc->gdb_num_core_regs = 35;
+    cc->gdb_core_xml_file = "avr-cpu.xml";
+}
+
+/*
+ * Setting features of AVR core type avr1
+ * --------------------------------------
+ *
+ * This type of AVR core is present in the following AVR MCUs:
+ *
+ * at90s1200, attiny11, attiny12, attiny15, attiny28
+ */
+static void avr_avr1_initfn(Object *obj)
+{
+    AVRCPU *cpu = AVR_CPU(obj);
+    CPUAVRState *env = &cpu->env;
+
+    avr_set_feature(env, AVR_FEATURE_LPM);
+    avr_set_feature(env, AVR_FEATURE_2_BYTE_SP);
+    avr_set_feature(env, AVR_FEATURE_2_BYTE_PC);
+}
+
+/*
+ * Setting features of AVR core type avr2
+ * --------------------------------------
+ *
+ * This type of AVR core is present in the following AVR MCUs:
+ *
+ * at90s2313, at90s2323, at90s2333, at90s2343, attiny22, attiny26, at90s4414,
+ * at90s4433, at90s4434, at90s8515, at90c8534, at90s8535
+ */
+static void avr_avr2_initfn(Object *obj)
+{
+    AVRCPU *cpu = AVR_CPU(obj);
+    CPUAVRState *env = &cpu->env;
+
+    avr_set_feature(env, AVR_FEATURE_LPM);
+    avr_set_feature(env, AVR_FEATURE_IJMP_ICALL);
+    avr_set_feature(env, AVR_FEATURE_ADIW_SBIW);
+    avr_set_feature(env, AVR_FEATURE_SRAM);
+    avr_set_feature(env, AVR_FEATURE_BREAK);
+
+    avr_set_feature(env, AVR_FEATURE_2_BYTE_PC);
+    avr_set_feature(env, AVR_FEATURE_2_BYTE_SP);
+}
+
+/*
+ * Setting features of AVR core type avr25
+ * --------------------------------------
+ *
+ * This type of AVR core is present in the following AVR MCUs:
+ *
+ * ata5272, ata6616c, attiny13, attiny13a, attiny2313, attiny2313a, attiny24,
+ * attiny24a, attiny4313, attiny44, attiny44a, attiny441, attiny84, attiny84a,
+ * attiny25, attiny45, attiny85, attiny261, attiny261a, attiny461, attiny461a,
+ * attiny861, attiny861a, attiny43u, attiny87, attiny48, attiny88, attiny828,
+ * attiny841, at86rf401
+ */
+static void avr_avr25_initfn(Object *obj)
+{
+    AVRCPU *cpu = AVR_CPU(obj);
+    CPUAVRState *env = &cpu->env;
+
+    avr_set_feature(env, AVR_FEATURE_LPM);
+    avr_set_feature(env, AVR_FEATURE_IJMP_ICALL);
+    avr_set_feature(env, AVR_FEATURE_ADIW_SBIW);
+    avr_set_feature(env, AVR_FEATURE_SRAM);
+    avr_set_feature(env, AVR_FEATURE_BREAK);
+
+    avr_set_feature(env, AVR_FEATURE_2_BYTE_PC);
+    avr_set_feature(env, AVR_FEATURE_2_BYTE_SP);
+    avr_set_feature(env, AVR_FEATURE_LPMX);
+    avr_set_feature(env, AVR_FEATURE_MOVW);
+}
+
+/*
+ * Setting features of AVR core type avr3
+ * --------------------------------------
+ *
+ * This type of AVR core is present in the following AVR MCUs:
+ *
+ * at43usb355, at76c711
+ */
+static void avr_avr3_initfn(Object *obj)
+{
+    AVRCPU *cpu = AVR_CPU(obj);
+    CPUAVRState *env = &cpu->env;
+
+    avr_set_feature(env, AVR_FEATURE_LPM);
+    avr_set_feature(env, AVR_FEATURE_IJMP_ICALL);
+    avr_set_feature(env, AVR_FEATURE_ADIW_SBIW);
+    avr_set_feature(env, AVR_FEATURE_SRAM);
+    avr_set_feature(env, AVR_FEATURE_BREAK);
+
+    avr_set_feature(env, AVR_FEATURE_2_BYTE_PC);
+    avr_set_feature(env, AVR_FEATURE_2_BYTE_SP);
+    avr_set_feature(env, AVR_FEATURE_JMP_CALL);
+}
+
+/*
+ * Setting features of AVR core type avr31
+ * --------------------------------------
+ *
+ * This type of AVR core is present in the following AVR MCUs:
+ *
+ * atmega103, at43usb320
+ */
+static void avr_avr31_initfn(Object *obj)
+{
+    AVRCPU *cpu = AVR_CPU(obj);
+    CPUAVRState *env = &cpu->env;
+
+    avr_set_feature(env, AVR_FEATURE_LPM);
+    avr_set_feature(env, AVR_FEATURE_IJMP_ICALL);
+    avr_set_feature(env, AVR_FEATURE_ADIW_SBIW);
+    avr_set_feature(env, AVR_FEATURE_SRAM);
+    avr_set_feature(env, AVR_FEATURE_BREAK);
+
+    avr_set_feature(env, AVR_FEATURE_2_BYTE_PC);
+    avr_set_feature(env, AVR_FEATURE_2_BYTE_SP);
+    avr_set_feature(env, AVR_FEATURE_RAMPZ);
+    avr_set_feature(env, AVR_FEATURE_ELPM);
+    avr_set_feature(env, AVR_FEATURE_JMP_CALL);
+}
+
+/*
+ * Setting features of AVR core type avr35
+ * --------------------------------------
+ *
+ * This type of AVR core is present in the following AVR MCUs:
+ *
+ * ata5505, ata6617c, ata664251, at90usb82, at90usb162, atmega8u2, atmega16u2,
+ * atmega32u2, attiny167, attiny1634
+ */
+static void avr_avr35_initfn(Object *obj)
+{
+    AVRCPU *cpu = AVR_CPU(obj);
+    CPUAVRState *env = &cpu->env;
+
+    avr_set_feature(env, AVR_FEATURE_LPM);
+    avr_set_feature(env, AVR_FEATURE_IJMP_ICALL);
+    avr_set_feature(env, AVR_FEATURE_ADIW_SBIW);
+    avr_set_feature(env, AVR_FEATURE_SRAM);
+    avr_set_feature(env, AVR_FEATURE_BREAK);
+
+    avr_set_feature(env, AVR_FEATURE_2_BYTE_PC);
+    avr_set_feature(env, AVR_FEATURE_2_BYTE_SP);
+    avr_set_feature(env, AVR_FEATURE_JMP_CALL);
+    avr_set_feature(env, AVR_FEATURE_LPMX);
+    avr_set_feature(env, AVR_FEATURE_MOVW);
+}
+
+/*
+ * Setting features of AVR core type avr4
+ * --------------------------------------
+ *
+ * This type of AVR core is present in the following AVR MCUs:
+ *
+ * ata6285, ata6286, ata6289, ata6612c, atmega8, atmega8a, atmega48, atmega48a,
+ * atmega48p, atmega48pa, atmega48pb, atmega88, atmega88a, atmega88p,
+ * atmega88pa, atmega88pb, atmega8515, atmega8535, atmega8hva, at90pwm1,
+ * at90pwm2, at90pwm2b, at90pwm3, at90pwm3b, at90pwm81
+ */
+static void avr_avr4_initfn(Object *obj)
+{
+    AVRCPU *cpu = AVR_CPU(obj);
+    CPUAVRState *env = &cpu->env;
+
+    avr_set_feature(env, AVR_FEATURE_LPM);
+    avr_set_feature(env, AVR_FEATURE_IJMP_ICALL);
+    avr_set_feature(env, AVR_FEATURE_ADIW_SBIW);
+    avr_set_feature(env, AVR_FEATURE_SRAM);
+    avr_set_feature(env, AVR_FEATURE_BREAK);
+
+    avr_set_feature(env, AVR_FEATURE_2_BYTE_PC);
+    avr_set_feature(env, AVR_FEATURE_2_BYTE_SP);
+    avr_set_feature(env, AVR_FEATURE_LPMX);
+    avr_set_feature(env, AVR_FEATURE_MOVW);
+    avr_set_feature(env, AVR_FEATURE_MUL);
+}
+
+/*
+ * Setting features of AVR core type avr5
+ * --------------------------------------
+ *
+ * This type of AVR core is present in the following AVR MCUs:
+ *
+ * ata5702m322, ata5782, ata5790, ata5790n, ata5791, ata5795, ata5831, ata6613c,
+ * ata6614q, ata8210, ata8510, atmega16, atmega16a, atmega161, atmega162,
+ * atmega163, atmega164a, atmega164p, atmega164pa, atmega165, atmega165a,
+ * atmega165p, atmega165pa, atmega168, atmega168a, atmega168p, atmega168pa,
+ * atmega168pb, atmega169, atmega169a, atmega169p, atmega169pa, atmega16hvb,
+ * atmega16hvbrevb, atmega16m1, atmega16u4, atmega32a, atmega32, atmega323,
+ * atmega324a, atmega324p, atmega324pa, atmega325, atmega325a, atmega325p,
+ * atmega325pa, atmega3250, atmega3250a, atmega3250p, atmega3250pa, atmega328,
+ * atmega328p, atmega328pb, atmega329, atmega329a, atmega329p, atmega329pa,
+ * atmega3290, atmega3290a, atmega3290p, atmega3290pa, atmega32c1, atmega32m1,
+ * atmega32u4, atmega32u6, atmega406, atmega64, atmega64a, atmega640, atmega644,
+ * atmega644a, atmega644p, atmega644pa, atmega645, atmega645a, atmega645p,
+ * atmega6450, atmega6450a, atmega6450p, atmega649, atmega649a, atmega649p,
+ * atmega6490, atmega16hva, atmega16hva2, atmega32hvb, atmega6490a, atmega6490p,
+ * atmega64c1, atmega64m1, atmega64hve, atmega64hve2, atmega64rfr2,
+ * atmega644rfr2, atmega32hvbrevb, at90can32, at90can64, at90pwm161, at90pwm216,
+ * at90pwm316, at90scr100, at90usb646, at90usb647, at94k, m3000
+ */
+static void avr_avr5_initfn(Object *obj)
+{
+    AVRCPU *cpu = AVR_CPU(obj);
+    CPUAVRState *env = &cpu->env;
+
+    avr_set_feature(env, AVR_FEATURE_LPM);
+    avr_set_feature(env, AVR_FEATURE_IJMP_ICALL);
+    avr_set_feature(env, AVR_FEATURE_ADIW_SBIW);
+    avr_set_feature(env, AVR_FEATURE_SRAM);
+    avr_set_feature(env, AVR_FEATURE_BREAK);
+
+    avr_set_feature(env, AVR_FEATURE_2_BYTE_PC);
+    avr_set_feature(env, AVR_FEATURE_2_BYTE_SP);
+    avr_set_feature(env, AVR_FEATURE_JMP_CALL);
+    avr_set_feature(env, AVR_FEATURE_LPMX);
+    avr_set_feature(env, AVR_FEATURE_MOVW);
+    avr_set_feature(env, AVR_FEATURE_MUL);
+}
+
+/*
+ * Setting features of AVR core type avr51
+ * --------------------------------------
+ *
+ * This type of AVR core is present in the following AVR MCUs:
+ *
+ * atmega128, atmega128a, atmega1280, atmega1281, atmega1284, atmega1284p,
+ * atmega128rfa1, atmega128rfr2, atmega1284rfr2, at90can128, at90usb1286,
+ * at90usb1287
+ */
+static void avr_avr51_initfn(Object *obj)
+{
+    AVRCPU *cpu = AVR_CPU(obj);
+    CPUAVRState *env = &cpu->env;
+
+    avr_set_feature(env, AVR_FEATURE_LPM);
+    avr_set_feature(env, AVR_FEATURE_IJMP_ICALL);
+    avr_set_feature(env, AVR_FEATURE_ADIW_SBIW);
+    avr_set_feature(env, AVR_FEATURE_SRAM);
+    avr_set_feature(env, AVR_FEATURE_BREAK);
+
+    avr_set_feature(env, AVR_FEATURE_2_BYTE_PC);
+    avr_set_feature(env, AVR_FEATURE_2_BYTE_SP);
+    avr_set_feature(env, AVR_FEATURE_RAMPZ);
+    avr_set_feature(env, AVR_FEATURE_ELPMX);
+    avr_set_feature(env, AVR_FEATURE_ELPM);
+    avr_set_feature(env, AVR_FEATURE_JMP_CALL);
+    avr_set_feature(env, AVR_FEATURE_LPMX);
+    avr_set_feature(env, AVR_FEATURE_MOVW);
+    avr_set_feature(env, AVR_FEATURE_MUL);
+}
+
+/*
+ * Setting features of AVR core type avr6
+ * --------------------------------------
+ *
+ * This type of AVR core is present in the following AVR MCUs:
+ *
+ * atmega2560, atmega2561, atmega256rfr2, atmega2564rfr2
+ */
+static void avr_avr6_initfn(Object *obj)
+{
+    AVRCPU *cpu = AVR_CPU(obj);
+    CPUAVRState *env = &cpu->env;
+
+    avr_set_feature(env, AVR_FEATURE_LPM);
+    avr_set_feature(env, AVR_FEATURE_IJMP_ICALL);
+    avr_set_feature(env, AVR_FEATURE_ADIW_SBIW);
+    avr_set_feature(env, AVR_FEATURE_SRAM);
+    avr_set_feature(env, AVR_FEATURE_BREAK);
+
+    avr_set_feature(env, AVR_FEATURE_3_BYTE_PC);
+    avr_set_feature(env, AVR_FEATURE_2_BYTE_SP);
+    avr_set_feature(env, AVR_FEATURE_RAMPZ);
+    avr_set_feature(env, AVR_FEATURE_EIJMP_EICALL);
+    avr_set_feature(env, AVR_FEATURE_ELPMX);
+    avr_set_feature(env, AVR_FEATURE_ELPM);
+    avr_set_feature(env, AVR_FEATURE_JMP_CALL);
+    avr_set_feature(env, AVR_FEATURE_LPMX);
+    avr_set_feature(env, AVR_FEATURE_MOVW);
+    avr_set_feature(env, AVR_FEATURE_MUL);
+}
+
+/*
+ * Setting features of AVR core type avrtiny
+ * --------------------------------------
+ *
+ * This type of AVR core is present in the following AVR MCUs:
+ *
+ * attiny4, attiny5, attiny9, attiny10, attiny20, attiny40
+ */
+static void avr_avrtiny_initfn(Object *obj)
+{
+    AVRCPU *cpu = AVR_CPU(obj);
+    CPUAVRState *env = &cpu->env;
+
+    avr_set_feature(env, AVR_FEATURE_LPM);
+    avr_set_feature(env, AVR_FEATURE_IJMP_ICALL);
+    avr_set_feature(env, AVR_FEATURE_BREAK);
+
+    avr_set_feature(env, AVR_FEATURE_2_BYTE_PC);
+    avr_set_feature(env, AVR_FEATURE_1_BYTE_SP);
+}
+
+/*
+ * Setting features of AVR core type xmega2
+ * --------------------------------------
+ *
+ * This type of AVR core is present in the following AVR MCUs:
+ *
+ * atxmega8e5, atxmega16a4, atxmega16d4, atxmega16e5, atxmega32a4, atxmega32c3,
+ * atxmega32d3, atxmega32d4, atxmega16a4u, atxmega16c4, atxmega32a4u,
+ * atxmega32c4, atxmega32e5
+ */
+static void avr_xmega2_initfn(Object *obj)
+{
+    AVRCPU *cpu = AVR_CPU(obj);
+    CPUAVRState *env = &cpu->env;
+
+    avr_set_feature(env, AVR_FEATURE_LPM);
+    avr_set_feature(env, AVR_FEATURE_IJMP_ICALL);
+    avr_set_feature(env, AVR_FEATURE_ADIW_SBIW);
+    avr_set_feature(env, AVR_FEATURE_SRAM);
+    avr_set_feature(env, AVR_FEATURE_BREAK);
+
+    avr_set_feature(env, AVR_FEATURE_2_BYTE_PC);
+    avr_set_feature(env, AVR_FEATURE_2_BYTE_SP);
+    avr_set_feature(env, AVR_FEATURE_JMP_CALL);
+    avr_set_feature(env, AVR_FEATURE_LPMX);
+    avr_set_feature(env, AVR_FEATURE_MOVW);
+    avr_set_feature(env, AVR_FEATURE_MUL);
+    avr_set_feature(env, AVR_FEATURE_RMW);
+}
+
+/*
+ * Setting features of AVR core type xmega3
+ * --------------------------------------
+ *
+ * This type of AVR core is present in the following AVR MCUs:
+ *
+ * attiny212, attiny214, attiny412, attiny414, attiny416, attiny417, attiny814,
+ * attiny816, attiny817, attiny1614, attiny1616, attiny1617, attiny3214,
+ * attiny3216, attiny3217, atmega808, atmega809, atmega1608, atmega1609,
+ * atmega3208, atmega3209, atmega4808, atmega4809
+ */
+static void avr_xmega3_initfn(Object *obj)
+{
+    AVRCPU *cpu = AVR_CPU(obj);
+    CPUAVRState *env = &cpu->env;
+
+    avr_set_feature(env, AVR_FEATURE_LPM);
+    avr_set_feature(env, AVR_FEATURE_IJMP_ICALL);
+    avr_set_feature(env, AVR_FEATURE_ADIW_SBIW);
+    avr_set_feature(env, AVR_FEATURE_SRAM);
+    avr_set_feature(env, AVR_FEATURE_BREAK);
+
+    avr_set_feature(env, AVR_FEATURE_2_BYTE_PC);
+    avr_set_feature(env, AVR_FEATURE_2_BYTE_SP);
+    avr_set_feature(env, AVR_FEATURE_JMP_CALL);
+    avr_set_feature(env, AVR_FEATURE_LPMX);
+    avr_set_feature(env, AVR_FEATURE_MOVW);
+    avr_set_feature(env, AVR_FEATURE_MUL);
+    avr_set_feature(env, AVR_FEATURE_RMW);
+}
+
+/*
+ * Setting features of AVR core type xmega4
+ * --------------------------------------
+ *
+ * This type of AVR core is present in the following AVR MCUs:
+ *
+ * atxmega64a3, atxmega64d3, atxmega64a3u, atxmega64a4u, atxmega64b1,
+ * atxmega64b3, atxmega64c3, atxmega64d4
+ */
+static void avr_xmega4_initfn(Object *obj)
+{
+    AVRCPU *cpu = AVR_CPU(obj);
+    CPUAVRState *env = &cpu->env;
+
+    avr_set_feature(env, AVR_FEATURE_LPM);
+    avr_set_feature(env, AVR_FEATURE_IJMP_ICALL);
+    avr_set_feature(env, AVR_FEATURE_ADIW_SBIW);
+    avr_set_feature(env, AVR_FEATURE_SRAM);
+    avr_set_feature(env, AVR_FEATURE_BREAK);
+
+    avr_set_feature(env, AVR_FEATURE_2_BYTE_PC);
+    avr_set_feature(env, AVR_FEATURE_2_BYTE_SP);
+    avr_set_feature(env, AVR_FEATURE_ELPMX);
+    avr_set_feature(env, AVR_FEATURE_ELPM);
+    avr_set_feature(env, AVR_FEATURE_JMP_CALL);
+    avr_set_feature(env, AVR_FEATURE_LPMX);
+    avr_set_feature(env, AVR_FEATURE_MOVW);
+    avr_set_feature(env, AVR_FEATURE_MUL);
+    avr_set_feature(env, AVR_FEATURE_RMW);
+}
+
+/*
+ * Setting features of AVR core type xmega5
+ * --------------------------------------
+ *
+ * This type of AVR core is present in the following AVR MCUs:
+ *
+ * atxmega64a1, atxmega64a1u
+ */
+static void avr_xmega5_initfn(Object *obj)
+{
+    AVRCPU *cpu = AVR_CPU(obj);
+    CPUAVRState *env = &cpu->env;
+
+    avr_set_feature(env, AVR_FEATURE_LPM);
+    avr_set_feature(env, AVR_FEATURE_IJMP_ICALL);
+    avr_set_feature(env, AVR_FEATURE_ADIW_SBIW);
+    avr_set_feature(env, AVR_FEATURE_SRAM);
+    avr_set_feature(env, AVR_FEATURE_BREAK);
+
+    avr_set_feature(env, AVR_FEATURE_2_BYTE_PC);
+    avr_set_feature(env, AVR_FEATURE_2_BYTE_SP);
+    avr_set_feature(env, AVR_FEATURE_RAMPD);
+    avr_set_feature(env, AVR_FEATURE_RAMPX);
+    avr_set_feature(env, AVR_FEATURE_RAMPY);
+    avr_set_feature(env, AVR_FEATURE_RAMPZ);
+    avr_set_feature(env, AVR_FEATURE_ELPMX);
+    avr_set_feature(env, AVR_FEATURE_ELPM);
+    avr_set_feature(env, AVR_FEATURE_JMP_CALL);
+    avr_set_feature(env, AVR_FEATURE_LPMX);
+    avr_set_feature(env, AVR_FEATURE_MOVW);
+    avr_set_feature(env, AVR_FEATURE_MUL);
+    avr_set_feature(env, AVR_FEATURE_RMW);
+}
+
+/*
+ * Setting features of AVR core type xmega6
+ * --------------------------------------
+ *
+ * This type of AVR core is present in the following AVR MCUs:
+ *
+ * atxmega128a3, atxmega128d3, atxmega192a3, atxmega192d3, atxmega256a3,
+ * atxmega256a3b, atxmega256a3bu, atxmega256d3, atxmega128a3u, atxmega128b1,
+ * atxmega128b3, atxmega128c3, atxmega128d4, atxmega192a3u, atxmega192c3,
+ * atxmega256a3u, atxmega256c3, atxmega384c3, atxmega384d3
+ */
+static void avr_xmega6_initfn(Object *obj)
+{
+    AVRCPU *cpu = AVR_CPU(obj);
+    CPUAVRState *env = &cpu->env;
+
+    avr_set_feature(env, AVR_FEATURE_LPM);
+    avr_set_feature(env, AVR_FEATURE_IJMP_ICALL);
+    avr_set_feature(env, AVR_FEATURE_ADIW_SBIW);
+    avr_set_feature(env, AVR_FEATURE_SRAM);
+    avr_set_feature(env, AVR_FEATURE_BREAK);
+
+    avr_set_feature(env, AVR_FEATURE_3_BYTE_PC);
+    avr_set_feature(env, AVR_FEATURE_2_BYTE_SP);
+    avr_set_feature(env, AVR_FEATURE_RAMPZ);
+    avr_set_feature(env, AVR_FEATURE_EIJMP_EICALL);
+    avr_set_feature(env, AVR_FEATURE_ELPMX);
+    avr_set_feature(env, AVR_FEATURE_ELPM);
+    avr_set_feature(env, AVR_FEATURE_JMP_CALL);
+    avr_set_feature(env, AVR_FEATURE_LPMX);
+    avr_set_feature(env, AVR_FEATURE_MOVW);
+    avr_set_feature(env, AVR_FEATURE_MUL);
+    avr_set_feature(env, AVR_FEATURE_RMW);
+}
+
+/*
+ * Setting features of AVR core type xmega7
+ * --------------------------------------
+ *
+ * This type of AVR core is present in the following AVR MCUs:
+ *
+ * atxmega128a1, atxmega128a1u, atxmega128a4u
+ */
+static void avr_xmega7_initfn(Object *obj)
+{
+    AVRCPU *cpu = AVR_CPU(obj);
+    CPUAVRState *env = &cpu->env;
+
+    avr_set_feature(env, AVR_FEATURE_LPM);
+    avr_set_feature(env, AVR_FEATURE_IJMP_ICALL);
+    avr_set_feature(env, AVR_FEATURE_ADIW_SBIW);
+    avr_set_feature(env, AVR_FEATURE_SRAM);
+    avr_set_feature(env, AVR_FEATURE_BREAK);
+
+    avr_set_feature(env, AVR_FEATURE_3_BYTE_PC);
+    avr_set_feature(env, AVR_FEATURE_2_BYTE_SP);
+    avr_set_feature(env, AVR_FEATURE_RAMPD);
+    avr_set_feature(env, AVR_FEATURE_RAMPX);
+    avr_set_feature(env, AVR_FEATURE_RAMPY);
+    avr_set_feature(env, AVR_FEATURE_RAMPZ);
+    avr_set_feature(env, AVR_FEATURE_EIJMP_EICALL);
+    avr_set_feature(env, AVR_FEATURE_ELPMX);
+    avr_set_feature(env, AVR_FEATURE_ELPM);
+    avr_set_feature(env, AVR_FEATURE_JMP_CALL);
+    avr_set_feature(env, AVR_FEATURE_LPMX);
+    avr_set_feature(env, AVR_FEATURE_MOVW);
+    avr_set_feature(env, AVR_FEATURE_MUL);
+    avr_set_feature(env, AVR_FEATURE_RMW);
+}
+
+typedef struct AVRCPUInfo {
+    const char *name;
+    void (*initfn)(Object *obj);
+} AVRCPUInfo;
+
+
+static void avr_cpu_list_entry(gpointer data, gpointer user_data)
+{
+    const char *typename = object_class_get_name(OBJECT_CLASS(data));
+
+    qemu_printf("%s\n", typename);
+}
+
+void avr_cpu_list(void)
+{
+    GSList *list;
+    list = object_class_get_list_sorted(TYPE_AVR_CPU, false);
+    g_slist_foreach(list, avr_cpu_list_entry, NULL);
+    g_slist_free(list);
+}
+
+#define DEFINE_AVR_CPU_TYPE(model, initfn) \
+    { \
+        .parent = TYPE_AVR_CPU, \
+        .instance_init = initfn, \
+        .name = AVR_CPU_TYPE_NAME(model), \
+    }
+
+static const TypeInfo avr_cpu_type_info[] = {
+    {
+        .name = TYPE_AVR_CPU,
+        .parent = TYPE_CPU,
+        .instance_size = sizeof(AVRCPU),
+        .instance_init = avr_cpu_initfn,
+        .class_size = sizeof(AVRCPUClass),
+        .class_init = avr_cpu_class_init,
+        .abstract = true,
+    },
+    DEFINE_AVR_CPU_TYPE("avrtiny", avr_avrtiny_initfn),
+    DEFINE_AVR_CPU_TYPE("avr1", avr_avr1_initfn),
+    DEFINE_AVR_CPU_TYPE("avr2", avr_avr2_initfn),
+    DEFINE_AVR_CPU_TYPE("avr25", avr_avr25_initfn),
+    DEFINE_AVR_CPU_TYPE("avr3", avr_avr3_initfn),
+    DEFINE_AVR_CPU_TYPE("avr31", avr_avr31_initfn),
+    DEFINE_AVR_CPU_TYPE("avr35", avr_avr35_initfn),
+    DEFINE_AVR_CPU_TYPE("avr4", avr_avr4_initfn),
+    DEFINE_AVR_CPU_TYPE("avr5", avr_avr5_initfn),
+    DEFINE_AVR_CPU_TYPE("avr51", avr_avr51_initfn),
+    DEFINE_AVR_CPU_TYPE("avr6", avr_avr6_initfn),
+    DEFINE_AVR_CPU_TYPE("xmega2", avr_xmega2_initfn),
+    DEFINE_AVR_CPU_TYPE("xmega3", avr_xmega3_initfn),
+    DEFINE_AVR_CPU_TYPE("xmega4", avr_xmega4_initfn),
+    DEFINE_AVR_CPU_TYPE("xmega5", avr_xmega5_initfn),
+    DEFINE_AVR_CPU_TYPE("xmega6", avr_xmega6_initfn),
+    DEFINE_AVR_CPU_TYPE("xmega7", avr_xmega7_initfn),
+};
+
+const char *avr_flags_to_cpu_type(uint32_t flags, const char *def_cpu_type)
+{
+    switch (flags & EF_AVR_MACH) {
+    case bfd_mach_avr1:
+        return AVR_CPU_TYPE_NAME("avr1");
+    case bfd_mach_avr2:
+        return AVR_CPU_TYPE_NAME("avr2");
+    case bfd_mach_avr25:
+        return AVR_CPU_TYPE_NAME("avr25");
+    case bfd_mach_avr3:
+        return AVR_CPU_TYPE_NAME("avr3");
+    case bfd_mach_avr31:
+        return AVR_CPU_TYPE_NAME("avr31");
+    case bfd_mach_avr35:
+        return AVR_CPU_TYPE_NAME("avr35");
+    case bfd_mach_avr4:
+        return AVR_CPU_TYPE_NAME("avr4");
+    case bfd_mach_avr5:
+        return AVR_CPU_TYPE_NAME("avr5");
+    case bfd_mach_avr51:
+        return AVR_CPU_TYPE_NAME("avr51");
+    case bfd_mach_avr6:
+        return AVR_CPU_TYPE_NAME("avr6");
+    case bfd_mach_avrtiny:
+        return AVR_CPU_TYPE_NAME("avrtiny");
+    case bfd_mach_avrxmega2:
+        return AVR_CPU_TYPE_NAME("xmega2");
+    case bfd_mach_avrxmega3:
+        return AVR_CPU_TYPE_NAME("xmega3");
+    case bfd_mach_avrxmega4:
+        return AVR_CPU_TYPE_NAME("xmega4");
+    case bfd_mach_avrxmega5:
+        return AVR_CPU_TYPE_NAME("xmega5");
+    case bfd_mach_avrxmega6:
+        return AVR_CPU_TYPE_NAME("xmega6");
+    case bfd_mach_avrxmega7:
+        return AVR_CPU_TYPE_NAME("xmega7");
+    default:
+        return def_cpu_type;
+    }
+}
+
+DEFINE_TYPES(avr_cpu_type_info)
diff --git a/target/avr/gdbstub.c b/target/avr/gdbstub.c
new file mode 100644
index 0000000000..733184c08f
--- /dev/null
+++ b/target/avr/gdbstub.c
@@ -0,0 +1,84 @@
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
+#include "qemu/osdep.h"
+#include "exec/gdbstub.h"
+
+int avr_cpu_gdb_read_register(CPUState *cs, uint8_t *mem_buf, int n)
+{
+    AVRCPU *cpu = AVR_CPU(cs);
+    CPUAVRState *env = &cpu->env;
+
+    /*  R */
+    if (n < 32) {
+        return gdb_get_reg8(mem_buf, env->r[n]);
+    }
+
+    /*  SREG */
+    if (n == 32) {
+        uint8_t sreg = cpu_get_sreg(env);
+
+        return gdb_get_reg8(mem_buf, sreg);
+    }
+
+    /*  SP */
+    if (n == 33) {
+        return gdb_get_reg16(mem_buf, env->sp & 0x0000ffff);
+    }
+
+    /*  PC */
+    if (n == 34) {
+        return gdb_get_reg32(mem_buf, env->pc_w * 2);
+    }
+
+    return 0;
+}
+
+int avr_cpu_gdb_write_register(CPUState *cs, uint8_t *mem_buf, int n)
+{
+    AVRCPU *cpu = AVR_CPU(cs);
+    CPUAVRState *env = &cpu->env;
+
+    /*  R */
+    if (n < 32) {
+        env->r[n] = *mem_buf;
+        return 1;
+    }
+
+    /*  SREG */
+    if (n == 32) {
+        cpu_set_sreg(env, *mem_buf);
+        return 1;
+    }
+
+    /*  SP */
+    if (n == 33) {
+        env->sp = lduw_p(mem_buf);
+        return 2;
+    }
+
+    /*  PC */
+    if (n == 34) {
+        env->pc_w = ldl_p(mem_buf) / 2;
+        return 4;
+    }
+
+    return 0;
+}
diff --git a/target/avr/machine.c b/target/avr/machine.c
new file mode 100644
index 0000000000..ba44bd042b
--- /dev/null
+++ b/target/avr/machine.c
@@ -0,0 +1,121 @@
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
+#include "qemu/osdep.h"
+#include "cpu.h"
+#include "migration/cpu.h"
+
+static int get_sreg(QEMUFile *f, void *opaque, size_t size,
+    const VMStateField *field)
+{
+    CPUAVRState *env = opaque;
+    uint8_t sreg;
+
+    sreg = qemu_get_byte(f);
+    cpu_set_sreg(env, sreg);
+    return 0;
+}
+
+static int put_sreg(
+    QEMUFile *f, void *opaque, size_t size,
+    const VMStateField *field, QJSON *vmdesc)
+{
+    CPUAVRState *env = opaque;
+    uint8_t sreg = cpu_get_sreg(env);
+
+    qemu_put_byte(f, sreg);
+    return 0;
+}
+
+static const VMStateInfo vms_sreg = {
+    .name = "sreg",
+    .get = get_sreg,
+    .put = put_sreg,
+};
+
+static int get_segment(
+    QEMUFile *f, void *opaque, size_t size, const VMStateField *field)
+{
+    uint32_t *ramp = opaque;
+    uint8_t temp;
+
+    temp = qemu_get_byte(f);
+    *ramp = ((uint32_t)temp) << 16;
+    return 0;
+}
+
+static int put_segment(
+    QEMUFile *f, void *opaque, size_t size,
+    const VMStateField *field, QJSON *vmdesc)
+{
+    uint32_t *ramp = opaque;
+    uint8_t temp = *ramp >> 16;
+
+    qemu_put_byte(f, temp);
+    return 0;
+}
+
+static const VMStateInfo vms_rampD = {
+    .name = "rampD",
+    .get = get_segment,
+    .put = put_segment,
+};
+static const VMStateInfo vms_rampX = {
+    .name = "rampX",
+    .get = get_segment,
+    .put = put_segment,
+};
+static const VMStateInfo vms_rampY = {
+    .name = "rampY",
+    .get = get_segment,
+    .put = put_segment,
+};
+static const VMStateInfo vms_rampZ = {
+    .name = "rampZ",
+    .get = get_segment,
+    .put = put_segment,
+};
+static const VMStateInfo vms_eind = {
+    .name = "eind",
+    .get = get_segment,
+    .put = put_segment,
+};
+
+const VMStateDescription vms_avr_cpu = {
+    .name = "cpu",
+    .version_id = 0,
+    .minimum_version_id = 0,
+    .fields = (VMStateField[]) {
+        VMSTATE_UINT32(env.pc_w, AVRCPU),
+        VMSTATE_UINT32(env.sp, AVRCPU),
+        VMSTATE_UINT32(env.skip, AVRCPU),
+
+        VMSTATE_UINT32_ARRAY(env.r, AVRCPU, NUMBER_OF_CPU_REGISTERS),
+
+        VMSTATE_SINGLE(env, AVRCPU, 0, vms_sreg, CPUAVRState),
+        VMSTATE_SINGLE(env.rampD, AVRCPU, 0, vms_rampD, uint32_t),
+        VMSTATE_SINGLE(env.rampX, AVRCPU, 0, vms_rampX, uint32_t),
+        VMSTATE_SINGLE(env.rampY, AVRCPU, 0, vms_rampY, uint32_t),
+        VMSTATE_SINGLE(env.rampZ, AVRCPU, 0, vms_rampZ, uint32_t),
+        VMSTATE_SINGLE(env.eind, AVRCPU, 0, vms_eind, uint32_t),
+
+        VMSTATE_END_OF_LIST()
+    }
+};
diff --git a/gdb-xml/avr-cpu.xml b/gdb-xml/avr-cpu.xml
new file mode 100644
index 0000000000..c4747f5b40
--- /dev/null
+++ b/gdb-xml/avr-cpu.xml
@@ -0,0 +1,49 @@
+<?xml version="1.0"?>
+<!-- Copyright (C) 2018-2019 Free Software Foundation, Inc.
+
+     Copying and distribution of this file, with or without modification,
+     are permitted in any medium without royalty provided the copyright
+     notice and this notice are preserved.  -->
+
+<!-- Register numbers are hard-coded in order to maintain backward
+     compatibility with older versions of tools that didn't use xml
+     register descriptions.  -->
+
+<!DOCTYPE feature SYSTEM "gdb-target.dtd">
+<feature name="org.gnu.gdb.riscv.cpu">
+  <reg name="r0" bitsize="8" type="int" regnum="0"/>
+  <reg name="r1" bitsize="8" type="int"/>
+  <reg name="r2" bitsize="8" type="int"/>
+  <reg name="r3" bitsize="8" type="int"/>
+  <reg name="r4" bitsize="8" type="int"/>
+  <reg name="r5" bitsize="8" type="int"/>
+  <reg name="r6" bitsize="8" type="int"/>
+  <reg name="r7" bitsize="8" type="int"/>
+  <reg name="r8" bitsize="8" type="int"/>
+  <reg name="r9" bitsize="8" type="int"/>
+  <reg name="r10" bitsize="8" type="int"/>
+  <reg name="r11" bitsize="8" type="int"/>
+  <reg name="r12" bitsize="8" type="int"/>
+  <reg name="r13" bitsize="8" type="int"/>
+  <reg name="r14" bitsize="8" type="int"/>
+  <reg name="r15" bitsize="8" type="int"/>
+  <reg name="r16" bitsize="8" type="int"/>
+  <reg name="r17" bitsize="8" type="int"/>
+  <reg name="r18" bitsize="8" type="int"/>
+  <reg name="r19" bitsize="8" type="int"/>
+  <reg name="r20" bitsize="8" type="int"/>
+  <reg name="r21" bitsize="8" type="int"/>
+  <reg name="r22" bitsize="8" type="int"/>
+  <reg name="r23" bitsize="8" type="int"/>
+  <reg name="r24" bitsize="8" type="int"/>
+  <reg name="r25" bitsize="8" type="int"/>
+  <reg name="r26" bitsize="8" type="int"/>
+  <reg name="r27" bitsize="8" type="int"/>
+  <reg name="r28" bitsize="8" type="int"/>
+  <reg name="r29" bitsize="8" type="int"/>
+  <reg name="r30" bitsize="8" type="int"/>
+  <reg name="r31" bitsize="8" type="int"/>
+  <reg name="sreg" bitsize="8" type="int"/>
+  <reg name="sp" bitsize="8" type="int"/>
+  <reg name="pc" bitsize="8" type="int"/>
+</feature>
-- 
2.20.1


