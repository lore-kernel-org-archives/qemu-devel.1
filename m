Return-Path: <SRS0=3KIA=4V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58F30C3F2CD
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Mar 2020 10:36:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2597120705
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Mar 2020 10:36:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="G3vgWfQf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2597120705
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60558 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j9RO2-0001og-1p
	for qemu-devel@archiver.kernel.org; Wed, 04 Mar 2020 05:36:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:53987)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1j9RNP-0001Ag-IC
 for qemu-devel@nongnu.org; Wed, 04 Mar 2020 05:35:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1j9RNO-00072K-8w
 for qemu-devel@nongnu.org; Wed, 04 Mar 2020 05:35:43 -0500
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:33021)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1j9RNN-00071u-UC
 for qemu-devel@nongnu.org; Wed, 04 Mar 2020 05:35:42 -0500
Received: by mail-wr1-x443.google.com with SMTP id x7so1765134wrr.0
 for <qemu-devel@nongnu.org>; Wed, 04 Mar 2020 02:35:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=hCiO3x1uR4xY3AOdgZ323cvKo3x40Pp8fN8MJzXH5nM=;
 b=G3vgWfQfJLnpYECqxMdfQ4NFbIO7lr37jrOESbddJ24k3Yu1i/I4sKVRH5oO5YjF0c
 +GDGcA6G7UFf+EeWxrqOHGxE4F3kBoAvgSCxSaberZp1MjfX/NQlMOBA4/s9jsD1C/UI
 0tEOTqkpuhplUQvL231Kmb7u/vS3DtjwEDYC72GaGN2nqPlMRyHFusCYEpWRhnfYdN4H
 BWulVUqFDOoF0pgaaF0Y5IJRHXWgxF0N9KWK6fWPF3W1hVEd7x7auEjc9Xgl1ARmpWyR
 OtNpO/4aMOIDNq+iXZjh57RDXmuEhreXINZZGhwN0wtU3Smykcv0Rrbuw5OikHfHhbyd
 5YEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=hCiO3x1uR4xY3AOdgZ323cvKo3x40Pp8fN8MJzXH5nM=;
 b=ILRi3qOFTSml0pMrngHl9FaZ8dUbj6LVYM2xIhlknZcl2Uidon2vOasNvv1q/ZEaIk
 Ymie5nWvJNbi4yMFAJ2MJ46J5f8tBNevEbPZz9jN05xp054q2cUizxOVL7R3FgCB0YTJ
 TKml/6sYtCGVkl/gQy/LSPj551dQZ1WkN8cCK5uYkisbB7HvfBzWKXZTfF2EXYUD1lpG
 f8L6JtVRIyOL6ERYwwPDpgw2csqhnFa8iQbyL/6r/eF/+JI49Y+SCeuAtPoNaLoDNVUd
 avRgVgCxqhHGOF08pVeeWz5jATFi3WX+UdwAHIj5rwC9ie8oPqCF01nvhUp8MvjVA0d7
 QexA==
X-Gm-Message-State: ANhLgQ2N0uoe6/RJwwT7T1RFMIT4eYRL81+/vUpqj5YCKmQuyu4SYIhW
 RyHWgZbGIIayEk/PP8QcRX5qBQ==
X-Google-Smtp-Source: ADFU+vs/Nx9V7Pm6tgYDyAlKAGFmVABQryMnScNTAn/Xb8+Vh9XfsYNIpS5qWuD0P6rti4GoCxIMyg==
X-Received: by 2002:adf:fc07:: with SMTP id i7mr3728153wrr.158.1583318139933; 
 Wed, 04 Mar 2020 02:35:39 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id n11sm28318380wrq.40.2020.03.04.02.35.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Mar 2020 02:35:38 -0800 (PST)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id BD2241FF87;
 Wed,  4 Mar 2020 10:35:36 +0000 (GMT)
References: <20200301215029.15196-1-nieklinnenbank@gmail.com>
 <20200301215029.15196-19-nieklinnenbank@gmail.com>
User-agent: mu4e 1.3.9; emacs 27.0.90
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Niek Linnenbank <nieklinnenbank@gmail.com>
Subject: Re: [PATCH v6 18/18] docs: add Orange Pi PC document
In-reply-to: <20200301215029.15196-19-nieklinnenbank@gmail.com>
Date: Wed, 04 Mar 2020 10:35:36 +0000
Message-ID: <871rq876h3.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::443
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
Cc: peter.maydell@linaro.org, jasowang@redhat.com, qemu-devel@nongnu.org,
 b.galvani@gmail.com, qemu-arm@nongnu.org, imammedo@redhat.com,
 philmd@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Niek Linnenbank <nieklinnenbank@gmail.com> writes:

> The Xunlong Orange Pi PC machine is a functional ARM machine
> based on the Allwinner H3 System-on-Chip. It supports mainline
> Linux, U-Boot, NetBSD and is covered by acceptance tests.
>
> This commit adds a documentation text file with a description
> of the machine and instructions for the user.

This is great, thanks for taking the time to include documentation.

>
> Signed-off-by: Niek Linnenbank <nieklinnenbank@gmail.com>
> ---
>  docs/orangepi.rst | 226
> ++++++++++++++++++++++++++++++++++++++++++++++

I suspect there is a better place to put this is than the top level. I
wonder if it should be docs/specs?

>  MAINTAINERS       |   1 +
>  2 files changed, 227 insertions(+)
>  create mode 100644 docs/orangepi.rst
>
> diff --git a/docs/orangepi.rst b/docs/orangepi.rst
> new file mode 100644
> index 0000000000..a9b46f553c
> --- /dev/null
> +++ b/docs/orangepi.rst
> @@ -0,0 +1,226 @@
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
> +Orange Pi PC Machine Type
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
> +
> +The Xunlong Orange Pi PC is an Allwinner H3 System on Chip
> +based embedded computer with mainline support in both U-Boot
> +and Linux. The board comes with a Quad Core Cortex A7 @ 1.3GHz,
> +1GiB RAM, 100Mbit ethernet, USB, SD/MMC, USB, HDMI and
> +various other I/O.

When Peter's document PR goes in later this week there will also be a:

  docs/system/target-arm.rst

which would benefit from a section for the Orange Pi in it.

> +
> +Supported devices
> +-----------------
> +
> +The Orange Pi PC machine supports the following devices:
> +
> + * SMP (Quad Core Cortex A7)
> + * Generic Interrupt Controller configuration
> + * SRAM mappings
> + * SDRAM controller
> + * Real Time Clock
> + * Timer device (re-used from Allwinner A10)
> + * UART
> + * SD/MMC storage controller
> + * EMAC ethernet

Do we ever exercise the ethernet in the acceptance tests? I see we have
some that boots a full OS but boot console only seems to touch the
serial console.

<snip>

--=20
Alex Benn=C3=A9e

