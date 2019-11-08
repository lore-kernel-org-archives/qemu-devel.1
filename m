Return-Path: <SRS0=73np=ZA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.4 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CCD7FC6196
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Nov 2019 21:02:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 398B8206C3
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Nov 2019 21:02:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Lt/QFf7Y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 398B8206C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60418 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iTBPG-0002RY-Cs
	for qemu-devel@archiver.kernel.org; Fri, 08 Nov 2019 16:02:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52888)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <marcandre.lureau@gmail.com>) id 1iTBNF-0001PN-Ap
 for qemu-devel@nongnu.org; Fri, 08 Nov 2019 16:00:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <marcandre.lureau@gmail.com>) id 1iTBNC-0005qQ-IH
 for qemu-devel@nongnu.org; Fri, 08 Nov 2019 16:00:53 -0500
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:36706)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
 id 1iTBNC-0005q3-CC; Fri, 08 Nov 2019 16:00:50 -0500
Received: by mail-wr1-x442.google.com with SMTP id r10so8557860wrx.3;
 Fri, 08 Nov 2019 13:00:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=wyT810R/G/i4yrIjZFSFR3q5EQi2xO2ZVvBWgTmhMR4=;
 b=Lt/QFf7YmZ00AZ5EDMFfcVWyLOmS++vz1lnU25e8Hbv4HwBP0EuQkoaSyuGSnimnNE
 6iqizuu2zUsFIpHAM0v6QJXBtaEsw8Nl0izWIyLlXQ7V9AKcfJpr/nfu/OtTlRx4rrRo
 yzoEcvCr2gJhIy5fWOATHRbNG6tPlm7B9gSvW1rhIZ4Une42qtLh7imZP/Mus0OyepBd
 mItFj44j6iIDS5hdJd35bLJdLvCv/1FKfttBDblQIW93nXygooQJvmu1VCEBgMfP4sCK
 knnDV87i9QgT6fZy2RZV0+YUDygJDpUyHlY75/nTUl33LbaSzVlyg7KLBLa8k2jNfOsQ
 kFlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=wyT810R/G/i4yrIjZFSFR3q5EQi2xO2ZVvBWgTmhMR4=;
 b=qNj8aDEXvWyq0k60dKCRZqlXGBjiAazBqZgAJxn9eDQStRxl0BKuzM8MjmoSjrh9Ub
 b8aiRR6FUqVQarXeQ/CaSh8IscRctUFkwIgD77xsYcR7x+4P/TImfMFPBQNStw7abv/y
 Xwb7V2LNWpHJUow0z+LdUuNHSi39JHz8NOqduPL27gglasVGUMWo8QBTEk9nDbIwqJ2s
 nrsS0xiYZfNYc9ITTmOwaYlNSK1znP4GWp4ynKXyjV0pxLQTT3x4T95g47+dXRAsz07f
 tZdNrDzNH4YLd35utnrhBGVuL5QJ5dRk6dRXQJ2QJPzBTk8OdYYvaVj4EnxeEIZZlmVG
 yu9Q==
X-Gm-Message-State: APjAAAUGauP6aRsj/U/iWwQGNZ+ZLSGNiHioA+fOASpbtTyYEdFhCnnp
 TzFLIrdvCWw6pKqIxtpHVBRMROVSt7Jlce8GtBo=
X-Google-Smtp-Source: APXvYqz+YeoFG2JbzOmBAzP9XylIu9MODw8f/yxMZnZ8O9+rrPyGM7o2IfSR1wc/C4vbZ8759NYgUjuYQzc1SLMip8E=
X-Received: by 2002:adf:f20f:: with SMTP id p15mr9682762wro.370.1573246848578; 
 Fri, 08 Nov 2019 13:00:48 -0800 (PST)
MIME-Version: 1.0
References: <20191011160552.22907-1-vsementsov@virtuozzo.com>
 <20191011160552.22907-24-vsementsov@virtuozzo.com>
In-Reply-To: <20191011160552.22907-24-vsementsov@virtuozzo.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Sat, 9 Nov 2019 01:00:36 +0400
Message-ID: <CAJ+F1CKBXMZTbFQzyNQ+KWyyDyrgma8rD3O6O17yZcPfPvNU3g@mail.gmail.com>
Subject: Re: [RFC v5 023/126] hw/vfio/ap: drop local_err from vfio_ap_realize
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
Cc: Tony Krowiak <akrowiak@linux.ibm.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Pierre Morel <pmorel@linux.ibm.com>, Cornelia Huck <cohuck@redhat.com>,
 QEMU <qemu-devel@nongnu.org>, Markus Armbruster <armbru@redhat.com>,
 Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>,
 Qemu-s390x list <qemu-s390x@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Oct 11, 2019 at 9:27 PM Vladimir Sementsov-Ogievskiy
<vsementsov@virtuozzo.com> wrote:
>
> No reason for local_err here, use errp directly instead.
>
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>  hw/vfio/ap.c | 16 +++-------------
>  1 file changed, 3 insertions(+), 13 deletions(-)
>
> diff --git a/hw/vfio/ap.c b/hw/vfio/ap.c
> index da6a20669d..db816e1860 100644
> --- a/hw/vfio/ap.c
> +++ b/hw/vfio/ap.c
> @@ -87,16 +87,14 @@ static VFIOGroup *vfio_ap_get_group(VFIOAPDevice *vap=
dev, Error **errp)
>
>  static void vfio_ap_realize(DeviceState *dev, Error **errp)
>  {
> -    int ret;
>      char *mdevid;
> -    Error *local_err =3D NULL;
>      VFIOGroup *vfio_group;
>      APDevice *apdev =3D AP_DEVICE(dev);
>      VFIOAPDevice *vapdev =3D VFIO_AP_DEVICE(apdev);
>
> -    vfio_group =3D vfio_ap_get_group(vapdev, &local_err);
> +    vfio_group =3D vfio_ap_get_group(vapdev, errp);
>      if (!vfio_group) {
> -        goto out_err;
> +        return;
>      }
>
>      vapdev->vdev.ops =3D &vfio_ap_ops;
> @@ -113,18 +111,10 @@ static void vfio_ap_realize(DeviceState *dev, Error=
 **errp)
>       */
>      vapdev->vdev.balloon_allowed =3D true;
>
> -    ret =3D vfio_get_device(vfio_group, mdevid, &vapdev->vdev, &local_er=
r);
> -    if (ret) {
> -        goto out_get_dev_err;
> -    }
> -
> -    return;
> +    vfio_get_device(vfio_group, mdevid, &vapdev->vdev, errp);
>
> -out_get_dev_err:
>      vfio_ap_put_device(vapdev);
>      vfio_put_group(vfio_group);
> -out_err:
> -    error_propagate(errp, local_err);
>  }
>
>  static void vfio_ap_unrealize(DeviceState *dev, Error **errp)
> --
> 2.21.0
>
>


Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>


--=20
Marc-Andr=C3=A9 Lureau

