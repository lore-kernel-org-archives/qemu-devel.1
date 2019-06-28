Return-Path: <SRS0=Ouwy=U3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E28AC4321A
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2019 22:05:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 68CCC20828
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2019 22:05:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZUUvhewb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 68CCC20828
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36596 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hgyzY-00089Y-KK
	for qemu-devel@archiver.kernel.org; Fri, 28 Jun 2019 18:05:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36631)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <alistair23@gmail.com>) id 1hgyww-00076f-C2
 for qemu-devel@nongnu.org; Fri, 28 Jun 2019 18:02:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alistair23@gmail.com>) id 1hgywu-0006X3-0a
 for qemu-devel@nongnu.org; Fri, 28 Jun 2019 18:02:29 -0400
Received: from mail-lf1-x144.google.com ([2a00:1450:4864:20::144]:39614)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alistair23@gmail.com>)
 id 1hgywc-0006Ic-Ji; Fri, 28 Jun 2019 18:02:10 -0400
Received: by mail-lf1-x144.google.com with SMTP id p24so4902413lfo.6;
 Fri, 28 Jun 2019 15:02:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=JF5n++4/DpTufVXfWmY5Yo0fSCSYNwLFIS1Bwvr7cNU=;
 b=ZUUvhewblfETEHW/FAViEURAvImx5XBprKwQxiJgRtMq7XIRpm0TAVALWS605OGRYA
 dpghXTkY2K5QNB2UGjtXSEmg67BqwPJbHy5TV5cBp30wa30FLs3apACiiSrP2n0MBEs9
 QFXxSb7toPuLRFRhj1Xo7faqRFlk7/IME5N7Wm6XchyDfrIMKhI4oAdj6kTmJi7W8nea
 Buvk2MEO8QWO2+ZGj7XI2EwpVqQxk4aMSpxh344yVvOKlR6Mrm7RyW00m38a75+crjL/
 hM7sqoXI4DQg3JxfTo/ypGJvLJSk/XF/dMEKy7IaUMXgqBWwEAilX1F6pC3MmqVohDjP
 JsGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=JF5n++4/DpTufVXfWmY5Yo0fSCSYNwLFIS1Bwvr7cNU=;
 b=bSpF3k3ftpco8i08uPAmJBM464v57XTN9BGUcsSTmtqbALW2vVbGtPLvGK9ZiJegFN
 ZQ+TF6+a+3FSocw0PeuCVV2jRu0JKqFr1jPer/L4gXaJmn6j8GiccRX5nYFqiWDzjf/f
 ulH6P525P+Ght3FPOEXnSP8SP4LJQ58fgPycsR7KAQQMfEsG0Hn/tK2lsPLDRqs91sAe
 f58DI3ylN8VJtpXNNZbc3thKG0guI6760IwgLJlVwH0oyKp0+9yovju2676TozuQTYHp
 YrpZLfdLiiWzu/SA9yv2AC7m0Tx/a7WgbunWiOIRhHc8FsMQt/SBgqxBw8CfxWUEXubw
 YP0A==
X-Gm-Message-State: APjAAAXNVNTU3pXgJUguSi4O6T8otUyPmw1+R415wIhtUT4dXD3d+1d+
 lfKrWpqqjArhgapMp6GwhSS1tpHzxQ19p3Y1MKU=
X-Google-Smtp-Source: APXvYqwl+UTQ1gauZl95fD99H5drrE1Y2mOjcXoh/FolFjHBRPUxo4ylzgwJEtkec34fMP/0Haw/Ae6v0wvPEvN48Bo=
X-Received: by 2002:a05:6512:29a:: with SMTP id
 j26mr5940495lfp.44.1561759328844; 
 Fri, 28 Jun 2019 15:02:08 -0700 (PDT)
MIME-Version: 1.0
References: <20190628201133.14235-1-jonathan@fintelia.io>
 <CAKmqyKNKD4k-Z=-cbFwqnqRQV3e+EO0V0G-brYGeHW4ir0Z+yA@mail.gmail.com>
 <CANnJOVHPR328jK0qEVpn5Tri5bUa4DvsTF8hZqJuac1nGicxRw@mail.gmail.com>
In-Reply-To: <CANnJOVHPR328jK0qEVpn5Tri5bUa4DvsTF8hZqJuac1nGicxRw@mail.gmail.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Fri, 28 Jun 2019 14:59:07 -0700
Message-ID: <CAKmqyKPGPzdJourJG0KEzxDG2=oxvYyY25NASpZNW2YhjVDe3w@mail.gmail.com>
To: Jonathan Behrens <jonathan@fintelia.io>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::144
Subject: Re: [Qemu-devel] [PATCH] target/riscv: Hardwire mcounter.TM and
 upper bits of [m|s]counteren
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
 "open list:All patches CC here" <qemu-devel@nongnu.org>,
 Alistair Francis <Alistair.Francis@wdc.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Jun 28, 2019 at 2:20 PM Jonathan Behrens <jonathan@fintelia.io> wrote:
>
> > Can you wrap your commit message at ~70 lines?
>
> Sure.
>
> > Isn't CSR_TIME & 31 just 0? Can this just be changed 1 << 1 or even better add a macro?
>
> Any of those options work. Unless anyone feels strongly otherwise, I'll add macros for the bits associated with the three named counters but not the remaining 29 unnamed "high performance counters".

Yep, sounds good.

Alistair

>
> On Fri, Jun 28, 2019 at 5:03 PM Alistair Francis <alistair23@gmail.com> wrote:
>>
>> On Fri, Jun 28, 2019 at 1:12 PM <jonathan@fintelia.io> wrote:
>> >
>> > From: Jonathan Behrens <jonathan@fintelia.io>
>> >
>> > QEMU currently always triggers an illegal instruction exception when code
>> > attempts to read the time CSR. This is valid behavor, but only if the TM bit in
>> > mcounteren is hardwired to zero. This change also corrects mcounteren and scounteren CSRs to be 32-bits on both
>> > 32-bit and 64-bit targets.
>>
>> Thanks for the patch.
>>
>> Can you wrap your commit message at ~70 lines?
>>
>> >
>> > Signed-off-by: Jonathan Behrens <jonathan@fintelia.io>
>> > ---
>> >  target/riscv/cpu.h | 4 ++--
>> >  target/riscv/csr.c | 3 ++-
>> >  2 files changed, 4 insertions(+), 3 deletions(-)
>> >
>> > diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
>> > index 0adb307f32..2d0cbe9c78 100644
>> > --- a/target/riscv/cpu.h
>> > +++ b/target/riscv/cpu.h
>> > @@ -151,8 +151,8 @@ struct CPURISCVState {
>> >      target_ulong mcause;
>> >      target_ulong mtval;  /* since: priv-1.10.0 */
>> >
>> > -    target_ulong scounteren;
>> > -    target_ulong mcounteren;
>> > +    uint32_t scounteren;
>> > +    uint32_t mcounteren;
>> >
>> >      target_ulong sscratch;
>> >      target_ulong mscratch;
>> > diff --git a/target/riscv/csr.c b/target/riscv/csr.c
>> > index e0d4586760..89cf9734c3 100644
>> > --- a/target/riscv/csr.c
>> > +++ b/target/riscv/csr.c
>> > @@ -473,7 +473,8 @@ static int write_mcounteren(CPURISCVState *env, int csrno, target_ulong val)
>> >      if (env->priv_ver < PRIV_VERSION_1_10_0) {
>> >          return -1;
>> >      }
>> > -    env->mcounteren = val;
>> > +    /* mcounteren.TM is hardwired to zero, all other bits are writable */
>> > +    env->mcounteren = val & ~(1 << (CSR_TIME & 31));
>>
>> Isn't CSR_TIME & 31 just 0? Can this just be changed 1 << 1 or even
>> better add a macro?
>>
>> Otherwise this patch looks good :)
>>
>> Alistair
>>
>> >      return 0;
>> >  }
>> >
>> > --
>> > 2.22.0
>> >

