Received: from eggs.gnu.org ([2001:4830:134:3::10]:54165)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1cg8JB-0007zN-U3
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 06:08:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1cg8J7-0000N7-Ta
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 06:08:37 -0500
Date: Tue, 21 Feb 2017 11:08:30 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170221110830.GB22731@stefanha-x1.localdomain>
References: <1487347224-8667-1-git-send-email-pl@kamp.de>
	<20170220145011.GJ21255@stefanha-x1.localdomain>
	<73412b92-353d-7109-cfbe-9c61bf91e7eb@kamp.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="E39vaYmALEf/7YXx"
Content-Disposition: inline
In-Reply-To: <73412b92-353d-7109-cfbe-9c61bf91e7eb@kamp.de>
Subject: Re: [Qemu-devel] [Qemu-block] [RFC PATCH V4] qemu-img: make convert
 async
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Lieven <pl@kamp.de>
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, famz@redhat.com, qemu-block@nongnu.org, mreitz@redhat.com


--E39vaYmALEf/7YXx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 20, 2017 at 03:59:42PM +0100, Peter Lieven wrote:
> Am 20.02.2017 um 15:50 schrieb Stefan Hajnoczi:
> > On Fri, Feb 17, 2017 at 05:00:24PM +0100, Peter Lieven wrote:
> > > +        if (s->wr_in_order) {
> > > +            /* reenter the coroutine that might have waited
> > > +             * for this write to complete */
> > > +            s->wr_offs =3D sector_num + n;
> > > +            for (i =3D 0; i < s->num_coroutines; i++) {
> > > +                if (s->co[i] && s->wait_sector_num[i] =3D=3D s->wr_o=
ffs) {
> > > +                    qemu_coroutine_enter(s->co[i]);
> > > +                    break;
> > This qemu_coroutine_enter() call relies on the yield pattern between
> > sibling coroutines having no recursive qemu_coroutine_enter() calls.
> > QEMU aborts if there is a code path where coroutine A enters B and then
> > B enters A again before yielding.
> >=20
> > Paolo's new aio_co_wake() API solves this issue by deferring the
> > qemu_coroutine_enter() to the event loop.  It's similar to CoQueue
> > wakeup.  aio_co_wake() is part of my latest block pull request (should
> > be merged into qemu.git soon).
> >=20
> > I *think* this patch has no A -> B -> A situation thanks to yields in
> > the code path, but it would be nicer to use aio_co_wake() where this can
> > never happen.
>=20
> I also believe this can't happen. Would it be also okay to use
> qemu_coroutine_enter_if_inactive() here?

Perhaps this comment is enough:

  /*
   * A -> B -> A cannot occur because A has s->wait_sector_num[i] =3D=3D -1
   * during A -> B.  Therefore B will never enter A during this time
   * window.
   */
  qemu_coroutine_enter(s->co[i]);

Normally a comment isn't necessary because qemu_coroutine_enter() is
used for parent-child relationships.  But here it's a sibling
relationship so we need proof that A -> B -> A doesn't occur.

--E39vaYmALEf/7YXx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJYrB+uAAoJEJykq7OBq3PIpDcIAKke/i2AiZLXXm0PhYgvtIX9
7tf+kPukzRFkZR1dteheuHx6rUHRuo6k/sflCMRC1Aa9hurZh1/Rtfejc4e1kkCs
M+QiKIm2EqBQmAUtkpcBO4JxiY7nH1N04kDlvzcDLK5MkBb3U5PfpfBCfSHRjFOr
2eOgR2HVf6gKoIsB0NDT+lyV+pm2J6xpCqBespd+Y0rHHkqQrlEK/OHLiwTELP2C
UYcD4pvNj9k9fIsVVOLg1mVZvIcWMN3em+dzKH+8QCmWWjZzTcDSr5pEmMaWY6+P
AvnpJdeTieUs6LEtCt2y4XUvYZlh72fUZgkGwbPzhsCYs/0Q4qD6xLeXsvM5btM=
=AU4S
-----END PGP SIGNATURE-----

--E39vaYmALEf/7YXx--
