Return-Path: <SRS0=IvAo=6E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8418EC3815B
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Apr 2020 16:41:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 51B2F20857
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Apr 2020 16:41:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GFwLJgEg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 51B2F20857
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39224 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jQZTo-0001wE-P8
	for qemu-devel@archiver.kernel.org; Mon, 20 Apr 2020 12:41:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51710 helo=eggs1p.gnu.org)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@redhat.com>) id 1jQZSp-0001AJ-BN
 for qemu-devel@nongnu.org; Mon, 20 Apr 2020 12:40:07 -0400
Received: from Debian-exim by eggs1p.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <stefanha@redhat.com>) id 1jQZSo-0006Ug-Rt
 for qemu-devel@nongnu.org; Mon, 20 Apr 2020 12:40:07 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:60349
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1jQZSo-0006Sx-Fp
 for qemu-devel@nongnu.org; Mon, 20 Apr 2020 12:40:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1587400805;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=yk3+eDpcuFgqvL9le4ML7YqBWkdHkuA6OBrhw55W61Y=;
 b=GFwLJgEgIz/T32fySHyIuvovKVTqOBUsJ4Tc3LKnUTbsIOFanxCouTMjROKwOwXnl5HPTx
 2/82sgI8Dv3OBT9uIwZX8Ky6Nj59akH0NP22/ty6IVf5LF08KAAz61u9BibkxkOnGWya3q
 T6ik9MHQmWYvbnyZJdEC+gasg8H5F+A=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-267-sriA4DBwOvmpp6OHT2KDzg-1; Mon, 20 Apr 2020 12:40:03 -0400
X-MC-Unique: sriA4DBwOvmpp6OHT2KDzg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D82AD107ACC4;
 Mon, 20 Apr 2020 16:40:01 +0000 (UTC)
Received: from localhost (ovpn-112-169.ams2.redhat.com [10.36.112.169])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 6AF3458;
 Mon, 20 Apr 2020 16:40:01 +0000 (UTC)
Date: Mon, 20 Apr 2020 17:40:00 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Subject: Re: [PATCH 8/9] block/io: move bdrv_make_zero under block-status
Message-ID: <20200420164000.GG7321@stefanha-x1.localdomain>
References: <20200408093051.9893-1-vsementsov@virtuozzo.com>
 <20200408093051.9893-9-vsementsov@virtuozzo.com>
MIME-Version: 1.0
In-Reply-To: <20200408093051.9893-9-vsementsov@virtuozzo.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="7lMq7vMTJT4tNk0a"
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.81; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs1p.gnu.org: First seen = 2020/04/20
 01:47:04
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
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
Cc: kwolf@redhat.com, fam@euphon.net, qemu-block@nongnu.org,
 qemu-devel@nongnu.org, mreitz@redhat.com, den@openvz.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--7lMq7vMTJT4tNk0a
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 08, 2020 at 12:30:50PM +0300, Vladimir Sementsov-Ogievskiy wrot=
e:
> We are going to use bdrv_co_block_status in bdrv_make_zero, so move it
> now down.
>=20
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>  block/io.c | 82 +++++++++++++++++++++++++++---------------------------
>  1 file changed, 41 insertions(+), 41 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--7lMq7vMTJT4tNk0a
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl6d0GAACgkQnKSrs4Gr
c8gcmQgAgs9k8S6tOZ83QTHz4YKL/bjHOtqbM7XPQxhSjsC3i6DcMvMwm4X8ll0/
H4HstAFY/9EyZTwWcnmuBuerq93YSJpbUPx259K98RdhTZEGEOdAAaRnwQ5y8KLO
P2skEaB2vIM6eBFDtYzJ6cTq1Yt7UZkFRHHYmINx7T9AfETEqTFvnxWJthdk3nRj
tPaZWVOSW86vxbOxjFBTzDXqstnjOtTb4E5vRn5y693HprQ2pFt1nbYNNTfemmzf
kYtu6LiDHFZ6D42sr4PPWyqGsKsIVRb3zRs4VIQRiP/ixJ4r51jVyIyb8kytNj7H
Q+vgNfMjlElevPoZ9zaxQ9Aq7UFWVw==
=ZTKC
-----END PGP SIGNATURE-----

--7lMq7vMTJT4tNk0a--


