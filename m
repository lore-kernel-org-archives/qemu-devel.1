Return-Path: <SRS0=tSBD=YP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C4EACA9EA0
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2019 16:07:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1526020B7C
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2019 16:07:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="f5Ra3dzm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1526020B7C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34626 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iMwhM-0003Rj-Lq
	for qemu-devel@archiver.kernel.org; Tue, 22 Oct 2019 12:07:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33278)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@redhat.com>) id 1iMwU9-0002Rn-NS
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 11:54:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@redhat.com>) id 1iMwU8-0008B1-Jg
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 11:54:13 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:60062
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1iMwU8-0008Am-G2
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 11:54:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1571759651;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=A29quRhd0zngvZ8JXaCGEzXz+AdljoO/ETzuprjksoY=;
 b=f5Ra3dzmw9GDHeg1xKDcVSHFhRkd8xEEe41pAUSxLHmDWwGvk0FIap3bDW/bEVF5lDUYEl
 ojABoyj4LH9n2xGwh9aUpaEEyLUrW9W99etYaHS/Mbn+qQMZhwN0jH9f4fIu02sYCS+cHd
 Q0a2jImNS0mN0g1QNJkZ3ZcpdTWm0uI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-208-UGteKI7mOyCIi71nFBgNAQ-1; Tue, 22 Oct 2019 11:54:08 -0400
X-MC-Unique: UGteKI7mOyCIi71nFBgNAQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 491541800D6A;
 Tue, 22 Oct 2019 15:54:07 +0000 (UTC)
Received: from localhost (ovpn-117-153.ams2.redhat.com [10.36.117.153])
 by smtp.corp.redhat.com (Postfix) with ESMTP id B4AEA60856;
 Tue, 22 Oct 2019 15:54:01 +0000 (UTC)
Date: Tue, 22 Oct 2019 16:54:00 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Thomas Huth <thuth@redhat.com>
Subject: Re: [PATCH v3 09/16] libqos: access VIRTIO 1.0 vring in little-endian
Message-ID: <20191022155400.GG32186@stefanha-x1.localdomain>
References: <20191019063810.6944-1-stefanha@redhat.com>
 <20191019063810.6944-10-stefanha@redhat.com>
 <bc98f11d-e067-f18b-2461-dcf56cfd1f47@redhat.com>
MIME-Version: 1.0
In-Reply-To: <bc98f11d-e067-f18b-2461-dcf56cfd1f47@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="MrRUTeZlqqNo1jQ9"
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
Cc: Fam Zheng <fam@euphon.net>, Laurent Vivier <lvivier@redhat.com>,
 slp@redhat.com, qemu-block@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>,
 qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--MrRUTeZlqqNo1jQ9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 21, 2019 at 02:48:08PM +0200, Thomas Huth wrote:
> On 19/10/2019 08.38, Stefan Hajnoczi wrote:
> > VIRTIO 1.0 uses little-endian for the vring.  Legacy VIRTIO uses guest
> > endianness.  Adjust the code to handle both.
> >=20
> > Note that qvirtio_readq() is not defined because it has no users.  All
> > the other accessors are really needed.
> >=20
> > Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> > ---
> >  tests/libqos/virtio.h      |   4 +-
> >  tests/libqos/virtio-mmio.c |   1 +
> >  tests/libqos/virtio-pci.c  |   1 +
> >  tests/libqos/virtio.c      | 131 +++++++++++++++++++++++++++----------
> >  tests/virtio-blk-test.c    |   8 +--
> >  5 files changed, 106 insertions(+), 39 deletions(-)
> [...]
> > @@ -191,23 +248,23 @@ void qvring_init(QTestState *qts, const QGuestAll=
ocator *alloc, QVirtQueue *vq,
> > =20
> >      for (i =3D 0; i < vq->size - 1; i++) {
> >          /* vq->desc[i].addr */
> > -        qtest_writeq(qts, vq->desc + (16 * i), 0);
> > +        qvirtio_writeq(vq->vdev, qts, vq->desc + (16 * i), 0);
> >          /* vq->desc[i].next */
> > -        qtest_writew(qts, vq->desc + (16 * i) + 14, i + 1);
> > +        qvirtio_writew(vq->vdev, qts, vq->desc + (16 * i) + 14, i + 1)=
;
> >      }
> > =20
> >      /* vq->avail->flags */
> > -    qtest_writew(qts, vq->avail, 0);
> > +    qvirtio_writew(vq->vdev, qts, vq->avail, 0);
> >      /* vq->avail->idx */
> > -    qtest_writew(qts, vq->avail + 2, 0);
> > +    qvirtio_writew(vq->vdev, qts, vq->avail + 2, 0);
> >      /* vq->avail->used_event */
> > -    qtest_writew(qts, vq->avail + 4 + (2 * vq->size), 0);
> > +    qvirtio_writew(vq->vdev, qts, vq->avail + 4 + (2 * vq->size), 0);
> > =20
> >      /* vq->used->flags */
> > -    qtest_writew(qts, vq->used, 0);
> > +    qvirtio_writew(vq->vdev, qts, vq->used, 0);
> >      /* vq->used->avail_event */
> > -    qtest_writew(qts, vq->used + 2 + sizeof(struct vring_used_elem) * =
vq->size,
> > -                 0);
> > +    qvirtio_writew(vq->vdev, qts, vq->used + 2 +
> > +            sizeof(struct vring_used_elem) * vq->size, 0);
>=20
> Fix indentation in the above line?

Will fix in v4.

--MrRUTeZlqqNo1jQ9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl2vJhgACgkQnKSrs4Gr
c8j4wQf/bIbPLoEsOohdKl+DWu9Z1mdQXbpaNI6i9LVQozL+MdGKFbs5Nl817GkD
KMfMmMJxiLY+p6G3mT/+SYkVK2Isu9ZV/SJ4Y7mcUOKAqfVdQwFACxgjXG5k1SO/
KNM/R5nmsOJriDK1VJsTA829ibuhDyPGjq7in3ARctB0yRBfBuSV8b4n55vbe2hK
Is3U8Jr8IBKis0yaensC0iLluodDRRpBRwXfETtwAeMyGkwPUBYC4pmZFDP8WCBB
jmTg/j7gYL1Q+f02whhRraS737/b+HoeyXnwzsXg96DxnwUNJ0FP2T8WmYFJe51+
khAUpZ0DX0J8IktXdOsRQIUjA8pHIQ==
=x9PW
-----END PGP SIGNATURE-----

--MrRUTeZlqqNo1jQ9--


