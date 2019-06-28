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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D0E5C4321A
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2019 17:15:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DAE792083B
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2019 17:15:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aeBd1VWM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DAE792083B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34606 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hguTC-0002mN-5e
	for qemu-devel@archiver.kernel.org; Fri, 28 Jun 2019 13:15:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34632)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <alistair23@gmail.com>) id 1hgtLt-0002hJ-A5
 for qemu-devel@nongnu.org; Fri, 28 Jun 2019 12:03:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alistair23@gmail.com>) id 1hgtLr-0000CC-8H
 for qemu-devel@nongnu.org; Fri, 28 Jun 2019 12:03:53 -0400
Received: from mail-lf1-x142.google.com ([2a00:1450:4864:20::142]:39111)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alistair23@gmail.com>)
 id 1hgtLq-0000AV-Sn; Fri, 28 Jun 2019 12:03:51 -0400
Received: by mail-lf1-x142.google.com with SMTP id p24so4311048lfo.6;
 Fri, 28 Jun 2019 09:03:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=q/A8imL/rQ6JkX+BcIdTTu9BYmRWq+4XuVdbkIj/Z7A=;
 b=aeBd1VWM9zJn0b9vj2WGlw7ZTB5V9tNc9hpnTKXkvm/qPTA+UlP41mXfUXUa4pT7Sl
 RGQg5Wz47XVj0z7mHcBTYC3js35n0LWcBQq/U1dDwgrlr4mh+tkxNVFbEqJKYN2xJIxp
 D/6oBR8MX+KJoP+kzBKPVjbu3QPOpcC0eww9SV/VHcCxjNuCinVqCvUUXRkBEDGDPBbM
 ogl2DkASYjBc2qP+LJGpIBjjBaon5vXYYZDroScdfN5w4Ewtm35QvdqdUUFEM0oji+6g
 ublnxaE6sa2HF06yIIKjgFOW+8xgTKLGK2uoHYk7wn67xDn1N1pUgjt3JmT0E3F8E6hI
 K9WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=q/A8imL/rQ6JkX+BcIdTTu9BYmRWq+4XuVdbkIj/Z7A=;
 b=MLH2JfoTePb6dp6Tk6bJFncVJJXmzjy9Hq01S/OgqsdS+/Olx00k9TOuIEf/P4tCq8
 tUZGyImy7X01XqlVHMekxWkMfLqC8q2XhfRLIasKTPTdelfdgdIsvskB7pkeAZqohK0D
 7bAEtU5RcalpFTo4qZ0hql5sTBSPbiCTIOQTIU3sPn52OFJ8UauSJLikFmcOgi9CirRv
 aUMI2aE3mNVD++Z/Cf1ipAXRe74LUSPZVfa2DZQoCBU6nJop6RX1/ru/h5r6y9fNnnJw
 2kVN/h06toCIJ5O8TMUFFd2ftEE2JPHF6/FUju8auThWHFpDUFbDn7YjnKiyEoLlqikc
 N6Gw==
X-Gm-Message-State: APjAAAXKiqfVtm7VMjGUFL2yWC5bF8I9eXad+IP2KJpG425YZx3WQS7K
 VFoxXflNf2EWx3nDa0xJ2FmI8Kw19+z1y9tMB0A=
X-Google-Smtp-Source: APXvYqxT+pBVOrQOFOBkZPRiB0+6zS5qInYh7RIz4KFEPu7L21zEXrW4ns/q7eRdgC2z2zMKVPkzAhDbsDjNlqD/37M=
X-Received: by 2002:a19:710b:: with SMTP id m11mr5473352lfc.135.1561737828961; 
 Fri, 28 Jun 2019 09:03:48 -0700 (PDT)
MIME-Version: 1.0
References: <20190627202719.17739-1-philmd@redhat.com>
 <20190627202719.17739-7-philmd@redhat.com>
In-Reply-To: <20190627202719.17739-7-philmd@redhat.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Fri, 28 Jun 2019 09:00:48 -0700
Message-ID: <CAKmqyKMbV-42gMy8kja+Y36c-CDESLgQy8OgC=W=_gYWoACjuA@mail.gmail.com>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::142
Subject: Re: [Qemu-devel] [PATCH v5 06/28] hw/block/pflash_cfi02: Add
 helpers to manipulate the status bits
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

On Thu, Jun 27, 2019 at 1:49 PM Philippe Mathieu-Daud=C3=A9
<philmd@redhat.com> wrote:
>
> Pull out all of the code to modify the status into simple helper
> functions. Status handling becomes more complex once multiple
> chips are interleaved to produce a single device.
>
> No change in functionality is intended with this commit.
>
> Signed-off-by: Stephen Checkoway <stephen.checkoway@oberlin.edu>
> Message-Id: <20190426162624.55977-3-stephen.checkoway@oberlin.edu>
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> Tested-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> [PMD: Extracted from bigger patch]
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  hw/block/pflash_cfi02.c | 40 ++++++++++++++++++++++++++++++++++------
>  1 file changed, 34 insertions(+), 6 deletions(-)
>
> diff --git a/hw/block/pflash_cfi02.c b/hw/block/pflash_cfi02.c
> index 303d225f23..e9eea0ec08 100644
> --- a/hw/block/pflash_cfi02.c
> +++ b/hw/block/pflash_cfi02.c
> @@ -101,6 +101,31 @@ struct PFlashCFI02 {
>      void *storage;
>  };
>
> +/*
> + * Toggle status bit DQ7.
> + */
> +static inline void toggle_dq7(PFlashCFI02 *pfl)
> +{
> +    pfl->status ^=3D 0x80;
> +}
> +
> +/*
> + * Set status bit DQ7 to bit 7 of value.
> + */
> +static inline void set_dq7(PFlashCFI02 *pfl, uint8_t value)
> +{
> +    pfl->status &=3D 0x7F;
> +    pfl->status |=3D value & 0x80;
> +}
> +
> +/*
> + * Toggle status bit DQ6.
> + */
> +static inline void toggle_dq6(PFlashCFI02 *pfl)
> +{
> +    pfl->status ^=3D 0x40;
> +}
> +
>  /*
>   * Set up replicated mappings of the same region.
>   */
> @@ -130,7 +155,7 @@ static void pflash_timer (void *opaque)
>
>      trace_pflash_timer_expired(pfl->cmd);
>      /* Reset flash */
> -    pfl->status ^=3D 0x80;
> +    toggle_dq7(pfl);
>      if (pfl->bypass) {
>          pfl->wcycle =3D 2;
>      } else {
> @@ -229,8 +254,7 @@ static uint32_t pflash_read(PFlashCFI02 *pfl, hwaddr =
offset,
>          /* Status register read */
>          ret =3D pfl->status;
>          DPRINTF("%s: status %" PRIx32 "\n", __func__, ret);
> -        /* Toggle bit 6 */
> -        pfl->status ^=3D 0x40;
> +        toggle_dq6(pfl);
>          break;
>      case 0x98:
>          /* CFI query mode */
> @@ -374,7 +398,11 @@ static void pflash_write(PFlashCFI02 *pfl, hwaddr of=
fset,
>                      break;
>                  }
>              }
> -            pfl->status =3D 0x00 | ~(value & 0x80);
> +            /*
> +             * While programming, status bit DQ7 should hold the opposit=
e
> +             * value from how it was programmed.
> +             */
> +            set_dq7(pfl, ~value);
>              /* Let's pretend write is immediate */
>              if (pfl->bypass)
>                  goto do_bypass;
> @@ -422,7 +450,7 @@ static void pflash_write(PFlashCFI02 *pfl, hwaddr off=
set,
>                  memset(pfl->storage, 0xFF, pfl->chip_len);
>                  pflash_update(pfl, 0, pfl->chip_len);
>              }
> -            pfl->status =3D 0x00;
> +            set_dq7(pfl, 0x00);
>              /* Let's wait 5 seconds before chip erase is done */
>              timer_mod(&pfl->timer, qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL)=
 +
>                        (NANOSECONDS_PER_SECOND * 5));
> @@ -437,7 +465,7 @@ static void pflash_write(PFlashCFI02 *pfl, hwaddr off=
set,
>                  memset(p + offset, 0xFF, pfl->sector_len);
>                  pflash_update(pfl, offset, pfl->sector_len);
>              }
> -            pfl->status =3D 0x00;
> +            set_dq7(pfl, 0x00);
>              /* Let's wait 1/2 second before sector erase is done */
>              timer_mod(&pfl->timer, qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL)=
 +
>                        (NANOSECONDS_PER_SECOND / 2));
> --
> 2.20.1
>
>

