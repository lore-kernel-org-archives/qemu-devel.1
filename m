Return-Path: <SRS0=xFA2=5Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2E74C43331
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Mar 2020 14:47:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9D8012078B
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Mar 2020 14:47:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NxHKEc4I"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D8012078B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39278 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jJIAg-00008i-Qh
	for qemu-devel@archiver.kernel.org; Tue, 31 Mar 2020 10:47:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53492)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@redhat.com>) id 1jJI8j-0007Bo-Nq
 for qemu-devel@nongnu.org; Tue, 31 Mar 2020 10:45:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@redhat.com>) id 1jJI8i-00050G-Mz
 for qemu-devel@nongnu.org; Tue, 31 Mar 2020 10:45:17 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:56739
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1jJI8i-0004yO-II
 for qemu-devel@nongnu.org; Tue, 31 Mar 2020 10:45:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585665915;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=OJErqcJ9brW6YPyurZ8Y+VLvgy6LGeSJ6a76T1MRCVE=;
 b=NxHKEc4Imvy0Y2IJJ0uD9VNW0DHrXZj06GsNIbtPyjjEiLqXzPDtsQkeeLQkc/WG8/6iRR
 nptXdFaat1uIwSw48el5sfBlX9bxuwssdLAf7QcpCmd3BfOMbufP1pHBTXE9qcgndIy9v7
 80rS45jvV1gXpnc5nb+qSC+aq/mvlC8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-364-Y2jhqy7lO66cpfJLReV1hw-1; Tue, 31 Mar 2020 10:45:13 -0400
X-MC-Unique: Y2jhqy7lO66cpfJLReV1hw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5F36F801A01
 for <qemu-devel@nongnu.org>; Tue, 31 Mar 2020 14:45:12 +0000 (UTC)
Received: from localhost (ovpn-114-248.ams2.redhat.com [10.36.114.248])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 4E30E5C3FA;
 Tue, 31 Mar 2020 14:45:09 +0000 (UTC)
Date: Tue, 31 Mar 2020 15:45:07 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Stefano Garzarella <sgarzare@redhat.com>
Subject: Re: [PATCH] vhost-vsock: fix double close() in the realize() error
 path
Message-ID: <20200331144507.GB119071@stefanha-x1.localdomain>
References: <20200331075910.42529-1-sgarzare@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200331075910.42529-1-sgarzare@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="hQiwHBbRI9kgIhsi"
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
Cc: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--hQiwHBbRI9kgIhsi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 31, 2020 at 09:59:10AM +0200, Stefano Garzarella wrote:
> vhost_dev_cleanup() closes the vhostfd parameter passed to
> vhost_dev_init(), so this patch avoids closing it twice in
> the vhost_vsock_device_realize() error path.
>=20
> Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
> ---
>  hw/virtio/vhost-vsock.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--hQiwHBbRI9kgIhsi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl6DV3MACgkQnKSrs4Gr
c8i3tQgAvdwmtSa58Eh4LsoVBTqCLgyp0J4o3Mq5PZubmk/7QeBJEKUOD4u1Mmog
ADVpd5GLw/jyOpicqhI9Q41j9Xc/LCFQtMTOb9zOkIJ3d4QPIPWvMwNs3IvvtT1d
buWbeyk/DC/34P039z2ngT0NRCM0KOX4Sqa11bh1wcPbOqIZ5+GkojAhXRBN6dEi
dl0klSlUnFepIS3g4hztsoJhytxkEJMOkW3k7ZESeSh2xTSbjwjegcdQg2SWwGgI
6hnISluVP+WUAg9Oo8KeXDVgSgp6gjpeEUEemFOCM0CpLhlBVFIERrlDCetqxsT3
2R6dAV9OGyHMPJK0QG2mPwt6+ZHHOA==
=d00o
-----END PGP SIGNATURE-----

--hQiwHBbRI9kgIhsi--


