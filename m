Return-Path: <SRS0=WkHy=5I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CFF9C3F2CD
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Mar 2020 15:57:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6565220714
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Mar 2020 15:57:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HcvVC9rS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6565220714
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36002 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jGPSV-0008BO-J3
	for qemu-devel@archiver.kernel.org; Mon, 23 Mar 2020 11:57:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59346)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alistair23@gmail.com>) id 1jGPRZ-0007DK-He
 for qemu-devel@nongnu.org; Mon, 23 Mar 2020 11:56:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alistair23@gmail.com>) id 1jGPRY-0003hH-ED
 for qemu-devel@nongnu.org; Mon, 23 Mar 2020 11:56:49 -0400
Received: from mail-ua1-x941.google.com ([2607:f8b0:4864:20::941]:36388)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alistair23@gmail.com>)
 id 1jGPRY-0003gE-7A; Mon, 23 Mar 2020 11:56:48 -0400
Received: by mail-ua1-x941.google.com with SMTP id o15so3297539ual.3;
 Mon, 23 Mar 2020 08:56:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=9sdYk+m9VIBNOHQO5FBubdeWBpMknt0oInCQuRCvabk=;
 b=HcvVC9rSVzeRmghwV0dJsoagZ9/o/EtcUICpPdEIItvD2CqprcMlHNhVhCnPJJc5Tx
 3KOABXPct/V6qgxgaWbeDQzF3wmc+p90p0SfGgCKsHr1WzlXcq23piVpb+ec2qkDNljR
 kW+b5UlTu44XqnxCgwSQhU116gSDExzlDkwzciQK4y8hN41rAr9ETxr4dY8DDWUSFFD+
 Q8zR8vUkJLDb8SIT+EboUmo+QwO1Fqfaq+LpSv8gCPnsPnDOdBuffmdhM3aYVB354Koq
 iQ5zOQrKZPQY0ioj6PmUQIl7ahzn7ohtnG+6QijI8n/hcVbEZtmjbHNTa8wLxFsw2yf+
 hw6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=9sdYk+m9VIBNOHQO5FBubdeWBpMknt0oInCQuRCvabk=;
 b=uGGR7pdo/lPhesTzHc7maVYJiL4IEOd0WI4iGjtz+b0xXvxLE/tH7HOO+9rByErCin
 bUy32z3O3T3J8N67Bq29HV9IuCV/Gv0uPrEfCCWs1htCiqf1A25CRHEp+8vvfoUNLQ+P
 O+zAAIjDMRH5G/TzNPxmAVxRoudac65zuf8zjSlNQyNY453/a8MnC3ZeJIX8mHitlGEU
 tEM56F/RtBmS50MkWc/r7hzAURSMFu1ZV6djhDIXNBGqByo2y6vjBB0+mmw0pHy7yxK1
 x2SVHNBwunQ2tV3TfjeM7AYG5EefGkzwZIViysPWz0CfLZDOWsGso68PERjYHV/MUNTR
 puhw==
X-Gm-Message-State: ANhLgQ1e+CPpsiJOHeLqDB4lsdO4No9Z5vHwn2T26mbhJJoElu5lkTpi
 GzYfCT3JPqqt9mLzHMmrN7fYybPZq5wjJ5hQtfI=
X-Google-Smtp-Source: ADFU+vtOwLMb9HGc6CN/cWNb7fSM7pmdgHKEIBBxBnPDn2LA/MTGjSUMAZ/YRuwR1jOpP1uIuVhfxe5ZMREElC5HTMg=
X-Received: by 2002:a9f:2964:: with SMTP id t91mr7715691uat.21.1584979005734; 
 Mon, 23 Mar 2020 08:56:45 -0700 (PDT)
MIME-Version: 1.0
References: <20200321144110.5010-1-philmd@redhat.com>
 <20200321144110.5010-2-philmd@redhat.com>
In-Reply-To: <20200321144110.5010-2-philmd@redhat.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 23 Mar 2020 08:48:47 -0700
Message-ID: <CAKmqyKNRs-ARh9vcV_TywnM1dBfQtMfUXV94sHTjY2BSE7=4hQ@mail.gmail.com>
Subject: Re: [PATCH-for-5.0 v2 01/11] block: Avoid dead assignment
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::941
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
Cc: Fam Zheng <fam@euphon.net>, Peter Maydell <peter.maydell@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 Qemu-block <qemu-block@nongnu.org>, QEMU Trivial <qemu-trivial@nongnu.org>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?Q?Herv=C3=A9_Poussineau?= <hpoussin@reactos.org>,
 Joel Stanley <joel@jms.id.au>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Alistair Francis <alistair@alistair23.me>, qemu-arm <qemu-arm@nongnu.org>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, John Snow <jsnow@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>, Kevin Wolf <kwolf@redhat.com>,
 Igor Mitsyanko <i.mitsyanko@gmail.com>, Laurent Vivier <laurent@vivier.eu>,
 Max Reitz <mreitz@redhat.com>, Andrew Jeffery <andrew@aj.id.au>,
 "open list:New World" <qemu-ppc@nongnu.org>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sat, Mar 21, 2020 at 7:42 AM Philippe Mathieu-Daud=C3=A9
<philmd@redhat.com> wrote:
>
> Fix warning reported by Clang static code analyzer:
>
>   block.c:3167:5: warning: Value stored to 'ret' is never read
>       ret =3D bdrv_fill_options(&options, filename, &flags, &local_err);
>       ^     ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>
> Fixes: 462f5bcf6
> Reported-by: Clang Static Analyzer
> Suggested-by: Markus Armbruster <armbru@redhat.com>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
> v2: Keep 'ret' assigned and check it (Markus)
> ---
>  block.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/block.c b/block.c
> index a2542c977b..a6f069d8bd 100644
> --- a/block.c
> +++ b/block.c
> @@ -3165,7 +3165,7 @@ static BlockDriverState *bdrv_open_inherit(const ch=
ar *filename,
>      }
>
>      ret =3D bdrv_fill_options(&options, filename, &flags, &local_err);
> -    if (local_err) {
> +    if (ret < 0) {
>          goto fail;
>      }
>
> --
> 2.21.1
>
>

