Return-Path: <SRS0=GavZ=27=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79FB9C282DD
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jan 2020 19:19:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 430252051A
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jan 2020 19:19:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AGRx6xvl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 430252051A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50820 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ipzp1-0006nT-8f
	for qemu-devel@archiver.kernel.org; Fri, 10 Jan 2020 14:19:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49215)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1ipznY-0005ak-1J
 for qemu-devel@nongnu.org; Fri, 10 Jan 2020 14:18:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1ipznW-0006kn-OF
 for qemu-devel@nongnu.org; Fri, 10 Jan 2020 14:18:19 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:37598
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1ipznW-0006gE-Iu
 for qemu-devel@nongnu.org; Fri, 10 Jan 2020 14:18:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1578683897;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=B+M2kvAb6/XP63I0j/FfN+o2BFvhF2fHo02YwyNua4k=;
 b=AGRx6xvloYkF5xLEfXikyEG87F1X5JlypdNc3LbpdsD97/ceNXxF9PkN2/FBeW7ocRUJcm
 Uj+yvTZHyw/snzp2jw57YIDSOwH5ubJg6V9N3QOnXer0rESSrrb/WjGtXNmm8RGms2uo+K
 FpXjvs2FBpYmH1PAYGBQlwgMc9Ak4ew=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-158-deAVTjmXM0qotVmr3RwwMg-1; Fri, 10 Jan 2020 14:18:14 -0500
Received: by mail-wm1-f70.google.com with SMTP id p2so1206645wma.3
 for <qemu-devel@nongnu.org>; Fri, 10 Jan 2020 11:18:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=B6Vq5pGv9oZCwpOZkhU3N32PdNefEkm/vll1fHIQVw0=;
 b=mNJU3GeCxDbaFUDNSTnNz3SjlitoAK4HOAu+5uoKrULKelWrp0m0e+p4eRFPpVFZg5
 ag5lCsRu/gRC3cJE78A3RzcE+3/MIxWbI16ALeWqs19wBu1KU22PXmIDH1/VBVpFZeVB
 lAlWz06Z0bsIPmjTT9y19Qd+80QiX83JUISB5b0hNLmSRibyK3t0xVcTRf5q1gyRyK0w
 ft1j85nLXDrsPIeIxlPN5lAFc9M9K3ymHtcKBiQv4b6kRFyPDxCnKE4+wCF2GICXJPpn
 ey+8/RKBXejMYbbXADOTiVvWilv3v9AbkSbEqbSS0y3O3QEpGI8WmMSe64enrQjvVhsq
 ff1A==
X-Gm-Message-State: APjAAAVNubi7vLM1fR1u+2scA+KK7PoQPV/mwtd8BmKbnIkgMhEc0Ztv
 XJWNrPRyo2RwegXtZFCilBbyztc9T7L3SwJTC6QujKL5aKcqaZR7iHf8cd5EPMAJ8Gsz7N6WtS0
 lTB3TX2A5LIAUqZ0=
X-Received: by 2002:a05:6000:1044:: with SMTP id
 c4mr5130335wrx.204.1578683893338; 
 Fri, 10 Jan 2020 11:18:13 -0800 (PST)
X-Google-Smtp-Source: APXvYqwu48h3jdMzAvvwqWPicBC1GqTj233IQvN4mBmRsd0XWV75s+EyfMbi6hvCUJSsQ+L3YlcN5w==
X-Received: by 2002:a05:6000:1044:: with SMTP id
 c4mr5130321wrx.204.1578683893058; 
 Fri, 10 Jan 2020 11:18:13 -0800 (PST)
Received: from ?IPv6:2a01:cb1d:8a0a:f500:48c1:8eab:256a:caf9?
 ([2a01:cb1d:8a0a:f500:48c1:8eab:256a:caf9])
 by smtp.gmail.com with ESMTPSA id k8sm3291503wrl.3.2020.01.10.11.18.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 10 Jan 2020 11:18:12 -0800 (PST)
Subject: Re: [PATCH 04/26] qdev: move helper function to monitor/misc
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org
References: <20200110153039.1379601-1-marcandre.lureau@redhat.com>
 <20200110153039.1379601-5-marcandre.lureau@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <356e02e7-53d3-3b79-47e8-5fa0caeef012@redhat.com>
Date: Fri, 10 Jan 2020 20:18:11 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20200110153039.1379601-5-marcandre.lureau@redhat.com>
Content-Language: en-US
X-MC-Unique: deAVTjmXM0qotVmr3RwwMg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 "Daniel P . Berrange" <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 1/10/20 4:30 PM, Marc-Andr=C3=A9 Lureau wrote:
> Move the one-user function to the place it is being used.
>=20
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

> ---
>   include/hw/qdev-core.h |  2 --
>   hw/core/qdev.c         | 26 --------------------------
>   monitor/misc.c         | 26 ++++++++++++++++++++++++++
>   3 files changed, 26 insertions(+), 28 deletions(-)
>=20
> diff --git a/include/hw/qdev-core.h b/include/hw/qdev-core.h
> index 1518495b1e..6b0e7b265d 100644
> --- a/include/hw/qdev-core.h
> +++ b/include/hw/qdev-core.h
> @@ -457,8 +457,6 @@ extern bool qdev_hot_removed;
>  =20
>   char *qdev_get_dev_path(DeviceState *dev);
>  =20
> -GSList *qdev_build_hotpluggable_device_list(Object *peripheral);
> -
>   void qbus_set_hotplug_handler(BusState *bus, Object *handler, Error **e=
rrp);
>  =20
>   void qbus_set_bus_hotplug_handler(BusState *bus, Error **errp);
> diff --git a/hw/core/qdev.c b/hw/core/qdev.c
> index c2aa7f91a6..a520d7fa89 100644
> --- a/hw/core/qdev.c
> +++ b/hw/core/qdev.c
> @@ -760,32 +760,6 @@ void qdev_alias_all_properties(DeviceState *target, =
Object *source)
>       } while (class !=3D object_class_by_name(TYPE_DEVICE));
>   }
>  =20
> -static int qdev_add_hotpluggable_device(Object *obj, void *opaque)
> -{
> -    GSList **list =3D opaque;
> -    DeviceState *dev =3D (DeviceState *)object_dynamic_cast(OBJECT(obj),
> -                                                          TYPE_DEVICE);
> -
> -    if (dev =3D=3D NULL) {
> -        return 0;
> -    }
> -
> -    if (dev->realized && object_property_get_bool(obj, "hotpluggable", N=
ULL)) {
> -        *list =3D g_slist_append(*list, dev);
> -    }
> -
> -    return 0;
> -}
> -
> -GSList *qdev_build_hotpluggable_device_list(Object *peripheral)
> -{
> -    GSList *list =3D NULL;
> -
> -    object_child_foreach(peripheral, qdev_add_hotpluggable_device, &list=
);
> -
> -    return list;
> -}
> -
>   static bool device_get_realized(Object *obj, Error **errp)
>   {
>       DeviceState *dev =3D DEVICE(obj);
> diff --git a/monitor/misc.c b/monitor/misc.c
> index a04d7edde0..be3c700511 100644
> --- a/monitor/misc.c
> +++ b/monitor/misc.c
> @@ -1954,6 +1954,32 @@ void object_add_completion(ReadLineState *rs, int =
nb_args, const char *str)
>       g_slist_free(list);
>   }
>  =20
> +static int qdev_add_hotpluggable_device(Object *obj, void *opaque)
> +{
> +    GSList **list =3D opaque;
> +    DeviceState *dev =3D (DeviceState *)object_dynamic_cast(OBJECT(obj),
> +                                                          TYPE_DEVICE);
> +
> +    if (dev =3D=3D NULL) {
> +        return 0;
> +    }
> +
> +    if (dev->realized && object_property_get_bool(obj, "hotpluggable", N=
ULL)) {
> +        *list =3D g_slist_append(*list, dev);
> +    }
> +
> +    return 0;
> +}
> +
> +static GSList *qdev_build_hotpluggable_device_list(Object *peripheral)
> +{
> +    GSList *list =3D NULL;
> +
> +    object_child_foreach(peripheral, qdev_add_hotpluggable_device, &list=
);
> +
> +    return list;
> +}
> +
>   static void peripheral_device_del_completion(ReadLineState *rs,
>                                                const char *str, size_t le=
n)
>   {
>=20


