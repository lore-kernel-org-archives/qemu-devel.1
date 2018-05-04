Received: from eggs.gnu.org ([2001:4830:134:3::10]:58345)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fEdIt-0004Gl-0F
	for qemu-devel@nongnu.org; Fri, 04 May 2018 12:11:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fEdIr-0000ey-W7
	for qemu-devel@nongnu.org; Fri, 04 May 2018 12:11:26 -0400
From: Max Reitz <mreitz@redhat.com>
References: <20180502213219.7842-1-mreitz@redhat.com>
	<871setrw5v.fsf@dusky.pond.sub.org>
	<2efd29b6-de41-2896-7a9f-021e12214f0e@redhat.com>
Message-ID: <b83088e2-13d0-eada-59c0-6fc48fe18c87@redhat.com>
Date: Fri, 4 May 2018 18:11:13 +0200
MIME-Version: 1.0
In-Reply-To: <2efd29b6-de41-2896-7a9f-021e12214f0e@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="9OxVTrzzA8LfaURFfTSNLIrClTyl7y5s3"
Subject: Re: [Qemu-devel] [RFC 0/7] block: Try to use correctly typed
 blockdev options
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org, Eric Blake <eblake@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--9OxVTrzzA8LfaURFfTSNLIrClTyl7y5s3
From: Max Reitz <mreitz@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 qemu-devel@nongnu.org, Eric Blake <eblake@redhat.com>
Message-ID: <b83088e2-13d0-eada-59c0-6fc48fe18c87@redhat.com>
Subject: Re: [Qemu-devel] [RFC 0/7] block: Try to use correctly typed blockdev
 options
References: <20180502213219.7842-1-mreitz@redhat.com>
 <871setrw5v.fsf@dusky.pond.sub.org>
 <2efd29b6-de41-2896-7a9f-021e12214f0e@redhat.com>
In-Reply-To: <2efd29b6-de41-2896-7a9f-021e12214f0e@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2018-05-04 17:53, Max Reitz wrote:

[...]

> So if you use it the "proper" way:
>=20
> $ x86_64-softmmu/qemu-system-x86_64 -nodefaults \
>     -drive if=3Dnone,driver=3Draw,file=3Dblkdebug::null-co://,file.alig=
n=3D512 \
>     -monitor stdio
> QEMU 2.12.50 monitor - type 'help' for more information
> (qemu) info block
> none0 (#block238): json:{"driver": "raw", "file": {"image": {"driver":
> "null-co"}, "driver": "blkdebug", "align": "512"}} (raw)
>=20
> Well... Looks like the same issue, but it's different, actually.
> blkdebug_parse_filename() only adds "x-image" after the conversion to
> BlockdevOptions and back, so that can't be the thing that breaks the
> conversion here.  No, the thing here is the "filename" option which is
> not something that blkdebug supports according to the QAPI schema...

[...]

> Option 3: Keep doing what this series did.  Find out why "filename" is
> an option in the QDict in the first place, because I would have assumed=

> that you need to specify it as the @filename parameter of bdrv_open()
> instead of through the QDict.

Solved the mystery.  The issue isn't "filename" in the QDict (it
actually isn't there), but the fact that -drive allows you to leave out
so many essential options.  In the above command line, for instance, I
left out file.driver and file.image.driver.  Both are derived by
bdrv_open(), but are not set at the point where I'm trying to do the typi=
ng.

(And this gets better with something like -drive file=3Dfoo.img where eve=
n
file.filename needs to be derived.  Or -drive file=3Dnbd://localhost,
where it's not even file.filename but file.server.*, which comes from
nbd_parse_filename()...)

Sooo...  Guess I'll go to option #1.

(And in the long run, I suppose we need to pull out the whole
"derivation infrastructure" which includes probing and
bdrv_parse_filename() and do the conversion to BlockdevOptions afterwards=
=2E)

Max


--9OxVTrzzA8LfaURFfTSNLIrClTyl7y5s3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlrshiEACgkQ9AfbAGHV
z0BPewgAszR3+nL+5qlbB+kXvZ3L0C7VasZFAYlYdy95yOt7wfSahaNnZbgrI0YN
j84ddLl5koZNoHCH8YgLhtG2ZP1N5+gz7OfH5pIXtdEhvoGCX1q+dsHGiAlr6TOO
zguPxW7RN1Idr0OooBMms58csCCFRIh1a84dRFww/sNRUl93+lkln2c4gtwbo2r1
9N/LKwltWbefIJeOx3gefttWwcLanFnhKC2yeMgmoN82kuyHZX0qmcqkswV/K6YU
FQ8UVJJuUIbwT6oequSHuayj72wpUxK3cHvbU6Pdp2qZKqkAR3Y4eaOlG3j/UXHL
6tdfbn3PB+wqGkVGCvq7j1i4vyev/w==
=bRvO
-----END PGP SIGNATURE-----

--9OxVTrzzA8LfaURFfTSNLIrClTyl7y5s3--
