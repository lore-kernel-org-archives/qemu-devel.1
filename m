Return-Path: <SRS0=tSBD=YP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BD41CA9EA0
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2019 15:42:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4376A205C9
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2019 15:42:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aBvHHpbv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4376A205C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33474 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iMwIk-0007Po-Sn
	for qemu-devel@archiver.kernel.org; Tue, 22 Oct 2019 11:42:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58122)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@redhat.com>) id 1iMwFN-0005U0-KF
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 11:38:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@redhat.com>) id 1iMwFL-0005PS-Ap
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 11:38:56 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:28651
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1iMwFK-0005NR-Pz
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 11:38:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1571758732;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=F53lYzRnyFg+MgjhRHtJK1ZfIq904/e391bFUH7wHvo=;
 b=aBvHHpbv1GpdY56M5JdAV6vT2WfT+AP0w+OP7k61XnOVGtPscOMM/dbX/P7WpPTOVxs6Ai
 3wmatmEnRHuT1yHv0jrnXCXRDdBwzrmSX7/zFxpVg05YmoDNEVJJkiBmIy69C7Zohmaf4J
 N/5ckOh8hpcAWwu2/PNdPgFZjLbCweo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-381-mHbbyE73N72ttA4Ero6BtQ-1; Tue, 22 Oct 2019 11:38:50 -0400
X-MC-Unique: mHbbyE73N72ttA4Ero6BtQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 056B7476;
 Tue, 22 Oct 2019 15:38:50 +0000 (UTC)
Received: from localhost (ovpn-117-153.ams2.redhat.com [10.36.117.153])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 9BDA7608A5;
 Tue, 22 Oct 2019 15:38:44 +0000 (UTC)
Date: Tue, 22 Oct 2019 16:38:43 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Thomas Huth <thuth@redhat.com>
Subject: Re: [PATCH v3 04/16] virtio-scsi-test: add missing feature negotiation
Message-ID: <20191022153843.GD32186@stefanha-x1.localdomain>
References: <20191019063810.6944-1-stefanha@redhat.com>
 <20191019063810.6944-5-stefanha@redhat.com>
 <74f8d009-a2ac-4d8b-429f-522899c03b94@redhat.com>
MIME-Version: 1.0
In-Reply-To: <74f8d009-a2ac-4d8b-429f-522899c03b94@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="5gxpn/Q6ypwruk0T"
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Cc: Fam Zheng <fam@euphon.net>, Laurent Vivier <lvivier@redhat.com>,
 slp@redhat.com, qemu-block@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>,
 qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--5gxpn/Q6ypwruk0T
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 21, 2019 at 02:08:34PM +0200, Thomas Huth wrote:
> On 19/10/2019 08.37, Stefan Hajnoczi wrote:
> > VIRTIO Device Initialization requires feature negotiation.  Currently
> > virtio-scsi-test.c is non-compliant.
> >=20
> > Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> > ---
> >  tests/virtio-scsi-test.c | 8 ++++++++
> >  1 file changed, 8 insertions(+)
> >=20
> > diff --git a/tests/virtio-scsi-test.c b/tests/virtio-scsi-test.c
> > index 7c8f9b27f8..0415e75876 100644
> > --- a/tests/virtio-scsi-test.c
> > +++ b/tests/virtio-scsi-test.c
> > @@ -123,10 +123,16 @@ static QVirtioSCSIQueues *qvirtio_scsi_init(QVirt=
ioDevice *dev)
> >      QVirtioSCSIQueues *vs;
> >      const uint8_t test_unit_ready_cdb[VIRTIO_SCSI_CDB_SIZE] =3D {};
> >      struct virtio_scsi_cmd_resp resp;
> > +    uint64_t features;
> >      int i;
> > =20
> >      vs =3D g_new0(QVirtioSCSIQueues, 1);
> >      vs->dev =3D dev;
> > +
> > +    features =3D qvirtio_get_features(dev);
> > +    features &=3D ~(QVIRTIO_F_BAD_FEATURE | (1ull << VIRTIO_RING_F_EVE=
NT_IDX));
> > +    qvirtio_set_features(dev, features);
>=20
> I wonder whether this get_feat + "&=3D" + set_feat is really the right wa=
y
> here? Maybe we should rather only set the feature bits that we care
> about instead of setting all but BAD_FEATURE and RING_F_EVENT_IDX?
>=20
> Otherwise, please mention in the commit message why you've chosen to
> disable just these two bits.

Enabling all features (except BAD_FEATURE and EVENT_IDX) is standard
practice in virtio qtests that I didn't want to diverge from.

I can mention this in the commit description and explain that
BAD_FEATURE must never be set (i.e. drivers that do so are considered
broken) and EVENT_IDX isn't supported by the libqos virtio code.

Stefan

--5gxpn/Q6ypwruk0T
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl2vIoMACgkQnKSrs4Gr
c8jibggAu6ALCqExt7+qvaeTiRKkyznH2Zg9yJ5JTPPZMc4kE0vEJT9f1uqT/Ibj
LEhpsw35Ji76uiOMccPlMM8HRZcRHb39gMo7KI5aUbD8YFD6Vx6JSyhnIQfwmLZ7
9Pf0tLbQt1VPy6vjHYiUWOmIy26pG3pWy9YN2x+2OloWfr+EOuOQ2QeEneyQNxNI
DL5XBOcLPSkZ/ZLGuXHgZHGi7sQjnKrGhfMJwbjIASqfGicyadPaq8EHMkHb9F2j
0ANMTMn3ET6ZnS5QXiInLWiqcXsj8iEqLigmj+K6cyhIqHzgmI/NmgewZPIstgLz
DJBTsgKA7zuPUVuWZTy5JgxpuWuyew==
=2pnR
-----END PGP SIGNATURE-----

--5gxpn/Q6ypwruk0T--


