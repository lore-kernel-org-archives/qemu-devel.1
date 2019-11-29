Return-Path: <SRS0=xfvu=ZV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D35E3C432C0
	for <qemu-devel@archiver.kernel.org>; Fri, 29 Nov 2019 06:15:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9E9232075C
	for <qemu-devel@archiver.kernel.org>; Fri, 29 Nov 2019 06:15:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dVSwTfhg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E9232075C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55224 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iaZZC-0004uA-Mt
	for qemu-devel@archiver.kernel.org; Fri, 29 Nov 2019 01:15:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34145)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1iaZUn-0003GL-M2
 for qemu-devel@nongnu.org; Fri, 29 Nov 2019 01:11:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1iaZUh-0007Z8-9F
 for qemu-devel@nongnu.org; Fri, 29 Nov 2019 01:11:09 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:52349
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1iaZUg-0007Rt-Ob
 for qemu-devel@nongnu.org; Fri, 29 Nov 2019 01:11:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1575007864;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QoYPGNk+zM9N/qsJypP1h/Na1pyVN198ox0H5gcEgRA=;
 b=dVSwTfhg9StLu7Qdizs65sNZzGve+0qx1MtRgpXU23KGDLbX8pDO1goOH3ex+pyV4JC9sd
 Z2FTrJp8UGt2dzOD0+aXUcJEW+GG/9GgKm9/26rCklkj69GUPUY2Uk4rP0pvtT79hGuWoL
 qURHqfiZnS2QEmDjkqefeacQW5Q5eog=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-109-az_WrPdXPFqaA5iAGBPCWg-1; Fri, 29 Nov 2019 01:11:00 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 66F9618C35A1;
 Fri, 29 Nov 2019 06:10:59 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-134.ams2.redhat.com
 [10.36.116.134])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 8C16B5C219;
 Fri, 29 Nov 2019 06:10:56 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 1C5B31138606; Fri, 29 Nov 2019 07:10:55 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Subject: Re: [PATCH v6] backends/cryptodev: drop local_err from
 cryptodev_backend_complete()
References: <20191127194541.24304-1-vsementsov@virtuozzo.com>
Date: Fri, 29 Nov 2019 07:10:55 +0100
In-Reply-To: <20191127194541.24304-1-vsementsov@virtuozzo.com> (Vladimir
 Sementsov-Ogievskiy's message of "Wed, 27 Nov 2019 22:45:41 +0300")
Message-ID: <874kynyzyo.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-MC-Unique: az_WrPdXPFqaA5iAGBPCWg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8
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
Cc: marcandre.lureau@gmail.com, arei.gonglei@huawei.com, philmd@redhat.com,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com> writes:

> No reason for local_err here, use errp directly instead.

Related: "[PATCH v6] hw/vfio/ap: drop local_err from vfio_ap_realize".
I'm surprised it's just two.  Did you search for the anti-pattern
systematically?

> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
>
> v6: add r-b by Philippe and Marc-Andr=C3=A9
>
>  backends/cryptodev.c | 11 +----------
>  1 file changed, 1 insertion(+), 10 deletions(-)
>
> diff --git a/backends/cryptodev.c b/backends/cryptodev.c
> index 3c071eab95..5a9735684e 100644
> --- a/backends/cryptodev.c
> +++ b/backends/cryptodev.c
> @@ -176,19 +176,10 @@ cryptodev_backend_complete(UserCreatable *uc, Error=
 **errp)
>  {
>      CryptoDevBackend *backend =3D CRYPTODEV_BACKEND(uc);
>      CryptoDevBackendClass *bc =3D CRYPTODEV_BACKEND_GET_CLASS(uc);
> -    Error *local_err =3D NULL;
> =20
>      if (bc->init) {
> -        bc->init(backend, &local_err);
> -        if (local_err) {
> -            goto out;
> -        }
> +        bc->init(backend, errp);
>      }
> -
> -    return;
> -
> -out:
> -    error_propagate(errp, local_err);
>  }
> =20
>  void cryptodev_backend_set_used(CryptoDevBackend *backend, bool used)

Reviewed-by: Markus Armbruster <armbru@redhat.com>


