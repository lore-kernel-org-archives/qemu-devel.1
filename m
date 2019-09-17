Return-Path: <SRS0=ES4k=XM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA474C4CECD
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Sep 2019 08:25:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8E22A20678
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Sep 2019 08:25:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O9C/VDDP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8E22A20678
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42642 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iA8nP-0004mc-Pk
	for qemu-devel@archiver.kernel.org; Tue, 17 Sep 2019 04:25:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54129)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <marcandre.lureau@gmail.com>) id 1iA8mh-0004Dy-2G
 for qemu-devel@nongnu.org; Tue, 17 Sep 2019 04:24:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <marcandre.lureau@gmail.com>) id 1iA8mf-0006N0-OU
 for qemu-devel@nongnu.org; Tue, 17 Sep 2019 04:24:26 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:45358)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
 id 1iA8mf-0006Mb-Fb
 for qemu-devel@nongnu.org; Tue, 17 Sep 2019 04:24:25 -0400
Received: by mail-wr1-x441.google.com with SMTP id r5so2051630wrm.12
 for <qemu-devel@nongnu.org>; Tue, 17 Sep 2019 01:24:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=FVlbjPxEY+eW65vxtwfmJjAmqCZKjosQZHM4rG212/0=;
 b=O9C/VDDPpE+0HHzp63emtbYxBPUXnDg7+5Gpv/OMNXKi2CHRoqTw1Moq+cP7ouWOOA
 wQd/FAsAGabuQfrGmgGEELzM7otRXmzZEuU0W5HtST6cc3C/9NNGnwbayMbujOkGmUSk
 IbOdzUDlkVqrs1K72srS26dyExpiYzExg8c9IIBAqKFD4GAk0BYefJkxk3sGHX4v6mDN
 tHm58zdLl6/K1sGub8vvfnuRFuSNZds+BlXT4IQWwDEQP/oFn8KnyBJZExoXgtVh0Pl2
 PVV0V4ntS0yPjGobe79WhHzKf2iXnN4Ca5Q0dWYQrCj7VYopWBLt2Fvtyh5xo39pYdu+
 v9lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=FVlbjPxEY+eW65vxtwfmJjAmqCZKjosQZHM4rG212/0=;
 b=WDnOpKgQnWuiUl4dSi6SJiNc77s8Pfx6ydav/a/jmVxasNNj6uQ7mZe6jrKsn1jHDg
 42Fs+4UbaWwwpKqWFniJMkCMVqLwkMaVtSaZXktIpignLCIpx1Qbh4pSF/2/rcXuWa6Y
 k4YsOXDFZA1WEUDExayp/UgXDDItA8Im1iQO4DR+7SUCbopgWJwHASOwvrEQxzEBBYOT
 eSDfpkP3ijnO13CTJ6awl30gxJ9B+5mxCWeEdN7kGuJgZI9C2pdnerx2iAaxIYgWjoHQ
 BU39+pJTO/UBLT2AyS0s6WwjSs2sm8gypnLX0PO8uHJSkmva7QQY2J6n1qEZGjA/p3v1
 XwbA==
X-Gm-Message-State: APjAAAWz4fBPM5UHN8hInRgKabyXDcyNENAB1ktn0jCLJ7jLH4MMlWmd
 3skpwQQrmiMt4aRDapX5Pebcla028N0XD368Yhw=
X-Google-Smtp-Source: APXvYqx0Acky/oAcGTv+f6kYq7H7gVRk5ptlogcKllsrfDXN0Akl81UeQ5aOD0VUJ+kKulpJgT2Ob/U3yCrdvIRt51g=
X-Received: by 2002:adf:f44e:: with SMTP id f14mr1822537wrp.290.1568708664179; 
 Tue, 17 Sep 2019 01:24:24 -0700 (PDT)
MIME-Version: 1.0
References: <20190912122514.22504-1-marcandre.lureau@redhat.com>
 <20190912122514.22504-6-marcandre.lureau@redhat.com>
 <20190916100035.GC2887@work-vm>
 <CAJ+F1C+GAJc8vYVLzBZWonVkjp-rdWFemAdwgE2sbxJDFKp0Uw@mail.gmail.com>
 <20190916131514.GG2887@work-vm>
 <CAJ+F1C+mbPHHO_Oet-CxUsfAxTrLvezvcV=+0KG+Rv2za=-arg@mail.gmail.com>
 <20190917081203.GA3370@work-vm>
In-Reply-To: <20190917081203.GA3370@work-vm>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Tue, 17 Sep 2019 12:23:54 +0400
Message-ID: <CAJ+F1CK4dW1kKqGMdyE1KubRc6wNqLoVBHXRcaFvPW+wV5kVpA@mail.gmail.com>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::441
Subject: Re: [Qemu-devel] [PATCH v3 5/6] docs: start a document to describe
 D-Bus usage
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
Cc: "Daniel P. Berrange" <berrange@redhat.com>,
 Juan Quintela <quintela@redhat.com>, Michal Privoznik <mprivozn@redhat.com>,
 QEMU <qemu-devel@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi

On Tue, Sep 17, 2019 at 12:12 PM Dr. David Alan Gilbert
<dgilbert@redhat.com> wrote:
>
> * Marc-Andr=C3=A9 Lureau (marcandre.lureau@gmail.com) wrote:
> > Hi
> >
> > On Mon, Sep 16, 2019 at 5:15 PM Dr. David Alan Gilbert
> > <dgilbert@redhat.com> wrote:
> > >
> > > * Marc-Andr=C3=A9 Lureau (marcandre.lureau@gmail.com) wrote:
> > > > Hi
> > > >
> > > > On Mon, Sep 16, 2019 at 2:02 PM Dr. David Alan Gilbert
> > > > <dgilbert@redhat.com> wrote:
> > > > >
> > > > > (Copying in Stefan since he was looking at DBus for virtiofs)
> > > > >
> > > > > * Marc-Andr=C3=A9 Lureau (marcandre.lureau@redhat.com) wrote:
> > > > > > Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.=
com>
>
> <snip>
>
> > > > Do you have a specific question we can answer or guide for qemu? Is
> > > > there something we have to document or implement?
> > > >
> > > > Since qemu is not managing the extra processes or applying policies=
, I
> > > > don't know what else could be done. From qemu pov, it can rely on
> > > > management layer to trust the bus and the helpers, similar to trust=
ing
> > > > the system in general.
> > >
> > > Well pretty much the same questions I asked in the discussion on v2;
> > > what is the supported configuration to ensure that one helper that's
> > > been compromised can't attack the others and qemu?
> >
> > I thought I gave the answer to that question above. What is missing? I
> > don't think one can generalize it here, it will be a case by case for
> > each helper, how they interact with each other and qemu.
>
> I think we need an example of how to lock it down; i.e. to allow a
> helper to provide migration data but not to be able to speak to other
> helpers.
>

That's the example policy I gave for dbus-dameon. Only qemu user can
talk to Helper1 (for ex, a helper migration interface). Only
qemu-helper user can claim Helper1.

You could have additionally other ways: selinux policy, p2p helpers
SCM credentials checks, or other methods.



--=20
Marc-Andr=C3=A9 Lureau

