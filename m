Received: from eggs.gnu.org ([209.51.188.92]:33723)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1hF6vb-0002Lv-JC
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 20:53:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1hF6va-00012L-HZ
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 20:53:55 -0400
References: <cover.1551895813.git.berto@igalia.com>
	<e25b416f8646a476017f21a8484a05931b0e3f5a.1551895814.git.berto@igalia.com>
	<1df28c23-7efe-310d-2955-432b9a4bb1ad@redhat.com>
	<w515zrkveul.fsf@maestria.local.igalia.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <5f16da0c-d689-b06c-883b-3911a2c9ff9d@redhat.com>
Date: Sat, 13 Apr 2019 02:53:42 +0200
MIME-Version: 1.0
In-Reply-To: <w515zrkveul.fsf@maestria.local.igalia.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="9TDZkTturvFkl5NtRPxjaqRoj6uO4dbL0"
Subject: Re: [Qemu-devel] [PATCH v2 13/13] qemu-iotests: Test the
 x-blockdev-reopen QMP command
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--9TDZkTturvFkl5NtRPxjaqRoj6uO4dbL0
From: Max Reitz <mreitz@redhat.com>
To: Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>
Message-ID: <5f16da0c-d689-b06c-883b-3911a2c9ff9d@redhat.com>
Subject: Re: [PATCH v2 13/13] qemu-iotests: Test the x-blockdev-reopen QMP
 command
References: <cover.1551895813.git.berto@igalia.com>
 <e25b416f8646a476017f21a8484a05931b0e3f5a.1551895814.git.berto@igalia.com>
 <1df28c23-7efe-310d-2955-432b9a4bb1ad@redhat.com>
 <w515zrkveul.fsf@maestria.local.igalia.com>
In-Reply-To: <w515zrkveul.fsf@maestria.local.igalia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 11.04.19 15:41, Alberto Garcia wrote:
> On Wed 10 Apr 2019 07:03:50 PM CEST, Max Reitz wrote:
>>> +        # hd0 has no backing file: we can omit the 'backing' option
>>> +        self.reopen(opts)
>>
>> [...]
>>
>>> +        # Detach hd2 from hd0.
>>> +        self.reopen(opts, {'backing': None})
>>> +        self.reopen(opts, {}, "backing is missing for 'hd0'")
>>
>> I don=E2=80=99t understand the second test.  hd0 has no default backin=
g file
>> and it currently has no backing child attached to it.  Why would this
>> call fail now?
>=20
> I think there's a bug.
>=20
> Calling x-blockdev-reopen without 'backing' should only fail if
>=20
>  a) the image has a backing file attached to it.
>     In this case it doesn't: we just detached it in the previous line.
>=20
>  b) there's a default backing file written on the image header.
>     In this case there isn't (hd0 is created without one in setUp()).

That=E2=80=99s what I thought, too, hence me applying effectively the sam=
e
change to the test in v4 of my series as you in your "Fix check for
default backing files" series:

http://lists.nongnu.org/archive/html/qemu-block/2019-04/msg00308.html

> So it should not fail. I think the bug is that the test for condition
> (b) in bdrv_reopen_prepare() that returns "backing is missing..." is
> using backing_file but it should use (correct me if I'm wrong)
> auto_backing_file.

Well, I think both should be fine, because...

> Changing that and replacing the test line with self.reopen(opts) fixes
> it for me.
>=20
> Not directly related to this, but should bdrv_backing_detach() also
> clear backing_file ?

=2E..I don=E2=80=99t think it should.  That=E2=80=99s what that my patch =
addresses.  The
real problem is that bs->backing_file is not a cache for
bs->backing->bs->filename, so it shouldn=E2=80=99t be treated as such.

Max


--9TDZkTturvFkl5NtRPxjaqRoj6uO4dbL0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlyxMxcACgkQ9AfbAGHV
z0DVeAgAxLa+9ldDqDCJHPLqkaUjbKACMit6d5J86ZjXq0fisJ3gIsZNbkgEWKA6
9MQS0JrmUGr7ySKD4zNr3J7wb+pOYHmdMdYEzaWKCcBpPXtFyfjXAeP7yKL+ysuE
skuHw2XPcv8Bs8Z5TLatJh1JPObXWGA6buXXlSOoQe2sa6Ey/n6nj391TyZjcXTv
vDRmHqvfNqMe+NjSB4rPdNGfsyLeCoQPQ0B60W5eL7Y5jOXuONKoq+iNymrhsDUY
rqy8iZCs4ZsJq0eM9zxE+pZboT2fO86xaAIV8LoHJTr6qP0uEkn3gUj081CMpyj4
LBKD+zlMGVabg7IW5ChxXs28oREG0g==
=21bd
-----END PGP SIGNATURE-----

--9TDZkTturvFkl5NtRPxjaqRoj6uO4dbL0--
