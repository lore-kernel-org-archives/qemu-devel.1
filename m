Return-Path: <SRS0=QD06=ZF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD45EC432C3
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Nov 2019 16:53:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 62F2B206D3
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Nov 2019 16:53:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DZIkfGjl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 62F2B206D3
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47462 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iUvtv-0004mT-SO
	for qemu-devel@archiver.kernel.org; Wed, 13 Nov 2019 11:53:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45543)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <sameid@google.com>) id 1iUvmz-0004tC-6v
 for qemu-devel@nongnu.org; Wed, 13 Nov 2019 11:46:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <sameid@google.com>) id 1iUvmv-00077E-4d
 for qemu-devel@nongnu.org; Wed, 13 Nov 2019 11:46:39 -0500
Received: from mail-qv1-xf44.google.com ([2607:f8b0:4864:20::f44]:44722)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <sameid@google.com>) id 1iUvmu-00076c-DN
 for qemu-devel@nongnu.org; Wed, 13 Nov 2019 11:46:36 -0500
Received: by mail-qv1-xf44.google.com with SMTP id d3so1068281qvs.11
 for <qemu-devel@nongnu.org>; Wed, 13 Nov 2019 08:46:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=H2T4CW/fFtJ7qTKVlw1EfF9OHZRW0qNkbbnBH8/YztA=;
 b=DZIkfGjlGjA3Bv7uKY0Hv2FshF+S/3x8Ue+HxKPJBs00W4sdvy97etts9fRei1lAHz
 EvJ44yhilYKHvXTZEPVWEPWxgn5y5rAp/s8Ucl+tLOVWmQEokEleWFDyGMeI9s0YaRXr
 5AhheVKT+pHsCWw6VtBFF/TaCnZba7GIucH0ps+jhkkkTPXIA/CUBwvUYez2FhI6qEuX
 iWvH4FOuW44uI6FmVe5VCx7kiqIhIybtKRBaxKhgX+n5ePBa1s6B19mHnJPxvxZd6prY
 LGpuStYPkaKI8TpEzDMEdnYBdlhb4b3zJEAK9+7oeNJVPYJ/6oAmpu+Y5eXCTShwmFVt
 EG3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=H2T4CW/fFtJ7qTKVlw1EfF9OHZRW0qNkbbnBH8/YztA=;
 b=WOFti20YbiwzpE8Pghz0o/XJU6JOVyNNuvC30LeNvi6/VMvzwBylEwxB/kW5HKWQYR
 BzjBgJFoxWrGSNO3m1CfyiQpD8pU2lbwKKBYCz16i3WbuQk4F/2y3kFvszfVTdbhVPxm
 qTRrSs5KJWjpLp47N1ojp20ey0+EeKQUWMPucFmXbIeDLzo2AX3vPVYQvY/JyiV9pS2m
 R5cPfjMigr54VQBEON9rCKKFU9kqyAYvoNpHRT9jWNec4XOgMN3WcqywN+OPwGe0Y715
 VeGXSU8S0J39SHRHqYdcUqVz5jHGMX2Cu6lZhXmwZqJXh7qjAn1y8crTxVdFJ/s9OeJY
 LOXg==
X-Gm-Message-State: APjAAAWJLDWrk/oZRk2NDmpxreh+fcJFgl9B4J/1vfutNj4xYsrx9BP3
 3Ck/i1Nz4J65zoJ9Y1iTuuHKf60BfdeLhkcfC3aDgA==
X-Google-Smtp-Source: APXvYqyyfqmPV3smKhmZ/ilXt1u859euBJoIdqBZ0BLSBatkimON7MNFO0JY9tQKLdQiaRasUJhPRqyfIXw1fL10NzQ=
X-Received: by 2002:ad4:4092:: with SMTP id l18mr3574904qvp.114.1573663595160; 
 Wed, 13 Nov 2019 08:46:35 -0800 (PST)
MIME-Version: 1.0
References: <20191113091809.31365-1-kraxel@redhat.com>
 <84d3a1aa-bbb2-d831-0abc-fe1169f8a860@redhat.com>
 <20191113140057.2ocwfa3rqqfkbg3r@sirius.home.kraxel.org>
 <CAFr6bUn5W2-w3z4Ty9XD7mh+=kxVq2rQJ3ZUz5nXA13ZdxQtsg@mail.gmail.com>
 <ca6dadb1-fddf-5f6f-a6fc-f94eb02862b6@redhat.com>
 <CAFr6bUkGrC64gXfLgeZ5hYEkzLF4J-NzNCG3X1deHEovyJ7qSw@mail.gmail.com>
In-Reply-To: <CAFr6bUkGrC64gXfLgeZ5hYEkzLF4J-NzNCG3X1deHEovyJ7qSw@mail.gmail.com>
From: Sam Eiderman <sameid@google.com>
Date: Wed, 13 Nov 2019 18:46:23 +0200
Message-ID: <CAFr6bU=Ru+G8u_aSeN7-nGYz54V0a2cpJz+dsNP8R98zR_kahQ@mail.gmail.com>
Subject: Re: [SeaBIOS] Re: [PATCH] ahci: zero-initialize port struct
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Cc: Gerd Hoffmann <kraxel@redhat.com>, Laszlo Ersek <lersek@redhat.com>,
 seabios@seabios.org, 
 Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::f44
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Links to latest commits from archive.
You can see all changes in the cover letter.

[SeaBIOS] [PATCH v4 0/5] Add Qemu to SeaBIOS LCHS interface
https://mail.coreboot.org/hyperkitty/list/seabios@seabios.org/message/VLNFB=
EERTWLEUO6LM5BYLBNVIFCTP46M/
[SeaBIOS] [PATCH v4 1/5] geometry: Read LCHS from fw_cfg
https://mail.coreboot.org/hyperkitty/list/seabios@seabios.org/message/B3IPD=
3HH4UPDYJWFE4KX3HXUCNW5GPEW/
[SeaBIOS] [PATCH v4 2/5] boot: Reorder functions in boot.c
https://mail.coreboot.org/hyperkitty/list/seabios@seabios.org/message/YDVU3=
WIGOSKZ2RQSMR5UVQNZ66K4IG65/
[SeaBIOS] [PATCH v4 3/5] boot: Build ata and scsi paths in function
https://mail.coreboot.org/hyperkitty/list/seabios@seabios.org/message/RY33D=
RZZ3UK3UMQ3Q6BY2KUCHRRW4MRK/
[SeaBIOS] [PATCH v4 4/5] geometry: Add boot_lchs_find_*() utility functions
https://mail.coreboot.org/hyperkitty/list/seabios@seabios.org/message/DAJOU=
LWFK24DX4DY3VS6WWOOQNWW3GSG/
[SeaBIOS] [PATCH v4 5/5] geometry: Apply LCHS values for boot devices
https://mail.coreboot.org/hyperkitty/list/seabios@seabios.org/message/UUCTP=
PJ4PTS5CUTCFLOH3YOEXGC6HQ4T/

Sam

On Wed, Nov 13, 2019 at 6:35 PM Sam Eiderman <sameid@google.com> wrote:
>
> Sure,
>
> There are two issues here.
>
> The first issue is that my commits which applied to seabios master:
>
> * 9caa19b - geometry: Apply LCHS values for boot devices
> * cb56f61 - config: Add toggle for bootdevice information
> * ad29109 - geometry: Add boot_lchs_find_*() utility functions
> * b3d2120 - boot: Reorder functions in boot.c
> * 7c66a43 - geometry: Read LCHS from fw_cfg
>
> Are not from the latest version which was submitted to the mailing list (=
v4)
> * fw_cfg key name has changed
> * The value and of the key has changed from binary (v1) to textual (v4)
> * Other fixes and variable name changes.
>
> So these commits need to be reverted and reapplied with the latest versio=
n (v4)
>
> The second issue is that my commits, (in v4 too) will require this fix
> that Gerd added ([PATCH] ahci: zero-initialize port struct) since they
> change how SeaBIOS uses lchs.
>
> Previously, before any of my commits, drive.lchs could contain "random
> crap" since it was always set before being used in
> setup_translation().
>
> After my patches, get_translation() invokes overriden_lchs_supplied()
> which checks: "return drive->lchs.cylinder || drive->lchs.head ||
> drive->lchs.sector;"
> So there is an assumption that "drive->lchs" is zeroed when lchs is
> not supplied for the host.
>
> This was true for all devices using "drive->lchs" (all were memset to
> 0) except ahci.
> (I used 'git grep "drive_s * drive"' to find them all).
>
> So Gerd fix is indeed needed and then all devices are covered
> (drive->lchs is memset to 0).
>
> Now only the first issue remains...
>
> Sam
>
> On Wed, Nov 13, 2019 at 6:12 PM Philippe Mathieu-Daud=C3=A9
> <philmd@redhat.com> wrote:
> >
> > Hi Sam,
> >
> > On 11/13/19 4:03 PM, Sam Eiderman wrote:
> > > Hi,
> > >
> > > Does this fix a bug that actually happened?
> > >
> > > I just noticed that in my lchs patches I assumed that lchs struct is
> > > zeroed out in all devices (not only ahci):
> > >
> > > 9caa19be0e53 (geometry: Apply LCHS values for boot devices)
> > >
> > > Seems like this is not the case but why only ahci is affected?
> > >
> > > The list of devices is at least:
> > >
> > >          * ata
> > >          * ahci
> > >          * scsi
> > >              * esp
> > >              * lsi
> > >              * megasas
> > >              * mpt
> > >              * pvscsi
> > >              * virtio
> > >          * virtio-blk
> > >
> > > As specified in the commit message.
> > >
> > > Also Gerd it seems that my lchs patches were not committed in the
> > > latest submitted version (v4)!!!
> > > The ABI of the fw config key is completely broken.
> >
> > What do you mean? Can you be more specific?
> >

