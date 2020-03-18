Return-Path: <SRS0=a3Gm=5D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B16C4C10DCE
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Mar 2020 14:28:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7B7E320772
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Mar 2020 14:28:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UtQcd3zv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B7E320772
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51356 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jEZfz-0001V5-IS
	for qemu-devel@archiver.kernel.org; Wed, 18 Mar 2020 10:28:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55613)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <berrange@redhat.com>) id 1jEZfP-0000zq-OE
 for qemu-devel@nongnu.org; Wed, 18 Mar 2020 10:27:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <berrange@redhat.com>) id 1jEZfN-0001KE-Ge
 for qemu-devel@nongnu.org; Wed, 18 Mar 2020 10:27:30 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:58583)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <berrange@redhat.com>) id 1jEZfN-0001Iz-6h
 for qemu-devel@nongnu.org; Wed, 18 Mar 2020 10:27:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584541648;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SIwDEuAjkCkA6WQUeoeTLkCs7w9SadwAykRb8hXwIlM=;
 b=UtQcd3zvltQF5I0iP1a/8lLnHsJqGRC+O0VROE2pZzJ1gjaikTJdyDqI9l2CQPKXkVmGEl
 iEeck+DLUYpZylSPQHVPiXY1jH0SNnvMmFabUIh0+ZkFSy+kL+Earjglf5qIiX3q5CyC+M
 QkEyMzgl5QwfA191G8sYr4fK19fhcoY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-320-5wjga3nVOlW8xd0tR9fZiw-1; Wed, 18 Mar 2020 10:27:13 -0400
X-MC-Unique: 5wjga3nVOlW8xd0tR9fZiw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8C0AD1005509;
 Wed, 18 Mar 2020 14:27:10 +0000 (UTC)
Received: from redhat.com (ovpn-115-92.ams2.redhat.com [10.36.115.92])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 49BF660BEC;
 Wed, 18 Mar 2020 14:27:03 +0000 (UTC)
Date: Wed, 18 Mar 2020 14:26:54 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Subject: Re: [RFC (fix for 5.0?)] block/io: do not do pointer arithmetic on
 void *
Message-ID: <20200318142654.GH2173309@redhat.com>
References: <20200318142253.2809-1-vsementsov@virtuozzo.com>
MIME-Version: 1.0
In-Reply-To: <20200318142253.2809-1-vsementsov@virtuozzo.com>
User-Agent: Mutt/1.13.3 (2020-01-12)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 63.128.21.74
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: kwolf@redhat.com, fam@euphon.net, qemu-block@nongnu.org,
 qemu-devel@nongnu.org, mreitz@redhat.com, stefanha@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Mar 18, 2020 at 05:22:53PM +0300, Vladimir Sementsov-Ogievskiy wrot=
e:
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>=20
> Hi all!
>=20
> C standard doesn't allow pointer arithmetic on void *.
> Still, gcc allows it as an extension:
>  https://gcc.gnu.org/onlinedocs/gcc-4.8.0/gcc/Pointer-Arith.html
>=20
> I can create a series of patches like this. Do we need it?

I don't think so, we only care about gcc & clang.

> Also, where is documented which compilers are supported by Qemu?

It is checked in configure - gcc 4.8 or clang 3.4 or xcode clang 5.1

>=20
>  block/io.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/block/io.c b/block/io.c
> index aba67f66b9..539178aed5 100644
> --- a/block/io.c
> +++ b/block/io.c
> @@ -1277,7 +1277,7 @@ static int coroutine_fn bdrv_co_do_copy_on_readv(Bd=
rvChild *child,
>       * modifying the image file.  This is critical for zero-copy guest I=
/O
>       * where anything might happen inside guest memory.
>       */
> -    void *bounce_buffer =3D NULL;
> +    char *bounce_buffer =3D NULL;
> =20
>      BlockDriver *drv =3D bs->drv;
>      int64_t cluster_offset;
> --=20
> 2.21.0
>=20
>=20

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange=
 :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com=
 :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange=
 :|


