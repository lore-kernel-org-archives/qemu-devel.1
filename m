Return-Path: <SRS0=ZO09=24=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D83B8C282DD
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2020 18:30:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AB291206F0
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2020 18:30:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RXy37LGa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AB291206F0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54732 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iotcl-0001Rx-UN
	for qemu-devel@archiver.kernel.org; Tue, 07 Jan 2020 13:30:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:48407)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iotak-0007kD-FD
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 13:28:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iotaj-0003Xp-4k
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 13:28:34 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:35403
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iotaj-0003X3-0c
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 13:28:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1578421712;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BO98RLKpwYNFezVM5wkJCX4w332YQdBNZ99C13EyHiQ=;
 b=RXy37LGauA0976Zox9bgrcrPN4jFLHt/2pOtnl2t9Snbvgq4hMjtgwlrWrtHXHfiqZwAFR
 sw38LN224m9CwG5H2yM75cP5hK7WSSueinrG8/hjlVceO74IfKeMBpH7H/b8Z+1wemvd1i
 WO3awzQMu1BDZrgGb0njt6Vew9altbM=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-257-DKm98YovMd6fa2sOoPjTWg-1; Tue, 07 Jan 2020 13:28:29 -0500
Received: by mail-wr1-f70.google.com with SMTP id u12so296195wrt.15
 for <qemu-devel@nongnu.org>; Tue, 07 Jan 2020 10:28:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=s7Y6TknuOrZeWUgUKLFH7AJLL/zruWZp9zt/lOOpiZM=;
 b=DYlvSl+2PaXfGFg3Dpr4P/B+Zwqor9sS0JEiTmUxap6RLhD211/wrmGE4ZhfNZneuv
 qXa+itYofcnluFpvTTR7nCbCUtrI2ioZDOGYr+kQjFQZzAKLFymLv87d0Dl/u9CX1LUj
 S2eiIq2N5F1znUb5+gCnIzizziVfQ+EQafmIznWjbljc2gDCBZTWn0Tktg04LleNoe4A
 3FIXDO5+sNeq06BwoixHIe9/AyW2jdU3TJv6xuiUN/mjiqXzsV6Yx1UwRaWA6YBZ8W1Q
 C2sbR3UwjKfDJdI3ebgkzzdx4H5R9gPpDW8S9HXF+53VHtCLol7icSXm1PuhYzJw80Vd
 ofzw==
X-Gm-Message-State: APjAAAWqjbhJNNK9S7X6G61UXoFOJlWz7osaLLP6YzXF3ldUSqoqt1xo
 Vcp1PsxSGQjsQ9qETiRb8uKZKff5rw5gJvdPIKNjxLuma2xz/q5Gt4UZLImDROX0P9ePSBb8uQx
 D1zFNIdUSgFAGxsU=
X-Received: by 2002:a05:6000:1047:: with SMTP id
 c7mr381162wrx.341.1578421707949; 
 Tue, 07 Jan 2020 10:28:27 -0800 (PST)
X-Google-Smtp-Source: APXvYqwveEhLC4MNVwZoh2Xa+56Y0iwXALdN52SeNxi4yFuWrVIuhgiepmvYaTZSuIbQ/lwXLEGRtg==
X-Received: by 2002:a05:6000:1047:: with SMTP id
 c7mr381146wrx.341.1578421707700; 
 Tue, 07 Jan 2020 10:28:27 -0800 (PST)
Received: from [192.168.1.35] (34.red-83-42-66.dynamicip.rima-tde.net.
 [83.42.66.34])
 by smtp.gmail.com with ESMTPSA id r6sm834074wrq.92.2020.01.07.10.28.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 07 Jan 2020 10:28:27 -0800 (PST)
Subject: Re: [PATCH 1/2] pnv/psi: Add device reset hook
To: Greg Kurz <groug@kaod.org>, David Gibson <david@gibson.dropbear.id.au>,
 =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
References: <157841289975.66386.6463139590245180762.stgit@bahia.tlslab.ibm.com>
 <157841476035.66386.17838417527621752518.stgit@bahia.tlslab.ibm.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <cc1a6cc0-8c96-963d-9dde-f61dde29f198@redhat.com>
Date: Tue, 7 Jan 2020 19:28:25 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <157841476035.66386.17838417527621752518.stgit@bahia.tlslab.ibm.com>
Content-Language: en-US
X-MC-Unique: DKm98YovMd6fa2sOoPjTWg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 1/7/20 5:32 PM, Greg Kurz wrote:
> And call it from a QEMU reset handler. This allows each PNV child class t=
o
> override the reset hook if needed, eg. POWER8 doesn't but POWER9 does.
> The proper way to do that would be to use device_class_set_parent_reset()=
,
> but defining a Pnv8PsiClass and a Pnv9PsiClass types with a parent_reset
> pointer adds a fair amount of code. Calling pnv_psi_reset() explicitely i=
s
> fine for now.
>=20
> A subsequent patch will consolidate the call to qemu_register_reset() in
> a single place.
>=20
> Signed-off-by: Greg Kurz <groug@kaod.org>
> Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

> ---
>   hw/ppc/pnv_psi.c |   15 +++++++++++----
>   1 file changed, 11 insertions(+), 4 deletions(-)
>=20
> diff --git a/hw/ppc/pnv_psi.c b/hw/ppc/pnv_psi.c
> index 75e20d9da08b..6c94781e377d 100644
> --- a/hw/ppc/pnv_psi.c
> +++ b/hw/ppc/pnv_psi.c
> @@ -455,7 +455,7 @@ static const MemoryRegionOps pnv_psi_xscom_ops =3D {
>       }
>   };
>  =20
> -static void pnv_psi_reset(void *dev)
> +static void pnv_psi_reset(DeviceState *dev)
>   {
>       PnvPsi *psi =3D PNV_PSI(dev);
>  =20
> @@ -464,6 +464,11 @@ static void pnv_psi_reset(void *dev)
>       psi->regs[PSIHB_XSCOM_BAR] =3D psi->bar | PSIHB_BAR_EN;
>   }
>  =20
> +static void pnv_psi_reset_handler(void *dev)
> +{
> +    device_reset(DEVICE(dev));
> +}
> +
>   static void pnv_psi_power8_instance_init(Object *obj)
>   {
>       Pnv8Psi *psi8 =3D PNV8_PSI(obj);
> @@ -533,7 +538,7 @@ static void pnv_psi_power8_realize(DeviceState *dev, =
Error **errp)
>               ((uint64_t) i << PSIHB_XIVR_SRC_SH);
>       }
>  =20
> -    qemu_register_reset(pnv_psi_reset, dev);
> +    qemu_register_reset(pnv_psi_reset_handler, dev);
>   }
>  =20
>   static int pnv_psi_dt_xscom(PnvXScomInterface *dev, void *fdt, int xsco=
m_offset)
> @@ -816,7 +821,7 @@ static void pnv_psi_power9_irq_set(PnvPsi *psi, int i=
rq, bool state)
>       qemu_set_irq(psi->qirqs[irq], state);
>   }
>  =20
> -static void pnv_psi_power9_reset(void *dev)
> +static void pnv_psi_power9_reset(DeviceState *dev)
>   {
>       Pnv9Psi *psi =3D PNV9_PSI(dev);
>  =20
> @@ -870,7 +875,7 @@ static void pnv_psi_power9_realize(DeviceState *dev, =
Error **errp)
>  =20
>       pnv_psi_set_bar(psi, psi->bar | PSIHB_BAR_EN);
>  =20
> -    qemu_register_reset(pnv_psi_power9_reset, dev);
> +    qemu_register_reset(pnv_psi_reset_handler, dev);
>   }
>  =20
>   static void pnv_psi_power9_class_init(ObjectClass *klass, void *data)
> @@ -882,6 +887,7 @@ static void pnv_psi_power9_class_init(ObjectClass *kl=
ass, void *data)
>  =20
>       dc->desc    =3D "PowerNV PSI Controller POWER9";
>       dc->realize =3D pnv_psi_power9_realize;
> +    dc->reset   =3D pnv_psi_power9_reset;
>  =20
>       ppc->xscom_pcba =3D PNV9_XSCOM_PSIHB_BASE;
>       ppc->xscom_size =3D PNV9_XSCOM_PSIHB_SIZE;
> @@ -934,6 +940,7 @@ static void pnv_psi_class_init(ObjectClass *klass, vo=
id *data)
>  =20
>       dc->desc =3D "PowerNV PSI Controller";
>       dc->props =3D pnv_psi_properties;
> +    dc->reset =3D pnv_psi_reset;
>   }
>  =20
>   static const TypeInfo pnv_psi_info =3D {
>=20
>=20


