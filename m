Return-Path: <SRS0=Ajie=DP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58E38C43467
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Oct 2020 11:06:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 86D9F215A4
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Oct 2020 11:06:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="u1sD84H/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 86D9F215A4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46692 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQTkp-0006Jo-Gg
	for qemu-devel@archiver.kernel.org; Thu, 08 Oct 2020 07:06:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43840)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kQTjp-0005i1-7z
 for qemu-devel@nongnu.org; Thu, 08 Oct 2020 07:05:33 -0400
Received: from mail-ej1-x641.google.com ([2a00:1450:4864:20::641]:39045)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kQTjl-0001rW-Sn
 for qemu-devel@nongnu.org; Thu, 08 Oct 2020 07:05:32 -0400
Received: by mail-ej1-x641.google.com with SMTP id lw21so7492053ejb.6
 for <qemu-devel@nongnu.org>; Thu, 08 Oct 2020 04:05:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=G4MqhLqpjMcTPLUEHu+e5WavH2k49KYPVDzsHyniNXI=;
 b=u1sD84H/Td+ncJk3VHEhOQbsgvpquiGKHv7UPQTcbhDXN74GY8CysqTNVhkLQ/Ig/4
 Ty02vHI4ql7AXY7x3HMbYLMAMR2ZVeRlLuvrcSUzaKkbqY9JsOoD8maapGklfGxdeECV
 ER+k3Oudwf8VjpzqQ2WFkaueLanztSjxH6BpimJGcDM5yHfpR4JB6K5xl9ieJSRjqElH
 MM28H5h3H//vPoVgu2v3VIVhkEWCP4YccuhiJ0U91WapWAneqJwLAw4xg8gpnHdniHsP
 eJkT12nJNhgOySkcmSjsN+9/GzK/zgQwM9/BWE5HHyn48OuSvTaQ35vAMlf5ee223pX6
 NAXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=G4MqhLqpjMcTPLUEHu+e5WavH2k49KYPVDzsHyniNXI=;
 b=QD+b247kx5Fvaq8gVN+IvG1G6e+AgJg0uxSr1JYgC9QQZNQDrzm0RJbmgx+ou4PwLh
 F8xAiGsgV2gqSgInOFN6L/1g3Hkn8aS5+tOgUTH9HzJmnwYnLQLURvn7cPUoYe9VZPtR
 IT+OjE3R1zx6tLZuNfwMn9K78CXSvHjj/QHFMPDbMPTAlNtJYoXeku29wG33q7Ld6Qdk
 DMHpWTA8vNQo2caO+YQYopyE74CtsCfglfdLPBluDQl+FqtJgNpV579ZRYyy1x0BCJcB
 +IlWQmW9gwmq41bR6XEec0F/26y8YzHw+J7XqYcgJJXwGU+Ggz7y19ToOz3+jA2cSd/r
 jFqw==
X-Gm-Message-State: AOAM5307AQo5gf05mEZTKjzw8SDetdSNFv0pyARKuL/lIw0rD3VRWTTB
 LsNi1TTjZOOflDfYPoQybHn8/jr1DbmMuoEnINptOA==
X-Google-Smtp-Source: ABdhPJygOkRHPzzCYx16qklrexgJa+piwJ2IhPnbM096E/hNH5HECV7YzYWZRU/ofeqijz6iXMpQIqScfnAoFlx3zVk=
X-Received: by 2002:a17:906:ce21:: with SMTP id
 sd1mr8354395ejb.4.1602155127018; 
 Thu, 08 Oct 2020 04:05:27 -0700 (PDT)
MIME-Version: 1.0
References: <20201002181032.1899463-1-f4bug@amsat.org>
In-Reply-To: <20201002181032.1899463-1-f4bug@amsat.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 8 Oct 2020 12:05:15 +0100
Message-ID: <CAFEAcA__ibwCfP72qQch9ahmQAo07i-yTzTPbK60H5H0Trubtg@mail.gmail.com>
Subject: Re: [PATCH] hw/char/bcm2835_aux: Allow less than 32-bit accesses
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::641;
 envelope-from=peter.maydell@linaro.org; helo=mail-ej1-x641.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Cc: Luc Michel <luc@lmichel.fr>, "Michael S . Tsirkin" <mst@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Andrew Baumann <Andrew.Baumann@microsoft.com>,
 Paul Zimmerman <pauldzim@gmail.com>, qemu-arm <qemu-arm@nongnu.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 2 Oct 2020 at 19:10, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org> =
wrote:
>
> The "BCM2835 ARM Peripherals" datasheet [*] chapter 2
> ("Auxiliaries: UART1 & SPI1, SPI2"), list the register
> sizes as 3/8/16/32 bits. We assume this means this
> peripheral allows 8-bit accesses.
>
> This was not an issue until commit 5d971f9e67 which reverted
> ("memory: accept mismatching sizes in memory_region_access_valid").
>
> The model is implemented as 32-bit accesses (see commit 97398d900c,
> all registers are 32-bit) so replace MemoryRegionOps.valid as
> MemoryRegionOps.impl, and re-introduce MemoryRegionOps.valid
> with a 8/32-bit range.
>
> [*] https://www.raspberrypi.org/app/uploads/2012/02/BCM2835-ARM-Periphera=
ls.pdf
>
> Fixes: 97398d900c ("bcm2835_aux: add emulation of BCM2835 AUX (aka UART1)=
 block")
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> ---
> Noticed while running Trusted Firmware-A on the raspi3:
> https://www.mail-archive.com/qemu-devel@nongnu.org/msg680115.html
> ---
>  hw/char/bcm2835_aux.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/hw/char/bcm2835_aux.c b/hw/char/bcm2835_aux.c
> index ee3dd40e3c..dade2ab5fd 100644
> --- a/hw/char/bcm2835_aux.c
> +++ b/hw/char/bcm2835_aux.c
> @@ -249,7 +249,9 @@ static const MemoryRegionOps bcm2835_aux_ops =3D {
>      .read =3D bcm2835_aux_read,
>      .write =3D bcm2835_aux_write,
>      .endianness =3D DEVICE_NATIVE_ENDIAN,
> -    .valid.min_access_size =3D 4,
> +    .impl.min_access_size =3D 4,
> +    .impl.max_access_size =3D 4,
> +    .valid.min_access_size =3D 1,
>      .valid.max_access_size =3D 4,
>  };

We don't seem to document the exact semantics you get for
a write with a size smaller than the impl.min_access_size.
Looking at the implementation in softmmu/memory.c, the
answer seems to be "it's turned into a write at the larger
size where the other bits in the write are zeroes".
Those semantics seem OK for this device (though there are
devices where they would not be, I suspect).
(The other plausible implementation would have been
"we do a read-modify-write sequence", which would not be
OK for this device, since it has some "device state changes
on read" registers like AUX_MU_IO_REG.)

We should probably clarify the comments in the MemoryRegionOps
struct to nail down the behaviour when the .impl constraints
are tighter than the .valid ones, but for this patch:

Applied to target-arm.next, thanks.

-- PMM

