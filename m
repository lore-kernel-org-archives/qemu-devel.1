Return-Path: <SRS0=u80H=ZS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D4FCC432C0
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Nov 2019 20:47:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DFD4920684
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Nov 2019 20:47:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B0Pm1HWz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DFD4920684
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58956 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iZhkS-0002OC-22
	for qemu-devel@archiver.kernel.org; Tue, 26 Nov 2019 15:47:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:44592)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1iZhj7-0001i1-VL
 for qemu-devel@nongnu.org; Tue, 26 Nov 2019 15:46:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1iZhj6-00033W-Ac
 for qemu-devel@nongnu.org; Tue, 26 Nov 2019 15:46:25 -0500
Received: from mail-ot1-x329.google.com ([2607:f8b0:4864:20::329]:42450)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <aleksandar.m.mail@gmail.com>)
 id 1iZhj6-00033F-5U
 for qemu-devel@nongnu.org; Tue, 26 Nov 2019 15:46:24 -0500
Received: by mail-ot1-x329.google.com with SMTP id 66so11028944otd.9
 for <qemu-devel@nongnu.org>; Tue, 26 Nov 2019 12:46:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=RTjkp7uAPBgzZIYZsVovl3YqcGnkLtXwcF/kQ5Vp0GE=;
 b=B0Pm1HWziEeMPnZ+kpdrZ7D+SH/RbEjpc5Y2y73R/3WEmUUoP6jIUCDDemquy7IH9S
 F3KZyrVgjjWF/Z8poE74iLBi5EAsUuCrrW7gJXnmovKihH+yMjgSVWZ6u2xWXn8IGNic
 eUCbeOz5xVhNV28yYXPyjljJmq+OUWARPDWqRzE8crEEGZ23MGgHCTGs5WIwGzK9eaJ4
 ah+D70WS8ooya2dhpvcaqeGPjp2xIFozeNMHm5IbdtEs0KqCi7SYPONDja+78/WUvJ+p
 F+tUbIgTkrKVkFbVgA1rgfdKkKsr4fegeyPqNVQ4EgFTllNMyhPPEJGlIfvs4mJFF4mJ
 vAog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=RTjkp7uAPBgzZIYZsVovl3YqcGnkLtXwcF/kQ5Vp0GE=;
 b=i7ba8RewxBJsvWUDS1w7V0Cd0cHLzYalk1ovwVqJG9ptBI1PBGCFFjdqIrx/uB83Qi
 FlVhsYQsHv/AMTOnLZU3OXWdnHtAB+bfMX43Y+OpMfFTRcqBTnD8C5XZ8M2zLMa4Reav
 Go8jIE++sZtbrJM6ArmL5aB8O6D5bEiHm6GnyY/DMOmDXR152KketqQYODRAscEIO32G
 tqC+bOyE9o2OS4Oi2YID9o8l/duQUd7eq9afXGbpOF17gArmThuJBNsBAnW3DSkhRI4F
 sfDc7KYsNc+YmgHG8IKI+OpBg8VPrGOk0Sv7g3DW7f3xvRwLhe8uGkvto3aQuz/nzf7A
 ey2Q==
X-Gm-Message-State: APjAAAV2VEBBRKmDAwJ2YR3Z2tDVbPt4HjJmE915Z/RuOUsGQisdSbwZ
 iKq4XqvOr44Zck1j/ITrG+IleD9E0cqO0w9Pos8=
X-Google-Smtp-Source: APXvYqx2ACPtZQiAI6dMg/N4UufxjX0BeWK7+aw/6WxBzFsOq+FUez0FI2PLcl5r63K8335wAHMbMLVuinE8vCAl7Bk=
X-Received: by 2002:a05:6830:44c:: with SMTP id
 d12mr742768otc.121.1574801183285; 
 Tue, 26 Nov 2019 12:46:23 -0800 (PST)
MIME-Version: 1.0
References: <20191125104103.28962-1-philmd@redhat.com>
In-Reply-To: <20191125104103.28962-1-philmd@redhat.com>
From: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Date: Tue, 26 Nov 2019 21:46:12 +0100
Message-ID: <CAL1e-=h69CVmS6Rpm_CNet836BLSxTPQsXmP1Ur4tVL-0uryOw@mail.gmail.com>
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

Philippe,

I see you added "libvir-list" in "cc". Was it a mistake, or there was
some purpose?

Yours,
Aleksandar

>  qemu-deprecated.texi | 5 +++++
>  hw/mips/mips_r4k.c   | 1 +
>  MAINTAINERS          | 2 +-
>  3 files changed, 7 insertions(+), 1 deletion(-)
>
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

