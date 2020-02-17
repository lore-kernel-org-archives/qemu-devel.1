Return-Path: <SRS0=CnYV=4F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D7FCC35254
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2020 10:23:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1365120702
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2020 10:23:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Cn/w2X8L"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1365120702
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43198 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j3dYv-0001VN-5M
	for qemu-devel@archiver.kernel.org; Mon, 17 Feb 2020 05:23:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59296)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1j3dYE-0000x9-DA
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 05:22:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1j3dYD-0007dS-Aq
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 05:22:54 -0500
Received: from mail-oi1-x242.google.com ([2607:f8b0:4864:20::242]:37834)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1j3dYD-0007cs-5G
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 05:22:53 -0500
Received: by mail-oi1-x242.google.com with SMTP id q84so16201768oic.4
 for <qemu-devel@nongnu.org>; Mon, 17 Feb 2020 02:22:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=I6pZiQYKw5bllwTSpCcY4oy/Qpa5ymGvSq6XhrO1I8E=;
 b=Cn/w2X8LK+eUuGcaKEJnmpUVYtIoe4M2Tb3U7GBngu4QBBg7kItnO+XMp9HA1F8iKE
 yR5nzk4Sr8nBk+5dCIEwhgWAmo70sAN7I1L981vrRHLg18M9yUS5BAuLqUELurlw9NaO
 4Cw9mIetxYbmdb0WZO3MM4bojmTTTPs/rfVBbGipzZlrmfGTTjatrv7BvgpRIq2VclIR
 2+tRWtnZPknSirR01eCTOQ38aa5SMnz9Uhx2I2oCBuhPWgvK05ffOI9jqJTNOWfl+2UK
 x3ibOh3DSuq+Nrphfh6kGKyXNZ7o5J4BYmartzSfUjDNkZ0ZxFTEM3WrQUOOsbk6EL1X
 aX+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=I6pZiQYKw5bllwTSpCcY4oy/Qpa5ymGvSq6XhrO1I8E=;
 b=YpmYzr5UA/AqnjnXSKz0pSzIBGFLO+O+V7RZcS0IMlWX5lHAm7OwmF5TPd2C2wKgk8
 p3F0DM2G8MvB0/0bLjysQvwSiCk+4FSD/HG1bsXq4VVkv7jikg1gvQQz5wosiayI1YP1
 0C2VDHiXPLLSAnkPqPGAloWVI2V4D3dh+jqIhRQes8o76Ur4ZCI/2rZY/97NRFK04ojE
 sGmYW2URODXqeywWemIY0IEYtkoXGKC5AIGhqOgINLQZghy7zEc5Cbrm0dZf/FGLraU2
 /o9/DZl9iVi7hW8lH25PPSy/AIhHkcQY2MhLRGDh5Xahp08PIDt2AJQseOsCS5ORe1f7
 PqMg==
X-Gm-Message-State: APjAAAVDbXOfxhn8G57n0L5NzhMhIWNR+sl9h592EwmSIqUqB53E3pU0
 YpueFeCnbDD/MWZ3k86YCVunzP7ieUEUtczTgyY9CQ==
X-Google-Smtp-Source: APXvYqwhYClzBMhfxicBWdGSPN28uBA7OZ7b3YYi5Ll/vZvmJHgdFW40QZV7Ru4/NdzgzJOvpUxLyk44KYf4ddia4Ro=
X-Received: by 2002:a54:4f16:: with SMTP id e22mr9754321oiy.170.1581934972203; 
 Mon, 17 Feb 2020 02:22:52 -0800 (PST)
MIME-Version: 1.0
References: <20200215161923.4741-1-f4bug@amsat.org>
In-Reply-To: <20200215161923.4741-1-f4bug@amsat.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 17 Feb 2020 10:22:41 +0000
Message-ID: <CAFEAcA8SLR5YXWYiS_GXOBhHAxR2QKut_BGVzNeamw_1xtifLA@mail.gmail.com>
Subject: Re: [PATCH] hw/misc/iotkit-secctl: Fix writing to 'PPC Interrupt
 Clear' register
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::242
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
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sat, 15 Feb 2020 at 16:19, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>=
 wrote:
>
> Fix warning reported by Clang static code analyzer:
>
>     CC      hw/misc/iotkit-secctl.o
>   hw/misc/iotkit-secctl.c:343:9: warning: Value stored to 'value' is neve=
r read
>           value &=3D 0x00f000f3;
>           ^        ~~~~~~~~~~
>
> Fixes: b3717c23e1c
> Reported-by: Clang Static Analyzer
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> ---
>  hw/misc/iotkit-secctl.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/hw/misc/iotkit-secctl.c b/hw/misc/iotkit-secctl.c
> index 609869821a..0d5556dd17 100644
> --- a/hw/misc/iotkit-secctl.c
> +++ b/hw/misc/iotkit-secctl.c
> @@ -340,7 +340,7 @@ static MemTxResult iotkit_secctl_s_write(void *opaque=
, hwaddr addr,
>          qemu_set_irq(s->sec_resp_cfg, s->secrespcfg);
>          break;
>      case A_SECPPCINTCLR:
> -        value &=3D 0x00f000f3;
> +        s->secppcintstat =3D ~value & 0x00f000f3;

This is (obviously) a bug, but I don't think your fix is right.
This register has bits which are write-one-to-clear,
(plus some other bits that are reserved and RAZ/WI)
so we want:
  s->secppcintstat &=3D ~(value & 0x00f000f3);

(In particular bitwise-not has higher precedence than
bitwise-and, so your expression will end up writing zero
to s->specppcintstat for any valid guest write.)

My guess is that when I originally wrote the code I meant
to write something like
   value &=3D 0x00f000f3;
   s->secppcintstat &=3D ~value;
and forgot the second line.

thanks
-- PMM

