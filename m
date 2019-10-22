Return-Path: <SRS0=tSBD=YP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B037CCA9EB7
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2019 16:02:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7F71D214E0
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2019 16:02:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SjH7AXSb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F71D214E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34528 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iMwcG-0007dJ-HG
	for qemu-devel@archiver.kernel.org; Tue, 22 Oct 2019 12:02:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33180)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@redhat.com>) id 1iMwTb-0001kH-JU
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 11:53:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@redhat.com>) id 1iMwTa-0007mI-Hk
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 11:53:39 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:23682
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1iMwTa-0007m1-EQ
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 11:53:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1571759618;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ArwMaoRC0hgUN93qlGTDlTqURBIccWxVn4qFKwIzex8=;
 b=SjH7AXSbUeP28x9R3OV0ytoTL5pxtf4PbCWV8WYaqQgGr2a+teBhMpJuNrMnyUmAtpGO7h
 F78plkFAZd6tCIj93DrmuA9zwnX8/4UMj9EiszIbABfC5nCRJT0jhKE6t/it42mp05EHe/
 3H2Ah3Nf4VtKA9kCn4iWRobVh/+jWNc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-213-Yfyh4Wr2P8mGsqTrynzL1w-1; Tue, 22 Oct 2019 11:53:34 -0400
X-MC-Unique: Yfyh4Wr2P8mGsqTrynzL1w-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7FD851005500;
 Tue, 22 Oct 2019 15:53:33 +0000 (UTC)
Received: from localhost (ovpn-117-153.ams2.redhat.com [10.36.117.153])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 24FF31001B09;
 Tue, 22 Oct 2019 15:53:27 +0000 (UTC)
Date: Tue, 22 Oct 2019 16:53:26 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Thomas Huth <thuth@redhat.com>
Subject: Re: [PATCH v3 08/16] libqos: implement VIRTIO 1.0 FEATURES_OK step
Message-ID: <20191022155326.GF32186@stefanha-x1.localdomain>
References: <20191019063810.6944-1-stefanha@redhat.com>
 <20191019063810.6944-9-stefanha@redhat.com>
 <9306a847-d4a4-7503-0682-8c75522e57f1@redhat.com>
MIME-Version: 1.0
In-Reply-To: <9306a847-d4a4-7503-0682-8c75522e57f1@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="sDKAb4OeUBrWWL6P"
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

--sDKAb4OeUBrWWL6P
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 21, 2019 at 02:23:15PM +0200, Thomas Huth wrote:
> On 19/10/2019 08.38, Stefan Hajnoczi wrote:
> > Device initialization has an extra step in VIRTIO 1.0.  The FEATURES_OK
> > status bit is set to indicate that feature negotiation has completed.
> > The driver then reads the status register again to check that the devic=
e
> > agrees with the final features.
> >=20
> > Implement this step as part of qvirtio_set_features() instead of
> > introducing a separate function.  This way all existing code works
> > without modifications.
> >=20
> > Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> > ---
> >  tests/libqos/virtio.c | 20 +++++++++++++++++---
> >  1 file changed, 17 insertions(+), 3 deletions(-)
> [...]
> > @@ -88,9 +101,10 @@ void qvirtio_set_driver(QVirtioDevice *d)
> > =20
> >  void qvirtio_set_driver_ok(QVirtioDevice *d)
> >  {
> > -    d->bus->set_status(d, d->bus->get_status(d) | VIRTIO_CONFIG_S_DRIV=
ER_OK);
> > -    g_assert_cmphex(d->bus->get_status(d), =3D=3D, VIRTIO_CONFIG_S_DRI=
VER_OK |
> > -                    VIRTIO_CONFIG_S_DRIVER | VIRTIO_CONFIG_S_ACKNOWLED=
GE);
> > +    uint8_t status =3D d->bus->get_status(d) | VIRTIO_CONFIG_S_DRIVER_=
OK;
> > +
> > +    d->bus->set_status(d, status);
> > +    g_assert_cmphex(d->bus->get_status(d), =3D=3D, status);
> >  }
>=20
> The changes to qvirtio_set_driver_ok() are not mentioned in the patch
> description. Please either mention them there, or move this to a
> separate patch.

Will fix in v4.

We can no longer hardcode the status register value for DRIVER_OK since
it now depends on whether VIRTIO 1.0 is used or not.

Here is an alternative that is smaller and makes the VIRTIO 1.0
dependency obvious:

  -    g_assert_cmphex(d->bus->get_status(d), =3D=3D, VIRTIO_CONFIG_S_DRIVE=
R_OK |
  -                    VIRTIO_CONFIG_S_DRIVER | VIRTIO_CONFIG_S_ACKNOWLEDGE=
);
  +    g_assert_cmphex(d->bus->get_status(d), =3D=3D, VIRTIO_CONFIG_S_DRIVE=
R_OK |
  +                    VIRTIO_CONFIG_S_DRIVER | VIRTIO_CONFIG_S_ACKNOWLEDGE=
 |
  +                    (d->features & (1ull << VIRTIO_F_VERSION_1) ?
  +                     VIRTIO_CONFIG_S_FEATURES_OK : 0));

Stefan

--sDKAb4OeUBrWWL6P
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl2vJfYACgkQnKSrs4Gr
c8ihfQgAuBVksV9rNH9gP8551ClMyHkK8CQ6L3nFo6brgqYxQRDKoQbwF16Ph6O1
cRzNWoygeMW2F7aoMipYQ8R/tCsrjxtFd9HFpn/QWDgsyD8ZtR4sm9VKt4qi9z0N
K5a7qpHJO3SAggezsc6XPNXpMZwsZusheMmew6qJjImVDIcm8rdXDMA72FXlLg8G
UPOE/+y0Er7tb2Z/GuG8vY8gUnnJCbrIdyT3KCnpHFPoWVMNQ41DdaPg7TgYWhV9
bvHSde6SNPHf7bUxHm/TFR0fp0lmJB8Io5edV8ciYYmwFjzQsUtRGtKN6pjpQeVP
8m43CscRe8mzxVTCp/8DuLf58H06ZA==
=a30T
-----END PGP SIGNATURE-----

--sDKAb4OeUBrWWL6P--


