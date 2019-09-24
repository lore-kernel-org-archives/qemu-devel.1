Return-Path: <SRS0=+sEj=XT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24F0BC432C2
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Sep 2019 09:45:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E324620872
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Sep 2019 09:45:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Fud46ZTb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E324620872
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43276 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iChOM-0007yv-1g
	for qemu-devel@archiver.kernel.org; Tue, 24 Sep 2019 05:45:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56221)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iChMh-000734-B0
 for qemu-devel@nongnu.org; Tue, 24 Sep 2019 05:44:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iChMf-0001En-AB
 for qemu-devel@nongnu.org; Tue, 24 Sep 2019 05:44:11 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:37470
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iChMd-0001DJ-CY
 for qemu-devel@nongnu.org; Tue, 24 Sep 2019 05:44:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1569318246;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:openpgp:openpgp;
 bh=w7X0ffLYjx3WhjHeJ/8TuzRhQI0tvi+bbn3vl1oYzjk=;
 b=Fud46ZTbFiseFCA7YsOuttAyFnKIhZNP8beG0eamIq5OaUg3qE+limpIvWNk+RCOkHgThT
 xSlx4ma/xTAKkfvwWy7XjjvKW2m5JnQxAm1IL/J3BtCXcUNHTRzx4AVoz8O90FKGfBuEbe
 T68s/WhoBNg3UfTv8D1TKCgWl0Mae2k=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-150-FOeinQSePdC_zI4Z9Ush1A-1; Tue, 24 Sep 2019 05:44:05 -0400
Received: by mail-wm1-f72.google.com with SMTP id l3so676143wmf.8
 for <qemu-devel@nongnu.org>; Tue, 24 Sep 2019 02:44:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=Z3VaEnLqpzs+wzolrWlmW+t80AuhLKd4Zed0xnc4Thw=;
 b=pf5KGl+rrFeEboR3xJCpJfGs9zdIj1A/eKCgvIo5g+GgO/GFvw64ma1qTyXCwBr65w
 nOZZECTe//bQ6TFv5boQkszMyAG19uWdXQYvVmZ6ctj5p3tEGNYy4eroyj4MoKcCrB9H
 sez0pGmHGdnuB46PU3W8KOZwIkbj8KN3Pac2L5YHXL5244765WF8qaNJ04LmXbSw7rxy
 uy5zJhP4CGhnBjrGEoNoXVt0iVAa7/nzfuR/FCVVNaf1t/ZOv4ijlxglbuQWOrfrFHLf
 vfzLX+/Mvy6AynLIBypJ0cB3Q93a6JpvxaqdI5hLuLxAJ4AC8DZRxQ5uLXk1U+LocPML
 f0pg==
X-Gm-Message-State: APjAAAX7ChhNpDN53MICTObwFtrgDQj4iJZN6YFpHIFgwbx5PKUwjA3w
 3wVJZeuC/1fpf/00YkXb4WVXv2wt4BrUo/8Xv7DQPGdoqcZXSGkfKHMU7PC4eF7U/iME1fe1DTf
 uiP1Tuy7qkfVMtsE=
X-Received: by 2002:a5d:62c8:: with SMTP id o8mr1533745wrv.350.1569318243918; 
 Tue, 24 Sep 2019 02:44:03 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxa+OXRTkJoxGyv7qsa7WQ7cOi6LerKFd1CaZz8MYaaKtAFNuJDZ8A8X5YxZn4rCJxpTqgLMg==
X-Received: by 2002:a5d:62c8:: with SMTP id o8mr1533721wrv.350.1569318243514; 
 Tue, 24 Sep 2019 02:44:03 -0700 (PDT)
Received: from [192.168.1.115] (240.red-88-21-68.staticip.rima-tde.net.
 [88.21.68.240])
 by smtp.gmail.com with ESMTPSA id t6sm1531284wmf.8.2019.09.24.02.44.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 24 Sep 2019 02:44:02 -0700 (PDT)
Subject: Re: [PATCH 2/4] xics: Merge reset and realize hooks
To: David Gibson <david@gibson.dropbear.id.au>, qemu-ppc@nongnu.org,
 clg@kaod.org
References: <20190924045952.11412-1-david@gibson.dropbear.id.au>
 <20190924045952.11412-3-david@gibson.dropbear.id.au>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <f15b4277-9382-a795-05d4-29c32afaea9b@redhat.com>
Date: Tue, 24 Sep 2019 11:44:01 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190924045952.11412-3-david@gibson.dropbear.id.au>
Content-Language: en-US
X-MC-Unique: FOeinQSePdC_zI4Z9Ush1A-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.61
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
Cc: gkurz@kaod.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi David,

On 9/24/19 6:59 AM, David Gibson wrote:
> Currently TYPE_XICS_BASE and TYPE_XICS_SIMPLE have their own reset and
> realize methods, using the standard technique for having the subtype
> call the supertype's methods before doing its own thing.
>=20
> But TYPE_XICS_SIMPLE is the only subtype of TYPE_XICS_BASE ever
> instantiated, so there's no point having the split here.  Merge them
> together into just ics_reset() and ics_realize() functions.
>=20
> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
> ---
>  hw/intc/xics.c        | 97 ++++++++++++++++---------------------------
>  include/hw/ppc/xics.h |  3 --
>  2 files changed, 35 insertions(+), 65 deletions(-)
>=20
> diff --git a/hw/intc/xics.c b/hw/intc/xics.c
> index 93139b0189..db0e532bd9 100644
> --- a/hw/intc/xics.c
> +++ b/hw/intc/xics.c
> @@ -548,68 +548,13 @@ static void ics_eoi(ICSState *ics, uint32_t nr)
>      }
>  }
> =20
> -static void ics_simple_reset(DeviceState *dev)
> -{
> -    ICSStateClass *icsc =3D ICS_BASE_GET_CLASS(dev);
> -
> -    icsc->parent_reset(dev);
> -
> -    if (kvm_irqchip_in_kernel()) {
> -        Error *local_err =3D NULL;
> -
> -        ics_set_kvm_state(ICS_BASE(dev), &local_err);
> -        if (local_err) {
> -            error_report_err(local_err);
> -        }
> -    }
> -}
> -
> -static void ics_simple_reset_handler(void *dev)
> -{
> -    ics_simple_reset(dev);
> -}
> -
> -static void ics_simple_realize(DeviceState *dev, Error **errp)
> -{
> -    ICSState *ics =3D ICS_SIMPLE(dev);
> -    ICSStateClass *icsc =3D ICS_BASE_GET_CLASS(ics);
> -    Error *local_err =3D NULL;
> -
> -    icsc->parent_realize(dev, &local_err);
> -    if (local_err) {
> -        error_propagate(errp, local_err);
> -        return;
> -    }
> -
> -    qemu_register_reset(ics_simple_reset_handler, ics);
> -}
> -
> -static void ics_simple_class_init(ObjectClass *klass, void *data)
> -{
> -    DeviceClass *dc =3D DEVICE_CLASS(klass);
> -    ICSStateClass *isc =3D ICS_BASE_CLASS(klass);
> -
> -    device_class_set_parent_realize(dc, ics_simple_realize,
> -                                    &isc->parent_realize);
> -    device_class_set_parent_reset(dc, ics_simple_reset,
> -                                  &isc->parent_reset);
> -}
> -
> -static const TypeInfo ics_simple_info =3D {
> -    .name =3D TYPE_ICS_SIMPLE,
> -    .parent =3D TYPE_ICS_BASE,
> -    .instance_size =3D sizeof(ICSState),
> -    .class_init =3D ics_simple_class_init,
> -    .class_size =3D sizeof(ICSStateClass),
> -};
> -
>  static void ics_reset_irq(ICSIRQState *irq)
>  {
>      irq->priority =3D 0xff;
>      irq->saved_priority =3D 0xff;
>  }
> =20
> -static void ics_base_reset(DeviceState *dev)
> +static void ics_reset(DeviceState *dev)
>  {
>      ICSState *ics =3D ICS_BASE(dev);
>      int i;
> @@ -625,17 +570,31 @@ static void ics_base_reset(DeviceState *dev)
>          ics_reset_irq(ics->irqs + i);
>          ics->irqs[i].flags =3D flags[i];
>      }
> +
> +    if (kvm_irqchip_in_kernel()) {
> +        Error *local_err =3D NULL;
> +
> +        ics_set_kvm_state(ICS_BASE(dev), &local_err);
> +        if (local_err) {
> +            error_report_err(local_err);
> +        }
> +    }
> +}
> +
> +static void ics_reset_handler(void *dev)
> +{
> +    ics_reset(dev);
>  }
> =20
> -static void ics_base_realize(DeviceState *dev, Error **errp)
> +static void ics_realize(DeviceState *dev, Error **errp)
>  {
>      ICSState *ics =3D ICS_BASE(dev);
> +    Error *local_err =3D NULL;

Nit: This variable renaming is confusing, maybe another patch?

>      Object *obj;
> -    Error *err =3D NULL;
> =20
> -    obj =3D object_property_get_link(OBJECT(dev), ICS_PROP_XICS, &err);
> +    obj =3D object_property_get_link(OBJECT(dev), ICS_PROP_XICS, &local_=
err);
>      if (!obj) {
> -        error_propagate_prepend(errp, err,
> +        error_propagate_prepend(errp, local_err,
>                                  "required link '" ICS_PROP_XICS
>                                  "' not found: ");
>          return;
> @@ -647,8 +606,22 @@ static void ics_base_realize(DeviceState *dev, Error=
 **errp)
>          return;
>      }
>      ics->irqs =3D g_malloc0(ics->nr_irqs * sizeof(ICSIRQState));
> +
> +    qemu_register_reset(ics_reset_handler, ics);

Can you change this call by ...

> +}
> +
> +static void ics_simple_class_init(ObjectClass *klass, void *data)
> +{

... this?

    DeviceClass *dc =3D DEVICE_CLASS(klass);

    dc->reset =3D ics_reset;

>  }
> =20
> +static const TypeInfo ics_simple_info =3D {
> +    .name =3D TYPE_ICS_SIMPLE,
> +    .parent =3D TYPE_ICS_BASE,

But now reading here, why keep TYPE_ICS_BASE?
It seems you can simplify further using directly:

       .parent =3D TYPE_DEVICE,

> +    .instance_size =3D sizeof(ICSState),
> +    .class_init =3D ics_simple_class_init,
> +    .class_size =3D sizeof(ICSStateClass),
> +};
> +
>  static void ics_base_instance_init(Object *obj)
>  {
>      ICSState *ics =3D ICS_BASE(obj);
> @@ -725,9 +698,9 @@ static void ics_base_class_init(ObjectClass *klass, v=
oid *data)
>  {
>      DeviceClass *dc =3D DEVICE_CLASS(klass);
> =20
> -    dc->realize =3D ics_base_realize;
> +    dc->realize =3D ics_realize;
>      dc->props =3D ics_base_properties;
> -    dc->reset =3D ics_base_reset;
> +    dc->reset =3D ics_reset;
>      dc->vmsd =3D &vmstate_ics_base;
>  }
> =20
> diff --git a/include/hw/ppc/xics.h b/include/hw/ppc/xics.h
> index 34d7985b7c..0eb39c2561 100644
> --- a/include/hw/ppc/xics.h
> +++ b/include/hw/ppc/xics.h
> @@ -103,9 +103,6 @@ struct PnvICPState {
> =20
>  struct ICSStateClass {
>      DeviceClass parent_class;
> -
> -    DeviceRealize parent_realize;
> -    DeviceReset parent_reset;
>  };
> =20
>  struct ICSState {
>=20


