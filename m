Return-Path: <SRS0=mO9Z=3M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50DE1C32771
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 00:10:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 065E52465B
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 00:10:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JloFcK/T"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 065E52465B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48704 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iuQ4p-0007Sd-0d
	for qemu-devel@archiver.kernel.org; Wed, 22 Jan 2020 19:10:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:54571)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iuPzB-00027b-KF
 for qemu-devel@nongnu.org; Wed, 22 Jan 2020 19:04:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iuPz3-0001yl-5W
 for qemu-devel@nongnu.org; Wed, 22 Jan 2020 19:04:36 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:34045)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iuPz2-0001xp-Pu
 for qemu-devel@nongnu.org; Wed, 22 Jan 2020 19:04:29 -0500
Received: by mail-pl1-f193.google.com with SMTP id c9so532544plo.1
 for <qemu-devel@nongnu.org>; Wed, 22 Jan 2020 16:04:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=ZS6nFisvm4sAX3GPDQFOuqE4SLBqqkCg/uc+tbhZikg=;
 b=JloFcK/THtpzC8Jl/7TS19N3AppqLiDH4f7zz9i4IHC9BXU78jhtquJ4ZBD+BwUF2q
 c1XAdhHDMH+hThz4+P5q7KrSG2r+xaPE37tp0xQ3VB6Vuj2vpSXzVPwx+SKFTvgpMxWr
 iTJnrU9DEH+wEI7GmX8qv2vujvJY5uswWh6jEFq7qJafHGDDdmvsxsoXJc3TWAe5yH6Y
 9LZ88DAcasiX/DaNGu7CqiYaBnIL50HdGTOHm+pCk7TgYsT+O273zBDJfnjzrX9FNuQ6
 RME4KFYsPKDO9XUpz9aRGw1W2m2dgu/k2rXjRUO2fNxzX3bz/AU2lomAYRgsMA39Gclv
 hpPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=ZS6nFisvm4sAX3GPDQFOuqE4SLBqqkCg/uc+tbhZikg=;
 b=D8fJ5i+Oz2ALOHy/MwrIghks+1zBTUGCVAVtwCpbvbD+zp1DI03IRu5zYSSk0HJntQ
 s7asyWNUK3aTMMSOrjf4kz/MyXoX5j0nuqQH9wPoTn6/TWXyqST9KcWultoag6UgEySy
 EWYlTUHLMCLeTsNIakjNJ4tLlMdRDaf+t06QW18pMtEa5LiSvyuQRSBkM1jcgyDY2qsh
 8JPC4fPxFckneSqQDr9KOYlLRiqrs0VZeULu/Hx3gmh9ukWGyKGC7ADsOQGSxaEQzLA9
 I9jfTHKbyx8AHd3ZahUjBXTb+4YsTic3KDBa9Nc3OdbyglejkogejUu+UOzbs87MrT1X
 /n2Q==
X-Gm-Message-State: APjAAAXj6F9SENxpP7qe5p2dbtq8AwMJrTOvBIJSr2Do6yDtn4ZzKxr0
 f4/nek1H4gpfD9+rQ1vJ6G933vDqilo=
X-Google-Smtp-Source: APXvYqxfuEnfjf84tzqNTBgA8Wxd+K4y/7EmlRgE4dyNHLDvGnlNNkvUI9WaoG7A7mR5s9VmapSfUQ==
X-Received: by 2002:a17:90a:8685:: with SMTP id
 p5mr1270173pjn.92.1579737805580; 
 Wed, 22 Jan 2020 16:03:25 -0800 (PST)
Received: from localhost.localdomain (rrcs-173-198-77-92.west.biz.rr.com.
 [173.198.77.92])
 by smtp.gmail.com with ESMTPSA id b21sm84521pfp.0.2020.01.22.16.03.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Jan 2020 16:03:24 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH rc1 06/24] target/avr: Add instruction translation - Data
 Transfer Instructions
Date: Wed, 22 Jan 2020 14:02:49 -1000
Message-Id: <20200123000307.11541-7-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200123000307.11541-1-richard.henderson@linaro.org>
References: <20200123000307.11541-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.214.193
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
    - MOV, MOVW
    - LDI, LDS LDX LDY LDZ
    - LDDY, LDDZ
    - STS, STX STY STZ
    - STDY, STDZ
    - LPM, LPMX
    - ELPM, ELPMX
    - SPM, SPMX
    - IN, OUT
    - PUSH, POP
    - XCH
    - LAS, LAC LAT

Signed-off-by: Michael Rolnik <mrolnik@gmail.com>
Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Message-Id: <20200118191416.19934-7-mrolnik@gmail.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/avr/translate.c | 987 +++++++++++++++++++++++++++++++++++++++++
 target/avr/insn.decode |  43 ++
 2 files changed, 1030 insertions(+)

diff --git a/target/avr/translate.c b/target/avr/translate.c
index 3d4005740a..4a62d9312a 100644
--- a/target/avr/translate.c
+++ b/target/avr/translate.c
@@ -1453,3 +1453,990 @@ static bool trans_BRBS(DisasContext *ctx, arg_BRBS *a)
     ctx->bstate = DISAS_CHAIN;
     return true;
 }
+
+/*
+ * Data Transfer Instructions
+ */
+
+/*
+ *  in the gen_set_addr & gen_get_addr functions
+ *  H assumed to be in 0x00ff0000 format
+ *  M assumed to be in 0x000000ff format
+ *  L assumed to be in 0x000000ff format
+ */
+static void gen_set_addr(TCGv addr, TCGv H, TCGv M, TCGv L)
+{
+
+    tcg_gen_andi_tl(L, addr, 0x000000ff);
+
+    tcg_gen_andi_tl(M, addr, 0x0000ff00);
+    tcg_gen_shri_tl(M, M, 8);
+
+    tcg_gen_andi_tl(H, addr, 0x00ff0000);
+}
+
+static void gen_set_xaddr(TCGv addr)
+{
+    gen_set_addr(addr, cpu_rampX, cpu_r[27], cpu_r[26]);
+}
+
+static void gen_set_yaddr(TCGv addr)
+{
+    gen_set_addr(addr, cpu_rampY, cpu_r[29], cpu_r[28]);
+}
+
+static void gen_set_zaddr(TCGv addr)
+{
+    gen_set_addr(addr, cpu_rampZ, cpu_r[31], cpu_r[30]);
+}
+
+static TCGv gen_get_addr(TCGv H, TCGv M, TCGv L)
+{
+    TCGv addr = tcg_temp_new_i32();
+
+    tcg_gen_deposit_tl(addr, M, H, 8, 8);
+    tcg_gen_deposit_tl(addr, L, addr, 8, 16);
+
+    return addr;
+}
+
+static TCGv gen_get_xaddr(void)
+{
+    return gen_get_addr(cpu_rampX, cpu_r[27], cpu_r[26]);
+}
+
+static TCGv gen_get_yaddr(void)
+{
+    return gen_get_addr(cpu_rampY, cpu_r[29], cpu_r[28]);
+}
+
+static TCGv gen_get_zaddr(void)
+{
+    return gen_get_addr(cpu_rampZ, cpu_r[31], cpu_r[30]);
+}
+
+/*
+ *  Load one byte indirect from data space to register and stores an clear
+ *  the bits in data space specified by the register. The instruction can only
+ *  be used towards internal SRAM.  The data location is pointed to by the Z (16
+ *  bits) Pointer Register in the Register File. Memory access is limited to the
+ *  current data segment of 64KB. To access another data segment in devices with
+ *  more than 64KB data space, the RAMPZ in register in the I/O area has to be
+ *  changed.  The Z-pointer Register is left unchanged by the operation. This
+ *  instruction is especially suited for clearing status bits stored in SRAM.
+ */
+static void gen_data_store(DisasContext *ctx, TCGv data, TCGv addr)
+{
+    if (ctx->tb->flags & TB_FLAGS_FULL_ACCESS) {
+        gen_helper_fullwr(cpu_env, data, addr);
+    } else {
+        tcg_gen_qemu_st8(data, addr, MMU_DATA_IDX); /* mem[addr] = data */
+    }
+}
+
+static void gen_data_load(DisasContext *ctx, TCGv data, TCGv addr)
+{
+    if (ctx->tb->flags & TB_FLAGS_FULL_ACCESS) {
+        gen_helper_fullrd(data, cpu_env, addr);
+    } else {
+        tcg_gen_qemu_ld8u(data, addr, MMU_DATA_IDX); /* data = mem[addr] */
+    }
+}
+
+/*
+ *  This instruction makes a copy of one register into another. The source
+ *  register Rr is left unchanged, while the destination register Rd is loaded
+ *  with a copy of Rr.
+ */
+static bool trans_MOV(DisasContext *ctx, arg_MOV *a)
+{
+    TCGv Rd = cpu_r[a->rd];
+    TCGv Rr = cpu_r[a->rr];
+
+    tcg_gen_mov_tl(Rd, Rr);
+
+    return true;
+}
+
+/*
+ *  This instruction makes a copy of one register pair into another register
+ *  pair. The source register pair Rr+1:Rr is left unchanged, while the
+ *  destination register pair Rd+1:Rd is loaded with a copy of Rr + 1:Rr.  This
+ *  instruction is not available in all devices. Refer to the device specific
+ *  instruction set summary.
+ */
+static bool trans_MOVW(DisasContext *ctx, arg_MOVW *a)
+{
+    if (!avr_have_feature(ctx, AVR_FEATURE_MOVW)) {
+        return true;
+    }
+
+    TCGv RdL = cpu_r[a->rd];
+    TCGv RdH = cpu_r[a->rd + 1];
+    TCGv RrL = cpu_r[a->rr];
+    TCGv RrH = cpu_r[a->rr + 1];
+
+    tcg_gen_mov_tl(RdH, RrH);
+    tcg_gen_mov_tl(RdL, RrL);
+
+    return true;
+}
+
+/*
+ * Loads an 8 bit constant directly to register 16 to 31.
+ */
+static bool trans_LDI(DisasContext *ctx, arg_LDI *a)
+{
+    TCGv Rd = cpu_r[a->rd];
+    int imm = a->imm;
+
+    tcg_gen_movi_tl(Rd, imm);
+
+    return true;
+}
+
+/*
+ *  Loads one byte from the data space to a register. For parts with SRAM,
+ *  the data space consists of the Register File, I/O memory and internal SRAM
+ *  (and external SRAM if applicable). For parts without SRAM, the data space
+ *  consists of the register file only. The EEPROM has a separate address space.
+ *  A 16-bit address must be supplied. Memory access is limited to the current
+ *  data segment of 64KB. The LDS instruction uses the RAMPD Register to access
+ *  memory above 64KB. To access another data segment in devices with more than
+ *  64KB data space, the RAMPD in register in the I/O area has to be changed.
+ *  This instruction is not available in all devices. Refer to the device
+ *  specific instruction set summary.
+ */
+static bool trans_LDS(DisasContext *ctx, arg_LDS *a)
+{
+    TCGv Rd = cpu_r[a->rd];
+    TCGv addr = tcg_temp_new_i32();
+    TCGv H = cpu_rampD;
+    a->imm = next_word(ctx);
+
+    tcg_gen_mov_tl(addr, H); /* addr = H:M:L */
+    tcg_gen_shli_tl(addr, addr, 16);
+    tcg_gen_ori_tl(addr, addr, a->imm);
+
+    gen_data_load(ctx, Rd, addr);
+
+    tcg_temp_free_i32(addr);
+
+    return true;
+}
+
+/*
+ *  Loads one byte indirect from the data space to a register. For parts
+ *  with SRAM, the data space consists of the Register File, I/O memory and
+ *  internal SRAM (and external SRAM if applicable). For parts without SRAM, the
+ *  data space consists of the Register File only. In some parts the Flash
+ *  Memory has been mapped to the data space and can be read using this command.
+ *  The EEPROM has a separate address space.  The data location is pointed to by
+ *  the X (16 bits) Pointer Register in the Register File. Memory access is
+ *  limited to the current data segment of 64KB. To access another data segment
+ *  in devices with more than 64KB data space, the RAMPX in register in the I/O
+ *  area has to be changed.  The X-pointer Register can either be left unchanged
+ *  by the operation, or it can be post-incremented or predecremented.  These
+ *  features are especially suited for accessing arrays, tables, and Stack
+ *  Pointer usage of the X-pointer Register. Note that only the low byte of the
+ *  X-pointer is updated in devices with no more than 256 bytes data space. For
+ *  such devices, the high byte of the pointer is not used by this instruction
+ *  and can be used for other purposes. The RAMPX Register in the I/O area is
+ *  updated in parts with more than 64KB data space or more than 64KB Program
+ *  memory, and the increment/decrement is added to the entire 24-bit address on
+ *  such devices.  Not all variants of this instruction is available in all
+ *  devices. Refer to the device specific instruction set summary.  In the
+ *  Reduced Core tinyAVR the LD instruction can be used to achieve the same
+ *  operation as LPM since the program memory is mapped to the data memory
+ *  space.
+ */
+static bool trans_LDX1(DisasContext *ctx, arg_LDX1 *a)
+{
+    TCGv Rd = cpu_r[a->rd];
+    TCGv addr = gen_get_xaddr();
+
+    gen_data_load(ctx, Rd, addr);
+
+    tcg_temp_free_i32(addr);
+
+    return true;
+}
+
+static bool trans_LDX2(DisasContext *ctx, arg_LDX2 *a)
+{
+    TCGv Rd = cpu_r[a->rd];
+    TCGv addr = gen_get_xaddr();
+
+    gen_data_load(ctx, Rd, addr);
+    tcg_gen_addi_tl(addr, addr, 1); /* addr = addr + 1 */
+
+    gen_set_xaddr(addr);
+
+    tcg_temp_free_i32(addr);
+
+    return true;
+}
+
+static bool trans_LDX3(DisasContext *ctx, arg_LDX3 *a)
+{
+    TCGv Rd = cpu_r[a->rd];
+    TCGv addr = gen_get_xaddr();
+
+    tcg_gen_subi_tl(addr, addr, 1); /* addr = addr - 1 */
+    gen_data_load(ctx, Rd, addr);
+    gen_set_xaddr(addr);
+
+    tcg_temp_free_i32(addr);
+
+    return true;
+}
+
+/*
+ *  Loads one byte indirect with or without displacement from the data space
+ *  to a register. For parts with SRAM, the data space consists of the Register
+ *  File, I/O memory and internal SRAM (and external SRAM if applicable). For
+ *  parts without SRAM, the data space consists of the Register File only. In
+ *  some parts the Flash Memory has been mapped to the data space and can be
+ *  read using this command. The EEPROM has a separate address space.  The data
+ *  location is pointed to by the Y (16 bits) Pointer Register in the Register
+ *  File. Memory access is limited to the current data segment of 64KB. To
+ *  access another data segment in devices with more than 64KB data space, the
+ *  RAMPY in register in the I/O area has to be changed.  The Y-pointer Register
+ *  can either be left unchanged by the operation, or it can be post-incremented
+ *  or predecremented.  These features are especially suited for accessing
+ *  arrays, tables, and Stack Pointer usage of the Y-pointer Register. Note that
+ *  only the low byte of the Y-pointer is updated in devices with no more than
+ *  256 bytes data space. For such devices, the high byte of the pointer is not
+ *  used by this instruction and can be used for other purposes. The RAMPY
+ *  Register in the I/O area is updated in parts with more than 64KB data space
+ *  or more than 64KB Program memory, and the increment/decrement/displacement
+ *  is added to the entire 24-bit address on such devices.  Not all variants of
+ *  this instruction is available in all devices. Refer to the device specific
+ *  instruction set summary.  In the Reduced Core tinyAVR the LD instruction can
+ *  be used to achieve the same operation as LPM since the program memory is
+ *  mapped to the data memory space.
+ */
+static bool trans_LDY2(DisasContext *ctx, arg_LDY2 *a)
+{
+    TCGv Rd = cpu_r[a->rd];
+    TCGv addr = gen_get_yaddr();
+
+    gen_data_load(ctx, Rd, addr);
+    tcg_gen_addi_tl(addr, addr, 1); /* addr = addr + 1 */
+
+    gen_set_yaddr(addr);
+
+    tcg_temp_free_i32(addr);
+
+    return true;
+}
+
+static bool trans_LDY3(DisasContext *ctx, arg_LDY3 *a)
+{
+    TCGv Rd = cpu_r[a->rd];
+    TCGv addr = gen_get_yaddr();
+
+    tcg_gen_subi_tl(addr, addr, 1); /* addr = addr - 1 */
+    gen_data_load(ctx, Rd, addr);
+    gen_set_yaddr(addr);
+
+    tcg_temp_free_i32(addr);
+
+    return true;
+}
+
+static bool trans_LDDY(DisasContext *ctx, arg_LDDY *a)
+{
+    TCGv Rd = cpu_r[a->rd];
+    TCGv addr = gen_get_yaddr();
+
+    tcg_gen_addi_tl(addr, addr, a->imm); /* addr = addr + q */
+    gen_data_load(ctx, Rd, addr);
+
+    tcg_temp_free_i32(addr);
+
+    return true;
+}
+
+/*
+ *  Loads one byte indirect with or without displacement from the data space
+ *  to a register. For parts with SRAM, the data space consists of the Register
+ *  File, I/O memory and internal SRAM (and external SRAM if applicable). For
+ *  parts without SRAM, the data space consists of the Register File only. In
+ *  some parts the Flash Memory has been mapped to the data space and can be
+ *  read using this command. The EEPROM has a separate address space.  The data
+ *  location is pointed to by the Z (16 bits) Pointer Register in the Register
+ *  File. Memory access is limited to the current data segment of 64KB. To
+ *  access another data segment in devices with more than 64KB data space, the
+ *  RAMPZ in register in the I/O area has to be changed.  The Z-pointer Register
+ *  can either be left unchanged by the operation, or it can be post-incremented
+ *  or predecremented.  These features are especially suited for Stack Pointer
+ *  usage of the Z-pointer Register, however because the Z-pointer Register can
+ *  be used for indirect subroutine calls, indirect jumps and table lookup, it
+ *  is often more convenient to use the X or Y-pointer as a dedicated Stack
+ *  Pointer. Note that only the low byte of the Z-pointer is updated in devices
+ *  with no more than 256 bytes data space. For such devices, the high byte of
+ *  the pointer is not used by this instruction and can be used for other
+ *  purposes. The RAMPZ Register in the I/O area is updated in parts with more
+ *  than 64KB data space or more than 64KB Program memory, and the
+ *  increment/decrement/displacement is added to the entire 24-bit address on
+ *  such devices.  Not all variants of this instruction is available in all
+ *  devices. Refer to the device specific instruction set summary.  In the
+ *  Reduced Core tinyAVR the LD instruction can be used to achieve the same
+ *  operation as LPM since the program memory is mapped to the data memory
+ *  space.  For using the Z-pointer for table lookup in Program memory see the
+ *  LPM and ELPM instructions.
+ */
+static bool trans_LDZ2(DisasContext *ctx, arg_LDZ2 *a)
+{
+    TCGv Rd = cpu_r[a->rd];
+    TCGv addr = gen_get_zaddr();
+
+    gen_data_load(ctx, Rd, addr);
+    tcg_gen_addi_tl(addr, addr, 1); /* addr = addr + 1 */
+
+    gen_set_zaddr(addr);
+
+    tcg_temp_free_i32(addr);
+
+    return true;
+}
+
+static bool trans_LDZ3(DisasContext *ctx, arg_LDZ3 *a)
+{
+    TCGv Rd = cpu_r[a->rd];
+    TCGv addr = gen_get_zaddr();
+
+    tcg_gen_subi_tl(addr, addr, 1); /* addr = addr - 1 */
+    gen_data_load(ctx, Rd, addr);
+
+    gen_set_zaddr(addr);
+
+    tcg_temp_free_i32(addr);
+
+    return true;
+}
+
+static bool trans_LDDZ(DisasContext *ctx, arg_LDDZ *a)
+{
+    TCGv Rd = cpu_r[a->rd];
+    TCGv addr = gen_get_zaddr();
+
+    tcg_gen_addi_tl(addr, addr, a->imm); /* addr = addr + q */
+    gen_data_load(ctx, Rd, addr);
+
+    tcg_temp_free_i32(addr);
+
+    return true;
+}
+
+/*
+ *  Stores one byte from a Register to the data space. For parts with SRAM,
+ *  the data space consists of the Register File, I/O memory and internal SRAM
+ *  (and external SRAM if applicable). For parts without SRAM, the data space
+ *  consists of the Register File only. The EEPROM has a separate address space.
+ *  A 16-bit address must be supplied. Memory access is limited to the current
+ *  data segment of 64KB. The STS instruction uses the RAMPD Register to access
+ *  memory above 64KB. To access another data segment in devices with more than
+ *  64KB data space, the RAMPD in register in the I/O area has to be changed.
+ *  This instruction is not available in all devices. Refer to the device
+ *  specific instruction set summary.
+ */
+static bool trans_STS(DisasContext *ctx, arg_STS *a)
+{
+    TCGv Rd = cpu_r[a->rd];
+    TCGv addr = tcg_temp_new_i32();
+    TCGv H = cpu_rampD;
+    a->imm = next_word(ctx);
+
+    tcg_gen_mov_tl(addr, H); /* addr = H:M:L */
+    tcg_gen_shli_tl(addr, addr, 16);
+    tcg_gen_ori_tl(addr, addr, a->imm);
+    gen_data_store(ctx, Rd, addr);
+
+    tcg_temp_free_i32(addr);
+
+    return true;
+}
+
+/*
+ * Stores one byte indirect from a register to data space. For parts with SRAM,
+ * the data space consists of the Register File, I/O memory, and internal SRAM
+ * (and external SRAM if applicable). For parts without SRAM, the data space
+ * consists of the Register File only. The EEPROM has a separate address space.
+ *
+ * The data location is pointed to by the X (16 bits) Pointer Register in the
+ * Register File. Memory access is limited to the current data segment of 64KB.
+ * To access another data segment in devices with more than 64KB data space, the
+ * RAMPX in register in the I/O area has to be changed.
+ *
+ * The X-pointer Register can either be left unchanged by the operation, or it
+ * can be post-incremented or pre-decremented. These features are especially
+ * suited for accessing arrays, tables, and Stack Pointer usage of the
+ * X-pointer Register. Note that only the low byte of the X-pointer is updated
+ * in devices with no more than 256 bytes data space. For such devices, the high
+ * byte of the pointer is not used by this instruction and can be used for other
+ * purposes. The RAMPX Register in the I/O area is updated in parts with more
+ * than 64KB data space or more than 64KB Program memory, and the increment /
+ * decrement is added to the entire 24-bit address on such devices.
+ */
+static bool trans_STX1(DisasContext *ctx, arg_STX1 *a)
+{
+    TCGv Rd = cpu_r[a->rr];
+    TCGv addr = gen_get_xaddr();
+
+    gen_data_store(ctx, Rd, addr);
+
+    tcg_temp_free_i32(addr);
+
+    return true;
+}
+
+static bool trans_STX2(DisasContext *ctx, arg_STX2 *a)
+{
+    TCGv Rd = cpu_r[a->rr];
+    TCGv addr = gen_get_xaddr();
+
+    gen_data_store(ctx, Rd, addr);
+    tcg_gen_addi_tl(addr, addr, 1); /* addr = addr + 1 */
+    gen_set_xaddr(addr);
+
+    tcg_temp_free_i32(addr);
+
+    return true;
+}
+
+static bool trans_STX3(DisasContext *ctx, arg_STX3 *a)
+{
+    TCGv Rd = cpu_r[a->rr];
+    TCGv addr = gen_get_xaddr();
+
+    tcg_gen_subi_tl(addr, addr, 1); /* addr = addr - 1 */
+    gen_data_store(ctx, Rd, addr);
+    gen_set_xaddr(addr);
+
+    tcg_temp_free_i32(addr);
+
+    return true;
+}
+
+/*
+ * Stores one byte indirect with or without displacement from a register to data
+ * space. For parts with SRAM, the data space consists of the Register File, I/O
+ * memory, and internal SRAM (and external SRAM if applicable). For parts
+ * without SRAM, the data space consists of the Register File only. The EEPROM
+ * has a separate address space.
+ *
+ * The data location is pointed to by the Y (16 bits) Pointer Register in the
+ * Register File. Memory access is limited to the current data segment of 64KB.
+ * To access another data segment in devices with more than 64KB data space, the
+ * RAMPY in register in the I/O area has to be changed.
+ *
+ * The Y-pointer Register can either be left unchanged by the operation, or it
+ * can be post-incremented or pre-decremented. These features are especially
+ * suited for accessing arrays, tables, and Stack Pointer usage of the Y-pointer
+ * Register. Note that only the low byte of the Y-pointer is updated in devices
+ * with no more than 256 bytes data space. For such devices, the high byte of
+ * the pointer is not used by this instruction and can be used for other
+ * purposes. The RAMPY Register in the I/O area is updated in parts with more
+ * than 64KB data space or more than 64KB Program memory, and the increment /
+ * decrement / displacement is added to the entire 24-bit address on such
+ * devices.
+ */
+static bool trans_STY2(DisasContext *ctx, arg_STY2 *a)
+{
+    TCGv Rd = cpu_r[a->rd];
+    TCGv addr = gen_get_yaddr();
+
+    gen_data_store(ctx, Rd, addr);
+    tcg_gen_addi_tl(addr, addr, 1); /* addr = addr + 1 */
+    gen_set_yaddr(addr);
+
+    tcg_temp_free_i32(addr);
+
+    return true;
+}
+
+static bool trans_STY3(DisasContext *ctx, arg_STY3 *a)
+{
+    TCGv Rd = cpu_r[a->rd];
+    TCGv addr = gen_get_yaddr();
+
+    tcg_gen_subi_tl(addr, addr, 1); /* addr = addr - 1 */
+    gen_data_store(ctx, Rd, addr);
+    gen_set_yaddr(addr);
+
+    tcg_temp_free_i32(addr);
+
+    return true;
+}
+
+static bool trans_STDY(DisasContext *ctx, arg_STDY *a)
+{
+    TCGv Rd = cpu_r[a->rd];
+    TCGv addr = gen_get_yaddr();
+
+    tcg_gen_addi_tl(addr, addr, a->imm); /* addr = addr + q */
+    gen_data_store(ctx, Rd, addr);
+
+    tcg_temp_free_i32(addr);
+
+    return true;
+}
+
+/*
+ * Stores one byte indirect with or without displacement from a register to data
+ * space. For parts with SRAM, the data space consists of the Register File, I/O
+ * memory, and internal SRAM (and external SRAM if applicable). For parts
+ * without SRAM, the data space consists of the Register File only. The EEPROM
+ * has a separate address space.
+ *
+ * The data location is pointed to by the Y (16 bits) Pointer Register in the
+ * Register File. Memory access is limited to the current data segment of 64KB.
+ * To access another data segment in devices with more than 64KB data space, the
+ * RAMPY in register in the I/O area has to be changed.
+ *
+ * The Y-pointer Register can either be left unchanged by the operation, or it
+ * can be post-incremented or pre-decremented. These features are especially
+ * suited for accessing arrays, tables, and Stack Pointer usage of the Y-pointer
+ * Register. Note that only the low byte of the Y-pointer is updated in devices
+ * with no more than 256 bytes data space. For such devices, the high byte of
+ * the pointer is not used by this instruction and can be used for other
+ * purposes. The RAMPY Register in the I/O area is updated in parts with more
+ * than 64KB data space or more than 64KB Program memory, and the increment /
+ * decrement / displacement is added to the entire 24-bit address on such
+ * devices.
+ */
+static bool trans_STZ2(DisasContext *ctx, arg_STZ2 *a)
+{
+    TCGv Rd = cpu_r[a->rd];
+    TCGv addr = gen_get_zaddr();
+
+    gen_data_store(ctx, Rd, addr);
+    tcg_gen_addi_tl(addr, addr, 1); /* addr = addr + 1 */
+
+    gen_set_zaddr(addr);
+
+    tcg_temp_free_i32(addr);
+
+    return true;
+}
+
+static bool trans_STZ3(DisasContext *ctx, arg_STZ3 *a)
+{
+    TCGv Rd = cpu_r[a->rd];
+    TCGv addr = gen_get_zaddr();
+
+    tcg_gen_subi_tl(addr, addr, 1); /* addr = addr - 1 */
+    gen_data_store(ctx, Rd, addr);
+
+    gen_set_zaddr(addr);
+
+    tcg_temp_free_i32(addr);
+
+    return true;
+}
+
+static bool trans_STDZ(DisasContext *ctx, arg_STDZ *a)
+{
+    TCGv Rd = cpu_r[a->rd];
+    TCGv addr = gen_get_zaddr();
+
+    tcg_gen_addi_tl(addr, addr, a->imm); /* addr = addr + q */
+    gen_data_store(ctx, Rd, addr);
+
+    tcg_temp_free_i32(addr);
+
+    return true;
+}
+
+/*
+ *  Loads one byte pointed to by the Z-register into the destination
+ *  register Rd. This instruction features a 100% space effective constant
+ *  initialization or constant data fetch. The Program memory is organized in
+ *  16-bit words while the Z-pointer is a byte address. Thus, the least
+ *  significant bit of the Z-pointer selects either low byte (ZLSB = 0) or high
+ *  byte (ZLSB = 1). This instruction can address the first 64KB (32K words) of
+ *  Program memory. The Zpointer Register can either be left unchanged by the
+ *  operation, or it can be incremented. The incrementation does not apply to
+ *  the RAMPZ Register.
+ *
+ *  Devices with Self-Programming capability can use the LPM instruction to read
+ *  the Fuse and Lock bit values.
+ */
+static bool trans_LPM1(DisasContext *ctx, arg_LPM1 *a)
+{
+    if (!avr_have_feature(ctx, AVR_FEATURE_LPM)) {
+        return true;
+    }
+
+    TCGv Rd = cpu_r[0];
+    TCGv addr = tcg_temp_new_i32();
+    TCGv H = cpu_r[31];
+    TCGv L = cpu_r[30];
+
+    tcg_gen_shli_tl(addr, H, 8); /* addr = H:L */
+    tcg_gen_or_tl(addr, addr, L);
+    tcg_gen_qemu_ld8u(Rd, addr, MMU_CODE_IDX); /* Rd = mem[addr] */
+
+    tcg_temp_free_i32(addr);
+
+    return true;
+}
+
+static bool trans_LPM2(DisasContext *ctx, arg_LPM2 *a)
+{
+    if (!avr_have_feature(ctx, AVR_FEATURE_LPM)) {
+        return true;
+    }
+
+    TCGv Rd = cpu_r[a->rd];
+    TCGv addr = tcg_temp_new_i32();
+    TCGv H = cpu_r[31];
+    TCGv L = cpu_r[30];
+
+    tcg_gen_shli_tl(addr, H, 8); /* addr = H:L */
+    tcg_gen_or_tl(addr, addr, L);
+    tcg_gen_qemu_ld8u(Rd, addr, MMU_CODE_IDX); /* Rd = mem[addr] */
+
+    tcg_temp_free_i32(addr);
+
+    return true;
+}
+
+static bool trans_LPMX(DisasContext *ctx, arg_LPMX *a)
+{
+    if (!avr_have_feature(ctx, AVR_FEATURE_LPMX)) {
+        return true;
+    }
+
+    TCGv Rd = cpu_r[a->rd];
+    TCGv addr = tcg_temp_new_i32();
+    TCGv H = cpu_r[31];
+    TCGv L = cpu_r[30];
+
+    tcg_gen_shli_tl(addr, H, 8); /* addr = H:L */
+    tcg_gen_or_tl(addr, addr, L);
+    tcg_gen_qemu_ld8u(Rd, addr, MMU_CODE_IDX); /* Rd = mem[addr] */
+    tcg_gen_addi_tl(addr, addr, 1); /* addr = addr + 1 */
+    tcg_gen_andi_tl(L, addr, 0xff);
+    tcg_gen_shri_tl(addr, addr, 8);
+    tcg_gen_andi_tl(H, addr, 0xff);
+
+    tcg_temp_free_i32(addr);
+
+    return true;
+}
+
+
+/*
+ *  Loads one byte pointed to by the Z-register and the RAMPZ Register in
+ *  the I/O space, and places this byte in the destination register Rd. This
+ *  instruction features a 100% space effective constant initialization or
+ *  constant data fetch. The Program memory is organized in 16-bit words while
+ *  the Z-pointer is a byte address. Thus, the least significant bit of the
+ *  Z-pointer selects either low byte (ZLSB = 0) or high byte (ZLSB = 1). This
+ *  instruction can address the entire Program memory space. The Z-pointer
+ *  Register can either be left unchanged by the operation, or it can be
+ *  incremented. The incrementation applies to the entire 24-bit concatenation
+ *  of the RAMPZ and Z-pointer Registers.
+ *
+ *  Devices with Self-Programming capability can use the ELPM instruction to
+ *  read the Fuse and Lock bit value.
+ */
+static bool trans_ELPM1(DisasContext *ctx, arg_ELPM1 *a)
+{
+    if (!avr_have_feature(ctx, AVR_FEATURE_ELPM)) {
+        return true;
+    }
+
+    TCGv Rd = cpu_r[0];
+    TCGv addr = gen_get_zaddr();
+
+    tcg_gen_qemu_ld8u(Rd, addr, MMU_CODE_IDX); /* Rd = mem[addr] */
+
+    tcg_temp_free_i32(addr);
+
+    return true;
+}
+
+static bool trans_ELPM2(DisasContext *ctx, arg_ELPM2 *a)
+{
+    if (!avr_have_feature(ctx, AVR_FEATURE_ELPM)) {
+        return true;
+    }
+
+    TCGv Rd = cpu_r[a->rd];
+    TCGv addr = gen_get_zaddr();
+
+    tcg_gen_qemu_ld8u(Rd, addr, MMU_CODE_IDX); /* Rd = mem[addr] */
+
+    tcg_temp_free_i32(addr);
+
+    return true;
+}
+
+static bool trans_ELPMX(DisasContext *ctx, arg_ELPMX *a)
+{
+    if (!avr_have_feature(ctx, AVR_FEATURE_ELPMX)) {
+        return true;
+    }
+
+    TCGv Rd = cpu_r[a->rd];
+    TCGv addr = gen_get_zaddr();
+
+    tcg_gen_qemu_ld8u(Rd, addr, MMU_CODE_IDX); /* Rd = mem[addr] */
+    tcg_gen_addi_tl(addr, addr, 1); /* addr = addr + 1 */
+    gen_set_zaddr(addr);
+
+    tcg_temp_free_i32(addr);
+
+    return true;
+}
+
+/*
+ *  SPM can be used to erase a page in the Program memory, to write a page
+ *  in the Program memory (that is already erased), and to set Boot Loader Lock
+ *  bits. In some devices, the Program memory can be written one word at a time,
+ *  in other devices an entire page can be programmed simultaneously after first
+ *  filling a temporary page buffer. In all cases, the Program memory must be
+ *  erased one page at a time. When erasing the Program memory, the RAMPZ and
+ *  Z-register are used as page address. When writing the Program memory, the
+ *  RAMPZ and Z-register are used as page or word address, and the R1:R0
+ *  register pair is used as data(1). When setting the Boot Loader Lock bits,
+ *  the R1:R0 register pair is used as data. Refer to the device documentation
+ *  for detailed description of SPM usage. This instruction can address the
+ *  entire Program memory.
+ *
+ *  The SPM instruction is not available in all devices. Refer to the device
+ *  specific instruction set summary.
+ *
+ *  Note: 1. R1 determines the instruction high byte, and R0 determines the
+ *  instruction low byte.
+ */
+static bool trans_SPM(DisasContext *ctx, arg_SPM *a)
+{
+    /* TODO */
+    if (!avr_have_feature(ctx, AVR_FEATURE_SPM)) {
+        return true;
+    }
+
+    return true;
+}
+
+static bool trans_SPMX(DisasContext *ctx, arg_SPMX *a)
+{
+    /* TODO */
+    if (!avr_have_feature(ctx, AVR_FEATURE_SPMX)) {
+        return true;
+    }
+
+    return true;
+}
+
+/*
+ *  Loads data from the I/O Space (Ports, Timers, Configuration Registers,
+ *  etc.) into register Rd in the Register File.
+ */
+static bool trans_IN(DisasContext *ctx, arg_IN *a)
+{
+    TCGv Rd = cpu_r[a->rd];
+    TCGv port = tcg_const_i32(a->imm);
+
+    gen_helper_inb(Rd, cpu_env, port);
+
+    tcg_temp_free_i32(port);
+
+    return true;
+}
+
+/*
+ *  Stores data from register Rr in the Register File to I/O Space (Ports,
+ *  Timers, Configuration Registers, etc.).
+ */
+static bool trans_OUT(DisasContext *ctx, arg_OUT *a)
+{
+    TCGv Rd = cpu_r[a->rd];
+    TCGv port = tcg_const_i32(a->imm);
+
+    gen_helper_outb(cpu_env, port, Rd);
+
+    tcg_temp_free_i32(port);
+
+    return true;
+}
+
+/*
+ *  This instruction stores the contents of register Rr on the STACK. The
+ *  Stack Pointer is post-decremented by 1 after the PUSH.  This instruction is
+ *  not available in all devices. Refer to the device specific instruction set
+ *  summary.
+ */
+static bool trans_PUSH(DisasContext *ctx, arg_PUSH *a)
+{
+    TCGv Rd = cpu_r[a->rd];
+
+    gen_data_store(ctx, Rd, cpu_sp);
+    tcg_gen_subi_tl(cpu_sp, cpu_sp, 1);
+
+    return true;
+}
+
+/*
+ *  This instruction loads register Rd with a byte from the STACK. The Stack
+ *  Pointer is pre-incremented by 1 before the POP.  This instruction is not
+ *  available in all devices. Refer to the device specific instruction set
+ *  summary.
+ */
+static bool trans_POP(DisasContext *ctx, arg_POP *a)
+{
+    /*
+     * Using a temp to work around some strange behaviour:
+     * tcg_gen_addi_tl(cpu_sp, cpu_sp, 1);
+     * gen_data_load(ctx, Rd, cpu_sp);
+     * seems to cause the add to happen twice.
+     * This doesn't happen if either the add or the load is removed.
+     */
+    TCGv t1 = tcg_temp_new_i32();
+    TCGv Rd = cpu_r[a->rd];
+
+    tcg_gen_addi_tl(t1, cpu_sp, 1);
+    gen_data_load(ctx, Rd, t1);
+    tcg_gen_mov_tl(cpu_sp, t1);
+
+    return true;
+}
+
+/*
+ *  Exchanges one byte indirect between register and data space.  The data
+ *  location is pointed to by the Z (16 bits) Pointer Register in the Register
+ *  File. Memory access is limited to the current data segment of 64KB. To
+ *  access another data segment in devices with more than 64KB data space, the
+ *  RAMPZ in register in the I/O area has to be changed.
+ *
+ *  The Z-pointer Register is left unchanged by the operation. This instruction
+ *  is especially suited for writing/reading status bits stored in SRAM.
+ */
+static bool trans_XCH(DisasContext *ctx, arg_XCH *a)
+{
+    if (!avr_have_feature(ctx, AVR_FEATURE_RMW)) {
+        return true;
+    }
+
+    TCGv Rd = cpu_r[a->rd];
+    TCGv t0 = tcg_temp_new_i32();
+    TCGv addr = gen_get_zaddr();
+
+    gen_data_load(ctx, t0, addr);
+    gen_data_store(ctx, Rd, addr);
+    tcg_gen_mov_tl(Rd, t0);
+
+    tcg_temp_free_i32(t0);
+    tcg_temp_free_i32(addr);
+
+    return true;
+}
+
+/*
+ *  Load one byte indirect from data space to register and set bits in data
+ *  space specified by the register. The instruction can only be used towards
+ *  internal SRAM.  The data location is pointed to by the Z (16 bits) Pointer
+ *  Register in the Register File. Memory access is limited to the current data
+ *  segment of 64KB. To access another data segment in devices with more than
+ *  64KB data space, the RAMPZ in register in the I/O area has to be changed.
+ *
+ *  The Z-pointer Register is left unchanged by the operation. This instruction
+ *  is especially suited for setting status bits stored in SRAM.
+ */
+static bool trans_LAS(DisasContext *ctx, arg_LAS *a)
+{
+    if (!avr_have_feature(ctx, AVR_FEATURE_RMW)) {
+        return true;
+    }
+
+    TCGv Rr = cpu_r[a->rd];
+    TCGv addr = gen_get_zaddr();
+    TCGv t0 = tcg_temp_new_i32();
+    TCGv t1 = tcg_temp_new_i32();
+
+    gen_data_load(ctx, t0, addr); /* t0 = mem[addr] */
+    tcg_gen_or_tl(t1, t0, Rr);
+    tcg_gen_mov_tl(Rr, t0); /* Rr = t0 */
+    gen_data_store(ctx, t1, addr); /* mem[addr] = t1 */
+
+    tcg_temp_free_i32(t1);
+    tcg_temp_free_i32(t0);
+    tcg_temp_free_i32(addr);
+
+    return true;
+}
+
+/*
+ *  Load one byte indirect from data space to register and stores and clear
+ *  the bits in data space specified by the register. The instruction can
+ *  only be used towards internal SRAM.  The data location is pointed to by
+ *  the Z (16 bits) Pointer Register in the Register File. Memory access is
+ *  limited to the current data segment of 64KB. To access another data
+ *  segment in devices with more than 64KB data space, the RAMPZ in register
+ *  in the I/O area has to be changed.
+ *
+ *  The Z-pointer Register is left unchanged by the operation. This instruction
+ *  is especially suited for clearing status bits stored in SRAM.
+ */
+static bool trans_LAC(DisasContext *ctx, arg_LAC *a)
+{
+    if (!avr_have_feature(ctx, AVR_FEATURE_RMW)) {
+        return true;
+    }
+
+    TCGv Rr = cpu_r[a->rd];
+    TCGv addr = gen_get_zaddr();
+    TCGv t0 = tcg_temp_new_i32();
+    TCGv t1 = tcg_temp_new_i32();
+
+    gen_data_load(ctx, t0, addr); /* t0 = mem[addr] */
+    tcg_gen_andc_tl(t1, t0, Rr); /* t1 = t0 & (0xff - Rr) = t0 & ~Rr */
+    tcg_gen_mov_tl(Rr, t0); /* Rr = t0 */
+    gen_data_store(ctx, t1, addr); /* mem[addr] = t1 */
+
+    tcg_temp_free_i32(t1);
+    tcg_temp_free_i32(t0);
+    tcg_temp_free_i32(addr);
+
+    return true;
+}
+
+
+/*
+ *  Load one byte indirect from data space to register and toggles bits in
+ *  the data space specified by the register.  The instruction can only be used
+ *  towards SRAM.  The data location is pointed to by the Z (16 bits) Pointer
+ *  Register in the Register File. Memory access is limited to the current data
+ *  segment of 64KB. To access another data segment in devices with more than
+ *  64KB data space, the RAMPZ in register in the I/O area has to be changed.
+ *
+ *  The Z-pointer Register is left unchanged by the operation. This instruction
+ *  is especially suited for changing status bits stored in SRAM.
+ */
+static bool trans_LAT(DisasContext *ctx, arg_LAT *a)
+{
+    if (!avr_have_feature(ctx, AVR_FEATURE_RMW)) {
+        return true;
+    }
+
+    TCGv Rd = cpu_r[a->rd];
+    TCGv addr = gen_get_zaddr();
+    TCGv t0 = tcg_temp_new_i32();
+    TCGv t1 = tcg_temp_new_i32();
+
+    gen_data_load(ctx, t0, addr); /* t0 = mem[addr] */
+    tcg_gen_xor_tl(t1, t0, Rd);
+    tcg_gen_mov_tl(Rd, t0); /* Rd = t0 */
+    gen_data_store(ctx, t1, addr); /* mem[addr] = t1 */
+
+    tcg_temp_free_i32(t1);
+    tcg_temp_free_i32(t0);
+    tcg_temp_free_i32(addr);
+
+    return true;
+}
diff --git a/target/avr/insn.decode b/target/avr/insn.decode
index 32034c10d2..3f9304f8b0 100644
--- a/target/avr/insn.decode
+++ b/target/avr/insn.decode
@@ -115,3 +115,46 @@ SBIC            1001 1001 reg:5 bit:3
 SBIS            1001 1011 reg:5 bit:3
 BRBS            1111 00 ....... ...         @op_bit_imm
 BRBC            1111 01 ....... ...         @op_bit_imm
+
+#
+# Data Transfer Instructions
+#
+MOV             0010 11 . ..... ....        @op_rd_rr
+MOVW            0000 0001 .... ....         &rd_rr      rd=%rd_d rr=%rr_d
+LDI             1110 .... .... ....         @op_rd_imm8
+LDS             1001 000 ..... 0000         @ldst_s
+LDX1            1001 000 rd:5 1100
+LDX2            1001 000 rd:5 1101
+LDX3            1001 000 rd:5 1110
+LDY2            1001 000 rd:5 1001
+LDY3            1001 000 rd:5 1010
+LDZ2            1001 000 rd:5 0001
+LDZ3            1001 000 rd:5 0010
+LDDY            10 . 0 .. 0 ..... 1 ...     @ldst_d
+LDDZ            10 . 0 .. 0 ..... 0 ...     @ldst_d
+STS             1001 001 ..... 0000         @ldst_s
+STX1            1001 001 rr:5 1100
+STX2            1001 001 rr:5 1101
+STX3            1001 001 rr:5 1110
+STY2            1001 001 rd:5 1001
+STY3            1001 001 rd:5 1010
+STZ2            1001 001 rd:5 0001
+STZ3            1001 001 rd:5 0010
+STDY            10 . 0 .. 1 ..... 1 ...     @ldst_d
+STDZ            10 . 0 .. 1 ..... 0 ...     @ldst_d
+LPM1            1001 0101 1100 1000
+LPM2            1001 000 rd:5 0100
+LPMX            1001 000 rd:5 0101
+ELPM1           1001 0101 1101 1000
+ELPM2           1001 000 rd:5 0110
+ELPMX           1001 000 rd:5 0111
+SPM             1001 0101 1110 1000
+SPMX            1001 0101 1111 1000
+IN              1011 0 .. ..... ....        @io_rd_imm
+OUT             1011 1 .. ..... ....        @io_rd_imm
+PUSH            1001 001 rd:5 1111
+POP             1001 000 rd:5 1111
+XCH             1001 001 rd:5 0100
+LAC             1001 001 rd:5 0110
+LAS             1001 001 rd:5 0101
+LAT             1001 001 rd:5 0111
-- 
2.20.1


