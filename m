Return-Path: <SRS0=IvAo=6E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4205C3815B
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Apr 2020 16:39:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6BA17206F6
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Apr 2020 16:39:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KBnzlXWG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6BA17206F6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39190 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jQZRm-0000c3-Hl
	for qemu-devel@archiver.kernel.org; Mon, 20 Apr 2020 12:39:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51256 helo=eggs1p.gnu.org)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@redhat.com>) id 1jQZR8-00006C-HS
 for qemu-devel@nongnu.org; Mon, 20 Apr 2020 12:38:22 -0400
Received: from Debian-exim by eggs1p.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <stefanha@redhat.com>) id 1jQZR7-0003mi-74
 for qemu-devel@nongnu.org; Mon, 20 Apr 2020 12:38:21 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:27575
 helo=us-smtp-1.mimecast.com)
 by eggs1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1jQZR6-0003fg-OV
 for qemu-devel@nongnu.org; Mon, 20 Apr 2020 12:38:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1587400699;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=qjPAiBkm8SvqiFvXa8XnH3IdFZDFirliC+zLqpAnunU=;
 b=KBnzlXWGdzHlcoBZ/jzYYSbIELO/9zllqr3ShC6CTUViSSFKInE+VeeMIHOVHCdFSlWjoS
 YvfDeh+3En03ykT1fl2H4rdAbLjJlzEtlYBrokiVz4pMWz2ju01LshJePqfZn2zCuDMiGh
 +b5UYRSSbnEM/xyWnpSl4VRIbDNqxbY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-291-k1kwhYCHOlqfRnQbPuloQg-1; Mon, 20 Apr 2020 12:38:16 -0400
X-MC-Unique: k1kwhYCHOlqfRnQbPuloQg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E34EA1922021;
 Mon, 20 Apr 2020 16:38:12 +0000 (UTC)
Received: from localhost (ovpn-112-169.ams2.redhat.com [10.36.112.169])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 442C8A1897;
 Mon, 20 Apr 2020 16:38:12 +0000 (UTC)
Date: Mon, 20 Apr 2020 17:38:10 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Subject: Re: [PATCH 7/9] block/io: add bdrv_do_pwrite_zeroes
Message-ID: <20200420163810.GF7321@stefanha-x1.localdomain>
References: <20200408093051.9893-1-vsementsov@virtuozzo.com>
 <20200408093051.9893-8-vsementsov@virtuozzo.com>
MIME-Version: 1.0
In-Reply-To: <20200408093051.9893-8-vsementsov@virtuozzo.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="7cm2iqirTL37Ot+N"
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.120; envelope-from=stefanha@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs1p.gnu.org: First seen = 2020/04/20
 03:29:13
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
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
Cc: kwolf@redhat.com, fam@euphon.net, qemu-block@nongnu.org,
 qemu-devel@nongnu.org, mreitz@redhat.com, den@openvz.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--7cm2iqirTL37Ot+N
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 08, 2020 at 12:30:49PM +0300, Vladimir Sementsov-Ogievskiy wrot=
e:
> We'll need a bdrv_co_pwrite_zeroes version without inc/dec in_flight to
> be used in further implementation of bdrv_make_zero.
>=20
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>  block/io.c | 23 +++++++++++++++++++----
>  1 file changed, 19 insertions(+), 4 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--7cm2iqirTL37Ot+N
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl6dz/IACgkQnKSrs4Gr
c8hdCgf+LbZUd0S9HHUITM1Za9sUC9c7aSoeha5unwNXjiOfUC7GAjGJ5zbnLVSl
2WPHATl8/J/a9XvtOO/Ov0dc19R11lera+a6dxWJtYjFHVuu607itYRmkQR7z7gs
krr5JmclmteYUYOhBMHDK+aJ5XIHL3Mhn3fUJyl4ZuvzJGqVwxUlIg8c9E7CZEgq
FfN83B8C/Rg3r9JzUMA0kFN/xpohLcOORA2UIhGbBdTxVWRJI99HUoz1w4pAbEmC
CB+dU+iwDNmiKv6eWbiSBzPhwekuWClI7FJciQShIOJBkOJcXNXqg0pHdR0bO4iB
eaRpZ4gJKHpwQ2rENMTiFwEmPVujcA==
=aKpz
-----END PGP SIGNATURE-----

--7cm2iqirTL37Ot+N--


