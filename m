Return-Path: <SRS0=8N/K=Z4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15279C43603
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Dec 2019 15:56:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D4B122173E
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Dec 2019 15:56:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NoEV7MIE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D4B122173E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40214 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1idFyT-0005PW-G2
	for qemu-devel@archiver.kernel.org; Fri, 06 Dec 2019 10:56:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41085)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1idEjf-0007I7-BR
 for qemu-devel@nongnu.org; Fri, 06 Dec 2019 09:37:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1idEjY-0007dV-BS
 for qemu-devel@nongnu.org; Fri, 06 Dec 2019 09:37:31 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:46182
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1idEjR-0007Xh-PC
 for qemu-devel@nongnu.org; Fri, 06 Dec 2019 09:37:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1575643036;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=edIubUtxN8p98bHFFpzdA868v3MEHjCgp23RKrnXBGg=;
 b=NoEV7MIE3KlJ29HMgrWWZoZrHbpW6URChD8wXcXkLhCVB0fW/d6t9lQd5oqxciSMurs7Br
 1fAWsqnWBuyRPcL6JzivZ5KraD1A7A1LTKC5SLFGx9idO4fRFs/bxactcVX5YNmD+Hlfsm
 VYlWiSsPIYBpv8ezmLU5o/JQTsIEE4g=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-69-YaxERqgRPBmyu922apLhvw-1; Fri, 06 Dec 2019 02:30:32 -0500
Received: by mail-wm1-f70.google.com with SMTP id i17so1795248wmd.1
 for <qemu-devel@nongnu.org>; Thu, 05 Dec 2019 23:30:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=vNjyLWrM+FG8hGz0yX7fG1I5NSM7ahQ0F2usQSKaFX4=;
 b=dofcFkS4YMapGibWOCQSycRzkeewLx0TO7hbQ/YgJsJgRSqHyKYLp6Wst67GruTdAG
 CO16lD43NFPLImmFoRHkzHMPRiFYvDeoxzZikVvh+LtMRpvPhcrShJvlYNZz8B1d1+ZL
 QZHAD6ZkTvYY82Ouxb/VnPPnemSlJUkAW8wYMMrWtkC4WUyuJAbt1BZKW7vgQVlKtRL3
 cSuv+g15j/6cZIBhvXZibx2Pi81mkExPdtSM5BgH9r5kK1X2LY9C8L6CVlyiwCILo4tZ
 DM/5vY5nl2A7hiO1aCqIOSX6Orwj4i0l+maw4w/lvrwxlisMKUvKDdETSlJdtAlmFNNg
 1rkQ==
X-Gm-Message-State: APjAAAWWFdW54eURSkYqaGs/3OjKMzvGgvAHt34GAkAjOJvL/vuByfj0
 HN++jPH53uks66l2HvOSByCdGxb260JZXNt04Bc5idIeRLCBVl23dx5v22KAcDA3pK7UcX/QMFv
 eRVRDHlb3VOLfn/s=
X-Received: by 2002:a1c:8055:: with SMTP id b82mr9016841wmd.127.1575617430632; 
 Thu, 05 Dec 2019 23:30:30 -0800 (PST)
X-Google-Smtp-Source: APXvYqzQ3eXy3DcLf0/GcpZ5RoqMXz1MbJ6oyjh1xGy/yWTNarLezsUTgdedxuwvvydvScptrB3DUg==
X-Received: by 2002:a1c:8055:: with SMTP id b82mr9016820wmd.127.1575617430428; 
 Thu, 05 Dec 2019 23:30:30 -0800 (PST)
Received: from [192.168.1.35] (182.red-88-21-103.staticip.rima-tde.net.
 [88.21.103.182])
 by smtp.gmail.com with ESMTPSA id c4sm2505569wml.7.2019.12.05.23.30.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 05 Dec 2019 23:30:29 -0800 (PST)
Subject: Re: [PATCH v8 05/21] vnc: drop Error pointer indirection in
 vnc_client_io_error
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-devel@nongnu.org
References: <20191205174635.18758-1-vsementsov@virtuozzo.com>
 <20191205174635.18758-6-vsementsov@virtuozzo.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <36f97ef3-e2cc-3370-de51-f33285395544@redhat.com>
Date: Fri, 6 Dec 2019 08:30:29 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191205174635.18758-6-vsementsov@virtuozzo.com>
Content-Language: en-US
X-MC-Unique: YaxERqgRPBmyu922apLhvw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252; format=flowed
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
Cc: armbru@redhat.com, Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 12/5/19 6:46 PM, Vladimir Sementsov-Ogievskiy wrote:
> We don't need Error **, as all callers pass local Error object, which
> isn't used after the call, or NULL. Use Error * instead.
>=20
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> Reviewed-by: Markus Armbruster <armbru@redhat.com>

Reviewed-by: Philippe Mathieu-Daud=E9 <philmd@redhat.com>

> ---
>   ui/vnc.h |  2 +-
>   ui/vnc.c | 20 +++++++-------------
>   2 files changed, 8 insertions(+), 14 deletions(-)
>=20
> diff --git a/ui/vnc.h b/ui/vnc.h
> index fea79c2fc9..4e2637ce6c 100644
> --- a/ui/vnc.h
> +++ b/ui/vnc.h
> @@ -547,7 +547,7 @@ uint32_t read_u32(uint8_t *data, size_t offset);
>  =20
>   /* Protocol stage functions */
>   void vnc_client_error(VncState *vs);
> -size_t vnc_client_io_error(VncState *vs, ssize_t ret, Error **errp);
> +size_t vnc_client_io_error(VncState *vs, ssize_t ret, Error *err);
>  =20
>   void start_client_init(VncState *vs);
>   void start_auth_vnc(VncState *vs);
> diff --git a/ui/vnc.c b/ui/vnc.c
> index 87b8045afe..4100d6e404 100644
> --- a/ui/vnc.c
> +++ b/ui/vnc.c
> @@ -1312,7 +1312,7 @@ void vnc_disconnect_finish(VncState *vs)
>       g_free(vs);
>   }
>  =20
> -size_t vnc_client_io_error(VncState *vs, ssize_t ret, Error **errp)
> +size_t vnc_client_io_error(VncState *vs, ssize_t ret, Error *err)
>   {
>       if (ret <=3D 0) {
>           if (ret =3D=3D 0) {
> @@ -1320,15 +1320,11 @@ size_t vnc_client_io_error(VncState *vs, ssize_t =
ret, Error **errp)
>               vnc_disconnect_start(vs);
>           } else if (ret !=3D QIO_CHANNEL_ERR_BLOCK) {
>               trace_vnc_client_io_error(vs, vs->ioc,
> -                                      errp ? error_get_pretty(*errp) :
> -                                      "Unknown");
> +                                      err ? error_get_pretty(err) : "Unk=
nown");
>               vnc_disconnect_start(vs);
>           }
>  =20
> -        if (errp) {
> -            error_free(*errp);
> -            *errp =3D NULL;
> -        }
> +        error_free(err);
>           return 0;
>       }
>       return ret;
> @@ -1361,10 +1357,9 @@ size_t vnc_client_write_buf(VncState *vs, const ui=
nt8_t *data, size_t datalen)
>   {
>       Error *err =3D NULL;
>       ssize_t ret;
> -    ret =3D qio_channel_write(
> -        vs->ioc, (const char *)data, datalen, &err);
> +    ret =3D qio_channel_write(vs->ioc, (const char *)data, datalen, &err=
);
>       VNC_DEBUG("Wrote wire %p %zd -> %ld\n", data, datalen, ret);
> -    return vnc_client_io_error(vs, ret, &err);
> +    return vnc_client_io_error(vs, ret, err);
>   }
>  =20
>  =20
> @@ -1488,10 +1483,9 @@ size_t vnc_client_read_buf(VncState *vs, uint8_t *=
data, size_t datalen)
>   {
>       ssize_t ret;
>       Error *err =3D NULL;
> -    ret =3D qio_channel_read(
> -        vs->ioc, (char *)data, datalen, &err);
> +    ret =3D qio_channel_read(vs->ioc, (char *)data, datalen, &err);
>       VNC_DEBUG("Read wire %p %zd -> %ld\n", data, datalen, ret);
> -    return vnc_client_io_error(vs, ret, &err);
> +    return vnc_client_io_error(vs, ret, err);
>   }
>  =20
>  =20
>=20


