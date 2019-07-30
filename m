Return-Path: <SRS0=D7Ry=V3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D021FC433FF
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jul 2019 00:40:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9BBFF206BA
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jul 2019 00:40:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hYfN5axu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9BBFF206BA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57226 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hsGBZ-0003fz-UZ
	for qemu-devel@archiver.kernel.org; Mon, 29 Jul 2019 20:40:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59787)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <richard.henderson@linaro.org>) id 1hsGAW-0001tb-Fc
 for qemu-devel@nongnu.org; Mon, 29 Jul 2019 20:39:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1hsGAV-0000i9-9l
 for qemu-devel@nongnu.org; Mon, 29 Jul 2019 20:39:08 -0400
Received: from mail-pg1-x541.google.com ([2607:f8b0:4864:20::541]:35333)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1hsGAT-0000fR-8k
 for qemu-devel@nongnu.org; Mon, 29 Jul 2019 20:39:06 -0400
Received: by mail-pg1-x541.google.com with SMTP id s1so22786720pgr.2
 for <qemu-devel@nongnu.org>; Mon, 29 Jul 2019 17:39:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=SHxGOz4FDTbH87+rztjIu6ElAtxs8i8JjXHc55Ce8o0=;
 b=hYfN5axuyAYrKda26vzAlWd7q3YMtYmFDs5bo3E5uyQ1qXccFqOh3Nwa2tN7gdf0Hs
 I2f7Dh72dHjp7L7i4USKbGOIVgaxDrmaY2vLKHQOgmiqvNqrMcC53G2uGTfV1R2uwlqP
 cqkDKMmjz1p5A28GyGUVFkHr82DNoshLBf87KWKkzEkCYm2hEjp7KHLqwxtgxTn02zh0
 D06SDBIxI84rUr1RlO9EZjkv1iU78mSI428zECkOSmfvpXTsRCJeZraWPQWGSKPGSUyB
 WWPumy71n+nmQkA5XaaOrZQogBMgQAm4a9nH07OvnGXJ0fQieO0keOja8sWnNK4O3fpv
 395w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=SHxGOz4FDTbH87+rztjIu6ElAtxs8i8JjXHc55Ce8o0=;
 b=Y9dDo7rGAc4QNKXjqet21TWnW7gs57Z5HHaT/yLFw1Ze84IqJuAu680/PO8tEqGP0o
 O+k1VX05KD+l2QmAeNIOBiu806ZM/EeCPhyCjmTTK2OBs1boAF1oqhneHPwyEkesw955
 0bfxi0yeyWZAa3Oqb1+AsE+5bO23/kMywXaFwMctRo/61pjpfukjayQygJsT1bk7OrBz
 48LoJ/41ALibx+xydHRW4oGWgOhwJw9cbip3qX2W6XK7LL2U5i1iP5/4aGJycg+4GnwM
 OBL83w+++cnmJ1pm3p/3oU6/VCWzEdGyiTgAgvX2tQxEHC638qmpm4fmNNSVEoA51e73
 KBzg==
X-Gm-Message-State: APjAAAU8ef1MYCTfw2DAtfve9xy/6njZssDFFHRllmcbiOiAyv1Rav12
 0E6wU1UK6xwh62IxP9ypNL921Q==
X-Google-Smtp-Source: APXvYqxaTBXc9TgYc86GS5zcJkOyEFnDPF5r91w3yhEd4ExMZAGhgqDIKfGfPdBgkKIMAXI8jQGr+A==
X-Received: by 2002:a17:90a:ad89:: with SMTP id
 s9mr115656081pjq.41.1564447140874; 
 Mon, 29 Jul 2019 17:39:00 -0700 (PDT)
Received: from [192.168.101.105] ([75.147.178.105])
 by smtp.gmail.com with ESMTPSA id u70sm26546799pgb.20.2019.07.29.17.38.59
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 29 Jul 2019 17:38:59 -0700 (PDT)
To: Peter Maydell <peter.maydell@linaro.org>
References: <20190726175032.6769-1-richard.henderson@linaro.org>
 <20190726175032.6769-7-richard.henderson@linaro.org>
 <CAFEAcA_kmuX6bxR50eU_3nTdRcjON2nVTqVWiRamSRe6jui3ig@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <09b930e2-0a92-25a3-4e26-8bea1f437039@linaro.org>
Date: Mon, 29 Jul 2019 17:38:57 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CAFEAcA_kmuX6bxR50eU_3nTdRcjON2nVTqVWiRamSRe6jui3ig@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::541
Subject: Re: [Qemu-devel] [PATCH 06/67] target/arm: Introduce pc_read
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
Cc: qemu-arm <qemu-arm@nongnu.org>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/29/19 7:05 AM, Peter Maydell wrote:
> On Fri, 26 Jul 2019 at 18:50, Richard Henderson
> <richard.henderson@linaro.org> wrote:
>>
>> We currently have 3 different ways of computing the architectural
>> value of "PC" as seen in the ARM ARM.
>>
>> The value of s->pc has been incremented past the current insn,
>> but that is all.  Thus for a32, PC = s->pc + 4; for t32, PC = s->pc;
>> for t16, PC = s->pc + 2.  These differing computations make it
>> impossible at present to unify the various code paths.
>>
>> Let s->pc_read hold the architectural value of PC for all cases.
>>
>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>> ---
>>  target/arm/translate.h | 10 ++++++++
>>  target/arm/translate.c | 53 ++++++++++++++++++------------------------
>>  2 files changed, 32 insertions(+), 31 deletions(-)
>>
>> diff --git a/target/arm/translate.h b/target/arm/translate.h
>> index a20f6e2056..2dfdd8ca66 100644
>> --- a/target/arm/translate.h
>> +++ b/target/arm/translate.h
>> @@ -9,7 +9,17 @@ typedef struct DisasContext {
>>      DisasContextBase base;
>>      const ARMISARegisters *isar;
>>
>> +    /*
>> +     * Summary of the various values for "PC":
>> +     * base.pc_next -- the start of the current insn
>> +     * pc           -- the start of the next insn
> 
> These are confusingly named -- logically "pc_next" ought to
> be the PC of the next instruction and "pc" ought to be
> that of the current one...

Yes, well.  I don't quite remember why "pc_next" was chosen for this field.  It
is the "next" upon entry to tr_foo_disas_insn().  Often the target will
increment s->base.pc_next immediately, so it will also be the "next" insn
throughout translation.  Though that isn't currently the case for ARM.

Once most of the uses of s->pc get moved to s->pc_read, it might be reasonable
to rename the remaining "s->base.pc_next" -> "s->pc_orig" and "s->pc" ->
"s->base.pc_next".  Perhaps that would be clearer, I'm not sure.


>> +     * pc_read      -- the value for "PC" in the ARM ARM;
> 
> nit: this line should end with a colon, rather than a semicolon

Oops, typo.


>> +     *                 in arm mode, the current insn + 8;
>> +     *                 in thumb mode, the current insn + 4;
>> +     *                 in aa64 mode, unused.
>> +     */
>>      target_ulong pc;
>> +    target_ulong pc_read;
>>      target_ulong page_start;
>>      uint32_t insn;
> 
> Why target_ulong rather than uint32_t, given this is
> aarch32 only?

I didn't know if it would stay aarch32 only and it seemed more natural to match
the types.


r~

