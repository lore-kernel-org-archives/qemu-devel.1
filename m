Received: from eggs.gnu.org ([2001:4830:134:3::10]:38648)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1elEmk-00042V-7i
	for qemu-devel@nongnu.org; Mon, 12 Feb 2018 09:08:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1elEmg-00089f-QG
	for qemu-devel@nongnu.org; Mon, 12 Feb 2018 09:08:46 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:53830 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1elEmg-00088q-M0
	for qemu-devel@nongnu.org; Mon, 12 Feb 2018 09:08:42 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
	[10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 53241814DF4C
	for <qemu-devel@nongnu.org>; Mon, 12 Feb 2018 14:08:31 +0000 (UTC)
Date: Mon, 12 Feb 2018 14:08:25 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20180212140825.GF4913@stefanha-x1.localdomain>
References: <20180208171807.24267-1-stefanha@redhat.com>
	<20180208171807.24267-2-stefanha@redhat.com>
	<ea22850e-f1b3-bcdd-db48-b6060e468296@redhat.com>
	<20180209172314.GA3129@localhost.localdomain>
	<94eef553-a2d6-cfac-9e5a-006ceee74519@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="CXFpZVxO6m2Ol4tQ"
Content-Disposition: inline
In-Reply-To: <94eef553-a2d6-cfac-9e5a-006ceee74519@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 1/3] block: add BlockBackend->in_flight
 counter
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org, John Snow <jsnow@redhat.com>


--CXFpZVxO6m2Ol4tQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 09, 2018 at 06:26:41PM +0100, Paolo Bonzini wrote:
> On 09/02/2018 18:23, Kevin Wolf wrote:
> > Am 09.02.2018 um 17:28 hat Paolo Bonzini geschrieben:
> >> On 08/02/2018 18:18, Stefan Hajnoczi wrote:
> >>> +    BlockDriverState *bs =3D blk_bs(blk);
> >>> +
> >>> +    if (bs) {
> >>> +        bdrv_drained_begin(bs);
> >>> +    }
> >>> +
> >>> +    /* We may have aio requests like -ENOMEDIUM in flight */
> >>> +    while (atomic_mb_read(&blk->in_flight) > 0) {
> >>> +        aio_poll(blk_get_aio_context(blk), true);
> >>> +    }
> >>> +
> >>> +    if (bs) {
> >>> +        bdrv_drained_end(bs);
> >>
> >> This only works if you are in the default AioContext, otherwise you can
> >> run handlers for one AioContexts in two threads.
> >=20
> > Should aio_poll() assert that it's called in the right thread to make
> > sure we obey the rules?
> >=20
> >> bdrv_dec_in_flight uses bdrv_wakeup and BDRV_POLL_WHILE to ensure that
> >> this doesn't happen, so there would be more code that you have to copy
> >> into block-backend.c.
> >=20
> > Instead of copying, can't we generalise it into a POLL_WHILE(ctx,
> > wakeup, cond) and make BDRV_POLL_WHILE() a wrapper for that?
>=20
> Yes, or even move bdrv_wakeup to AioContext would do.  We already have
> block layer-specific fields such as the linux-aio state(*).
>=20
> 	(*) though now that linux-aio has been improved to do something
> 	    like epoll, there may be a better reason to place linux-aio
> 	    state in AioContext.

Thanks for the ideas, will fix in v2.

Stefan

--CXFpZVxO6m2Ol4tQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJagZ/ZAAoJEJykq7OBq3PIxU4H/3gLtBLtpP8D20/q1/doJSTX
MZCJdNgfypOLl0R1rBOvd727l7hyrv4spsLoKjRLQtT6+TuicuoRGmMVXK/mFn5Y
x69gB3SHiGtPMWcNw9TmID1yz4bvxltzzCInbqaKVEVhIwiZLwUiAMMPxmo6qREp
XUgnWuk7o9k8NzCf7qrUIjDCYa+b7smI4WpAJj1CZgd5Yb3Sb5Cc1zFAI7dyvq6b
6Yr6K8WPkACLGFmyV3CUjnJtetYg/aFxrDAbcVirXHLhIJnNZhfNKjmx/x30AxSx
XIIJPt0gHcvVu5QFF/WnG9ORXouokuu4NHMMH4F/4JIyWocy93tqz7oqYvbnD9M=
=ZuMl
-----END PGP SIGNATURE-----

--CXFpZVxO6m2Ol4tQ--
