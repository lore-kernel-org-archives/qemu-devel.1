Return-Path: <SRS0=9jkQ=VP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 428F2C76191
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jul 2019 12:21:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0D34A21783
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jul 2019 12:21:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gh4DhHQl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D34A21783
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37434 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ho5PO-0007Mf-45
	for qemu-devel@archiver.kernel.org; Thu, 18 Jul 2019 08:21:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39775)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1ho5PC-0006wq-PW
 for qemu-devel@nongnu.org; Thu, 18 Jul 2019 08:21:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1ho5PB-0007DU-CJ
 for qemu-devel@nongnu.org; Thu, 18 Jul 2019 08:21:02 -0400
Received: from mail-ot1-x331.google.com ([2607:f8b0:4864:20::331]:45222)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <aleksandar.m.mail@gmail.com>)
 id 1ho5PB-0007Cu-6s
 for qemu-devel@nongnu.org; Thu, 18 Jul 2019 08:21:01 -0400
Received: by mail-ot1-x331.google.com with SMTP id x21so28735961otq.12
 for <qemu-devel@nongnu.org>; Thu, 18 Jul 2019 05:21:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=ZOJH/EM+Tk04eB/8jhZDpK4FyUlykMb5XF5LeaJ/zbo=;
 b=gh4DhHQlCjl6x156rzRNBzYFJPmJd7ylSDrbVpmSoMAV7hjHTn1O2QyufwG9qdJp0o
 YB39VX0dTf4XJY5cr4UHrOsCShjT1VvVIa1ELKPax9MjkUAI7U0NQMEIafK+bjTxl+gD
 eR3QVS2G/Vno1Mca5BmVnvD1mA5SHjOecAuIYNTJPGRL6yM0wkqjuFA35VosTcM5I+2o
 wc+8i6/qNOtk6rqeGPWBAWJM4/3bOUkbFns85SOohDaMuusCj3KRrHHFObihwJkLi465
 DAySgN9ig1O4hDjbNkNQM1SwBJ65YmrjoK8aVrfAM4TsVD9dmxx5XTBFahuw7+6KHoM2
 lLtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=ZOJH/EM+Tk04eB/8jhZDpK4FyUlykMb5XF5LeaJ/zbo=;
 b=Byk2Kbdqo+GHOWipYdKyl+mWQvAd4leQzokIISHzeTWHymZVCLWlJhK/utOqc8zfIB
 y1vIxExoliLiKXKwfW9yArLvG03RQGB8sjuFr1PucOUkvkoRx8YgB2zSu1O0yxlgIrCo
 CAONp01H2D9cmp0EqaZpcydiY4ooyeODKf3jYB83YXYkaOxIOo2CRNqDE8sXuOCbTW6W
 79+kieLkZgV11w+q0oWxdM/mBF4MC1N4k3tOaqGCNYpKxxbs70X+0edQSSnZv0mYEevm
 qjHmELIJvmVJ8DHybqD8bCP9n8os089DOxHNc0gz/ApfqPx5Z2KJ45mbzYiK2pWGdMhl
 0T1Q==
X-Gm-Message-State: APjAAAURCg0FznI9Z8reihw2omxNQ9bJEjyVYAaKspm0k7WrAhjoB4ah
 6WAZMZ1Z1E9+Slx2vA3RbXsD9FQ8r4/WASynPCA=
X-Google-Smtp-Source: APXvYqxxVJVI1DF91ZwYnugSdDdCsTpyVRYeL2uIuOcmw2NtIBC6vpheyHQabuTW08MelVXgcVWhEvc4WQbUb5rKtd4=
X-Received: by 2002:a9d:5cc1:: with SMTP id r1mr27187511oti.341.1563452459751; 
 Thu, 18 Jul 2019 05:20:59 -0700 (PDT)
MIME-Version: 1.0
References: <cb727b5d-683f-115d-f3c0-06f5a6761aea@redhat.com>
 <126a3ec4-f5e3-0590-011a-9c2a10d07b24@redhat.com>
 <bf5da6c7-74c1-8950-2869-2d94419f1820@redhat.com>
 <CAL1e-=iLLQfAdfFrKpAT9k48X0sEMevBXFWAmny7PRPwtBMiEQ@mail.gmail.com>
 <4367860f-5226-ec42-6407-f50dfd96270b@redhat.com>
 <20190718114352.GE15411@redhat.com>
In-Reply-To: <20190718114352.GE15411@redhat.com>
From: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Date: Thu, 18 Jul 2019 14:20:48 +0200
Message-ID: <CAL1e-=hXg6HpAjtsxC+qaHMBXKU7-PKHf0QL+3mRKOh8ojNpOA@mail.gmail.com>
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::331
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Content-Filtered-By: Mailman/MimeDel 2.1.23
Subject: Re: [Qemu-devel] No archives to download from www.qemu.org/download/
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
Cc: Stefan Weil <sw@weilnetz.de>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Jul 18, 2019 at 1:43 PM Daniel P. Berrang=C3=A9 <berrange@redhat.co=
m>
wrote:

> On Thu, Jul 18, 2019 at 01:29:02PM +0200, Thomas Huth wrote:
> > On 18/07/2019 12.55, Aleksandar Markovic wrote:
> > > On Thu, Jul 18, 2019 at 10:58 AM Philippe Mathieu-Daud=C3=A9 <
> philmd@redhat.com>
> > > wrote:
> > >>
> > >> On 7/18/19 9:10 AM, Thomas Huth wrote:
> > >>> On 18/07/2019 08.25, Philippe Mathieu-Daud=C3=A9 wrote:
> > >
> > >>>> ...
> > >
> > >>>> Now there are no archive to download at this url...
> > >>>
> > >>> You just have to click on the "Source code" tab ... is that too har=
d?
> > >>
> > >> Argh it has been a rough night, now I feel ashamed. I scrolled but
> > >> missed that tab. Really sorry for crying wolf here :/
> > >>
> > >
> > > Download QEMU page <https://www.qemu.org/download/>
> > >
> > > In all fairness to Philippe, this page could be better in terms of
> > > human-computer interaction... If one presses 'Download', one
> > > expects to get to the download links directly or obviously easily.
> >
> > I guess we should simply re-arrange the order of the tabs ... the
> > OS-agnostic source code tab should come first (since this is about what
> > we provide for download on our site), and then the others with
> > references to the distros etc.
>
> I'm not sure it is clear cut. I think its reasonable to say that users
> coming to QEMU are best served by using distro provided packages. Only
> those wishing to actually hack on QEMU, or who need newer than the
> distro provides, should prefer the source. Building from source has many
> more potential hurdles / failure points than installing distro packages,
> which can leave users with a worse first experience of QEMU.
>
>
Yes, Daniel, but here we blend two visitor activities onto a single page:
download source (and build), and install QEMU (from prebuilt binaries).
Now wonder a confusion arises.

Yours,
Aleksandar



> Regards,
> Daniel
> --
> |: https://berrange.com      -o-
> https://www.flickr.com/photos/dberrange :|
> |: https://libvirt.org         -o-
> https://fstop138.berrange.com :|
> |: https://entangle-photo.org    -o-
> https://www.instagram.com/dberrange :|
>
