Received: from eggs.gnu.org ([2001:4830:134:3::10]:48640)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cYtYk-0006kD-Tf
	for qemu-devel@nongnu.org; Wed, 01 Feb 2017 06:58:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cYtYk-0000Da-6V
	for qemu-devel@nongnu.org; Wed, 01 Feb 2017 06:58:46 -0500
References: <20170130161441.30493-1-berto@igalia.com>
	<574dd15d-ace7-cbaf-574a-944c2c436b95@redhat.com>
	<w51inoury83.fsf@maestria.local.igalia.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <0e44af0e-6319-62f0-1e17-87f91ee1b66e@redhat.com>
Date: Wed, 1 Feb 2017 12:58:36 +0100
MIME-Version: 1.0
In-Reply-To: <w51inoury83.fsf@maestria.local.igalia.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="MMO5I8rPP8hlJi1CpCH4LPCMjWXnXloUn"
Subject: Re: [Qemu-devel] [PATCH] qcow2: Optimize the refcount-block overlap
 check
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
--MMO5I8rPP8hlJi1CpCH4LPCMjWXnXloUn
From: Max Reitz <mreitz@redhat.com>
To: Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>
Message-ID: <0e44af0e-6319-62f0-1e17-87f91ee1b66e@redhat.com>
Subject: Re: [PATCH] qcow2: Optimize the refcount-block overlap check
References: <20170130161441.30493-1-berto@igalia.com>
 <574dd15d-ace7-cbaf-574a-944c2c436b95@redhat.com>
 <w51inoury83.fsf@maestria.local.igalia.com>
In-Reply-To: <w51inoury83.fsf@maestria.local.igalia.com>
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: quoted-printable

On 01.02.2017 11:39, Alberto Garcia wrote:
> On Wed 01 Feb 2017 02:46:20 AM CET, Max Reitz <mreitz@redhat.com> wrote=
:
>=20
>>> The problem with the refcount table is that since it always occupies
>>> complete clusters its size is usually very big.
>>
>> Actually the main problem is that BDRVQcow2State.refcount_table_size
>> is updated very generously as opposed to BDRVQcow2State.l1_size. The
>> latter is usually exactly as large as it needs to be (because the L1
>> table size usually doesn't change), whereas the refcount_table_size is=

>> just bumped up every time the image gets bigger until it reaches or
>> exceeds the value it needs to be.
>=20
> That's actually a good point.
>=20
> One reason why this happens is that the size of the L1 table is static
> and the qcow2 header stores the actual number of entries, whereas for
> the refcount table it stores the number of clusters.

The other reason is what I said: The image size changes, so the refcount
table size needs to be bumped up from time to time. The L1 table size is
pretty much static, so it makes sense to keep it exactly as large as it
needs to be to represent all of the virtual disk.

> Maybe we can have refcount_table_size store the actual size of the
> table. The number of clusters can be calculated from that after all, an=
d
> we would get rid of max_refcount_table_index.

refcount_table_size as in the one in BDRVQcow2State? That is the number
of entries already. I don't think making it "exact" is worth it, because
see above (you need to bump it up any time an allocation is made, and
you don't want to reallocate the refcount table all the time).

Also, you lose all of the accuracy once the image is closed and reopened
because the field in the qcow2 header only stores number of clusters.
Changing that would not be backwards compatible. You could add a new
field which stores the number of entries, but I don't see the point, as
it is very easy to just recalculate it once the image is opened (which
doesn't take *that* much time if you do it just once).

> The change might be a bit more difficult, though, I'll take a look.

Well, I won't hold you back, but I don't think it's worth it.

Max

>>> @@ -439,6 +450,7 @@ static int alloc_refcount_block(BlockDriverState =
*bs,
>>>          }
>>> =20
>>>          s->refcount_table[refcount_table_index] =3D new_block;
>>> +        s->max_refcount_table_index =3D refcount_table_index;
>>
>> Should be MAX(s->max_refcount_table_index, refcount_table_index) or
>> this won't support refcount tables with holes in them.
>=20
> Good catch.
>=20
> Berto
>=20



--MMO5I8rPP8hlJi1CpCH4LPCMjWXnXloUn
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAliRzWwSHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9AR8kH/AnaYuhwMN5lWNT/r968cSEQAPU9yHM1
AB6RnwX0sr8e/qGeFmIPPnR82qs1nZeqVEhmdkE+cOoobz5h6glfyoJ063QpSyhb
2sGycHjIOi6F6sYb8psbkOhtD9JNI7OXZEOz/3dzP761Q+B4zm8jZPkyjuagHth0
GCKS2+khXaVf+sdtIWoKLAo61iCZih0+ktGcZGGszaGP1m9CFrR9UvepGvbXflXG
5fbSI7E/1zp+TTQStzCz+FroxJnosTFI3JZ/nctdm5WQzVSaowa7pooUTl7yS9hO
Ju/uQJB6b+q6TQj9ZXWUoXOX6QL047PNA3H/SfWXht4QJzhBRlhmTOs=
=MOtb
-----END PGP SIGNATURE-----

--MMO5I8rPP8hlJi1CpCH4LPCMjWXnXloUn--
