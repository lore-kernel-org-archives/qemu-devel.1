Return-Path: <SRS0=/cID=ZR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DA47C432C0
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Nov 2019 14:58:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ECC4020748
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Nov 2019 14:58:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WR62UqpO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ECC4020748
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44964 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iZFov-0005SJ-Qe
	for qemu-devel@archiver.kernel.org; Mon, 25 Nov 2019 09:58:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:55533)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iZFnM-0004ZF-NH
 for qemu-devel@nongnu.org; Mon, 25 Nov 2019 09:56:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iZFnJ-0007BK-KQ
 for qemu-devel@nongnu.org; Mon, 25 Nov 2019 09:56:54 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:55606
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iZFnJ-0007Au-Ce
 for qemu-devel@nongnu.org; Mon, 25 Nov 2019 09:56:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574693812;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=AA5UqppXqLQF0tfz1U5RiPwHC0UeVXOo8KHVc+EIATw=;
 b=WR62UqpOw6fGkYWY5+mqjNxwWc/85RT8oq0a/6V4AW6dT3irVJphTGRuJUfi+2LskgJ5MH
 99mvIXSBY9+nxB/26NQaDF3g2zK5F0cxSXaGrCMAOuUod2HCmYaxCVDM+3cAGP3cEeBlrM
 4acgVMRHqvBvnVB3E2+jv1WPSm6mZbE=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-28--a7LQh5tMrSwvubvQXJPKg-1; Mon, 25 Nov 2019 09:56:48 -0500
Received: by mail-wm1-f71.google.com with SMTP id m68so6657245wme.7
 for <qemu-devel@nongnu.org>; Mon, 25 Nov 2019 06:56:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=iiUF5pyxL+z4vp/lJBXO8wlOjwWWsNuoKK535fR6H0M=;
 b=UvMgjNX4UNClq9G+jGZTbyxWLETibrUYmfy/lVxdPCok/gBU/tAlBT/Bq9J55lIgRJ
 9n9wn+91EaEiDfZb9PjfGG4W6W44sISbY+mWbf6waXtdCcudEQmlQY+e0y3WhMZKPTeQ
 cuqZA8elqI1OTgb1gCd/OlDarC//fvVtItEl2ffT8GLm3SCMkator2UHI7uO+r77cAYc
 GznjOhz8gKJbwto/tMOw7A/X6IbMShIsjnneBgEep1S71ZXjY7hCV2B6JkrdmRs5WOuv
 7DjohMsDBOEDc6GPdq09VNEgh4nAdyuaXlj8rak19E2ZShv+xz0AiWDJIlE76RFu1veL
 NHyw==
X-Gm-Message-State: APjAAAWauTTpvE38AiiFsIl/thc57USLXFf61afy7ba/s8P2z+UZdAsD
 EQT/kGw0Z/BNIls5QHuduEmytOJ7FSxpTtT4plywXO0p2HOos5Vxuo3dgyQT0L02Q55fG1b6U44
 KnXlEtGBNIPf4TbI=
X-Received: by 2002:adf:f744:: with SMTP id z4mr32317966wrp.205.1574693807808; 
 Mon, 25 Nov 2019 06:56:47 -0800 (PST)
X-Google-Smtp-Source: APXvYqyOARKkcXlIEc4fieVSthC2UNsyDl8t2TDLQs5sjq1TAEn03THOokn7sP+87nx8gshs8HLm0Q==
X-Received: by 2002:adf:f744:: with SMTP id z4mr32317942wrp.205.1574693807589; 
 Mon, 25 Nov 2019 06:56:47 -0800 (PST)
Received: from [192.168.1.35] (182.red-88-21-103.staticip.rima-tde.net.
 [88.21.103.182])
 by smtp.gmail.com with ESMTPSA id t16sm9003936wmt.38.2019.11.25.06.56.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 25 Nov 2019 06:56:47 -0800 (PST)
Subject: Re: [PATCH-for-4.2] hw/mips: Deprecate the r4k machine
To: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
References: <20191125104103.28962-1-philmd@redhat.com>
 <CAL1e-=hktyuAzESyZMz3P4a9aq17dsrrzWpyXYfFYn=cWP3e4A@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <a65a4811-d515-6849-3758-e9fa76cd1fd7@redhat.com>
Date: Mon, 25 Nov 2019 15:56:46 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <CAL1e-=hktyuAzESyZMz3P4a9aq17dsrrzWpyXYfFYn=cWP3e4A@mail.gmail.com>
Content-Language: en-US
X-MC-Unique: -a7LQh5tMrSwvubvQXJPKg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.120
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
 =?UTF-8?Q?Herv=c3=a9_Poussineau?= <hpoussin@reactos.org>,
 Aleksandar Markovic <amarkovic@wavecomp.com>,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 11/25/19 3:45 PM, Aleksandar Markovic wrote:
>=20
>=20
> On Monday, November 25, 2019, Philippe Mathieu-Daud=C3=A9 <philmd@redhat.=
com=20
> <mailto:philmd@redhat.com>> wrote:
>=20
>     The r4k machine was introduced in 2005 (6af0bf9c7) and its last
>     logical change was in 2005 (9542611a6). After we can count 164
>     maintenance commits (QEMU API changes) with the exception of
>     1 fix in 2015 (memory leak, commit 3ad9fd5a).
>=20
>=20
> Please don't start any deprecation process. This requires certain=20
> consultation within my company. Rest assured that everyone's opinion=20
> will be taken into account while doing consiltation.

While I think both listed maintainers need to confirm this patch=20
(Aurelien and Aleksandar Rikalo), anyone is welcome to object :)

Aurelien already acked to step down:
https://www.mail-archive.com/qemu-devel@nongnu.org/msg658363.html

We will wait for your consultation. Meanwhile, patch postponed to 5.0.

>     This machine was introduced as a proof of concept to run a MIPS
>     CPU. 2 years later, the Malta machine was add (commit 5856de80)
>     modeling a real platform.
>=20
>     Note also this machine has no specification except 5 lines in
>     the header of this file:
>=20
>      =C2=A0* emulates a simple machine with ISA-like bus.
>      =C2=A0* ISA IO space mapped to the 0x14000000 (PHYS) and
>      =C2=A0* ISA memory at the 0x10000000 (PHYS, 16Mb in size).
>      =C2=A0* All peripherial devices are attached to this "bus" with
>      =C2=A0* the standard PC ISA addresses.
>=20
>     It is time to deprecate this obsolete machine. Users are
>     recommended to use the Malta board, which hardware is well
>     documented.
>=20
>     Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com
>     <mailto:philmd@redhat.com>>
>     ---
>      =C2=A0qemu-deprecated.texi | 5 +++++
>      =C2=A0hw/mips/mips_r4k.c=C2=A0 =C2=A0| 1 +
>      =C2=A0MAINTAINERS=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | 2 +-
>      =C2=A03 files changed, 7 insertions(+), 1 deletion(-)
>=20
>     diff --git a/qemu-deprecated.texi b/qemu-deprecated.texi
>     index 4b4b7425ac..05265b43c8 100644
>     --- a/qemu-deprecated.texi
>     +++ b/qemu-deprecated.texi
>     @@ -266,6 +266,11 @@ The 'scsi-disk' device is deprecated. Users
>     should use 'scsi-hd' or
>=20
>      =C2=A0@section System emulator machines
>=20
>     +@subsection mips r4k platform (since 4.2)
>     +
>     +This machine type is very old and unmaintained. Users should use
>     the 'malta'
>     +machine type instead.
>     +
>      =C2=A0@subsection pc-0.12, pc-0.13, pc-0.14 and pc-0.15 (since 4.0)
>=20
>      =C2=A0These machine types are very old and likely can not be used fo=
r
>     live migration
>     diff --git a/hw/mips/mips_r4k.c b/hw/mips/mips_r4k.c
>     index 70024235ae..0b79ad26cb 100644
>     --- a/hw/mips/mips_r4k.c
>     +++ b/hw/mips/mips_r4k.c
>     @@ -294,6 +294,7 @@ void mips_r4k_init(MachineState *machine)
>=20
>      =C2=A0static void mips_machine_init(MachineClass *mc)
>      =C2=A0{
>     +=C2=A0 =C2=A0 mc->deprecation_reason =3D "use malta machine type ins=
tead";
>      =C2=A0 =C2=A0 =C2=A0mc->desc =3D "mips r4k platform";
>      =C2=A0 =C2=A0 =C2=A0mc->init =3D mips_r4k_init;
>      =C2=A0 =C2=A0 =C2=A0mc->block_default_type =3D IF_IDE;
>     diff --git a/MAINTAINERS b/MAINTAINERS
>     index 5e5e3e52d6..3b3a88e264 100644
>     --- a/MAINTAINERS
>     +++ b/MAINTAINERS
>     @@ -972,7 +972,7 @@ F: hw/net/mipsnet.c
>      =C2=A0R4000
>      =C2=A0M: Aurelien Jarno <aurelien@aurel32.net <mailto:aurelien@aurel=
32.net>>
>      =C2=A0R: Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com
>     <mailto:aleksandar.rikalo@rt-rk.com>>
>     -S: Maintained
>     +S: Obsolete
>      =C2=A0F: hw/mips/mips_r4k.c
>=20
>      =C2=A0Fulong 2E
>     --=20
>     2.21.0
>=20
>=20


