Return-Path: <SRS0=xKpV=2I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_SBL,URIBL_SBL_A autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3379C43603
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2019 19:38:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ACA282082E
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2019 19:38:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vpzg5mIJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ACA282082E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59704 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ihf9U-000414-D0
	for qemu-devel@archiver.kernel.org; Wed, 18 Dec 2019 14:38:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:46899)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1ihf84-0002k4-B5
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 14:37:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1ihf83-00083A-4K
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 14:37:04 -0500
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:35950)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <aleksandar.m.mail@gmail.com>)
 id 1ihf82-000820-H4
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 14:37:02 -0500
Received: by mail-ot1-x341.google.com with SMTP id w1so3842398otg.3
 for <qemu-devel@nongnu.org>; Wed, 18 Dec 2019 11:37:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=awJsa2dHdU30Q0o+lOSxI8PfSTU+FwiMyQXqFGpE4dI=;
 b=Vpzg5mIJDHOqIT9YIGk8x4FNLqDdyNAGzHPI5v7P6Q5aju9TzwqpktcPcAnCPzbCBN
 Csa9Xe14OOD9mGMjodZGzKqCbBR4cd0H/bvyVjThdztpHaZZSBKu/uhaxDrqCK5Vdk8Y
 NfN1VM4oGtWeKtLmibCyjySzHWv+TssVpuooDvfkb4EEswUzINYOlIPHay7WISPidcrj
 PF0MN5NcG54ng8SJ+FM5LXXbdAOFefk2oh11FakDAAzx04AgTF86AmuWKGthaQRB2euR
 kB6ReaVnctp/MFcw2wLUrNFxEtIrSb9Mf+5eU38/l3OobKmHuOPJFxXuwQlvJSX7up3X
 UuyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=awJsa2dHdU30Q0o+lOSxI8PfSTU+FwiMyQXqFGpE4dI=;
 b=rAwbuUjBcHTDkhDCYOMAlp6VL3RzNuxLKaaKAuiTfCcTwZKgmkbVOQ7w2KqXJgoOBc
 iGPDwsbM30RDB6teqQX7dl1eTSRedxcyp0ecTTch1eMBOrFue1wr5FYIeHHJHcgZlWHi
 DQPdaA8oomiE++aIbWdrZMYiSro36Lc+KHN3pvKIlFIf0IeJNuRPr5GMsoEpehxXonpq
 BrLjG6HXkBAF18/j5nGdFTAOVx+O7YVkddcHvCXuTnWjBAUkNIye824aR6htbel10kv/
 huJUc0M/G0WnHsh9fMHp2TDJYBkxoaLffQavkjHck8ZDwWo9Iez8XQoKDYlW3YLD6BgC
 HPJw==
X-Gm-Message-State: APjAAAUaEzIpIXLNS5PoevkJrG/HoAxlUg0TUIDtsXcV8JxvWENp03Sd
 iZSiVyssyL85AP5Dal/iynGdEhr/sc3aHBQN1tg=
X-Google-Smtp-Source: APXvYqyJQvjWK66sYiaFmcW1yPXRGRRF93evUs6ENhQTmSQshJor5HcRYjIdYEXbIMCNQLqfRjAMK+jfv4p75taL1Yw=
X-Received: by 2002:a05:6830:1042:: with SMTP id
 b2mr4391867otp.306.1576697821583; 
 Wed, 18 Dec 2019 11:37:01 -0800 (PST)
MIME-Version: 1.0
References: <20191218192526.13845-1-philmd@redhat.com>
 <20191218192526.13845-3-philmd@redhat.com>
In-Reply-To: <20191218192526.13845-3-philmd@redhat.com>
From: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Date: Wed, 18 Dec 2019 20:36:50 +0100
Message-ID: <CAL1e-=g6w3H9mHHJRgRYO=eMU8ZSQ1aMAqSGo3gVAPadmhJVgA@mail.gmail.com>
Subject: Re: [PATCH v2 2/6] hw/display/tcx: Add missing fall through comments
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::341
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
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Richard Henderson <richard.henderson@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>, Olivier Danet <odanet@caramail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Dec 18, 2019 at 8:26 PM Philippe Mathieu-Daud=C3=A9
<philmd@redhat.com> wrote:
>
> When building with GCC9 using CFLAG -Wimplicit-fallthrough=3D2 we get:
>
>   hw/display/tcx.c: In function =E2=80=98tcx_dac_writel=E2=80=99:
>   hw/display/tcx.c:453:26: error: this statement may fall through [-Werro=
r=3Dimplicit-fallthrough=3D]
>     453 |             s->dac_index =3D (s->dac_index + 1) & 0xff; /* Inde=
x autoincrement */
>         |             ~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~
>   hw/display/tcx.c:454:9: note: here
>     454 |         default:
>         |         ^~~~~~~
>   hw/display/tcx.c: In function =E2=80=98tcx_dac_readl=E2=80=99:
>   hw/display/tcx.c:412:22: error: this statement may fall through [-Werro=
r=3Dimplicit-fallthrough=3D]
>     412 |         s->dac_index =3D (s->dac_index + 1) & 0xff; /* Index au=
toincrement */
>         |         ~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~
>   hw/display/tcx.c:413:5: note: here
>     413 |     default:
>         |     ^~~~~~~
>   cc1: all warnings being treated as errors
>
> Give a hint to GCC by adding the missing fall through comments.
>
> Fixes: 55d7bfe22
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> ---
> v2: Reword the description (Aleksandar)
>

Reviewed-by: Aleksandar Markovic <amarkovic@wavecomp.com>

> Cc: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
> Cc: Olivier Danet <odanet@caramail.com>
> Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> ---
>  hw/display/tcx.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/hw/display/tcx.c b/hw/display/tcx.c
> index 14e829d3fa..abbeb30284 100644
> --- a/hw/display/tcx.c
> +++ b/hw/display/tcx.c
> @@ -410,6 +410,7 @@ static uint64_t tcx_dac_readl(void *opaque, hwaddr ad=
dr,
>      case 2:
>          val =3D s->b[s->dac_index] << 24;
>          s->dac_index =3D (s->dac_index + 1) & 0xff; /* Index autoincreme=
nt */
> +        /* fall through */
>      default:
>          s->dac_state =3D 0;
>          break;
> @@ -451,6 +452,7 @@ static void tcx_dac_writel(void *opaque, hwaddr addr,=
 uint64_t val,
>              s->b[index] =3D val >> 24;
>              update_palette_entries(s, index, index + 1);
>              s->dac_index =3D (s->dac_index + 1) & 0xff; /* Index autoinc=
rement */
> +            /* fall through */
>          default:
>              s->dac_state =3D 0;
>              break;
> --
> 2.21.0
>

