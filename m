Received: from eggs.gnu.org ([2001:4830:134:3::10]:45018)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fQVah-0000Ci-N6
	for qemu-devel@nongnu.org; Wed, 06 Jun 2018 06:22:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fQVac-0002G4-02
	for qemu-devel@nongnu.org; Wed, 06 Jun 2018 06:22:55 -0400
References: <20180604141437.22758-1-mreitz@redhat.com>
	<20180604141437.22758-2-mreitz@redhat.com>
	<20180604200611.GA14298@localhost.localdomain>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <8bd0d5ab-b560-f96f-d81d-30a62f914cef@redhat.com>
Date: Wed, 6 Jun 2018 12:22:40 +0200
MIME-Version: 1.0
In-Reply-To: <20180604200611.GA14298@localhost.localdomain>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="zg2SmfvmCowSF6U3qT1dR3e2bm1mQUQWp"
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH 1/2] qcow2: Do not mark
 inactive images corrupt
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jeff Cody <jcody@redhat.com>
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, qemu-stable@nongnu.org, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--zg2SmfvmCowSF6U3qT1dR3e2bm1mQUQWp
From: Max Reitz <mreitz@redhat.com>
To: Jeff Cody <jcody@redhat.com>
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 qemu-stable@nongnu.org, qemu-devel@nongnu.org
Message-ID: <8bd0d5ab-b560-f96f-d81d-30a62f914cef@redhat.com>
Subject: Re: [Qemu-block] [PATCH 1/2] qcow2: Do not mark inactive images
 corrupt
References: <20180604141437.22758-1-mreitz@redhat.com>
 <20180604141437.22758-2-mreitz@redhat.com>
 <20180604200611.GA14298@localhost.localdomain>
In-Reply-To: <20180604200611.GA14298@localhost.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2018-06-04 22:06, Jeff Cody wrote:
> On Mon, Jun 04, 2018 at 04:14:36PM +0200, Max Reitz wrote:
>> When signaling a corruption on a read-only image, qcow2 already makes
>> fatal events non-fatal (i.e., they will not result in the image being
>> closed, and the image header's corrupt flag will not be set).  This is=

>> necessary because we cannot set the corrupt flag on read-only images,
>> and it is possible because further corruption of read-only images is
>> impossible.
>>
>> Inactive images are effectively read-only, too, so we should do the sa=
me
>> for them.
>>
>> (Otherwise, the assert(!(bs->open_flags & BDRV_O_INACTIVE)) in
>> bdrv_co_pwritev() will fail, crashing qemu.)
>>
>> Cc: qemu-stable@nongnu.org
>> Signed-off-by: Max Reitz <mreitz@redhat.com>
>> ---
>>  block/qcow2.c | 4 +++-
>>  1 file changed, 3 insertions(+), 1 deletion(-)
>>
>> diff --git a/block/qcow2.c b/block/qcow2.c
>> index 59a38b9cd3..8b5f7386f7 100644
>> --- a/block/qcow2.c
>> +++ b/block/qcow2.c
>> @@ -4402,7 +4402,9 @@ void qcow2_signal_corruption(BlockDriverState *b=
s, bool fatal, int64_t offset,
>>      char *message;
>>      va_list ap;
>> =20
>> -    fatal =3D fatal && !bs->read_only;
>> +    if ((bs->open_flags & (BDRV_O_RDWR | BDRV_O_INACTIVE)) !=3D BDRV_=
O_RDWR) {
>=20
> Hmm, this is pretty much exactly what the bdrv_is_writable() helper fun=
ction
> does in block.c; too bad it's scope is limited to block.c.  Maybe worth=
 it
> to make it a more widely available helper and use it here?

You know what, I copied it from there but for some reason never thought
of making it global.

Will do.

Max

>> +        fatal =3D false;
>> +    }
>> =20
>>      if (s->signaled_corruption &&
>>          (!fatal || (s->incompatible_features & QCOW2_INCOMPAT_CORRUPT=
)))
>> --=20
>> 2.17.0
>>
>>



--zg2SmfvmCowSF6U3qT1dR3e2bm1mQUQWp
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlsXtfAACgkQ9AfbAGHV
z0AoCwgAhZkWfgn0+o54y5O0UVjrMP3whYpkTCFqW8eqKkLBaBgzK5eE+EHs36js
NUamyh6efEsCw4OPtstykhHnKxIE/g6GMS4FEbvauLeL3+XjbbYRIrbWjJPB/PeV
AlzijJ8bj0mYAc6/Lvs6XOGiT0Kn6pZAsn9Fh9+D8BGhzBZgmPXX5kAKXvxkHxRq
PopBsfTWX/VRnoxxfGhsp1FNEKrD6TbearCHJxyXOUiT6tzbTL+z3EdbNo1Mr3Gy
f4BC06do0/Ao/tK9XsloIHr+Q9VlHnEb6eAM6pS1+21aptEJYyRKz5TSL2sTrHix
RoLics9dSRH5Sh2xWaFToMM6Zbi60Q==
=QvG1
-----END PGP SIGNATURE-----

--zg2SmfvmCowSF6U3qT1dR3e2bm1mQUQWp--
