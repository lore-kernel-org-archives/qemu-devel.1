Return-Path: <SRS0=YrRb=Z3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D475DC43603
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Dec 2019 14:20:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 79D6D21823
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Dec 2019 14:20:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vIxhX1Of"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 79D6D21823
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55084 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1icrzy-0004XH-9n
	for qemu-devel@archiver.kernel.org; Thu, 05 Dec 2019 09:20:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:47295)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1icrjq-0006hC-I9
 for qemu-devel@nongnu.org; Thu, 05 Dec 2019 09:04:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1icrjh-0003yg-Ce
 for qemu-devel@nongnu.org; Thu, 05 Dec 2019 09:04:14 -0500
Received: from mail-oi1-x244.google.com ([2607:f8b0:4864:20::244]:35889)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <aleksandar.m.mail@gmail.com>)
 id 1icrjg-0003wH-Ud
 for qemu-devel@nongnu.org; Thu, 05 Dec 2019 09:04:05 -0500
Received: by mail-oi1-x244.google.com with SMTP id c16so2821804oic.3
 for <qemu-devel@nongnu.org>; Thu, 05 Dec 2019 06:04:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:in-reply-to:references:from:date:message-id:subject:to
 :cc; bh=3RYwM8vcvwnqSZK921jwe2Zp6O4mT2v3n2FCfQJEu4Y=;
 b=vIxhX1Of3IownRiAoeEPGb2124nDf4HZCIPAxSSMi++rsRC13s1PLitVm0HGc6Mja9
 3w6UiypLVWjO5+9ZBL3w2iRuneX0J0YasBD7cZd6E4T78Ave49CS1OMBUZlBeg+WA5d0
 i7+XBtJtWQMIE3LhPdILK8WEYSvbjBT+8Xc2pqzTlcm66p+r/6/yl+FACXqZ4TzfYCAj
 ynNYHtd7JjaB8K8ozP9uh0lgCLAE3uVcTcL3Iz0qDm/YPMK9waltfzSRMG5Jb2Ua/wMa
 xgkkE+lEQmqjSzrTLPUFYZUViaqPJ1Fj4zNpbsm0LK4KejfN6FWKnv9pQeYqS4EE38DF
 MFeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:in-reply-to:references:from:date
 :message-id:subject:to:cc;
 bh=3RYwM8vcvwnqSZK921jwe2Zp6O4mT2v3n2FCfQJEu4Y=;
 b=FtM8Cr1+B4q6YCw07BXqOGV9rE4HQ6EQ3aTT3bp9401iilU7UPSvuaKYBoOpe6H2Ms
 3wvPhsScdYxdKNC9P+m3tcOFInPApzMsutlFcak/6WOIMZhEFatKkCfYXrsK08bkfcCX
 sEcUe6ONGa9x1qoKVUEIIADVSe1ZDTbam0awGDVz75cegn+X43zulAL3z45YyDaZw31F
 hpoSvhWH2GK6pYqmKuUn+Tl3W5bvjlnog43vPjMkwrsbRBvHmBqHO3UlCgvjdTCDUJYF
 DZcONsn054krN025T9tYcmglBjpQAHnlvrDuaUnUYVLUiuNbTSGbTKG90BKc4gjWhD+R
 hZjQ==
X-Gm-Message-State: APjAAAU+IN7sysUQf/HCi4FEy6jLsBEjBh0OoF7gwSbOHdgJ19RDHQPr
 Oisq1/+QfkJTGoct9+IH3sCoDJbxtpUKiALi0BV/oA==
X-Google-Smtp-Source: APXvYqwPmYXZu7FK4Js17/Bi6CzoyWQ9eh3YXAaBK9aioTCxh/3kghgcMX08WZMcBBQEgVJA+GWDQgX/YlgIo8pOVsE=
X-Received: by 2002:aca:bbc6:: with SMTP id l189mr463271oif.53.1575548894587; 
 Thu, 05 Dec 2019 04:28:14 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a9d:d21:0:0:0:0:0 with HTTP;
 Thu, 5 Dec 2019 04:28:14 -0800 (PST)
In-Reply-To: <20191127175257.23480-8-mrolnik@gmail.com>
References: <20191127175257.23480-1-mrolnik@gmail.com>
 <20191127175257.23480-8-mrolnik@gmail.com>
From: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Date: Thu, 5 Dec 2019 13:28:14 +0100
Message-ID: <CAL1e-=iG-Y+QB5nFdf41tr1vJSSwjmADQr9Hcgk-_MQpFseS5Q@mail.gmail.com>
Subject: Re: [PATCH v37 07/17] target/avr: Add instruction translation - Bit
 and Bit-test Instructions
To: Michael Rolnik <mrolnik@gmail.com>
Content-Type: multipart/alternative; boundary="000000000000302e930598f410dc"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::244
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
Cc: "thuth@redhat.com" <thuth@redhat.com>,
 "me@xcancerberox.com.ar" <me@xcancerberox.com.ar>,
 "richard.henderson@linaro.org" <richard.henderson@linaro.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "dovgaluk@ispras.ru" <dovgaluk@ispras.ru>,
 "imammedo@redhat.com" <imammedo@redhat.com>,
 "philmd@redhat.com" <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000302e930598f410dc
Content-Type: text/plain; charset="UTF-8"

On Wednesday, November 27, 2019, Michael Rolnik <mrolnik@gmail.com> wrote:

> This includes:
>     - LSR, ROR
>     - ASR
>     - SWAP
>     - SBI, CBI
>     - BST, BLD
>     - BSET, BCLR
>
> Signed-off-by: Michael Rolnik <mrolnik@gmail.com>
> ---
>  target/avr/translate.c | 1123 ++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 1123 insertions(+)
>
>
Hello, Michael

I said I am on vacation, and truly I am, but, fir the next version if the
series, I would like to ask you to extract "data transfer" instruction (as
defined in avr docs, MOV LD ST etc) from this patch, and create a new patch
for them - so that the patches follow the division from docs.

Yours,
Aleksandar





> diff --git a/target/avr/translate.c b/target/avr/translate.c
> index 48a42c984a..dc6a1af2fc 100644
> --- a/target/avr/translate.c
> +++ b/target/avr/translate.c
> @@ -317,6 +317,15 @@ static void gen_goto_tb(DisasContext *ctx, int n,
> target_ulong dest)
>  }
>
>
> +static void gen_rshift_ZNVSf(TCGv R)
> +{
> +    tcg_gen_setcondi_tl(TCG_COND_EQ, cpu_Zf, R, 0); /* Zf = R == 0 */
> +    tcg_gen_shri_tl(cpu_Nf, R, 7); /* Nf = R(7) */
> +    tcg_gen_xor_tl(cpu_Vf, cpu_Nf, cpu_Cf);
> +    tcg_gen_xor_tl(cpu_Sf, cpu_Nf, cpu_Vf); /* Sf = Nf ^ Vf */
> +}
> +
> +
>  /*
>   *  Adds two registers without the C Flag and places the result in the
>   *  destination register Rd.
> @@ -1508,3 +1517,1117 @@ static bool trans_BRBS(DisasContext *ctx,
> arg_BRBS *a)
>      return true;
>  }
>
> +
> +/*
> + *  This instruction makes a copy of one register into another. The source
> + *  register Rr is left unchanged, while the destination register Rd is
> loaded
> + *  with a copy of Rr.
> + */
> +static bool trans_MOV(DisasContext *ctx, arg_MOV *a)
> +{
> +    TCGv Rd = cpu_r[a->rd];
> +    TCGv Rr = cpu_r[a->rr];
> +
> +    tcg_gen_mov_tl(Rd, Rr);
> +
> +    return true;
> +}
> +
> +
> +/*
> + *  This instruction makes a copy of one register pair into another
> register
> + *  pair. The source register pair Rr+1:Rr is left unchanged, while the
> + *  destination register pair Rd+1:Rd is loaded with a copy of Rr +
> 1:Rr.  This
> + *  instruction is not available in all devices. Refer to the device
> specific
> + *  instruction set summary.
> + */
> +static bool trans_MOVW(DisasContext *ctx, arg_MOVW *a)
> +{
> +    if (!avr_have_feature(ctx, AVR_FEATURE_MOVW)) {
> +        return true;
> +    }
> +
> +    TCGv RdL = cpu_r[a->rd];
> +    TCGv RdH = cpu_r[a->rd + 1];
> +    TCGv RrL = cpu_r[a->rr];
> +    TCGv RrH = cpu_r[a->rr + 1];
> +
> +    tcg_gen_mov_tl(RdH, RrH);
> +    tcg_gen_mov_tl(RdL, RrL);
> +
> +    return true;
> +}
> +
> +
> +/*
> + * Loads an 8 bit constant directly to register 16 to 31.
> + */
> +static bool trans_LDI(DisasContext *ctx, arg_LDI *a)
> +{
> +    TCGv Rd = cpu_r[a->rd];
> +    int imm = a->imm;
> +
> +    tcg_gen_movi_tl(Rd, imm);
> +
> +    return true;
> +}
> +
> +
> +/*
> + *  Loads one byte from the data space to a register. For parts with SRAM,
> + *  the data space consists of the Register File, I/O memory and internal
> SRAM
> + *  (and external SRAM if applicable). For parts without SRAM, the data
> space
> + *  consists of the register file only. The EEPROM has a separate address
> space.
> + *  A 16-bit address must be supplied. Memory access is limited to the
> current
> + *  data segment of 64KB. The LDS instruction uses the RAMPD Register to
> access
> + *  memory above 64KB. To access another data segment in devices with
> more than
> + *  64KB data space, the RAMPD in register in the I/O area has to be
> changed.
> + *  This instruction is not available in all devices. Refer to the device
> + *  specific instruction set summary.
> + */
> +static bool trans_LDS(DisasContext *ctx, arg_LDS *a)
> +{
> +    TCGv Rd = cpu_r[a->rd];
> +    TCGv addr = tcg_temp_new_i32();
> +    TCGv H = cpu_rampD;
> +    a->imm = next_word(ctx);
> +
> +    tcg_gen_mov_tl(addr, H); /* addr = H:M:L */
> +    tcg_gen_shli_tl(addr, addr, 16);
> +    tcg_gen_ori_tl(addr, addr, a->imm);
> +
> +    gen_data_load(ctx, Rd, addr);
> +
> +    tcg_temp_free_i32(addr);
> +
> +    return true;
> +}
> +
> +
> +/*
> + *  Loads one byte indirect from the data space to a register. For parts
> + *  with SRAM, the data space consists of the Register File, I/O memory
> and
> + *  internal SRAM (and external SRAM if applicable). For parts without
> SRAM, the
> + *  data space consists of the Register File only. In some parts the Flash
> + *  Memory has been mapped to the data space and can be read using this
> command.
> + *  The EEPROM has a separate address space.  The data location is
> pointed to by
> + *  the X (16 bits) Pointer Register in the Register File. Memory access
> is
> + *  limited to the current data segment of 64KB. To access another data
> segment
> + *  in devices with more than 64KB data space, the RAMPX in register in
> the I/O
> + *  area has to be changed.  The X-pointer Register can either be left
> unchanged
> + *  by the operation, or it can be post-incremented or predecremented.
> These
> + *  features are especially suited for accessing arrays, tables, and Stack
> + *  Pointer usage of the X-pointer Register. Note that only the low byte
> of the
> + *  X-pointer is updated in devices with no more than 256 bytes data
> space. For
> + *  such devices, the high byte of the pointer is not used by this
> instruction
> + *  and can be used for other purposes. The RAMPX Register in the I/O
> area is
> + *  updated in parts with more than 64KB data space or more than 64KB
> Program
> + *  memory, and the increment/decrement is added to the entire 24-bit
> address on
> + *  such devices.  Not all variants of this instruction is available in
> all
> + *  devices. Refer to the device specific instruction set summary.  In the
> + *  Reduced Core tinyAVR the LD instruction can be used to achieve the
> same
> + *  operation as LPM since the program memory is mapped to the data memory
> + *  space.
> + */
> +static bool trans_LDX1(DisasContext *ctx, arg_LDX1 *a)
> +{
> +    TCGv Rd = cpu_r[a->rd];
> +    TCGv addr = gen_get_xaddr();
> +
> +    gen_data_load(ctx, Rd, addr);
> +
> +    tcg_temp_free_i32(addr);
> +
> +    return true;
> +}
> +
> +
> +static bool trans_LDX2(DisasContext *ctx, arg_LDX2 *a)
> +{
> +    TCGv Rd = cpu_r[a->rd];
> +    TCGv addr = gen_get_xaddr();
> +
> +    gen_data_load(ctx, Rd, addr);
> +    tcg_gen_addi_tl(addr, addr, 1); /* addr = addr + 1 */
> +
> +    gen_set_xaddr(addr);
> +
> +    tcg_temp_free_i32(addr);
> +
> +    return true;
> +}
> +
> +
> +static bool trans_LDX3(DisasContext *ctx, arg_LDX3 *a)
> +{
> +    TCGv Rd = cpu_r[a->rd];
> +    TCGv addr = gen_get_xaddr();
> +
> +    tcg_gen_subi_tl(addr, addr, 1); /* addr = addr - 1 */
> +    gen_data_load(ctx, Rd, addr);
> +    gen_set_xaddr(addr);
> +
> +    tcg_temp_free_i32(addr);
> +
> +    return true;
> +}
> +
> +
> +static bool trans_STX1(DisasContext *ctx, arg_STX1 *a)
> +{
> +    TCGv Rd = cpu_r[a->rr];
> +    TCGv addr = gen_get_xaddr();
> +
> +    gen_data_store(ctx, Rd, addr);
> +
> +    tcg_temp_free_i32(addr);
> +
> +    return true;
> +}
> +
> +static bool trans_STX2(DisasContext *ctx, arg_STX2 *a)
> +{
> +    TCGv Rd = cpu_r[a->rr];
> +    TCGv addr = gen_get_xaddr();
> +
> +    gen_data_store(ctx, Rd, addr);
> +    tcg_gen_addi_tl(addr, addr, 1); /* addr = addr + 1 */
> +    gen_set_xaddr(addr);
> +
> +    tcg_temp_free_i32(addr);
> +
> +    return true;
> +}
> +
> +static bool trans_STX3(DisasContext *ctx, arg_STX3 *a)
> +{
> +    TCGv Rd = cpu_r[a->rr];
> +    TCGv addr = gen_get_xaddr();
> +
> +    tcg_gen_subi_tl(addr, addr, 1); /* addr = addr - 1 */
> +    gen_data_store(ctx, Rd, addr);
> +    gen_set_xaddr(addr);
> +
> +    tcg_temp_free_i32(addr);
> +
> +    return true;
> +}
> +
> +
> +/*
> + *  Loads one byte indirect with or without displacement from the data
> space
> + *  to a register. For parts with SRAM, the data space consists of the
> Register
> + *  File, I/O memory and internal SRAM (and external SRAM if applicable).
> For
> + *  parts without SRAM, the data space consists of the Register File
> only. In
> + *  some parts the Flash Memory has been mapped to the data space and can
> be
> + *  read using this command. The EEPROM has a separate address space.
> The data
> + *  location is pointed to by the Y (16 bits) Pointer Register in the
> Register
> + *  File. Memory access is limited to the current data segment of 64KB. To
> + *  access another data segment in devices with more than 64KB data
> space, the
> + *  RAMPY in register in the I/O area has to be changed.  The Y-pointer
> Register
> + *  can either be left unchanged by the operation, or it can be
> post-incremented
> + *  or predecremented.  These features are especially suited for accessing
> + *  arrays, tables, and Stack Pointer usage of the Y-pointer Register.
> Note that
> + *  only the low byte of the Y-pointer is updated in devices with no more
> than
> + *  256 bytes data space. For such devices, the high byte of the pointer
> is not
> + *  used by this instruction and can be used for other purposes. The RAMPY
> + *  Register in the I/O area is updated in parts with more than 64KB data
> space
> + *  or more than 64KB Program memory, and the increment/decrement/
> displacement
> + *  is added to the entire 24-bit address on such devices.  Not all
> variants of
> + *  this instruction is available in all devices. Refer to the device
> specific
> + *  instruction set summary.  In the Reduced Core tinyAVR the LD
> instruction can
> + *  be used to achieve the same operation as LPM since the program memory
> is
> + *  mapped to the data memory space.
> + */
> +static bool trans_LDY2(DisasContext *ctx, arg_LDY2 *a)
> +{
> +    TCGv Rd = cpu_r[a->rd];
> +    TCGv addr = gen_get_yaddr();
> +
> +    gen_data_load(ctx, Rd, addr);
> +    tcg_gen_addi_tl(addr, addr, 1); /* addr = addr + 1 */
> +
> +    gen_set_yaddr(addr);
> +
> +    tcg_temp_free_i32(addr);
> +
> +    return true;
> +}
> +
> +
> +static bool trans_LDY3(DisasContext *ctx, arg_LDY3 *a)
> +{
> +    TCGv Rd = cpu_r[a->rd];
> +    TCGv addr = gen_get_yaddr();
> +
> +    tcg_gen_subi_tl(addr, addr, 1); /* addr = addr - 1 */
> +    gen_data_load(ctx, Rd, addr);
> +    gen_set_yaddr(addr);
> +
> +    tcg_temp_free_i32(addr);
> +
> +    return true;
> +}
> +
> +
> +static bool trans_LDDY(DisasContext *ctx, arg_LDDY *a)
> +{
> +    TCGv Rd = cpu_r[a->rd];
> +    TCGv addr = gen_get_yaddr();
> +
> +    tcg_gen_addi_tl(addr, addr, a->imm); /* addr = addr + q */
> +    gen_data_load(ctx, Rd, addr);
> +
> +    tcg_temp_free_i32(addr);
> +
> +    return true;
> +}
> +
> +
> +static bool trans_STY2(DisasContext *ctx, arg_STY2 *a)
> +{
> +    TCGv Rd = cpu_r[a->rd];
> +    TCGv addr = gen_get_yaddr();
> +
> +    gen_data_store(ctx, Rd, addr);
> +    tcg_gen_addi_tl(addr, addr, 1); /* addr = addr + 1 */
> +    gen_set_yaddr(addr);
> +
> +    tcg_temp_free_i32(addr);
> +
> +    return true;
> +}
> +
> +
> +static bool trans_STY3(DisasContext *ctx, arg_STY3 *a)
> +{
> +    TCGv Rd = cpu_r[a->rd];
> +    TCGv addr = gen_get_yaddr();
> +
> +    tcg_gen_subi_tl(addr, addr, 1); /* addr = addr - 1 */
> +    gen_data_store(ctx, Rd, addr);
> +    gen_set_yaddr(addr);
> +
> +    tcg_temp_free_i32(addr);
> +
> +    return true;
> +}
> +
> +
> +static bool trans_STDY(DisasContext *ctx, arg_STDY *a)
> +{
> +    TCGv Rd = cpu_r[a->rd];
> +    TCGv addr = gen_get_yaddr();
> +
> +    tcg_gen_addi_tl(addr, addr, a->imm); /* addr = addr + q */
> +    gen_data_store(ctx, Rd, addr);
> +
> +    tcg_temp_free_i32(addr);
> +
> +    return true;
> +}
> +
> +
> +/*
> + *  Loads one byte indirect with or without displacement from the data
> space
> + *  to a register. For parts with SRAM, the data space consists of the
> Register
> + *  File, I/O memory and internal SRAM (and external SRAM if applicable).
> For
> + *  parts without SRAM, the data space consists of the Register File
> only. In
> + *  some parts the Flash Memory has been mapped to the data space and can
> be
> + *  read using this command. The EEPROM has a separate address space.
> The data
> + *  location is pointed to by the Z (16 bits) Pointer Register in the
> Register
> + *  File. Memory access is limited to the current data segment of 64KB. To
> + *  access another data segment in devices with more than 64KB data
> space, the
> + *  RAMPZ in register in the I/O area has to be changed.  The Z-pointer
> Register
> + *  can either be left unchanged by the operation, or it can be
> post-incremented
> + *  or predecremented.  These features are especially suited for Stack
> Pointer
> + *  usage of the Z-pointer Register, however because the Z-pointer
> Register can
> + *  be used for indirect subroutine calls, indirect jumps and table
> lookup, it
> + *  is often more convenient to use the X or Y-pointer as a dedicated
> Stack
> + *  Pointer. Note that only the low byte of the Z-pointer is updated in
> devices
> + *  with no more than 256 bytes data space. For such devices, the high
> byte of
> + *  the pointer is not used by this instruction and can be used for other
> + *  purposes. The RAMPZ Register in the I/O area is updated in parts with
> more
> + *  than 64KB data space or more than 64KB Program memory, and the
> + *  increment/decrement/displacement is added to the entire 24-bit
> address on
> + *  such devices.  Not all variants of this instruction is available in
> all
> + *  devices. Refer to the device specific instruction set summary.  In the
> + *  Reduced Core tinyAVR the LD instruction can be used to achieve the
> same
> + *  operation as LPM since the program memory is mapped to the data memory
> + *  space.  For using the Z-pointer for table lookup in Program memory
> see the
> + *  LPM and ELPM instructions.
> + */
> +static bool trans_LDZ2(DisasContext *ctx, arg_LDZ2 *a)
> +{
> +    TCGv Rd = cpu_r[a->rd];
> +    TCGv addr = gen_get_zaddr();
> +
> +    gen_data_load(ctx, Rd, addr);
> +    tcg_gen_addi_tl(addr, addr, 1); /* addr = addr + 1 */
> +
> +    gen_set_zaddr(addr);
> +
> +    tcg_temp_free_i32(addr);
> +
> +    return true;
> +}
> +
> +
> +static bool trans_LDZ3(DisasContext *ctx, arg_LDZ3 *a)
> +{
> +    TCGv Rd = cpu_r[a->rd];
> +    TCGv addr = gen_get_zaddr();
> +
> +    tcg_gen_subi_tl(addr, addr, 1); /* addr = addr - 1 */
> +    gen_data_load(ctx, Rd, addr);
> +
> +    gen_set_zaddr(addr);
> +
> +    tcg_temp_free_i32(addr);
> +
> +    return true;
> +}
> +
> +
> +static bool trans_LDDZ(DisasContext *ctx, arg_LDDZ *a)
> +{
> +    TCGv Rd = cpu_r[a->rd];
> +    TCGv addr = gen_get_zaddr();
> +
> +    tcg_gen_addi_tl(addr, addr, a->imm); /* addr = addr + q */
> +    gen_data_load(ctx, Rd, addr);
> +
> +    tcg_temp_free_i32(addr);
> +
> +    return true;
> +}
> +
> +
> +static bool trans_STZ2(DisasContext *ctx, arg_STZ2 *a)
> +{
> +    TCGv Rd = cpu_r[a->rd];
> +    TCGv addr = gen_get_zaddr();
> +
> +    gen_data_store(ctx, Rd, addr);
> +    tcg_gen_addi_tl(addr, addr, 1); /* addr = addr + 1 */
> +
> +    gen_set_zaddr(addr);
> +
> +    tcg_temp_free_i32(addr);
> +
> +    return true;
> +}
> +
> +
> +static bool trans_STZ3(DisasContext *ctx, arg_STZ3 *a)
> +{
> +    TCGv Rd = cpu_r[a->rd];
> +    TCGv addr = gen_get_zaddr();
> +
> +    tcg_gen_subi_tl(addr, addr, 1); /* addr = addr - 1 */
> +    gen_data_store(ctx, Rd, addr);
> +
> +    gen_set_zaddr(addr);
> +
> +    tcg_temp_free_i32(addr);
> +
> +    return true;
> +}
> +
> +
> +static bool trans_STDZ(DisasContext *ctx, arg_STDZ *a)
> +{
> +    TCGv Rd = cpu_r[a->rd];
> +    TCGv addr = gen_get_zaddr();
> +
> +    tcg_gen_addi_tl(addr, addr, a->imm); /* addr = addr + q */
> +    gen_data_store(ctx, Rd, addr);
> +
> +    tcg_temp_free_i32(addr);
> +
> +    return true;
> +}
> +
> +
> +
> +/*
> + *  Stores one byte from a Register to the data space. For parts with
> SRAM,
> + *  the data space consists of the Register File, I/O memory and internal
> SRAM
> + *  (and external SRAM if applicable). For parts without SRAM, the data
> space
> + *  consists of the Register File only. The EEPROM has a separate address
> space.
> + *  A 16-bit address must be supplied. Memory access is limited to the
> current
> + *  data segment of 64KB. The STS instruction uses the RAMPD Register to
> access
> + *  memory above 64KB. To access another data segment in devices with
> more than
> + *  64KB data space, the RAMPD in register in the I/O area has to be
> changed.
> + *  This instruction is not available in all devices. Refer to the device
> + *  specific instruction set summary.
> + */
> +static bool trans_STS(DisasContext *ctx, arg_STS *a)
> +{
> +    TCGv Rd = cpu_r[a->rd];
> +    TCGv addr = tcg_temp_new_i32();
> +    TCGv H = cpu_rampD;
> +    a->imm = next_word(ctx);
> +
> +    tcg_gen_mov_tl(addr, H); /* addr = H:M:L */
> +    tcg_gen_shli_tl(addr, addr, 16);
> +    tcg_gen_ori_tl(addr, addr, a->imm);
> +
> +    gen_data_store(ctx, Rd, addr);
> +
> +    tcg_temp_free_i32(addr);
> +
> +    return true;
> +}
> +
> +
> +/*
> + *  Loads one byte pointed to by the Z-register into the destination
> + *  register Rd. This instruction features a 100% space effective constant
> + *  initialization or constant data fetch. The Program memory is
> organized in
> + *  16-bit words while the Z-pointer is a byte address. Thus, the least
> + *  significant bit of the Z-pointer selects either low byte (ZLSB = 0)
> or high
> + *  byte (ZLSB = 1). This instruction can address the first 64KB (32K
> words) of
> + *  Program memory. The Zpointer Register can either be left unchanged by
> the
> + *  operation, or it can be incremented. The incrementation does not
> apply to
> + *  the RAMPZ Register.  Devices with Self-Programming capability can use
> the
> + *  LPM instruction to read the Fuse and Lock bit values.  Refer to the
> device
> + *  documentation for a detailed description.  The LPM instruction is not
> + *  available in all devices. Refer to the device specific instruction set
> + *  summary
> + */
> +static bool trans_LPM1(DisasContext *ctx, arg_LPM1 *a)
> +{
> +    if (!avr_have_feature(ctx, AVR_FEATURE_LPM)) {
> +        return true;
> +    }
> +
> +    TCGv Rd = cpu_r[0];
> +    TCGv addr = tcg_temp_new_i32();
> +    TCGv H = cpu_r[31];
> +    TCGv L = cpu_r[30];
> +
> +    tcg_gen_shli_tl(addr, H, 8); /* addr = H:L */
> +    tcg_gen_or_tl(addr, addr, L);
> +
> +    tcg_gen_qemu_ld8u(Rd, addr, MMU_CODE_IDX); /* Rd = mem[addr] */
> +
> +    tcg_temp_free_i32(addr);
> +
> +    return true;
> +}
> +
> +
> +static bool trans_LPM2(DisasContext *ctx, arg_LPM2 *a)
> +{
> +    if (!avr_have_feature(ctx, AVR_FEATURE_LPM)) {
> +        return true;
> +    }
> +
> +    TCGv Rd = cpu_r[a->rd];
> +    TCGv addr = tcg_temp_new_i32();
> +    TCGv H = cpu_r[31];
> +    TCGv L = cpu_r[30];
> +
> +    tcg_gen_shli_tl(addr, H, 8); /* addr = H:L */
> +    tcg_gen_or_tl(addr, addr, L);
> +
> +    tcg_gen_qemu_ld8u(Rd, addr, MMU_CODE_IDX); /* Rd = mem[addr] */
> +
> +    tcg_temp_free_i32(addr);
> +
> +    return true;
> +}
> +
> +
> +static bool trans_LPMX(DisasContext *ctx, arg_LPMX *a)
> +{
> +    if (!avr_have_feature(ctx, AVR_FEATURE_LPMX)) {
> +        return true;
> +    }
> +
> +    TCGv Rd = cpu_r[a->rd];
> +    TCGv addr = tcg_temp_new_i32();
> +    TCGv H = cpu_r[31];
> +    TCGv L = cpu_r[30];
> +
> +    tcg_gen_shli_tl(addr, H, 8); /* addr = H:L */
> +    tcg_gen_or_tl(addr, addr, L);
> +
> +    tcg_gen_qemu_ld8u(Rd, addr, MMU_CODE_IDX); /* Rd = mem[addr] */
> +
> +    tcg_gen_addi_tl(addr, addr, 1); /* addr = addr + 1 */
> +
> +    tcg_gen_andi_tl(L, addr, 0xff);
> +
> +    tcg_gen_shri_tl(addr, addr, 8);
> +    tcg_gen_andi_tl(H, addr, 0xff);
> +
> +    tcg_temp_free_i32(addr);
> +
> +    return true;
> +}
> +
> +
> +/*
> + *  Loads one byte pointed to by the Z-register and the RAMPZ Register in
> + *  the I/O space, and places this byte in the destination register Rd.
> This
> + *  instruction features a 100% space effective constant initialization or
> + *  constant data fetch. The Program memory is organized in 16-bit words
> while
> + *  the Z-pointer is a byte address. Thus, the least significant bit of
> the
> + *  Z-pointer selects either low byte (ZLSB = 0) or high byte (ZLSB = 1).
> This
> + *  instruction can address the entire Program memory space. The Z-pointer
> + *  Register can either be left unchanged by the operation, or it can be
> + *  incremented. The incrementation applies to the entire 24-bit
> concatenation
> + *  of the RAMPZ and Z-pointer Registers.  Devices with Self-Programming
> + *  capability can use the ELPM instruction to read the Fuse and Lock bit
> value.
> + *  Refer to the device documentation for a detailed description.  This
> + *  instruction is not available in all devices. Refer to the device
> specific
> + *  instruction set summary.
> + */
> +static bool trans_ELPM1(DisasContext *ctx, arg_ELPM1 *a)
> +{
> +    if (!avr_have_feature(ctx, AVR_FEATURE_ELPM)) {
> +        return true;
> +    }
> +
> +    TCGv Rd = cpu_r[0];
> +    TCGv addr = gen_get_zaddr();
> +
> +    tcg_gen_qemu_ld8u(Rd, addr, MMU_CODE_IDX); /* Rd = mem[addr] */
> +
> +    tcg_temp_free_i32(addr);
> +
> +    return true;
> +}
> +
> +
> +static bool trans_ELPM2(DisasContext *ctx, arg_ELPM2 *a)
> +{
> +    if (!avr_have_feature(ctx, AVR_FEATURE_ELPM)) {
> +        return true;
> +    }
> +
> +    TCGv Rd = cpu_r[a->rd];
> +    TCGv addr = gen_get_zaddr();
> +
> +    tcg_gen_qemu_ld8u(Rd, addr, MMU_CODE_IDX); /* Rd = mem[addr] */
> +
> +    tcg_temp_free_i32(addr);
> +
> +    return true;
> +}
> +
> +
> +static bool trans_ELPMX(DisasContext *ctx, arg_ELPMX *a)
> +{
> +    if (!avr_have_feature(ctx, AVR_FEATURE_ELPMX)) {
> +        return true;
> +    }
> +
> +    TCGv Rd = cpu_r[a->rd];
> +    TCGv addr = gen_get_zaddr();
> +
> +    tcg_gen_qemu_ld8u(Rd, addr, MMU_CODE_IDX); /* Rd = mem[addr] */
> +
> +    tcg_gen_addi_tl(addr, addr, 1); /* addr = addr + 1 */
> +
> +    gen_set_zaddr(addr);
> +
> +    tcg_temp_free_i32(addr);
> +
> +    return true;
> +}
> +
> +
> +/*
> + *  SPM can be used to erase a page in the Program memory, to write a page
> + *  in the Program memory (that is already erased), and to set Boot
> Loader Lock
> + *  bits. In some devices, the Program memory can be written one word at
> a time,
> + *  in other devices an entire page can be programmed simultaneously
> after first
> + *  filling a temporary page buffer. In all cases, the Program memory
> must be
> + *  erased one page at a time. When erasing the Program memory, the RAMPZ
> and
> + *  Z-register are used as page address. When writing the Program memory,
> the
> + *  RAMPZ and Z-register are used as page or word address, and the R1:R0
> + *  register pair is used as data(1). When setting the Boot Loader Lock
> bits,
> + *  the R1:R0 register pair is used as data. Refer to the device
> documentation
> + *  for detailed description of SPM usage. This instruction can address
> the
> + *  entire Program memory.  The SPM instruction is not available in all
> devices.
> + *  Refer to the device specific instruction set summary.  Note: 1. R1
> + *  determines the instruction high byte, and R0 determines the
> instruction low
> + *  byte.
> + */
> +static bool trans_SPM(DisasContext *ctx, arg_SPM *a)
> +{
> +    /* TODO */
> +    if (!avr_have_feature(ctx, AVR_FEATURE_SPM)) {
> +        return true;
> +    }
> +
> +    return true;
> +}
> +
> +
> +static bool trans_SPMX(DisasContext *ctx, arg_SPMX *a)
> +{
> +    /* TODO */
> +    if (!avr_have_feature(ctx, AVR_FEATURE_SPMX)) {
> +        return true;
> +    }
> +
> +    return true;
> +}
> +
> +
> +/*
> + *  Loads data from the I/O Space (Ports, Timers, Configuration Registers,
> + *  etc.) into register Rd in the Register File.
> + */
> +static bool trans_IN(DisasContext *ctx, arg_IN *a)
> +{
> +    TCGv Rd = cpu_r[a->rd];
> +    TCGv port = tcg_const_i32(a->imm);
> +
> +    gen_helper_inb(Rd, cpu_env, port);
> +
> +    tcg_temp_free_i32(port);
> +
> +    return true;
> +}
> +
> +
> +/*
> + *  Stores data from register Rr in the Register File to I/O Space (Ports,
> + *  Timers, Configuration Registers, etc.).
> + */
> +static bool trans_OUT(DisasContext *ctx, arg_OUT *a)
> +{
> +    TCGv Rd = cpu_r[a->rd];
> +    TCGv port = tcg_const_i32(a->imm);
> +
> +    gen_helper_outb(cpu_env, port, Rd);
> +
> +    tcg_temp_free_i32(port);
> +
> +    return true;
> +}
> +
> +
> +/*
> + *  This instruction stores the contents of register Rr on the STACK. The
> + *  Stack Pointer is post-decremented by 1 after the PUSH.  This
> instruction is
> + *  not available in all devices. Refer to the device specific
> instruction set
> + *  summary.
> + */
> +static bool trans_PUSH(DisasContext *ctx, arg_PUSH *a)
> +{
> +    TCGv Rd = cpu_r[a->rd];
> +
> +    gen_data_store(ctx, Rd, cpu_sp);
> +    tcg_gen_subi_tl(cpu_sp, cpu_sp, 1);
> +
> +    return true;
> +}
> +
> +
> +/*
> + *  This instruction loads register Rd with a byte from the STACK. The
> Stack
> + *  Pointer is pre-incremented by 1 before the POP.  This instruction is
> not
> + *  available in all devices. Refer to the device specific instruction set
> + *  summary.
> + */
> +static bool trans_POP(DisasContext *ctx, arg_POP *a)
> +{
> +    /*
> +     * Using a temp to work around some strange behaviour:
> +     * tcg_gen_addi_tl(cpu_sp, cpu_sp, 1);
> +     * gen_data_load(ctx, Rd, cpu_sp);
> +     * seems to cause the add to happen twice.
> +     * This doesn't happen if either the add or the load is removed.
> +     */
> +    TCGv t1 = tcg_temp_new_i32();
> +    TCGv Rd = cpu_r[a->rd];
> +
> +    tcg_gen_addi_tl(t1, cpu_sp, 1);
> +    gen_data_load(ctx, Rd, t1);
> +    tcg_gen_mov_tl(cpu_sp, t1);
> +
> +    return true;
> +}
> +
> +
> +/*
> + *  Exchanges one byte indirect between register and data space.  The data
> + *  location is pointed to by the Z (16 bits) Pointer Register in the
> Register
> + *  File. Memory access is limited to the current data segment of 64KB. To
> + *  access another data segment in devices with more than 64KB data
> space, the
> + *  RAMPZ in register in the I/O area has to be changed.  The Z-pointer
> Register
> + *  is left unchanged by the operation. This instruction is especially
> suited
> + *  for writing/reading status bits stored in SRAM.
> + */
> +static bool trans_XCH(DisasContext *ctx, arg_XCH *a)
> +{
> +    if (!avr_have_feature(ctx, AVR_FEATURE_RMW)) {
> +        return true;
> +    }
> +
> +    TCGv Rd = cpu_r[a->rd];
> +    TCGv t0 = tcg_temp_new_i32();
> +    TCGv addr = gen_get_zaddr();
> +
> +    gen_data_load(ctx, t0, addr);
> +    gen_data_store(ctx, Rd, addr);
> +    tcg_gen_mov_tl(Rd, t0);
> +
> +    tcg_temp_free_i32(t0);
> +    tcg_temp_free_i32(addr);
> +
> +    return true;
> +}
> +
> +
> +/*
> + *  Load one byte indirect from data space to register and set bits in
> data
> + *  space specified by the register. The instruction can only be used
> towards
> + *  internal SRAM.  The data location is pointed to by the Z (16 bits)
> Pointer
> + *  Register in the Register File. Memory access is limited to the
> current data
> + *  segment of 64KB. To access another data segment in devices with more
> than
> + *  64KB data space, the RAMPZ in register in the I/O area has to be
> changed.
> + *  The Z-pointer Register is left unchanged by the operation. This
> instruction
> + *  is especially suited for setting status bits stored in SRAM.
> + */
> +static bool trans_LAS(DisasContext *ctx, arg_LAS *a)
> +{
> +    if (!avr_have_feature(ctx, AVR_FEATURE_RMW)) {
> +        return true;
> +    }
> +
> +    TCGv Rr = cpu_r[a->rd];
> +    TCGv addr = gen_get_zaddr();
> +    TCGv t0 = tcg_temp_new_i32();
> +    TCGv t1 = tcg_temp_new_i32();
> +
> +    gen_data_load(ctx, t0, addr); /* t0 = mem[addr] */
> +    tcg_gen_or_tl(t1, t0, Rr);
> +
> +    tcg_gen_mov_tl(Rr, t0); /* Rr = t0 */
> +    gen_data_store(ctx, t1, addr); /* mem[addr] = t1 */
> +
> +    tcg_temp_free_i32(t1);
> +    tcg_temp_free_i32(t0);
> +    tcg_temp_free_i32(addr);
> +
> +    return true;
> +}
> +
> +
> +/*
> + *  Load one byte indirect from data space to register and stores and
> clear
> + *  the bits in data space specified by the register. The instruction can
> + *  only be used towards internal SRAM.  The data location is pointed to
> by
> + *  the Z (16 bits) Pointer Register in the Register File. Memory access
> is
> + *  limited to the current data segment of 64KB. To access another data
> + *  segment in devices with more than 64KB data space, the RAMPZ in
> register
> + *  in the I/O area has to be changed.  The Z-pointer Register is left
> + *  unchanged by the operation. This instruction is especially suited for
> + *  clearing status bits stored in SRAM.
> + */
> +static bool trans_LAC(DisasContext *ctx, arg_LAC *a)
> +{
> +    if (!avr_have_feature(ctx, AVR_FEATURE_RMW)) {
> +        return true;
> +    }
> +
> +    TCGv Rr = cpu_r[a->rd];
> +    TCGv addr = gen_get_zaddr();
> +    TCGv t0 = tcg_temp_new_i32();
> +    TCGv t1 = tcg_temp_new_i32();
> +
> +    gen_data_load(ctx, t0, addr); /* t0 = mem[addr] */
> +        /* t1 = t0 & (0xff - Rr) = t0 and ~Rr */
> +    tcg_gen_andc_tl(t1, t0, Rr);
> +
> +    tcg_gen_mov_tl(Rr, t0); /* Rr = t0 */
> +    gen_data_store(ctx, t1, addr); /* mem[addr] = t1 */
> +
> +    tcg_temp_free_i32(t1);
> +    tcg_temp_free_i32(t0);
> +    tcg_temp_free_i32(addr);
> +
> +    return true;
> +}
> +
> +
> +/*
> + *  Load one byte indirect from data space to register and toggles bits in
> + *  the data space specified by the register.  The instruction can only
> be used
> + *  towards SRAM.  The data location is pointed to by the Z (16 bits)
> Pointer
> + *  Register in the Register File. Memory access is limited to the
> current data
> + *  segment of 64KB. To access another data segment in devices with more
> than
> + *  64KB data space, the RAMPZ in register in the I/O area has to be
> changed.
> + *  The Z-pointer Register is left unchanged by the operation. This
> instruction
> + *  is especially suited for changing status bits stored in SRAM.
> + */
> +static bool trans_LAT(DisasContext *ctx, arg_LAT *a)
> +{
> +    if (!avr_have_feature(ctx, AVR_FEATURE_RMW)) {
> +        return true;
> +    }
> +
> +    TCGv Rd = cpu_r[a->rd];
> +    TCGv addr = gen_get_zaddr();
> +    TCGv t0 = tcg_temp_new_i32();
> +    TCGv t1 = tcg_temp_new_i32();
> +
> +    gen_data_load(ctx, t0, addr); /* t0 = mem[addr] */
> +    tcg_gen_xor_tl(t1, t0, Rd);
> +
> +    tcg_gen_mov_tl(Rd, t0); /* Rd = t0 */
> +    gen_data_store(ctx, t1, addr); /* mem[addr] = t1 */
> +
> +    tcg_temp_free_i32(t1);
> +    tcg_temp_free_i32(t0);
> +    tcg_temp_free_i32(addr);
> +
> +    return true;
> +}
> +
> +
> +/*
> + *  Shifts all bits in Rd one place to the right. Bit 7 is cleared. Bit 0
> is
> + *  loaded into the C Flag of the SREG. This operation effectively
> divides an
> + *  unsigned value by two. The C Flag can be used to round the result.
> + */
> +static bool trans_LSR(DisasContext *ctx, arg_LSR *a)
> +{
> +    TCGv Rd = cpu_r[a->rd];
> +
> +    tcg_gen_andi_tl(cpu_Cf, Rd, 1);
> +
> +    tcg_gen_shri_tl(Rd, Rd, 1);
> +
> +    tcg_gen_setcondi_tl(TCG_COND_EQ, cpu_Zf, Rd, 0); /* Zf = Rd == 0 */
> +    tcg_gen_movi_tl(cpu_Nf, 0);
> +    tcg_gen_mov_tl(cpu_Vf, cpu_Cf);
> +    tcg_gen_mov_tl(cpu_Sf, cpu_Vf);
> +
> +    return true;
> +}
> +
> +
> +/*
> + *  Shifts all bits in Rd one place to the right. The C Flag is shifted
> into
> + *  bit 7 of Rd. Bit 0 is shifted into the C Flag.  This operation,
> combined
> + *  with ASR, effectively divides multi-byte signed values by two.
> Combined with
> + *  LSR it effectively divides multi-byte unsigned values by two. The
> Carry Flag
> + *  can be used to round the result.
> + */
> +static bool trans_ROR(DisasContext *ctx, arg_ROR *a)
> +{
> +    TCGv Rd = cpu_r[a->rd];
> +    TCGv t0 = tcg_temp_new_i32();
> +
> +    tcg_gen_shli_tl(t0, cpu_Cf, 7);
> +    tcg_gen_andi_tl(cpu_Cf, Rd, 1);
> +    tcg_gen_shri_tl(Rd, Rd, 1);
> +    tcg_gen_or_tl(Rd, Rd, t0);
> +
> +    gen_rshift_ZNVSf(Rd);
> +
> +    tcg_temp_free_i32(t0);
> +
> +    return true;
> +}
> +
> +
> +/*
> + *  Shifts all bits in Rd one place to the right. Bit 7 is held constant.
> Bit 0
> + *  is loaded into the C Flag of the SREG. This operation effectively
> divides a
> + *  signed value by two without changing its sign. The Carry Flag can be
> used to
> + *  round the result.
> + */
> +static bool trans_ASR(DisasContext *ctx, arg_ASR *a)
> +{
> +    TCGv Rd = cpu_r[a->rd];
> +    TCGv t0 = tcg_temp_new_i32();
> +
> +    /* Cf */
> +    tcg_gen_andi_tl(cpu_Cf, Rd, 1); /* Cf = Rd(0) */
> +
> +    /* op */
> +    tcg_gen_andi_tl(t0, Rd, 0x80); /* Rd = (Rd & 0x80) | (Rd >> 1) */
> +    tcg_gen_shri_tl(Rd, Rd, 1);
> +    tcg_gen_or_tl(Rd, Rd, t0);
> +
> +    gen_rshift_ZNVSf(Rd);
> +
> +    tcg_temp_free_i32(t0);
> +
> +    return true;
> +}
> +
> +
> +/*
> + *  Swaps high and low nibbles in a register.
> + */
> +static bool trans_SWAP(DisasContext *ctx, arg_SWAP *a)
> +{
> +    TCGv Rd = cpu_r[a->rd];
> +    TCGv t0 = tcg_temp_new_i32();
> +    TCGv t1 = tcg_temp_new_i32();
> +
> +    tcg_gen_andi_tl(t0, Rd, 0x0f);
> +    tcg_gen_shli_tl(t0, t0, 4);
> +    tcg_gen_andi_tl(t1, Rd, 0xf0);
> +    tcg_gen_shri_tl(t1, t1, 4);
> +    tcg_gen_or_tl(Rd, t0, t1);
> +
> +    tcg_temp_free_i32(t1);
> +    tcg_temp_free_i32(t0);
> +
> +    return true;
> +}
> +
> +
> +/*
> + *  Sets a specified bit in an I/O Register. This instruction operates on
> + *  the lower 32 I/O Registers -- addresses 0-31.
> + */
> +static bool trans_SBI(DisasContext *ctx, arg_SBI *a)
> +{
> +    TCGv data = tcg_temp_new_i32();
> +    TCGv port = tcg_const_i32(a->reg);
> +
> +    gen_helper_inb(data, cpu_env, port);
> +    tcg_gen_ori_tl(data, data, 1 << a->bit);
> +    gen_helper_outb(cpu_env, port, data);
> +
> +    tcg_temp_free_i32(port);
> +    tcg_temp_free_i32(data);
> +
> +    return true;
> +}
> +
> +
> +/*
> + *  Clears a specified bit in an I/O Register. This instruction operates
> on
> + *  the lower 32 I/O Registers -- addresses 0-31.
> + */
> +static bool trans_CBI(DisasContext *ctx, arg_CBI *a)
> +{
> +    TCGv data = tcg_temp_new_i32();
> +    TCGv port = tcg_const_i32(a->reg);
> +
> +    gen_helper_inb(data, cpu_env, port);
> +    tcg_gen_andi_tl(data, data, ~(1 << a->bit));
> +    gen_helper_outb(cpu_env, port, data);
> +
> +    tcg_temp_free_i32(data);
> +    tcg_temp_free_i32(port);
> +
> +    return true;
> +}
> +
> +
> +/*
> + *  Stores bit b from Rd to the T Flag in SREG (Status Register).
> + */
> +static bool trans_BST(DisasContext *ctx, arg_BST *a)
> +{
> +    TCGv Rd = cpu_r[a->rd];
> +
> +    tcg_gen_andi_tl(cpu_Tf, Rd, 1 << a->bit);
> +    tcg_gen_shri_tl(cpu_Tf, cpu_Tf, a->bit);
> +
> +    return true;
> +}
> +
> +
> +/*
> + *  Copies the T Flag in the SREG (Status Register) to bit b in register
> Rd.
> + */
> +static bool trans_BLD(DisasContext *ctx, arg_BLD *a)
> +{
> +    TCGv Rd = cpu_r[a->rd];
> +    TCGv t1 = tcg_temp_new_i32();
> +
> +    tcg_gen_andi_tl(Rd, Rd, ~(1u << a->bit)); /* clear bit */
> +    tcg_gen_shli_tl(t1, cpu_Tf, a->bit); /* create mask */
> +    tcg_gen_or_tl(Rd, Rd, t1);
> +
> +    tcg_temp_free_i32(t1);
> +
> +    return true;
> +}
> +
> +
> +/*
> + *  Sets a single Flag or bit in SREG.
> + */
> +static bool trans_BSET(DisasContext *ctx, arg_BSET *a)
> +{
> +    switch (a->bit) {
> +    case 0x00:
> +        tcg_gen_movi_tl(cpu_Cf, 0x01);
> +        break;
> +    case 0x01:
> +        tcg_gen_movi_tl(cpu_Zf, 0x01);
> +        break;
> +    case 0x02:
> +        tcg_gen_movi_tl(cpu_Nf, 0x01);
> +        break;
> +    case 0x03:
> +        tcg_gen_movi_tl(cpu_Vf, 0x01);
> +        break;
> +    case 0x04:
> +        tcg_gen_movi_tl(cpu_Sf, 0x01);
> +        break;
> +    case 0x05:
> +        tcg_gen_movi_tl(cpu_Hf, 0x01);
> +        break;
> +    case 0x06:
> +        tcg_gen_movi_tl(cpu_Tf, 0x01);
> +        break;
> +    case 0x07:
> +        tcg_gen_movi_tl(cpu_If, 0x01);
> +        break;
> +    }
> +
> +    return true;
> +}
> +
> +
> +/*
> + *  Clears a single Flag in SREG.
> + */
> +static bool trans_BCLR(DisasContext *ctx, arg_BCLR *a)
> +{
> +    switch (a->bit) {
> +    case 0x00:
> +        tcg_gen_movi_tl(cpu_Cf, 0x00);
> +        break;
> +    case 0x01:
> +        tcg_gen_movi_tl(cpu_Zf, 0x00);
> +        break;
> +    case 0x02:
> +        tcg_gen_movi_tl(cpu_Nf, 0x00);
> +        break;
> +    case 0x03:
> +        tcg_gen_movi_tl(cpu_Vf, 0x00);
> +        break;
> +    case 0x04:
> +        tcg_gen_movi_tl(cpu_Sf, 0x00);
> +        break;
> +    case 0x05:
> +        tcg_gen_movi_tl(cpu_Hf, 0x00);
> +        break;
> +    case 0x06:
> +        tcg_gen_movi_tl(cpu_Tf, 0x00);
> +        break;
> +    case 0x07:
> +        tcg_gen_movi_tl(cpu_If, 0x00);
> +        break;
> +    }
> +
> +    return true;
> +}
> --
> 2.17.2 (Apple Git-113)
>
>

--000000000000302e930598f410dc
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<br><br>On Wednesday, November 27, 2019, Michael Rolnik &lt;<a href=3D"mail=
to:mrolnik@gmail.com">mrolnik@gmail.com</a>&gt; wrote:<br><blockquote class=
=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padd=
ing-left:1ex">This includes:<br>
=C2=A0 =C2=A0 - LSR, ROR<br>
=C2=A0 =C2=A0 - ASR<br>
=C2=A0 =C2=A0 - SWAP<br>
=C2=A0 =C2=A0 - SBI, CBI<br>
=C2=A0 =C2=A0 - BST, BLD<br>
=C2=A0 =C2=A0 - BSET, BCLR<br>
<br>
Signed-off-by: Michael Rolnik &lt;<a href=3D"mailto:mrolnik@gmail.com">mrol=
nik@gmail.com</a>&gt;<br>
---<br>
=C2=A0target/avr/translate.c | 1123 ++++++++++++++++++++++++++++++<wbr>++++=
++++++<br>
=C2=A01 file changed, 1123 insertions(+)<br>
<br></blockquote><div><br></div><div>Hello, Michael</div><div><br></div><di=
v>I said I am on vacation, and truly I am, but, fir the next version if the=
 series, I would like to ask you to extract &quot;data transfer&quot; instr=
uction (as defined in avr docs, MOV LD ST etc) from this patch, and create =
a new patch for them - so that the patches follow the division from docs.</=
div><div><br></div><div>Yours,</div><div>Aleksandar</div><div><br></div><di=
v><br></div><div><br></div><div>=C2=A0</div><blockquote class=3D"gmail_quot=
e" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">
diff --git a/target/avr/translate.c b/target/avr/translate.c<br>
index 48a42c984a..dc6a1af2fc 100644<br>
--- a/target/avr/translate.c<br>
+++ b/target/avr/translate.c<br>
@@ -317,6 +317,15 @@ static void gen_goto_tb(DisasContext *ctx, int n, targ=
et_ulong dest)<br>
=C2=A0}<br>
<br>
<br>
+static void gen_rshift_ZNVSf(TCGv R)<br>
+{<br>
+=C2=A0 =C2=A0 tcg_gen_setcondi_tl(TCG_COND_<wbr>EQ, cpu_Zf, R, 0); /* Zf =
=3D R =3D=3D 0 */<br>
+=C2=A0 =C2=A0 tcg_gen_shri_tl(cpu_Nf, R, 7); /* Nf =3D R(7) */<br>
+=C2=A0 =C2=A0 tcg_gen_xor_tl(cpu_Vf, cpu_Nf, cpu_Cf);<br>
+=C2=A0 =C2=A0 tcg_gen_xor_tl(cpu_Sf, cpu_Nf, cpu_Vf); /* Sf =3D Nf ^ Vf */=
<br>
+}<br>
+<br>
+<br>
=C2=A0/*<br>
=C2=A0 *=C2=A0 Adds two registers without the C Flag and places the result =
in the<br>
=C2=A0 *=C2=A0 destination register Rd.<br>
@@ -1508,3 +1517,1117 @@ static bool trans_BRBS(DisasContext *ctx, arg_BRBS=
 *a)<br>
=C2=A0 =C2=A0 =C2=A0return true;<br>
=C2=A0}<br>
<br>
+<br>
+/*<br>
+ *=C2=A0 This instruction makes a copy of one register into another. The s=
ource<br>
+ *=C2=A0 register Rr is left unchanged, while the destination register Rd =
is loaded<br>
+ *=C2=A0 with a copy of Rr.<br>
+ */<br>
+static bool trans_MOV(DisasContext *ctx, arg_MOV *a)<br>
+{<br>
+=C2=A0 =C2=A0 TCGv Rd =3D cpu_r[a-&gt;rd];<br>
+=C2=A0 =C2=A0 TCGv Rr =3D cpu_r[a-&gt;rr];<br>
+<br>
+=C2=A0 =C2=A0 tcg_gen_mov_tl(Rd, Rr);<br>
+<br>
+=C2=A0 =C2=A0 return true;<br>
+}<br>
+<br>
+<br>
+/*<br>
+ *=C2=A0 This instruction makes a copy of one register pair into another r=
egister<br>
+ *=C2=A0 pair. The source register pair Rr+1:Rr is left unchanged, while t=
he<br>
+ *=C2=A0 destination register pair Rd+1:Rd is loaded with a copy of Rr + 1=
:Rr.=C2=A0 This<br>
+ *=C2=A0 instruction is not available in all devices. Refer to the device =
specific<br>
+ *=C2=A0 instruction set summary.<br>
+ */<br>
+static bool trans_MOVW(DisasContext *ctx, arg_MOVW *a)<br>
+{<br>
+=C2=A0 =C2=A0 if (!avr_have_feature(ctx, AVR_FEATURE_MOVW)) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return true;<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 TCGv RdL =3D cpu_r[a-&gt;rd];<br>
+=C2=A0 =C2=A0 TCGv RdH =3D cpu_r[a-&gt;rd + 1];<br>
+=C2=A0 =C2=A0 TCGv RrL =3D cpu_r[a-&gt;rr];<br>
+=C2=A0 =C2=A0 TCGv RrH =3D cpu_r[a-&gt;rr + 1];<br>
+<br>
+=C2=A0 =C2=A0 tcg_gen_mov_tl(RdH, RrH);<br>
+=C2=A0 =C2=A0 tcg_gen_mov_tl(RdL, RrL);<br>
+<br>
+=C2=A0 =C2=A0 return true;<br>
+}<br>
+<br>
+<br>
+/*<br>
+ * Loads an 8 bit constant directly to register 16 to 31.<br>
+ */<br>
+static bool trans_LDI(DisasContext *ctx, arg_LDI *a)<br>
+{<br>
+=C2=A0 =C2=A0 TCGv Rd =3D cpu_r[a-&gt;rd];<br>
+=C2=A0 =C2=A0 int imm =3D a-&gt;imm;<br>
+<br>
+=C2=A0 =C2=A0 tcg_gen_movi_tl(Rd, imm);<br>
+<br>
+=C2=A0 =C2=A0 return true;<br>
+}<br>
+<br>
+<br>
+/*<br>
+ *=C2=A0 Loads one byte from the data space to a register. For parts with =
SRAM,<br>
+ *=C2=A0 the data space consists of the Register File, I/O memory and inte=
rnal SRAM<br>
+ *=C2=A0 (and external SRAM if applicable). For parts without SRAM, the da=
ta space<br>
+ *=C2=A0 consists of the register file only. The EEPROM has a separate add=
ress space.<br>
+ *=C2=A0 A 16-bit address must be supplied. Memory access is limited to th=
e current<br>
+ *=C2=A0 data segment of 64KB. The LDS instruction uses the RAMPD Register=
 to access<br>
+ *=C2=A0 memory above 64KB. To access another data segment in devices with=
 more than<br>
+ *=C2=A0 64KB data space, the RAMPD in register in the I/O area has to be =
changed.<br>
+ *=C2=A0 This instruction is not available in all devices. Refer to the de=
vice<br>
+ *=C2=A0 specific instruction set summary.<br>
+ */<br>
+static bool trans_LDS(DisasContext *ctx, arg_LDS *a)<br>
+{<br>
+=C2=A0 =C2=A0 TCGv Rd =3D cpu_r[a-&gt;rd];<br>
+=C2=A0 =C2=A0 TCGv addr =3D tcg_temp_new_i32();<br>
+=C2=A0 =C2=A0 TCGv H =3D cpu_rampD;<br>
+=C2=A0 =C2=A0 a-&gt;imm =3D next_word(ctx);<br>
+<br>
+=C2=A0 =C2=A0 tcg_gen_mov_tl(addr, H); /* addr =3D H:M:L */<br>
+=C2=A0 =C2=A0 tcg_gen_shli_tl(addr, addr, 16);<br>
+=C2=A0 =C2=A0 tcg_gen_ori_tl(addr, addr, a-&gt;imm);<br>
+<br>
+=C2=A0 =C2=A0 gen_data_load(ctx, Rd, addr);<br>
+<br>
+=C2=A0 =C2=A0 tcg_temp_free_i32(addr);<br>
+<br>
+=C2=A0 =C2=A0 return true;<br>
+}<br>
+<br>
+<br>
+/*<br>
+ *=C2=A0 Loads one byte indirect from the data space to a register. For pa=
rts<br>
+ *=C2=A0 with SRAM, the data space consists of the Register File, I/O memo=
ry and<br>
+ *=C2=A0 internal SRAM (and external SRAM if applicable). For parts withou=
t SRAM, the<br>
+ *=C2=A0 data space consists of the Register File only. In some parts the =
Flash<br>
+ *=C2=A0 Memory has been mapped to the data space and can be read using th=
is command.<br>
+ *=C2=A0 The EEPROM has a separate address space.=C2=A0 The data location =
is pointed to by<br>
+ *=C2=A0 the X (16 bits) Pointer Register in the Register File. Memory acc=
ess is<br>
+ *=C2=A0 limited to the current data segment of 64KB. To access another da=
ta segment<br>
+ *=C2=A0 in devices with more than 64KB data space, the RAMPX in register =
in the I/O<br>
+ *=C2=A0 area has to be changed.=C2=A0 The X-pointer Register can either b=
e left unchanged<br>
+ *=C2=A0 by the operation, or it can be post-incremented or predecremented=
.=C2=A0 These<br>
+ *=C2=A0 features are especially suited for accessing arrays, tables, and =
Stack<br>
+ *=C2=A0 Pointer usage of the X-pointer Register. Note that only the low b=
yte of the<br>
+ *=C2=A0 X-pointer is updated in devices with no more than 256 bytes data =
space. For<br>
+ *=C2=A0 such devices, the high byte of the pointer is not used by this in=
struction<br>
+ *=C2=A0 and can be used for other purposes. The RAMPX Register in the I/O=
 area is<br>
+ *=C2=A0 updated in parts with more than 64KB data space or more than 64KB=
 Program<br>
+ *=C2=A0 memory, and the increment/decrement is added to the entire 24-bit=
 address on<br>
+ *=C2=A0 such devices.=C2=A0 Not all variants of this instruction is avail=
able in all<br>
+ *=C2=A0 devices. Refer to the device specific instruction set summary.=C2=
=A0 In the<br>
+ *=C2=A0 Reduced Core tinyAVR the LD instruction can be used to achieve th=
e same<br>
+ *=C2=A0 operation as LPM since the program memory is mapped to the data m=
emory<br>
+ *=C2=A0 space.<br>
+ */<br>
+static bool trans_LDX1(DisasContext *ctx, arg_LDX1 *a)<br>
+{<br>
+=C2=A0 =C2=A0 TCGv Rd =3D cpu_r[a-&gt;rd];<br>
+=C2=A0 =C2=A0 TCGv addr =3D gen_get_xaddr();<br>
+<br>
+=C2=A0 =C2=A0 gen_data_load(ctx, Rd, addr);<br>
+<br>
+=C2=A0 =C2=A0 tcg_temp_free_i32(addr);<br>
+<br>
+=C2=A0 =C2=A0 return true;<br>
+}<br>
+<br>
+<br>
+static bool trans_LDX2(DisasContext *ctx, arg_LDX2 *a)<br>
+{<br>
+=C2=A0 =C2=A0 TCGv Rd =3D cpu_r[a-&gt;rd];<br>
+=C2=A0 =C2=A0 TCGv addr =3D gen_get_xaddr();<br>
+<br>
+=C2=A0 =C2=A0 gen_data_load(ctx, Rd, addr);<br>
+=C2=A0 =C2=A0 tcg_gen_addi_tl(addr, addr, 1); /* addr =3D addr + 1 */<br>
+<br>
+=C2=A0 =C2=A0 gen_set_xaddr(addr);<br>
+<br>
+=C2=A0 =C2=A0 tcg_temp_free_i32(addr);<br>
+<br>
+=C2=A0 =C2=A0 return true;<br>
+}<br>
+<br>
+<br>
+static bool trans_LDX3(DisasContext *ctx, arg_LDX3 *a)<br>
+{<br>
+=C2=A0 =C2=A0 TCGv Rd =3D cpu_r[a-&gt;rd];<br>
+=C2=A0 =C2=A0 TCGv addr =3D gen_get_xaddr();<br>
+<br>
+=C2=A0 =C2=A0 tcg_gen_subi_tl(addr, addr, 1); /* addr =3D addr - 1 */<br>
+=C2=A0 =C2=A0 gen_data_load(ctx, Rd, addr);<br>
+=C2=A0 =C2=A0 gen_set_xaddr(addr);<br>
+<br>
+=C2=A0 =C2=A0 tcg_temp_free_i32(addr);<br>
+<br>
+=C2=A0 =C2=A0 return true;<br>
+}<br>
+<br>
+<br>
+static bool trans_STX1(DisasContext *ctx, arg_STX1 *a)<br>
+{<br>
+=C2=A0 =C2=A0 TCGv Rd =3D cpu_r[a-&gt;rr];<br>
+=C2=A0 =C2=A0 TCGv addr =3D gen_get_xaddr();<br>
+<br>
+=C2=A0 =C2=A0 gen_data_store(ctx, Rd, addr);<br>
+<br>
+=C2=A0 =C2=A0 tcg_temp_free_i32(addr);<br>
+<br>
+=C2=A0 =C2=A0 return true;<br>
+}<br>
+<br>
+static bool trans_STX2(DisasContext *ctx, arg_STX2 *a)<br>
+{<br>
+=C2=A0 =C2=A0 TCGv Rd =3D cpu_r[a-&gt;rr];<br>
+=C2=A0 =C2=A0 TCGv addr =3D gen_get_xaddr();<br>
+<br>
+=C2=A0 =C2=A0 gen_data_store(ctx, Rd, addr);<br>
+=C2=A0 =C2=A0 tcg_gen_addi_tl(addr, addr, 1); /* addr =3D addr + 1 */<br>
+=C2=A0 =C2=A0 gen_set_xaddr(addr);<br>
+<br>
+=C2=A0 =C2=A0 tcg_temp_free_i32(addr);<br>
+<br>
+=C2=A0 =C2=A0 return true;<br>
+}<br>
+<br>
+static bool trans_STX3(DisasContext *ctx, arg_STX3 *a)<br>
+{<br>
+=C2=A0 =C2=A0 TCGv Rd =3D cpu_r[a-&gt;rr];<br>
+=C2=A0 =C2=A0 TCGv addr =3D gen_get_xaddr();<br>
+<br>
+=C2=A0 =C2=A0 tcg_gen_subi_tl(addr, addr, 1); /* addr =3D addr - 1 */<br>
+=C2=A0 =C2=A0 gen_data_store(ctx, Rd, addr);<br>
+=C2=A0 =C2=A0 gen_set_xaddr(addr);<br>
+<br>
+=C2=A0 =C2=A0 tcg_temp_free_i32(addr);<br>
+<br>
+=C2=A0 =C2=A0 return true;<br>
+}<br>
+<br>
+<br>
+/*<br>
+ *=C2=A0 Loads one byte indirect with or without displacement from the dat=
a space<br>
+ *=C2=A0 to a register. For parts with SRAM, the data space consists of th=
e Register<br>
+ *=C2=A0 File, I/O memory and internal SRAM (and external SRAM if applicab=
le). For<br>
+ *=C2=A0 parts without SRAM, the data space consists of the Register File =
only. In<br>
+ *=C2=A0 some parts the Flash Memory has been mapped to the data space and=
 can be<br>
+ *=C2=A0 read using this command. The EEPROM has a separate address space.=
=C2=A0 The data<br>
+ *=C2=A0 location is pointed to by the Y (16 bits) Pointer Register in the=
 Register<br>
+ *=C2=A0 File. Memory access is limited to the current data segment of 64K=
B. To<br>
+ *=C2=A0 access another data segment in devices with more than 64KB data s=
pace, the<br>
+ *=C2=A0 RAMPY in register in the I/O area has to be changed.=C2=A0 The Y-=
pointer Register<br>
+ *=C2=A0 can either be left unchanged by the operation, or it can be post-=
incremented<br>
+ *=C2=A0 or predecremented.=C2=A0 These features are especially suited for=
 accessing<br>
+ *=C2=A0 arrays, tables, and Stack Pointer usage of the Y-pointer Register=
. Note that<br>
+ *=C2=A0 only the low byte of the Y-pointer is updated in devices with no =
more than<br>
+ *=C2=A0 256 bytes data space. For such devices, the high byte of the poin=
ter is not<br>
+ *=C2=A0 used by this instruction and can be used for other purposes. The =
RAMPY<br>
+ *=C2=A0 Register in the I/O area is updated in parts with more than 64KB =
data space<br>
+ *=C2=A0 or more than 64KB Program memory, and the increment/decrement/<wb=
r>displacement<br>
+ *=C2=A0 is added to the entire 24-bit address on such devices.=C2=A0 Not =
all variants of<br>
+ *=C2=A0 this instruction is available in all devices. Refer to the device=
 specific<br>
+ *=C2=A0 instruction set summary.=C2=A0 In the Reduced Core tinyAVR the LD=
 instruction can<br>
+ *=C2=A0 be used to achieve the same operation as LPM since the program me=
mory is<br>
+ *=C2=A0 mapped to the data memory space.<br>
+ */<br>
+static bool trans_LDY2(DisasContext *ctx, arg_LDY2 *a)<br>
+{<br>
+=C2=A0 =C2=A0 TCGv Rd =3D cpu_r[a-&gt;rd];<br>
+=C2=A0 =C2=A0 TCGv addr =3D gen_get_yaddr();<br>
+<br>
+=C2=A0 =C2=A0 gen_data_load(ctx, Rd, addr);<br>
+=C2=A0 =C2=A0 tcg_gen_addi_tl(addr, addr, 1); /* addr =3D addr + 1 */<br>
+<br>
+=C2=A0 =C2=A0 gen_set_yaddr(addr);<br>
+<br>
+=C2=A0 =C2=A0 tcg_temp_free_i32(addr);<br>
+<br>
+=C2=A0 =C2=A0 return true;<br>
+}<br>
+<br>
+<br>
+static bool trans_LDY3(DisasContext *ctx, arg_LDY3 *a)<br>
+{<br>
+=C2=A0 =C2=A0 TCGv Rd =3D cpu_r[a-&gt;rd];<br>
+=C2=A0 =C2=A0 TCGv addr =3D gen_get_yaddr();<br>
+<br>
+=C2=A0 =C2=A0 tcg_gen_subi_tl(addr, addr, 1); /* addr =3D addr - 1 */<br>
+=C2=A0 =C2=A0 gen_data_load(ctx, Rd, addr);<br>
+=C2=A0 =C2=A0 gen_set_yaddr(addr);<br>
+<br>
+=C2=A0 =C2=A0 tcg_temp_free_i32(addr);<br>
+<br>
+=C2=A0 =C2=A0 return true;<br>
+}<br>
+<br>
+<br>
+static bool trans_LDDY(DisasContext *ctx, arg_LDDY *a)<br>
+{<br>
+=C2=A0 =C2=A0 TCGv Rd =3D cpu_r[a-&gt;rd];<br>
+=C2=A0 =C2=A0 TCGv addr =3D gen_get_yaddr();<br>
+<br>
+=C2=A0 =C2=A0 tcg_gen_addi_tl(addr, addr, a-&gt;imm); /* addr =3D addr + q=
 */<br>
+=C2=A0 =C2=A0 gen_data_load(ctx, Rd, addr);<br>
+<br>
+=C2=A0 =C2=A0 tcg_temp_free_i32(addr);<br>
+<br>
+=C2=A0 =C2=A0 return true;<br>
+}<br>
+<br>
+<br>
+static bool trans_STY2(DisasContext *ctx, arg_STY2 *a)<br>
+{<br>
+=C2=A0 =C2=A0 TCGv Rd =3D cpu_r[a-&gt;rd];<br>
+=C2=A0 =C2=A0 TCGv addr =3D gen_get_yaddr();<br>
+<br>
+=C2=A0 =C2=A0 gen_data_store(ctx, Rd, addr);<br>
+=C2=A0 =C2=A0 tcg_gen_addi_tl(addr, addr, 1); /* addr =3D addr + 1 */<br>
+=C2=A0 =C2=A0 gen_set_yaddr(addr);<br>
+<br>
+=C2=A0 =C2=A0 tcg_temp_free_i32(addr);<br>
+<br>
+=C2=A0 =C2=A0 return true;<br>
+}<br>
+<br>
+<br>
+static bool trans_STY3(DisasContext *ctx, arg_STY3 *a)<br>
+{<br>
+=C2=A0 =C2=A0 TCGv Rd =3D cpu_r[a-&gt;rd];<br>
+=C2=A0 =C2=A0 TCGv addr =3D gen_get_yaddr();<br>
+<br>
+=C2=A0 =C2=A0 tcg_gen_subi_tl(addr, addr, 1); /* addr =3D addr - 1 */<br>
+=C2=A0 =C2=A0 gen_data_store(ctx, Rd, addr);<br>
+=C2=A0 =C2=A0 gen_set_yaddr(addr);<br>
+<br>
+=C2=A0 =C2=A0 tcg_temp_free_i32(addr);<br>
+<br>
+=C2=A0 =C2=A0 return true;<br>
+}<br>
+<br>
+<br>
+static bool trans_STDY(DisasContext *ctx, arg_STDY *a)<br>
+{<br>
+=C2=A0 =C2=A0 TCGv Rd =3D cpu_r[a-&gt;rd];<br>
+=C2=A0 =C2=A0 TCGv addr =3D gen_get_yaddr();<br>
+<br>
+=C2=A0 =C2=A0 tcg_gen_addi_tl(addr, addr, a-&gt;imm); /* addr =3D addr + q=
 */<br>
+=C2=A0 =C2=A0 gen_data_store(ctx, Rd, addr);<br>
+<br>
+=C2=A0 =C2=A0 tcg_temp_free_i32(addr);<br>
+<br>
+=C2=A0 =C2=A0 return true;<br>
+}<br>
+<br>
+<br>
+/*<br>
+ *=C2=A0 Loads one byte indirect with or without displacement from the dat=
a space<br>
+ *=C2=A0 to a register. For parts with SRAM, the data space consists of th=
e Register<br>
+ *=C2=A0 File, I/O memory and internal SRAM (and external SRAM if applicab=
le). For<br>
+ *=C2=A0 parts without SRAM, the data space consists of the Register File =
only. In<br>
+ *=C2=A0 some parts the Flash Memory has been mapped to the data space and=
 can be<br>
+ *=C2=A0 read using this command. The EEPROM has a separate address space.=
=C2=A0 The data<br>
+ *=C2=A0 location is pointed to by the Z (16 bits) Pointer Register in the=
 Register<br>
+ *=C2=A0 File. Memory access is limited to the current data segment of 64K=
B. To<br>
+ *=C2=A0 access another data segment in devices with more than 64KB data s=
pace, the<br>
+ *=C2=A0 RAMPZ in register in the I/O area has to be changed.=C2=A0 The Z-=
pointer Register<br>
+ *=C2=A0 can either be left unchanged by the operation, or it can be post-=
incremented<br>
+ *=C2=A0 or predecremented.=C2=A0 These features are especially suited for=
 Stack Pointer<br>
+ *=C2=A0 usage of the Z-pointer Register, however because the Z-pointer Re=
gister can<br>
+ *=C2=A0 be used for indirect subroutine calls, indirect jumps and table l=
ookup, it<br>
+ *=C2=A0 is often more convenient to use the X or Y-pointer as a dedicated=
 Stack<br>
+ *=C2=A0 Pointer. Note that only the low byte of the Z-pointer is updated =
in devices<br>
+ *=C2=A0 with no more than 256 bytes data space. For such devices, the hig=
h byte of<br>
+ *=C2=A0 the pointer is not used by this instruction and can be used for o=
ther<br>
+ *=C2=A0 purposes. The RAMPZ Register in the I/O area is updated in parts =
with more<br>
+ *=C2=A0 than 64KB data space or more than 64KB Program memory, and the<br=
>
+ *=C2=A0 increment/decrement/<wbr>displacement is added to the entire 24-b=
it address on<br>
+ *=C2=A0 such devices.=C2=A0 Not all variants of this instruction is avail=
able in all<br>
+ *=C2=A0 devices. Refer to the device specific instruction set summary.=C2=
=A0 In the<br>
+ *=C2=A0 Reduced Core tinyAVR the LD instruction can be used to achieve th=
e same<br>
+ *=C2=A0 operation as LPM since the program memory is mapped to the data m=
emory<br>
+ *=C2=A0 space.=C2=A0 For using the Z-pointer for table lookup in Program =
memory see the<br>
+ *=C2=A0 LPM and ELPM instructions.<br>
+ */<br>
+static bool trans_LDZ2(DisasContext *ctx, arg_LDZ2 *a)<br>
+{<br>
+=C2=A0 =C2=A0 TCGv Rd =3D cpu_r[a-&gt;rd];<br>
+=C2=A0 =C2=A0 TCGv addr =3D gen_get_zaddr();<br>
+<br>
+=C2=A0 =C2=A0 gen_data_load(ctx, Rd, addr);<br>
+=C2=A0 =C2=A0 tcg_gen_addi_tl(addr, addr, 1); /* addr =3D addr + 1 */<br>
+<br>
+=C2=A0 =C2=A0 gen_set_zaddr(addr);<br>
+<br>
+=C2=A0 =C2=A0 tcg_temp_free_i32(addr);<br>
+<br>
+=C2=A0 =C2=A0 return true;<br>
+}<br>
+<br>
+<br>
+static bool trans_LDZ3(DisasContext *ctx, arg_LDZ3 *a)<br>
+{<br>
+=C2=A0 =C2=A0 TCGv Rd =3D cpu_r[a-&gt;rd];<br>
+=C2=A0 =C2=A0 TCGv addr =3D gen_get_zaddr();<br>
+<br>
+=C2=A0 =C2=A0 tcg_gen_subi_tl(addr, addr, 1); /* addr =3D addr - 1 */<br>
+=C2=A0 =C2=A0 gen_data_load(ctx, Rd, addr);<br>
+<br>
+=C2=A0 =C2=A0 gen_set_zaddr(addr);<br>
+<br>
+=C2=A0 =C2=A0 tcg_temp_free_i32(addr);<br>
+<br>
+=C2=A0 =C2=A0 return true;<br>
+}<br>
+<br>
+<br>
+static bool trans_LDDZ(DisasContext *ctx, arg_LDDZ *a)<br>
+{<br>
+=C2=A0 =C2=A0 TCGv Rd =3D cpu_r[a-&gt;rd];<br>
+=C2=A0 =C2=A0 TCGv addr =3D gen_get_zaddr();<br>
+<br>
+=C2=A0 =C2=A0 tcg_gen_addi_tl(addr, addr, a-&gt;imm); /* addr =3D addr + q=
 */<br>
+=C2=A0 =C2=A0 gen_data_load(ctx, Rd, addr);<br>
+<br>
+=C2=A0 =C2=A0 tcg_temp_free_i32(addr);<br>
+<br>
+=C2=A0 =C2=A0 return true;<br>
+}<br>
+<br>
+<br>
+static bool trans_STZ2(DisasContext *ctx, arg_STZ2 *a)<br>
+{<br>
+=C2=A0 =C2=A0 TCGv Rd =3D cpu_r[a-&gt;rd];<br>
+=C2=A0 =C2=A0 TCGv addr =3D gen_get_zaddr();<br>
+<br>
+=C2=A0 =C2=A0 gen_data_store(ctx, Rd, addr);<br>
+=C2=A0 =C2=A0 tcg_gen_addi_tl(addr, addr, 1); /* addr =3D addr + 1 */<br>
+<br>
+=C2=A0 =C2=A0 gen_set_zaddr(addr);<br>
+<br>
+=C2=A0 =C2=A0 tcg_temp_free_i32(addr);<br>
+<br>
+=C2=A0 =C2=A0 return true;<br>
+}<br>
+<br>
+<br>
+static bool trans_STZ3(DisasContext *ctx, arg_STZ3 *a)<br>
+{<br>
+=C2=A0 =C2=A0 TCGv Rd =3D cpu_r[a-&gt;rd];<br>
+=C2=A0 =C2=A0 TCGv addr =3D gen_get_zaddr();<br>
+<br>
+=C2=A0 =C2=A0 tcg_gen_subi_tl(addr, addr, 1); /* addr =3D addr - 1 */<br>
+=C2=A0 =C2=A0 gen_data_store(ctx, Rd, addr);<br>
+<br>
+=C2=A0 =C2=A0 gen_set_zaddr(addr);<br>
+<br>
+=C2=A0 =C2=A0 tcg_temp_free_i32(addr);<br>
+<br>
+=C2=A0 =C2=A0 return true;<br>
+}<br>
+<br>
+<br>
+static bool trans_STDZ(DisasContext *ctx, arg_STDZ *a)<br>
+{<br>
+=C2=A0 =C2=A0 TCGv Rd =3D cpu_r[a-&gt;rd];<br>
+=C2=A0 =C2=A0 TCGv addr =3D gen_get_zaddr();<br>
+<br>
+=C2=A0 =C2=A0 tcg_gen_addi_tl(addr, addr, a-&gt;imm); /* addr =3D addr + q=
 */<br>
+=C2=A0 =C2=A0 gen_data_store(ctx, Rd, addr);<br>
+<br>
+=C2=A0 =C2=A0 tcg_temp_free_i32(addr);<br>
+<br>
+=C2=A0 =C2=A0 return true;<br>
+}<br>
+<br>
+<br>
+<br>
+/*<br>
+ *=C2=A0 Stores one byte from a Register to the data space. For parts with=
 SRAM,<br>
+ *=C2=A0 the data space consists of the Register File, I/O memory and inte=
rnal SRAM<br>
+ *=C2=A0 (and external SRAM if applicable). For parts without SRAM, the da=
ta space<br>
+ *=C2=A0 consists of the Register File only. The EEPROM has a separate add=
ress space.<br>
+ *=C2=A0 A 16-bit address must be supplied. Memory access is limited to th=
e current<br>
+ *=C2=A0 data segment of 64KB. The STS instruction uses the RAMPD Register=
 to access<br>
+ *=C2=A0 memory above 64KB. To access another data segment in devices with=
 more than<br>
+ *=C2=A0 64KB data space, the RAMPD in register in the I/O area has to be =
changed.<br>
+ *=C2=A0 This instruction is not available in all devices. Refer to the de=
vice<br>
+ *=C2=A0 specific instruction set summary.<br>
+ */<br>
+static bool trans_STS(DisasContext *ctx, arg_STS *a)<br>
+{<br>
+=C2=A0 =C2=A0 TCGv Rd =3D cpu_r[a-&gt;rd];<br>
+=C2=A0 =C2=A0 TCGv addr =3D tcg_temp_new_i32();<br>
+=C2=A0 =C2=A0 TCGv H =3D cpu_rampD;<br>
+=C2=A0 =C2=A0 a-&gt;imm =3D next_word(ctx);<br>
+<br>
+=C2=A0 =C2=A0 tcg_gen_mov_tl(addr, H); /* addr =3D H:M:L */<br>
+=C2=A0 =C2=A0 tcg_gen_shli_tl(addr, addr, 16);<br>
+=C2=A0 =C2=A0 tcg_gen_ori_tl(addr, addr, a-&gt;imm);<br>
+<br>
+=C2=A0 =C2=A0 gen_data_store(ctx, Rd, addr);<br>
+<br>
+=C2=A0 =C2=A0 tcg_temp_free_i32(addr);<br>
+<br>
+=C2=A0 =C2=A0 return true;<br>
+}<br>
+<br>
+<br>
+/*<br>
+ *=C2=A0 Loads one byte pointed to by the Z-register into the destination<=
br>
+ *=C2=A0 register Rd. This instruction features a 100% space effective con=
stant<br>
+ *=C2=A0 initialization or constant data fetch. The Program memory is orga=
nized in<br>
+ *=C2=A0 16-bit words while the Z-pointer is a byte address. Thus, the lea=
st<br>
+ *=C2=A0 significant bit of the Z-pointer selects either low byte (ZLSB =
=3D 0) or high<br>
+ *=C2=A0 byte (ZLSB =3D 1). This instruction can address the first 64KB (3=
2K words) of<br>
+ *=C2=A0 Program memory. The Zpointer Register can either be left unchange=
d by the<br>
+ *=C2=A0 operation, or it can be incremented. The incrementation does not =
apply to<br>
+ *=C2=A0 the RAMPZ Register.=C2=A0 Devices with Self-Programming capabilit=
y can use the<br>
+ *=C2=A0 LPM instruction to read the Fuse and Lock bit values.=C2=A0 Refer=
 to the device<br>
+ *=C2=A0 documentation for a detailed description.=C2=A0 The LPM instructi=
on is not<br>
+ *=C2=A0 available in all devices. Refer to the device specific instructio=
n set<br>
+ *=C2=A0 summary<br>
+ */<br>
+static bool trans_LPM1(DisasContext *ctx, arg_LPM1 *a)<br>
+{<br>
+=C2=A0 =C2=A0 if (!avr_have_feature(ctx, AVR_FEATURE_LPM)) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return true;<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 TCGv Rd =3D cpu_r[0];<br>
+=C2=A0 =C2=A0 TCGv addr =3D tcg_temp_new_i32();<br>
+=C2=A0 =C2=A0 TCGv H =3D cpu_r[31];<br>
+=C2=A0 =C2=A0 TCGv L =3D cpu_r[30];<br>
+<br>
+=C2=A0 =C2=A0 tcg_gen_shli_tl(addr, H, 8); /* addr =3D H:L */<br>
+=C2=A0 =C2=A0 tcg_gen_or_tl(addr, addr, L);<br>
+<br>
+=C2=A0 =C2=A0 tcg_gen_qemu_ld8u(Rd, addr, MMU_CODE_IDX); /* Rd =3D mem[add=
r] */<br>
+<br>
+=C2=A0 =C2=A0 tcg_temp_free_i32(addr);<br>
+<br>
+=C2=A0 =C2=A0 return true;<br>
+}<br>
+<br>
+<br>
+static bool trans_LPM2(DisasContext *ctx, arg_LPM2 *a)<br>
+{<br>
+=C2=A0 =C2=A0 if (!avr_have_feature(ctx, AVR_FEATURE_LPM)) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return true;<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 TCGv Rd =3D cpu_r[a-&gt;rd];<br>
+=C2=A0 =C2=A0 TCGv addr =3D tcg_temp_new_i32();<br>
+=C2=A0 =C2=A0 TCGv H =3D cpu_r[31];<br>
+=C2=A0 =C2=A0 TCGv L =3D cpu_r[30];<br>
+<br>
+=C2=A0 =C2=A0 tcg_gen_shli_tl(addr, H, 8); /* addr =3D H:L */<br>
+=C2=A0 =C2=A0 tcg_gen_or_tl(addr, addr, L);<br>
+<br>
+=C2=A0 =C2=A0 tcg_gen_qemu_ld8u(Rd, addr, MMU_CODE_IDX); /* Rd =3D mem[add=
r] */<br>
+<br>
+=C2=A0 =C2=A0 tcg_temp_free_i32(addr);<br>
+<br>
+=C2=A0 =C2=A0 return true;<br>
+}<br>
+<br>
+<br>
+static bool trans_LPMX(DisasContext *ctx, arg_LPMX *a)<br>
+{<br>
+=C2=A0 =C2=A0 if (!avr_have_feature(ctx, AVR_FEATURE_LPMX)) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return true;<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 TCGv Rd =3D cpu_r[a-&gt;rd];<br>
+=C2=A0 =C2=A0 TCGv addr =3D tcg_temp_new_i32();<br>
+=C2=A0 =C2=A0 TCGv H =3D cpu_r[31];<br>
+=C2=A0 =C2=A0 TCGv L =3D cpu_r[30];<br>
+<br>
+=C2=A0 =C2=A0 tcg_gen_shli_tl(addr, H, 8); /* addr =3D H:L */<br>
+=C2=A0 =C2=A0 tcg_gen_or_tl(addr, addr, L);<br>
+<br>
+=C2=A0 =C2=A0 tcg_gen_qemu_ld8u(Rd, addr, MMU_CODE_IDX); /* Rd =3D mem[add=
r] */<br>
+<br>
+=C2=A0 =C2=A0 tcg_gen_addi_tl(addr, addr, 1); /* addr =3D addr + 1 */<br>
+<br>
+=C2=A0 =C2=A0 tcg_gen_andi_tl(L, addr, 0xff);<br>
+<br>
+=C2=A0 =C2=A0 tcg_gen_shri_tl(addr, addr, 8);<br>
+=C2=A0 =C2=A0 tcg_gen_andi_tl(H, addr, 0xff);<br>
+<br>
+=C2=A0 =C2=A0 tcg_temp_free_i32(addr);<br>
+<br>
+=C2=A0 =C2=A0 return true;<br>
+}<br>
+<br>
+<br>
+/*<br>
+ *=C2=A0 Loads one byte pointed to by the Z-register and the RAMPZ Registe=
r in<br>
+ *=C2=A0 the I/O space, and places this byte in the destination register R=
d. This<br>
+ *=C2=A0 instruction features a 100% space effective constant initializati=
on or<br>
+ *=C2=A0 constant data fetch. The Program memory is organized in 16-bit wo=
rds while<br>
+ *=C2=A0 the Z-pointer is a byte address. Thus, the least significant bit =
of the<br>
+ *=C2=A0 Z-pointer selects either low byte (ZLSB =3D 0) or high byte (ZLSB=
 =3D 1). This<br>
+ *=C2=A0 instruction can address the entire Program memory space. The Z-po=
inter<br>
+ *=C2=A0 Register can either be left unchanged by the operation, or it can=
 be<br>
+ *=C2=A0 incremented. The incrementation applies to the entire 24-bit conc=
atenation<br>
+ *=C2=A0 of the RAMPZ and Z-pointer Registers.=C2=A0 Devices with Self-Pro=
gramming<br>
+ *=C2=A0 capability can use the ELPM instruction to read the Fuse and Lock=
 bit value.<br>
+ *=C2=A0 Refer to the device documentation for a detailed description.=C2=
=A0 This<br>
+ *=C2=A0 instruction is not available in all devices. Refer to the device =
specific<br>
+ *=C2=A0 instruction set summary.<br>
+ */<br>
+static bool trans_ELPM1(DisasContext *ctx, arg_ELPM1 *a)<br>
+{<br>
+=C2=A0 =C2=A0 if (!avr_have_feature(ctx, AVR_FEATURE_ELPM)) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return true;<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 TCGv Rd =3D cpu_r[0];<br>
+=C2=A0 =C2=A0 TCGv addr =3D gen_get_zaddr();<br>
+<br>
+=C2=A0 =C2=A0 tcg_gen_qemu_ld8u(Rd, addr, MMU_CODE_IDX); /* Rd =3D mem[add=
r] */<br>
+<br>
+=C2=A0 =C2=A0 tcg_temp_free_i32(addr);<br>
+<br>
+=C2=A0 =C2=A0 return true;<br>
+}<br>
+<br>
+<br>
+static bool trans_ELPM2(DisasContext *ctx, arg_ELPM2 *a)<br>
+{<br>
+=C2=A0 =C2=A0 if (!avr_have_feature(ctx, AVR_FEATURE_ELPM)) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return true;<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 TCGv Rd =3D cpu_r[a-&gt;rd];<br>
+=C2=A0 =C2=A0 TCGv addr =3D gen_get_zaddr();<br>
+<br>
+=C2=A0 =C2=A0 tcg_gen_qemu_ld8u(Rd, addr, MMU_CODE_IDX); /* Rd =3D mem[add=
r] */<br>
+<br>
+=C2=A0 =C2=A0 tcg_temp_free_i32(addr);<br>
+<br>
+=C2=A0 =C2=A0 return true;<br>
+}<br>
+<br>
+<br>
+static bool trans_ELPMX(DisasContext *ctx, arg_ELPMX *a)<br>
+{<br>
+=C2=A0 =C2=A0 if (!avr_have_feature(ctx, AVR_FEATURE_ELPMX)) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return true;<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 TCGv Rd =3D cpu_r[a-&gt;rd];<br>
+=C2=A0 =C2=A0 TCGv addr =3D gen_get_zaddr();<br>
+<br>
+=C2=A0 =C2=A0 tcg_gen_qemu_ld8u(Rd, addr, MMU_CODE_IDX); /* Rd =3D mem[add=
r] */<br>
+<br>
+=C2=A0 =C2=A0 tcg_gen_addi_tl(addr, addr, 1); /* addr =3D addr + 1 */<br>
+<br>
+=C2=A0 =C2=A0 gen_set_zaddr(addr);<br>
+<br>
+=C2=A0 =C2=A0 tcg_temp_free_i32(addr);<br>
+<br>
+=C2=A0 =C2=A0 return true;<br>
+}<br>
+<br>
+<br>
+/*<br>
+ *=C2=A0 SPM can be used to erase a page in the Program memory, to write a=
 page<br>
+ *=C2=A0 in the Program memory (that is already erased), and to set Boot L=
oader Lock<br>
+ *=C2=A0 bits. In some devices, the Program memory can be written one word=
 at a time,<br>
+ *=C2=A0 in other devices an entire page can be programmed simultaneously =
after first<br>
+ *=C2=A0 filling a temporary page buffer. In all cases, the Program memory=
 must be<br>
+ *=C2=A0 erased one page at a time. When erasing the Program memory, the R=
AMPZ and<br>
+ *=C2=A0 Z-register are used as page address. When writing the Program mem=
ory, the<br>
+ *=C2=A0 RAMPZ and Z-register are used as page or word address, and the R1=
:R0<br>
+ *=C2=A0 register pair is used as data(1). When setting the Boot Loader Lo=
ck bits,<br>
+ *=C2=A0 the R1:R0 register pair is used as data. Refer to the device docu=
mentation<br>
+ *=C2=A0 for detailed description of SPM usage. This instruction can addre=
ss the<br>
+ *=C2=A0 entire Program memory.=C2=A0 The SPM instruction is not available=
 in all devices.<br>
+ *=C2=A0 Refer to the device specific instruction set summary.=C2=A0 Note:=
 1. R1<br>
+ *=C2=A0 determines the instruction high byte, and R0 determines the instr=
uction low<br>
+ *=C2=A0 byte.<br>
+ */<br>
+static bool trans_SPM(DisasContext *ctx, arg_SPM *a)<br>
+{<br>
+=C2=A0 =C2=A0 /* TODO */<br>
+=C2=A0 =C2=A0 if (!avr_have_feature(ctx, AVR_FEATURE_SPM)) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return true;<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 return true;<br>
+}<br>
+<br>
+<br>
+static bool trans_SPMX(DisasContext *ctx, arg_SPMX *a)<br>
+{<br>
+=C2=A0 =C2=A0 /* TODO */<br>
+=C2=A0 =C2=A0 if (!avr_have_feature(ctx, AVR_FEATURE_SPMX)) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return true;<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 return true;<br>
+}<br>
+<br>
+<br>
+/*<br>
+ *=C2=A0 Loads data from the I/O Space (Ports, Timers, Configuration Regis=
ters,<br>
+ *=C2=A0 etc.) into register Rd in the Register File.<br>
+ */<br>
+static bool trans_IN(DisasContext *ctx, arg_IN *a)<br>
+{<br>
+=C2=A0 =C2=A0 TCGv Rd =3D cpu_r[a-&gt;rd];<br>
+=C2=A0 =C2=A0 TCGv port =3D tcg_const_i32(a-&gt;imm);<br>
+<br>
+=C2=A0 =C2=A0 gen_helper_inb(Rd, cpu_env, port);<br>
+<br>
+=C2=A0 =C2=A0 tcg_temp_free_i32(port);<br>
+<br>
+=C2=A0 =C2=A0 return true;<br>
+}<br>
+<br>
+<br>
+/*<br>
+ *=C2=A0 Stores data from register Rr in the Register File to I/O Space (P=
orts,<br>
+ *=C2=A0 Timers, Configuration Registers, etc.).<br>
+ */<br>
+static bool trans_OUT(DisasContext *ctx, arg_OUT *a)<br>
+{<br>
+=C2=A0 =C2=A0 TCGv Rd =3D cpu_r[a-&gt;rd];<br>
+=C2=A0 =C2=A0 TCGv port =3D tcg_const_i32(a-&gt;imm);<br>
+<br>
+=C2=A0 =C2=A0 gen_helper_outb(cpu_env, port, Rd);<br>
+<br>
+=C2=A0 =C2=A0 tcg_temp_free_i32(port);<br>
+<br>
+=C2=A0 =C2=A0 return true;<br>
+}<br>
+<br>
+<br>
+/*<br>
+ *=C2=A0 This instruction stores the contents of register Rr on the STACK.=
 The<br>
+ *=C2=A0 Stack Pointer is post-decremented by 1 after the PUSH.=C2=A0 This=
 instruction is<br>
+ *=C2=A0 not available in all devices. Refer to the device specific instru=
ction set<br>
+ *=C2=A0 summary.<br>
+ */<br>
+static bool trans_PUSH(DisasContext *ctx, arg_PUSH *a)<br>
+{<br>
+=C2=A0 =C2=A0 TCGv Rd =3D cpu_r[a-&gt;rd];<br>
+<br>
+=C2=A0 =C2=A0 gen_data_store(ctx, Rd, cpu_sp);<br>
+=C2=A0 =C2=A0 tcg_gen_subi_tl(cpu_sp, cpu_sp, 1);<br>
+<br>
+=C2=A0 =C2=A0 return true;<br>
+}<br>
+<br>
+<br>
+/*<br>
+ *=C2=A0 This instruction loads register Rd with a byte from the STACK. Th=
e Stack<br>
+ *=C2=A0 Pointer is pre-incremented by 1 before the POP.=C2=A0 This instru=
ction is not<br>
+ *=C2=A0 available in all devices. Refer to the device specific instructio=
n set<br>
+ *=C2=A0 summary.<br>
+ */<br>
+static bool trans_POP(DisasContext *ctx, arg_POP *a)<br>
+{<br>
+=C2=A0 =C2=A0 /*<br>
+=C2=A0 =C2=A0 =C2=A0* Using a temp to work around some strange behaviour:<=
br>
+=C2=A0 =C2=A0 =C2=A0* tcg_gen_addi_tl(cpu_sp, cpu_sp, 1);<br>
+=C2=A0 =C2=A0 =C2=A0* gen_data_load(ctx, Rd, cpu_sp);<br>
+=C2=A0 =C2=A0 =C2=A0* seems to cause the add to happen twice.<br>
+=C2=A0 =C2=A0 =C2=A0* This doesn&#39;t happen if either the add or the loa=
d is removed.<br>
+=C2=A0 =C2=A0 =C2=A0*/<br>
+=C2=A0 =C2=A0 TCGv t1 =3D tcg_temp_new_i32();<br>
+=C2=A0 =C2=A0 TCGv Rd =3D cpu_r[a-&gt;rd];<br>
+<br>
+=C2=A0 =C2=A0 tcg_gen_addi_tl(t1, cpu_sp, 1);<br>
+=C2=A0 =C2=A0 gen_data_load(ctx, Rd, t1);<br>
+=C2=A0 =C2=A0 tcg_gen_mov_tl(cpu_sp, t1);<br>
+<br>
+=C2=A0 =C2=A0 return true;<br>
+}<br>
+<br>
+<br>
+/*<br>
+ *=C2=A0 Exchanges one byte indirect between register and data space.=C2=
=A0 The data<br>
+ *=C2=A0 location is pointed to by the Z (16 bits) Pointer Register in the=
 Register<br>
+ *=C2=A0 File. Memory access is limited to the current data segment of 64K=
B. To<br>
+ *=C2=A0 access another data segment in devices with more than 64KB data s=
pace, the<br>
+ *=C2=A0 RAMPZ in register in the I/O area has to be changed.=C2=A0 The Z-=
pointer Register<br>
+ *=C2=A0 is left unchanged by the operation. This instruction is especiall=
y suited<br>
+ *=C2=A0 for writing/reading status bits stored in SRAM.<br>
+ */<br>
+static bool trans_XCH(DisasContext *ctx, arg_XCH *a)<br>
+{<br>
+=C2=A0 =C2=A0 if (!avr_have_feature(ctx, AVR_FEATURE_RMW)) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return true;<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 TCGv Rd =3D cpu_r[a-&gt;rd];<br>
+=C2=A0 =C2=A0 TCGv t0 =3D tcg_temp_new_i32();<br>
+=C2=A0 =C2=A0 TCGv addr =3D gen_get_zaddr();<br>
+<br>
+=C2=A0 =C2=A0 gen_data_load(ctx, t0, addr);<br>
+=C2=A0 =C2=A0 gen_data_store(ctx, Rd, addr);<br>
+=C2=A0 =C2=A0 tcg_gen_mov_tl(Rd, t0);<br>
+<br>
+=C2=A0 =C2=A0 tcg_temp_free_i32(t0);<br>
+=C2=A0 =C2=A0 tcg_temp_free_i32(addr);<br>
+<br>
+=C2=A0 =C2=A0 return true;<br>
+}<br>
+<br>
+<br>
+/*<br>
+ *=C2=A0 Load one byte indirect from data space to register and set bits i=
n data<br>
+ *=C2=A0 space specified by the register. The instruction can only be used=
 towards<br>
+ *=C2=A0 internal SRAM.=C2=A0 The data location is pointed to by the Z (16=
 bits) Pointer<br>
+ *=C2=A0 Register in the Register File. Memory access is limited to the cu=
rrent data<br>
+ *=C2=A0 segment of 64KB. To access another data segment in devices with m=
ore than<br>
+ *=C2=A0 64KB data space, the RAMPZ in register in the I/O area has to be =
changed.<br>
+ *=C2=A0 The Z-pointer Register is left unchanged by the operation. This i=
nstruction<br>
+ *=C2=A0 is especially suited for setting status bits stored in SRAM.<br>
+ */<br>
+static bool trans_LAS(DisasContext *ctx, arg_LAS *a)<br>
+{<br>
+=C2=A0 =C2=A0 if (!avr_have_feature(ctx, AVR_FEATURE_RMW)) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return true;<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 TCGv Rr =3D cpu_r[a-&gt;rd];<br>
+=C2=A0 =C2=A0 TCGv addr =3D gen_get_zaddr();<br>
+=C2=A0 =C2=A0 TCGv t0 =3D tcg_temp_new_i32();<br>
+=C2=A0 =C2=A0 TCGv t1 =3D tcg_temp_new_i32();<br>
+<br>
+=C2=A0 =C2=A0 gen_data_load(ctx, t0, addr); /* t0 =3D mem[addr] */<br>
+=C2=A0 =C2=A0 tcg_gen_or_tl(t1, t0, Rr);<br>
+<br>
+=C2=A0 =C2=A0 tcg_gen_mov_tl(Rr, t0); /* Rr =3D t0 */<br>
+=C2=A0 =C2=A0 gen_data_store(ctx, t1, addr); /* mem[addr] =3D t1 */<br>
+<br>
+=C2=A0 =C2=A0 tcg_temp_free_i32(t1);<br>
+=C2=A0 =C2=A0 tcg_temp_free_i32(t0);<br>
+=C2=A0 =C2=A0 tcg_temp_free_i32(addr);<br>
+<br>
+=C2=A0 =C2=A0 return true;<br>
+}<br>
+<br>
+<br>
+/*<br>
+ *=C2=A0 Load one byte indirect from data space to register and stores and=
 clear<br>
+ *=C2=A0 the bits in data space specified by the register. The instruction=
 can<br>
+ *=C2=A0 only be used towards internal SRAM.=C2=A0 The data location is po=
inted to by<br>
+ *=C2=A0 the Z (16 bits) Pointer Register in the Register File. Memory acc=
ess is<br>
+ *=C2=A0 limited to the current data segment of 64KB. To access another da=
ta<br>
+ *=C2=A0 segment in devices with more than 64KB data space, the RAMPZ in r=
egister<br>
+ *=C2=A0 in the I/O area has to be changed.=C2=A0 The Z-pointer Register i=
s left<br>
+ *=C2=A0 unchanged by the operation. This instruction is especially suited=
 for<br>
+ *=C2=A0 clearing status bits stored in SRAM.<br>
+ */<br>
+static bool trans_LAC(DisasContext *ctx, arg_LAC *a)<br>
+{<br>
+=C2=A0 =C2=A0 if (!avr_have_feature(ctx, AVR_FEATURE_RMW)) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return true;<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 TCGv Rr =3D cpu_r[a-&gt;rd];<br>
+=C2=A0 =C2=A0 TCGv addr =3D gen_get_zaddr();<br>
+=C2=A0 =C2=A0 TCGv t0 =3D tcg_temp_new_i32();<br>
+=C2=A0 =C2=A0 TCGv t1 =3D tcg_temp_new_i32();<br>
+<br>
+=C2=A0 =C2=A0 gen_data_load(ctx, t0, addr); /* t0 =3D mem[addr] */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* t1 =3D t0 &amp; (0xff - Rr) =3D t0 and ~Rr =
*/<br>
+=C2=A0 =C2=A0 tcg_gen_andc_tl(t1, t0, Rr);<br>
+<br>
+=C2=A0 =C2=A0 tcg_gen_mov_tl(Rr, t0); /* Rr =3D t0 */<br>
+=C2=A0 =C2=A0 gen_data_store(ctx, t1, addr); /* mem[addr] =3D t1 */<br>
+<br>
+=C2=A0 =C2=A0 tcg_temp_free_i32(t1);<br>
+=C2=A0 =C2=A0 tcg_temp_free_i32(t0);<br>
+=C2=A0 =C2=A0 tcg_temp_free_i32(addr);<br>
+<br>
+=C2=A0 =C2=A0 return true;<br>
+}<br>
+<br>
+<br>
+/*<br>
+ *=C2=A0 Load one byte indirect from data space to register and toggles bi=
ts in<br>
+ *=C2=A0 the data space specified by the register.=C2=A0 The instruction c=
an only be used<br>
+ *=C2=A0 towards SRAM.=C2=A0 The data location is pointed to by the Z (16 =
bits) Pointer<br>
+ *=C2=A0 Register in the Register File. Memory access is limited to the cu=
rrent data<br>
+ *=C2=A0 segment of 64KB. To access another data segment in devices with m=
ore than<br>
+ *=C2=A0 64KB data space, the RAMPZ in register in the I/O area has to be =
changed.<br>
+ *=C2=A0 The Z-pointer Register is left unchanged by the operation. This i=
nstruction<br>
+ *=C2=A0 is especially suited for changing status bits stored in SRAM.<br>
+ */<br>
+static bool trans_LAT(DisasContext *ctx, arg_LAT *a)<br>
+{<br>
+=C2=A0 =C2=A0 if (!avr_have_feature(ctx, AVR_FEATURE_RMW)) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return true;<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 TCGv Rd =3D cpu_r[a-&gt;rd];<br>
+=C2=A0 =C2=A0 TCGv addr =3D gen_get_zaddr();<br>
+=C2=A0 =C2=A0 TCGv t0 =3D tcg_temp_new_i32();<br>
+=C2=A0 =C2=A0 TCGv t1 =3D tcg_temp_new_i32();<br>
+<br>
+=C2=A0 =C2=A0 gen_data_load(ctx, t0, addr); /* t0 =3D mem[addr] */<br>
+=C2=A0 =C2=A0 tcg_gen_xor_tl(t1, t0, Rd);<br>
+<br>
+=C2=A0 =C2=A0 tcg_gen_mov_tl(Rd, t0); /* Rd =3D t0 */<br>
+=C2=A0 =C2=A0 gen_data_store(ctx, t1, addr); /* mem[addr] =3D t1 */<br>
+<br>
+=C2=A0 =C2=A0 tcg_temp_free_i32(t1);<br>
+=C2=A0 =C2=A0 tcg_temp_free_i32(t0);<br>
+=C2=A0 =C2=A0 tcg_temp_free_i32(addr);<br>
+<br>
+=C2=A0 =C2=A0 return true;<br>
+}<br>
+<br>
+<br>
+/*<br>
+ *=C2=A0 Shifts all bits in Rd one place to the right. Bit 7 is cleared. B=
it 0 is<br>
+ *=C2=A0 loaded into the C Flag of the SREG. This operation effectively di=
vides an<br>
+ *=C2=A0 unsigned value by two. The C Flag can be used to round the result=
.<br>
+ */<br>
+static bool trans_LSR(DisasContext *ctx, arg_LSR *a)<br>
+{<br>
+=C2=A0 =C2=A0 TCGv Rd =3D cpu_r[a-&gt;rd];<br>
+<br>
+=C2=A0 =C2=A0 tcg_gen_andi_tl(cpu_Cf, Rd, 1);<br>
+<br>
+=C2=A0 =C2=A0 tcg_gen_shri_tl(Rd, Rd, 1);<br>
+<br>
+=C2=A0 =C2=A0 tcg_gen_setcondi_tl(TCG_COND_<wbr>EQ, cpu_Zf, Rd, 0); /* Zf =
=3D Rd =3D=3D 0 */<br>
+=C2=A0 =C2=A0 tcg_gen_movi_tl(cpu_Nf, 0);<br>
+=C2=A0 =C2=A0 tcg_gen_mov_tl(cpu_Vf, cpu_Cf);<br>
+=C2=A0 =C2=A0 tcg_gen_mov_tl(cpu_Sf, cpu_Vf);<br>
+<br>
+=C2=A0 =C2=A0 return true;<br>
+}<br>
+<br>
+<br>
+/*<br>
+ *=C2=A0 Shifts all bits in Rd one place to the right. The C Flag is shift=
ed into<br>
+ *=C2=A0 bit 7 of Rd. Bit 0 is shifted into the C Flag.=C2=A0 This operati=
on, combined<br>
+ *=C2=A0 with ASR, effectively divides multi-byte signed values by two. Co=
mbined with<br>
+ *=C2=A0 LSR it effectively divides multi-byte unsigned values by two. The=
 Carry Flag<br>
+ *=C2=A0 can be used to round the result.<br>
+ */<br>
+static bool trans_ROR(DisasContext *ctx, arg_ROR *a)<br>
+{<br>
+=C2=A0 =C2=A0 TCGv Rd =3D cpu_r[a-&gt;rd];<br>
+=C2=A0 =C2=A0 TCGv t0 =3D tcg_temp_new_i32();<br>
+<br>
+=C2=A0 =C2=A0 tcg_gen_shli_tl(t0, cpu_Cf, 7);<br>
+=C2=A0 =C2=A0 tcg_gen_andi_tl(cpu_Cf, Rd, 1);<br>
+=C2=A0 =C2=A0 tcg_gen_shri_tl(Rd, Rd, 1);<br>
+=C2=A0 =C2=A0 tcg_gen_or_tl(Rd, Rd, t0);<br>
+<br>
+=C2=A0 =C2=A0 gen_rshift_ZNVSf(Rd);<br>
+<br>
+=C2=A0 =C2=A0 tcg_temp_free_i32(t0);<br>
+<br>
+=C2=A0 =C2=A0 return true;<br>
+}<br>
+<br>
+<br>
+/*<br>
+ *=C2=A0 Shifts all bits in Rd one place to the right. Bit 7 is held const=
ant. Bit 0<br>
+ *=C2=A0 is loaded into the C Flag of the SREG. This operation effectively=
 divides a<br>
+ *=C2=A0 signed value by two without changing its sign. The Carry Flag can=
 be used to<br>
+ *=C2=A0 round the result.<br>
+ */<br>
+static bool trans_ASR(DisasContext *ctx, arg_ASR *a)<br>
+{<br>
+=C2=A0 =C2=A0 TCGv Rd =3D cpu_r[a-&gt;rd];<br>
+=C2=A0 =C2=A0 TCGv t0 =3D tcg_temp_new_i32();<br>
+<br>
+=C2=A0 =C2=A0 /* Cf */<br>
+=C2=A0 =C2=A0 tcg_gen_andi_tl(cpu_Cf, Rd, 1); /* Cf =3D Rd(0) */<br>
+<br>
+=C2=A0 =C2=A0 /* op */<br>
+=C2=A0 =C2=A0 tcg_gen_andi_tl(t0, Rd, 0x80); /* Rd =3D (Rd &amp; 0x80) | (=
Rd &gt;&gt; 1) */<br>
+=C2=A0 =C2=A0 tcg_gen_shri_tl(Rd, Rd, 1);<br>
+=C2=A0 =C2=A0 tcg_gen_or_tl(Rd, Rd, t0);<br>
+<br>
+=C2=A0 =C2=A0 gen_rshift_ZNVSf(Rd);<br>
+<br>
+=C2=A0 =C2=A0 tcg_temp_free_i32(t0);<br>
+<br>
+=C2=A0 =C2=A0 return true;<br>
+}<br>
+<br>
+<br>
+/*<br>
+ *=C2=A0 Swaps high and low nibbles in a register.<br>
+ */<br>
+static bool trans_SWAP(DisasContext *ctx, arg_SWAP *a)<br>
+{<br>
+=C2=A0 =C2=A0 TCGv Rd =3D cpu_r[a-&gt;rd];<br>
+=C2=A0 =C2=A0 TCGv t0 =3D tcg_temp_new_i32();<br>
+=C2=A0 =C2=A0 TCGv t1 =3D tcg_temp_new_i32();<br>
+<br>
+=C2=A0 =C2=A0 tcg_gen_andi_tl(t0, Rd, 0x0f);<br>
+=C2=A0 =C2=A0 tcg_gen_shli_tl(t0, t0, 4);<br>
+=C2=A0 =C2=A0 tcg_gen_andi_tl(t1, Rd, 0xf0);<br>
+=C2=A0 =C2=A0 tcg_gen_shri_tl(t1, t1, 4);<br>
+=C2=A0 =C2=A0 tcg_gen_or_tl(Rd, t0, t1);<br>
+<br>
+=C2=A0 =C2=A0 tcg_temp_free_i32(t1);<br>
+=C2=A0 =C2=A0 tcg_temp_free_i32(t0);<br>
+<br>
+=C2=A0 =C2=A0 return true;<br>
+}<br>
+<br>
+<br>
+/*<br>
+ *=C2=A0 Sets a specified bit in an I/O Register. This instruction operate=
s on<br>
+ *=C2=A0 the lower 32 I/O Registers -- addresses 0-31.<br>
+ */<br>
+static bool trans_SBI(DisasContext *ctx, arg_SBI *a)<br>
+{<br>
+=C2=A0 =C2=A0 TCGv data =3D tcg_temp_new_i32();<br>
+=C2=A0 =C2=A0 TCGv port =3D tcg_const_i32(a-&gt;reg);<br>
+<br>
+=C2=A0 =C2=A0 gen_helper_inb(data, cpu_env, port);<br>
+=C2=A0 =C2=A0 tcg_gen_ori_tl(data, data, 1 &lt;&lt; a-&gt;bit);<br>
+=C2=A0 =C2=A0 gen_helper_outb(cpu_env, port, data);<br>
+<br>
+=C2=A0 =C2=A0 tcg_temp_free_i32(port);<br>
+=C2=A0 =C2=A0 tcg_temp_free_i32(data);<br>
+<br>
+=C2=A0 =C2=A0 return true;<br>
+}<br>
+<br>
+<br>
+/*<br>
+ *=C2=A0 Clears a specified bit in an I/O Register. This instruction opera=
tes on<br>
+ *=C2=A0 the lower 32 I/O Registers -- addresses 0-31.<br>
+ */<br>
+static bool trans_CBI(DisasContext *ctx, arg_CBI *a)<br>
+{<br>
+=C2=A0 =C2=A0 TCGv data =3D tcg_temp_new_i32();<br>
+=C2=A0 =C2=A0 TCGv port =3D tcg_const_i32(a-&gt;reg);<br>
+<br>
+=C2=A0 =C2=A0 gen_helper_inb(data, cpu_env, port);<br>
+=C2=A0 =C2=A0 tcg_gen_andi_tl(data, data, ~(1 &lt;&lt; a-&gt;bit));<br>
+=C2=A0 =C2=A0 gen_helper_outb(cpu_env, port, data);<br>
+<br>
+=C2=A0 =C2=A0 tcg_temp_free_i32(data);<br>
+=C2=A0 =C2=A0 tcg_temp_free_i32(port);<br>
+<br>
+=C2=A0 =C2=A0 return true;<br>
+}<br>
+<br>
+<br>
+/*<br>
+ *=C2=A0 Stores bit b from Rd to the T Flag in SREG (Status Register).<br>
+ */<br>
+static bool trans_BST(DisasContext *ctx, arg_BST *a)<br>
+{<br>
+=C2=A0 =C2=A0 TCGv Rd =3D cpu_r[a-&gt;rd];<br>
+<br>
+=C2=A0 =C2=A0 tcg_gen_andi_tl(cpu_Tf, Rd, 1 &lt;&lt; a-&gt;bit);<br>
+=C2=A0 =C2=A0 tcg_gen_shri_tl(cpu_Tf, cpu_Tf, a-&gt;bit);<br>
+<br>
+=C2=A0 =C2=A0 return true;<br>
+}<br>
+<br>
+<br>
+/*<br>
+ *=C2=A0 Copies the T Flag in the SREG (Status Register) to bit b in regis=
ter Rd.<br>
+ */<br>
+static bool trans_BLD(DisasContext *ctx, arg_BLD *a)<br>
+{<br>
+=C2=A0 =C2=A0 TCGv Rd =3D cpu_r[a-&gt;rd];<br>
+=C2=A0 =C2=A0 TCGv t1 =3D tcg_temp_new_i32();<br>
+<br>
+=C2=A0 =C2=A0 tcg_gen_andi_tl(Rd, Rd, ~(1u &lt;&lt; a-&gt;bit)); /* clear =
bit */<br>
+=C2=A0 =C2=A0 tcg_gen_shli_tl(t1, cpu_Tf, a-&gt;bit); /* create mask */<br=
>
+=C2=A0 =C2=A0 tcg_gen_or_tl(Rd, Rd, t1);<br>
+<br>
+=C2=A0 =C2=A0 tcg_temp_free_i32(t1);<br>
+<br>
+=C2=A0 =C2=A0 return true;<br>
+}<br>
+<br>
+<br>
+/*<br>
+ *=C2=A0 Sets a single Flag or bit in SREG.<br>
+ */<br>
+static bool trans_BSET(DisasContext *ctx, arg_BSET *a)<br>
+{<br>
+=C2=A0 =C2=A0 switch (a-&gt;bit) {<br>
+=C2=A0 =C2=A0 case 0x00:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 tcg_gen_movi_tl(cpu_Cf, 0x01);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
+=C2=A0 =C2=A0 case 0x01:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 tcg_gen_movi_tl(cpu_Zf, 0x01);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
+=C2=A0 =C2=A0 case 0x02:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 tcg_gen_movi_tl(cpu_Nf, 0x01);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
+=C2=A0 =C2=A0 case 0x03:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 tcg_gen_movi_tl(cpu_Vf, 0x01);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
+=C2=A0 =C2=A0 case 0x04:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 tcg_gen_movi_tl(cpu_Sf, 0x01);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
+=C2=A0 =C2=A0 case 0x05:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 tcg_gen_movi_tl(cpu_Hf, 0x01);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
+=C2=A0 =C2=A0 case 0x06:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 tcg_gen_movi_tl(cpu_Tf, 0x01);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
+=C2=A0 =C2=A0 case 0x07:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 tcg_gen_movi_tl(cpu_If, 0x01);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 return true;<br>
+}<br>
+<br>
+<br>
+/*<br>
+ *=C2=A0 Clears a single Flag in SREG.<br>
+ */<br>
+static bool trans_BCLR(DisasContext *ctx, arg_BCLR *a)<br>
+{<br>
+=C2=A0 =C2=A0 switch (a-&gt;bit) {<br>
+=C2=A0 =C2=A0 case 0x00:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 tcg_gen_movi_tl(cpu_Cf, 0x00);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
+=C2=A0 =C2=A0 case 0x01:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 tcg_gen_movi_tl(cpu_Zf, 0x00);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
+=C2=A0 =C2=A0 case 0x02:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 tcg_gen_movi_tl(cpu_Nf, 0x00);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
+=C2=A0 =C2=A0 case 0x03:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 tcg_gen_movi_tl(cpu_Vf, 0x00);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
+=C2=A0 =C2=A0 case 0x04:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 tcg_gen_movi_tl(cpu_Sf, 0x00);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
+=C2=A0 =C2=A0 case 0x05:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 tcg_gen_movi_tl(cpu_Hf, 0x00);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
+=C2=A0 =C2=A0 case 0x06:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 tcg_gen_movi_tl(cpu_Tf, 0x00);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
+=C2=A0 =C2=A0 case 0x07:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 tcg_gen_movi_tl(cpu_If, 0x00);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 return true;<br>
+}<br>
-- <br>
2.17.2 (Apple Git-113)<br>
<br>
</blockquote>

--000000000000302e930598f410dc--

