Return-Path: <SRS0=73np=ZA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.4 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06450FC6196
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Nov 2019 20:57:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BA1DC214DB
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Nov 2019 20:57:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Yi0gIHV/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BA1DC214DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60326 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iTBJU-0007Fe-U4
	for qemu-devel@archiver.kernel.org; Fri, 08 Nov 2019 15:57:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52010)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <marcandre.lureau@gmail.com>) id 1iTBIk-0006ke-RN
 for qemu-devel@nongnu.org; Fri, 08 Nov 2019 15:56:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <marcandre.lureau@gmail.com>) id 1iTBIj-00031M-Mh
 for qemu-devel@nongnu.org; Fri, 08 Nov 2019 15:56:14 -0500
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:37547)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
 id 1iTBIj-000310-EN
 for qemu-devel@nongnu.org; Fri, 08 Nov 2019 15:56:13 -0500
Received: by mail-wr1-x442.google.com with SMTP id t1so8536160wrv.4
 for <qemu-devel@nongnu.org>; Fri, 08 Nov 2019 12:56:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=NzJmXAGXwTKAL5SyQxEUp59S86q+GhuJWH0OEyVhcTo=;
 b=Yi0gIHV/z6a0DPLufo3sTSY8Airm/id3GhJEURvlRqMa9yvNHeeopGBjQ3Of3CS/If
 //IjX7LUUpDMPb88h5MonuXE9l1MYRsZNcNly/hL7poqbnMz+0BZAhzH14VX6wq04ghL
 hoURuCc1cfRhbWbJPPLGZBp8jXF4im97++wGPNmHkjnMhxVqbSwBe6PA8MSvDGWS73qa
 GHX53LxFzhTbLIiWBob5lNbeCNz9fDs4GfdPMXmTmhiMyP2cxW9TYXpD3zwO/R4VVzZw
 jqJkJUgLJNurn7uhK8k8h2PDtgHqFlUcPbpDZf2g2ZS8ygB5/8gmKDLTMfpeKk8RYOWK
 wCcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=NzJmXAGXwTKAL5SyQxEUp59S86q+GhuJWH0OEyVhcTo=;
 b=t7fPp1ZYFOxEG9hI74Fw1sQANElqM8sPr0rK9wR3z/hAVJt1ZEzA9J4s4iWHSRTGV7
 FH2xnDZt0XflLXu1U1zSe0MaiTA3Tw8MIfJH4UIul96pBTs8l754EBTlaaBSMukhKqwP
 KafldtqSFoqs5dh4uQ2vq68ok43RMBjVdFNO5KtvzDjoHHkFPar0k5xRnA/w5G5snXpw
 s7Yl4dD3XL5gSxP1Fo1eQd5IiXu1tcCPo5o5IXP2UkuWjNU6HvibeAIcveCgj0ZeiquZ
 yhN3hZTR2/PNuBHQsGnXXxpc2mJzvZRNfGxX0LBPzdHXquSG3mEVH3tv1e6rPrbikr4s
 mr0w==
X-Gm-Message-State: APjAAAWdFhJLQTc+VnxbzexHql1EUnN/cLtCzRY/Z7LfhIfrKILdXp0Y
 joZnjNpdjX4egCXo8Uc2rEbGhujttQh7yxZpBNU=
X-Google-Smtp-Source: APXvYqyYnvPUJgNBA8U//eMYMG+IqzKgXpse6bwmw60+ltHWiRjUch7KltNsk65DOhADbYcLsBgm5ilyD2S0F4/5SqI=
X-Received: by 2002:adf:ef0f:: with SMTP id e15mr10247086wro.312.1573246571919; 
 Fri, 08 Nov 2019 12:56:11 -0800 (PST)
MIME-Version: 1.0
References: <20191011160552.22907-1-vsementsov@virtuozzo.com>
 <20191011160552.22907-11-vsementsov@virtuozzo.com>
In-Reply-To: <20191011160552.22907-11-vsementsov@virtuozzo.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Sat, 9 Nov 2019 00:55:59 +0400
Message-ID: <CAJ+F1CKwSDM=zjQeTU=Tx5dQSQj_RVjnGqdN+qEV5AkiWXrQxQ@mail.gmail.com>
Subject: Re: [RFC v5 010/126] hw/core/qdev: cleanup Error ** variables
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::442
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
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 QEMU <qemu-devel@nongnu.org>, Eduardo Habkost <ehabkost@redhat.com>,
 Markus Armbruster <armbru@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Oct 11, 2019 at 8:18 PM Vladimir Sementsov-Ogievskiy
<vsementsov@virtuozzo.com> wrote:
>
> Rename Error ** parameter in check_only_migratable to common errp.
>
> In device_set_realized:
>
>  - Move "if (local_err !=3D NULL)" closer to error setters.
>
>  - Drop 'Error **local_errp': it doesn't save any LoCs, but it's very
>    unusual.
>
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>  hw/core/qdev.c | 28 +++++++++++++---------------
>  1 file changed, 13 insertions(+), 15 deletions(-)
>
> diff --git a/hw/core/qdev.c b/hw/core/qdev.c
> index cbad6c1d55..e3be8cc3c4 100644
> --- a/hw/core/qdev.c
> +++ b/hw/core/qdev.c
> @@ -796,12 +796,12 @@ static bool device_get_realized(Object *obj, Error =
**errp)
>      return dev->realized;
>  }
>
> -static bool check_only_migratable(Object *obj, Error **err)
> +static bool check_only_migratable(Object *obj, Error **errp)
>  {
>      DeviceClass *dc =3D DEVICE_GET_CLASS(obj);
>
>      if (!vmstate_check_only_migratable(dc->vmsd)) {
> -        error_setg(err, "Device %s is not migratable, but "
> +        error_setg(errp, "Device %s is not migratable, but "
>                     "--only-migratable was specified",
>                     object_get_typename(obj));
>          return false;
> @@ -850,10 +850,9 @@ static void device_set_realized(Object *obj, bool va=
lue, Error **errp)
>
>          if (dc->realize) {
>              dc->realize(dev, &local_err);
> -        }
> -
> -        if (local_err !=3D NULL) {
> -            goto fail;
> +            if (local_err !=3D NULL) {
> +                goto fail;
> +            }
>          }
>
>          DEVICE_LISTENER_CALL(realize, Forward, dev);
> @@ -894,27 +893,26 @@ static void device_set_realized(Object *obj, bool v=
alue, Error **errp)
>         }
>
>      } else if (!value && dev->realized) {
> -        Error **local_errp =3D NULL;
> +        /* We want to catch in local_err only first error */
>          QLIST_FOREACH(bus, &dev->child_bus, sibling) {
> -            local_errp =3D local_err ? NULL : &local_err;
>              object_property_set_bool(OBJECT(bus), false, "realized",
> -                                     local_errp);
> +                                     local_err ? NULL : &local_err);
>          }
>          if (qdev_get_vmsd(dev)) {
>              vmstate_unregister(dev, qdev_get_vmsd(dev), dev);
>          }
>          if (dc->unrealize) {
> -            local_errp =3D local_err ? NULL : &local_err;
> -            dc->unrealize(dev, local_errp);
> +            dc->unrealize(dev, local_err ? NULL : &local_err);
>          }
>          dev->pending_deleted_event =3D true;
>          DEVICE_LISTENER_CALL(unrealize, Reverse, dev);
> -    }
>
> -    if (local_err !=3D NULL) {
> -        goto fail;
> +        if (local_err !=3D NULL) {
> +            goto fail;
> +        }
>      }
>
> +    assert(local_err =3D=3D NULL);
>      dev->realized =3D value;
>      return;
>
> @@ -952,7 +950,7 @@ static bool device_get_hotpluggable(Object *obj, Erro=
r **errp)
>                                  qbus_is_hotpluggable(dev->parent_bus));
>  }
>
> -static bool device_get_hotplugged(Object *obj, Error **err)
> +static bool device_get_hotplugged(Object *obj, Error **errp)
>  {
>      DeviceState *dev =3D DEVICE(obj);
>
> --
> 2.21.0
>
>

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>


--=20
Marc-Andr=C3=A9 Lureau

