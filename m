Return-Path: <SRS0=tSBD=YP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31A8DCA9EA0
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2019 15:53:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F0261214E0
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2019 15:53:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="W01GX0Km"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F0261214E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34004 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iMwTl-0001Xp-15
	for qemu-devel@archiver.kernel.org; Tue, 22 Oct 2019 11:53:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60970)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@redhat.com>) id 1iMwOz-0005Al-2t
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 11:48:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@redhat.com>) id 1iMwOx-0004BQ-5k
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 11:48:52 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:22596
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1iMwOw-0004An-Sr
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 11:48:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1571759330;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=D6yOI/R8uemwWw45AquIfMxN1nhxnYxjMR8iFOr1ZyA=;
 b=W01GX0Kmo87MYEDBZ284aRMlagSJsHUV7o1lbNlykt97quEFYjse/cX7j8DiRL1ZG66b2p
 UPX1AGitUNXu9/Xm9HRUOVk/wq0pnsIgPcZ8foe2Q9Bu5XOHEGn8BGTjlzsVtzH3ws/avP
 k1CXO0ZhgH3z3hRv1xwJnzfUauODRxM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-101-cwBgPb79Ofe3ZM0iqiePxw-1; Tue, 22 Oct 2019 11:48:48 -0400
X-MC-Unique: cwBgPb79Ofe3ZM0iqiePxw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id F1AAD476;
 Tue, 22 Oct 2019 15:48:46 +0000 (UTC)
Received: from localhost (ovpn-117-153.ams2.redhat.com [10.36.117.153])
 by smtp.corp.redhat.com (Postfix) with ESMTP id CCCDF19C4F;
 Tue, 22 Oct 2019 15:48:41 +0000 (UTC)
Date: Tue, 22 Oct 2019 16:48:40 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Thomas Huth <thuth@redhat.com>
Subject: Re: [PATCH v3 07/16] libqos: enforce Device Initialization order
Message-ID: <20191022154840.GE32186@stefanha-x1.localdomain>
References: <20191019063810.6944-1-stefanha@redhat.com>
 <20191019063810.6944-8-stefanha@redhat.com>
 <158ef0b2-c478-1304-3128-8feb7cd943d4@redhat.com>
MIME-Version: 1.0
In-Reply-To: <158ef0b2-c478-1304-3128-8feb7cd943d4@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="ILuaRSyQpoVaJ1HG"
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

--ILuaRSyQpoVaJ1HG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 21, 2019 at 02:15:53PM +0200, Thomas Huth wrote:
> On 19/10/2019 08.38, Stefan Hajnoczi wrote:
> > According to VIRTIO 1.1 "3.1.1 Driver Requirements: Device
> > Initialization", configuration space and virtqueues cannot be accessed
> > before features have been negotiated.  Enforce this requirement.
> >=20
> > Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> > ---
> >  tests/libqos/virtio.c | 11 +++++++++++
> >  1 file changed, 11 insertions(+)
> >=20
> > diff --git a/tests/libqos/virtio.c b/tests/libqos/virtio.c
> > index 4f7e6bb8a1..2593996c98 100644
> > --- a/tests/libqos/virtio.c
> > +++ b/tests/libqos/virtio.c
> > @@ -13,23 +13,33 @@
> >  #include "standard-headers/linux/virtio_config.h"
> >  #include "standard-headers/linux/virtio_ring.h"
> > =20
> > +/* Features must be negotiated before config space or virtqueue access=
 */
> > +static void check_features_negotiated(QVirtioDevice *d)
> > +{
> > +    g_assert_cmphex(d->features, !=3D, 0);
> > +}
>=20
> Isn't it "legal" to negotiate 0 feature bits, too (for legacy devices)?

Yes, it's possible for Legacy devices.  If someone ever does that
they'll need to extend this code, but it's unlikely so I'd rather not
complicate this.

Stefan

--ILuaRSyQpoVaJ1HG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl2vJNgACgkQnKSrs4Gr
c8hAnggAw1tsUfLNzvTFGPGJi+Dpw9tSx+O3//gwzvvp9HJjql/alI3ktjajonVK
0qneWxWS2BAY2lQEZKyTL+NXJa9CCkeZKmreqb/YAX+/j51GKbmh0F/tgCmdViNZ
b5WyFqxZm4VvTgNSOyIKu16E5yOSZsZ5aGwV9KLGruNy77tJaaTEf3p6Kz40ITfk
ag5CQuyABfgax4NdvMrHIoYdGCJvUJSkxGWDVupnikecgqwg9XEN0y1ZCAja0wZG
gBkU6yjJSHKWIL4pZUJX16dV1VvJ5hmUqH3WSa29Qau8lx04etAbkdXR/SSQZ+99
Syp8B0PXQlwJ6DieqeGUiAtQbXXafw==
=zamH
-----END PGP SIGNATURE-----

--ILuaRSyQpoVaJ1HG--


