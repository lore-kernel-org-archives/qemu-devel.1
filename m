Return-Path: <SRS0=a3Gm=5D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B20D3C5ACD6
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Mar 2020 16:17:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7A6E320663
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Mar 2020 16:17:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZcFJJr1d"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A6E320663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53146 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jEbNv-0001U7-6f
	for qemu-devel@archiver.kernel.org; Wed, 18 Mar 2020 12:17:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54585)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aleksandar.qemu.devel@gmail.com>) id 1jEbN5-00012k-GO
 for qemu-devel@nongnu.org; Wed, 18 Mar 2020 12:16:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.qemu.devel@gmail.com>) id 1jEbN4-0002R4-9i
 for qemu-devel@nongnu.org; Wed, 18 Mar 2020 12:16:43 -0400
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430]:41677)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1jEbN4-0002Ov-3e
 for qemu-devel@nongnu.org; Wed, 18 Mar 2020 12:16:42 -0400
Received: by mail-wr1-x430.google.com with SMTP id h9so2378643wrc.8
 for <qemu-devel@nongnu.org>; Wed, 18 Mar 2020 09:16:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=627nj6+X2EZKr8+OB6V3GzC8cGmTOzmSm3FMRsFrWmg=;
 b=ZcFJJr1do9LYHmGFxWMZOKsdpb95EYyhB6StoIRi2KXVAjCaqDN4aaslBtKa2Pj69z
 VWBPmjuIvrgNt2WPrBEnunVZxEK2KLjOO0x9zHIGXMfuHsmNSXSHHBEQtuLYJVRNBvH9
 5uMuGEOREr/d+DYOj/ptuAxXkHNk5dgYbUuDE7oawKA2C7KyopdVbVvkRbzIY5up/c0P
 BBe/CCbQzaGHtSIB/PwIed6955XKy6q27cVxBF1FX701VaDysDFiOMv9B7xJfaB5PNgz
 q7qyfGp3jtiDh41x3fv67DJuz8qIqkw+EEKZI7oSkOErUAzfbHVJQY7+zr6xg5qbdN43
 W0aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=627nj6+X2EZKr8+OB6V3GzC8cGmTOzmSm3FMRsFrWmg=;
 b=Q41pF1X1CrVdJIZV5sTF1lyYkDCPO/308oxc5U6kfkP6kcGzrK3BUdost0JVj+E08v
 fAmcHycuboKy9bnWqiWs3S8ky7Hh4/L+bgn21/UWflUE0uSrealc3mic2tK+RdWX8E5D
 QFMrDA6bH0Wkv+uioTvwAeBXsmZrNhEGFZNoc4eTmGX2Rs6bt3JtU2G2U2s4vEW6Wct4
 jYqxkohX2dyshaKkNgqLfv+t4K0BzDRnmFgWWrdwvsSZfnvy4kzbORX3z3M/SZK/mZ7e
 WcHMyFrO7ez6ghJDYyT13Q8DuWpgRClCHpgeQVe3ktICnORARPT795/85NzxxWrcN1BI
 UB/A==
X-Gm-Message-State: ANhLgQ2hI+RRX1qKlGVvbyXwZaKojdECfTL3vZCyMRFIMuYva+NEXYFG
 ycnKbOXApB6abZ/l4djsFZGG6nNjjIBHIMQEj6Y=
X-Google-Smtp-Source: ADFU+vtDWjsxZ8tiN1viZOZk8UNiQg0nKFlimxOeC/OWpvIcMuUfencqvD/zF1zUaW4QUknxwN+ib/fBJbnhUJUgMgE=
X-Received: by 2002:adf:e9cc:: with SMTP id l12mr6327223wrn.420.1584548199697; 
 Wed, 18 Mar 2020 09:16:39 -0700 (PDT)
MIME-Version: 1.0
References: <158450473711.25478.16951249008771308992@39012742ff91>
 <04961888-5610-6805-c4c0-6f952df99d4f@virtuozzo.com>
 <20200318161223.GL1817047@habkost.net>
In-Reply-To: <20200318161223.GL1817047@habkost.net>
From: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
Date: Wed, 18 Mar 2020 17:16:28 +0100
Message-ID: <CAHiYmc7=T1mO-KnMWFRB-U0PoAhtzMXWivPig-gJoxKFZEbuWw@mail.gmail.com>
Subject: Re: [PULL 0/4] Python queue for 5.0 soft freeze
To: Eduardo Habkost <ehabkost@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::430
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-devel@nongnu.org,
 crosa@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

=D1=81=D1=80=D0=B5, 18. =D0=BC=D0=B0=D1=80 2020. =D1=83 17:13 Eduardo Habko=
st <ehabkost@redhat.com> =D1=98=D0=B5 =D0=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=B0=
=D0=BE/=D0=BB=D0=B0:
>
> On Wed, Mar 18, 2020 at 10:59:22AM +0300, Vladimir Sementsov-Ogievskiy wr=
ote:
> > 18.03.2020 7:12, no-reply@patchew.org wrote:
> > > Patchew URL: https://patchew.org/QEMU/20200318011217.2102748-1-ehabko=
st@redhat.com/
> > >
> > >
> > >
> > > Hi,
> > >
> > > This series seems to have some coding style problems. See output belo=
w for
> > > more information:
> > >
> > > Subject: [PULL 0/4] Python queue for 5.0 soft freeze
> > > Message-id: 20200318011217.2102748-1-ehabkost@redhat.com
> > > Type: series
> > >
> > > =3D=3D=3D TEST SCRIPT BEGIN =3D=3D=3D
> > > #!/bin/bash
> > > git rev-parse base > /dev/null || exit 0
> > > git config --local diff.renamelimit 0
> > > git config --local diff.renames True
> > > git config --local diff.algorithm histogram
> > > ./scripts/checkpatch.pl --mailback base..
> > > =3D=3D=3D TEST SCRIPT END =3D=3D=3D
> > >
> > > Updating 3c8cf5a9c21ff8782164d1def7f44bd888713384
> > > Switched to a new branch 'test'
> > > 1b4f6f3 MAINTAINERS: add simplebench
> > > 57b42b6 scripts/simplebench: add example usage of simplebench
> > > 99ea4d7 scripts/simplebench: add qemu/bench_block_job.py
> > > 196f97d scripts/simplebench: add simplebench.py
> > >
> > > =3D=3D=3D OUTPUT BEGIN =3D=3D=3D
> > > 1/4 Checking commit 196f97d8566d (scripts/simplebench: add simplebenc=
h.py)
> > > WARNING: added, moved or deleted file(s), does MAINTAINERS need updat=
ing?
> > > #16:
> > > new file mode 100644
> > >
> > > ERROR: please use python3 interpreter
> > > #21: FILE: scripts/simplebench/simplebench.py:1:
> > > +#!/usr/bin/env python
> >
> > Hmm, yes, we need to fix it.
> >
> > Should I resend?
> >
>
> Just send that as follow up bug fixes.  No need to resend the
> whole series.
>

Vladimir, you can send as follow-up fixes those changes in
output format that we both agree are needed for nicer output.

Thanks,
Aleksandar

> --
> Eduardo
>
>

