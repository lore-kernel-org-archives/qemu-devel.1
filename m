Return-Path: <SRS0=M8fn=UR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FCF5C31E51
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Jun 2019 12:04:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 58C6D20679
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Jun 2019 12:04:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="oIJ2HHVd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 58C6D20679
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56088 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hdCqG-0002yW-9G
	for qemu-devel@archiver.kernel.org; Tue, 18 Jun 2019 08:04:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52641)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <peter.maydell@linaro.org>) id 1hdClA-0001Ev-9G
 for qemu-devel@nongnu.org; Tue, 18 Jun 2019 07:58:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1hdCl9-00023E-8H
 for qemu-devel@nongnu.org; Tue, 18 Jun 2019 07:58:44 -0400
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:43861)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1hdCl9-000223-1d
 for qemu-devel@nongnu.org; Tue, 18 Jun 2019 07:58:43 -0400
Received: by mail-ot1-x341.google.com with SMTP id i8so14050881oth.10
 for <qemu-devel@nongnu.org>; Tue, 18 Jun 2019 04:58:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=uOzI7vyxmAzItnicrOeD/gq6Ty6mFLLzi0cebA6sp3A=;
 b=oIJ2HHVda7DE5GOa5SWZBQjf4e7AM7AoLXmq8Ell2whjj3WVts6WM6I8ZkjH8UOy5P
 mQdPKBgXs9NduXVvjNDawY7rmDB0ShC1Zy+AOkBSu6An9vxEBynk4UlxEn4KAzyfjABn
 X69DL1Totq/xLKXya7kCqLDEo2KANGcMPk/4r5hQHfUc9uLmJ/hdC9JDWrtaUy5vGHuY
 i3dSMJELbM07alx2S/dFuWwaMf23CUMWW8ADQrQ2gHqmbvKWHhLA6UViKV69mVK47mwi
 bKqh0690eotiyANmNXd2R6lG3ZmiR1giXfEa2xBtGWfxNwm1lArbFgoLytT8D4ZzGxJK
 +NMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=uOzI7vyxmAzItnicrOeD/gq6Ty6mFLLzi0cebA6sp3A=;
 b=n4/wdFdufKZXIyCLQuUeI0tHDmR9fJoh+zjgThJ8+7vKmrjjYAdugKErRHqT4bnBf3
 8dUcNmPR6Uby76y9L03BK5Ercvrr5oLEGzQUpJO5w+tAWPTrxOESoagxblvv9mKy6vgE
 O7wVdJgHlz2vXPQOiubTeEMZoC35gMxBMGubQDoayXXdn1wU6PKOnGMmztSnqlowSHDm
 W3H3Qoy4tla81VimMsTTaV3LYMRQTbuIEKRQLhPYtv9UzXjiZ2Azbzm6LFNPMuP03+tE
 wa8F04IPr0m04sd5y+NkH+zL/mwSdstOVX/Ev7axw9tIZJYTYDAE44L/9DOwme06sMhC
 0yCA==
X-Gm-Message-State: APjAAAXsMUDbL7aFhrsjDbaMTRQchYoswcJmJprD0jyAj4eC2bTFcJyB
 CElHw4ifLXj9VD1bwTgjRCn/Q5qGOpRAfhtKeex2qg==
X-Google-Smtp-Source: APXvYqzwAekZFqZEU86yLm3SsxR9IQelRGmuy7PpOt0WK2hu2tFx728lCQxkOORRYeL/JYmvR8n75YR+XscepM3Zeuo=
X-Received: by 2002:a9d:6e8d:: with SMTP id a13mr4514002otr.303.1560859121214; 
 Tue, 18 Jun 2019 04:58:41 -0700 (PDT)
MIME-Version: 1.0
References: <20190618083442.10407-1-drjones@redhat.com>
 <CAFEAcA9bwbev3efZ=LJPGgObBCbW-WX19fySMusLyMNC5ZExvA@mail.gmail.com>
 <20190618115558.uhygiqryxo4lbb5u@kamzik.brq.redhat.com>
In-Reply-To: <20190618115558.uhygiqryxo4lbb5u@kamzik.brq.redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 18 Jun 2019 12:58:30 +0100
Message-ID: <CAFEAcA-66=jnVrdKAkY8EtY7BjoB5EscG1S15ABUd6yQij4YFw@mail.gmail.com>
To: Andrew Jones <drjones@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::341
Subject: Re: [Qemu-devel] [PATCH] hw/arm/boot: fix direct kernel boot setup
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
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 18 Jun 2019 at 12:56, Andrew Jones <drjones@redhat.com> wrote:
>
> On Tue, Jun 18, 2019 at 12:02:37PM +0100, Peter Maydell wrote:
> > On Tue, 18 Jun 2019 at 09:34, Andrew Jones <drjones@redhat.com> wrote:
> > >
> > > We need to check ram_end, not ram_size.
> > >
> > > Fixes: 852dc64d665f ("hw/arm/boot: Diagnose layouts that put initrd or
> > > DTB off the end of RAM")
> > > Signed-off-by: Andrew Jones <drjones@redhat.com>
> > > ---
> > >  hw/arm/boot.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > diff --git a/hw/arm/boot.c b/hw/arm/boot.c
> > > index b2f93f6beff6..8a280ab3ed49 100644
> > > --- a/hw/arm/boot.c
> > > +++ b/hw/arm/boot.c
> > > @@ -1109,7 +1109,7 @@ static void arm_setup_direct_kernel_boot(ARMCPU *cpu,
> > >                               info->initrd_filename);
> > >                  exit(1);
> > >              }
> > > -            if (info->initrd_start + initrd_size > info->ram_size) {
> > > +            if (info->initrd_start + initrd_size > ram_end) {
> > >                  error_report("could not load initrd '%s': "
> > >                               "too big to fit into RAM after the kernel",
> > >                               info->initrd_filename);
> > > --
> > > 2.20.1
> >
> > Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
> >
> > I think I missed this because my test case doesn't have an
> > initrd -- direct kernel boot works fine if all you're
> > passing to QEMU is the kernel... I think we could clarify
> > the commit message a little:
>
> I found it using kvm-unit-tests which uses a small initrd to
> pass environment variables to the guest. All the tests started
> to report FAIL.
>
> >
> > hw/arm/boot: fix direct kernel boot with initrd
> >
> > Fix the condition used to check whether the initrd fits
> > into RAM; this meant we were spuriously refusing to do
> > a direct boot of a kernel in some cases if an initrd
> > was also passed on the command line.
>
> Actually I think we need another fix for this error too. We
> weren't actually refusing do direct boot the kernel, but we
> should have been. We're missing the 'exit(1)' after the error
> message.

Hmm, so we are. Do you want to send a v2 then, which fixes
that too and fixes up the commit message?

thanks
-- PMM

