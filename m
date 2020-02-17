Return-Path: <SRS0=CnYV=4F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D878C33FA1
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2020 13:26:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1861C2070B
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2020 13:26:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ePWhksdG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1861C2070B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45462 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j3gPc-0001rN-AT
	for qemu-devel@archiver.kernel.org; Mon, 17 Feb 2020 08:26:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:53954)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1j3gOx-0001SV-8X
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 08:25:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1j3gOv-0007j6-Ux
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 08:25:31 -0500
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:33740)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1j3gOv-0007ha-OV
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 08:25:29 -0500
Received: by mail-ot1-x343.google.com with SMTP id w6so6857543otk.0
 for <qemu-devel@nongnu.org>; Mon, 17 Feb 2020 05:25:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=6Z9Qd7ve71+QyUtTZIhIkPsfj8X7rcCLN1WHLO5CKDo=;
 b=ePWhksdGSSb9rVjP5dzq4oPMF1lIL8GUjBCWuLfLeOFEthX9dTcI/+BYMVJ5+AcLVc
 n5gofQnXidsBzSH0jkFGUqgU6tNqpprzgMvkdviamMnRky0FrUfKLusuqAPOn8KHHXx+
 SbO8i0dPy9M/cLutnHP8ILSBCsih0zvFIejJxHJ6XfgH4SFFb2EQ+ORKmS7nX/NiQAwL
 uksp05cXgV4QoLcUiPEGyIRDpcWnuIsQbmNSzX6g/zHx2XMl3i0V6sB56aqIcrz4MbhG
 CeAUqxX9XGZuwJS3MMBWK+y7ronoOKJbrpqOYWHpeg5sfp6qnhPGCm1/7tulR84HTQaE
 xrKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=6Z9Qd7ve71+QyUtTZIhIkPsfj8X7rcCLN1WHLO5CKDo=;
 b=jQr7pOEui5utVVVqrKVi8uItPazAtSrbn/jmvKQk01qqgm1msTOLBMO6OdWbUkZZzN
 JJzx1cq/xepWtC8bBBlP/TNrkO+PRYq0SieW5y3mKYRVEAmisKXGoPwSotRRNjiiSW1R
 eu5HPoX82JN61Gvo17aC2XF+dLPgLnvqDBToY0e3z/nWTbbGjAHXx0pIPYh+5L5qOl6f
 CUcyrtsfOrZfwSX+FGdpJKqIPa3yKAwTAUAVXFroRUZQt9OgwJJaQiLWwhrbgRwentXO
 0bhQrIfUScaUAcBnvMw23/MwukuMQQ41Bh6zSHR9CgvMPpkQwS9Ow04Zi3ltojVj79Dx
 eAaA==
X-Gm-Message-State: APjAAAVCLioWjJELpFR7bZ+gyUURo+xRLWJioKjI0pDNYsB1jSvsq8TK
 q9ENObFQo5nYLn+pyS5+b3iCm5LntRNj4yoq2MwgVQ==
X-Google-Smtp-Source: APXvYqyS7Z1Op82W2YfyYZklyRxllL/BWhtyOczWmcF3eri0DY31GQnkr3zjK9kwi9hj7aK2HiT7xNI9Bl+F6yjnSus=
X-Received: by 2002:a05:6830:4a4:: with SMTP id
 l4mr12248761otd.91.1581945927051; 
 Mon, 17 Feb 2020 05:25:27 -0800 (PST)
MIME-Version: 1.0
References: <20200215154706.19837-1-philmd@redhat.com>
 <20200215154706.19837-2-philmd@redhat.com>
In-Reply-To: <20200215154706.19837-2-philmd@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 17 Feb 2020 13:25:15 +0000
Message-ID: <CAFEAcA9cZHWziyk6VzfaxrqjCNNOmnmSkB=uuGJMp0TL521mAQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] hw/ipmi/bmc: Delay timer_new_ns() from init to
 realize to avoid memleaks
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::343
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
Cc: Pan Nengyuan <pannengyuan@huawei.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Corey Minyard <minyard@acm.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sat, 15 Feb 2020 at 15:48, Philippe Mathieu-Daud=C3=A9 <philmd@redhat.co=
m> wrote:
>
> In commit f3a508eb4e the Euler Robot reported calling timer_new()
> in instance_init() can leak heap memory. The easier fix is to
> delay the timer creation at instance realize(). Similarly move
> timer_del() into a new instance unrealize() method.
>
> This case was found with the following coccinelle script:
>
>     @ match @
>     identifier instance_init;
>     typedef Object;
>     identifier obj;
>     expression val, scale;
>     identifier clock_type, callback, opaque;
>     position pos;
>     @@
>     static void instance_init(Object *obj)
>     {
>       <...
>     (
>       val =3D timer_new@pos(clock_type, scale, callback, opaque);
>     |
>       val =3D timer_new_ns@pos(clock_type, callback, opaque);
>     |
>       val =3D timer_new_us@pos(clock_type, callback, opaque);
>     |
>       val =3D timer_new_ms@pos(clock_type, callback, opaque);
>     )
>       ...>
>     }
>
>     @ script:python @
>     f << match.instance_init;
>     p << match.pos;
>     @@
>     print "check %s:%s:%s in %s()" % (p[0].file, p[0].line, p[0].column, =
f)
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> ---
> Cc: Pan Nengyuan <pannengyuan@huawei.com>
> ---
>  hw/ipmi/ipmi_bmc_extern.c | 12 ++++++++++--
>  1 file changed, 10 insertions(+), 2 deletions(-)
>
> diff --git a/hw/ipmi/ipmi_bmc_extern.c b/hw/ipmi/ipmi_bmc_extern.c
> index f9a13e0a44..9144ac6c38 100644
> --- a/hw/ipmi/ipmi_bmc_extern.c
> +++ b/hw/ipmi/ipmi_bmc_extern.c
> @@ -463,6 +463,15 @@ static void ipmi_bmc_extern_realize(DeviceState *dev=
, Error **errp)
>
>      qemu_chr_fe_set_handlers(&ibe->chr, can_receive, receive,
>                               chr_event, NULL, ibe, NULL, true);
> +
> +    ibe->extern_timer =3D timer_new_ns(QEMU_CLOCK_VIRTUAL, extern_timeou=
t, ibe);
> +}
> +
> +static void ipmi_bmc_extern_unrealize(DeviceState *dev, Error **errp)
> +{
> +    IPMIBmcExtern *ibe =3D IPMI_BMC_EXTERN(dev);
> +
> +    timer_del(ibe->extern_timer);
>  }
>
>  static int ipmi_bmc_extern_post_migrate(void *opaque, int version_id)
> @@ -502,7 +511,6 @@ static void ipmi_bmc_extern_init(Object *obj)
>  {
>      IPMIBmcExtern *ibe =3D IPMI_BMC_EXTERN(obj);
>
> -    ibe->extern_timer =3D timer_new_ns(QEMU_CLOCK_VIRTUAL, extern_timeou=
t, ibe);
>      vmstate_register(NULL, 0, &vmstate_ipmi_bmc_extern, ibe);
>  }
>
> @@ -510,7 +518,6 @@ static void ipmi_bmc_extern_finalize(Object *obj)
>  {
>      IPMIBmcExtern *ibe =3D IPMI_BMC_EXTERN(obj);
>
> -    timer_del(ibe->extern_timer);
>      timer_free(ibe->extern_timer);
>  }

So we now call timer_new in realize, and timer_del in unrealize,
but timer_free in finalize. This seems unbalanced -- why not
call timer_free in unrealize too, if we're moving things?

Also, this is a case of code that's actually doing things right:
we free the memory that we allocated in init in finalize. So
we're not fixing any leak here, we're just moving code around
(which is reasonable if we're trying to standardize on "call
timer_new in realize, not init", but should be noted in the
commit message).

thanks
-- PMM

