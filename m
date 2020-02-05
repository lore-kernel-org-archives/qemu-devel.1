Return-Path: <SRS0=Tmh/=3Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1629C35247
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Feb 2020 15:57:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 86B2420702
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Feb 2020 15:57:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Z1GlGOht"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 86B2420702
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51460 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1izN3R-0001Gx-NQ
	for qemu-devel@archiver.kernel.org; Wed, 05 Feb 2020 10:57:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42276)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <cohuck@redhat.com>) id 1izN1c-0007Fb-V4
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 10:55:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <cohuck@redhat.com>) id 1izN1b-0006s2-Qt
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 10:55:36 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:41310
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1izN1b-0006pO-M8
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 10:55:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580918135;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ed6rt3LmBRoRLzeBBdAr7ZLFxbBoTVzEAqMQlXyxF30=;
 b=Z1GlGOhtmcbRgruYClCbYEk8d+YyFXGCDp7brpVEmP/PCfsXpsj1J/fywOWQ3a+ULb072Y
 ZOde6gsyCoaoLJBU4JKtzgkv7U08Y8QphBkhyT80fTmiWVplbRKHoib2Q9Xq+NaAJQkGlY
 8nSYQ+BcO72kIQQcLefyK5MI/gX67LE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-398-60IQ-JFrNFagBxo26beHsA-1; Wed, 05 Feb 2020 10:55:30 -0500
X-MC-Unique: 60IQ-JFrNFagBxo26beHsA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4AB831800D42;
 Wed,  5 Feb 2020 15:55:29 +0000 (UTC)
Received: from gondolin (dhcp-192-195.str.redhat.com [10.33.192.195])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 584375C28C;
 Wed,  5 Feb 2020 15:55:23 +0000 (UTC)
Date: Wed, 5 Feb 2020 16:55:11 +0100
From: Cornelia Huck <cohuck@redhat.com>
To: Stefan Hajnoczi <stefanha@gmail.com>
Subject: Re: [PATCH] virtio: clean up when virtio_queue_set_rings() fails
Message-ID: <20200205165511.108326a5.cohuck@redhat.com>
In-Reply-To: <20200205144946.GH58062@stefanha-x1.localdomain>
References: <20200204151618.39296-1-stefanha@redhat.com>
 <20200204170239.49deb13a.cohuck@redhat.com>
 <20200205144946.GH58062@stefanha-x1.localdomain>
Organization: Red Hat GmbH
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; boundary="Sig_/L7b.n+=8KvDdbmSISDwWlP+";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
Cc: Alexander Bulekov <alxndr@bu.edu>, qemu-devel@nongnu.org,
 Stefan Hajnoczi <stefanha@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--Sig_/L7b.n+=8KvDdbmSISDwWlP+
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Wed, 5 Feb 2020 14:49:46 +0000
Stefan Hajnoczi <stefanha@gmail.com> wrote:

> On Tue, Feb 04, 2020 at 05:02:39PM +0100, Cornelia Huck wrote:
> > On Tue,  4 Feb 2020 15:16:18 +0000
> > Stefan Hajnoczi <stefanha@redhat.com> wrote:

> > > diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
> > > index 2c5410e981..5d7f619a1e 100644
> > > --- a/hw/virtio/virtio.c
> > > +++ b/hw/virtio/virtio.c
> > > @@ -2163,6 +2163,11 @@ void virtio_queue_set_rings(VirtIODevice *vdev=
, int n, hwaddr desc,
> > >      vdev->vq[n].vring.avail =3D avail;
> > >      vdev->vq[n].vring.used =3D used;
> > >      virtio_init_region_cache(vdev, n);
> > > +    if (vdev->broken) {
> > > +        vdev->vq[n].vring.desc =3D 0;
> > > +        vdev->vq[n].vring.avail =3D 0;
> > > +        vdev->vq[n].vring.used =3D 0;
> > > +    }
> > >  }
> > > =20
> > >  void virtio_queue_set_num(VirtIODevice *vdev, int n, int num) =20
> >=20
> > This looks correct; but shouldn't virtio_queue_set_addr() also set
> > .desc to 0 on failure? =20
>=20
> Now that you mention it, there are a number of other
> virtio_init_region_cache() callers that could be affected.
>=20
> I added the error handling code to virtio_queue_set_rings() because
> that's symmetric - this function sets .desc and so it should be the one
> to clear it on error.  But now I think virtio_init_region_cache() should
> take on that responsibility so callers don't need to duplicate this
> error handling code.

Is it clear in every case what the correct error handling procedure
would be? It would feel a bit surprising if the addresses were cleared
for callers that don't directly change them.

--Sig_/L7b.n+=8KvDdbmSISDwWlP+
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEw9DWbcNiT/aowBjO3s9rk8bwL68FAl465V8ACgkQ3s9rk8bw
L68Jww//SNGM6J5TgNzLmI2kNkarirQhjqi6AYZtJJjRTJVXIpxxpiH7fqkK9Cpi
/pakj9g+A6Clf3nUmVh1/dSRcWVk6EgRNOJCFh8U3vNhC4a49MV0B4dBUmaanzHQ
L5iYB6DP1bacmc4kC+DXKDZ8VSoRSvZrXTFogp+5cCoAkaliOqJZJOvVblFVx8Ct
+d4pgYPkZkqGH+3BvTOAb/Dc1ymX8H5S1ovYPE0S8exv3sEExt4zr9mcvZqYrceQ
KpaZzl/Kfu+vZGEmy2DQD+soN5YN8qSPqXHbmzsxr2PX6+tcJFCOEN4RrGaPi4ul
+4sje7EpOtZYobYT0ChsgydOBCVeVCWelkVg4aGAmGScL+YY6u6EadGGrke020iu
rL2/rOa202Ie8Ji/6IytHBjysLSx5nBQifQyNUMs1ajLMBhY7/cwqygSP08VDH76
t/QiG9ifNaLys6H4OMA2kfw8RhkQnwLesA207FxtaYrUk6wF2unpkf4Mk6kdwD+Y
0Bnkh+UJC53Q1vSxiOBz+lbuYsZ/SHOguAtOAuplltG3rhqSGvAp7jxQ4GNRrlxa
lOjJ2pra069gDmo2D1jkb6EQ6ZMMZwqMH47GDmrgUDN8qWWQBkp7H5KJ+D3jqSfp
Pv7efwciz6mfXPDHXIKF5GTQwgaPOfeS9haE1VxArqtNhzX/R4A=
=A452
-----END PGP SIGNATURE-----

--Sig_/L7b.n+=8KvDdbmSISDwWlP+--


