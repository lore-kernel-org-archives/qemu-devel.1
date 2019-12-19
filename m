Return-Path: <SRS0=p/0J=2J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1254C2D0C1
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2019 13:16:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7EA1C218AC
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2019 13:16:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hqZnlI1W"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7EA1C218AC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41160 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ihves-0001PK-N4
	for qemu-devel@archiver.kernel.org; Thu, 19 Dec 2019 08:16:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56241)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1ihv9t-0000Xj-Mv
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 07:44:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1ihv9q-0001FF-2v
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 07:44:01 -0500
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:44527)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1ihv9p-000183-O6
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 07:43:57 -0500
Received: by mail-ot1-x341.google.com with SMTP id h9so4515586otj.11
 for <qemu-devel@nongnu.org>; Thu, 19 Dec 2019 04:43:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=j03bvTj8hmciPAmrh7pM7iJu7uCWP2HD0yo3OK6rh70=;
 b=hqZnlI1WgGL0a2W2GYcjcJNnZG18GLBC5jaC7cOmKTLG0kOkC0ZzPwzoMVHTY5SH5g
 kDwJ5SgOhPMi0rpbmMXiF6X1h3lgPPhCXKjhIbd9i1Nf2pBaIv8nIOM+Zgakzm0CxSik
 12i1X1wmdBzK8ejvKq7ylj4xb3yMzYy8hMOWKCv7GZKIl07+wcc+B87HgMKSfxd7hKqP
 a1G+qEINv8zhZQWDlA2bdaPVn63IEkMOsf4iK0osd25xtUoPllGh6Hx0r2OjkgAwtIDJ
 kHINPG5ucfA+7ySpCqoktCfKDJIzpJqYYI4pHhexWk5vxHmpwTr68iZqo3eqvJyI9KUJ
 AsHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=j03bvTj8hmciPAmrh7pM7iJu7uCWP2HD0yo3OK6rh70=;
 b=rc3VXINPe0OcPqfApp0nfFxBt9EpY0h1pOHhLGJm0LHR5xafLS7JicSQOQZNSQgewW
 Yfyl3FQ9jx6BNyJ+IiegX0W5pvz4roXmju4ZsLZUedU/AxTYMCNPmXhpSQ97f3A/raM8
 RZIT6viAQG6eDIV8Oz1FrSuNw0lOG/tFvWvTAUdkUYJ7kjU924U5Eqz233/1/Ex1hcOx
 slAVBKepohqUHe2AvDMl1EY0Rq1LrjmsvMlK2ssAFcciaefm9MMW4hxnJLx8ai5pv1ik
 k+fZyQiUgho0mY3PO0h89qlYlqjUX+DPdXQaJdF3o5PSxKKpJg2EogBS0aARUxPFOC8A
 dBLA==
X-Gm-Message-State: APjAAAWZT2MvtPv2sUdLp0+rL03Gc/nu74+E4W9qhy2jMFN9fu6N73hC
 IBjhtB4GuKG9KKxTsJhTLOgtzIFb6J1dPIl0r5Sg6w==
X-Google-Smtp-Source: APXvYqylSpwFKqvccJOPnj7nz3IOGQ5pVGvShhbN+8qPpK51wbu6huekTEn3yaSUWGR+WCaSAstdO8PerowrjAD+r88=
X-Received: by 2002:a05:6830:2001:: with SMTP id
 e1mr8197502otp.97.1576759436211; 
 Thu, 19 Dec 2019 04:43:56 -0800 (PST)
MIME-Version: 1.0
References: <20191217210230.99559-1-jeff.kubascik@dornerworks.com>
 <7a274247-e593-5828-73f8-2042971e8633@linaro.org>
In-Reply-To: <7a274247-e593-5828-73f8-2042971e8633@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 19 Dec 2019 12:43:45 +0000
Message-ID: <CAFEAcA8Egy=Jkw8yKSumkeX=+Qxi8bPy-0fJjopHR6gCmz3FLQ@mail.gmail.com>
Subject: Re: [PATCH] target/arm: fix IL bit for data abort exceptions
To: Richard Henderson <richard.henderson@linaro.org>
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
 qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>,
 Jeff Kubascik <jeff.kubascik@dornerworks.com>,
 Jarvis Roach <Jarvis.Roach@dornerworks.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 18 Dec 2019 at 01:03, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> On 12/17/19 11:02 AM, Jeff Kubascik wrote:
> > diff --git a/target/arm/tlb_helper.c b/target/arm/tlb_helper.c
> > index 5feb312941..e63f8bda29 100644
> > --- a/target/arm/tlb_helper.c
> > +++ b/target/arm/tlb_helper.c
> > @@ -44,7 +44,7 @@ static inline uint32_t merge_syn_data_abort(uint32_t template_syn,
> >          syn = syn_data_abort_with_iss(same_el,
> >                                        0, 0, 0, 0, 0,
> >                                        ea, 0, s1ptw, is_write, fsc,
> > -                                      false);
> > +                                      true);
> >          /* Merge the runtime syndrome with the template syndrome.  */
> >          syn |= template_syn;
>
> This doesn't look correct.  Surely the IL bit should come from template_syn?

Yes. In translate.c we put it into the syndrome information by
passing true/false to syn_data_abort_with_iss() depending on
whether the issinfo passed in to disas_set_da_iss() has the
ISSIs16Bit flag set.

I think this is a regression introduced in commit 46beb58efbb8a2a32
when we converted the Thumb decoder over to decodetree. Before that
16 bit Thumb insns were in a different place in the old decoder and
the 16-bit Thumb path passed ISSIs16Bit in with its issflags.
(We should cc: qemu-stable@nongnu.org on the fix for this.)

> > diff --git a/target/arm/translate.c b/target/arm/translate.c
> > index 2b6c1f91bf..300480f1b7 100644
> > --- a/target/arm/translate.c
> > +++ b/target/arm/translate.c
> > @@ -8555,7 +8555,7 @@ static ISSInfo make_issinfo(DisasContext *s, int rd, bool p, bool w)
> >
> >      /* ISS not valid if writeback */
> >      if (p && !w) {
> > -        ret = rd;
> > +        ret = rd | (s->is_16bit ? ISSIs16Bit : 0);
> >      } else {
> >          ret = ISSInvalid;
> >      }

Rather than setting an is_16bit flag, we could just use
"dc->base.pc_next - dc->pc_curr == 2", couldn't we?

thanks
-- PMM

