Return-Path: <SRS0=g8gL=WD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FFC2C32751
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Aug 2019 17:25:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CA6692229C
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Aug 2019 17:25:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="CmVP0vSg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA6692229C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43786 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hvPh6-00029c-1c
	for qemu-devel@archiver.kernel.org; Wed, 07 Aug 2019 13:25:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54333)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <palmer@sifive.com>) id 1hvPgc-0001dV-8Y
 for qemu-devel@nongnu.org; Wed, 07 Aug 2019 13:25:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <palmer@sifive.com>) id 1hvPgb-0007Nn-8x
 for qemu-devel@nongnu.org; Wed, 07 Aug 2019 13:25:18 -0400
Received: from mail-pl1-x641.google.com ([2607:f8b0:4864:20::641]:37261)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <palmer@sifive.com>) id 1hvPgb-0007La-1Z
 for qemu-devel@nongnu.org; Wed, 07 Aug 2019 13:25:17 -0400
Received: by mail-pl1-x641.google.com with SMTP id b3so41836238plr.4
 for <qemu-devel@nongnu.org>; Wed, 07 Aug 2019 10:25:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sifive.com; s=google;
 h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
 :content-transfer-encoding;
 bh=Qia39A3RdeKMzCgJmI5iAQYq9gFiR+QJM6Y430p4Wx8=;
 b=CmVP0vSgzkVJm5GjoKJNhsNJiqjjNRHPEIpPQWY87w5WF3bJWMhCFTWHn5nwCJgxzQ
 EndnCSz8hFqDKaT0KR8ogieFEtQB/zZ4g8ier/JDCgs023FA2v9o95qziEpXdOM4lTxV
 0POfpte/EyVFqEwO/USd3fYSyUi/X4g2p0En4UW8o2RN5T57dBqrZTiHEnwJRpVIQdvv
 MRbc0519iGd4e+BnsZd7ZFTAokrnjzuikIXW03wvzNbLQuMqGEbqaBbhyu85KZmUKkut
 7gcPqF0cshkZ3WP9mdOuLLLyoSf5tn3mFD+XUsZ4F76u7bEEgDyl00xt4N1lRKKutxUd
 003w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
 :mime-version:content-transfer-encoding;
 bh=Qia39A3RdeKMzCgJmI5iAQYq9gFiR+QJM6Y430p4Wx8=;
 b=uNASzdrrLqocDqlk1b3/F91FwTbSOVGRD8g29ftu2AT4qVodYR68j93RsXJ9oTE0B6
 yvZ7gbhEL+tuSyJTp/ck/yqtKyxnlunp1SYNh3mIUlzDD9DXkdt5hq7Fx7jbraMqQQZX
 uZFvVqlUrga1Io8GuRyHfmkh0hROY/k/MtvrBY5S+Y1fkN5ZB904s1YzFXrCw/e3QTxV
 EdaGmsG9+1gDGtFOoGaXKNRh94JWirO3GRJTF2OGEePVgbvjYleU3B5rj0V/isjMfT7g
 6E8HZc3wGIPqiI+X8cSU4r5/4sa8QMh8/GsfesA61+3pzJQ2VUSmuJSKLRHNVF10q6SJ
 FT9Q==
X-Gm-Message-State: APjAAAU5a9O7UOhDHT5iKsgRIfsx7mSt3IdqY8m5+mVjORkfZ4vf+BfM
 Oytr8YgYvxwVPSUZ1uKaDTvvcA==
X-Google-Smtp-Source: APXvYqxkoomxIRUSdPFpwpyii3DyXZwp58FvrgerHVRBt7lfd/vU2ESWVsXt+eXUJgkSBVRC6lV5UQ==
X-Received: by 2002:a63:c84d:: with SMTP id l13mr8666342pgi.154.1565198715353; 
 Wed, 07 Aug 2019 10:25:15 -0700 (PDT)
Received: from localhost ([12.206.222.5])
 by smtp.gmail.com with ESMTPSA id 67sm72433878pfd.177.2019.08.07.10.25.14
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Wed, 07 Aug 2019 10:25:14 -0700 (PDT)
Date: Wed, 07 Aug 2019 10:25:14 -0700 (PDT)
X-Google-Original-Date: Wed, 07 Aug 2019 09:53:36 PDT (-0700)
In-Reply-To: <CAFEAcA9YeuvQPnvG1+Cdb+-JbsbKaRpa0Frv5zz+Vb3q0prAeQ@mail.gmail.com>
From: Palmer Dabbelt <palmer@sifive.com>
To: Peter Maydell <peter.maydell@linaro.org>
Message-ID: <mhng-21b84257-7bfd-4a52-b6f2-cefa6fcf703a@palmer-si-x1c4>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::641
Subject: Re: [Qemu-devel] [PATCH for 4.1] RISC-V: Ignore the S and U
 extensions when formatting ISA strings
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
Cc: Alistair Francis <Alistair.Francis@wdc.com>,
 Paul Walmsley <paul.walmsley@sifive.com>, qemu-riscv@nongnu.org,
 qemu-devel@nongnu.org, Atish Patra <Atish.Patra@wdc.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 07 Aug 2019 09:41:17 PDT (-0700), Peter Maydell wrote:
> On Wed, 7 Aug 2019 at 16:02, Palmer Dabbelt <palmer@sifive.com> wrote:
>>
>> The ISA strings we're providing from QEMU aren't actually legal RISC-V
>> ISA strings, as both the S and U extensions cannot exist as
>> single-letter extensions and must instead be multi-letter strings.
>> We're still using the ISA strings inside QEMU to track the availiable
>> extensions, so this patch just strips out the S and U extensions when
>> formatting ISA strings.
>>
>> This boots Linux on top of 4.1-rc3, which no longer has the U extension
>> in /proc/cpuinfo.
>>
>> Signed-off-by: Palmer Dabbelt <palmer@sifive.com>
>> ---
>> This is another late one, but I'd like to target it for 4.1 as we're
>> providing illegal ISA strings and I don't want to bake that into a bunch
>> of other code.
>> ---
>>  target/riscv/cpu.c | 17 ++++++++++++++++-
>>  1 file changed, 16 insertions(+), 1 deletion(-)
>>
>> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
>> index f8d07bd20ad7..4df14433d789 100644
>> --- a/target/riscv/cpu.c
>> +++ b/target/riscv/cpu.c
>> @@ -501,7 +501,22 @@ char *riscv_isa_string(RISCVCPU *cpu)
>>      char *p = isa_str + snprintf(isa_str, maxlen, "rv%d", TARGET_LONG_BITS);
>>      for (i = 0; i < sizeof(riscv_exts); i++) {
>>          if (cpu->env.misa & RV(riscv_exts[i])) {
>> -            *p++ = qemu_tolower(riscv_exts[i]);
>> +            char lower = qemu_tolower(riscv_exts[i]);
>> +            switch (lower) {
>> +            case 's':
>> +            case 'u':
>> +                /*
>> +                 * The 's' and 'u' extensions shouldn't be passed in the device
>> +                 * tree, but we still use them internally to track extension
>> +                 * sets.  Here we just explicitly remove them when formatting
>> +                 * an ISA string.
>> +                 */
>> +                break;
>> +
>> +            default:
>> +                *p++ = qemu_tolower(riscv_exts[i]);
>
>  *p++ = lower;  ?

Yes, thanks -- that's why I pulled the variable out in the first place :)

>
> thanks
> -- PMM

