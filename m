Return-Path: <SRS0=QAbx=Z6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EDE5C43603
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Dec 2019 18:52:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5F2B3205F4
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Dec 2019 18:52:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mv+ucCPY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F2B3205F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60838 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ie1fg-0000Jb-Gm
	for qemu-devel@archiver.kernel.org; Sun, 08 Dec 2019 13:52:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37499)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mrolnik@gmail.com>) id 1ie1Tn-0002Eg-Aq
 for qemu-devel@nongnu.org; Sun, 08 Dec 2019 13:40:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mrolnik@gmail.com>) id 1ie1Tc-00038A-Ni
 for qemu-devel@nongnu.org; Sun, 08 Dec 2019 13:40:21 -0500
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c]:46092)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <mrolnik@gmail.com>) id 1ie1Tc-00035L-7W
 for qemu-devel@nongnu.org; Sun, 08 Dec 2019 13:40:16 -0500
Received: by mail-wr1-x42c.google.com with SMTP id z7so13437122wrl.13
 for <qemu-devel@nongnu.org>; Sun, 08 Dec 2019 10:40:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=oqKi5HzJkp77MgZPrC41hLc2L4061rWL1MLVHU1rrJE=;
 b=Mv+ucCPYRVLrDYgdnXH9ahKmc+KSNSIpyvcU6ql1c6h5yeE4M82nNRctHyk78gfWbp
 ti/6EQUEm+1kpV/beKwfOsl1w8Mpke1wpFp91W8RnT6fzumlfcNbTN/f93hEAxOyUKV4
 mnuxkPMiKb1Aqx2iED9tXD2BFC4PITzUiO5z4TEJSVYV0zGo5s8yzcsdHkIyAETJhYLZ
 Mlwg0mTWtvVXbl5OaSHROS1oPp76absMek2/7xOLi5OGoumYh/Wwq4/RvJw8l33SbGw/
 QuJapgCCygneE1Wb8b+s4HvFYeePYFdtT/k8Bw64v/ZxOHINx0e4UmBedNH0zOihGXLC
 D6SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=oqKi5HzJkp77MgZPrC41hLc2L4061rWL1MLVHU1rrJE=;
 b=BXH6Ge6XG2tO+ReYJt97J/2y+MzLJAlBWUJ7NNRokigkGW/Y5N6tCIbwGyvJ7eeHOY
 CC/KK2/7mLuIf5IsQ5gqI/4vtJXKQBitbqXusmv/e1bBxgowOJa/EghgrNvRRbAAy0UY
 BUCRa64jnjgXDz9NWRzfzm6bAVcRdQZYrxDUv2S1D6Q7eqVpXl8r8gBnNZpdebRzHLsd
 H+AB8d0o8fy8VBSZl8zqnWSI6X4f3gHJ6aTO86yruhRDmvAxXW/F56dhJvXjM+W+6FZ2
 bAeSjB5L9XnJZyvkSUxp74sdraLhUcAZN+5wRnNaS9WT2fCdhUirl5ftNtrIaEaLYUIJ
 T8bA==
X-Gm-Message-State: APjAAAVHS/NHbVJEdpNBth90MQLKShxJlVe56EkHxJTV0LtZIEJ49A65
 i5ZRpYvQHB1K6ZUicKxk2CPRKev2bJHmEiZa
X-Google-Smtp-Source: APXvYqz6GAPmBlG5K7Q2NJAjKcespBxuz3wwQCCVZyrnlimTUGBkqJiXH+a7DRon2IkRxGaArNLGAw==
X-Received: by 2002:adf:e74a:: with SMTP id c10mr25916382wrn.386.1575830413557; 
 Sun, 08 Dec 2019 10:40:13 -0800 (PST)
Received: from 8c859074c0ff.ant.amazon.com.com
 (bzq-79-180-52-3.red.bezeqint.net. [79.180.52.3])
 by smtp.gmail.com with ESMTPSA id h17sm25289717wrs.18.2019.12.08.10.40.12
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Sun, 08 Dec 2019 10:40:13 -0800 (PST)
From: Michael Rolnik <mrolnik@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v38 11/22] target/avr: Add instruction disassembly function
Date: Sun,  8 Dec 2019 20:39:11 +0200
Message-Id: <20191208183922.13757-12-mrolnik@gmail.com>
X-Mailer: git-send-email 2.17.2 (Apple Git-113)
In-Reply-To: <20191208183922.13757-1-mrolnik@gmail.com>
References: <20191208183922.13757-1-mrolnik@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::42c
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
Cc: thuth@redhat.com, Michael Rolnik <mrolnik@gmail.com>,
 me@xcancerberox.com.ar, richard.henderson@linaro.org, dovgaluk@ispras.ru,
 imammedo@redhat.com, philmd@redhat.com, aleksandar.m.mail@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Provide function disassembles executed instruction when `-d in_asm` is
provided

Example:
`./avr-softmmu/qemu-system-avr -bios free-rtos/Demo/AVR_ATMega2560_GCC/demo.elf -d in_asm` will produce something like the following

```
    ...
    IN:
    0x0000014a:  CALL      0x3808

    IN: main
    0x00003808:  CALL      0x4b4

    IN: vParTestInitialise
    0x000004b4:  LDI       r24, 255
    0x000004b6:  STS       r24, 0
    0x000004b8:  MULS      r16, r20
    0x000004ba:  OUT       $1, r24
    0x000004bc:  LDS       r24, 0
    0x000004be:  MULS      r16, r20
    0x000004c0:  OUT       $2, r24
    0x000004c2:  RET
    ...
```

Signed-off-by: Michael Rolnik <mrolnik@gmail.com>
Suggested-by: Richard Henderson <richard.henderson@linaro.org>
Suggested-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Suggested-by: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 target/avr/cpu.h       |   1 +
 target/avr/cpu.c       |   2 +-
 target/avr/disas.c     | 226 +++++++++++++++++++++++++++++++++++++++++
 target/avr/translate.c |  11 ++
 4 files changed, 239 insertions(+), 1 deletion(-)
 create mode 100644 target/avr/disas.c

diff --git a/target/avr/cpu.h b/target/avr/cpu.h
index c217eefeb4..a8a3e7ade6 100644
--- a/target/avr/cpu.h
+++ b/target/avr/cpu.h
@@ -178,6 +178,7 @@ bool avr_cpu_exec_interrupt(CPUState *cpu, int int_req);
 hwaddr avr_cpu_get_phys_page_debug(CPUState *cpu, vaddr addr);
 int avr_cpu_gdb_read_register(CPUState *cpu, uint8_t *buf, int reg);
 int avr_cpu_gdb_write_register(CPUState *cpu, uint8_t *buf, int reg);
+int avr_print_insn(bfd_vma addr, disassemble_info *info);
 
 static inline int avr_feature(CPUAVRState *env, int feature)
 {
diff --git a/target/avr/cpu.c b/target/avr/cpu.c
index c5cafcae3c..be4b921e4d 100644
--- a/target/avr/cpu.c
+++ b/target/avr/cpu.c
@@ -83,7 +83,7 @@ static void avr_cpu_reset(CPUState *cs)
 static void avr_cpu_disas_set_info(CPUState *cpu, disassemble_info *info)
 {
     info->mach = bfd_arch_avr;
-    info->print_insn = NULL;
+    info->print_insn = avr_print_insn;
 }
 
 static void avr_cpu_realizefn(DeviceState *dev, Error **errp)
diff --git a/target/avr/disas.c b/target/avr/disas.c
new file mode 100644
index 0000000000..22863d2eb1
--- /dev/null
+++ b/target/avr/disas.c
@@ -0,0 +1,226 @@
+/*
+ * AVR disassembler
+ *
+ * Copyright (c) 2019 Richard Henderson <rth@twiddle.net>
+ * Copyright (c) 2019 Michael Rolnik <mrolnik@gmail.com>
+ *
+ * This program is free software: you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation, either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program.  If not, see <http://www.gnu.org/licenses/>.
+ */
+
+#include "qemu/osdep.h"
+#include "cpu.h"
+
+typedef struct {
+    disassemble_info *info;
+    uint16_t next_word;
+    bool next_word_used;
+} DisasContext;
+
+static int to_regs_16_31_by_one(DisasContext *ctx, int indx)
+{
+    return 16 + (indx % 16);
+}
+
+static int to_regs_16_23_by_one(DisasContext *ctx, int indx)
+{
+    return 16 + (indx % 8);
+}
+static int to_regs_24_30_by_two(DisasContext *ctx, int indx)
+{
+    return 24 + (indx % 4) * 2;
+}
+static int to_regs_00_30_by_two(DisasContext *ctx, int indx)
+{
+    return (indx % 16) * 2;
+}
+
+static uint16_t next_word(DisasContext *ctx)
+{
+    ctx->next_word_used = true;
+    return ctx->next_word;
+}
+
+static int append_16(DisasContext *ctx, int x)
+{
+    return x << 16 | next_word(ctx);
+}
+
+
+/* Include the auto-generated decoder.  */
+static bool decode_insn(DisasContext *ctx, uint16_t insn);
+#include "decode_insn.inc.c"
+
+#define output(mnemonic, format, ...) \
+    (pctx->info->fprintf_func(pctx->info->stream, "%-9s " format, \
+                        mnemonic, ##__VA_ARGS__))
+
+int avr_print_insn(bfd_vma addr, disassemble_info *info)
+{
+    DisasContext ctx;
+    DisasContext *pctx = &ctx;
+    bfd_byte buffer[4];
+    uint16_t insn;
+    int status;
+
+    ctx.info = info;
+
+    status = info->read_memory_func(addr, buffer, 4, info);
+    if (status != 0) {
+        info->memory_error_func(status, addr, info);
+        return -1;
+    }
+    insn = bfd_getl16(buffer);
+    ctx.next_word = bfd_getl16(buffer + 2);
+    ctx.next_word_used = false;
+
+    if (!decode_insn(&ctx, insn)) {
+        output(".db", "0x%02x, 0x%02x", buffer[0], buffer[1]);
+    }
+
+    return ctx.next_word_used ? 4 : 2;
+}
+
+
+#define INSN(opcode, format, ...)                                       \
+static bool trans_##opcode(DisasContext *pctx, arg_##opcode * a)        \
+{                                                                       \
+    output(#opcode, format, ##__VA_ARGS__);                             \
+    return true;                                                        \
+}
+
+#define INSN_MNEMONIC(opcode, mnemonic, format, ...)                    \
+static bool trans_##opcode(DisasContext *pctx, arg_##opcode * a)        \
+{                                                                       \
+    output(mnemonic, format, ##__VA_ARGS__);                            \
+    return true;                                                        \
+}
+
+/*
+ *   C       Z       N       V       S       H       T       I
+ *   0       1       2       3       4       5       6       7
+ */
+static const char *brbc[] = {
+    "BRCC", "BRNE", "BRPL", "BRVC", "BRGE", "BRHC", "BRTC", "BRID"
+};
+
+static const char *brbs[] = {
+    "BRCS", "BREQ", "BRMI", "BRVS", "BRLT", "BRHS", "BRTS", "BRIE"
+};
+
+static const char *bset[] = {
+    "SEC",  "SEZ",  "SEN",  "SEZ",  "SES",  "SEH",  "SET",  "SEI"
+};
+
+static const char *bclr[] = {
+    "CLC",  "CLZ",  "CLN",  "CLZ",  "CLS",  "CLH",  "CLT",  "CLI"
+};
+
+INSN(ADC,    "r%d, r%d", a->rd, a->rr)
+INSN(ADD,    "r%d, r%d", a->rd, a->rr)
+INSN(ADIW,   "r%d:r%d, %d", a->rd + 1, a->rd, a->imm)
+INSN(AND,    "r%d, r%d", a->rd, a->rr)
+INSN(ANDI,   "r%d, %d", a->rd, a->imm)
+INSN(ASR,    "r%d", a->rd)
+INSN_MNEMONIC(BCLR,  bclr[a->bit], "")
+INSN(BLD,    "r%d, %d", a->rd, a->bit)
+INSN_MNEMONIC(BRBC,  brbc[a->bit], ".%+d", a->imm * 2)
+INSN_MNEMONIC(BRBS,  brbs[a->bit], ".%+d", a->imm * 2)
+INSN(BREAK,  "")
+INSN_MNEMONIC(BSET,  bset[a->bit], "")
+INSN(BST,    "r%d, %d", a->rd, a->bit)
+INSN(CALL,   "0x%x", a->imm * 2)
+INSN(CBI,    "%d, %d", a->reg, a->bit)
+INSN(COM,    "r%d", a->rd)
+INSN(CP,     "r%d, r%d", a->rd, a->rr)
+INSN(CPC,    "r%d, r%d", a->rd, a->rr)
+INSN(CPI,    "r%d, %d", a->rd, a->imm)
+INSN(CPSE,   "r%d, r%d", a->rd, a->rr)
+INSN(DEC,    "r%d", a->rd)
+INSN(DES,    "%d", a->imm)
+INSN(EICALL, "")
+INSN(EIJMP,  "")
+INSN(ELPM1,  "")
+INSN(ELPM2,  "r%d, Z", a->rd)
+INSN(ELPMX,  "r%d, Z+", a->rd)
+INSN(EOR,    "r%d, r%d", a->rd, a->rr)
+INSN(FMUL,   "r%d, r%d", a->rd, a->rr)
+INSN(FMULS,  "r%d, r%d", a->rd, a->rr)
+INSN(FMULSU, "r%d, r%d", a->rd, a->rr)
+INSN(ICALL,  "")
+INSN(IJMP,   "")
+INSN(IN,     "r%d, $%d", a->rd, a->imm)
+INSN(INC,    "r%d", a->rd)
+INSN(JMP,    "0x%x", a->imm * 2)
+INSN(LAC,    "Z, r%d", a->rd)
+INSN(LAS,    "Z, r%d", a->rd)
+INSN(LAT,    "Z, r%d", a->rd)
+INSN(LDDY,   "r%d, Y+%d", a->rd, a->imm)
+INSN(LDDZ,   "r%d, Z+%d", a->rd, a->imm)
+INSN(LDI,    "r%d, %d", a->rd, a->imm)
+INSN(LDS,    "r%d, %d", a->rd, a->imm)
+INSN(LDX1,   "r%d, X", a->rd)
+INSN(LDX2,   "r%d, X+", a->rd)
+INSN(LDX3,   "r%d, -X", a->rd)
+INSN(LDY2,   "r%d, Y+", a->rd)
+INSN(LDY3,   "r%d, -Y", a->rd)
+INSN(LDZ2,   "r%d, Z+", a->rd)
+INSN(LDZ3,   "r%d, -Z", a->rd)
+INSN(LPM1,   "")
+INSN(LPM2,   "r%d, Z", a->rd)
+INSN(LPMX,   "r%d, Z+", a->rd)
+INSN(LSR,    "r%d", a->rd)
+INSN(MOV,    "r%d, r%d", a->rd, a->rr)
+INSN(MOVW,   "r%d:r%d, r%d,r:r%d", a->rd + 1, a->rd, a->rr + 1, a->rr)
+INSN(MUL,    "r%d, r%d", a->rd, a->rr)
+INSN(MULS,   "r%d, r%d", a->rd, a->rr)
+INSN(MULSU,  "r%d, r%d", a->rd, a->rr)
+INSN(NEG,    "r%d", a->rd)
+INSN(NOP,    "")
+INSN(OR,     "r%d, r%d", a->rd, a->rr)
+INSN(ORI,    "r%d, %d", a->rd, a->imm)
+INSN(OUT,    "$%d, r%d", a->imm, a->rd)
+INSN(POP,    "r%d", a->rd)
+INSN(PUSH,   "r%d", a->rd)
+INSN(RCALL,  ".%+d", a->imm * 2)
+INSN(RET,    "")
+INSN(RETI,   "")
+INSN(RJMP,   ".%+d", a->imm * 2)
+INSN(ROR,    "r%d", a->rd)
+INSN(SBC,    "r%d, r%d", a->rd, a->rr)
+INSN(SBCI,   "r%d, %d", a->rd, a->imm)
+INSN(SBI,    "$%d, %d", a->reg, a->bit)
+INSN(SBIC,   "$%d, %d", a->reg, a->bit)
+INSN(SBIS,   "$%d, %d", a->reg, a->bit)
+INSN(SBIW,   "r%d:r%d, %d", a->rd + 1, a->rd, a->imm)
+INSN(SBRC,   "r%d, %d", a->rr, a->bit)
+INSN(SBRS,   "r%d, %d", a->rr, a->bit)
+INSN(SLEEP,  "")
+INSN(SPM,    "")
+INSN(SPMX,   "Z+")
+INSN(STDY,   "r%d, Y+%d", a->rd, a->imm)
+INSN(STDZ,   "r%d, Z+%d", a->rd, a->imm)
+INSN(STS,    "r%d, %d", a->rd, a->imm)
+INSN(STX1,   "r%d, X", a->rr)
+INSN(STX2,   "r%d, X+", a->rr)
+INSN(STX3,   "r%d, -X", a->rr)
+INSN(STY2,   "r%d, Y+", a->rd)
+INSN(STY3,   "r%d, -Y", a->rd)
+INSN(STZ2,   "r%d, Z+", a->rd)
+INSN(STZ3,   "r%d, -Z", a->rd)
+INSN(SUB,    "r%d, r%d", a->rd, a->rr)
+INSN(SUBI,   "r%d, %d", a->rd, a->imm)
+INSN(SWAP,   "r%d", a->rd)
+INSN(WDR,    "")
+INSN(XCH,    "Z, r%d", a->rd)
+
diff --git a/target/avr/translate.c b/target/avr/translate.c
index c8c6f798bf..a621195817 100644
--- a/target/avr/translate.c
+++ b/target/avr/translate.c
@@ -2917,6 +2917,17 @@ done_generating:
 
     tb->size = (ctx.npc - pc_start) * 2;
     tb->icount = num_insns;
+
+#ifdef DEBUG_DISAS
+    if (qemu_loglevel_mask(CPU_LOG_TB_IN_ASM)
+        && qemu_log_in_addr_range(tb->pc)) {
+        qemu_log_lock();
+        qemu_log("IN: %s\n", lookup_symbol(tb->pc));
+        log_target_disas(cs, tb->pc, tb->size);
+        qemu_log("\n");
+        qemu_log_unlock();
+    }
+#endif
 }
 
 void restore_state_to_opc(CPUAVRState *env, TranslationBlock *tb,
-- 
2.17.2 (Apple Git-113)


