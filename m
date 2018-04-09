Received: from eggs.gnu.org ([2001:4830:134:3::10]:59347)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1f5RAY-0003sX-IL
	for qemu-devel@nongnu.org; Mon, 09 Apr 2018 03:24:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1f5RAV-0000HC-9h
	for qemu-devel@nongnu.org; Mon, 09 Apr 2018 03:24:50 -0400
Date: Mon, 9 Apr 2018 15:24:42 +0800
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20180409072442.GA26563@stefanha-x1.localdomain>
References: <20180404150146.23281-1-stefanha@redhat.com>
	<5c93e912-9d6a-214c-e4fb-8a4e6fc6e7f9@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="HcAYCG3uE/tztfnV"
Content-Disposition: inline
In-Reply-To: <5c93e912-9d6a-214c-e4fb-8a4e6fc6e7f9@redhat.com>
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH for-2.12 v2] qemu-iotests:
 update 185 output
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org


--HcAYCG3uE/tztfnV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 04, 2018 at 06:16:12PM +0200, Max Reitz wrote:
> On 2018-04-04 17:01, Stefan Hajnoczi wrote:
> > Commit 4486e89c219c0d1b9bd8dfa0b1dd5b0d51ff2268 ("vl: introduce
> > vm_shutdown()") added a bdrv_drain_all() call.  As a side-effect of the
> > drain operation the block job iterates one more time than before.  The
> > 185 output no longer matches and the test is failing now.
> >=20
> > It may be possible to avoid the superfluous block job iteration, but
> > that type of patch is not suitable late in the QEMU 2.12 release cycle.
> >=20
> > This patch simply updates the 185 output file.  The new behavior is
> > correct, just not optimal, so make the test pass again.
> >=20
> > Fixes: 4486e89c219c0d1b9bd8dfa0b1dd5b0d51ff2268 ("vl: introduce vm_shut=
down()")
> > Cc: Kevin Wolf <kwolf@redhat.com>
> > Cc: QingFeng Hao <haoqf@linux.vnet.ibm.com>
> > Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> > ---
> >  tests/qemu-iotests/185     | 10 ++++++----
> >  tests/qemu-iotests/185.out | 12 +++++++-----
> >  2 files changed, 13 insertions(+), 9 deletions(-)
>=20
> On tmpfs, this isn't enough to let the test pass.  There, the active
> commit job finishes before the quit is sent, resulting in this diff:
>=20
> --- tests/qemu-iotests/185.out      2018-04-04 18:10:02.015935435 +0200
> +++ tests/qemu-iotests/185.out.bad  2018-04-04 18:10:21.045473817 +0200
> @@ -26,9 +26,9 @@
>=20
>  {"return": {}}
>  {"return": {}}
> +{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP},
> "event": "BLOCK_JOB_READY", "data": {"device": "disk", "len": 4194304,
> "offset": 4194304, "speed": 65536, "type": "commit"}}
>  {"return": {}}
>  {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP},
> "event": "SHUTDOWN", "data": {"guest": false}}
> -{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP},
> "event": "BLOCK_JOB_READY", "data": {"device": "disk", "len": 4194304,
> "offset": 4194304, "speed": 65536, "type": "commit"}}
>  {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP},
> "event": "BLOCK_JOB_COMPLETED", "data": {"device": "disk", "len":
> 4194304, "offset": 4194304, "speed": 65536, "type": "commit"}}
>=20
>  =3D=3D=3D Start mirror job and exit qemu =3D=3D=3D
>=20
> This seems to be independent of whether there is actually data on
> TEST_IMG (the commit source), so something doesn't seem quite right with
> the block job throttling here...?

That is a race condition.  I can reproduce it on XFS too.

Will see if I can figure it out...

Stefan

--HcAYCG3uE/tztfnV
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJayxU6AAoJEJykq7OBq3PIakEIAI2FEpFXH0txjdM9cLC0XluI
Aek3YjNTykmjqHJ0a112qhsh/0O6tzkgeT6hhqt8PSaygYCWJ6UPKbQRTyW1x7Ub
Twvqb7J05AKX5YEJVhH94/2waRFoYlUdw3kxgBEYgvrMehlxXoBBkbSnME6Qur7W
z1Gsqsw5WJO2OqyqSIDU9tgxBpfK8tmt5M9miyU0iP4w6hApd4edZdD70lNjVwJr
g6MU0o7aqKtTe69J06mL9xSiiNsXWggBKwZKmpxp1Qdrf8SWtYCtncufragcFqx3
3bf5d48shVwr1wgIx84lMUqcHcaRUvga7CMi3M9dQ4fQojQT6FZSGVo9Eu8rwq0=
=wW4y
-----END PGP SIGNATURE-----

--HcAYCG3uE/tztfnV--
