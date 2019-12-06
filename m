Return-Path: <SRS0=8N/K=Z4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF9DAC43603
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Dec 2019 15:48:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 79ED320659
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Dec 2019 15:48:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MurRmRCf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 79ED320659
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40056 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1idFq5-0002x8-OX
	for qemu-devel@archiver.kernel.org; Fri, 06 Dec 2019 10:48:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:48756)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1idElH-0000kW-24
 for qemu-devel@nongnu.org; Fri, 06 Dec 2019 09:39:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1idElF-0001gP-Tq
 for qemu-devel@nongnu.org; Fri, 06 Dec 2019 09:39:14 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:29964
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1idElF-0001f7-Pl
 for qemu-devel@nongnu.org; Fri, 06 Dec 2019 09:39:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1575643153;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=24TZiEsa9WFToT2V3ewXUqAU8uyhbYVoZ91o2XZUhdc=;
 b=MurRmRCfydG1p/lO24PY4vdJev3nHi2Kna1gmRwayyyABcSl5qmQdddrdWrGE88wYHIqa2
 U/rLdPFH7zXWSKtargYtYdJrOx9yIHhofsL35k+qmdloastdkwNGGMTRzORbglV2cj3EPr
 LOTKG1BptvvnWfRgP9vJhDc2yOYzdwQ=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-136-tchFe7fzOU6nnCdU1yojJg-1; Fri, 06 Dec 2019 02:37:51 -0500
Received: by mail-wr1-f69.google.com with SMTP id f1so763321wre.14
 for <qemu-devel@nongnu.org>; Thu, 05 Dec 2019 23:37:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=nx12kXObBCGl7RyZwIueYAz7xt4q+2T+2o6nn0LvO8o=;
 b=G4DiAbPtlW8KodhSFTWSID5FJM+eENK1iOQW5XAADuZcLy0l7YLCHwKYtmzs8Dvwra
 ZYRZBGQ54AjLPq9BdnlcAbt07UayqlCQNz4+STcYd5fV/i+BrgsvQ+PqOGkruO/XCNT4
 bZeDwX0Jh8IHcaI14l09/mi4hXSt6650HP0haRiMkgKK+VDd78RT9rkfv6Xu+wxVfCAa
 GX8V3Ze1VBjXm5hBjqvmcZLdM8dEyNVesITr+DLMKozBdZomCCLj0JG9Rh+9uIzHKEQi
 p4MBj+hHZNycmW0DK6LFW+mJuDu2OhUYDAvUjx5e4skS3TLelUPzhX3n2cv95LtMjwra
 WnaQ==
X-Gm-Message-State: APjAAAVp7x4IcS4JKqRF6v/m8j9mnlwAaAR6b7fjqSqf7EZFXs84erGE
 qy2Vnq7YruO4M9MXkkaWhuNTQ6xtt1baKYrS2RKQV2PSXO/8KeHZv/cB1MFGSGnFtXXeDvE3hGf
 8T6am3vdBpnh3YCc=
X-Received: by 2002:a1c:6086:: with SMTP id u128mr8950843wmb.131.1575617869021; 
 Thu, 05 Dec 2019 23:37:49 -0800 (PST)
X-Google-Smtp-Source: APXvYqwOKN1MrAniCQ0BxbraqhRuAwNxb9CwjVKPYIKA0+2+7t1HGR/++KV4s6kleb4bYc1ZpFUYFQ==
X-Received: by 2002:a1c:6086:: with SMTP id u128mr8950823wmb.131.1575617868831; 
 Thu, 05 Dec 2019 23:37:48 -0800 (PST)
Received: from [192.168.1.35] (182.red-88-21-103.staticip.rima-tde.net.
 [88.21.103.182])
 by smtp.gmail.com with ESMTPSA id o1sm15452959wrn.84.2019.12.05.23.37.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 05 Dec 2019 23:37:48 -0800 (PST)
Subject: Re: [PATCH v8 14/21] hw/s390x: rename Error ** parameter to more
 common errp
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-devel@nongnu.org
References: <20191205174635.18758-1-vsementsov@virtuozzo.com>
 <20191205174635.18758-15-vsementsov@virtuozzo.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <f9c61820-9ae7-e197-fa24-d28e29140866@redhat.com>
Date: Fri, 6 Dec 2019 08:37:47 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191205174635.18758-15-vsementsov@virtuozzo.com>
Content-Language: en-US
X-MC-Unique: tchFe7fzOU6nnCdU1yojJg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252; format=flowed
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
Cc: David Hildenbrand <david@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 armbru@redhat.com, Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>, qemu-s390x@nongnu.org,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 12/5/19 6:46 PM, Vladimir Sementsov-Ogievskiy wrote:
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> Reviewed-by: Cornelia Huck <cohuck@redhat.com>

Reviewed-by: Philippe Mathieu-Daud=E9 <philmd@redhat.com>

> ---
>   hw/s390x/event-facility.c | 2 +-
>   hw/s390x/s390-stattrib.c  | 3 ++-
>   2 files changed, 3 insertions(+), 2 deletions(-)
>=20
> diff --git a/hw/s390x/event-facility.c b/hw/s390x/event-facility.c
> index 66205697ae..dc733ee2af 100644
> --- a/hw/s390x/event-facility.c
> +++ b/hw/s390x/event-facility.c
> @@ -439,7 +439,7 @@ static void sclp_event_set_allow_all_mask_sizes(Objec=
t *obj, bool value,
>       ef->allow_all_mask_sizes =3D value;
>   }
>  =20
> -static bool sclp_event_get_allow_all_mask_sizes(Object *obj, Error **e)
> +static bool sclp_event_get_allow_all_mask_sizes(Object *obj, Error **err=
p)
>   {
>       SCLPEventFacility *ef =3D (SCLPEventFacility *)obj;
>  =20
> diff --git a/hw/s390x/s390-stattrib.c b/hw/s390x/s390-stattrib.c
> index bf5ac014c4..58121b9f68 100644
> --- a/hw/s390x/s390-stattrib.c
> +++ b/hw/s390x/s390-stattrib.c
> @@ -352,7 +352,8 @@ static void s390_stattrib_class_init(ObjectClass *oc,=
 void *data)
>       dc->realize =3D s390_stattrib_realize;
>   }
>  =20
> -static inline bool s390_stattrib_get_migration_enabled(Object *obj, Erro=
r **e)
> +static inline bool s390_stattrib_get_migration_enabled(Object *obj,
> +                                                       Error **errp)
>   {
>       S390StAttribState *s =3D S390_STATTRIB(obj);
>  =20
>=20


