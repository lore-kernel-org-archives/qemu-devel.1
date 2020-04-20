Return-Path: <SRS0=IvAo=6E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9A30C3815B
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Apr 2020 16:07:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A0A1320775
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Apr 2020 16:07:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HGsAv+8R"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A0A1320775
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38706 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jQYwl-0003Pg-MV
	for qemu-devel@archiver.kernel.org; Mon, 20 Apr 2020 12:06:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44982 helo=eggs1p.gnu.org)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@redhat.com>) id 1jQYuz-0001BK-MW
 for qemu-devel@nongnu.org; Mon, 20 Apr 2020 12:05:10 -0400
Received: from Debian-exim by eggs1p.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <stefanha@redhat.com>) id 1jQYux-0005TP-IU
 for qemu-devel@nongnu.org; Mon, 20 Apr 2020 12:05:08 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:21483
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1jQYux-0005Kc-4A
 for qemu-devel@nongnu.org; Mon, 20 Apr 2020 12:05:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1587398704;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=pLy5c3bWQB2ORbE1RYs/kHugkd3b106ZtP4U6G8++38=;
 b=HGsAv+8R2N92DUo/cqbog3a+LRTC3kz6rS5LmcGs3+96zdPzYRgXJ87DJP+lmLagDvLsGt
 ILA/OPM0gLtsPehR3YhBZYhcxsUfEelT9TPVqudFnOl1oIp+IQ3UPWOV5AMVbejctfQVc/
 YkbWLCKq8BVK8ahf45Sot8r3mnMNse0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-52-EIjMI_wmP0eoQS8LX37bVQ-1; Mon, 20 Apr 2020 12:04:59 -0400
X-MC-Unique: EIjMI_wmP0eoQS8LX37bVQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 26AC61007282;
 Mon, 20 Apr 2020 16:04:58 +0000 (UTC)
Received: from localhost (ovpn-112-169.ams2.redhat.com [10.36.112.169])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 785765DA76;
 Mon, 20 Apr 2020 16:04:57 +0000 (UTC)
Date: Mon, 20 Apr 2020 17:04:56 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Subject: Re: [PATCH 4/9] block/io: move bdrv_rw_co_entry and friends down
Message-ID: <20200420160456.GD7321@stefanha-x1.localdomain>
References: <20200408093051.9893-1-vsementsov@virtuozzo.com>
 <20200408093051.9893-5-vsementsov@virtuozzo.com>
MIME-Version: 1.0
In-Reply-To: <20200408093051.9893-5-vsementsov@virtuozzo.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="J5MfuwkIyy7RmF4Q"
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.61; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs1p.gnu.org: First seen = 2020/04/20
 09:01:45
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
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
Cc: kwolf@redhat.com, fam@euphon.net, qemu-block@nongnu.org,
 qemu-devel@nongnu.org, mreitz@redhat.com, den@openvz.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--J5MfuwkIyy7RmF4Q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 08, 2020 at 12:30:46PM +0300, Vladimir Sementsov-Ogievskiy wrot=
e:
> We are going to use bdrv_co_pwritev_part and bdrv_co_preadv_part in
> bdrv_rw_co_entry, so move it down.
>=20
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>  block/io.c | 361 +++++++++++++++++++++++++++--------------------------
>  1 file changed, 181 insertions(+), 180 deletions(-)

Note to other reviewers: Comment formatting was changed to conform to
coding style and function order was changed.  Otherwise the code is
unmodified.

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--J5MfuwkIyy7RmF4Q
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl6dyCgACgkQnKSrs4Gr
c8hrVwf+OFwaB3NtD0ULXPcEb7y+Pt2WHwNa2dGbnEwcQV5mXT2afa53KdFwEizc
n20HoBFeeu2nRPPAPQ/hR60uFUQHLGEtkWscJfljy6TsT0Of1Nr/+2gJfp5hdKYJ
/hA5yToQJRmMRY25/4aipDp1gVaJWo/Th5eqE9xCkl0GAGi9UP4QQlzAQUGcrug7
mMn905Y2DwOHzJYRu7byzz3CMsxDxEs7OCSrDxALl0iOPVQs/Tj2TJpAHKbi1Bud
WKai/yYedmvpX0Y9wp4CpXRY6v/da4ZZ+L0Zg82ACVfPmhQw27tXJ9eh+0/9rIba
Py+Z8aX4fyNP+5gdtfvvDSsqVDu2Fg==
=iHfg
-----END PGP SIGNATURE-----

--J5MfuwkIyy7RmF4Q--


