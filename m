Return-Path: <SRS0=TsRd=ZO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24391C432C0
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Nov 2019 20:39:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DE48120704
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Nov 2019 20:39:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UC5gx21l"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE48120704
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54828 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iYFhp-0008J6-RE
	for qemu-devel@archiver.kernel.org; Fri, 22 Nov 2019 15:39:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56242)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1iYFg9-0007K1-7A
 for qemu-devel@nongnu.org; Fri, 22 Nov 2019 15:37:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1iYFg8-0004yB-4f
 for qemu-devel@nongnu.org; Fri, 22 Nov 2019 15:37:21 -0500
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:39585)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <aleksandar.m.mail@gmail.com>)
 id 1iYFg7-0004xe-UT
 for qemu-devel@nongnu.org; Fri, 22 Nov 2019 15:37:20 -0500
Received: by mail-ot1-x344.google.com with SMTP id w24so7339000otk.6
 for <qemu-devel@nongnu.org>; Fri, 22 Nov 2019 12:37:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=f6zn+H6oF3eiDm85P3tJt6E66/oBb6hdWvSeBL7gO7M=;
 b=UC5gx21lxjWTK436MZykGKME8kfkTK5F4Hgol6nvyc8mYY9VaK45b7p7wQZKynv/I7
 WieO0zH0n3Cd8ZEj+N65BqaxW8CI1aQqSxyAyKvSoSa83EcTTOHxKRrs5k3aCglw6yc7
 gIrsOCg/wuzvP+mlS1f7UmIpRnN4oR1NYf/EciIGRJ8A5ZlTaUPyNnJMpn7XRQ/fm0vv
 eyUHYXodvRXcMEM1zzu8Ik5B2fP0H+XHmbUBTa/R8kzHfwwhi7lGhDUziXCQZJtgwU88
 gcmCelREMGU3V5iEmPEC3PwMIbdGkyotEWpwCgQLnAKin8Y1CYHgAvjwnNvAsszHSp0L
 rzyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=f6zn+H6oF3eiDm85P3tJt6E66/oBb6hdWvSeBL7gO7M=;
 b=pE+/ZdJmJwBmgjNxGbH/cnnnEyYLaA8lRFSa84I3LWCffGV0mvLrePKAW7tasfr/MB
 0jS5E8rOMD+A4NWY0BLjkGBphUBBngtYIkTwK72rX60S8HV3blpPCROSTF7T3NfM7KIP
 EMBWy+pVTaI9G00klmFvrGXQUHJZwMvbLWlg2t1kZlOaGOuIvvP3lw3e0gv9xoWSVNxZ
 wl4qsbjxeULZ+IaXCRYMIyPYb47cEGzZ8X1gqWMIfqH2tXNJB8PZR8fMrw07sdao52hC
 ecqX04ucbdDjmB91ua28dXcZ78pXOXEle8lkJLmqv3Ye+Aow8PXAP0DIOxU7te2DFgOE
 o0bg==
X-Gm-Message-State: APjAAAWkmcSuuVP5CfJaV/VBn7VQ+mra7L4oE6WfLr3/C28ebFLMU1hJ
 8C2DphlYQ0Ck1gmK1XPSPAWgrRBUFnWT6pquMVM=
X-Google-Smtp-Source: APXvYqw4ZlSnCg/GO70tTeyKJeIT60sRo03CPFmBf3qYbciKa6PTMV/SodKMUYlMk5MT6N8W874ZesOQ8iGjNIdS8oc=
X-Received: by 2002:a05:6830:81:: with SMTP id
 a1mr11839685oto.64.1574455037774; 
 Fri, 22 Nov 2019 12:37:17 -0800 (PST)
MIME-Version: 1.0
References: <1573652826-23987-1-git-send-email-aleksandar.markovic@rt-rk.com>
 <1573652826-23987-6-git-send-email-aleksandar.markovic@rt-rk.com>
 <0fc4bf6b-3725-e2dd-79aa-bc5b74377b39@redhat.com>
In-Reply-To: <0fc4bf6b-3725-e2dd-79aa-bc5b74377b39@redhat.com>
From: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Date: Fri, 22 Nov 2019 21:37:06 +0100
Message-ID: <CAL1e-=h1GAF-U2NO4BAU1FQ-qF7dwPE1MwgYModi6d1z=yADiQ@mail.gmail.com>
Subject: Re: [PATCH v2 5/5] MAINTAINERS: Add two files to Malta section
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Aleksandar Markovic <aleksandar.markovic@rt-rk.com>,
 =?UTF-8?Q?Herv=C3=A9_Poussineau?= <hpoussin@reactos.org>,
 Aleksandar Markovic <amarkovic@wavecomp.com>,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Nov 22, 2019 at 9:28 PM Philippe Mathieu-Daud=C3=A9
<philmd@redhat.com> wrote:
>
> On 11/13/19 2:47 PM, Aleksandar Markovic wrote:
> > From: Aleksandar Markovic <amarkovic@wavecomp.com>
> >
> > Add two files that were recently introduced in a refactoring,
> > that Malta emulation relies on. They are added by this patch
> > to Malta section, but they are not added to the general MIPS
> > section, since they are really not MIPS-specific, and there
> > may be some non-MIPS hardware using them in future.
> >
> > Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
> > ---
> >   MAINTAINERS | 2 ++
> >   1 file changed, 2 insertions(+)
> >
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index ba9ca98..f8a1646 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -959,8 +959,10 @@ M: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> >   R: Herv=C3=A9 Poussineau <hpoussin@reactos.org>
> >   R: Aurelien Jarno <aurelien@aurel32.net>
> >   S: Maintained
> > +F: hw/isa/piix4.c
>
> Maybe:
>
>     F: hw/*/piix4.c
>
> Or also add:
>
>     F: hw/acpi/piix4.c
>

Philippe, are you sure? hw/acpi/piix4.c is used in PC, not in Malta, no?

> >   F: hw/mips/mips_malta.c
> >   F: hw/mips/gt64xxx_pci.c
> > +F: include/hw/southbridge/piix.h
> >   F: tests/acceptance/linux_ssh_mips_malta.py
> >
> >   Mipssim
> >
>
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
>
>

