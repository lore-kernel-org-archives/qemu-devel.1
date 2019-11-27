Return-Path: <SRS0=bFmd=ZT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06F64C432C0
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Nov 2019 19:43:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C20D4205ED
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Nov 2019 19:43:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FkqXgJj7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C20D4205ED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42614 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ia3E0-0003hj-C0
	for qemu-devel@archiver.kernel.org; Wed, 27 Nov 2019 14:43:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:48645)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1ia3BO-0002Gp-Gi
 for qemu-devel@nongnu.org; Wed, 27 Nov 2019 14:41:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1ia3BN-0000yE-6q
 for qemu-devel@nongnu.org; Wed, 27 Nov 2019 14:41:02 -0500
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:44390)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <aleksandar.m.mail@gmail.com>)
 id 1ia3BN-0000vA-10
 for qemu-devel@nongnu.org; Wed, 27 Nov 2019 14:41:01 -0500
Received: by mail-ot1-x343.google.com with SMTP id c19so20139646otr.11
 for <qemu-devel@nongnu.org>; Wed, 27 Nov 2019 11:41:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=YNXZuFyoXubAt/z0XAK5RjRYWin+36Yc5tq7AucNX6E=;
 b=FkqXgJj78zx724G/4g26fiZ17i0j7BTx/XpYx+DWEBBdclr8WzboCckTmkDg0XkaoZ
 mRHPwCqkdc6HygUykNE1UL7d18Cph/UnrOIsa44+nF7YXFTpQMM5GNXtdbyhhtkCGk5Y
 CJaeOTVbjW6DwhfJunTFjLUks74mpmEfahF+WZuTQPMEh9cABDwZTdGdWObKuppQPn4K
 Q9lG4D2kj/LsbJTBDIYs9wlcwHDbptVpq/s7ddyBelhn+k5Zt5IUAK2FmW3jgNV7sZZP
 ybuH5GkqRq9k9V4B1LIy5rESCKyFxKNs5+DfxYXcP16sIh2HLoLcnag0wm17OZYJ9AAi
 vCtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=YNXZuFyoXubAt/z0XAK5RjRYWin+36Yc5tq7AucNX6E=;
 b=i4kaDzjNKiMGnwW0fCmzqNERJ9bWJSoffODnyrTCxIrhlMMSTN1Vm44EGaGMcw/dde
 GIZkyC2aW5w/M2Aa44eYDb3Ef+nea2e4UixjP5Id+CJMUZPgJiULyKREq8Qa35bC1ZTL
 1ZGI2D2kYuAecLqj2CsqHpep6TyDaAl5pmkBrnH4FcD1Vd6veWE02ZgBv6wyLfD+JyBA
 Q4+Vc85RfEsoLuyLxvPc6V+TL0///lAH/0g/wxVFp3WlifNlXunssmVmiuRvn4KyoWJP
 BvbSrnHcrAk1jakaP1FOFO/FAVmWz1wXMcsD1MgHnCS+mBAT3lcDVjFw5fzZ+ajyycrw
 PwjA==
X-Gm-Message-State: APjAAAX2eYy2ELRy7ohtjAY6zWxrxcIoGRGEDgPsTGDv+CbD0LQJKi2G
 C2weaIcFEJ4exZdqX+MwTnHpySQoc/aEA3rgsqI=
X-Google-Smtp-Source: APXvYqyW2hlfPaTl7LUmPu4q/aiLBQ0gr2wgyX4seyw8fixCj67IDHWkg0nuUZen8FDrJ9XU3QHzqDEWN8aEeFom/CI=
X-Received: by 2002:a9d:1b3:: with SMTP id e48mr5052723ote.341.1574883659381; 
 Wed, 27 Nov 2019 11:40:59 -0800 (PST)
MIME-Version: 1.0
References: <20191125104103.28962-1-philmd@redhat.com>
 <CAL1e-=hktyuAzESyZMz3P4a9aq17dsrrzWpyXYfFYn=cWP3e4A@mail.gmail.com>
 <20191125154021.GI4157473@redhat.com>
In-Reply-To: <20191125154021.GI4157473@redhat.com>
From: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Date: Wed, 27 Nov 2019 20:40:48 +0100
Message-ID: <CAL1e-=h8b5FZ2tGXB62skK8Ub8diKCjL++Ss6EGQnoQ5TkOmnw@mail.gmail.com>
Subject: Re: [libvirt] [PATCH-for-4.2] hw/mips: Deprecate the r4k machine
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::343
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
Cc: Thomas Huth <thuth@redhat.com>,
 "libvir-list@redhat.com" <libvir-list@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 =?UTF-8?Q?Herv=C3=A9_Poussineau?= <hpoussin@reactos.org>,
 Aleksandar Markovic <amarkovic@wavecomp.com>,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Nov 25, 2019 at 4:40 PM Daniel P. Berrang=C3=A9 <berrange@redhat.co=
m> wrote:
>
> On Mon, Nov 25, 2019 at 03:45:35PM +0100, Aleksandar Markovic wrote:
> > On Monday, November 25, 2019, Philippe Mathieu-Daud=C3=A9 <philmd@redha=
t.com>
> > wrote:
> >
> > > The r4k machine was introduced in 2005 (6af0bf9c7) and its last
> > > logical change was in 2005 (9542611a6). After we can count 164
> > > maintenance commits (QEMU API changes) with the exception of
> > > 1 fix in 2015 (memory leak, commit 3ad9fd5a).
> > >
> > >
> > Please don't start any deprecation process. This requires certain
> > consultation within my company. Rest assured that everyone's opinion wi=
ll
> > be taken into account while doing consiltation.
>
> The idea of having a deprecation process is precisely to
> allow time for people like to provide feedback before any
> deletion takes place. So this is not a reason to delay
> starting of deprecation.
>

What you said is fine, Daniel, I understand the idea, and it should be
that way. But I didn't ask for some lengthy negotiation, or waiting
for someone for months, but I just wanted to check within company if
all relevant people (that do not read QEMU devel list very often)
agree - since we, naturally, do various in-house setups with QEMU for
MIPS, that's all. This could count as the discussion on the patch, not
as a part of that loooooong "deprecated" state...

All is well,
Aleksandar


> The process lasts for 2 releases before we delete anything:
>
>   https://qemu.weilnetz.de/doc/qemu-doc.html#Deprecated-features
>
> When we start the clock now, it is deprecated when 5.0 releases
> in April 2020, and still deprecated with 5.1 in August 2020.
>
> The code won't be deleted until Sep 2020 when 5.2 dev cycle opens,
> and there's still time to undelete it right up until the 5.2 feature
> freeze in late Oct 2020. That's 11 months away, which is plenty of
> time for feedback IMHO.
>
> Regards,
> Daniel
> --
> |: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
> |: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
> |: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
>

