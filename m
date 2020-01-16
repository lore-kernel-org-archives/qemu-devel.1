Return-Path: <SRS0=QWrs=3F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BD8EC32771
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jan 2020 02:09:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5A3452081E
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jan 2020 02:09:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZzAtctM6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A3452081E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35326 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iruas-0005L5-54
	for qemu-devel@archiver.kernel.org; Wed, 15 Jan 2020 21:09:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41824)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iruWV-0007lp-Kl
 for qemu-devel@nongnu.org; Wed, 15 Jan 2020 21:04:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iruWT-0001Hd-LD
 for qemu-devel@nongnu.org; Wed, 15 Jan 2020 21:04:39 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:55377
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iruWT-0001HI-Gy
 for qemu-devel@nongnu.org; Wed, 15 Jan 2020 21:04:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579140277;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3Q70BMahiPtEyyi8NR3hjz4XHq+nXqUnzPcAFF9ET+E=;
 b=ZzAtctM6vp6JRN28PPoHqYfrQ87ZVWMua9RQgGPtEv3J4XrOj66Wt7zB2g8JX8Wqz9ArvV
 EnulbalYLx3sC5OYMvXfXo1Yn+zfvF1xjp/+1Z8YhZU78X1lduu1PY5xYW5gQu0rqucYnx
 BjgUwm0Qg+im+E/X5pquSy5Pz97gNwI=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-4-SeA8uD-bNrWpTn4viGk_6A-1; Wed, 15 Jan 2020 21:04:35 -0500
Received: by mail-wm1-f71.google.com with SMTP id h130so652070wme.7
 for <qemu-devel@nongnu.org>; Wed, 15 Jan 2020 18:04:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=8hukU6pxUq0CupOZ+seGlP9QRAr603i6J8evF7BH81k=;
 b=QH9JigL3IgxTVsNliGhmOj3TmLCWI//6QotcOZpF9bTcd4GWT3wmA97KOdRB9rIZ9w
 GTjf+Uxcbbvc9W1gJW34nDYKOw7DuWiOIxshlYoivIuIr9/WE/pR09XjTYHxIQlvGM18
 ph4VLBxT8dMOGfHPCen19vyjCg1or6L/AcLDCBzZUSB/4sCyDFMHcX6rD7+D8uzexiZk
 eJeZfmuJCkvw6NWgCh7dAbzJRun6ONlOnNv0sygZB+AEQ9JKwcvQ2L5mwP882Ndq9ydq
 ZvMOVeQxYU59DFPoe8awml63T08X9B+tFAK60AFZbbwz2OX5FBgwaScEBRR9St/h6jDq
 sgDg==
X-Gm-Message-State: APjAAAXumDZUFsOF74IiSZzp7IWTtiy6hNCgKLJDBoNAmqldVSAJ2iTX
 N5PGdPhPbvKAAGkMe233whu05/WWCguq8FEidOGxRzmRdM09L4mQrPVUZToVs0W766XWeoHmbkJ
 Ug9Ulf3krokRZZb4=
X-Received: by 2002:a1c:a382:: with SMTP id m124mr3321652wme.90.1579140274453; 
 Wed, 15 Jan 2020 18:04:34 -0800 (PST)
X-Google-Smtp-Source: APXvYqyaPPsN86A/1ICexe+E9QNBVJOnHXVyeTs4NstunhuPdHGUePM8+OCQ1kwZm/YsQunCu/P20w==
X-Received: by 2002:a1c:a382:: with SMTP id m124mr3321628wme.90.1579140274247; 
 Wed, 15 Jan 2020 18:04:34 -0800 (PST)
Received: from [192.168.1.24] (lfbn-mon-1-1519-115.w92-167.abo.wanadoo.fr.
 [92.167.83.115])
 by smtp.gmail.com with ESMTPSA id n14sm2362355wmi.26.2020.01.15.18.04.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 15 Jan 2020 18:04:33 -0800 (PST)
Subject: Re: [PATCH v7 02/11] hw/core/qdev: add trace events to help with
 resettable transition
To: Damien Hedde <damien.hedde@greensocs.com>, qemu-devel@nongnu.org
References: <20200115123620.250132-1-damien.hedde@greensocs.com>
 <20200115123620.250132-3-damien.hedde@greensocs.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <f507aa1b-6410-bb89-df28-3302b5cc47a1@redhat.com>
Date: Thu, 16 Jan 2020 03:04:32 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20200115123620.250132-3-damien.hedde@greensocs.com>
Content-Language: en-US
X-MC-Unique: SeA8uD-bNrWpTn4viGk_6A-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.120
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
Cc: peter.maydell@linaro.org, berrange@redhat.com, ehabkost@redhat.com,
 Richard Henderson <richard.henderson@linaro.org>, cohuck@redhat.com,
 mark.burton@greensocs.com, qemu-s390x@nongnu.org, edgari@xilinx.com,
 pbonzini@redhat.com, david@gibson.dropbear.id.au
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 1/15/20 1:36 PM, Damien Hedde wrote:
> Adds trace events to reset procedure and when updating the parent
> bus of a device.
>=20
> Signed-off-by: Damien Hedde <damien.hedde@greensocs.com>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> Reviewed-by: Cornelia Huck <cohuck@redhat.com>

Tested-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

> ---
>   hw/core/qdev.c       | 29 ++++++++++++++++++++++++++---
>   hw/core/trace-events |  9 +++++++++
>   2 files changed, 35 insertions(+), 3 deletions(-)
>=20
> diff --git a/hw/core/qdev.c b/hw/core/qdev.c
> index 8c0c8284c8..5cb03136b5 100644
> --- a/hw/core/qdev.c
> +++ b/hw/core/qdev.c
> @@ -38,6 +38,7 @@
>   #include "hw/boards.h"
>   #include "hw/sysbus.h"
>   #include "migration/vmstate.h"
> +#include "trace.h"
>  =20
>   bool qdev_hotplug =3D false;
>   static bool qdev_hot_added =3D false;
> @@ -98,7 +99,11 @@ void qdev_set_parent_bus(DeviceState *dev, BusState *b=
us)
>       bool replugging =3D dev->parent_bus !=3D NULL;
>  =20
>       if (replugging) {
> -        /* Keep a reference to the device while it's not plugged into
> +        trace_qdev_update_parent_bus(dev, object_get_typename(OBJECT(dev=
)),
> +            dev->parent_bus, object_get_typename(OBJECT(dev->parent_bus)=
),
> +            OBJECT(bus), object_get_typename(OBJECT(bus)));
> +        /*
> +         * Keep a reference to the device while it's not plugged into
>            * any bus, to avoid it potentially evaporating when it is
>            * dereffed in bus_remove_child().
>            */
> @@ -296,6 +301,18 @@ HotplugHandler *qdev_get_hotplug_handler(DeviceState=
 *dev)
>       return hotplug_ctrl;
>   }
>  =20
> +static int qdev_prereset(DeviceState *dev, void *opaque)
> +{
> +    trace_qdev_reset_tree(dev, object_get_typename(OBJECT(dev)));
> +    return 0;
> +}
> +
> +static int qbus_prereset(BusState *bus, void *opaque)
> +{
> +    trace_qbus_reset_tree(bus, object_get_typename(OBJECT(bus)));
> +    return 0;
> +}
> +
>   static int qdev_reset_one(DeviceState *dev, void *opaque)
>   {
>       device_legacy_reset(dev);
> @@ -306,6 +323,7 @@ static int qdev_reset_one(DeviceState *dev, void *opa=
que)
>   static int qbus_reset_one(BusState *bus, void *opaque)
>   {
>       BusClass *bc =3D BUS_GET_CLASS(bus);
> +    trace_qbus_reset(bus, object_get_typename(OBJECT(bus)));
>       if (bc->reset) {
>           bc->reset(bus);
>       }
> @@ -314,7 +332,9 @@ static int qbus_reset_one(BusState *bus, void *opaque=
)
>  =20
>   void qdev_reset_all(DeviceState *dev)
>   {
> -    qdev_walk_children(dev, NULL, NULL, qdev_reset_one, qbus_reset_one, =
NULL);
> +    trace_qdev_reset_all(dev, object_get_typename(OBJECT(dev)));
> +    qdev_walk_children(dev, qdev_prereset, qbus_prereset,
> +                       qdev_reset_one, qbus_reset_one, NULL);
>   }
>  =20
>   void qdev_reset_all_fn(void *opaque)
> @@ -324,7 +344,9 @@ void qdev_reset_all_fn(void *opaque)
>  =20
>   void qbus_reset_all(BusState *bus)
>   {
> -    qbus_walk_children(bus, NULL, NULL, qdev_reset_one, qbus_reset_one, =
NULL);
> +    trace_qbus_reset_all(bus, object_get_typename(OBJECT(bus)));
> +    qbus_walk_children(bus, qdev_prereset, qbus_prereset,
> +                       qdev_reset_one, qbus_reset_one, NULL);
>   }
>  =20
>   void qbus_reset_all_fn(void *opaque)
> @@ -1131,6 +1153,7 @@ void device_legacy_reset(DeviceState *dev)
>   {
>       DeviceClass *klass =3D DEVICE_GET_CLASS(dev);
>  =20
> +    trace_qdev_reset(dev, object_get_typename(OBJECT(dev)));
>       if (klass->reset) {
>           klass->reset(dev);
>       }
> diff --git a/hw/core/trace-events b/hw/core/trace-events
> index fe47a9c8cb..a375aa88a4 100644
> --- a/hw/core/trace-events
> +++ b/hw/core/trace-events
> @@ -1,2 +1,11 @@
>   # loader.c
>   loader_write_rom(const char *name, uint64_t gpa, uint64_t size, bool is=
rom) "%s: @0x%"PRIx64" size=3D0x%"PRIx64" ROM=3D%d"
> +
> +# qdev.c
> +qdev_reset(void *obj, const char *objtype) "obj=3D%p(%s)"
> +qdev_reset_all(void *obj, const char *objtype) "obj=3D%p(%s)"
> +qdev_reset_tree(void *obj, const char *objtype) "obj=3D%p(%s)"
> +qbus_reset(void *obj, const char *objtype) "obj=3D%p(%s)"
> +qbus_reset_all(void *obj, const char *objtype) "obj=3D%p(%s)"
> +qbus_reset_tree(void *obj, const char *objtype) "obj=3D%p(%s)"
> +qdev_update_parent_bus(void *obj, const char *objtype, void *oldp, const=
 char *oldptype, void *newp, const char *newptype) "obj=3D%p(%s) old_parent=
=3D%p(%s) new_parent=3D%p(%s)"
>=20


