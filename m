Return-Path: <SRS0=7VQp=V2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CE4FC433FF
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jul 2019 15:50:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3C1982067D
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jul 2019 15:50:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OjNSns+s"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C1982067D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54488 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hs7uW-0003aC-Ie
	for qemu-devel@archiver.kernel.org; Mon, 29 Jul 2019 11:50:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50510)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <peter.maydell@linaro.org>) id 1hs7qo-0005iI-IP
 for qemu-devel@nongnu.org; Mon, 29 Jul 2019 11:46:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1hs7qn-0004bt-J7
 for qemu-devel@nongnu.org; Mon, 29 Jul 2019 11:46:14 -0400
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:37415)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1hs7qn-0004Yl-99
 for qemu-devel@nongnu.org; Mon, 29 Jul 2019 11:46:13 -0400
Received: by mail-ot1-x344.google.com with SMTP id s20so63011608otp.4
 for <qemu-devel@nongnu.org>; Mon, 29 Jul 2019 08:46:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=Xm9aTF7cXi37N0w1qhsI3m6ubZzHFFqrl2Qg0Wpv74Q=;
 b=OjNSns+sH/FhVIZw5WO9guhcLjr1SkKrpVrvzBumHTAohJgjPQDirQbkTd6W6R43oX
 S0JLltnvTgiHuKuqqGx/TQrnJu0cJpwwfNuwG2qal1akyjE1HioPDqyeql1ZRpCEbHLg
 c2GIKGcn3TYIerQxceEoycqyVRZyVhfqcKE1NCy9B1kwWHJTp3hxw87sPz3LSoyNVsCl
 2o0Gg8VySDfejTii7ZKKcTu5IjxZL6Xq+udk3Vma2AZjFHDu3DGuOpXJRHnullhwRRrH
 E3bpywuz7ITdusZa986JO2EUJ8t8LqWxKtnpkNLUETMngcDgegoyqzvaXzBRKp5vsVEq
 NLHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Xm9aTF7cXi37N0w1qhsI3m6ubZzHFFqrl2Qg0Wpv74Q=;
 b=dBS3Fc6Dkfdm6a/qXpmVtSHIP2HuaUQFyZ4yFBNwxSgHgYZ4kFrKnkkbB6jIw3iMx3
 D/qOYOwEYEhMK24cldlIHN001xRh1vYXhxIzVfBAcH+10pQyCHlQbg/vZFMKmYH83BXl
 S5URMY8+T7NOviVynEXCb83BwqX9JJWSg3/4XU3lNGLH6JYkEgD294THd8SyOzuJVX2u
 qLWEGD8Z5Ps1pOafh/wajf/fRuY1t13QcqGMGLmLbiCFCyd9+NDYz0Xlsgup22Itsn1j
 Smju/qB2jBpHZTyOepn2at5UiYjoyX976cNlwi65RXFtulPe2rmILYSsswHUWPF+Y0yi
 Shdw==
X-Gm-Message-State: APjAAAUq3gV5g2qrGKes+p00OCVyY3E+SAbmoqmE4DNe9HpjQmyRJQzg
 Ag8OOWOgb9i3aVRdyXC5wFc4M2ecpeoRjIZCSQJL/w==
X-Google-Smtp-Source: APXvYqzx6eob1h0OAnSz6JGm1SCMDRffLciD8gJ6Y4NjTkzztdDf4sBg56NqMVO4gfTUAf1qKdPKeRYMiB6NGEAVXqI=
X-Received: by 2002:a9d:711e:: with SMTP id n30mr76904740otj.97.1564415172145; 
 Mon, 29 Jul 2019 08:46:12 -0700 (PDT)
MIME-Version: 1.0
References: <20190716155808.25010-1-paul.c.lai@intel.com>
 <1a33ae335f396d49689425e0137213efd9f28a7c.camel@suse.com>
In-Reply-To: <1a33ae335f396d49689425e0137213efd9f28a7c.camel@suse.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 29 Jul 2019 16:46:01 +0100
Message-ID: <CAFEAcA9Rmw6L7O9=r_H3fv=1kFdthC+s0W5q=6UCkrPF-oWcZA@mail.gmail.com>
To: Bruce Rogers <BROGERS@suse.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::344
Subject: Re: [Qemu-devel] Fixing Snowridge CPU model name and features
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
Cc: "luwei.kang@intel.com" <luwei.kang@intel.com>,
 "ehabkost@redhat.com" <ehabkost@redhat.com>,
 "paul.c.lai@intel.com" <paul.c.lai@intel.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "wei.w.wang@intel.com" <wei.w.wang@intel.com>,
 Paolo Bonzini <pbonzini@redhat.com>, "tao3.xu@intel.com" <tao3.xu@intel.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 29 Jul 2019 at 16:42, Bruce Rogers <BROGERS@suse.com> wrote:
>
> On Tue, 2019-07-16 at 08:58 -0700, Paul Lai wrote:
> > Changing the name to Snowridge from SnowRidge-Server.
> > There is no client model of Snowridge, so "-Server" is unnecessary.
> >
> > Removing CPUID_EXT_VMX from Snowridge cpu feature list.
> >
> > Signed-off-by: Paul Lai <paul.c.lai@intel.com>
> > Tested-by: Tao3 Xu <tao3.xu@intel.com>
> > ---
> >  target/i386/cpu.c | 3 +--
> >  1 file changed, 1 insertion(+), 2 deletions(-)
> >
> > diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> > index 63d89276fe..7f56e887ae 100644
> > --- a/target/i386/cpu.c
> > +++ b/target/i386/cpu.c
> > @@ -2688,7 +2688,7 @@ static X86CPUDefinition builtin_x86_defs[] = {
> >          .model_id = "Intel Xeon Processor (Icelake)",
> >      },
> >      {
> > -        .name = "SnowRidge-Server",
> > +        .name = "Snowridge",
> >          .level = 27,
> >          .vendor = CPUID_VENDOR_INTEL,
> >          .family = 6,
> > @@ -2706,7 +2706,6 @@ static X86CPUDefinition builtin_x86_defs[] = {
> >              CPUID_FXSR | CPUID_SSE | CPUID_SSE2,
> >          .features[FEAT_1_ECX] =
> >              CPUID_EXT_SSE3 | CPUID_EXT_PCLMULQDQ | CPUID_EXT_MONITOR
> > |
> > -            CPUID_EXT_VMX |
> >              CPUID_EXT_SSSE3 |
> >              CPUID_EXT_CX16 |
> >              CPUID_EXT_SSE41 |
>
> What is the status of this patch with respect to the v4.1.0 release?
> It would seem to me that it was targeted for this release, to get the
> name and features right before codified in a released version, but
> Intel would know better.

If nobody picks it up this afternoon then it has (probably) missed the boat.
Not ccing any of the target/i386 maintainers or putting "for-4.1"
in the subject line is probably why it got missed. Eduardo/Paolo/Richard ?

thanks
-- PMM

