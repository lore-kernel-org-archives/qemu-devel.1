Return-Path: <SRS0=bFmd=ZT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9814FC432C0
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Nov 2019 18:55:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6379720715
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Nov 2019 18:55:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XN3kBFnc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6379720715
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41846 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ia2St-00046E-DM
	for qemu-devel@archiver.kernel.org; Wed, 27 Nov 2019 13:55:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:46687)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1ia2Kc-0006qv-Em
 for qemu-devel@nongnu.org; Wed, 27 Nov 2019 13:46:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1ia2KV-0001NZ-6Y
 for qemu-devel@nongnu.org; Wed, 27 Nov 2019 13:46:28 -0500
Received: from mail-ot1-x329.google.com ([2607:f8b0:4864:20::329]:36368)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <aleksandar.m.mail@gmail.com>)
 id 1ia2KT-0000cN-8i
 for qemu-devel@nongnu.org; Wed, 27 Nov 2019 13:46:22 -0500
Received: by mail-ot1-x329.google.com with SMTP id d7so3107115otq.3
 for <qemu-devel@nongnu.org>; Wed, 27 Nov 2019 10:46:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=x1XXFHuR2g2Kd5nM74RzsgCxQuaxK/zMqg5TwSY0nmg=;
 b=XN3kBFnc+3VMhF/4e49bNBMzZwy+36EC9Z532x81sMZw3XF19xKDZtU835cbCoOoiU
 ccD1PADkc/pf5yi7M4D/uAesyCylUBGHWDY2XuLER1vTpCB3ZeqYq8AeKkQGcqtHTI6m
 49Sv5Pxm9y61thIR72Ejyv+AZcTlfFiE2L0OsDAljb1UHCgWg9J7YtkeHFED4WPYDRiA
 d/sKirJgjf8GI7/asmxU6EiHLv9oUiSgXkrmW0xcRa1RZbYPPdxEM6db8TN8Z/WCpAAn
 RpLnPcxZ11uQ8cAY5POPLTeUgfScW4zGmfJOtUJu13qFLIg4uthziVni1M+6NEYBRp+C
 76wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=x1XXFHuR2g2Kd5nM74RzsgCxQuaxK/zMqg5TwSY0nmg=;
 b=EKKiIJ3Pk+Uf96qLq29AGRKpjOur2VK806uKsvFi6QUz5cjval0OGQxriVmt2N0BxH
 ybi5dbdyAuATre4liJWvr0Ddj5ruzLOitp9dawUnKrUDVHUx3XjDxyBne9ujuBNcDupF
 zx+SYCce7B9ihSY8gGqAW+8Y32KpHEDJxVTCngRcMIh0TRn9tfi4tLeXgZlqHC9T7b6b
 KbWu3+m6nnc1Z6o2TMw1r2XeBKLxJ9dI3Bt6cQOjrUHBbqCf9PtPZ2J31LwtaIiZWRWy
 EZUDrY0bt25lWTTkIHn/x78yB0I9+WMx2nn0rJgMjdWvibtUGhhSfL4aRvysYzV0Y2nt
 BB1Q==
X-Gm-Message-State: APjAAAVFwvsV2rSZDgJJOYD6BLIrW6j8IlPPalSWJJD0csmMdNlFbG8T
 DdE5bb9bptjFfNrER7IYhwFtXPGXkQMJ+mGPAaI=
X-Google-Smtp-Source: APXvYqx0mjH2z/1weBhTTaqkbQ9Q9Z4y8jI9CuKdzOIJ3/7MD4al/QboBG9GGq7D7BEKCZZoujDsmRUsZm6R7PsTRlw=
X-Received: by 2002:a9d:1b3:: with SMTP id e48mr4884724ote.341.1574880379353; 
 Wed, 27 Nov 2019 10:46:19 -0800 (PST)
MIME-Version: 1.0
References: <20191125104103.28962-1-philmd@redhat.com>
In-Reply-To: <20191125104103.28962-1-philmd@redhat.com>
From: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Date: Wed, 27 Nov 2019 19:46:08 +0100
Message-ID: <CAL1e-=gsR8PkWpMZOjPDJDHsGhZ2hMZU_af54sNh1Yi4oYDeQA@mail.gmail.com>
Subject: Re: [PATCH-for-4.2] hw/mips: Deprecate the r4k machine
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::329
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
Cc: Thomas Huth <thuth@redhat.com>, libvir-list@redhat.com,
 QEMU Developers <qemu-devel@nongnu.org>,
 =?UTF-8?Q?Herv=C3=A9_Poussineau?= <hpoussin@reactos.org>,
 Aleksandar Markovic <amarkovic@wavecomp.com>,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Nov 25, 2019 at 11:41 AM Philippe Mathieu-Daud=C3=A9
<philmd@redhat.com> wrote:
>
> The r4k machine was introduced in 2005 (6af0bf9c7) and its last
> logical change was in 2005 (9542611a6). After we can count 164
> maintenance commits (QEMU API changes) with the exception of
> 1 fix in 2015 (memory leak, commit 3ad9fd5a).
>
> This machine was introduced as a proof of concept to run a MIPS
> CPU. 2 years later, the Malta machine was add (commit 5856de80)
> modeling a real platform.
>
> Note also this machine has no specification except 5 lines in
> the header of this file:
>
>  * emulates a simple machine with ISA-like bus.
>  * ISA IO space mapped to the 0x14000000 (PHYS) and
>  * ISA memory at the 0x10000000 (PHYS, 16Mb in size).
>  * All peripherial devices are attached to this "bus" with
>  * the standard PC ISA addresses.
>
> It is time to deprecate this obsolete machine. Users are
> recommended to use the Malta board, which hardware is well
> documented.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> ---
>  qemu-deprecated.texi | 5 +++++
>  hw/mips/mips_r4k.c   | 1 +
>  MAINTAINERS          | 2 +-
>  3 files changed, 7 insertions(+), 1 deletion(-)
>


Reviewed-by: Aleksandar Markovic <amarkovic@wavecomp.com>


> diff --git a/qemu-deprecated.texi b/qemu-deprecated.texi
> index 4b4b7425ac..05265b43c8 100644
> --- a/qemu-deprecated.texi
> +++ b/qemu-deprecated.texi
> @@ -266,6 +266,11 @@ The 'scsi-disk' device is deprecated. Users should u=
se 'scsi-hd' or
>
>  @section System emulator machines
>
> +@subsection mips r4k platform (since 4.2)
> +
> +This machine type is very old and unmaintained. Users should use the 'ma=
lta'
> +machine type instead.
> +
>  @subsection pc-0.12, pc-0.13, pc-0.14 and pc-0.15 (since 4.0)
>
>  These machine types are very old and likely can not be used for live mig=
ration
> diff --git a/hw/mips/mips_r4k.c b/hw/mips/mips_r4k.c
> index 70024235ae..0b79ad26cb 100644
> --- a/hw/mips/mips_r4k.c
> +++ b/hw/mips/mips_r4k.c
> @@ -294,6 +294,7 @@ void mips_r4k_init(MachineState *machine)
>
>  static void mips_machine_init(MachineClass *mc)
>  {
> +    mc->deprecation_reason =3D "use malta machine type instead";
>      mc->desc =3D "mips r4k platform";
>      mc->init =3D mips_r4k_init;
>      mc->block_default_type =3D IF_IDE;
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 5e5e3e52d6..3b3a88e264 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -972,7 +972,7 @@ F: hw/net/mipsnet.c
>  R4000
>  M: Aurelien Jarno <aurelien@aurel32.net>
>  R: Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>
> -S: Maintained
> +S: Obsolete
>  F: hw/mips/mips_r4k.c
>
>  Fulong 2E
> --
> 2.21.0
>
>

