Return-Path: <SRS0=VaDC=2D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90D53C2D0C9
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Dec 2019 21:27:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 170B821655
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Dec 2019 21:27:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UpAZwqZr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 170B821655
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47516 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ifj9W-0003Tl-QS
	for qemu-devel@archiver.kernel.org; Fri, 13 Dec 2019 06:30:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:40104)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@redhat.com>) id 1ifj8k-00031O-1A
 for qemu-devel@nongnu.org; Fri, 13 Dec 2019 06:29:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@redhat.com>) id 1ifj8f-0005WQ-MR
 for qemu-devel@nongnu.org; Fri, 13 Dec 2019 06:29:44 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:28922
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1ifj8f-0005Ue-7r
 for qemu-devel@nongnu.org; Fri, 13 Dec 2019 06:29:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576236580;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=GJSOlUsSwYKEPMGcSD4mqFFfqlCrqvMMp+hc59YPBEI=;
 b=UpAZwqZrlvyGWePFMsXYpz+CPDAsuK3COYESszAkAbvSamM1EI4NuZ36hWwGgx2F8XY7aY
 jnC7ldvo3la4PWt+xEgSuKa8m5WeHcYWdwq+7dsLXYFrYHP7r8SHDNY2muBAj0bu8fYA4Y
 MQ2sTgg9FYsMX9nvOIkQcbX+FDXCo/0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-296-YcYKedjiMSyns7DL0KO2Pw-1; Fri, 13 Dec 2019 06:29:38 -0500
X-MC-Unique: YcYKedjiMSyns7DL0KO2Pw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 95B28800D48
 for <qemu-devel@nongnu.org>; Fri, 13 Dec 2019 11:29:37 +0000 (UTC)
Received: from localhost (unknown [10.36.118.64])
 by smtp.corp.redhat.com (Postfix) with ESMTP id C067876FF2;
 Fri, 13 Dec 2019 11:29:33 +0000 (UTC)
Date: Fri, 13 Dec 2019 11:29:32 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Subject: Re: [PATCH] virtio-fs: fix MSI-X nvectors calculation
Message-ID: <20191213112932.GA1186952@stefanha-x1.localdomain>
References: <20191209110759.35227-1-stefanha@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20191209110759.35227-1-stefanha@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="NzB8fVQJ5HfG6fxh"
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
Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Vivek Goyal <vgoyal@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--NzB8fVQJ5HfG6fxh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 09, 2019 at 11:07:59AM +0000, Stefan Hajnoczi wrote:
> The following MSI-X vectors are required:
>  * VIRTIO Configuration Change
>  * hiprio virtqueue
>  * requests virtqueues
>=20
> Fix the calculation to reserve enough MSI-X vectors.  Otherwise guest
> drivers fall back to a sub-optional configuration where all virtqueues
> share a single vector.
>=20
> This change does not break live migration compatibility since
> vhost-user-fs-pci devices are not migratable yet.
>=20
> Reported-by: Vivek Goyal <vgoyal@redhat.com>
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
>  hw/virtio/vhost-user-fs-pci.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

Thanks, applied to my block tree:
https://github.com/stefanha/qemu/commits/block

Stefan

--NzB8fVQJ5HfG6fxh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl3zdhwACgkQnKSrs4Gr
c8iHNggAskaej8aOVM3yEaN0PprY7QvC6TtHNGjBFa0OxeezJwozpjFE08h5OhkY
xmeogFJtCeeosvKyOueFHYxClUTMa/umDWb0yI1hHp+FtvzTZAQMFMmqZ3IpAp0J
MmLhj0UOAyOe2qBRJfK9yhjlOxCllLIJLdgE0iBG4RLhMKd4FCNcz4+OxJPS+/FJ
dvCu3PplURoZx3uuShavkAsdmwI6Nez92s9wgB2nFqOKJEoENazTTH0iKCzVZl7V
Osn4aKG8ES1xQxpawPldEZSp8Ix7auKPs2j2GgT+aQhHr16zPi7W1orgU4qOBCr5
DEBQV1y/4TW1wCCLyuyGZ76Zjh+cmA==
=cfvX
-----END PGP SIGNATURE-----

--NzB8fVQJ5HfG6fxh--


