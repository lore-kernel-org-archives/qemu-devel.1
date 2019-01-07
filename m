Received: from eggs.gnu.org ([209.51.188.92]:60553)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1ggUVs-0001vj-V0
	for qemu-devel@nongnu.org; Mon, 07 Jan 2019 08:00:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1ggUVm-0004Nk-LB
	for qemu-devel@nongnu.org; Mon, 07 Jan 2019 08:00:16 -0500
References: <320758d6-012b-0b17-2467-f73bf8f4dcb2@virtuozzo.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <9e947c78-97b4-8eca-1e10-637489a39fe7@redhat.com>
Date: Mon, 7 Jan 2019 13:52:43 +0100
MIME-Version: 1.0
In-Reply-To: <320758d6-012b-0b17-2467-f73bf8f4dcb2@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="E61AMtq8iXQlihCtGSUrsOXd4T2cg19zL"
Subject: Re: [Qemu-devel] do not lseek in qcow2 block_status
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-devel <qemu-devel@nongnu.org>, qemu block <qemu-block@nongnu.org>
Cc: Kevin Wolf <kwolf@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <fam@euphon.net>, Stefan Hajnoczi <stefanha@redhat.com>, Eric Blake <eblake@redhat.com>, Denis Lunev <den@virtuozzo.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--E61AMtq8iXQlihCtGSUrsOXd4T2cg19zL
From: Max Reitz <mreitz@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-devel <qemu-devel@nongnu.org>, qemu block <qemu-block@nongnu.org>
Cc: Kevin Wolf <kwolf@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Fam Zheng <fam@euphon.net>, Stefan Hajnoczi <stefanha@redhat.com>,
 Eric Blake <eblake@redhat.com>, Denis Lunev <den@virtuozzo.com>
Message-ID: <9e947c78-97b4-8eca-1e10-637489a39fe7@redhat.com>
Subject: Re: do not lseek in qcow2 block_status
References: <320758d6-012b-0b17-2467-f73bf8f4dcb2@virtuozzo.com>
In-Reply-To: <320758d6-012b-0b17-2467-f73bf8f4dcb2@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 24.12.18 16:50, Vladimir Sementsov-Ogievskiy wrote:
> Hi all!
>=20
> bdrv_co_block_status digs bs->file for additional, more accurate search=
 for hole
> inside region, reported as DATA by bs since long-ago
>=20
>    commit 5daa74a6ebce7543aaad178c4061dc087bb4c705
>    Author: Paolo Bonzini <pbonzini@redhat.com>
>    Date:   Wed Sep 4 19:00:38 2013 +0200
>=20
>        block: look for zero blocks in bs->file
>=20
> This accuracy is not free: assume we have qcow2 disk. Actually, qcow2 k=
nows,
> where are holes and where is data. But every block_status request calls=
 lseek
> additionally. Recently (and not the first time) we have faced the situa=
tion,
> when lseek works slow. Of course, it is more about kernel implementatio=
n of it,
> but why to involve lseek at all, if we have the information on qcow2 le=
vel?
> Assume a big disk, full of data, in any iterative copying block job (or=
 img
> convert) we'll call lseek(HOLE) on every iteration, and each of these l=
seeks
> will have to iterate through all metadata up to the end of file. It's o=
bviously
> ineffective behavior.
>=20
> I'm thinking about, how to properly workaround this thing, and I have s=
ome
> questions.
>=20
> What are the cases, when we really need digging for zeros in bs->file?
>=20
> Why in mirror we care about discard vs write_zeros, keeping in mind, th=
at
> block_status will return ZERO instead for unallocated regions in some c=
ases, not
> related to guest view of disk (bdrv_unallocated_blocks_are_zero, backin=
g file is
> smaller than request.start)?
>=20
> And finally, what to do with the problem?
>=20
> Obviously, the simplest thing is just revert 5daa74a. What will it brea=
k?
>=20
> Otherwise, I need to "revert" it in some cases, and, may be, it should =
be a
> user-defined parameter.. Should it?  And what are the cases? We need to=
 "free"
> of 5daa74a at least qcow2.. But again, should it be format-specific opt=
ion, or
> something more generic?
>=20
> Then, if it would be separate parameter, how should it interfere with
> want_zeros, or even, should it be want_zeros, reworked a bit to be want=
_lseek?

As far as I have understood, the @want_zero parameter basically is
exactly this.  If you want the call to be quick, you set it to false.
If you want the result to be accurate, you set it to true.

Well, for raw images it'll still go down to bs->file even with
want_zero=3Dfalse, but I don't think there's much else we can do, really.=


Max


--E61AMtq8iXQlihCtGSUrsOXd4T2cg19zL
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlwzS5sACgkQ9AfbAGHV
z0D3cwf6As+XjtSCzmg/QSVgXEe0QDWz9NAyNQHgTKj/tHMzdhXFvyCCD28IV3t6
v0/RhDNVAZCEHYq92RmkhuReTMVCGWgpr91nbIEB3ZaAsbolln/eD0R0BaNAeJ52
b45NjdRO0d5pp1IllmoAHsUuNqGdaNV1FLl1ndy8SxjKBTuoo7M1KKOPNkLxw2rE
1TJ8/8zuGHP1+tp7c6Aa1kUq2ia/0nIofpovN1O+7dkeX+essWJ4/jVueoNSwBw4
LsNpitgxp48l3bgLncH2/NgjMwp0D1kc2UNJSbaEL15aTVyrbutgFjEqAEP0HyKf
Q3t41KfIyrJXwyw370Zvt1Qq4gXJjw==
=JeqT
-----END PGP SIGNATURE-----

--E61AMtq8iXQlihCtGSUrsOXd4T2cg19zL--
