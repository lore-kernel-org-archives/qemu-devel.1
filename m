Return-Path: <SRS0=Z1O7=DF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 573E0C2D0A8
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Sep 2020 10:22:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D704421531
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Sep 2020 10:22:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AJzsSyAN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D704421531
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51306 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kMqIQ-0001Fs-UE
	for qemu-devel@archiver.kernel.org; Mon, 28 Sep 2020 06:22:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38666)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1kMqHp-0000kn-E6
 for qemu-devel@nongnu.org; Mon, 28 Sep 2020 06:21:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:34136)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1kMqHl-0003Km-GO
 for qemu-devel@nongnu.org; Mon, 28 Sep 2020 06:21:37 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601288492;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=sq3SCr/G8YXnLfiMHpGI+TfJxC2L8wanh412SIrsw+Q=;
 b=AJzsSyANY5QchuOkA1eiMAbuQPQ4HZ/IHTs9qdASq2OuLgOqlSJJfTOzLILIcLuJdAD6W/
 81npLLzLLK8CY8dXGy8wVHlzYtzq1+XeRT2bFI/PE520l4mwfolTbSPzTgTegeGre+FOGV
 7h72HG2tTtT3BH0Y+RcmvaWRTloL3O4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-75-YclfzLaqMoSDMaTjnOfeXw-1; Mon, 28 Sep 2020 06:21:30 -0400
X-MC-Unique: YclfzLaqMoSDMaTjnOfeXw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 268171021200;
 Mon, 28 Sep 2020 10:21:29 +0000 (UTC)
Received: from linux.fritz.box (ovpn-114-193.ams2.redhat.com [10.36.114.193])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id B8F1D7838A;
 Mon, 28 Sep 2020 10:21:24 +0000 (UTC)
Date: Mon, 28 Sep 2020 12:21:23 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: [PATCH v7 12/13] block: Add bdrv_co_move_to_aio_context()
Message-ID: <20200928102123.GC5451@linux.fritz.box>
References: <20200909151149.490589-1-kwolf@redhat.com>
 <20200909151149.490589-13-kwolf@redhat.com>
 <20200915143142.GE629589@stefanha-x1.localdomain>
 <20200925160051.GI5731@linux.fritz.box>
 <20200928085911.GD43571@stefanha-x1.localdomain>
MIME-Version: 1.0
In-Reply-To: <20200928085911.GD43571@stefanha-x1.localdomain>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=kwolf@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="+pHx0qQiF2pBVqBT"
Content-Disposition: inline
Received-SPF: pass client-ip=216.205.24.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/28 03:29:35
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -36
X-Spam_score: -3.7
X-Spam_bar: ---
X-Spam_report: (-3.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.576,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Cc: qemu-devel@nongnu.org, marcandre.lureau@gmail.com, armbru@redhat.com,
 qemu-block@nongnu.org, dgilbert@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--+pHx0qQiF2pBVqBT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Am 28.09.2020 um 10:59 hat Stefan Hajnoczi geschrieben:
> On Fri, Sep 25, 2020 at 06:00:51PM +0200, Kevin Wolf wrote:
> > Am 15.09.2020 um 16:31 hat Stefan Hajnoczi geschrieben:
> > > On Wed, Sep 09, 2020 at 05:11:48PM +0200, Kevin Wolf wrote:
> > > > Add a function to move the current coroutine to the AioContext of a
> > > > given BlockDriverState.
> > > >=20
> > > > Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> > > > ---
> > > >  include/block/block.h |  6 ++++++
> > > >  block.c               | 10 ++++++++++
> > > >  2 files changed, 16 insertions(+)
> > > >=20
> > > > diff --git a/include/block/block.h b/include/block/block.h
> > > > index 981ab5b314..80ab322f11 100644
> > > > --- a/include/block/block.h
> > > > +++ b/include/block/block.h
> > > > @@ -626,6 +626,12 @@ bool bdrv_debug_is_suspended(BlockDriverState =
*bs, const char *tag);
> > > >   */
> > > >  AioContext *bdrv_get_aio_context(BlockDriverState *bs);
> > > > =20
> > > > +/**
> > > > + * Move the current coroutine to the AioContext of @bs and return =
the old
> > > > + * AioContext of the coroutine.
> > > > + */
> > > > +AioContext *coroutine_fn bdrv_co_move_to_aio_context(BlockDriverSt=
ate *bs);
> > >=20
> > > I'm not sure this function handles all cases:
> > > 1. Being called without the BQL (i.e. from an IOThread).
> > > 2. Being called while a device stops using its IOThread.
> > >=20
> > > The races that come to mind are fetching the AioContext for bs and th=
en
> > > scheduling a BH. The BH is executed later on by the event loop. There
> > > might be cases where the AioContext for bs is updated before the BH
> > > runs.
>=20
> The scenario I'm thinking about is where bs' AioContext changes while we
> are trying to move there.
>=20
> There is a window of time between fetching bs' AioContext, scheduling a
> BH in our old AioContext (not in bs' AioContext), and then scheduling
> the coroutine into the AioContext we previously fetched for bs.
>=20
> Is it possible for the AioContext value we stashed to be outdated by the
> time we use it?
>=20
> I think the answer is that it's safe to use this function from the main
> loop thread under the BQL. That way nothing else will change bs'
> AioContext while we're running. But it's probably not safe to use this
> function from an arbitrary IOThread (without the BQL).

It's probably the safest to treat it as such. The first part of it (the
window between fetching bs->aio_context and using it) is actually also
true for this ubiquitous sequence:

    AioContext *ctx =3D bdrv_get_aio_context(bs);
    aio_context_acquire(ctx);

I never really thought about this, but this is only safe in the main
thread. Most of its users are of course monitor command handlers, which
always run in the main thread.

> I think this limitation is okay but it needs to be documented. Maybe an
> assertion can verify that it holds.

Yes, why not.

Maybe we should actually change the interface into a pair of
bdrv_co_enter/leave() functions that also increase bs->in_flight so that
the whole section will complete before the AioContext of bs changes
(changing the AioContext while the handle coroutine has yielded and will
continue to run in the old context would be bad).

block_resize is safe without it, but it might be better to introduce
patterns that will be safe without being extra careful in each command.

Kevin

--+pHx0qQiF2pBVqBT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE3D3rFZqa+V09dFb+fwmycsiPL9YFAl9xuSMACgkQfwmycsiP
L9ZT0g/8CLqbnTAT17v8QZ8+fUKY6Kq9bcNGaath3UIWAvU4I3ftzLSzB0I7oaP+
psidigtCbMJJt35JSUyvaZhv/DBg3HK74ww9lc+K6iDQBj7FIMdDcZ7PTqqb2/PY
z3mSSCLPu902XSWLPbgEs8NvMkJ/JFHbYqiMbp1kDAfJxH8ZNh7wRiOb0GgcIDUb
xO4piknsbpbclQB4Z818FiZmrCcq+Uhp+hQuxFw23TX4BaGQVF9Dh4M6xd85bIYU
nywzYmtqWq9prKODxb7dHxFdQ0Kbu06NzrRXrze0QYMRqKFUIWZ2qfySjD1hfB6U
9XMp9XURqHWjLxubFI9GSiU3guG1KZA0AWkk8r8CAEw4jsIaOCJjRqdso1p5NxYY
3H/cer/Ns9SYLE7DGQ8pjEaQd8JvRx1BSPpuOFvjTeAAOE+exDIYPAhUNymPubL4
ByWkJmL32JjDZ6yQSRWpCvq2maG6fhC8OuUSl6IWOrkQXSz9k5n13FprD1z/nK1N
koztodKWIaOvF5jnQ6QKnKIHN//mrUHqK7QdqOWhLSOWRVn1hyZqfk+gvpLBb+qC
u1GQvYBdjMCt2Lhfl1WoeKuD+Q4ZHa+vGZOqSPYlpAy1YOadzxV/lnVvDRhcGRUJ
vjPLDmVvSGkAToonT2ZWijNm5FQ0gFULNUUWQLy7ccQsM4588Qc=
=v4SQ
-----END PGP SIGNATURE-----

--+pHx0qQiF2pBVqBT--


