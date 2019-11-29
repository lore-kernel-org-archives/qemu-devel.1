Return-Path: <SRS0=xfvu=ZV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EC44C432C0
	for <qemu-devel@archiver.kernel.org>; Fri, 29 Nov 2019 06:15:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 21C742075C
	for <qemu-devel@archiver.kernel.org>; Fri, 29 Nov 2019 06:15:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VVHsXOvm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 21C742075C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55222 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iaZZ6-0004tf-9Z
	for qemu-devel@archiver.kernel.org; Fri, 29 Nov 2019 01:15:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57218)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1iaZRe-0001iG-BC
 for qemu-devel@nongnu.org; Fri, 29 Nov 2019 01:08:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1iaZRU-0005K0-Tu
 for qemu-devel@nongnu.org; Fri, 29 Nov 2019 01:07:49 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:31663
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1iaZRU-0005AI-PQ
 for qemu-devel@nongnu.org; Fri, 29 Nov 2019 01:07:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1575007665;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vK8WGGz/xuwo1IW7E3ATDDx68EVANPwPZ0qEE2rhWLY=;
 b=VVHsXOvmNj8ZTx3OnqVIbtCC+Nyo00iQoKtJFG4FBmvMzseRVL/Yb8UL5L32s47J1ftdXB
 82k+gw6JqU4rXGdTOckwyTqNlU4+XgWLLsiUPX6/UFdqCLY2dchIIU5lYbPJoJj3o5WXky
 pS7dLwLGrwiso6/UhmBW7XtkDCJxOj0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-131-uB1132GiPtOda3wrrrEMpg-1; Fri, 29 Nov 2019 01:07:44 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 59565593A2;
 Fri, 29 Nov 2019 06:07:43 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-134.ams2.redhat.com
 [10.36.116.134])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 5B16119C4F;
 Fri, 29 Nov 2019 06:07:40 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id C98401138606; Fri, 29 Nov 2019 07:07:38 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Subject: Re: [PATCH v6] hw/core/qdev: cleanup Error ** variables
References: <20191127192025.21594-1-vsementsov@virtuozzo.com>
Date: Fri, 29 Nov 2019 07:07:38 +0100
In-Reply-To: <20191127192025.21594-1-vsementsov@virtuozzo.com> (Vladimir
 Sementsov-Ogievskiy's message of "Wed, 27 Nov 2019 22:20:25 +0300")
Message-ID: <87a78fz045.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: uB1132GiPtOda3wrrrEMpg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: marcandre.lureau@redhat.com, pbonzini@redhat.com, berrange@redhat.com,
 qemu-devel@nongnu.org, ehabkost@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com> writes:

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
> Reviewed-by: Eric Blake <eblake@redhat.com>
> Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
>
> v6: enhance grammar in comment [Eric]
>     add r-b by Eric and Marc-Andr=C3=A9
>
>  hw/core/qdev.c | 28 +++++++++++++---------------
>  1 file changed, 13 insertions(+), 15 deletions(-)
>
> diff --git a/hw/core/qdev.c b/hw/core/qdev.c
> index cf1ba28fe3..82d3ee590a 100644
> --- a/hw/core/qdev.c
> +++ b/hw/core/qdev.c
> @@ -820,12 +820,12 @@ static bool device_get_realized(Object *obj, Error =
**errp)
>      return dev->realized;
>  }
> =20
> -static bool check_only_migratable(Object *obj, Error **err)
> +static bool check_only_migratable(Object *obj, Error **errp)
>  {
>      DeviceClass *dc =3D DEVICE_GET_CLASS(obj);
> =20
>      if (!vmstate_check_only_migratable(dc->vmsd)) {
> -        error_setg(err, "Device %s is not migratable, but "
> +        error_setg(errp, "Device %s is not migratable, but "
>                     "--only-migratable was specified",
>                     object_get_typename(obj));
>          return false;
> @@ -874,10 +874,9 @@ static void device_set_realized(Object *obj, bool va=
lue, Error **errp)
> =20
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

Yes, this is the more conventional usage.

> =20
>          DEVICE_LISTENER_CALL(realize, Forward, dev);
> @@ -918,27 +917,26 @@ static void device_set_realized(Object *obj, bool v=
alue, Error **errp)
>         }
> =20
>      } else if (!value && dev->realized) {
> -        Error **local_errp =3D NULL;
> +        /* We want local_err to track only the first error */
>          QLIST_FOREACH(bus, &dev->child_bus, sibling) {
> -            local_errp =3D local_err ? NULL : &local_err;
>              object_property_set_bool(OBJECT(bus), false, "realized",
> -                                     local_errp);
> +                                     local_err ? NULL : &local_err);
>          }

This is a rather unusual way to keep the first error of several.
qapi/error.h advises:

 * Receive and accumulate multiple errors (first one wins):
 *     Error *err =3D NULL, *local_err =3D NULL;
 *     foo(arg, &err);
 *     bar(arg, &local_err);
 *     error_propagate(&err, local_err);
 *     if (err) {
 *         handle the error...
 *     }

If replacing this by the usual way is too troublesome now, we can do it
after the ERRP_AUTO_PROPAGATE() conversion.  Your choice.

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
> =20
> -    if (local_err !=3D NULL) {
> -        goto fail;
> +        if (local_err !=3D NULL) {
> +            goto fail;
> +        }
>      }
> =20
> +    assert(local_err =3D=3D NULL);

Not sure this one's worth it's keep with the usage of local_err cleaned
up.

>      dev->realized =3D value;
>      return;
> =20
> @@ -976,7 +974,7 @@ static bool device_get_hotpluggable(Object *obj, Erro=
r **errp)
>                                  qbus_is_hotpluggable(dev->parent_bus));
>  }
> =20
> -static bool device_get_hotplugged(Object *obj, Error **err)
> +static bool device_get_hotplugged(Object *obj, Error **errp)
>  {
>      DeviceState *dev =3D DEVICE(obj);

In case you want to clean up afterwards rather than now:
Reviewed-by: Markus Armbruster <armbru@redhat.com>


