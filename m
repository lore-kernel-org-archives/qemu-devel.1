Return-Path: <SRS0=PWhW=VO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6388DC76186
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jul 2019 13:46:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2FD0A208C0
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jul 2019 13:46:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YaikLNKl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2FD0A208C0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57348 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hnkGF-0007ca-99
	for qemu-devel@archiver.kernel.org; Wed, 17 Jul 2019 09:46:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56378)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <peter.maydell@linaro.org>) id 1hnkFS-0004cg-HH
 for qemu-devel@nongnu.org; Wed, 17 Jul 2019 09:45:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1hnkFR-0005oO-DM
 for qemu-devel@nongnu.org; Wed, 17 Jul 2019 09:45:34 -0400
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:41694)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1hnkFR-0005nW-7Q
 for qemu-devel@nongnu.org; Wed, 17 Jul 2019 09:45:33 -0400
Received: by mail-ot1-x343.google.com with SMTP id o101so25047882ota.8
 for <qemu-devel@nongnu.org>; Wed, 17 Jul 2019 06:45:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=mIA2vzeTnkhB/e6CFWSokCe2bOE/PdJL1LQ+Nea8kUw=;
 b=YaikLNKlB2QRqk2lZDYn+RfZnIq24M/ar0s2oJ5fK+eShtgMbJYYnL1NKjsHNLQWnM
 5P2YXnI4utTNGITJzbda3slZZ20+mD+ogKV1Zx21P2MBba2v/1NnZ4oOvEo6Gq2M0eiN
 FbDKlpmU2Rw6qTXDMp9ACwUaanN7tKaiyEpuTdOg9hvZ24ZV21iJnasuOacRfIp2ZT2s
 dwUs7XZWOHqajUSmO/Ai+QBcdjkvURpuv9CuF47ZBd5xwEmOrH6nwPaA9+0dt1q7vMLk
 zCRkTQkY/+bbjopkSIFCSHDe3yEUDCMKq59MkIbQGVsOrYyhlGlZ7cpY95YueytwDXM/
 AkHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=mIA2vzeTnkhB/e6CFWSokCe2bOE/PdJL1LQ+Nea8kUw=;
 b=nuX65UxDAsw4iDi2hrYDbu9ZFSg2x2akIlYnGO5qMzileGCsHD97NtJ9AZkrMpFKP0
 O0yKZXUdwEjI5EhL9wNCjsZaD/cldA/3YPNFO/M4k163hl1ixpZJdszyUUzPvNwAVrN5
 QN4gM3PobfF8PcyooVcHHaEDzNAevbDN7HoX74+/AAHE9pJ4CjuODJP5gfj9nfyPQxmM
 9NuWAdVLCRhzSIWR11QywFjnVLNgHpd+C3OfocDAPAeHgIv0SDFI4+i78bmJn0mc/Rp3
 RpgCYQcoHJto368xbBYOrvUcKY16G2/fC35IPw/z/A8tcGs6zATH9u9r+LM5HCZ8jNGU
 QZVw==
X-Gm-Message-State: APjAAAXNhr/5Q7nDDw+UA6F/wNM/9p1odEB6nRpT80u3xjbFvNGKNT1l
 wxzSii+wd5QFfMQ++rXdTmhWChHV/5g8YQ70IpIHvg==
X-Google-Smtp-Source: APXvYqw5FciZAmox7fxjmuV9DsZ6PKusErI+L5jnzvV7vdB2fXAeFiq6vnFGf1T4Pe5lk0Ji+QYVpQPXO1QzSr1SXWc=
X-Received: by 2002:a9d:5f1a:: with SMTP id f26mr8339991oti.91.1563371131388; 
 Wed, 17 Jul 2019 06:45:31 -0700 (PDT)
MIME-Version: 1.0
References: <20181102171638.24069-1-peter.maydell@linaro.org>
 <20181102171638.24069-9-peter.maydell@linaro.org>
 <3e3d2018-3993-f651-8e94-5bea612bd776@redhat.com>
 <CAFEAcA_FtoHOUv_cPgfO7GrZ8Ug9cKCvmY2z75i9DaAQ8Qx+gQ@mail.gmail.com>
 <417cd887-aec4-d8ba-1dd2-810bc4c04977@redhat.com>
 <CAFEAcA_JntiaOOWisqLVqAV6jc=wk4nR548KbbUcG0XLabcNpA@mail.gmail.com>
 <8d06b8f2-7ee8-a77a-81d7-3219d5e43c45@redhat.com>
 <dfeab9fd-7ee1-01f2-dd38-cba449b1de63@redhat.com>
 <f625f1f1-ad97-1c75-e44d-3b0c015312b3@redhat.com>
 <cf9156f6-c3fa-ec7e-c51a-8b8d2fd1e6d6@redhat.com>
In-Reply-To: <cf9156f6-c3fa-ec7e-c51a-8b8d2fd1e6d6@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 17 Jul 2019 14:45:19 +0100
Message-ID: <CAFEAcA_SAvEi7wGPp-MUf3qoXK17MwO4NjRYUtKXKZikCH6crg@mail.gmail.com>
To: Laszlo Ersek <lersek@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::343
Subject: Re: [Qemu-devel] [PULL 08/10] target/arm: Conditionalize some
 asserts on aarch32 support
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
Cc: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 17 Jul 2019 at 10:22, Laszlo Ersek <lersek@redhat.com> wrote:
> Hmmm wait a second. The ARMv8 ARM says, about ID_ISAR0_EL1:
>
> > Divide, bits [27:24]
> >
> >     Indicates the implemented Divide instructions. Permitted values
> >     are:
> >     0000 None implemented.
> >     0001 Adds SDIV and UDIV in the T32 instruction set.
> >     0010 As for 0b0001, and adds SDIV and UDIV in the A32 instruction
> >          set.
> >     All other values are reserved.
>
> So this means that (aa32 && !arm_div) *does* conform to the architecture
> manual!

The architecture manual also says
"In ARMv8-A the only permitted value is 0010.", and in
earlier versions of the manual it says also that ARMv7VE
implies that we must have all the integer divide instructions.
And this assert is guarded by "if (arm_feature(env, ARM_FEATURE_V7VE))".
(This is what we're trying to test, really: something that's
providing AArch32 v7VE-or-better must include the divide insns.)

> Upon re-reading the commit message more carefully:
>
>     on a host that doesn't support aarch32 mode at all, neither arm_div
>     nor jazelle will be supported either

The point of this text is that "v8 AArch64 with no AArch32" is
an exception to the previous version of the check, which was
just "v7VE must mean we have the divide insns".

Similarly with Jazelle: what we were testing before commit 0f8d06f
was "v6 must imply Jazelle", which is true for everything except
the special case of "an AArch64 CPU with no AArch32 support" (which
can only happen for a KVM setup), and the test we are trying to
check after the commit is "v6 aarch32 must imply Jazelle".

> > diff --git a/target/arm/cpu.c b/target/arm/cpu.c
> > index e75a64a25a4b..ea84a3e11abb 100644
> > --- a/target/arm/cpu.c
> > +++ b/target/arm/cpu.c
> > @@ -1382,8 +1382,13 @@ static void arm_cpu_realizefn(DeviceState *dev, Error **errp)
> >           * include the various other features that V7VE implies.
> >           * Presence of EL2 itself is ARM_FEATURE_EL2, and of the
> >           * Security Extensions is ARM_FEATURE_EL3.
> > +         *
> > +         * Lack of aa32 support excludes arm_div support:
> > +         *   no_aa32 --> !arm_div
> > +         * Using the logical OR operator, the same is expressed as:
> > +         *   !no_aa32 || !arm_div
> >           */
> > -        assert(no_aa32 || cpu_isar_feature(arm_div, cpu));
> > +        assert(!no_aa32 || !cpu_isar_feature(arm_div, cpu));

This now fails to test what we wanted, because it will allow
an incorrect set of ID registers that define a v7VE CPU
without the arm_div feature to pass.

thanks
-- PMM

