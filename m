Received: from eggs.gnu.org ([2001:4830:134:3::10]:48442)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dqK5X-0004ya-6K
	for qemu-devel@nongnu.org; Fri, 08 Sep 2017 10:16:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dqK5T-00026E-5i
	for qemu-devel@nongnu.org; Fri, 08 Sep 2017 10:16:55 -0400
Date: Fri, 8 Sep 2017 16:16:29 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20170908141629.GK3283@localhost.localdomain>
References: <20170830210542.2153-1-eblake@redhat.com>
	<20170830210542.2153-17-eblake@redhat.com>
	<20170908132741.GJ3283@localhost.localdomain>
	<3e1edd8f-dcfa-561e-a5e1-99ef89b1ec81@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="mP3DRpeJDSE+ciuQ"
Content-Disposition: inline
In-Reply-To: <3e1edd8f-dcfa-561e-a5e1-99ef89b1ec81@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v6 16/18] qcow2: Switch store_bitmap_data()
 to byte-based iteration
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, jsnow@redhat.com, vsementsov@virtuozzo.com, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>


--mP3DRpeJDSE+ciuQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Am 08.09.2017 um 16:09 hat Eric Blake geschrieben:
> On 09/08/2017 08:27 AM, Kevin Wolf wrote:
> > Am 30.08.2017 um 23:05 hat Eric Blake geschrieben:
> >> Now that we have adjusted the majority of the calls this function
> >> makes to be byte-based, it is easier to read the code if it makes
> >> passes over the image using bytes rather than sectors.
> >>
> >> Signed-off-by: Eric Blake <eblake@redhat.com>
> >> Reviewed-by: John Snow <jsnow@redhat.com>
> >> Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> >>
>=20
> >>
> >> -    while ((sector =3D bdrv_dirty_iter_next(dbi) >> BDRV_SECTOR_BITS)=
 !=3D -1) {
> >> -        uint64_t cluster =3D sector / sbc;
> >> +    while ((offset =3D bdrv_dirty_iter_next(dbi)) !=3D -1) {
> >=20
> > Don't you have to multiply both sides of the equation? This would be
> > offset !=3D -512, which points out that the previous patch to convert
> > bdrv_dirty_iter_next() to byte-based gave it a really awkward interface.
>=20
> I think what I really need to do is change '!=3D -1' to '< 0', as that's
> much easier to reason about when scaling is present.

Hm, I think I would prefer a special case for -1 in bdrv_dirty_iter_next()
so that it returns -1 after the last entry. Even if you check for < 0,
-512 is still an odd return value to signal the end.

Though I think after the final patch, we're back to -1 anyway, so it's
not that important.

Kevin

--mP3DRpeJDSE+ciuQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBAgAGBQJZsqY9AAoJEH8JsnLIjy/WbsgQAMmEM/+ATSXQ1P3rtfoLGsLX
tE8fmh+Jjg73fwLEB4NwQJ9qh/c7NUeS41zIRwOysgBwsrHOPjb7d3o7wAfykr1t
cLet6tSVZi2qlFsY/pYdltAd/xdIXlHbinLVgcT5oKpix/8kcqCEssJlQAHFxClj
37m9BVVW7HSJ/YnXe5z9Htla4vazPAttUkA+W23hva36plrASWLT7/J59VQNCL/i
Q4tbmQfVAKfKt+T3DlihlSdE+/KMivd5jtsJimGyvOqAYrl4+8c83TTkrfliCP02
v+UOpgegK9SzJ2SWEf5H2HQyEXBJlLtTVcJYuUhtMtSbaw2weotdR4Yc8M4CR0rQ
tpNe0S2eY0EsUyH34/7KnspFIJpHvwL7hMackvB5Vr4Lip4+pWc05WgcB9A/VuHq
mh0dPLS7f2iVKoxO1Z+hEYinafQpXo/aivrWMloFAOMF0vCf4yrd97T7kj+kz92+
gKS6u5x8Em6tPyF1w/KadUrhcxG89knYIN+J936c2+IXABq/naB5hA777xFMhxJG
fzsMh0nqUPOXrXdQ9m83E5F0w7xyik0PBS8CPsxWZRqCQot1yKmIj9H3id58zYdU
60w76gVpT/l9gSGoaidfbUTPJRkiI972+iwcuAUOVuexe7kaYXf9PllWuuFYwuVT
1q3cmoIBk0Y7IPqFSEWp
=U6r0
-----END PGP SIGNATURE-----

--mP3DRpeJDSE+ciuQ--
