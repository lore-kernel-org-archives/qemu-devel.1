Return-Path: <SRS0=Dj2y=5L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95FF9C43331
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2020 23:53:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5ECEA20719
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2020 23:53:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dEieT6t/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5ECEA20719
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35330 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jHcJs-00009c-ID
	for qemu-devel@archiver.kernel.org; Thu, 26 Mar 2020 19:53:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42819)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alistair23@gmail.com>) id 1jHcJF-00085G-VT
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 19:53:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alistair23@gmail.com>) id 1jHcJE-0004YY-Se
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 19:53:13 -0400
Received: from mail-vs1-xe42.google.com ([2607:f8b0:4864:20::e42]:45855)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alistair23@gmail.com>)
 id 1jHcJE-0004Xf-Nv; Thu, 26 Mar 2020 19:53:12 -0400
Received: by mail-vs1-xe42.google.com with SMTP id x82so5083747vsc.12;
 Thu, 26 Mar 2020 16:53:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=z+HGkigCTY+gVybeiKe42pJ6OvxmiSA7KAJu97PBKgo=;
 b=dEieT6t/TXNf289vGBIZeEr+UClY5lMugwuWxqpRLGc4zM7AZm9b4TfQ1XMIaHTRbG
 SqTHQVga0xoNuIHBPvAbBJI1IuIBpklizCGNyaKcUdvcbXEzmEHaNcFzf2HpC0BmaL2o
 XRhDTVURBOWbmr1MAAc8EQ/UyPP6l4W2HGnUxg7Az7xmeCYToD/5dsh2l2d9+Yl2cEYn
 7QJ2O4qh1GiC36ep8ak2uim9xFdmIfVWIL5wYeCfsaq4J141Er4xo1ViyhYixRTV9NOy
 0lLyM7qiPrNtWQD0d8GEgyyJk6XO/YkR8HxsVBbxlxwcHLLaPHMDeDeo5aEBXy9KMlhm
 j0VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=z+HGkigCTY+gVybeiKe42pJ6OvxmiSA7KAJu97PBKgo=;
 b=bvigD+RBTargRnXS+PClBKJwM1aNALvvBQ/OMGQ8zEPAV1dKc5FBvzC+Z+mzekns5E
 mJWni4wlpkEKzCsi7M1uFgmz17mbsFSNL3lYBhCewrGDaOnalW9OhxQ7qDdkSIua+GlA
 i31J2ZA4xSsjSyBsyhYiJBiAAe2znQIMgAHEQCwsa5rgBbZYs5WtHYeJBSABG0murs8M
 nsu1idI0POh03rjE2DYZiBjrEh0XWouL4mVitz2CwyRNENvpvigx/guFJku9ZPBGAXfM
 XIJ2nmBlnCdwDi3qdCKBJE5hc+XqHVrd279RLlBIGZL8k83VDyGZMQ5Yp7qIGryFRGEX
 T3wg==
X-Gm-Message-State: ANhLgQ3f9hKubFvslCcZ5AnbAqil6Hzs08WF8/d0MmMiZuXFfAvPoIUI
 BaWyHtYPcZgblxnC8PT1qNvKoyn1RIg+5URhi9W0Wr0cDsY=
X-Google-Smtp-Source: ADFU+vvfXwQrBUTTfO4haBLj4m2uoaxYnz2c622TXNGE4J5jAnN8ZVIf9UNaltVZC9rrBLJSAToB4iS2mTb3DI+Hdgk=
X-Received: by 2002:a67:902:: with SMTP id 2mr10698923vsj.133.1585266791852;
 Thu, 26 Mar 2020 16:53:11 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1585262586.git.alistair.francis@wdc.com>
 <846f1e18f5922d818bc464ec32c144ef314ec724.1585262586.git.alistair.francis@wdc.com>
 <c835ef40-6e7a-7639-236c-5fb939bf7fc2@linaro.org>
In-Reply-To: <c835ef40-6e7a-7639-236c-5fb939bf7fc2@linaro.org>
From: Alistair Francis <alistair23@gmail.com>
Date: Thu, 26 Mar 2020 16:45:10 -0700
Message-ID: <CAKmqyKPnLZTYogkFZf1d4=guuz_qFd_ixo18peEADG_xdtoiPQ@mail.gmail.com>
Subject: Re: [PATCH for 5.0 v1 2/2] riscv: AND stage-1 and stage-2 protection
 flags
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::e42
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
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Mar 26, 2020 at 4:32 PM Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> On 3/26/20 3:44 PM, Alistair Francis wrote:
> > Take the result of stage-1 and stage-2 page table walks and AND the two
> > protection flags together. This way we require both to set permissions
> > instead of just stage-2.
> >
> > Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
> > ---
> >  target/riscv/cpu_helper.c | 8 +++++---
> >  1 file changed, 5 insertions(+), 3 deletions(-)
> >
> > diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
> > index f36d184b7b..50e13a064f 100644
> > --- a/target/riscv/cpu_helper.c
> > +++ b/target/riscv/cpu_helper.c
> > @@ -707,7 +707,7 @@ bool riscv_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
> >  #ifndef CONFIG_USER_ONLY
> >      vaddr im_address;
> >      hwaddr pa = 0;
> > -    int prot;
> > +    int prot, prot2;
> >      bool pmp_violation = false;
> >      bool m_mode_two_stage = false;
> >      bool hs_mode_two_stage = false;
> > @@ -757,13 +757,15 @@ bool riscv_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
> >              /* Second stage lookup */
> >              im_address = pa;
> >
> > -            ret = get_physical_address(env, &pa, &prot, im_address,
> > +            ret = get_physical_address(env, &pa, &prot2, im_address,
> >                                         access_type, mmu_idx, false, true);
> >
> >              qemu_log_mask(CPU_LOG_MMU,
> >                      "%s 2nd-stage address=%" VADDR_PRIx " ret %d physical "
> >                      TARGET_FMT_plx " prot %d\n",
> > -                    __func__, im_address, ret, pa, prot);
> > +                    __func__, im_address, ret, pa, prot2);
> > +
> > +            prot &= prot2;
> >
> >              if (riscv_feature(env, RISCV_FEATURE_PMP) &&
> >                  (ret == TRANSLATE_SUCCESS) &&
> >
>
> Whee!  Yes, I think this is what you've been looking for.

Yep!

I actually tried this ages ago, but it didn't work without the first
path so it never fixed the problem.

> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

Thanks

Alistair

>
>
> r~

