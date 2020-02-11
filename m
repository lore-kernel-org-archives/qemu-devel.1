Return-Path: <SRS0=pnX7=37=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE379C352A3
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Feb 2020 17:18:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C051E20578
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Feb 2020 17:18:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="z2cRtnzZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C051E20578
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53756 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j1ZAe-0004OO-UE
	for qemu-devel@archiver.kernel.org; Tue, 11 Feb 2020 12:18:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39788)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1j1Z9x-0003qn-Nz
 for qemu-devel@nongnu.org; Tue, 11 Feb 2020 12:17:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1j1Z9v-00038E-EF
 for qemu-devel@nongnu.org; Tue, 11 Feb 2020 12:17:17 -0500
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:39876)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1j1Z9v-00036V-8J
 for qemu-devel@nongnu.org; Tue, 11 Feb 2020 12:17:15 -0500
Received: by mail-ot1-x344.google.com with SMTP id 77so10851638oty.6
 for <qemu-devel@nongnu.org>; Tue, 11 Feb 2020 09:17:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=ABoApGT1NRSFCZN/x9oAOMNsrTf1SfkAjLxXqqSz1hc=;
 b=z2cRtnzZHPEuifzx9exiKlw1cCY4EoCzlz5P7BGMr7i7GJlpAFdCCIfjIGXx9IlTi8
 wIK4DAgFQderwNzS0ALGNo5w1NQA9LA1fwgm/K6s5XeaOsY4iVGFll3oTpgUtlq7Ee3V
 s86wJIBFwuadBHFU9NNpEDsEwwGSCkU6AzP1ERN86mH2UEgQrU3leGZ8rN5jgQvSULPs
 OjrIk1rvaOR/Hi6N/oCyEu9RkGItbmkIbVe6WNEL/C6N8g7IjU6ioIfgvGbmeg+mG6zb
 gQneBsbl0pwsDe7x1xaiVRUxQMlWxbEN0Kn1Af0rr7jxYn+tA2aH5rntr6zl/tgpwYoY
 tZuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=ABoApGT1NRSFCZN/x9oAOMNsrTf1SfkAjLxXqqSz1hc=;
 b=R+HdgX8QlFxN6HSn1OMCJnWG+LzQzx72xscZ4LYIcPklKE/MWBMBna57riTjiF8JVy
 /jRPpfRgT4q2QuTctXn8cwgvDVDgdmVdNCV0IKMcd2KFqQmNi8OEMAFcQdge33S+0tv6
 NPkttH9xg/iVlqFZX1Dc+Gfj5KZlxLIPaQksLaDZWxcszSbuFmeoAAxX36+5UPCDj/rq
 ywQQ0MyU2C3BFj1x3K9cKc6uJlMWb+hbI9fcXwqjEphvoxhY2a2Xp3qv5ACWwr6AFWsy
 QUDNLumfm6lvOwE4z7yXe1r5d3fCUNjNQg61QMOp+551nkA7uAaTSyS4ifXQpc4wkP01
 5M7Q==
X-Gm-Message-State: APjAAAVEDVPPIaPbbGQ30r4GEm8P1vmaM2PsHQvuWDBDG46U1REQBmN5
 mlFzlr3uld3dRQiOydwu0gmhm843p6LlmkeUN30Dxw==
X-Google-Smtp-Source: APXvYqxjOaFBNcmjESzVP0b6n42HsF9OJ+Iy6fb9CkSUow6RwRZUgCfeVtCrDK7pQXsWHUF1Hjo5B0OmXT+3qbj4RKo=
X-Received: by 2002:a05:6830:13d3:: with SMTP id
 e19mr6068172otq.135.1581441433612; 
 Tue, 11 Feb 2020 09:17:13 -0800 (PST)
MIME-Version: 1.0
References: <20200204171053.1718013-1-laurent@vivier.eu>
 <20200204171053.1718013-4-laurent@vivier.eu>
 <CAFEAcA_BVPRXkhVoq7=r6QsQ+upkg1YbiXEHmoR9R824QcjZ0Q@mail.gmail.com>
 <8cbf7281-d613-d7fe-9651-20408d54caa9@vivier.eu>
In-Reply-To: <8cbf7281-d613-d7fe-9651-20408d54caa9@vivier.eu>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 11 Feb 2020 17:17:03 +0000
Message-ID: <CAFEAcA_J0zjabnhj0oe20RXNHwjBq3=88D2GMh_p_+F4rpya-w@mail.gmail.com>
Subject: Re: [PATCH v2 3/4] linux-user: fix TARGET_NSIG and _NSIG uses
To: Laurent Vivier <laurent@vivier.eu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::344
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
Cc: Marlies Ruck <marlies.ruck@gmail.com>, Riku Voipio <riku.voipio@iki.fi>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Aleksandar Markovic <aleksandar.markovic@rt-rk.com>,
 Josh Kunz <jkz@google.com>, Taylor Simpson <tsimpson@quicinc.com>,
 Matus Kysel <mkysel@tachyum.com>,
 =?UTF-8?B?TWlsb8WhIFN0b2phbm92acSH?= <milos.stojanovic@rt-rk.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 11 Feb 2020 at 16:59, Laurent Vivier <laurent@vivier.eu> wrote:
>
> Le 11/02/2020 =C3=A0 17:47, Peter Maydell a =C3=A9crit :
> > On Tue, 4 Feb 2020 at 17:11, Laurent Vivier <laurent@vivier.eu> wrote:
> >>
> >> Valid signal numbers are between 1 (SIGHUP) and SIGRTMAX.
> >>
> >> System includes define _NSIG to SIGRTMAX + 1, but
> >> QEMU (like kernel) defines TARGET_NSIG to TARGET_SIGRTMAX.
> >>
> >> Fix all the checks involving the signal range.
> >>
> >> Signed-off-by: Laurent Vivier <laurent@vivier.eu>
> >> ---
> >>
> >> Notes:
> >>     v2: replace i, j by target_sig, host_sig
> >>
> >>  linux-user/signal.c | 52 ++++++++++++++++++++++++++++++++------------=
-
> >>  1 file changed, 37 insertions(+), 15 deletions(-)
> >>
> >> diff --git a/linux-user/signal.c b/linux-user/signal.c
> >> index 246315571c09..c1e664f97a7c 100644
> >> --- a/linux-user/signal.c
> >> +++ b/linux-user/signal.c
> >> @@ -30,6 +30,15 @@ static struct target_sigaction sigact_table[TARGET_=
NSIG];
> >
> > Optional follow-on patch: make sigact_table[] also size
> > TARGET_NSIG + 1, for consistency with target_to_host_signal_table[],
> > and remove all the "- 1"s when we index into it.
> >
>
> OK,
>
> >> @@ -492,10 +514,10 @@ static void signal_table_init(void)
> >>          if (host_to_target_signal_table[host_sig] =3D=3D 0) {
> >>              host_to_target_signal_table[host_sig] =3D host_sig;
> >>          }
> >> -    }
> >> -    for (host_sig =3D 1; host_sig < _NSIG; host_sig++) {
> >>          target_sig =3D host_to_target_signal_table[host_sig];
> >> -        target_to_host_signal_table[target_sig] =3D host_sig;
> >> +        if (target_sig <=3D TARGET_NSIG) {
> >> +            target_to_host_signal_table[target_sig] =3D host_sig;
> >> +        }
> >
> > Why does this hunk apparently delete the for() line ?
>
> It effectively deletes the for() line because I merge the two "for
> (host_sig =3D 1; host_sig < _NSIG; host_sig++)" loops into one.

Oh, I see, I missed the closing brace being deleted.

> > Why do we need the if() -- surely there should never be any
> > entries in host_to_target_signal_table[] that aren't
> > valid target signal numbers ?
> >
>
> we have above the "host_to_target_signal_table[host_sig] =3D host_sig;"
> and host_sig can be greater than TARGET_NSIG.
>
> Setting like this allows to ignore them later in the target as we can
> compare them to TARGET_NSIG. This mapping 1:1 in the default case is the
> original behaviour.

I guess so (I was sort of expecting us to do the filter on
"is this valid" when we filled the array, rather than having
to do it every time we used the entries, but this works).

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

