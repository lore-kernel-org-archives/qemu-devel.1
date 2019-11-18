Return-Path: <SRS0=QE2o=ZK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83C89C432C3
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Nov 2019 18:55:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 50EC7222ED
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Nov 2019 18:55:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XpFWtRJ4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 50EC7222ED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38302 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iWmBp-00077G-Ee
	for qemu-devel@archiver.kernel.org; Mon, 18 Nov 2019 13:55:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42304)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <ehabkost@redhat.com>) id 1iWmAu-00060U-9D
 for qemu-devel@nongnu.org; Mon, 18 Nov 2019 13:55:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <ehabkost@redhat.com>) id 1iWmAt-00054W-4o
 for qemu-devel@nongnu.org; Mon, 18 Nov 2019 13:55:00 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:36358
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1iWmAt-00054P-0V
 for qemu-devel@nongnu.org; Mon, 18 Nov 2019 13:54:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574103298;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lLJaR17OdpMM/MSrxIrdIGLU/eZlORloLpviZq+sMEU=;
 b=XpFWtRJ4F8IikqRdphb485bqWavPQ2W2JjLJnOGEisYk7nD1o6kv/MnAYY8pLm8TRY7Woz
 hQI88iC6E3oKNVvyfqp3XF9ttv6YkXLjGE3ivnZ1v8DjNOnsGnL8vygUjXHP8/JCaknNjr
 ipANDDUPVwh7FtrcQa3/Ss95NbAvIIo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-262-3YlGJxrRM2SPDYL5hM1OsQ-1; Mon, 18 Nov 2019 13:54:56 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AA70A1883525;
 Mon, 18 Nov 2019 18:54:55 +0000 (UTC)
Received: from localhost (ovpn-116-6.gru2.redhat.com [10.97.116.6])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 0EC7F19C4F;
 Mon, 18 Nov 2019 18:54:54 +0000 (UTC)
Date: Mon, 18 Nov 2019 15:54:53 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
To: Denis Plotnikov <dplotnikov@virtuozzo.com>
Subject: Re: [PATCH v0 1/2] qdev-properties-system: extend set_pionter for
 unrealized devices
Message-ID: <20191118185453.GC3812@habkost.net>
References: <20191110190310.19799-1-dplotnikov@virtuozzo.com>
 <20191110190310.19799-2-dplotnikov@virtuozzo.com>
MIME-Version: 1.0
In-Reply-To: <20191110190310.19799-2-dplotnikov@virtuozzo.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: 3YlGJxrRM2SPDYL5hM1OsQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
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
Cc: kwolf@redhat.com, vsementsov@virtuozzo.com, berrange@redhat.com,
 den@virtuozzo.com, qemu-block@nongnu.org, qemu-devel@nongnu.org,
 mreitz@redhat.com, pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sun, Nov 10, 2019 at 10:03:09PM +0300, Denis Plotnikov wrote:
> Some device's property can be changed if the device has been already
> realized. For example, it could be "drive" property of a scsi disk device=
.
>=20
> So far, set_pointer could operate only on a relized device. The patch
> extends its interface for operation on an unrealized device.
>=20
> Signed-off-by: Denis Plotnikov <dplotnikov@virtuozzo.com>
> ---
>  hw/core/qdev-properties-system.c | 32 +++++++++++++++++++++-----------
>  1 file changed, 21 insertions(+), 11 deletions(-)
>=20
> diff --git a/hw/core/qdev-properties-system.c b/hw/core/qdev-properties-s=
ystem.c
> index ba412dd2ca..c534590dcd 100644
> --- a/hw/core/qdev-properties-system.c
> +++ b/hw/core/qdev-properties-system.c
> @@ -38,9 +38,14 @@ static void get_pointer(Object *obj, Visitor *v, Prope=
rty *prop,
>  }
> =20
>  static void set_pointer(Object *obj, Visitor *v, Property *prop,
> -                        void (*parse)(DeviceState *dev, const char *str,
> -                                      void **ptr, const char *propname,
> -                                      Error **errp),
> +                        void (*parse_realized)(DeviceState *dev,
> +                                               const char *str, void **p=
tr,
> +                                               const char *propname,
> +                                               Error **errp),
> +                        void (*parse_unrealized)(DeviceState *dev,
> +                                                 const char *str, void *=
*ptr,
> +                                                 const char *propname,
> +                                                 Error **errp),
>                          const char *name, Error **errp)

Wouldn't it be simpler to just add a PropertyInfo::allow_set_after_realize
bool field, and call the same setter function?  Then you can
simply change do_parse_drive() to check if realized is true.

>  {
>      DeviceState *dev =3D DEVICE(obj);
> @@ -48,11 +53,6 @@ static void set_pointer(Object *obj, Visitor *v, Prope=
rty *prop,
>      void **ptr =3D qdev_get_prop_ptr(dev, prop);
>      char *str;
> =20
> -    if (dev->realized) {
> -        qdev_prop_set_after_realize(dev, name, errp);
> -        return;
> -    }
> -
>      visit_type_str(v, name, &str, &local_err);
>      if (local_err) {
>          error_propagate(errp, local_err);
> @@ -63,7 +63,17 @@ static void set_pointer(Object *obj, Visitor *v, Prope=
rty *prop,
>          *ptr =3D NULL;
>          return;
>      }
> -    parse(dev, str, ptr, prop->name, errp);
> +
> +    if (dev->realized) {
> +        if (parse_realized) {
> +            parse_realized(dev, str, ptr, prop->name, errp);
> +        } else {
> +            qdev_prop_set_after_realize(dev, name, errp);
> +        }
> +    } else {
> +        parse_unrealized(dev, str, ptr, prop->name, errp);
> +    }
> +
>      g_free(str);
>  }
> =20
> @@ -178,13 +188,13 @@ static void get_drive(Object *obj, Visitor *v, cons=
t char *name, void *opaque,
>  static void set_drive(Object *obj, Visitor *v, const char *name, void *o=
paque,
>                        Error **errp)
>  {
> -    set_pointer(obj, v, opaque, parse_drive, name, errp);
> +    set_pointer(obj, v, opaque, NULL, parse_drive, name, errp);
>  }
> =20
>  static void set_drive_iothread(Object *obj, Visitor *v, const char *name=
,
>                                 void *opaque, Error **errp)
>  {
> -    set_pointer(obj, v, opaque, parse_drive_iothread, name, errp);
> +    set_pointer(obj, v, opaque, NULL, parse_drive_iothread, name, errp);
>  }
> =20
>  const PropertyInfo qdev_prop_drive =3D {
> --=20
> 2.17.0
>=20

--=20
Eduardo


