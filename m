Return-Path: <SRS0=bVMU=B5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 764B9C433E1
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Aug 2020 14:46:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2A3392083B
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Aug 2020 14:46:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eYQClLwH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2A3392083B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44080 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k8PLy-0002Dx-CZ
	for qemu-devel@archiver.kernel.org; Wed, 19 Aug 2020 10:46:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50222)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1k8PIG-0005fZ-J7
 for qemu-devel@nongnu.org; Wed, 19 Aug 2020 10:42:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:33139)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1k8PIF-0002m0-1x
 for qemu-devel@nongnu.org; Wed, 19 Aug 2020 10:42:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597848139;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=IhSm4wQXZ9Q2hNIYT+SbkfJfQ/Zhd/PZU5K08y5wyYE=;
 b=eYQClLwHLlByaXXQCSSxHs+Fsfib6bEXfvxV/p12On43VyAETW+VaWAcFgzu9HUBjosKNf
 h+iZ8B8cp9IXu4sbJujrBovuK2Mmjem67tfA+o6QFckP5mMv6IQBiGjBkXJYEbKqMZ7i2q
 +PakfCwvFAQNOXQx1XyG0NVO4zFlfsM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-297-c23_Y8FDOgWRCqLrh-WPRA-1; Wed, 19 Aug 2020 10:42:15 -0400
X-MC-Unique: c23_Y8FDOgWRCqLrh-WPRA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D6D8D1084C89;
 Wed, 19 Aug 2020 14:42:13 +0000 (UTC)
Received: from localhost (ovpn-113-22.ams2.redhat.com [10.36.113.22])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 637A059;
 Wed, 19 Aug 2020 14:42:13 +0000 (UTC)
Date: Wed, 19 Aug 2020 15:42:11 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Subject: Re: [PATCH v3 06/12] block: introduce BDRV_REQ_NO_WAIT flag
Message-ID: <20200819144211.GG366841@stefanha-x1.localdomain>
References: <20200817091553.283155-1-vsementsov@virtuozzo.com>
 <20200817091553.283155-7-vsementsov@virtuozzo.com>
MIME-Version: 1.0
In-Reply-To: <20200817091553.283155-7-vsementsov@virtuozzo.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=stefanha@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="E69HUUNAyIJqGpVn"
Content-Disposition: inline
Received-SPF: pass client-ip=216.205.24.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/19 10:07:28
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
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
Cc: fam@euphon.net, kwolf@redhat.com, qemu-block@nongnu.org, armbru@redhat.com,
 qemu-devel@nongnu.org, mreitz@redhat.com, den@openvz.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--E69HUUNAyIJqGpVn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 17, 2020 at 12:15:47PM +0300, Vladimir Sementsov-Ogievskiy wrot=
e:
> diff --git a/block/io.c b/block/io.c
> index 96b1b9cf5f..fc6d44d302 100644
> --- a/block/io.c
> +++ b/block/io.c
> @@ -1911,9 +1911,20 @@ bdrv_co_write_req_prepare(BdrvChild *child, int64_=
t offset, uint64_t bytes,
>      assert(!(bs->open_flags & BDRV_O_INACTIVE));
>      assert((bs->open_flags & BDRV_O_NO_IO) =3D=3D 0);
>      assert(!(flags & ~BDRV_REQ_MASK));
> +    assert(!((flags & BDRV_REQ_NO_WAIT) && !(flags & BDRV_REQ_SERIALISIN=
G)));
> =20
>      if (flags & BDRV_REQ_SERIALISING) {
> -        bdrv_make_request_serialising(req, bdrv_get_cluster_size(bs));
> +        qemu_co_mutex_lock(&bs->reqs_lock);
> +
> +        tracked_request_set_serialising(req, bdrv_get_cluster_size(bs));
> +
> +        if ((flags & BDRV_REQ_NO_WAIT) && bdrv_find_conflicting_request(=
req)) {
> +            return -EBUSY;

bs->reqs_lock is leaked.

--E69HUUNAyIJqGpVn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl89OkMACgkQnKSrs4Gr
c8gQjwgAwcZaf3w2wnr3XzqWCnYFdFO1PyJVa84e7WCr7BiuwFQvx/3x47PVfWol
cJd2aeQ3sQfLEpZbh+AhsPmHtAi+gCMjy03gTpB4H3iL62PGSPc8AE/JurVvwwp5
zvpPxsJw3AUpTTEbcPCgWRHOAptRHE9OZMevKurHMAQ4WFbyM3QWJFW66rlnPRvr
HGeuqrYGCB5bBo7jqtmoSOjVggX8JCw0qKpZWi8F6dntZ249t2ldfYv1S5Kg/gLX
ACZqHPZ7qqk/iJ3FdUBjJMOLpExANhGdEKFa5GXXcC+ONGq+5QPKfED9ULs+4vhi
8SmSF7aes+hIq7pzgBEjjI+L83W6Vw==
=/5/Q
-----END PGP SIGNATURE-----

--E69HUUNAyIJqGpVn--


