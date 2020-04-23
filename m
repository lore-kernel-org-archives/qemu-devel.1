Return-Path: <SRS0=5yua=6H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5F8BC55186
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2020 13:26:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A34842084D
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2020 13:26:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YoDYO3ss"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A34842084D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43226 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jRbsE-0002tE-RL
	for qemu-devel@archiver.kernel.org; Thu, 23 Apr 2020 09:26:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42868)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1jRbrX-0002Jl-7i
 for qemu-devel@nongnu.org; Thu, 23 Apr 2020 09:25:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1jRbrW-00038K-FI
 for qemu-devel@nongnu.org; Thu, 23 Apr 2020 09:25:55 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:32734
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1jRbrW-000379-1s
 for qemu-devel@nongnu.org; Thu, 23 Apr 2020 09:25:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1587648353;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=LXK96gXOyTeWMEipjOOQ+YbC595VdcVwjX6DU9/kOsw=;
 b=YoDYO3ssnP2moe1eoag3bMMGWMuK9AMOmn4N06tzlWZkA7/Vq/Xt1xZMtPrfg+lCQmP8jz
 SLcl9kHjFvK214SxYmHyP73aIORibYEvfzuhrygaKO911ua/O4q1x0Z2E0e59zCpp7xwLU
 TyihoOcQE/dWSaUYFbpEE0w4xHzgEQk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-69-iJH9yKafORaP-3saKlWkSQ-1; Thu, 23 Apr 2020 09:25:49 -0400
X-MC-Unique: iJH9yKafORaP-3saKlWkSQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EE564107B7C4;
 Thu, 23 Apr 2020 13:25:47 +0000 (UTC)
Received: from linux.fritz.box (ovpn-114-28.ams2.redhat.com [10.36.114.28])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 8C5AE5C1D2;
 Thu, 23 Apr 2020 13:25:46 +0000 (UTC)
Date: Thu, 23 Apr 2020 15:25:45 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Max Reitz <mreitz@redhat.com>
Subject: Re: [PATCH v5 4/9] qcow2: Support BDRV_REQ_ZERO_WRITE for truncate
Message-ID: <20200423132545.GB23654@linux.fritz.box>
References: <20200422152129.167074-1-kwolf@redhat.com>
 <20200422152129.167074-5-kwolf@redhat.com>
 <282cd7bb-71e0-f3df-13cb-c098597cf704@redhat.com>
MIME-Version: 1.0
In-Reply-To: <282cd7bb-71e0-f3df-13cb-c098597cf704@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="d6Gm4EdcadzBjdND"
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.120; envelope-from=kwolf@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/23 06:43:51
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
Cc: berto@igalia.com, vsementsov@virtuozzo.com, qemu-devel@nongnu.org,
 qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--d6Gm4EdcadzBjdND
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Am 23.04.2020 um 12:53 hat Max Reitz geschrieben:
> On 22.04.20 17:21, Kevin Wolf wrote:
> > If BDRV_REQ_ZERO_WRITE is set and we're extending the image, calling
> > qcow2_cluster_zeroize() with flags=3D0 does the right thing: It doesn't
> > undo any previous preallocation, but just adds the zero flag to all
> > relevant L2 entries. If an external data file is in use, a write_zeroes
> > request to the data file is made instead.
> >=20
> > Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> > ---
> >  block/qcow2.c | 30 ++++++++++++++++++++++++++++++
> >  1 file changed, 30 insertions(+)
> >=20
> > diff --git a/block/qcow2.c b/block/qcow2.c
> > index 9cfbdfc939..bd632405d1 100644
> > --- a/block/qcow2.c
> > +++ b/block/qcow2.c
>=20
> [...]
>=20
> > @@ -4214,6 +4215,35 @@ static int coroutine_fn qcow2_co_truncate(BlockD=
riverState *bs, int64_t offset,
> >          g_assert_not_reached();
> >      }
> > =20
> > +    if ((flags & BDRV_REQ_ZERO_WRITE) && offset > old_length) {
> > +        uint64_t zero_start =3D QEMU_ALIGN_UP(old_length, s->cluster_s=
ize);
> > +        uint64_t zero_end =3D QEMU_ALIGN_UP(offset, s->cluster_size);
> > +
> > +        /* Use zero clusters as much as we can */
> > +        ret =3D qcow2_cluster_zeroize(bs, zero_start, zero_end - zero_=
start, 0);
>=20
> It=E2=80=99s kind of a pity that this changes the cluster mappings that w=
ere
> established when using falloc/full preallocation already (i.e., they
> become preallocated zero clusters then, so when writing to them, we need
> COW again).
>=20
> But falloc/full preallocation do not guarantee that the new data is
> zero, so I suppose this is the only thing we can reasonably do.

If we really want, I guess we could make full preallocation first try
passing BDRV_REQ_ZERO_WRITE to the protocol layer and if that succeeds,
we could skip setting the zero cluster flag at the qcow2 level.

Feels like a separate patch, though.

Kevin

--d6Gm4EdcadzBjdND
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE3D3rFZqa+V09dFb+fwmycsiPL9YFAl6hl1gACgkQfwmycsiP
L9bTNQ/8DCPc1YuCtzIoliNV4E4U87a5nCx0I+Hvcj5Kpnjrtp+FTIeIJb3t3wBJ
SK883OVlU2Z3PLJ5pDRui7T2QRYYXlRKDbqadAJT8qot/JdW0tyr5lTOLwF6cHw5
oFUpnKPBw4gvlB4e1sbQguDZdbkfP989YoqS3MOYZeYxHhZ+XDur3f9l7G+qnJI9
JbWLIDKzAS3vRofJKnFKExMnN428bFRE8p6/f/vjmoEFlcz1GqG5f25EPsgGTsHA
OLG1daedYxy76ibFMUsVgs9B2ccg+cqlO47YSihz+laUSwUHehuy+u+o7FhzQgTq
4b9fPDi/segQC0WG4qVkFzs3SJ05n1lUhmikzlbhuSzIAHHy8aIhmhoiBAjCsC9A
4o2p71++xXavNZ48Axk6aF4Ahnzow6SCXkBbMqXfnzi2QDprmkix7OMPa0zja5nY
btOC04N5GSf0XJwvFu0WdfjbdK1sDGgYqNwpL1pTZ+82+7hYhvyZ0pKgZnQUdYD9
rIMKjWxrWu3b+kLwXeA1kIrDd8+VOl0staWke2O16plXOD09m8qi2JM5ah1RlBUi
iFaIuHRvt+t3cD3wRFhabI21cL9nh0XXRSIM+aZ+h9waa1FWNa+xeoxfC60lCexy
EPs0QKVUN3wkoslaLAR6WrWAW7MzkAuZ7WqpbhLQ05JDEvK1l14=
=6vic
-----END PGP SIGNATURE-----

--d6Gm4EdcadzBjdND--


