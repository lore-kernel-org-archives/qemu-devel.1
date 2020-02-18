Return-Path: <SRS0=v1sw=4G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F0CCC34026
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2020 09:06:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CF2FB206E2
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2020 09:06:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=greensocs.com header.i=@greensocs.com header.b="kFEd/jaM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF2FB206E2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=greensocs.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58472 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j3ypV-0000tZ-SV
	for qemu-devel@archiver.kernel.org; Tue, 18 Feb 2020 04:06:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37551)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <luc.michel@greensocs.com>) id 1j3ymo-000753-In
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 04:03:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <luc.michel@greensocs.com>) id 1j3ymn-0003pR-E4
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 04:03:22 -0500
Received: from beetle.greensocs.com ([5.135.226.135]:33636)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <luc.michel@greensocs.com>)
 id 1j3yml-0003ou-38; Tue, 18 Feb 2020 04:03:19 -0500
Received: from [172.16.11.100] (tiramisu.bar.greensocs.com [172.16.11.100])
 by beetle.greensocs.com (Postfix) with ESMTPSA id A82E396EF0;
 Tue, 18 Feb 2020 09:03:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=greensocs.com;
 s=mail; t=1582016598;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QwzSxtH+QYYUM0hnv7zLFbkQKZqy9LdPLXoeOgPZpzw=;
 b=kFEd/jaMVrmOg75f+jb2z5dlbsgzcLZRKkKaNpTBerTtY+MiIKyy3h1qSraUTRqSvaUehM
 wY0Uq80BvDs9MP5YsLc76Q2ulNFA9AntxNGnD6w8PDgVleBI9yuulToLWDPRGkjl+Bu7pO
 1WFAMUVLc7c1ZrY67RyvRDX+qNBAR9Q=
Subject: Re: [PATCH v2 10/13] hw/arm/bcm2836: Split out common realize() code
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 qemu-devel@nongnu.org
References: <20200217114533.17779-1-f4bug@amsat.org>
 <20200217114533.17779-11-f4bug@amsat.org>
From: Luc Michel <luc.michel@greensocs.com>
Message-ID: <fffe1411-72fa-4263-b8f3-bebc3d1da8cc@greensocs.com>
Date: Tue, 18 Feb 2020 10:03:17 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200217114533.17779-11-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-PH
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=greensocs.com; 
 s=mail; t=1582016598;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QwzSxtH+QYYUM0hnv7zLFbkQKZqy9LdPLXoeOgPZpzw=;
 b=SQOry8KPgeUHdFtnrncGwaPV1wmb0uc+esQ2q9fc2zv/SmBdoqxXV1UScVaDh6qcSX9Z0B
 4qVgJqpErQ467cuXUmGQ5idwEMoA/lmzLMSeZKycrf4cUJsSZZLFB/ctsvnTOw7ABMxwLq
 WfOqkjhdTc4y4xcces4hBxdkt/cb7N0=
ARC-Seal: i=1; s=mail; d=greensocs.com; t=1582016598; a=rsa-sha256; cv=none;
 b=2w+f7QyjLXT/cSIgFp+Vh2Q0QcoHZPnfdBGlURth/XNXRz8KKeTZXauF2niCFSblYHU5kM
 A9jAyobP0TTkhcrJr1Mi+83vivgXbVQF0oeGIC6PsYzihDrNzhqR0juVSvYicrZ36keRgl
 2s2SYHeABn3MHK1yaSoplSopCm9U6yM=
ARC-Authentication-Results: i=1; ORIGINATING;
 auth=pass smtp.auth=luc smtp.mailfrom=luc.michel@greensocs.com
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 5.135.226.135
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
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 Andrew Baumann <Andrew.Baumann@microsoft.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 2/17/20 12:45 PM, Philippe Mathieu-Daud=C3=A9 wrote:
> The realize() function is clearly composed of two parts,
> each described by a comment:
>=20
>   void realize()
>   {
>      /* common peripherals from bcm2835 */
>      ...
>      /* bcm2836 interrupt controller (and mailboxes, etc.) */
>      ...
>    }
>=20
> Split the two part, so we can reuse the common part with other
> SoCs from this family.
>=20
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

Reviewed-by: Luc Michel <luc.michel@greensocs.com>

> ---
>  hw/arm/bcm2836.c | 23 +++++++++++++++++++----
>  1 file changed, 19 insertions(+), 4 deletions(-)
>=20
> diff --git a/hw/arm/bcm2836.c b/hw/arm/bcm2836.c
> index caaa4b625e..2b6fe31139 100644
> --- a/hw/arm/bcm2836.c
> +++ b/hw/arm/bcm2836.c
> @@ -51,8 +51,10 @@ static void bcm2836_init(Object *obj)
>          qdev_prop_set_uint32(DEVICE(obj), "enabled-cpus", bc->core_cou=
nt);
>      }
> =20
> -    sysbus_init_child_obj(obj, "control", &s->control, sizeof(s->contr=
ol),
> -                          TYPE_BCM2836_CONTROL);
> +    if (bc->ctrl_base) {
> +        sysbus_init_child_obj(obj, "control", &s->control,
> +                              sizeof(s->control), TYPE_BCM2836_CONTROL=
);
> +    }
> =20
>      sysbus_init_child_obj(obj, "peripherals", &s->peripherals,
>                            sizeof(s->peripherals), TYPE_BCM2835_PERIPHE=
RALS);
> @@ -62,13 +64,12 @@ static void bcm2836_init(Object *obj)
>                                "vcram-size", &error_abort);
>  }
> =20
> -static void bcm2836_realize(DeviceState *dev, Error **errp)
> +static void bcm283x_common_realize(DeviceState *dev, Error **errp)
>  {
>      BCM283XState *s =3D BCM283X(dev);
>      BCM283XClass *bc =3D BCM283X_GET_CLASS(dev);
>      Object *obj;
>      Error *err =3D NULL;
> -    int n;
> =20
>      /* common peripherals from bcm2835 */
> =20
> @@ -100,6 +101,20 @@ static void bcm2836_realize(DeviceState *dev, Erro=
r **errp)
> =20
>      sysbus_mmio_map_overlap(SYS_BUS_DEVICE(&s->peripherals), 0,
>                              bc->peri_base, 1);
> +}
> +
> +static void bcm2836_realize(DeviceState *dev, Error **errp)
> +{
> +    BCM283XState *s =3D BCM283X(dev);
> +    BCM283XClass *bc =3D BCM283X_GET_CLASS(dev);
> +    Error *err =3D NULL;
> +    int n;
> +
> +    bcm283x_common_realize(dev, &err);
> +    if (err) {
> +        error_propagate(errp, err);
> +        return;
> +    }
> =20
>      /* bcm2836 interrupt controller (and mailboxes, etc.) */
>      object_property_set_bool(OBJECT(&s->control), true, "realized", &e=
rr);
>=20

