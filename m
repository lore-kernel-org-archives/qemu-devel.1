Return-Path: <SRS0=IvAo=6E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48154C3815B
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Apr 2020 16:05:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1018C2082E
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Apr 2020 16:05:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ScbB8YRV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1018C2082E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38656 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jQYvV-0001hZ-5R
	for qemu-devel@archiver.kernel.org; Mon, 20 Apr 2020 12:05:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44268 helo=eggs1p.gnu.org)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@redhat.com>) id 1jQYrp-0005hN-Sf
 for qemu-devel@nongnu.org; Mon, 20 Apr 2020 12:01:54 -0400
Received: from Debian-exim by eggs1p.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <stefanha@redhat.com>) id 1jQYro-0006Rj-Mb
 for qemu-devel@nongnu.org; Mon, 20 Apr 2020 12:01:53 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:57815
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1jQYro-0006Ma-7R
 for qemu-devel@nongnu.org; Mon, 20 Apr 2020 12:01:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1587398511;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=rVo+R8JA7ZZDlaBiRKTQADwfvxjnr9FMonVS+DxwGdM=;
 b=ScbB8YRVoeAnKGlkJXV5iWvz8DklYnkdJOuahsi6QkeqEFTaztawantmSpNzE5CIPDqeSn
 ZlOZNNyW1XG1w2ed8LvNStwxQqDSPvfLHp+KoaLTqYZFQKiZHzYCydUCbkL8qywix/B0ml
 6YpiTOXwPpPdAeTMPCFiAPDHjOzJGRs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-461-ME6QpQWwPsKZRQXa91INVQ-1; Mon, 20 Apr 2020 12:01:47 -0400
X-MC-Unique: ME6QpQWwPsKZRQXa91INVQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CC028801A0E;
 Mon, 20 Apr 2020 16:01:45 +0000 (UTC)
Received: from localhost (ovpn-112-169.ams2.redhat.com [10.36.112.169])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 589395C578;
 Mon, 20 Apr 2020 16:01:44 +0000 (UTC)
Date: Mon, 20 Apr 2020 17:01:43 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Subject: Re: [PATCH 3/9] block/io: move flush and pdiscard stuff down
Message-ID: <20200420160143.GC7321@stefanha-x1.localdomain>
References: <20200408093051.9893-1-vsementsov@virtuozzo.com>
 <20200408093051.9893-4-vsementsov@virtuozzo.com>
MIME-Version: 1.0
In-Reply-To: <20200408093051.9893-4-vsementsov@virtuozzo.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="p2kqVDKq5asng8Dg"
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

--p2kqVDKq5asng8Dg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 08, 2020 at 12:30:45PM +0300, Vladimir Sementsov-Ogievskiy wrot=
e:
> bdrv_co_flush and bdrv_co_pdiscard will become static in further patch,
> move their usage down.
>=20
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>  block/io.c | 56 +++++++++++++++++++++++++++---------------------------
>  1 file changed, 28 insertions(+), 28 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--p2kqVDKq5asng8Dg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl6dx2cACgkQnKSrs4Gr
c8h1LAgAqA8r7Tkttfg6efUn+eaFg2oPevZzuWHdr5IXkOQoPtZCj//Qg3vjnYYp
zokHftAoyd08XzNz/H4prdFXaQtGdDxNBfvzkFSMfZWem11xe2yl6/3tTSMeMFCv
DlmyKHO973MR4TTdrR952TMqYHYW4jELDCuco0NC5LeXSvSqzhCYKqBnPvhSDQyr
tHkVwXCxJaNTMdLNmiEeIyIiN2robMoaY76ej4Q24bVlfWrL6Hz8x+2xIqFWjAZY
i6ThayOsBQBTUTYUZ1p00md+kglyF6tA/qR+OMpkjgDNnsh0EVCCKZVn98NPFsdu
dPd4tuQY2zOxIDPK9qcRPwwp393qZg==
=f/ql
-----END PGP SIGNATURE-----

--p2kqVDKq5asng8Dg--


