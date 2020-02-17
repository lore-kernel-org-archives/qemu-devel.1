Return-Path: <SRS0=CnYV=4F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A44BC35254
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2020 11:28:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 66768207FD
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2020 11:28:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OWlPY6LX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 66768207FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43864 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j3eZy-0005Lp-JS
	for qemu-devel@archiver.kernel.org; Mon, 17 Feb 2020 06:28:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38840)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1j3eZM-0004iD-8E
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 06:28:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1j3eZK-0002PV-VY
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 06:28:07 -0500
Received: from mail-oi1-x243.google.com ([2607:f8b0:4864:20::243]:36841)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1j3eZK-0002On-PN
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 06:28:06 -0500
Received: by mail-oi1-x243.google.com with SMTP id c16so16369305oic.3
 for <qemu-devel@nongnu.org>; Mon, 17 Feb 2020 03:28:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=P6A4CuPNh5DrmAV95Z4jahk8OrH+S9Dcprv7wSv2qqM=;
 b=OWlPY6LXd7WCTA1HpliAtBFKIi27s46D/y8xB63R01SH64dqFQ7lQsEXqL4H7b/baD
 2se5BgQH7KcGdFC73D6Nm0OrJVDzQjGTsuvt7FbzVMlsZO3EBOjY87SlkxS0odm6joq0
 dA5k3U6fy4OeMoB6rSNC7sqMxibmG/HQAdbYVQEth9p2ZFt8U+hCp29yicwyvkyRMNpa
 ung0trd3Cxt7mldRuMhxa/CxH2VVClisjHC7rG0y5Vzs08lNvvCfdNQwwbnKnZtkmTlR
 l/Wv3ZVgBfIGEVEsIqgDh/H1eoFO1xVCFhRyHsxDvN/PN2Mhsb2f94HZVh0+bg4w16DV
 PtQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=P6A4CuPNh5DrmAV95Z4jahk8OrH+S9Dcprv7wSv2qqM=;
 b=Td5ELoK7+G/Ah9jFfrLku0Ro2s9ZByZ+lqo80dDUSQiE70lR3Oi3UjITMmTnbM7Gh1
 EvM813LOfbDkZCKb3CNg7Vm43fjlIv/3neMaVZJG1XDVPKE45Dicq/hJGeUGpku7KfwL
 426cbA/uLe95fUL2PqdDvA/6pYQbDXBHGpfVcF7oeqCI8Gzd1n3su4+snVz+SMgQ6kVH
 YSEOCu5mNkfsJBh0vKp62MYyB5IyOUUpLLr0TU9UUxl3PmvXZhn8EpLqptasn9DzUyp1
 o6VPVRl2V/r9ggr2SfWuOpTby9Er9wBRPsbM2wNVf43FJkeaovq1Sw2Yf7HkNz3NQ6dn
 B1PA==
X-Gm-Message-State: APjAAAVIVDXkM/KY9P4j+xREUSPx+cUVSWrwMeincXcehkj2oU6GnsMo
 SqvRxNTKnbBE4zVO9kIS4scpp4UDIJtgH90FmXP2xA==
X-Google-Smtp-Source: APXvYqyK0RNvylgVxJGQe5rEpUHQvrz0PP1FsJFfOaNGZCE3zoNADlnhBDt5ZqqKQDJ0ndCAoweijfJdMUuYauIeM14=
X-Received: by 2002:aca:3d7:: with SMTP id 206mr9747324oid.98.1581938885747;
 Mon, 17 Feb 2020 03:28:05 -0800 (PST)
MIME-Version: 1.0
References: <20200217105657.31506-1-f4bug@amsat.org>
In-Reply-To: <20200217105657.31506-1-f4bug@amsat.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 17 Feb 2020 11:27:54 +0000
Message-ID: <CAFEAcA8AT2YE0kzWjRmR1ZsSFxH7bs1t_G8Bs+J-QsCzMXPg3w@mail.gmail.com>
Subject: Re: [PATCH v2] hw/misc/iotkit-secctl: Fix writing to 'PPC Interrupt
 Clear' register
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::243
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

On Mon, 17 Feb 2020 at 10:57, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>=
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
> v2: Corrected bitwise-not precedence (pm215)
> ---
>  hw/misc/iotkit-secctl.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/hw/misc/iotkit-secctl.c b/hw/misc/iotkit-secctl.c
> index 609869821a..43cf0f9970 100644
> --- a/hw/misc/iotkit-secctl.c
> +++ b/hw/misc/iotkit-secctl.c
> @@ -340,7 +340,7 @@ static MemTxResult iotkit_secctl_s_write(void *opaque=
, hwaddr addr,
>          qemu_set_irq(s->sec_resp_cfg, s->secrespcfg);
>          break;
>      case A_SECPPCINTCLR:
> -        value &=3D 0x00f000f3;
> +        s->secppcintstat =3D ~(value & 0x00f000f3);

Should be &=3D, not =3D. Otherwise you set all the other
bits in the register.

thanks
-- PMM

