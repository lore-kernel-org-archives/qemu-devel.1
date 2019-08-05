Return-Path: <SRS0=vzij=WB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F2ABC0650F
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Aug 2019 06:44:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0BED02086D
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Aug 2019 06:44:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jaQa5WF/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0BED02086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50918 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1huWji-0006YT-Ai
	for qemu-devel@archiver.kernel.org; Mon, 05 Aug 2019 02:44:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:32778)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <bmeng.cn@gmail.com>) id 1huWj2-00066l-9j
 for qemu-devel@nongnu.org; Mon, 05 Aug 2019 02:44:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bmeng.cn@gmail.com>) id 1huWj1-0003KQ-Am
 for qemu-devel@nongnu.org; Mon, 05 Aug 2019 02:44:08 -0400
Received: from mail-ed1-x544.google.com ([2a00:1450:4864:20::544]:46147)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bmeng.cn@gmail.com>)
 id 1huWj1-0003Ia-5C; Mon, 05 Aug 2019 02:44:07 -0400
Received: by mail-ed1-x544.google.com with SMTP id d4so77654768edr.13;
 Sun, 04 Aug 2019 23:44:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=4KyS6xKm/sjfbPt3VI4totXhOCWYjVSZ+Sav2FQdi+I=;
 b=jaQa5WF/LOZ2Icn6G+p8jrCgsDJThuBd+UdWCE2D21HJ+TR8QBPlfSFBQiqenpYBBv
 UxXEJHUbiYKU2QZaeqSxeAGGBnhXNb/Df5mJJit8S2FC04N9HrWnnhgkMuKG2OWbcW9Z
 VSFaWZR5SHTyMvmTrbC2F8pCqCOSUwmQFC5WxsJAKb+BmksD1OuecfBqEGCxZt6s4zgt
 YjA5WOQBCNjsqj3GaV3TwXx5x9ei02XQX9YA8IS/MvoSliLaOhAo76M49LgajrDAwS42
 6+4918lm7Su+/qkF/yNsZSHvguC3rVSHO/AOOimqU1mRloEY6ObnPCw8g224VqUN2Ono
 UAqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=4KyS6xKm/sjfbPt3VI4totXhOCWYjVSZ+Sav2FQdi+I=;
 b=bRf4Ls5Yu/mJSrfYQ+jFJ8su1iYsErxMOWre6gBOi+UBaeMB7Qz7KuYq4gr+uCqcgC
 Znas0oHU0bg/FtpiiqQDmjms9mXQG108u2oL7MMDA6RBHT7io3K0S9wl194agpZj3ex9
 Gq5rSYtXGRuBz+f/PvgUaiSOfjlpA4pXjC9+3iAaJnCib94hXYR5NaUa/uUsfF1JsGyy
 6detR+YbLZSqhxaiTQo/RQBZ5xwEcze2l8a0nv7x5eFd2HFB/YWtDjC5kBnyAW/e+0VS
 H0PV6uJ528rAnO7bq6DXvyYjt+0Y/zGgtDgj945+QL0w3Qi3mY9lEzLSKdwrjs0HxH2O
 /a/g==
X-Gm-Message-State: APjAAAUuZJoOwL5IPZlZDIm4jt1/5Bsm5khn5gcizBfwnFC/2sCqkHPr
 TVFxAsMy4e5dBeuYzz7+W5xRE5HCiY3Bz3rxjeA=
X-Google-Smtp-Source: APXvYqzhbjwocTpSUbzHPT3VLtQN8yxkg0B6BjzO5VdJV3giIBEKhVlsGFCPsWIErVWEFUvocJ8bsU8Z5f7QPr+VdXQ=
X-Received: by 2002:a50:b388:: with SMTP id s8mr129938428edd.15.1564987446019; 
 Sun, 04 Aug 2019 23:44:06 -0700 (PDT)
MIME-Version: 1.0
References: <1564792052-6469-1-git-send-email-bmeng.cn@gmail.com>
 <CAEiOBXWQ02uRQQOpP=Rauq8WZnYtoxNqjM--Rpi5tHX2W0bGsw@mail.gmail.com>
In-Reply-To: <CAEiOBXWQ02uRQQOpP=Rauq8WZnYtoxNqjM--Rpi5tHX2W0bGsw@mail.gmail.com>
From: Bin Meng <bmeng.cn@gmail.com>
Date: Mon, 5 Aug 2019 14:43:53 +0800
Message-ID: <CAEUhbmU-TdVocONETkSV-+DtX_66+8J8m3yYeph3P1i_3C9LzQ@mail.gmail.com>
To: Chih-Min Chao <chihmin.chao@sifive.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::544
Subject: Re: [Qemu-devel] [Qemu-riscv] [PATCH] riscv: sifive_e: Correct
 various SoC IP block sizes
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
Cc: "open list:RISC-V" <qemu-riscv@nongnu.org>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Palmer Dabbelt <palmer@sifive.com>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 Alistair Francis <Alistair.Francis@wdc.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Aug 5, 2019 at 2:14 PM Chih-Min Chao <chihmin.chao@sifive.com> wrote:
>
>
>
> On Sat, Aug 3, 2019 at 8:27 AM Bin Meng <bmeng.cn@gmail.com> wrote:
>>
>> Some of the SoC IP block sizes are wrong. Correct them according
>> to the FE310 manual.
>>
>> Signed-off-by: Bin Meng <bmeng.cn@gmail.com>
>> ---
>>
>>  hw/riscv/sifive_e.c | 6 +++---
>>  1 file changed, 3 insertions(+), 3 deletions(-)
>>
>> diff --git a/hw/riscv/sifive_e.c b/hw/riscv/sifive_e.c
>> index 2a499d8..9655847 100644
>> --- a/hw/riscv/sifive_e.c
>> +++ b/hw/riscv/sifive_e.c
>> @@ -53,13 +53,13 @@ static const struct MemmapEntry {
>>      hwaddr base;
>>      hwaddr size;
>>  } sifive_e_memmap[] = {
>> -    [SIFIVE_E_DEBUG] =    {        0x0,      0x100 },
>> +    [SIFIVE_E_DEBUG] =    {        0x0,     0x1000 },
>>      [SIFIVE_E_MROM] =     {     0x1000,     0x2000 },
>>      [SIFIVE_E_OTP] =      {    0x20000,     0x2000 },
>>      [SIFIVE_E_CLINT] =    {  0x2000000,    0x10000 },
>>      [SIFIVE_E_PLIC] =     {  0xc000000,  0x4000000 },
>> -    [SIFIVE_E_AON] =      { 0x10000000,     0x8000 },
>> -    [SIFIVE_E_PRCI] =     { 0x10008000,     0x8000 },
>> +    [SIFIVE_E_AON] =      { 0x10000000,     0x1000 },
>> +    [SIFIVE_E_PRCI] =     { 0x10008000,     0x1000 },
>>      [SIFIVE_E_OTP_CTRL] = { 0x10010000,     0x1000 },
>>      [SIFIVE_E_GPIO0] =    { 0x10012000,     0x1000 },
>>      [SIFIVE_E_UART0] =    { 0x10013000,     0x1000 },
>> --
>> 2.7.4
>>
>
> It seems the modification follows  E310-G002(Hifive1 Rev B) spec and the origin is for E310-G000(Hifive1) spec.
> There should be some way to specify different board version with different memory map or we have policy, always support the latest spec.
>

Yes, I checked both specs. The older spec says these bigger sizes,
however their register sizes fit well in the smaller range as well. So
I think the modification works well for both.

Regards,
Bin

