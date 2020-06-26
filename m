Return-Path: <SRS0=ZkAM=AH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48846C433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 18:33:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1A6B8207D8
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 18:33:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="EPqpTzj1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A6B8207D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55740 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jotAT-0003ip-Cf
	for qemu-devel@archiver.kernel.org; Fri, 26 Jun 2020 14:33:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58490)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jot0O-0004D3-E7
 for qemu-devel@nongnu.org; Fri, 26 Jun 2020 14:23:16 -0400
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:33232)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jot0M-0005Bq-ND
 for qemu-devel@nongnu.org; Fri, 26 Jun 2020 14:23:16 -0400
Received: by mail-ot1-x341.google.com with SMTP id n6so9507941otl.0
 for <qemu-devel@nongnu.org>; Fri, 26 Jun 2020 11:23:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=LvgLLhBtWl2z+FXtxz/Ed4ovyKj4GMS7TWSgOgCVmF8=;
 b=EPqpTzj1cd2Znrz+bTU7dU0M7aac5eS2BXa/IBOhXQR2XQh0lrwsQpMbvygPWOPXqV
 IED5DHDcC0EvfEAHqsSO+pIuQMdzxt0rfzHCbv0735VwSWJ29q8A199giaXN4KrV7Lub
 XPKY2IsFPCen0C4kll4IGDTzo72ctLkS7hIndKbXJe1aN+BaavBIhFiwF9pbwt+EYPxF
 wwSVVwR0UphTRQtaPYyw1qwUlnc7LX9aOnmNoN47ofnjQy3E2TQXIY9MZswZZ1q4LADK
 aGxWHheXXvrAhuYaR9UgdlXYY8l6In/nRQTf8X6d8+m4KI5RY9KdoKNcKQPCrUEw2XKt
 ZoWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=LvgLLhBtWl2z+FXtxz/Ed4ovyKj4GMS7TWSgOgCVmF8=;
 b=p4Y2xIw7+Q+rRFbE9CIwPG/dw7CPCL7SvRNSKxGW8oiL6minNyiMzqOPn0eb3r1wlL
 CONU6WdwEP/wOH7jWYK2ZxyyoHIQhHPaVyxTkE5Ht+ZsEa3VNa96zoaHu3Q5hD0pdpi6
 xLVcyeCwtjNQGH1npFKhgsbg7mQlllRbUVwWmgsBPDxPIDaiRvvmCxmfnF50fMJaQFQ6
 YBp2CoYmIxKEd0kUFdMx1XROAgKXAAOVRufuVytmWnuPtggNqWa2EqtICQNw/yJsOdWs
 6pXjJxodTDE2IwW2AMb6eULs4aNyjIJ6l3udsP25wLdNZoZQ57b9hdn/q0f4PGs/on2t
 bV0w==
X-Gm-Message-State: AOAM532Hr5x1uO0eslpxjGJjynsp4nj3GihxslLbce/9YNeU3W9cvhUX
 adl9bEnQVRxLmlJ0UZ/uWoKFrAu02vjLUeXfD6Cluw==
X-Google-Smtp-Source: ABdhPJwqWBcYU+p1YL2CyFvXgzkoD6vjTsV8ilxoHyHNqOuH3dHYQgKKKOo384NY3q5AtATlWVvY2StqMzoeV+zZi2M=
X-Received: by 2002:a4a:2f15:: with SMTP id p21mr3558948oop.20.1593195793213; 
 Fri, 26 Jun 2020 11:23:13 -0700 (PDT)
MIME-Version: 1.0
References: <20200623072723.6324-1-f4bug@amsat.org>
 <20200623072723.6324-2-f4bug@amsat.org>
In-Reply-To: <20200623072723.6324-2-f4bug@amsat.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 26 Jun 2020 19:23:02 +0100
Message-ID: <CAFEAcA9-Vjh-hkB9i9fvp9yEHuKW7cGeEDQ-kKmiiao2WogQDQ@mail.gmail.com>
Subject: Re: [PATCH v6 1/9] hw/i2c/core: Add i2c_try_create_slave() and
 i2c_realize_and_unref()
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::341;
 envelope-from=peter.maydell@linaro.org; helo=mail-ot1-x341.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Corey Minyard <cminyard@mvista.com>, Andrew Jeffery <andrew@aj.id.au>,
 QEMU Developers <qemu-devel@nongnu.org>, Markus Armbruster <armbru@redhat.com>,
 qemu-arm <qemu-arm@nongnu.org>, Joel Stanley <joel@jms.id.au>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 23 Jun 2020 at 08:27, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>=
 wrote:
>
> Extract i2c_try_create_slave() and i2c_realize_and_unref()
> from i2c_create_slave().
> We can now set properties on a I2CSlave before it is realized.
>
> This is in line with the recent qdev/QOM changes merged
> in commit 6675a653d2e.
>
> Reviewed-by: Corey Minyard <cminyard@mvista.com>
> Reviewed-by: C=C3=A9dric Le Goater <clg@kaod.org>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

Couple of things I belatedly noticed on this patch, which I don't
think are important enough for me to drop it from my pullreq,
but which I think it would be nice to address in a followup:

> diff --git a/include/hw/i2c/i2c.h b/include/hw/i2c/i2c.h
> index 4117211565..d6e3d85faf 100644
> --- a/include/hw/i2c/i2c.h
> +++ b/include/hw/i2c/i2c.h
> @@ -80,6 +80,8 @@ int i2c_send(I2CBus *bus, uint8_t data);
>  uint8_t i2c_recv(I2CBus *bus);
>
>  DeviceState *i2c_create_slave(I2CBus *bus, const char *name, uint8_t add=
r);
> +DeviceState *i2c_try_create_slave(const char *name, uint8_t addr);
> +bool i2c_realize_and_unref(DeviceState *dev, I2CBus *bus, Error **errp);

Can we have doc-comments for new global-scope functions, please ?

> --- a/hw/i2c/core.c
> +++ b/hw/i2c/core.c
> @@ -267,13 +267,27 @@ const VMStateDescription vmstate_i2c_slave =3D {
>      }
>  };
>
> -DeviceState *i2c_create_slave(I2CBus *bus, const char *name, uint8_t add=
r)
> +DeviceState *i2c_try_create_slave(const char *name, uint8_t addr)
>  {
>      DeviceState *dev;
>
>      dev =3D qdev_new(name);
>      qdev_prop_set_uint8(dev, "address", addr);
> -    qdev_realize_and_unref(dev, &bus->qbus, &error_fatal);
> +    return dev;
> +}
> +
> +bool i2c_realize_and_unref(DeviceState *dev, I2CBus *bus, Error **errp)
> +{
> +    return qdev_realize_and_unref(dev, &bus->qbus, errp);
> +}
> +
> +DeviceState *i2c_create_slave(I2CBus *bus, const char *name, uint8_t add=
r)
> +{
> +    DeviceState *dev;
> +
> +    dev =3D i2c_try_create_slave(name, addr);
> +    i2c_realize_and_unref(dev, bus, &error_fatal);
> +

We now have a _try_ function which isn't "same behaviour as
the non-try function, but give me back an error status rather
than just killing QEMU". That seems confusing -- is there a
better name we can use ?

thanks
-- PMM

