Return-Path: <SRS0=IEfc=4J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 053C8C35646
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2020 15:37:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C2751208E4
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2020 15:37:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zA/nBlsb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C2751208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59934 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j5AMT-0007W3-T7
	for qemu-devel@archiver.kernel.org; Fri, 21 Feb 2020 10:37:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37946)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1j5ALf-0006zP-Hc
 for qemu-devel@nongnu.org; Fri, 21 Feb 2020 10:36:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1j5ALe-0000ZS-4P
 for qemu-devel@nongnu.org; Fri, 21 Feb 2020 10:36:15 -0500
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:44012)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1j5ALd-0000YK-W5
 for qemu-devel@nongnu.org; Fri, 21 Feb 2020 10:36:14 -0500
Received: by mail-ot1-x344.google.com with SMTP id p8so2315702oth.10
 for <qemu-devel@nongnu.org>; Fri, 21 Feb 2020 07:36:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=84O7Vd/5wHrqQ9g5s2fwjY42t+M3TZiaa3O3TgLmqxM=;
 b=zA/nBlsbHssjiLRMqPCTeprRwKaFQNmnTPQHG3UI5bQA8US4X24W2OT6KltlHuNyjd
 CDiIJMhvIZfngfYuZAPt3nWTuWt2499nLBQh98w1iHbJ5Hn/5nEZ/rZlZASPMk1zpU2X
 ZH2/CNOLIXMhzis8SC+c8CrhIAyGyD7PnKHTmrmWb3K3kmDrt47qmMsgKLCqno3RmFLE
 yjgwyeiTtQnuQN+UZ/IsqzuZNSJIscmxkS+NbTsNJQuLwEUfjKCWXMfzD3brh33O+B+V
 JBR1H/s8uXUC1BqIu7j1zp7vow67exgBDbBGb2W+wXMHXymZExPgi5mNv5Q4fwf3qahL
 40Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=84O7Vd/5wHrqQ9g5s2fwjY42t+M3TZiaa3O3TgLmqxM=;
 b=eDeJ9mu1MfzImbo8Br4nlWbTL4ZprhRnS9eOkjT/GDzgtnlMWYaeFKN61BUZLuUk8V
 o+SXoovaxggwE0jWI3UBM4JiW9i0Jc836+M/L4GXS5mELRFkPMC3Kr+VxzCIqE87ErAC
 r6p3dfhouWWP2J4C1eToP4tnx+unW8s5E/0ODejRYH60qh8RbC3mUCr2Y/k6ZtIFgrTz
 3xQNSDxhD0VzbNz+vBG95wDFH5wm+BMb2RRW/SPw4aaAb7j+YtMY44IkmwDeyo98d6Sw
 ocMtB1Ww/6pSyppeR8DuCFTgav3bYFvF3vHtJHNe4FdcsEMA7czJf+30Oh5DnBGAo8vR
 aO4Q==
X-Gm-Message-State: APjAAAWGCfrrZlxkYCKnZK/XBvyKLTqq6prjkbPOKKnoJ1FelEU03dqo
 dEM0VsHcrbiL6VHdzOuT+wkd1h6E1gcZfSdTtNM3wA==
X-Google-Smtp-Source: APXvYqxcwddlfxpWqVZ1eap6QBpnZte3HCluI1Xlrb3GUI/m1yzcNmZ1J3U140llT2c/Xhwgx/ldVgde4bVtdYPtZRA=
X-Received: by 2002:a05:6830:13da:: with SMTP id
 e26mr26815902otq.97.1582299372940; 
 Fri, 21 Feb 2020 07:36:12 -0800 (PST)
MIME-Version: 1.0
References: <20200220142001.20774-1-kchamart@redhat.com>
 <20200220142001.20774-2-kchamart@redhat.com>
 <CAFEAcA9_tDWLxBrsw42uxs7E_QmA5XzsMs6zwmzpckv=B0ksuw@mail.gmail.com>
 <20200221153115.GG628613@redhat.com>
In-Reply-To: <20200221153115.GG628613@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 21 Feb 2020 15:36:02 +0000
Message-ID: <CAFEAcA8dTR6xkQnsf32HAo6aDXf5Z0UmkhL3+257KWLj1ES6Sw@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] docs: Convert qemu-cpu-models.texi to rST
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>,
 QEMU Developers <qemu-devel@nongnu.org>, Eduardo Habkost <ehabkost@redhat.com>,
 Kashyap Chamarthy <kchamart@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 21 Feb 2020 at 15:31, Daniel P. Berrang=C3=A9 <berrange@redhat.com>=
 wrote:
>
> On Fri, Feb 21, 2020 at 03:16:29PM +0000, Peter Maydell wrote:
> > On Thu, 20 Feb 2020 at 14:20, Kashyap Chamarthy <kchamart@redhat.com> w=
rote:
> > > diff --git a/docs/system/conf.py b/docs/system/conf.py
> > > index 7ca115f5e0..7cc9da9508 100644
> > > --- a/docs/system/conf.py
> > > +++ b/docs/system/conf.py
> > > @@ -18,5 +18,8 @@ html_theme_options['description'] =3D u'System Emul=
ation User''s Guide'
> > >  man_pages =3D [
> > >      ('qemu-block-drivers', 'qemu-block-drivers',
> > >       u'QEMU block drivers reference',
> > > +     ['Fabrice Bellard and the QEMU Project developers'], 7),
> > > +    ('qemu-cpu-models', 'qemu-cpu-models',
> > > +     u'QEMU CPU Models',
> > >       ['Fabrice Bellard and the QEMU Project developers'], 7)
> > >  ]
> >
> > The old manpage/documentation credits Dan as the author,
> > so that's what we should specify in the conf.py line,
> > rather than 'Fabrice and the project devs' (which we
> > use for qemu-block-drivers.7 because that's what the
> > old texi version of that file specified as the authors).
>
> I agree that listing Fabrice explicitly here is wrong
> since he didn't write any of it.
>
> As the author, I don't feel a need for my name to be
> explicitly credited here. QEMU is a collaborative project
> and other people add text to this over time. Indeed IME
> explicitly listing an individual  encourages users to
> directly email the individual person with questions,
> instead of using the mailing list / irc / forums.
>
> Thus I would personally prefer if we just used
>
>   "The QEMU Project maintainers"
>
> as the author credit

Sure, if you want to update the author credit (which you
originally picked in commit 2544e9e4aa2bcef :-)) we can
do that, though our standard phrasing (see
the QEMU_COPYRIGHT #define in qemu-common.h) is
"The QEMU Project developers" so I'd rather we stuck
with that than "maintainers".

Mostly I want to avoid our rST conversion accidentally
dropping or changing existing authorship/attribution
information, so maybe we should change the authorship
in a follow-on patch.

thanks
-- PMM

