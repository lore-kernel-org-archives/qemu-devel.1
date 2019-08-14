Return-Path: <SRS0=fB5B=WK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A90BAC32753
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Aug 2019 18:08:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 75EB9206C1
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Aug 2019 18:08:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="hepls6ws"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 75EB9206C1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34822 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hxxgm-0007iF-DF
	for qemu-devel@archiver.kernel.org; Wed, 14 Aug 2019 14:08:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40583)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <palmer@sifive.com>) id 1hxxg7-0007HP-Ny
 for qemu-devel@nongnu.org; Wed, 14 Aug 2019 14:07:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <palmer@sifive.com>) id 1hxxg6-0002ch-DO
 for qemu-devel@nongnu.org; Wed, 14 Aug 2019 14:07:19 -0400
Received: from mail-pg1-x542.google.com ([2607:f8b0:4864:20::542]:45129)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <palmer@sifive.com>) id 1hxxg6-0002c9-6Y
 for qemu-devel@nongnu.org; Wed, 14 Aug 2019 14:07:18 -0400
Received: by mail-pg1-x542.google.com with SMTP id o13so53460375pgp.12
 for <qemu-devel@nongnu.org>; Wed, 14 Aug 2019 11:07:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sifive.com; s=google;
 h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
 :content-transfer-encoding;
 bh=BYMZIJRAjZIOACutjhNqljiEiMOmv7+eNJtz5BWVSgw=;
 b=hepls6ws1FXVROt6tr7O2nbFJcHq/sukUcuQAC0kC5+ycaHM1JfKTjXuNUwE2RMfNQ
 /FX4dIL+rlz9nA843y1h+qLNCmJYGsbP12rcVsaS4wMLVQWO7NDiypJZaNHPsRfpqWrv
 YQMs9GpdY4tjnFdvnzFsNSZcLs2R3DO6Leg/0Hks5d07xvxfrmnmWO61tdXxbYiLCv8O
 XYJPciZ/WOBe3joiwHKpGvinFr3m4ko9J9jeWBkFwRwLQQhmVWEK1vNhw6rmvmXUrwd6
 r5kkxSKu8HKMI3twUtLKOQwi6xfdqyQa6b309A93O0thOzMmyClld8YxiAx0p3otLzKa
 8DQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
 :mime-version:content-transfer-encoding;
 bh=BYMZIJRAjZIOACutjhNqljiEiMOmv7+eNJtz5BWVSgw=;
 b=da6HBEwJydwYRg4jEG8ufy6HGW+s4orDk0+tRWUJ2sZ6dYJIa7kdv77jkVoMfR5U/5
 jISO6q5tBRklcfVktL85T3+oNJyWeliryfENEUk30yKGiPzRLm6XB7EAofDmZHyKhNtv
 tTTVmCYXIP/PTNpsosvKdr52cSjVAVAgSSZCRfxpeXdDAbbJmQs5MSAJpEKqabIOovdU
 NqChbPjm9riEGq+ZOzEXAnIA7TnlHikcB5cePnsjWPcjZDMRHxJZzr/zc51IaGL57v7e
 k1VHqntfekSygzCHxRUY7t5CaNURtkcMO5Oenz76CiHL/1BAKXd76xuvnV/HyeFMb4zz
 L4aw==
X-Gm-Message-State: APjAAAXMER3wccQXQnb9VU8htlxFsswCsxHxnDN+xmq4Bm/tOkP7mG+V
 xMcM1Baf3XqGRRV8q2abc7HoUg==
X-Google-Smtp-Source: APXvYqy4F7rriy4VoxSPVX1QlZ3crKkoK6y2dlG8veTj0821JfFtb4ymEc3gwmmtmwt5jd9Sgbagxw==
X-Received: by 2002:a62:aa13:: with SMTP id e19mr1171919pff.37.1565806036961; 
 Wed, 14 Aug 2019 11:07:16 -0700 (PDT)
Received: from localhost ([12.206.222.5])
 by smtp.gmail.com with ESMTPSA id f26sm531371pfq.38.2019.08.14.11.07.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Aug 2019 11:07:16 -0700 (PDT)
Date: Wed, 14 Aug 2019 11:07:16 -0700 (PDT)
X-Google-Original-Date: Wed, 14 Aug 2019 10:56:01 PDT (-0700)
In-Reply-To: <CAKmqyKOikOJCp0d7ivt2tvd9P56xGZKEh_OrGBf4qo0hQOidJA@mail.gmail.com>
From: Palmer Dabbelt <palmer@sifive.com>
To: alistair23@gmail.com
Message-ID: <mhng-dea7d47b-8f66-44b1-84c8-6b5a04ee0b86@palmer-si-x1c4>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::542
Subject: Re: [Qemu-devel] [PATCH-4.2 v2 5/5] target/riscv: Fix Floating
 Point register names
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
Cc: qemu-riscv@nongnu.org, Alistair Francis <Alistair.Francis@wdc.com>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 13 Aug 2019 10:06:58 PDT (-0700), alistair23@gmail.com wrote:
> On Mon, Aug 12, 2019 at 4:08 PM Palmer Dabbelt <palmer@sifive.com> wrote:
>>
>> On Tue, 30 Jul 2019 16:35:34 PDT (-0700), Alistair Francis wrote:
>> > From: Atish Patra <atish.patra@wdc.com>
>> >
>> > As per the RISC-V spec, Floating Point registers are named as f0..f31
>> > so lets fix the register names accordingly.
>> >
>> > Signed-off-by: Atish Patra <atish.patra@wdc.com>
>> > Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
>> > ---
>> >  target/riscv/cpu.c | 8 ++++----
>> >  1 file changed, 4 insertions(+), 4 deletions(-)
>> >
>> > diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
>> > index f8d07bd20a..af1e9b7690 100644
>> > --- a/target/riscv/cpu.c
>> > +++ b/target/riscv/cpu.c
>> > @@ -40,10 +40,10 @@ const char * const riscv_int_regnames[] = {
>> >  };
>> >
>> >  const char * const riscv_fpr_regnames[] = {
>> > -  "ft0", "ft1", "ft2",  "ft3",  "ft4", "ft5", "ft6",  "ft7",
>> > -  "fs0", "fs1", "fa0",  "fa1",  "fa2", "fa3", "fa4",  "fa5",
>> > -  "fa6", "fa7", "fs2",  "fs3",  "fs4", "fs5", "fs6",  "fs7",
>> > -  "fs8", "fs9", "fs10", "fs11", "ft8", "ft9", "ft10", "ft11"
>> > +  "f0", "f1", "f2",  "f3",  "f4", "f5", "f6", "f7",
>> > +  "f8", "f9", "f10",  "f11",  "f12", "f13", "f14", "f15",
>> > +  "f16", "f17", "f18",  "f19",  "f20", "f21", "f22", "f23",
>> > +  "f24", "f25", "f26", "f27", "f28", "f29", "f30", "f31"
>> >  };
>> >
>> >  const char * const riscv_excp_names[] = {
>>
>> I actually don't think this one is right: riscv_int_regnames uses the ABI
>> names, so this should match.  I'd be OK switching both of them, but not just
>> one.
>
> I like that the int registers use the ABI names though, as I find that useful.
>
> What about we change the registers to use both? As in something like
> x0/zero for all registers?
>
> The disadvantage is that it's a little longer, but it seems the most useful.

I'm fine with that, as long as it doesn't show up in the GDB XML stuff as that 
will likely cause issues.

> Alistair
>
>>
>> I've queued the other four patches.

