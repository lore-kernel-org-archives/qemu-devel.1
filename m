Return-Path: <SRS0=5yua=6H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09847C54FCB
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2020 13:01:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C4A322076C
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2020 13:01:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Lkm7yLev"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C4A322076C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42828 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jRbTk-00031j-Pd
	for qemu-devel@archiver.kernel.org; Thu, 23 Apr 2020 09:01:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37374)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1jRbSi-0002FN-N9
 for qemu-devel@nongnu.org; Thu, 23 Apr 2020 09:00:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1jRbSg-00025X-HM
 for qemu-devel@nongnu.org; Thu, 23 Apr 2020 09:00:16 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:31382
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1jRbSf-00020L-T2
 for qemu-devel@nongnu.org; Thu, 23 Apr 2020 09:00:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1587646812;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=LsnuHfLuG9/l2Kz9MIdDfzb87V6SZhCES5QHj/Pf4vw=;
 b=Lkm7yLevYRw03W0v0b8IKV6k77YatD7xNMLQHaVasPQay2GnNOFce+2IhnF2ynj8ptDiMc
 9OfpRPu6Y46SOscG4CPQKLFQ+mSkQoZuIOY/JKP+Bg9UZi66r8cm4OeTu6C4XUeFVVr3MI
 RbcRJrvUY9bRy/gICgQh5C2ADm844nc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-434-brKwVEuGMJCZhCTE0A8xMA-1; Thu, 23 Apr 2020 09:00:10 -0400
X-MC-Unique: brKwVEuGMJCZhCTE0A8xMA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1D591872FE0;
 Thu, 23 Apr 2020 13:00:09 +0000 (UTC)
Received: from linux.fritz.box (ovpn-114-28.ams2.redhat.com [10.36.114.28])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 3AC0B1002381;
 Thu, 23 Apr 2020 13:00:07 +0000 (UTC)
Date: Thu, 23 Apr 2020 15:00:05 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Max Reitz <mreitz@redhat.com>
Subject: Re: [PATCH v5 7/9] block: truncate: Don't make backing file data
 visible
Message-ID: <20200423130005.GB7687@linux.fritz.box>
References: <20200422152129.167074-1-kwolf@redhat.com>
 <20200422152129.167074-8-kwolf@redhat.com>
 <1d0c34af-7efa-9be7-669e-fe15cf89e3cb@redhat.com>
MIME-Version: 1.0
In-Reply-To: <1d0c34af-7efa-9be7-669e-fe15cf89e3cb@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="wq9mPyueHGvFACwf"
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.61; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/23 03:23:21
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
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
Cc: berto@igalia.com, vsementsov@virtuozzo.com, qemu-devel@nongnu.org,
 qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--wq9mPyueHGvFACwf
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Am 23.04.2020 um 13:14 hat Max Reitz geschrieben:
> On 22.04.20 17:21, Kevin Wolf wrote:
> > When extending the size of an image that has a backing file larger than
> > its old size, make sure that the backing file data doesn't become
> > visible in the guest, but the added area is properly zeroed out.
> >=20
> > Consider the following scenario where the overlay is shorter than its
> > backing file:
> >=20
> >     base.qcow2:     AAAAAAAA
> >     overlay.qcow2:  BBBB
> >=20
> > When resizing (extending) overlay.qcow2, the new blocks should not stay
> > unallocated and make the additional As from base.qcow2 visible like
> > before this patch, but zeros should be read.
> >=20
> > A similar case happens with the various variants of a commit job when a=
n
> > intermediate file is short (- for unallocated):
> >=20
> >     base.qcow2:     A-A-AAAA
> >     mid.qcow2:      BB-B
> >     top.qcow2:      C--C--C-
> >=20
> > After commit top.qcow2 to mid.qcow2, the following happens:
> >=20
> >     mid.qcow2:      CB-C00C0 (correct result)
> >     mid.qcow2:      CB-C--C- (before this fix)
> >=20
> > Without the fix, blocks that previously read as zeros on top.qcow2
> > suddenly turn into A.
> >=20
> > Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> > Reviewed-by: Alberto Garcia <berto@igalia.com>
> > ---
> >  block/io.c | 14 ++++++++++++++
> >  1 file changed, 14 insertions(+)
> >=20
> > diff --git a/block/io.c b/block/io.c
> > index 795075954e..8fbb607515 100644
> > --- a/block/io.c
> > +++ b/block/io.c
> > @@ -3394,6 +3394,20 @@ int coroutine_fn bdrv_co_truncate(BdrvChild *chi=
ld, int64_t offset, bool exact,
> >          goto out;
> >      }
> > =20
> > +    /*
> > +     * If the image has a backing file that is large enough that it wo=
uld
> > +     * provide data for the new area, we cannot leave it unallocated b=
ecause
> > +     * then the backing file content would become visible. Instead, ze=
ro-fill
> > +     * the new area.
> > +     *
> > +     * Note that if the image has a backing file, but was opened witho=
ut the
> > +     * backing file, taking care of keeping things consistent with tha=
t backing
> > +     * file is the user's responsibility.
> > +     */
> > +    if (new_bytes && bs->backing) {
> > +        flags |=3D BDRV_REQ_ZERO_WRITE;
> > +    }
>=20
> This breaks growing any non-qcow2 image with any backing file.  Do we
> care about that?
>=20
> The comment says something about =E2=80=9Ca backing file that is large en=
ough
> that it would provide data for the new area=E2=80=9D, but that condition =
doesn=E2=80=99t
> appear in the code.  Should it?  (If it did, I think the number of cases
> this change broke would be much smaller.)
>=20
> If it was deliberate to not have that condition here, and if we decide
> that we don=E2=80=99t care about non-qcow2 formats here, then I think at =
least
> the error message deserves some improvement over =E2=80=9Cqemu-img: Block=
 driver
> does not support requested flags=E2=80=9D.

This was not deliberate. v3 had the check and I'm not sure why I removed
it. Probably because the new approach felt so much simpler and I was
glad that I could throw away complicated code that I threw away more
than I should have...

Kevin

--wq9mPyueHGvFACwf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE3D3rFZqa+V09dFb+fwmycsiPL9YFAl6hkUEACgkQfwmycsiP
L9aiJQ/9F9/1tuerval4Jd+BBWPvU8wtiLym0miUlgb5tUoJMPApKh5kYh8bskD2
WVJSKBXgqTJ4HgsQI2F1mZxdfabH0yWpVJ5tRSrbuAkW70Q63ArO+fnjGRKScP/t
V4PIYFxYQAes4hx2MSl3ElJ1WzC+7p78ZSzTl977SqFeH9JBMrtxcupFFUzOfF5m
Rl0wAF4+vKKWA3cSsqr6KKSAK0WujLWt1YjYTF/8VC67PLRYGuvLiTnpL2vUQEa5
L3OiGkRv0QtrDFlWApFJI8j90bIRgvMPgtBkT3DRBrkexDmm9+fIQLc9nUbvdRoj
KgQ8zBMKnaR1bzGFRm95xeCTjweZqMUDQqwE1vv2Uaxvl41jGcN6mtHOvji6gjre
qPBBCw1gh9h7eOMUOAPlo6Iu2qYBTXxpTgGR/ZgS/Uc7ZzjTne7M++TR+HKi5M4g
fKVvoUQjYDhLE1zk3whYNjFpF5E7Dx8ht1IZSu5k8QYH7IhNQF/RNNdIj4DACJgR
KTDqsEGCaz+vNIW+QJUwA0xtxxtzYiEQ/zt0kMaU9KHSLZlZP7sDmTdW8i9s7ev3
gQzsv0Gwgo3ui+g6oi7+6rSLwOLnh7EO4OL/e6m31YympjlZZ4plpVNEDT5BPxRB
yKuEwd+41qgCdPyl9PZxBHHP6S6cHpe7+icPeu4QOYKfNl/z9vk=
=FrxW
-----END PGP SIGNATURE-----

--wq9mPyueHGvFACwf--


