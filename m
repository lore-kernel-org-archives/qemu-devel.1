Return-Path: <SRS0=Ouwy=U3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 111B5C4321A
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2019 17:28:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D30DC2086D
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2019 17:28:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eZ33s0e5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D30DC2086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34750 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hgugE-00047o-3K
	for qemu-devel@archiver.kernel.org; Fri, 28 Jun 2019 13:28:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38734)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <alistair23@gmail.com>) id 1hgtbi-00055Z-4l
 for qemu-devel@nongnu.org; Fri, 28 Jun 2019 12:20:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alistair23@gmail.com>) id 1hgtbf-0006ng-BO
 for qemu-devel@nongnu.org; Fri, 28 Jun 2019 12:20:13 -0400
Received: from mail-lf1-x144.google.com ([2a00:1450:4864:20::144]:45468)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alistair23@gmail.com>)
 id 1hgtbd-0006jx-F8; Fri, 28 Jun 2019 12:20:10 -0400
Received: by mail-lf1-x144.google.com with SMTP id u10so4308068lfm.12;
 Fri, 28 Jun 2019 09:20:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=3L0a++vJ0Hqer90XeUWUES0yvyyu/FiXM74eh2UIIoI=;
 b=eZ33s0e5VPYr9AeHkc2UPccaxXwH66fbBuRzmTs4VdNNYW7vFlS38Y7iSofZ460S0R
 CXVYr3PPa2k292W0YcYFxyTX//3K/TajpyQtDTHBN67noB0hO2qVM8xs8g6/X7C5UsoE
 TBfAiPEpDIhVXn1XCEmQzTivZ+OAuAdfZmPhHeGbfW7q7al7LTv9Wz59z9WxeHBwKcIF
 iJnRzv6FOyh7M9zfxnqEsHgzxAXZqgEqPlrOnMjuvuxyTpgbo+ZII+azI6C78uwYVgnN
 OUxk+oa1N7F453l6yLgvmkaywlq+u6qhknrxizVDR9vFNM5xC+xB6ssbdaN0k4qtJYGr
 xOKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=3L0a++vJ0Hqer90XeUWUES0yvyyu/FiXM74eh2UIIoI=;
 b=JTt4De7n0vZMU22ww6KvHPQDvsJuKqAUsSnrrmmKgW00hEbJ7VKY+kJJ1kDD/D3fKn
 hjPba6kxwYoD7YxogvSD0NQZV/cKTSAw2ct1rZUn4El/YUE/cRiSS9DICoLlANkAG9TE
 7ujpAVyChbguZrGRacsU1p+bYqBzQH/OCmMYfry17aOg+eWkj5CYgH3BzB80RqSCsnaU
 mtU8hGvgQnrlR951o2DKpwjIL5LMOkfyFHBXnQ/YF8oLgAJsBm6Cqf6wstMvXQ9pLqGh
 ErO2TA28jbSGJYYROBrjGsZVcqFX7+3Cq56N0MSyzyRI9YvBvbYctOj3SQcTQ5qjH4NY
 B9Zg==
X-Gm-Message-State: APjAAAWswCNE29dcdZTG/hUC3ttIzJCxlo9wdiGuMUXHnqs6ff5snLKc
 u9lg90/DQhVhRIsMG283nSsFtii6alo2cY1AoTQ=
X-Google-Smtp-Source: APXvYqx22sgpTlr3scbGHhOFgnltQylPTT0iKg2Wdn5d+JfP7uEkZ6dhksxCYs/362ZvkMn4f33iepD9lRtTcdWpYJs=
X-Received: by 2002:a05:6512:29a:: with SMTP id
 j26mr5302424lfp.44.1561738806501; 
 Fri, 28 Jun 2019 09:20:06 -0700 (PDT)
MIME-Version: 1.0
References: <20190627202719.17739-1-philmd@redhat.com>
 <20190627202719.17739-11-philmd@redhat.com>
In-Reply-To: <20190627202719.17739-11-philmd@redhat.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Fri, 28 Jun 2019 09:17:05 -0700
Message-ID: <CAKmqyKMk=bHg8KWvsfCoQwKp2Rk3z=rwoq0XDA42PLEeY-5m=A@mail.gmail.com>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::144
Subject: Re: [Qemu-devel] [PATCH v5 10/28] hw/block/pflash_cfi02: Extract
 the pflash_data_read() function
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
 Stephen Checkoway <stephen.checkoway@oberlin.edu>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Qemu-block <qemu-block@nongnu.org>, John Snow <jsnow@redhat.com>,
 Magnus Damm <magnus.damm@gmail.com>, Markus Armbruster <armbru@redhat.com>,
 Antony Pavlov <antonynpavlov@gmail.com>, Laurent Vivier <lvivier@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Alistair Francis <alistair@alistair23.me>,
 qemu-arm <qemu-arm@nongnu.org>, Jan Kiszka <jan.kiszka@web.de>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
 David Gibson <david@gibson.dropbear.id.au>, Kevin Wolf <kwolf@redhat.com>,
 Max Reitz <mreitz@redhat.com>, Michael Walle <michael@walle.cc>,
 "open list:New World" <qemu-ppc@nongnu.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Jun 27, 2019 at 1:46 PM Philippe Mathieu-Daud=C3=A9
<philmd@redhat.com> wrote:
>
> Extract the code block in a new function, remove a goto statement.
>
> Signed-off-by: Stephen Checkoway <stephen.checkoway@oberlin.edu>
> Message-Id: <20190426162624.55977-3-stephen.checkoway@oberlin.edu>
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> Tested-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> [PMD: Extracted from bigger patch, remove the XXX tracing comment]
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  hw/block/pflash_cfi02.c | 24 ++++++++++++++----------
>  1 file changed, 14 insertions(+), 10 deletions(-)
>
> diff --git a/hw/block/pflash_cfi02.c b/hw/block/pflash_cfi02.c
> index 49afecb921..c079a63880 100644
> --- a/hw/block/pflash_cfi02.c
> +++ b/hw/block/pflash_cfi02.c
> @@ -165,12 +165,23 @@ static void pflash_timer (void *opaque)
>      pfl->cmd =3D 0;
>  }
>
> +/*
> + * Read data from flash.
> + */
> +static uint64_t pflash_data_read(PFlashCFI02 *pfl, hwaddr offset,
> +                                 unsigned int width)
> +{
> +    uint8_t *p =3D (uint8_t *)pfl->storage + offset;
> +    uint64_t ret =3D pfl->be ? ldn_be_p(p, width) : ldn_le_p(p, width);
> +    trace_pflash_data_read(offset, width << 1, ret);
> +    return ret;
> +}
> +
>  static uint32_t pflash_read(PFlashCFI02 *pfl, hwaddr offset,
>                              int width, int be)
>  {
>      hwaddr boff;
>      uint32_t ret;
> -    uint8_t *p;
>
>      ret =3D -1;
>      /* Lazy reset to ROMD mode after a certain amount of read accesses *=
/
> @@ -194,15 +205,8 @@ static uint32_t pflash_read(PFlashCFI02 *pfl, hwaddr=
 offset,
>      case 0x80:
>          /* We accept reads during second unlock sequence... */
>      case 0x00:
> -    flash_read:
>          /* Flash area read */
> -        p =3D (uint8_t *)pfl->storage + offset;
> -        if (pfl->be) {
> -            ret =3D ldn_be_p(p, width);
> -        } else {
> -            ret =3D ldn_le_p(p, width);
> -        }
> -        trace_pflash_data_read(offset, width << 1, ret);
> +        ret =3D pflash_data_read(pfl, offset, width);
>          break;
>      case 0x90:
>          /* flash ID read */
> @@ -222,7 +226,7 @@ static uint32_t pflash_read(PFlashCFI02 *pfl, hwaddr =
offset,
>              }
>              /* Fall through to data read. */
>          default:
> -            goto flash_read;
> +            ret =3D pflash_data_read(pfl, offset, width);
>          }
>          DPRINTF("%s: ID " TARGET_FMT_plx " %" PRIx32 "\n", __func__, bof=
f, ret);
>          break;
> --
> 2.20.1
>
>

