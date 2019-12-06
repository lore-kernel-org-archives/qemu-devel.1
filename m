Return-Path: <SRS0=8N/K=Z4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59EECC43603
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Dec 2019 16:40:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 23D042173E
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Dec 2019 16:40:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="eOKamfZl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 23D042173E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41040 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1idGeo-0002MI-Uf
	for qemu-devel@archiver.kernel.org; Fri, 06 Dec 2019 11:40:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:32910)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1idFd9-0004Ru-Ou
 for qemu-devel@nongnu.org; Fri, 06 Dec 2019 10:34:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1idFd8-00054G-FN
 for qemu-devel@nongnu.org; Fri, 06 Dec 2019 10:34:55 -0500
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342]:33341)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1idFd8-00052O-9X
 for qemu-devel@nongnu.org; Fri, 06 Dec 2019 10:34:54 -0500
Received: by mail-ot1-x342.google.com with SMTP id d17so6168332otc.0
 for <qemu-devel@nongnu.org>; Fri, 06 Dec 2019 07:34:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=RPcSIYISFBGo154XUSTQYSxMjNsNm7pj3byN7uYuvPg=;
 b=eOKamfZlDixU8QGd/iqSOaHV9oe5RhQvoLa/8FzX30/1VJkuC4apnoGlH37gw+SGQF
 brGOKNS1YYtxM5vIx72h/OLYOQVHwYypPHyq5eLetOoA80+MGcevGo0qCh/RpHyUayfW
 Je3OgdtMjvrtsh7fxbl4MgQIgnHvAkP9Hu8G3xPp7A0Pm4Jrlw1r/Gya+tnCOtSxSnIp
 WmRRLvjCrtu8fvfYCrNuR59xORsKxHEtGYE7PxtUFcThIxodq+Q9shEcLGmOZTGQvAzx
 K733qXbsjSjX++qb5Qm4BdZCZBweDl8vtk7B8DUrXF5LhAwG7jDyVaSWirIpe/KRC/L3
 WVpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=RPcSIYISFBGo154XUSTQYSxMjNsNm7pj3byN7uYuvPg=;
 b=JriZUYQT+C/Oe1S5srGhmsp9ITcLOonVUEupH9Ml/bd3trMnfqGjIKCpYNKE1Nlrbd
 6rhWbS3XkQO7w5DdFKhWQzp9szz0+u3lQL/dC0sKWOrmSFq0iEQDktzJp4Bu27OsIZoV
 Qq+MLEOku8IsWaZ7bS7d+KGLHg0ntWXa7G/sVW0i0Njhi4S2HvD80wQIynoATCHm0E0/
 /3bSCQkfF3ur6Cq4b4ziFEyg15gq6yJQoeeDjXvA7CFZF/RHKrBYpz8D1S6xtRxdH7aP
 ts3okcSGyT5QXl+y5+PJjVAI7s+8G0XTx8j1bD2w8JdYwpj2AzYsovh/jWnlHZkwOfJd
 s1CQ==
X-Gm-Message-State: APjAAAUAJYskSGwiu7gTJqOQCEPvgY7cRqngi3lri1jwgXYcDHmQIUyo
 kTk+wY+7VUIIE/ygPyJJTuD5a+sIRngNoYhXyw33lg==
X-Google-Smtp-Source: APXvYqyVrekgGkxjL1TN6VssP2gTgQswzzmUxmbtGP6t+Wr62x9E8SVQ1mvqOeAra1HWBumsmlrbCTD6yIzlsW/q/q0=
X-Received: by 2002:a05:6830:4a4:: with SMTP id
 l4mr5490552otd.91.1575646493249; 
 Fri, 06 Dec 2019 07:34:53 -0800 (PST)
MIME-Version: 1.0
References: <20191206072257.7221-1-philmd@redhat.com>
In-Reply-To: <20191206072257.7221-1-philmd@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 6 Dec 2019 15:34:42 +0000
Message-ID: <CAFEAcA-n=RKviDr9h+hCdwETN-Et5+A--v+HU_DuwqCQ2BWdDA@mail.gmail.com>
Subject: Re: [PATCH-for-5.0] hw/arm/sbsa-ref: Call qdev_get_gpio_in in place
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::342
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
Cc: Radoslaw Biernacki <radoslaw.biernacki@linaro.org>,
 qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>,
 Leif Lindholm <leif.lindholm@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 6 Dec 2019 at 07:23, Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com=
> wrote:
>
> Instead of filling an array of qemu_irq and passing it around,
> directly call qdev_get_gpio_in() on the GIC.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> ---
> I accept better patch subject suggestions :)
> ---
>  hw/arm/sbsa-ref.c | 58 +++++++++++++++++++++++------------------------
>  1 file changed, 29 insertions(+), 29 deletions(-)
>
> diff --git a/hw/arm/sbsa-ref.c b/hw/arm/sbsa-ref.c
> index 27046cc284..30cb647551 100644
> --- a/hw/arm/sbsa-ref.c
> +++ b/hw/arm/sbsa-ref.c
> @@ -328,7 +328,7 @@ static void create_secure_ram(SBSAMachineState *sms,
>      memory_region_add_subregion(secure_sysmem, base, secram);
>  }
>
> -static void create_gic(SBSAMachineState *sms, qemu_irq *pic)
> +static DeviceState *create_gic(SBSAMachineState *sms)
>  {
>      unsigned int smp_cpus =3D MACHINE(sms)->smp.cpus;
>      DeviceState *gicdev;
> @@ -403,12 +403,10 @@ static void create_gic(SBSAMachineState *sms, qemu_=
irq *pic)
>                             qdev_get_gpio_in(cpudev, ARM_CPU_VFIQ));
>      }
>
> -    for (i =3D 0; i < NUM_IRQS; i++) {
> -        pic[i] =3D qdev_get_gpio_in(gicdev, i);
> -    }
> +    return gicdev;

If you make DeviceState *gic a field in SBSAMachineState then
you don't need to pass it in as a parameter to all these
functions. I think this code is mostly borrowed from the
virt board, which is written the way it is because at the
time we didn't have machine state structs which could
own all the device structs etc for the devices on the board.

thanks
-- PMM

