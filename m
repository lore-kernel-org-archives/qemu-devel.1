Received: from eggs.gnu.org ([2001:4830:134:3::10]:48718)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cu0bt-0002dx-0T
	for qemu-devel@nongnu.org; Fri, 31 Mar 2017 13:45:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cu0br-0008As-SW
	for qemu-devel@nongnu.org; Fri, 31 Mar 2017 13:45:17 -0400
References: <20170331152730.12514-1-eblake@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <8fc29f2c-9741-0f8d-da95-cbf663ef5573@redhat.com>
Date: Fri, 31 Mar 2017 19:45:05 +0200
MIME-Version: 1.0
In-Reply-To: <20170331152730.12514-1-eblake@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="x3VQj3bXA7RHNgHG3JchIwHWlObCPhlBf"
Subject: Re: [Qemu-devel] [PATCH for-2.9] rbd: Fix regression in legacy
 key/values containing escaped :
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, jcody@redhat.com, armbru@redhat.com, Alexandru.Avadanii@enea.com, Josh Durgin <jdurgin@redhat.com>, Kevin Wolf <kwolf@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--x3VQj3bXA7RHNgHG3JchIwHWlObCPhlBf
From: Max Reitz <mreitz@redhat.com>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, jcody@redhat.com, armbru@redhat.com,
 Alexandru.Avadanii@enea.com, Josh Durgin <jdurgin@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>
Message-ID: <8fc29f2c-9741-0f8d-da95-cbf663ef5573@redhat.com>
Subject: Re: [PATCH for-2.9] rbd: Fix regression in legacy key/values
 containing escaped :
References: <20170331152730.12514-1-eblake@redhat.com>
In-Reply-To: <20170331152730.12514-1-eblake@redhat.com>
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: quoted-printable

On 31.03.2017 17:27, Eric Blake wrote:
> Commit c7cacb3 accidentally broke legacy key-value parsing through
> pseudo-filename parsing of -drive file=3Drbd://..., for any key that
> contains an escaped ':'.  Such a key is surprisingly common, thanks
> to mon_host specifying a 'host:port' string.  The break happens
> because passing things from QDict through QemuOpts back to another
> QDict requires that we pack our parsed key/value pairs into a string,
> and then reparse that string, but the intermediate string that we
> created ("key1=3Dvalue1:key2=3Dvalue2") lost the \: escaping that was
> present in the original, so that we could no longer see which : were
> used as separators vs. those used as part of the original input.
>=20
> Fix it by collecting the key/value pairs through a QList, and
> sending that list on a round trip through a JSON QString (as in
> '["key1","value1","key2","value2"]') on its way through QemuOpts,
> rather than hand-rolling our own string.  Since the string is only
> handled internally, this was faster than creating a full-blown
> struct of '[{"key1":"value1"},{"key2":"value2"}]', and safer at
> guaranteeing order compared to '{"key1":"value1","key2":"value2"}'.
>=20
> It would be nicer if we didn't have to round-trip through QemuOpts
> in the first place, but that's a much bigger task for later.
>=20
> Reproducer:
> ./x86_64-softmmu/qemu-system-x86_64 -nodefaults -nographic -qmp stdio \=

> -drive 'file=3Drbd:volumes/volume-ea141b5c-cdb3-4765-910d-e7008b209a70'=
\
> ':id=3Dcompute:key=3DAQAVkvxXAAAAABAA9ZxWFYdRmV+DSwKr7BKKXg=3D=3D'\
> ':auth_supported=3Dcephx\;none:mon_host=3D192.168.1.2\:6789'\
> ',format=3Draw,if=3Dnone,id=3Ddrive-virtio-disk0,'\
> 'serial=3Dea141b5c-cdb3-4765-910d-e7008b209a70,cache=3Dwriteback'
>=20
> Even without an RBD setup, this serves a test of whether we get
> the incorrect parser error of:
> qemu-system-x86_64: -drive file=3Drbd:...cache=3Dwriteback: conf option=
 6789 has no value
> or the correct behavior of hanging while trying to connect to
> the requested mon_host of 192.168.1.2:6789.
>=20
> Reported-by: Alexandru Avadanii <Alexandru.Avadanii@enea.com>
> Signed-off-by: Eric Blake <eblake@redhat.com>
> ---
>  block/rbd.c | 83 +++++++++++++++++++++++++++++++----------------------=
--------
>  1 file changed, 42 insertions(+), 41 deletions(-)

Reviewed-by: Max Reitz <mreitz@redhat.com>


--x3VQj3bXA7RHNgHG3JchIwHWlObCPhlBf
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAljelaESHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9AGbsH/0mCQQ9h+fEZJ5EMxOfz3wD2HtgGE03D
8lvLVjYeimGno+W4Eo1SLGwU2710fWy3Q/iGYg6kjGDo0jKrfqI7RiBOF6R12aDX
h/RCvrahS/wx2f6ECVlJLf7LbV7EnAt1XrypoZcx7K+sU8KWjWL0RTmTyjqnz7eq
DrIw4O8gNJK+ErrvrRc2rr+UoCJrxVaKAMIJmyRM7qo7G5v/ds8nLRkHMgAWFgwx
n7KRNfDkfqYr81cNaZSK4+zCU22D7OaBLEzeCv/eyASXuzmVUIyW6ia6S9LoWFiC
c1VNzCUbFFffGo6fk+51kZD+I/J/eyFKCFPN/QvaRVfwsk5yBg47lSA=
=6aoY
-----END PGP SIGNATURE-----

--x3VQj3bXA7RHNgHG3JchIwHWlObCPhlBf--
