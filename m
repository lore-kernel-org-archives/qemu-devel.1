Return-Path: <SRS0=+Fwv=DS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27760C433E7
	for <qemu-devel@archiver.kernel.org>; Sun, 11 Oct 2020 11:14:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 86925207F7
	for <qemu-devel@archiver.kernel.org>; Sun, 11 Oct 2020 11:14:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y2GC/jAg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 86925207F7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59018 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kRZJJ-00036R-LY
	for qemu-devel@archiver.kernel.org; Sun, 11 Oct 2020 07:14:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34922)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kRZIC-0002cC-09
 for qemu-devel@nongnu.org; Sun, 11 Oct 2020 07:13:33 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:42846)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kRZIA-0008DI-3m
 for qemu-devel@nongnu.org; Sun, 11 Oct 2020 07:13:31 -0400
Received: by mail-wr1-x443.google.com with SMTP id e18so15617999wrw.9
 for <qemu-devel@nongnu.org>; Sun, 11 Oct 2020 04:13:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=XrNEw8pmGJX4I8bIsuFHYsLyBi3saFdJ4JOwMhwOOXE=;
 b=Y2GC/jAgYiLSa2PX8Ukrr0Z3N+JUOEJGCJPAdy/8Tg9B0/sAtYZ2IUXA8VEhDk9aku
 D56ILAQB1nCQKzYu6HO4Vop5eLQnV8FReh/uq/1EMhzwagVdN/beWAWg7F3oM8O2GeNg
 ZVWU4RMJtdzmW338fA0ue4rSe0QqzIYnUJUtoNHR5vfr37jjmUP3/+Djn7L3qDsJqKu1
 D0s0NTdQ7D9T2ZxidVkVqSrDVUnE4iuSLbArc+N1+OhTrzwlArKgxkE0FyCAyNtFKSxS
 ljAHn8Db9ajsAKXR4C2YJg4lMdpy6OunzOIyHa3c3OpHjsYzm701aKoKCpmNdZSIUaAh
 CLlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=XrNEw8pmGJX4I8bIsuFHYsLyBi3saFdJ4JOwMhwOOXE=;
 b=q6mtGAox3ZJdd8f5K9yOtoQgG7DFDix3inN0yufGxpk1bZmHBawVxVq6WzxW4N03Mo
 BsUE5ji3035AhQkvpq0VMBDaRi/lz++F8o+SyRrkFte+dt3Fzu5ttlkhVeYmcrEHLg6Y
 DjeSA72wvQchRUUEwPlUXaIYJiA644UKHE709zA3iep65fYSxWKBj3zUuGzgk5FeXAF5
 +I25ie7zmu1a0XeiWSu6pnzoAd68iGGnLwrNudWC3LtUjlVFORZF6D32/y1H0Gdm/QY4
 Vltlbq+k1i6VngnwzyKnlCceS4ePjsSNb7SLEqLmDqVO70PamL5DL/io6TuQM5Yh2gOs
 +mNQ==
X-Gm-Message-State: AOAM5333eaTCPabSA0w7BdpMQ409KGs+C6AxsQlPn7AfiySwGo48HESa
 Sifr4XQLh1ykiboG8/YP15c=
X-Google-Smtp-Source: ABdhPJyVXr+QOWuiLwAyfXtxkplmDWSsG4ymAKKyllpvVcZz0i7v+bWHBZqN0PBrtkRP30IDWJ9aEg==
X-Received: by 2002:adf:82ab:: with SMTP id 40mr24408651wrc.420.1602414808100; 
 Sun, 11 Oct 2020 04:13:28 -0700 (PDT)
Received: from [192.168.1.36] (106.red-83-59-162.dynamicip.rima-tde.net.
 [83.59.162.106])
 by smtp.gmail.com with ESMTPSA id b63sm21119200wme.9.2020.10.11.04.13.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 11 Oct 2020 04:13:27 -0700 (PDT)
Subject: Re: [PATCH V13 6/9] target/mips: Add loongson-ext lsdc2 group of
 instructions
To: Huacai Chen <chenhuacai@gmail.com>
References: <1602059975-10115-1-git-send-email-chenhc@lemote.com>
 <1602059975-10115-7-git-send-email-chenhc@lemote.com>
 <ae0f1019-91a5-f31e-4337-3be1d021a50e@amsat.org>
 <CAAhV-H4xAqfE2zLOOMKdzTtaQvUsjaXv1SM2iq7LbTWXcSQ35A@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <9148cfd9-7dbb-3038-5d02-0f7896ebfc70@amsat.org>
Date: Sun, 11 Oct 2020 13:13:25 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <CAAhV-H4xAqfE2zLOOMKdzTtaQvUsjaXv1SM2iq7LbTWXcSQ35A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::443;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x443.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.249,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.25, NICE_REPLY_A=-0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Cc: Huacai Chen <zltjiangshi@gmail.com>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Aurelien Jarno <aurelien@aurel32.net>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/11/20 5:02 AM, Huacai Chen wrote:
> Hi, Philippe,
> 
> On Sat, Oct 10, 2020 at 9:07 PM Philippe Mathieu-Daudé <f4bug@amsat.org> wrote:
>>
>> On 10/7/20 10:39 AM, Huacai Chen wrote:
>>> From: Jiaxun Yang <jiaxun.yang@flygoat.com>
>>>
>>> LDC2/SDC2 opcodes have been rewritten as "load & store with offset"
>>> group of instructions by loongson-ext ASE.
>>>
>>> This patch add implementation of these instructions:
>>> gslbx: load 1 bytes to GPR
>>> gslhx: load 2 bytes to GPR
>>> gslwx: load 4 bytes to GPR
>>> gsldx: load 8 bytes to GPR
>>> gslwxc1: load 4 bytes to FPR
>>> gsldxc1: load 8 bytes to FPR
>>> gssbx: store 1 bytes from GPR
>>> gsshx: store 2 bytes from GPR
>>> gsswx: store 4 bytes from GPR
>>> gssdx: store 8 bytes from GPR
>>> gsswxc1: store 4 bytes from FPR
>>> gssdxc1: store 8 bytes from FPR
>>>
>>> Details of Loongson-EXT is here:
>>> https://github.com/FlyGoat/loongson-insn/blob/master/loongson-ext.md
>>>
>>> Signed-off-by: Huacai Chen <chenhc@lemote.com>
>>> Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
>>
>> If this patch is from Jiaxun, Huacai's S-o-b should come *after*.
> OK, I will do that.
> 
>>
>>> ---
>>>    target/mips/translate.c | 179 ++++++++++++++++++++++++++++++++++++++++++++++++
>>>    1 file changed, 179 insertions(+)
>>>
>>> diff --git a/target/mips/translate.c b/target/mips/translate.c
>>> index 916b57f..4d42cfc 100644
>>> --- a/target/mips/translate.c
>>> +++ b/target/mips/translate.c
>>> @@ -484,6 +484,24 @@ enum {
>>>        OPC_GSSDRC1     = 0x7 | OPC_GSSHFS,
>>>    };
>>>
>>> +/* Loongson EXT LDC2/SDC2 opcodes */
>>> +#define MASK_LOONGSON_LSDC2(op)           (MASK_OP_MAJOR(op) | (op & 0x7))
>>> +
>>> +enum {
>>> +    OPC_GSLBX      = 0x0 | OPC_LDC2,
>>> +    OPC_GSLHX      = 0x1 | OPC_LDC2,
>>> +    OPC_GSLWX      = 0x2 | OPC_LDC2,
>>> +    OPC_GSLDX      = 0x3 | OPC_LDC2,
>>> +    OPC_GSLWXC1    = 0x6 | OPC_LDC2,
>>> +    OPC_GSLDXC1    = 0x7 | OPC_LDC2,
>>> +    OPC_GSSBX      = 0x0 | OPC_SDC2,
>>> +    OPC_GSSHX      = 0x1 | OPC_SDC2,
>>> +    OPC_GSSWX      = 0x2 | OPC_SDC2,
>>> +    OPC_GSSDX      = 0x3 | OPC_SDC2,
>>> +    OPC_GSSWXC1    = 0x6 | OPC_SDC2,
>>> +    OPC_GSSDXC1    = 0x7 | OPC_SDC2,
>>> +};
>>> +
>>>    /* BSHFL opcodes */
>>>    #define MASK_BSHFL(op)              (MASK_SPECIAL3(op) | (op & (0x1F << 6)))
>>>
>>> @@ -6172,6 +6190,165 @@ static void gen_loongson_lswc2(DisasContext *ctx, int rt,
>>>        tcg_temp_free(t0);
>>>    }
>>>
>>> +/* Loongson EXT LDC2/SDC2 */
>>> +static void gen_loongson_lsdc2(DisasContext *ctx, int rt,
>>> +                                int rs, int rd)
>>
>> Alignment off (various occurences in this series).
> OK, thanks.
> 
>>
>>> +{
>>> +    int offset = (int8_t)(ctx->opcode >> 3);
>>
>> Please use sextract32() which is easier to read:
>>
>>          int32_t offset = sextract32(ctx->opcode, 3, 8);
> OK, thanks.
> 
>>
>>> +    uint32_t opc = MASK_LOONGSON_LSDC2(ctx->opcode);
>>> +    TCGv t0, t1;
>>> +    TCGv_i32 fp0;
>>> +
>>> +    /* Pre-conditions */
>>> +    switch (opc) {
>>> +    case OPC_GSLBX:
>>> +    case OPC_GSLHX:
>>> +    case OPC_GSLWX:
>>> +    case OPC_GSLDX:
>>> +        /* prefetch, implement as NOP */
>>> +        if (rt == 0) {
>>> +            return;
>>> +        }
>>> +        break;
>>> +    case OPC_GSSBX:
>>> +    case OPC_GSSHX:
>>> +    case OPC_GSSWX:
>>> +    case OPC_GSSDX:
>>> +        break;
>>> +    case OPC_GSLWXC1:
>>> +#if defined(TARGET_MIPS64)
>>> +    case OPC_GSLDXC1:
>>> +#endif
>>> +        check_cp1_enabled(ctx);
>>> +        /* prefetch, implement as NOP */
>>> +        if (rt == 0) {
>>> +            return;
>>> +        }
>>> +        break;
>>> +    case OPC_GSSWXC1:
>>> +#if defined(TARGET_MIPS64)
>>> +    case OPC_GSSDXC1:
>>> +#endif
>>> +        check_cp1_enabled(ctx);
>>> +        break;
>>> +    default:
>>> +        MIPS_INVAL("loongson_lsdc2");
>>> +        generate_exception_end(ctx, EXCP_RI);
>>> +        return;
>>> +        break;
>>> +    }
>>> +
>>> +    t0 = tcg_temp_new();
>>> +
>>> +    gen_base_offset_addr(ctx, t0, rs, offset);
>>> +    gen_op_addr_add(ctx, t0, cpu_gpr[rd], t0);
>>> +
>>> +    switch (opc) {
>>> +    case OPC_GSLBX:
>>> +        tcg_gen_qemu_ld_tl(t0, t0, ctx->mem_idx, MO_SB);
>>> +        gen_store_gpr(t0, rt);
>>> +        break;
>>> +    case OPC_GSLHX:
>>> +        tcg_gen_qemu_ld_tl(t0, t0, ctx->mem_idx, MO_TESW |
>>> +                            ctx->default_tcg_memop_mask);
>>
>> Do Loongson EXT plan to support unaligned accesses?
> Not support in hardware, and Linux kernel emulate the unaligned cases.

OK, that was my understanding. So we don't need to use
default_tcg_memop_mask, we can directly use MO_ALIGN in
place instead.

Regards,

Phil.

