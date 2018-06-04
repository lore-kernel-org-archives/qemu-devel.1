Received: from eggs.gnu.org ([2001:4830:134:3::10]:47301)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1fPmHO-0002RI-DM
	for qemu-devel@nongnu.org; Mon, 04 Jun 2018 05:59:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1fPmHN-0002wZ-Fb
	for qemu-devel@nongnu.org; Mon, 04 Jun 2018 05:59:58 -0400
Date: Mon, 4 Jun 2018 10:59:48 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20180604095948.GF13674@stefanha-x1.localdomain>
References: <1527801443-30620-1-git-send-email-ari@tuxera.com>
	<e890432c-cfb4-d933-c1a8-d571ac5687e8@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="kbCYTQG2MZjuOjyn"
Content-Disposition: inline
In-Reply-To: <e890432c-cfb4-d933-c1a8-d571ac5687e8@redhat.com>
Subject: Re: [Qemu-devel] [Qemu-block]  [PATCH 1/5] block: Add blklogwrites
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: Ari Sundholm <ari@tuxera.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org, Aapo Vienamo <aapo@tuxera.com>


--kbCYTQG2MZjuOjyn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 01, 2018 at 07:26:03AM -0500, Eric Blake wrote:
> On 05/31/2018 04:17 PM, Ari Sundholm wrote:
> > +static void blk_log_writes_co_do_file(void *opaque)
> > +{
> > +    BlkLogWritesFileReq *fr =3D opaque;
> > +
> > +    fr->file_ret =3D fr->func(fr);
> > +
> > +    fr->r->done++;
>=20
> Two non-atomic increments...
>=20
> > +    qemu_coroutine_enter_if_inactive(fr->r->co);
> > +}
> > +
> > +static int coroutine_fn
> > +blk_log_writes_co_log(BlockDriverState *bs, uint64_t offset, uint64_t =
bytes,
> > +                      QEMUIOVector *qiov, int flags,
> > +                      int (*file_func)(BlkLogWritesFileReq *r),
> > +                      uint64_t entry_flags)
> > +{
>=20
> > +    qemu_coroutine_enter(co_file);
> > +    qemu_coroutine_enter(co_log);
> > +
> > +    while (r.done < 2) {
> > +        qemu_coroutine_yield();
> > +    }
>=20
> ...used as the condition for waiting.  Since the point of coroutines is to
> allow (restricted) parallel operation, there's a chance that the coroutine
> implementation can be utilizing parallel threads; if that's the case, then
> on the rare race when both threads try to increment at near the same time,
> they can both read 0 and write 1, at which point this wait loop would be =
an
> infinite loop.  You're probably better off using atomics (even if I'm wro=
ng
> about coroutines being able to race each other on the increment, as the
> other point of coroutines is that they provide restricted parallelism whe=
re
> you can also implement them in only a single thread because of well-defin=
ed
> yield points).

In this case the coroutines run from a single event loop (the
BlockDriverState's AioContext) so they cannot race.

As QEMU transitions to a multi-queue block layer we will need to think
about parallelism more.  But the multi-queue block layer isn't
implemented yet, so I prefer writing straightforward code now without
trying to anticipate what parallelism issues might arise in the future.

Stefan

--kbCYTQG2MZjuOjyn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJbFQ2UAAoJEJykq7OBq3PImdcH+wYizpAsmiMBaM60hpRcXLEZ
9oAKOLmPnG5NN/7unujH0WCuxjcXtEClGzj6+N6N3CIUMLrVJ956ZcOs8NsQzBDe
+8vGdqSWOtvnJuw57WzysZn/g2vm6zua5XInbKyYf0ck/WEuqSo4Hj5FE/oEFuzh
H8cLHBxhKVW1e5SQFKI/SKP4jJNdjFt/yfypEdyams+lfWVj3n53JggjA0q6ebDy
OvtZZQR6byL9Air6pd/41LdOfXxY6fuRaMolgL+32Gk/PhmA53+fBNdB9PGE5itT
7+LoTUv8ZZhbwxQu5TjM0yhKK7Tt/KNyWHUrsFCJV/Q7/+qwh1LPM3rAWF2wSck=
=ZQWV
-----END PGP SIGNATURE-----

--kbCYTQG2MZjuOjyn--
