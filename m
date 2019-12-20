Return-Path: <SRS0=uEni=2K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2E3DC43603
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2019 14:23:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ACFAC206A5
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2019 14:23:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="C2WsHvtX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ACFAC206A5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56896 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iiJBp-0000Qq-Jg
	for qemu-devel@archiver.kernel.org; Fri, 20 Dec 2019 09:23:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58762)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iiIow-0007fP-Tq
 for qemu-devel@nongnu.org; Fri, 20 Dec 2019 09:00:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iiIov-0001l2-Kl
 for qemu-devel@nongnu.org; Fri, 20 Dec 2019 08:59:58 -0500
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:33822)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iiIou-0001fN-W4
 for qemu-devel@nongnu.org; Fri, 20 Dec 2019 08:59:57 -0500
Received: by mail-ot1-x341.google.com with SMTP id a15so12008858otf.1
 for <qemu-devel@nongnu.org>; Fri, 20 Dec 2019 05:59:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=ELpgbcB63eyC8D0t7Z4Fvx7gbMm7zBoq3zJjp0z7mJs=;
 b=C2WsHvtXy749gvkXphiJQTFHdm/9pOO9gjYmzXfaMLqdg68HFmS3occ6TK1MSzXdyb
 uUmtq1l2Po1yfQpIgwdvSzEpC1uFhJAh+kyjBMD+mNCVzYn6dXscMcqBrGEh3zzEnZsO
 8JyRWZtXbDIB5QdXXP2eFjy4UT5TlMOPrJZUCExUXpdPXMejY+y9M+Xwr0Vvkd4AxszA
 z28XwAmP270e3O4nXANpuVyISK8HH/ZfARLCWsT8YvVejQkspcLyKx/t/uPMDb6bULvj
 P6l0OlDwUPI+f/VomsNt6imSbigMkNHTUseeuFb0hbKpa91s00rtXGiGZOTJcW9tAMTr
 jATw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=ELpgbcB63eyC8D0t7Z4Fvx7gbMm7zBoq3zJjp0z7mJs=;
 b=O2MI0MciVvvCYPpv2/MX+7GFURzwDFBs8nPIDvyJuTUgq3rXA8xxazNQ4Xp7Qo+Uub
 j3gk7WnAh+psJWiHWFWo70PeAbblrqtpYrJl8leYxGEzdTcQoH7um9ytrpsZJAL9LIZb
 Xp7mXncoZ6UmDJbDV9YYGiAJF9pfZrya35kK3ESYcs1KjhXqhg7nnavEINAXVfKhsEx1
 Pfplou7wUl56zUm2yPwpG00wnNFtuVAUnkQ7KxgA3sFcCjXNJl3cNHsbuihV9slfovIJ
 a/p2cXZWuGHqf+qtuC3Zj7C2H49YXaHQiugSMcdB1uwNSTeKcFFac/p75+WgLVDR3Y8v
 QQDA==
X-Gm-Message-State: APjAAAUB2F/Vze583Ok8IIMB55xhzC/IC7HyXWPx8ABAnAIIHM5oygeA
 Re3NvejNKfihU8Qn5VajPQZkqPZWgr0A8j6IgM1dog==
X-Google-Smtp-Source: APXvYqx7n0BA5B96/Ii01kjGjFm+xgRen7pmR5PfmX7v1txRP32lWTBvNQpd//WBSZzfX7adDf5Ee80hbYzlEgEMyeU=
X-Received: by 2002:a9d:8cb:: with SMTP id 69mr1308538otf.221.1576850395953;
 Fri, 20 Dec 2019 05:59:55 -0800 (PST)
MIME-Version: 1.0
References: <20191217210230.99559-1-jeff.kubascik@dornerworks.com>
 <7a274247-e593-5828-73f8-2042971e8633@linaro.org>
 <CAFEAcA8Egy=Jkw8yKSumkeX=+Qxi8bPy-0fJjopHR6gCmz3FLQ@mail.gmail.com>
 <e8daa5c4-ba9a-a6dc-1037-7eec6335ad0b@dornerworks.com>
In-Reply-To: <e8daa5c4-ba9a-a6dc-1037-7eec6335ad0b@dornerworks.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 20 Dec 2019 13:59:45 +0000
Message-ID: <CAFEAcA8Dxwsx4dUuq4YjD9zYCJEW5gsYc=99nH=YgZTF4Ay2aw@mail.gmail.com>
Subject: Re: [PATCH] target/arm: fix IL bit for data abort exceptions
To: Jeff Kubascik <jeff.kubascik@dornerworks.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::341
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
Cc: Stewart Hildebrand <Stewart.Hildebrand@dornerworks.com>,
 qemu-arm <qemu-arm@nongnu.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Jarvis Roach <Jarvis.Roach@dornerworks.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 20 Dec 2019 at 13:53, Jeff Kubascik
<jeff.kubascik@dornerworks.com> wrote:
>
> On 12/19/2019 7:43 AM, Peter Maydell wrote:
> > On Wed, 18 Dec 2019 at 01:03, Richard Henderson
> > <richard.henderson@linaro.org> wrote:
> >>
> >> On 12/17/19 11:02 AM, Jeff Kubascik wrote:
> >>> diff --git a/target/arm/tlb_helper.c b/target/arm/tlb_helper.c
> >>> index 5feb312941..e63f8bda29 100644
> >>> --- a/target/arm/tlb_helper.c
> >>> +++ b/target/arm/tlb_helper.c
> >>> @@ -44,7 +44,7 @@ static inline uint32_t merge_syn_data_abort(uint32_t template_syn,
> >>>          syn = syn_data_abort_with_iss(same_el,
> >>>                                        0, 0, 0, 0, 0,
> >>>                                        ea, 0, s1ptw, is_write, fsc,
> >>> -                                      false);
> >>> +                                      true);
> >>>          /* Merge the runtime syndrome with the template syndrome.  */
> >>>          syn |= template_syn;
> >>
> >> This doesn't look correct.  Surely the IL bit should come from template_syn?
> >
> > Yes. In translate.c we put it into the syndrome information by
> > passing true/false to syn_data_abort_with_iss() depending on
> > whether the issinfo passed in to disas_set_da_iss() has the
> > ISSIs16Bit flag set.
> >
> > I think this is a regression introduced in commit 46beb58efbb8a2a32
> > when we converted the Thumb decoder over to decodetree. Before that
> > 16 bit Thumb insns were in a different place in the old decoder and
> > the 16-bit Thumb path passed ISSIs16Bit in with its issflags.
> > (We should cc: qemu-stable@nongnu.org on the fix for this.)
>
> The problem here was syn_data_abort_with_iss would return syn with the IL bit
> set, which carries through when it gets or'd with template_syn. I had to change
> the is_16bit argument to true so that it clear the IL bit.

Interesting. I think that's an entirely separate (and long
standing) bug to the regression where we forgot to fill in ISSIs16Bit
in the issinfo field, and it masks the other bug...

thanks
-- PMM

