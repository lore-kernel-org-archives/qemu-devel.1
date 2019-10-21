Return-Path: <SRS0=8ZcK=YO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B523CA9EAF
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2019 15:18:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0562D2084B
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2019 15:18:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="I6uUKYns"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0562D2084B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43976 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iMZS0-0007ep-62
	for qemu-devel@archiver.kernel.org; Mon, 21 Oct 2019 11:18:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56003)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@redhat.com>) id 1iMZQw-0007DN-1p
 for qemu-devel@nongnu.org; Mon, 21 Oct 2019 11:17:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@redhat.com>) id 1iMZQt-000401-H6
 for qemu-devel@nongnu.org; Mon, 21 Oct 2019 11:17:20 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:61000
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1iMZQt-0003zq-4I
 for qemu-devel@nongnu.org; Mon, 21 Oct 2019 11:17:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1571671038;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=vN3Rl/lZOKkhMJY3BXgQJZngOvC7FdDXdZ0yyj0izyk=;
 b=I6uUKYnsyBJDtnzUZNa7o3xebevy8Es2Q8RvpC1FIWtXq1aIt79n2IKM7YtUVBbrRB+kQC
 6wesp/s0eQWMrT59UwQMY+lRw5aa2go/EDxdsYnPBAdlbPjfIOeYUAytjmSVTTGcMkVQls
 A4LCdU7qxYV59EfpXmk8NCDkB93+ph0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-128-bCoq4GlXMceXrjn5xFIhPw-1; Mon, 21 Oct 2019 11:17:16 -0400
X-MC-Unique: bCoq4GlXMceXrjn5xFIhPw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C8390800D49
 for <qemu-devel@nongnu.org>; Mon, 21 Oct 2019 15:17:15 +0000 (UTC)
Received: from localhost (ovpn-116-128.ams2.redhat.com [10.36.116.128])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 512D919481;
 Mon, 21 Oct 2019 15:17:09 +0000 (UTC)
Date: Mon, 21 Oct 2019 16:17:07 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Julia Suvorova <jusual@redhat.com>
Subject: Re: [PATCH] virtio-blk: Add blk_drain() to
 virtio_blk_device_unrealize()
Message-ID: <20191021151707.GI22659@stefanha-x1.localdomain>
References: <20191018142856.31870-1-jusual@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20191018142856.31870-1-jusual@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="YrQNB5Deg1WGKZi3"
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.120
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
Cc: Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>,
 qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--YrQNB5Deg1WGKZi3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 18, 2019 at 04:28:56PM +0200, Julia Suvorova wrote:
> QEMU does not wait for completed I/O requests, assuming that the guest
> driver will reset the device before calling unrealize(). This does not
> happen on Windows, and QEMU crashes in virtio_notify(), getting the
> result of a completed I/O request on hot-unplugged device.
>=20
> Signed-off-by: Julia Suvorova <jusual@redhat.com>
> ---
>  hw/block/virtio-blk.c | 1 +
>  1 file changed, 1 insertion(+)

Thanks, applied to my block tree:
https://github.com/stefanha/qemu/commits/block

Stefan

--YrQNB5Deg1WGKZi3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl2ty/MACgkQnKSrs4Gr
c8ix2wf9HqR81djEe4yohc8n7q3TcFbyh9PP6HvhAYkpOT41B1y5gamAK/IjCVN7
88umfw3csuqThhXuMGUm8nxuO6nYFkeJ51DG36/thP9fZf5EpBfIp9gO5wox0I5k
wXDaFzxjbotoa5cQJnoMco1P3C4o0qytcDeCieQGUfoQZ9ArGBBnDnZVQUYMM/+n
Vo18Qw+izgxogjTtx4kyHFyDN8Y98Y2mHWrrBrR4FwOqoZ0h1AvW9ut8d3L4X2Gm
wp1ESE7E6XZhpJpoixlEn/stTO/B1CY2AV9j7w11ahmLITuHIh0TKaIUhHf5pItC
yLQowz5EVvZkU4BlSwzS3/VE48DdHA==
=S8GB
-----END PGP SIGNATURE-----

--YrQNB5Deg1WGKZi3--


