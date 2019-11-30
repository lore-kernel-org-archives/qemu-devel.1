Return-Path: <SRS0=cUpU=ZW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58AC8C432C0
	for <qemu-devel@archiver.kernel.org>; Sat, 30 Nov 2019 08:53:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 00A5B20833
	for <qemu-devel@archiver.kernel.org>; Sat, 30 Nov 2019 08:53:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pVZynDbC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 00A5B20833
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38658 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iayVA-0001fW-RS
	for qemu-devel@archiver.kernel.org; Sat, 30 Nov 2019 03:53:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57833)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iayOW-00035g-PU
 for qemu-devel@nongnu.org; Sat, 30 Nov 2019 03:46:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iayOR-0003Ne-BN
 for qemu-devel@nongnu.org; Sat, 30 Nov 2019 03:46:24 -0500
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:37180)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iayOP-0003L2-Hg
 for qemu-devel@nongnu.org; Sat, 30 Nov 2019 03:46:18 -0500
Received: by mail-wr1-x442.google.com with SMTP id w15so6827996wru.4
 for <qemu-devel@nongnu.org>; Sat, 30 Nov 2019 00:46:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=sU+W8T99bPTDZ6kdZL1rsH6pYgyW8q+bwz+yNxHOl+w=;
 b=pVZynDbCmPRtlp9H/ch2n/qC7vZe7UYOfgGPZsh1U7p7nwQKEqoArKWa6Aj+Mp49ya
 IPvdNnJn5RXMb1msfY7MH9mF2SiDRf9/BbWUgarwRilDwrbhDH6vhtHZXBnrG2L5EGi4
 Qbib8jok8/+s5S8B1PgsFVFb44HgpU9kjvwBZY1rZXavIoS45W0bKYSBMx7yGeFTbv6+
 9WHG4+oh9BfvVu/XTFXivaQNEAhUD1uQcEYb0scIt3cRtwTn8HyIz/WjO6eucOzjoDqF
 DGz2+8FEPz3EEJUAOV5o66thwzgMngtHxcYpyb2ArDOveIB0MtYLmq6VAEYy+k8o5T+n
 D2rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=sU+W8T99bPTDZ6kdZL1rsH6pYgyW8q+bwz+yNxHOl+w=;
 b=ODI5qeoPcixC2GkeK9b6OvdATvjlJ3ksQ0qSYl9Dh1tscuLl45gDLZIJaTk8WnCmV7
 v/VyckhHutdSL8TePKrVgTwR4FtZkYqEr+kKsSYCIivgO6Zq4TA/9A1mR4w63B5f+YU5
 Xm3XttJ4qLRaLgE9VxOWfnlSnS3UvXxjv1qJlDs1LdjR2WT26GQ08/JgfNrXkM4PPZ9G
 K8vP4ZuPcA078DqXnQuX4nNQdNRfoMDMn2SdlbEpRnicWiOWN2/guyMNqodAXpQQK26r
 8FmyqYMJx/uNW7agl4I5mZVLyqgjm8GvGJnNbXUfW4x/WhXjLdFY87wqgP20AgoSlc9H
 eUAg==
X-Gm-Message-State: APjAAAWd3r+7Z7VGKlhOjn51B5c+cwDyxnEUKhBO+PUFjdvi3i2p/D4h
 xNUCTEDaWRvBkb4qQokeO3soBA==
X-Google-Smtp-Source: APXvYqwcst7Tm8wgZJdp1MoBPu0vomDKqocOj2hupI62DkkcApFy8ujs5qUwuIY7mKn5XSoHt0VcEQ==
X-Received: by 2002:adf:e2c1:: with SMTP id d1mr47331366wrj.130.1575103575512; 
 Sat, 30 Nov 2019 00:46:15 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id u69sm17312617wmu.39.2019.11.30.00.46.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 30 Nov 2019 00:46:13 -0800 (PST)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 08CB51FF87;
 Sat, 30 Nov 2019 08:46:05 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 08/14] gdbstub: extend GByteArray to read register helpers
Date: Sat, 30 Nov 2019 08:45:56 +0000
Message-Id: <20191130084602.10818-9-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191130084602.10818-1-alex.bennee@linaro.org>
References: <20191130084602.10818-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::442
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Cornelia Huck <cohuck@redhat.com>,
 luis.machado@linaro.org, Sagar Karandikar <sagark@eecs.berkeley.edu>,
 David Hildenbrand <david@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Max Filippov <jcmvbkbc@gmail.com>, Alistair Francis <Alistair.Francis@wdc.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, Marek Vasut <marex@denx.de>,
 alan.hayward@arm.com, "open list:PowerPC TCG CPUs" <qemu-ppc@nongnu.org>,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 Richard Henderson <rth@twiddle.net>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Artyom Tarasenko <atar4qemu@gmail.com>, Eduardo Habkost <ehabkost@redhat.com>,
 richard.henderson@linaro.org,
 "open list:S390 TCG CPUs" <qemu-s390x@nongnu.org>,
 "open list:ARM TCG CPUs" <qemu-arm@nongnu.org>,
 Stafford Horne <shorne@gmail.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 David Gibson <david@gibson.dropbear.id.au>, damien.hedde@greensocs.com,
 "open list:RISC-V TCG CPUs" <qemu-riscv@nongnu.org>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Chris Wulff <crwulff@gmail.com>, Laurent Vivier <laurent@vivier.eu>,
 Michael Walle <michael@walle.cc>, Palmer Dabbelt <palmer@dabbelt.com>,
 Aleksandar Markovic <amarkovic@wavecomp.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Instead of passing a pointer to memory now just extend the GByteArray
to all the read register helpers. They can then safely append their
data through the normal way. We don't bother with this abstraction for
write registers as we have already ensured the buffer being copied
from is the correct size.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 include/exec/gdbstub.h          | 46 +++++++++++++++++-----------
 include/hw/core/cpu.h           |  2 +-
 target/alpha/cpu.h              |  2 +-
 target/arm/cpu.h                |  4 +--
 target/cris/cpu.h               |  4 +--
 target/hppa/cpu.h               |  2 +-
 target/i386/cpu.h               |  2 +-
 target/lm32/cpu.h               |  2 +-
 target/m68k/cpu.h               |  2 +-
 target/microblaze/cpu.h         |  2 +-
 target/mips/internal.h          |  2 +-
 target/openrisc/cpu.h           |  2 +-
 target/ppc/cpu.h                |  4 +--
 target/riscv/cpu.h              |  2 +-
 target/s390x/internal.h         |  2 +-
 target/sh4/cpu.h                |  2 +-
 target/sparc/cpu.h              |  2 +-
 target/xtensa/cpu.h             |  2 +-
 gdbstub.c                       | 20 ++++++------
 hw/core/cpu.c                   |  2 +-
 target/alpha/gdbstub.c          |  2 +-
 target/arm/gdbstub.c            |  2 +-
 target/arm/gdbstub64.c          |  2 +-
 target/arm/helper.c             | 19 +++++-------
 target/cris/gdbstub.c           |  4 +--
 target/hppa/gdbstub.c           |  2 +-
 target/i386/gdbstub.c           |  2 +-
 target/lm32/gdbstub.c           |  2 +-
 target/m68k/gdbstub.c           |  2 +-
 target/m68k/helper.c            |  4 +--
 target/microblaze/gdbstub.c     |  2 +-
 target/mips/gdbstub.c           |  2 +-
 target/nios2/cpu.c              |  2 +-
 target/openrisc/gdbstub.c       |  2 +-
 target/ppc/gdbstub.c            | 48 +++++++++++++++--------------
 target/ppc/translate_init.inc.c | 54 ++++++++++++++++++---------------
 target/riscv/gdbstub.c          | 18 +++++------
 target/s390x/gdbstub.c          | 30 +++++++++---------
 target/sh4/gdbstub.c            |  2 +-
 target/sparc/gdbstub.c          |  2 +-
 target/xtensa/gdbstub.c         |  2 +-
 41 files changed, 165 insertions(+), 148 deletions(-)

diff --git a/include/exec/gdbstub.h b/include/exec/gdbstub.h
index 59e366ba3af..ef79e32708c 100644
--- a/include/exec/gdbstub.h
+++ b/include/exec/gdbstub.h
@@ -68,49 +68,59 @@ void gdb_signalled(CPUArchState *, int);
 void gdbserver_fork(CPUState *);
 #endif
 /* Get or set a register.  Returns the size of the register.  */
-typedef int (*gdb_reg_cb)(CPUArchState *env, uint8_t *buf, int reg);
+typedef int (*gdb_get_reg_cb)(CPUArchState *env, GByteArray *buf, int reg);
+typedef int (*gdb_set_reg_cb)(CPUArchState *env, uint8_t *buf, int reg);
 void gdb_register_coprocessor(CPUState *cpu,
-                              gdb_reg_cb get_reg, gdb_reg_cb set_reg,
+                              gdb_get_reg_cb get_reg, gdb_set_reg_cb set_reg,
                               int num_regs, const char *xml, int g_pos);
 
-/* The GDB remote protocol transfers values in target byte order.  This means
- * we can use the raw memory access routines to access the value buffer.
- * Conveniently, these also handle the case where the buffer is mis-aligned.
+/*
+ * The GDB remote protocol transfers values in target byte order. As
+ * the gdbstub may be batching up several register values we always
+ * append to the array.
  */
 
-static inline int gdb_get_reg8(uint8_t *mem_buf, uint8_t val)
+static inline int gdb_get_reg8(GByteArray *buf, uint8_t val)
 {
-    stb_p(mem_buf, val);
+    g_byte_array_append(buf, &val, 1);
     return 1;
 }
 
-static inline int gdb_get_reg16(uint8_t *mem_buf, uint16_t val)
+static inline int gdb_get_reg16(GByteArray *buf, uint16_t val)
 {
-    stw_p(mem_buf, val);
+    uint16_t to_word = tswap16(val);
+    g_byte_array_append(buf, (uint8_t *) &to_word, 2);
     return 2;
 }
 
-static inline int gdb_get_reg32(uint8_t *mem_buf, uint32_t val)
+static inline int gdb_get_reg32(GByteArray *buf, uint32_t val)
 {
-    stl_p(mem_buf, val);
+    uint32_t to_long = tswap32(val);
+    g_byte_array_append(buf, (uint8_t *) &to_long, 4);
     return 4;
 }
 
-static inline int gdb_get_reg64(uint8_t *mem_buf, uint64_t val)
+static inline int gdb_get_reg64(GByteArray *buf, uint64_t val)
 {
-    stq_p(mem_buf, val);
+    uint64_t to_quad = tswap64(val);
+    g_byte_array_append(buf, (uint8_t *) &to_quad, 8);
     return 8;
 }
 
-static inline int gdb_get_reg128(uint8_t *mem_buf, uint64_t val_hi,
+static inline int gdb_get_reg128(GByteArray *buf, uint64_t val_hi,
                                  uint64_t val_lo)
 {
+    uint64_t to_quad;
 #ifdef TARGET_WORDS_BIGENDIAN
-    stq_p(mem_buf, val_hi);
-    stq_p(mem_buf + 8, val_lo);
+    to_quad = tswap64(val_hi);
+    g_byte_array_append(buf, (uint8_t *) &to_quad, 8);
+    to_quad = tswap64(val_lo);
+    g_byte_array_append(buf, (uint8_t *) &to_quad, 8);
 #else
-    stq_p(mem_buf, val_lo);
-    stq_p(mem_buf + 8, val_hi);
+    to_quad = tswap64(val_lo);
+    g_byte_array_append(buf, (uint8_t *) &to_quad, 8);
+    to_quad = tswap64(val_hi);
+    g_byte_array_append(buf, (uint8_t *) &to_quad, 8);
 #endif
     return 16;
 }
diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
index 77c6f052990..e85ec519add 100644
--- a/include/hw/core/cpu.h
+++ b/include/hw/core/cpu.h
@@ -195,7 +195,7 @@ typedef struct CPUClass {
     hwaddr (*get_phys_page_attrs_debug)(CPUState *cpu, vaddr addr,
                                         MemTxAttrs *attrs);
     int (*asidx_from_attrs)(CPUState *cpu, MemTxAttrs attrs);
-    int (*gdb_read_register)(CPUState *cpu, uint8_t *buf, int reg);
+    int (*gdb_read_register)(CPUState *cpu, GByteArray *buf, int reg);
     int (*gdb_write_register)(CPUState *cpu, uint8_t *buf, int reg);
     bool (*debug_check_watchpoint)(CPUState *cpu, CPUWatchpoint *wp);
     void (*debug_excp_handler)(CPUState *cpu);
diff --git a/target/alpha/cpu.h b/target/alpha/cpu.h
index a530249a5bf..faa09768424 100644
--- a/target/alpha/cpu.h
+++ b/target/alpha/cpu.h
@@ -282,7 +282,7 @@ void alpha_cpu_do_interrupt(CPUState *cpu);
 bool alpha_cpu_exec_interrupt(CPUState *cpu, int int_req);
 void alpha_cpu_dump_state(CPUState *cs, FILE *f, int flags);
 hwaddr alpha_cpu_get_phys_page_debug(CPUState *cpu, vaddr addr);
-int alpha_cpu_gdb_read_register(CPUState *cpu, uint8_t *buf, int reg);
+int alpha_cpu_gdb_read_register(CPUState *cpu, GByteArray *buf, int reg);
 int alpha_cpu_gdb_write_register(CPUState *cpu, uint8_t *buf, int reg);
 void alpha_cpu_do_unaligned_access(CPUState *cpu, vaddr addr,
                                    MMUAccessType access_type,
diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 83a809d4bac..cf16f915c82 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -949,7 +949,7 @@ bool arm_cpu_exec_interrupt(CPUState *cpu, int int_req);
 hwaddr arm_cpu_get_phys_page_attrs_debug(CPUState *cpu, vaddr addr,
                                          MemTxAttrs *attrs);
 
-int arm_cpu_gdb_read_register(CPUState *cpu, uint8_t *buf, int reg);
+int arm_cpu_gdb_read_register(CPUState *cpu, GByteArray *buf, int reg);
 int arm_cpu_gdb_write_register(CPUState *cpu, uint8_t *buf, int reg);
 
 /* Dynamically generates for gdb stub an XML description of the sysregs from
@@ -969,7 +969,7 @@ int arm_cpu_write_elf32_note(WriteCoreDumpFunction f, CPUState *cs,
                              int cpuid, void *opaque);
 
 #ifdef TARGET_AARCH64
-int aarch64_cpu_gdb_read_register(CPUState *cpu, uint8_t *buf, int reg);
+int aarch64_cpu_gdb_read_register(CPUState *cpu, GByteArray *buf, int reg);
 int aarch64_cpu_gdb_write_register(CPUState *cpu, uint8_t *buf, int reg);
 void aarch64_sve_narrow_vq(CPUARMState *env, unsigned vq);
 void aarch64_sve_change_el(CPUARMState *env, int old_el,
diff --git a/target/cris/cpu.h b/target/cris/cpu.h
index aba0a664744..333ee5b171a 100644
--- a/target/cris/cpu.h
+++ b/target/cris/cpu.h
@@ -194,8 +194,8 @@ void cris_cpu_dump_state(CPUState *cs, FILE *f, int flags);
 
 hwaddr cris_cpu_get_phys_page_debug(CPUState *cpu, vaddr addr);
 
-int crisv10_cpu_gdb_read_register(CPUState *cpu, uint8_t *buf, int reg);
-int cris_cpu_gdb_read_register(CPUState *cpu, uint8_t *buf, int reg);
+int crisv10_cpu_gdb_read_register(CPUState *cpu, GByteArray *buf, int reg);
+int cris_cpu_gdb_read_register(CPUState *cpu, GByteArray *buf, int reg);
 int cris_cpu_gdb_write_register(CPUState *cpu, uint8_t *buf, int reg);
 
 /* you can call this signal handler from your SIGBUS and SIGSEGV
diff --git a/target/hppa/cpu.h b/target/hppa/cpu.h
index 6713d04f111..801a4fb1bae 100644
--- a/target/hppa/cpu.h
+++ b/target/hppa/cpu.h
@@ -321,7 +321,7 @@ void cpu_hppa_change_prot_id(CPUHPPAState *env);
 
 int cpu_hppa_signal_handler(int host_signum, void *pinfo, void *puc);
 hwaddr hppa_cpu_get_phys_page_debug(CPUState *cs, vaddr addr);
-int hppa_cpu_gdb_read_register(CPUState *cpu, uint8_t *buf, int reg);
+int hppa_cpu_gdb_read_register(CPUState *cpu, GByteArray *buf, int reg);
 int hppa_cpu_gdb_write_register(CPUState *cpu, uint8_t *buf, int reg);
 void hppa_cpu_do_interrupt(CPUState *cpu);
 bool hppa_cpu_exec_interrupt(CPUState *cpu, int int_req);
diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index cde2a16b941..11720130e66 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -1757,7 +1757,7 @@ void x86_cpu_dump_state(CPUState *cs, FILE *f, int flags);
 hwaddr x86_cpu_get_phys_page_attrs_debug(CPUState *cpu, vaddr addr,
                                          MemTxAttrs *attrs);
 
-int x86_cpu_gdb_read_register(CPUState *cpu, uint8_t *buf, int reg);
+int x86_cpu_gdb_read_register(CPUState *cpu, GByteArray *buf, int reg);
 int x86_cpu_gdb_write_register(CPUState *cpu, uint8_t *buf, int reg);
 
 void x86_cpu_exec_enter(CPUState *cpu);
diff --git a/target/lm32/cpu.h b/target/lm32/cpu.h
index 064c6b1267e..01d408eb55d 100644
--- a/target/lm32/cpu.h
+++ b/target/lm32/cpu.h
@@ -202,7 +202,7 @@ void lm32_cpu_do_interrupt(CPUState *cpu);
 bool lm32_cpu_exec_interrupt(CPUState *cs, int int_req);
 void lm32_cpu_dump_state(CPUState *cpu, FILE *f, int flags);
 hwaddr lm32_cpu_get_phys_page_debug(CPUState *cpu, vaddr addr);
-int lm32_cpu_gdb_read_register(CPUState *cpu, uint8_t *buf, int reg);
+int lm32_cpu_gdb_read_register(CPUState *cpu, GByteArray *buf, int reg);
 int lm32_cpu_gdb_write_register(CPUState *cpu, uint8_t *buf, int reg);
 
 typedef enum {
diff --git a/target/m68k/cpu.h b/target/m68k/cpu.h
index 20de3c379aa..cdb08c269f6 100644
--- a/target/m68k/cpu.h
+++ b/target/m68k/cpu.h
@@ -168,7 +168,7 @@ void m68k_cpu_do_interrupt(CPUState *cpu);
 bool m68k_cpu_exec_interrupt(CPUState *cpu, int int_req);
 void m68k_cpu_dump_state(CPUState *cpu, FILE *f, int flags);
 hwaddr m68k_cpu_get_phys_page_debug(CPUState *cpu, vaddr addr);
-int m68k_cpu_gdb_read_register(CPUState *cpu, uint8_t *buf, int reg);
+int m68k_cpu_gdb_read_register(CPUState *cpu, GByteArray *buf, int reg);
 int m68k_cpu_gdb_write_register(CPUState *cpu, uint8_t *buf, int reg);
 
 void m68k_tcg_init(void);
diff --git a/target/microblaze/cpu.h b/target/microblaze/cpu.h
index 95773089aa3..987e4629b0a 100644
--- a/target/microblaze/cpu.h
+++ b/target/microblaze/cpu.h
@@ -313,7 +313,7 @@ void mb_cpu_do_interrupt(CPUState *cs);
 bool mb_cpu_exec_interrupt(CPUState *cs, int int_req);
 void mb_cpu_dump_state(CPUState *cpu, FILE *f, int flags);
 hwaddr mb_cpu_get_phys_page_debug(CPUState *cpu, vaddr addr);
-int mb_cpu_gdb_read_register(CPUState *cpu, uint8_t *buf, int reg);
+int mb_cpu_gdb_read_register(CPUState *cpu, GByteArray *buf, int reg);
 int mb_cpu_gdb_write_register(CPUState *cpu, uint8_t *buf, int reg);
 
 void mb_tcg_init(void);
diff --git a/target/mips/internal.h b/target/mips/internal.h
index 3f435b5e631..c5ae86360f5 100644
--- a/target/mips/internal.h
+++ b/target/mips/internal.h
@@ -82,7 +82,7 @@ void mips_cpu_do_interrupt(CPUState *cpu);
 bool mips_cpu_exec_interrupt(CPUState *cpu, int int_req);
 void mips_cpu_dump_state(CPUState *cpu, FILE *f, int flags);
 hwaddr mips_cpu_get_phys_page_debug(CPUState *cpu, vaddr addr);
-int mips_cpu_gdb_read_register(CPUState *cpu, uint8_t *buf, int reg);
+int mips_cpu_gdb_read_register(CPUState *cpu, GByteArray *buf, int reg);
 int mips_cpu_gdb_write_register(CPUState *cpu, uint8_t *buf, int reg);
 void mips_cpu_do_unaligned_access(CPUState *cpu, vaddr addr,
                                   MMUAccessType access_type,
diff --git a/target/openrisc/cpu.h b/target/openrisc/cpu.h
index 0ad02eab794..d9484b802f3 100644
--- a/target/openrisc/cpu.h
+++ b/target/openrisc/cpu.h
@@ -320,7 +320,7 @@ void openrisc_cpu_do_interrupt(CPUState *cpu);
 bool openrisc_cpu_exec_interrupt(CPUState *cpu, int int_req);
 void openrisc_cpu_dump_state(CPUState *cpu, FILE *f, int flags);
 hwaddr openrisc_cpu_get_phys_page_debug(CPUState *cpu, vaddr addr);
-int openrisc_cpu_gdb_read_register(CPUState *cpu, uint8_t *buf, int reg);
+int openrisc_cpu_gdb_read_register(CPUState *cpu, GByteArray *buf, int reg);
 int openrisc_cpu_gdb_write_register(CPUState *cpu, uint8_t *buf, int reg);
 void openrisc_translate_init(void);
 bool openrisc_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
index e3e82327b72..ed3f55ea4b4 100644
--- a/target/ppc/cpu.h
+++ b/target/ppc/cpu.h
@@ -1258,8 +1258,8 @@ bool ppc_cpu_exec_interrupt(CPUState *cpu, int int_req);
 void ppc_cpu_dump_state(CPUState *cpu, FILE *f, int flags);
 void ppc_cpu_dump_statistics(CPUState *cpu, int flags);
 hwaddr ppc_cpu_get_phys_page_debug(CPUState *cpu, vaddr addr);
-int ppc_cpu_gdb_read_register(CPUState *cpu, uint8_t *buf, int reg);
-int ppc_cpu_gdb_read_register_apple(CPUState *cpu, uint8_t *buf, int reg);
+int ppc_cpu_gdb_read_register(CPUState *cpu, GByteArray *buf, int reg);
+int ppc_cpu_gdb_read_register_apple(CPUState *cpu, GByteArray *buf, int reg);
 int ppc_cpu_gdb_write_register(CPUState *cpu, uint8_t *buf, int reg);
 int ppc_cpu_gdb_write_register_apple(CPUState *cpu, uint8_t *buf, int reg);
 #ifndef CONFIG_USER_ONLY
diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index e59343e13c0..fe0b8861021 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -243,7 +243,7 @@ extern const char * const riscv_excp_names[];
 extern const char * const riscv_intr_names[];
 
 void riscv_cpu_do_interrupt(CPUState *cpu);
-int riscv_cpu_gdb_read_register(CPUState *cpu, uint8_t *buf, int reg);
+int riscv_cpu_gdb_read_register(CPUState *cpu, GByteArray *buf, int reg);
 int riscv_cpu_gdb_write_register(CPUState *cpu, uint8_t *buf, int reg);
 bool riscv_cpu_exec_interrupt(CPUState *cs, int interrupt_request);
 bool riscv_cpu_fp_enabled(CPURISCVState *env);
diff --git a/target/s390x/internal.h b/target/s390x/internal.h
index d37816104dd..8c95c734dbe 100644
--- a/target/s390x/internal.h
+++ b/target/s390x/internal.h
@@ -292,7 +292,7 @@ uint16_t float128_dcmask(CPUS390XState *env, float128 f1);
 
 
 /* gdbstub.c */
-int s390_cpu_gdb_read_register(CPUState *cpu, uint8_t *buf, int reg);
+int s390_cpu_gdb_read_register(CPUState *cpu, GByteArray *buf, int reg);
 int s390_cpu_gdb_write_register(CPUState *cpu, uint8_t *buf, int reg);
 void s390_cpu_gdb_init(CPUState *cs);
 
diff --git a/target/sh4/cpu.h b/target/sh4/cpu.h
index ecaa7a18a94..d7a1bffd600 100644
--- a/target/sh4/cpu.h
+++ b/target/sh4/cpu.h
@@ -208,7 +208,7 @@ void superh_cpu_do_interrupt(CPUState *cpu);
 bool superh_cpu_exec_interrupt(CPUState *cpu, int int_req);
 void superh_cpu_dump_state(CPUState *cpu, FILE *f, int flags);
 hwaddr superh_cpu_get_phys_page_debug(CPUState *cpu, vaddr addr);
-int superh_cpu_gdb_read_register(CPUState *cpu, uint8_t *buf, int reg);
+int superh_cpu_gdb_read_register(CPUState *cpu, GByteArray *buf, int reg);
 int superh_cpu_gdb_write_register(CPUState *cpu, uint8_t *buf, int reg);
 void superh_cpu_do_unaligned_access(CPUState *cpu, vaddr addr,
                                     MMUAccessType access_type,
diff --git a/target/sparc/cpu.h b/target/sparc/cpu.h
index ae97c7d9f79..b9369398f24 100644
--- a/target/sparc/cpu.h
+++ b/target/sparc/cpu.h
@@ -571,7 +571,7 @@ extern const VMStateDescription vmstate_sparc_cpu;
 void sparc_cpu_do_interrupt(CPUState *cpu);
 void sparc_cpu_dump_state(CPUState *cpu, FILE *f, int flags);
 hwaddr sparc_cpu_get_phys_page_debug(CPUState *cpu, vaddr addr);
-int sparc_cpu_gdb_read_register(CPUState *cpu, uint8_t *buf, int reg);
+int sparc_cpu_gdb_read_register(CPUState *cpu, GByteArray *buf, int reg);
 int sparc_cpu_gdb_write_register(CPUState *cpu, uint8_t *buf, int reg);
 void QEMU_NORETURN sparc_cpu_do_unaligned_access(CPUState *cpu, vaddr addr,
                                                  MMUAccessType access_type,
diff --git a/target/xtensa/cpu.h b/target/xtensa/cpu.h
index b363ffcf106..b20be1f5814 100644
--- a/target/xtensa/cpu.h
+++ b/target/xtensa/cpu.h
@@ -569,7 +569,7 @@ void xtensa_cpu_dump_state(CPUState *cpu, FILE *f, int flags);
 hwaddr xtensa_cpu_get_phys_page_debug(CPUState *cpu, vaddr addr);
 void xtensa_count_regs(const XtensaConfig *config,
                        unsigned *n_regs, unsigned *n_core_regs);
-int xtensa_cpu_gdb_read_register(CPUState *cpu, uint8_t *buf, int reg);
+int xtensa_cpu_gdb_read_register(CPUState *cpu, GByteArray *buf, int reg);
 int xtensa_cpu_gdb_write_register(CPUState *cpu, uint8_t *buf, int reg);
 void xtensa_cpu_do_unaligned_access(CPUState *cpu, vaddr addr,
                                     MMUAccessType access_type,
diff --git a/gdbstub.c b/gdbstub.c
index 265157282f2..7b695bdebe6 100644
--- a/gdbstub.c
+++ b/gdbstub.c
@@ -319,8 +319,8 @@ static int gdb_signal_to_target (int sig)
 typedef struct GDBRegisterState {
     int base_reg;
     int num_regs;
-    gdb_reg_cb get_reg;
-    gdb_reg_cb set_reg;
+    gdb_get_reg_cb get_reg;
+    gdb_set_reg_cb set_reg;
     const char *xml;
     struct GDBRegisterState *next;
 } GDBRegisterState;
@@ -905,19 +905,19 @@ static const char *get_feature_xml(const char *p, const char **newp,
     return name ? xml_builtin[i][1] : NULL;
 }
 
-static int gdb_read_register(CPUState *cpu, uint8_t *mem_buf, int reg)
+static int gdb_read_register(CPUState *cpu, GByteArray *buf, int reg)
 {
     CPUClass *cc = CPU_GET_CLASS(cpu);
     CPUArchState *env = cpu->env_ptr;
     GDBRegisterState *r;
 
     if (reg < cc->gdb_num_core_regs) {
-        return cc->gdb_read_register(cpu, mem_buf, reg);
+        return cc->gdb_read_register(cpu, buf, reg);
     }
 
     for (r = cpu->gdb_regs; r; r = r->next) {
         if (r->base_reg <= reg && reg < r->base_reg + r->num_regs) {
-            return r->get_reg(env, mem_buf, reg - r->base_reg);
+            return r->get_reg(env, buf, reg - r->base_reg);
         }
     }
     return 0;
@@ -948,7 +948,7 @@ static int gdb_write_register(CPUState *cpu, uint8_t *mem_buf, int reg)
  */
 
 void gdb_register_coprocessor(CPUState *cpu,
-                              gdb_reg_cb get_reg, gdb_reg_cb set_reg,
+                              gdb_get_reg_cb get_reg, gdb_set_reg_cb set_reg,
                               int num_regs, const char *xml, int g_pos)
 {
     GDBRegisterState *s;
@@ -1740,7 +1740,7 @@ static void handle_get_reg(GdbCmdContext *gdb_ctx, void *user_ctx)
     }
 
     reg_size = gdb_read_register(gdbserver_state.g_cpu,
-                                 gdbserver_state.mem_buf->data,
+                                 gdbserver_state.mem_buf,
                                  gdb_ctx->params[0].val_ull);
     if (!reg_size) {
         put_packet("E14");
@@ -1833,14 +1833,14 @@ static void handle_read_all_regs(GdbCmdContext *gdb_ctx, void *user_ctx)
     target_ulong addr, len;
 
     cpu_synchronize_state(gdbserver_state.g_cpu);
+    g_byte_array_set_size(gdbserver_state.mem_buf, 0);
     len = 0;
     for (addr = 0; addr < gdbserver_state.g_cpu->gdb_num_g_regs; addr++) {
         len += gdb_read_register(gdbserver_state.g_cpu,
-                                 gdbserver_state.mem_buf->data + len,
+                                 gdbserver_state.mem_buf,
                                  addr);
     }
-    /* FIXME: This is after the fact sizing */
-    g_byte_array_set_size(gdbserver_state.mem_buf, len);
+    g_assert(len == gdbserver_state.mem_buf->len);
 
     memtohex(gdbserver_state.str_buf, gdbserver_state.mem_buf->data, len);
     put_strbuf();
diff --git a/hw/core/cpu.c b/hw/core/cpu.c
index db1a03c6bbb..9cd1a2a54fb 100644
--- a/hw/core/cpu.c
+++ b/hw/core/cpu.c
@@ -177,7 +177,7 @@ static int cpu_common_write_elf64_note(WriteCoreDumpFunction f,
 }
 
 
-static int cpu_common_gdb_read_register(CPUState *cpu, uint8_t *buf, int reg)
+static int cpu_common_gdb_read_register(CPUState *cpu, GByteArray *buf, int reg)
 {
     return 0;
 }
diff --git a/target/alpha/gdbstub.c b/target/alpha/gdbstub.c
index 7f9cc092a9c..0cd76ddaa9e 100644
--- a/target/alpha/gdbstub.c
+++ b/target/alpha/gdbstub.c
@@ -21,7 +21,7 @@
 #include "cpu.h"
 #include "exec/gdbstub.h"
 
-int alpha_cpu_gdb_read_register(CPUState *cs, uint8_t *mem_buf, int n)
+int alpha_cpu_gdb_read_register(CPUState *cs, GByteArray *mem_buf, int n)
 {
     AlphaCPU *cpu = ALPHA_CPU(cs);
     CPUAlphaState *env = &cpu->env;
diff --git a/target/arm/gdbstub.c b/target/arm/gdbstub.c
index 1239abd9842..4557775d245 100644
--- a/target/arm/gdbstub.c
+++ b/target/arm/gdbstub.c
@@ -32,7 +32,7 @@ typedef struct RegisterSysregXmlParam {
    We hack round this by giving the FPA regs zero size when talking to a
    newer gdb.  */
 
-int arm_cpu_gdb_read_register(CPUState *cs, uint8_t *mem_buf, int n)
+int arm_cpu_gdb_read_register(CPUState *cs, GByteArray *mem_buf, int n)
 {
     ARMCPU *cpu = ARM_CPU(cs);
     CPUARMState *env = &cpu->env;
diff --git a/target/arm/gdbstub64.c b/target/arm/gdbstub64.c
index 665ebb3ef64..35d0b80c2de 100644
--- a/target/arm/gdbstub64.c
+++ b/target/arm/gdbstub64.c
@@ -20,7 +20,7 @@
 #include "cpu.h"
 #include "exec/gdbstub.h"
 
-int aarch64_cpu_gdb_read_register(CPUState *cs, uint8_t *mem_buf, int n)
+int aarch64_cpu_gdb_read_register(CPUState *cs, GByteArray *mem_buf, int n)
 {
     ARMCPU *cpu = ARM_CPU(cs);
     CPUARMState *env = &cpu->env;
diff --git a/target/arm/helper.c b/target/arm/helper.c
index 0ac950d6c71..6476245e789 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -47,30 +47,27 @@ static bool get_phys_addr_lpae(CPUARMState *env, target_ulong address,
 
 static void switch_mode(CPUARMState *env, int mode);
 
-static int vfp_gdb_get_reg(CPUARMState *env, uint8_t *buf, int reg)
+static int vfp_gdb_get_reg(CPUARMState *env, GByteArray *buf, int reg)
 {
     int nregs;
 
     /* VFP data registers are always little-endian.  */
     nregs = arm_feature(env, ARM_FEATURE_VFP3) ? 32 : 16;
     if (reg < nregs) {
-        stq_le_p(buf, *aa32_vfp_dreg(env, reg));
-        return 8;
+        return gdb_get_reg64(buf, *aa32_vfp_dreg(env, reg));
     }
     if (arm_feature(env, ARM_FEATURE_NEON)) {
         /* Aliases for Q regs.  */
         nregs += 16;
         if (reg < nregs) {
             uint64_t *q = aa32_vfp_qreg(env, reg - 32);
-            stq_le_p(buf, q[0]);
-            stq_le_p(buf + 8, q[1]);
-            return 16;
+            return gdb_get_reg128(buf, q[0], q[1]);
         }
     }
     switch (reg - nregs) {
-    case 0: stl_p(buf, env->vfp.xregs[ARM_VFP_FPSID]); return 4;
-    case 1: stl_p(buf, vfp_get_fpscr(env)); return 4;
-    case 2: stl_p(buf, env->vfp.xregs[ARM_VFP_FPEXC]); return 4;
+    case 0: return gdb_get_reg32(buf, env->vfp.xregs[ARM_VFP_FPSID]); break;
+    case 1: return gdb_get_reg32(buf, vfp_get_fpscr(env)); break;
+    case 2: return gdb_get_reg32(buf, env->vfp.xregs[ARM_VFP_FPEXC]); break;
     }
     return 0;
 }
@@ -101,7 +98,7 @@ static int vfp_gdb_set_reg(CPUARMState *env, uint8_t *buf, int reg)
     return 0;
 }
 
-static int aarch64_fpu_gdb_get_reg(CPUARMState *env, uint8_t *buf, int reg)
+static int aarch64_fpu_gdb_get_reg(CPUARMState *env, GByteArray *buf, int reg)
 {
     switch (reg) {
     case 0 ... 31:
@@ -204,7 +201,7 @@ static void write_raw_cp_reg(CPUARMState *env, const ARMCPRegInfo *ri,
     }
 }
 
-static int arm_gdb_get_sysreg(CPUARMState *env, uint8_t *buf, int reg)
+static int arm_gdb_get_sysreg(CPUARMState *env, GByteArray *buf, int reg)
 {
     ARMCPU *cpu = env_archcpu(env);
     const ARMCPRegInfo *ri;
diff --git a/target/cris/gdbstub.c b/target/cris/gdbstub.c
index a3d76d2e8c2..b01b2aa0811 100644
--- a/target/cris/gdbstub.c
+++ b/target/cris/gdbstub.c
@@ -21,7 +21,7 @@
 #include "cpu.h"
 #include "exec/gdbstub.h"
 
-int crisv10_cpu_gdb_read_register(CPUState *cs, uint8_t *mem_buf, int n)
+int crisv10_cpu_gdb_read_register(CPUState *cs, GByteArray *mem_buf, int n)
 {
     CRISCPU *cpu = CRIS_CPU(cs);
     CPUCRISState *env = &cpu->env;
@@ -53,7 +53,7 @@ int crisv10_cpu_gdb_read_register(CPUState *cs, uint8_t *mem_buf, int n)
     return 0;
 }
 
-int cris_cpu_gdb_read_register(CPUState *cs, uint8_t *mem_buf, int n)
+int cris_cpu_gdb_read_register(CPUState *cs, GByteArray *mem_buf, int n)
 {
     CRISCPU *cpu = CRIS_CPU(cs);
     CPUCRISState *env = &cpu->env;
diff --git a/target/hppa/gdbstub.c b/target/hppa/gdbstub.c
index 341888a9da0..a6428a2893f 100644
--- a/target/hppa/gdbstub.c
+++ b/target/hppa/gdbstub.c
@@ -21,7 +21,7 @@
 #include "cpu.h"
 #include "exec/gdbstub.h"
 
-int hppa_cpu_gdb_read_register(CPUState *cs, uint8_t *mem_buf, int n)
+int hppa_cpu_gdb_read_register(CPUState *cs, GByteArray *mem_buf, int n)
 {
     HPPACPU *cpu = HPPA_CPU(cs);
     CPUHPPAState *env = &cpu->env;
diff --git a/target/i386/gdbstub.c b/target/i386/gdbstub.c
index aef25b70f10..38324498f33 100644
--- a/target/i386/gdbstub.c
+++ b/target/i386/gdbstub.c
@@ -79,7 +79,7 @@ static const int gpr_map32[8] = { 0, 1, 2, 3, 4, 5, 6, 7 };
 #endif
 
 
-int x86_cpu_gdb_read_register(CPUState *cs, uint8_t *mem_buf, int n)
+int x86_cpu_gdb_read_register(CPUState *cs, GByteArray *mem_buf, int n)
 {
     X86CPU *cpu = X86_CPU(cs);
     CPUX86State *env = &cpu->env;
diff --git a/target/lm32/gdbstub.c b/target/lm32/gdbstub.c
index 82ede436e12..b6fe12e1d61 100644
--- a/target/lm32/gdbstub.c
+++ b/target/lm32/gdbstub.c
@@ -22,7 +22,7 @@
 #include "exec/gdbstub.h"
 #include "hw/lm32/lm32_pic.h"
 
-int lm32_cpu_gdb_read_register(CPUState *cs, uint8_t *mem_buf, int n)
+int lm32_cpu_gdb_read_register(CPUState *cs, GByteArray *mem_buf, int n)
 {
     LM32CPU *cpu = LM32_CPU(cs);
     CPULM32State *env = &cpu->env;
diff --git a/target/m68k/gdbstub.c b/target/m68k/gdbstub.c
index fdc96f57fff..eb2d030e148 100644
--- a/target/m68k/gdbstub.c
+++ b/target/m68k/gdbstub.c
@@ -21,7 +21,7 @@
 #include "cpu.h"
 #include "exec/gdbstub.h"
 
-int m68k_cpu_gdb_read_register(CPUState *cs, uint8_t *mem_buf, int n)
+int m68k_cpu_gdb_read_register(CPUState *cs, GByteArray *mem_buf, int n)
 {
     M68kCPU *cpu = M68K_CPU(cs);
     CPUM68KState *env = &cpu->env;
diff --git a/target/m68k/helper.c b/target/m68k/helper.c
index 70b0c0b5076..a11863a8545 100644
--- a/target/m68k/helper.c
+++ b/target/m68k/helper.c
@@ -68,7 +68,7 @@ void m68k_cpu_list(void)
     g_slist_free(list);
 }
 
-static int cf_fpu_gdb_get_reg(CPUM68KState *env, uint8_t *mem_buf, int n)
+static int cf_fpu_gdb_get_reg(CPUM68KState *env, GByteArray *buf, int n)
 {
     if (n < 8) {
         float_status s;
@@ -105,7 +105,7 @@ static int cf_fpu_gdb_set_reg(CPUM68KState *env, uint8_t *mem_buf, int n)
     return 0;
 }
 
-static int m68k_fpu_gdb_get_reg(CPUM68KState *env, uint8_t *mem_buf, int n)
+static int m68k_fpu_gdb_get_reg(CPUM68KState *env, GByteArray *buf, int n)
 {
     if (n < 8) {
         int len = gdb_get_reg16(buf, env->fregs[n].l.upper);
diff --git a/target/microblaze/gdbstub.c b/target/microblaze/gdbstub.c
index 30677b6d1f4..f41ebf1f33b 100644
--- a/target/microblaze/gdbstub.c
+++ b/target/microblaze/gdbstub.c
@@ -21,7 +21,7 @@
 #include "cpu.h"
 #include "exec/gdbstub.h"
 
-int mb_cpu_gdb_read_register(CPUState *cs, uint8_t *mem_buf, int n)
+int mb_cpu_gdb_read_register(CPUState *cs, GByteArray *mem_buf, int n)
 {
     MicroBlazeCPU *cpu = MICROBLAZE_CPU(cs);
     CPUMBState *env = &cpu->env;
diff --git a/target/mips/gdbstub.c b/target/mips/gdbstub.c
index bbb25449391..98f56e660d2 100644
--- a/target/mips/gdbstub.c
+++ b/target/mips/gdbstub.c
@@ -22,7 +22,7 @@
 #include "internal.h"
 #include "exec/gdbstub.h"
 
-int mips_cpu_gdb_read_register(CPUState *cs, uint8_t *mem_buf, int n)
+int mips_cpu_gdb_read_register(CPUState *cs, GByteArray *mem_buf, int n)
 {
     MIPSCPU *cpu = MIPS_CPU(cs);
     CPUMIPSState *env = &cpu->env;
diff --git a/target/nios2/cpu.c b/target/nios2/cpu.c
index ca9c7a6df5d..17d868421ed 100644
--- a/target/nios2/cpu.c
+++ b/target/nios2/cpu.c
@@ -124,7 +124,7 @@ static void nios2_cpu_disas_set_info(CPUState *cpu, disassemble_info *info)
 #endif
 }
 
-static int nios2_cpu_gdb_read_register(CPUState *cs, uint8_t *mem_buf, int n)
+static int nios2_cpu_gdb_read_register(CPUState *cs, GByteArray *mem_buf, int n)
 {
     Nios2CPU *cpu = NIOS2_CPU(cs);
     CPUClass *cc = CPU_GET_CLASS(cs);
diff --git a/target/openrisc/gdbstub.c b/target/openrisc/gdbstub.c
index 0fcdb79668c..095bf76c12c 100644
--- a/target/openrisc/gdbstub.c
+++ b/target/openrisc/gdbstub.c
@@ -21,7 +21,7 @@
 #include "cpu.h"
 #include "exec/gdbstub.h"
 
-int openrisc_cpu_gdb_read_register(CPUState *cs, uint8_t *mem_buf, int n)
+int openrisc_cpu_gdb_read_register(CPUState *cs, GByteArray *mem_buf, int n)
 {
     OpenRISCCPU *cpu = OPENRISC_CPU(cs);
     CPUOpenRISCState *env = &cpu->env;
diff --git a/target/ppc/gdbstub.c b/target/ppc/gdbstub.c
index 823759c92e7..6f08021cc22 100644
--- a/target/ppc/gdbstub.c
+++ b/target/ppc/gdbstub.c
@@ -114,10 +114,11 @@ void ppc_maybe_bswap_register(CPUPPCState *env, uint8_t *mem_buf, int len)
  * the FP regs zero size when talking to a newer gdb.
  */
 
-int ppc_cpu_gdb_read_register(CPUState *cs, uint8_t *mem_buf, int n)
+int ppc_cpu_gdb_read_register(CPUState *cs, GByteArray *buf, int n)
 {
     PowerPCCPU *cpu = POWERPC_CPU(cs);
     CPUPPCState *env = &cpu->env;
+    uint8_t *mem_buf;
     int r = ppc_gdb_register_len(n);
 
     if (!r) {
@@ -126,17 +127,17 @@ int ppc_cpu_gdb_read_register(CPUState *cs, uint8_t *mem_buf, int n)
 
     if (n < 32) {
         /* gprs */
-        gdb_get_regl(mem_buf, env->gpr[n]);
+        gdb_get_regl(buf, env->gpr[n]);
     } else if (n < 64) {
         /* fprs */
-        stfq_p(mem_buf, *cpu_fpr_ptr(env, n - 32));
+        gdb_get_reg64(buf, *cpu_fpr_ptr(env, n - 32));
     } else {
         switch (n) {
         case 64:
-            gdb_get_regl(mem_buf, env->nip);
+            gdb_get_regl(buf, env->nip);
             break;
         case 65:
-            gdb_get_regl(mem_buf, env->msr);
+            gdb_get_regl(buf, env->msr);
             break;
         case 66:
             {
@@ -145,31 +146,33 @@ int ppc_cpu_gdb_read_register(CPUState *cs, uint8_t *mem_buf, int n)
                 for (i = 0; i < 8; i++) {
                     cr |= env->crf[i] << (32 - ((i + 1) * 4));
                 }
-                gdb_get_reg32(mem_buf, cr);
+                gdb_get_reg32(buf, cr);
                 break;
             }
         case 67:
-            gdb_get_regl(mem_buf, env->lr);
+            gdb_get_regl(buf, env->lr);
             break;
         case 68:
-            gdb_get_regl(mem_buf, env->ctr);
+            gdb_get_regl(buf, env->ctr);
             break;
         case 69:
-            gdb_get_reg32(mem_buf, env->xer);
+            gdb_get_reg32(buf, env->xer);
             break;
         case 70:
-            gdb_get_reg32(mem_buf, env->fpscr);
+            gdb_get_reg32(buf, env->fpscr);
             break;
         }
     }
+    mem_buf = buf->data - r;
     ppc_maybe_bswap_register(env, mem_buf, r);
     return r;
 }
 
-int ppc_cpu_gdb_read_register_apple(CPUState *cs, uint8_t *mem_buf, int n)
+int ppc_cpu_gdb_read_register_apple(CPUState *cs, GByteArray *buf, int n)
 {
     PowerPCCPU *cpu = POWERPC_CPU(cs);
     CPUPPCState *env = &cpu->env;
+    uint8_t *mem_buf;
     int r = ppc_gdb_register_len_apple(n);
 
     if (!r) {
@@ -178,21 +181,21 @@ int ppc_cpu_gdb_read_register_apple(CPUState *cs, uint8_t *mem_buf, int n)
 
     if (n < 32) {
         /* gprs */
-        gdb_get_reg64(mem_buf, env->gpr[n]);
+        gdb_get_reg64(buf, env->gpr[n]);
     } else if (n < 64) {
         /* fprs */
-        stfq_p(mem_buf, *cpu_fpr_ptr(env, n - 32));
+        gdb_get_reg64(buf, *cpu_fpr_ptr(env, n - 32));
     } else if (n < 96) {
         /* Altivec */
-        stq_p(mem_buf, n - 64);
-        stq_p(mem_buf + 8, 0);
+        gdb_get_reg64(buf, n - 64);
+        gdb_get_reg64(buf, 0);
     } else {
         switch (n) {
         case 64 + 32:
-            gdb_get_reg64(mem_buf, env->nip);
+            gdb_get_reg64(buf, env->nip);
             break;
         case 65 + 32:
-            gdb_get_reg64(mem_buf, env->msr);
+            gdb_get_reg64(buf, env->msr);
             break;
         case 66 + 32:
             {
@@ -201,23 +204,24 @@ int ppc_cpu_gdb_read_register_apple(CPUState *cs, uint8_t *mem_buf, int n)
                 for (i = 0; i < 8; i++) {
                     cr |= env->crf[i] << (32 - ((i + 1) * 4));
                 }
-                gdb_get_reg32(mem_buf, cr);
+                gdb_get_reg32(buf, cr);
                 break;
             }
         case 67 + 32:
-            gdb_get_reg64(mem_buf, env->lr);
+            gdb_get_reg64(buf, env->lr);
             break;
         case 68 + 32:
-            gdb_get_reg64(mem_buf, env->ctr);
+            gdb_get_reg64(buf, env->ctr);
             break;
         case 69 + 32:
-            gdb_get_reg32(mem_buf, env->xer);
+            gdb_get_reg32(buf, env->xer);
             break;
         case 70 + 32:
-            gdb_get_reg64(mem_buf, env->fpscr);
+            gdb_get_reg64(buf, env->fpscr);
             break;
         }
     }
+    mem_buf = buf->data - r;
     ppc_maybe_bswap_register(env, mem_buf, r);
     return r;
 }
diff --git a/target/ppc/translate_init.inc.c b/target/ppc/translate_init.inc.c
index ba726dec4d0..154f876e44c 100644
--- a/target/ppc/translate_init.inc.c
+++ b/target/ppc/translate_init.inc.c
@@ -9587,7 +9587,7 @@ static int gdb_find_spr_idx(CPUPPCState *env, int n)
     return -1;
 }
 
-static int gdb_get_spr_reg(CPUPPCState *env, uint8_t *mem_buf, int n)
+static int gdb_get_spr_reg(CPUPPCState *env, GByteArray *buf, int n)
 {
     int reg;
     int len;
@@ -9598,8 +9598,8 @@ static int gdb_get_spr_reg(CPUPPCState *env, uint8_t *mem_buf, int n)
     }
 
     len = TARGET_LONG_SIZE;
-    stn_p(mem_buf, len, env->spr[reg]);
-    ppc_maybe_bswap_register(env, mem_buf, len);
+    gdb_get_regl(buf, env->spr[reg]);
+    ppc_maybe_bswap_register(env, buf->data - len, len);
     return len;
 }
 
@@ -9621,15 +9621,18 @@ static int gdb_set_spr_reg(CPUPPCState *env, uint8_t *mem_buf, int n)
 }
 #endif
 
-static int gdb_get_float_reg(CPUPPCState *env, uint8_t *mem_buf, int n)
+static int gdb_get_float_reg(CPUPPCState *env, GByteArray *buf, int n)
 {
+    uint8_t *mem_buf;
     if (n < 32) {
-        stfq_p(mem_buf, *cpu_fpr_ptr(env, n));
+        gdb_get_reg64(buf, *cpu_fpr_ptr(env, n));
+        mem_buf = buf->data - 8;
         ppc_maybe_bswap_register(env, mem_buf, 8);
         return 8;
     }
     if (n == 32) {
-        stl_p(mem_buf, env->fpscr);
+        gdb_get_reg32(buf, env->fpscr);
+        mem_buf = buf->data - 4;
         ppc_maybe_bswap_register(env, mem_buf, 4);
         return 4;
     }
@@ -9651,28 +9654,31 @@ static int gdb_set_float_reg(CPUPPCState *env, uint8_t *mem_buf, int n)
     return 0;
 }
 
-static int gdb_get_avr_reg(CPUPPCState *env, uint8_t *mem_buf, int n)
+static int gdb_get_avr_reg(CPUPPCState *env, GByteArray *buf, int n)
 {
+    uint8_t *mem_buf;
+
     if (n < 32) {
         ppc_avr_t *avr = cpu_avr_ptr(env, n);
         if (!avr_need_swap(env)) {
-            stq_p(mem_buf, avr->u64[0]);
-            stq_p(mem_buf + 8, avr->u64[1]);
+            gdb_get_reg128(buf, avr->u64[0] , avr->u64[1]);
         } else {
-            stq_p(mem_buf, avr->u64[1]);
-            stq_p(mem_buf + 8, avr->u64[0]);
+            gdb_get_reg128(buf, avr->u64[1] , avr->u64[0]);
         }
+        mem_buf = buf->data - 16;
         ppc_maybe_bswap_register(env, mem_buf, 8);
         ppc_maybe_bswap_register(env, mem_buf + 8, 8);
         return 16;
     }
     if (n == 32) {
-        stl_p(mem_buf, helper_mfvscr(env));
+        gdb_get_reg32(buf, helper_mfvscr(env));
+        mem_buf = buf->data - 4;
         ppc_maybe_bswap_register(env, mem_buf, 4);
         return 4;
     }
     if (n == 33) {
-        stl_p(mem_buf, (uint32_t)env->spr[SPR_VRSAVE]);
+        gdb_get_reg32(buf, (uint32_t)env->spr[SPR_VRSAVE]);
+        mem_buf = buf->data - 4;
         ppc_maybe_bswap_register(env, mem_buf, 4);
         return 4;
     }
@@ -9707,25 +9713,25 @@ static int gdb_set_avr_reg(CPUPPCState *env, uint8_t *mem_buf, int n)
     return 0;
 }
 
-static int gdb_get_spe_reg(CPUPPCState *env, uint8_t *mem_buf, int n)
+static int gdb_get_spe_reg(CPUPPCState *env, GByteArray *buf, int n)
 {
     if (n < 32) {
 #if defined(TARGET_PPC64)
-        stl_p(mem_buf, env->gpr[n] >> 32);
-        ppc_maybe_bswap_register(env, mem_buf, 4);
+        gdb_get_reg32(buf, env->gpr[n] >> 32);
+        ppc_maybe_bswap_register(env, buf->data - 4, 4);
 #else
-        stl_p(mem_buf, env->gprh[n]);
+        gdb_get_reg32(buf, env->gprh[n]);
 #endif
         return 4;
     }
     if (n == 32) {
-        stq_p(mem_buf, env->spe_acc);
-        ppc_maybe_bswap_register(env, mem_buf, 8);
+        gdb_get_reg64(buf, env->spe_acc);
+        ppc_maybe_bswap_register(env, buf->data - 8, 8);
         return 8;
     }
     if (n == 33) {
-        stl_p(mem_buf, env->spe_fscr);
-        ppc_maybe_bswap_register(env, mem_buf, 4);
+        gdb_get_reg32(buf, env->spe_fscr);
+        ppc_maybe_bswap_register(env, buf->data - 4, 4);
         return 4;
     }
     return 0;
@@ -9760,11 +9766,11 @@ static int gdb_set_spe_reg(CPUPPCState *env, uint8_t *mem_buf, int n)
     return 0;
 }
 
-static int gdb_get_vsx_reg(CPUPPCState *env, uint8_t *mem_buf, int n)
+static int gdb_get_vsx_reg(CPUPPCState *env, GByteArray *buf, int n)
 {
     if (n < 32) {
-        stq_p(mem_buf, *cpu_vsrl_ptr(env, n));
-        ppc_maybe_bswap_register(env, mem_buf, 8);
+        gdb_get_reg64(buf, *cpu_vsrl_ptr(env, n));
+        ppc_maybe_bswap_register(env, buf->data - 8, 8);
         return 8;
     }
     return 0;
diff --git a/target/riscv/gdbstub.c b/target/riscv/gdbstub.c
index 1a7947e0198..05442215a4b 100644
--- a/target/riscv/gdbstub.c
+++ b/target/riscv/gdbstub.c
@@ -269,7 +269,7 @@ static int csr_register_map[] = {
     CSR_MHCOUNTEREN,
 };
 
-int riscv_cpu_gdb_read_register(CPUState *cs, uint8_t *mem_buf, int n)
+int riscv_cpu_gdb_read_register(CPUState *cs, GByteArray *mem_buf, int n)
 {
     RISCVCPU *cpu = RISCV_CPU(cs);
     CPURISCVState *env = &cpu->env;
@@ -300,10 +300,10 @@ int riscv_cpu_gdb_write_register(CPUState *cs, uint8_t *mem_buf, int n)
     return 0;
 }
 
-static int riscv_gdb_get_fpu(CPURISCVState *env, uint8_t *mem_buf, int n)
+static int riscv_gdb_get_fpu(CPURISCVState *env, GByteArray *buf, int n)
 {
     if (n < 32) {
-        return gdb_get_reg64(mem_buf, env->fpr[n]);
+        return gdb_get_reg64(buf, env->fpr[n]);
     /* there is hole between ft11 and fflags in fpu.xml */
     } else if (n < 36 && n > 32) {
         target_ulong val = 0;
@@ -316,7 +316,7 @@ static int riscv_gdb_get_fpu(CPURISCVState *env, uint8_t *mem_buf, int n)
         result = riscv_csrrw_debug(env, n - 33 + csr_register_map[8], &val,
                                    0, 0);
         if (result == 0) {
-            return gdb_get_regl(mem_buf, val);
+            return gdb_get_regl(buf, val);
         }
     }
     return 0;
@@ -345,7 +345,7 @@ static int riscv_gdb_set_fpu(CPURISCVState *env, uint8_t *mem_buf, int n)
     return 0;
 }
 
-static int riscv_gdb_get_csr(CPURISCVState *env, uint8_t *mem_buf, int n)
+static int riscv_gdb_get_csr(CPURISCVState *env, GByteArray *buf, int n)
 {
     if (n < ARRAY_SIZE(csr_register_map)) {
         target_ulong val = 0;
@@ -353,7 +353,7 @@ static int riscv_gdb_get_csr(CPURISCVState *env, uint8_t *mem_buf, int n)
 
         result = riscv_csrrw_debug(env, csr_register_map[n], &val, 0, 0);
         if (result == 0) {
-            return gdb_get_regl(mem_buf, val);
+            return gdb_get_regl(buf, val);
         }
     }
     return 0;
@@ -373,13 +373,13 @@ static int riscv_gdb_set_csr(CPURISCVState *env, uint8_t *mem_buf, int n)
     return 0;
 }
 
-static int riscv_gdb_get_virtual(CPURISCVState *cs, uint8_t *mem_buf, int n)
+static int riscv_gdb_get_virtual(CPURISCVState *cs, GByteArray *buf, int n)
 {
     if (n == 0) {
 #ifdef CONFIG_USER_ONLY
-        return gdb_get_regl(mem_buf, 0);
+        return gdb_get_regl(buf, 0);
 #else
-        return gdb_get_regl(mem_buf, cs->priv);
+        return gdb_get_regl(buf, cs->priv);
 #endif
     }
     return 0;
diff --git a/target/s390x/gdbstub.c b/target/s390x/gdbstub.c
index e24a49f4a91..d6fce5ff1e1 100644
--- a/target/s390x/gdbstub.c
+++ b/target/s390x/gdbstub.c
@@ -27,7 +27,7 @@
 #include "sysemu/hw_accel.h"
 #include "sysemu/tcg.h"
 
-int s390_cpu_gdb_read_register(CPUState *cs, uint8_t *mem_buf, int n)
+int s390_cpu_gdb_read_register(CPUState *cs, GByteArray *mem_buf, int n)
 {
     S390CPU *cpu = S390_CPU(cs);
     CPUS390XState *env = &cpu->env;
@@ -82,11 +82,11 @@ int s390_cpu_gdb_write_register(CPUState *cs, uint8_t *mem_buf, int n)
 /* total number of registers in s390-acr.xml */
 #define S390_NUM_AC_REGS 16
 
-static int cpu_read_ac_reg(CPUS390XState *env, uint8_t *mem_buf, int n)
+static int cpu_read_ac_reg(CPUS390XState *env, GByteArray *buf, int n)
 {
     switch (n) {
     case S390_A0_REGNUM ... S390_A15_REGNUM:
-        return gdb_get_reg32(mem_buf, env->aregs[n]);
+        return gdb_get_reg32(buf, env->aregs[n]);
     default:
         return 0;
     }
@@ -111,13 +111,13 @@ static int cpu_write_ac_reg(CPUS390XState *env, uint8_t *mem_buf, int n)
 /* total number of registers in s390-fpr.xml */
 #define S390_NUM_FP_REGS 17
 
-static int cpu_read_fp_reg(CPUS390XState *env, uint8_t *mem_buf, int n)
+static int cpu_read_fp_reg(CPUS390XState *env, GByteArray *buf, int n)
 {
     switch (n) {
     case S390_FPC_REGNUM:
-        return gdb_get_reg32(mem_buf, env->fpc);
+        return gdb_get_reg32(buf, env->fpc);
     case S390_F0_REGNUM ... S390_F15_REGNUM:
-        return gdb_get_reg64(mem_buf, *get_freg(env, n - S390_F0_REGNUM));
+        return gdb_get_reg64(buf, *get_freg(env, n - S390_F0_REGNUM));
     default:
         return 0;
     }
@@ -145,17 +145,17 @@ static int cpu_write_fp_reg(CPUS390XState *env, uint8_t *mem_buf, int n)
 /* total number of registers in s390-vx.xml */
 #define S390_NUM_VREGS 32
 
-static int cpu_read_vreg(CPUS390XState *env, uint8_t *mem_buf, int n)
+static int cpu_read_vreg(CPUS390XState *env, GByteArray *buf, int n)
 {
     int ret;
 
     switch (n) {
     case S390_V0L_REGNUM ... S390_V15L_REGNUM:
-        ret = gdb_get_reg64(mem_buf, env->vregs[n][1]);
+        ret = gdb_get_reg64(buf, env->vregs[n][1]);
         break;
     case S390_V16_REGNUM ... S390_V31_REGNUM:
-        ret = gdb_get_reg64(mem_buf, env->vregs[n][0]);
-        ret += gdb_get_reg64(mem_buf + 8, env->vregs[n][1]);
+        ret = gdb_get_reg64(buf, env->vregs[n][0]);
+        ret += gdb_get_reg64(buf, env->vregs[n][1]);
         break;
     default:
         ret = 0;
@@ -186,11 +186,11 @@ static int cpu_write_vreg(CPUS390XState *env, uint8_t *mem_buf, int n)
 #define S390_NUM_C_REGS 16
 
 #ifndef CONFIG_USER_ONLY
-static int cpu_read_c_reg(CPUS390XState *env, uint8_t *mem_buf, int n)
+static int cpu_read_c_reg(CPUS390XState *env, GByteArray *buf, int n)
 {
     switch (n) {
     case S390_C0_REGNUM ... S390_C15_REGNUM:
-        return gdb_get_regl(mem_buf, env->cregs[n]);
+        return gdb_get_regl(buf, env->cregs[n]);
     default:
         return 0;
     }
@@ -223,7 +223,7 @@ static int cpu_write_c_reg(CPUS390XState *env, uint8_t *mem_buf, int n)
 /* total number of registers in s390-virt.xml */
 #define S390_NUM_VIRT_REGS 8
 
-static int cpu_read_virt_reg(CPUS390XState *env, uint8_t *mem_buf, int n)
+static int cpu_read_virt_reg(CPUS390XState *env, GByteArray *mem_buf, int n)
 {
     switch (n) {
     case S390_VIRT_CKC_REGNUM:
@@ -296,9 +296,9 @@ static int cpu_write_virt_reg(CPUS390XState *env, uint8_t *mem_buf, int n)
 /* total number of registers in s390-gs.xml */
 #define S390_NUM_GS_REGS 4
 
-static int cpu_read_gs_reg(CPUS390XState *env, uint8_t *mem_buf, int n)
+static int cpu_read_gs_reg(CPUS390XState *env, GByteArray *buf, int n)
 {
-    return gdb_get_regl(mem_buf, env->gscb[n]);
+    return gdb_get_regl(buf, env->gscb[n]);
 }
 
 static int cpu_write_gs_reg(CPUS390XState *env, uint8_t *mem_buf, int n)
diff --git a/target/sh4/gdbstub.c b/target/sh4/gdbstub.c
index 44c1679e9db..49fc4a0cc69 100644
--- a/target/sh4/gdbstub.c
+++ b/target/sh4/gdbstub.c
@@ -24,7 +24,7 @@
 /* Hint: Use "set architecture sh4" in GDB to see fpu registers */
 /* FIXME: We should use XML for this.  */
 
-int superh_cpu_gdb_read_register(CPUState *cs, uint8_t *mem_buf, int n)
+int superh_cpu_gdb_read_register(CPUState *cs, GByteArray *mem_buf, int n)
 {
     SuperHCPU *cpu = SUPERH_CPU(cs);
     CPUSH4State *env = &cpu->env;
diff --git a/target/sparc/gdbstub.c b/target/sparc/gdbstub.c
index 8be742b5a3d..78dc8dcc980 100644
--- a/target/sparc/gdbstub.c
+++ b/target/sparc/gdbstub.c
@@ -27,7 +27,7 @@
 #define gdb_get_rega(buf, val) gdb_get_regl(buf, val)
 #endif
 
-int sparc_cpu_gdb_read_register(CPUState *cs, uint8_t *mem_buf, int n)
+int sparc_cpu_gdb_read_register(CPUState *cs, GByteArray *mem_buf, int n)
 {
     SPARCCPU *cpu = SPARC_CPU(cs);
     CPUSPARCState *env = &cpu->env;
diff --git a/target/xtensa/gdbstub.c b/target/xtensa/gdbstub.c
index 54727881f38..0ee3feabe54 100644
--- a/target/xtensa/gdbstub.c
+++ b/target/xtensa/gdbstub.c
@@ -63,7 +63,7 @@ void xtensa_count_regs(const XtensaConfig *config,
     }
 }
 
-int xtensa_cpu_gdb_read_register(CPUState *cs, uint8_t *mem_buf, int n)
+int xtensa_cpu_gdb_read_register(CPUState *cs, GByteArray *mem_buf, int n)
 {
     XtensaCPU *cpu = XTENSA_CPU(cs);
     CPUXtensaState *env = &cpu->env;
-- 
2.20.1


