Received: from eggs.gnu.org ([209.51.188.92]:39435)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1gxBX1-00041r-Sw
	for qemu-devel@nongnu.org; Fri, 22 Feb 2019 09:10:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1gxBWt-00047N-KP
	for qemu-devel@nongnu.org; Fri, 22 Feb 2019 09:10:21 -0500
References: <20190131175549.11691-1-kwolf@redhat.com>
	<20190131175549.11691-7-kwolf@redhat.com>
	<e8d7022b-5946-381f-262c-47b1596cc2a6@redhat.com>
	<20190219084544.GB4727@localhost.localdomain>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <c5807792-f3b3-785a-692d-d81d211ca308@redhat.com>
Date: Fri, 22 Feb 2019 15:09:44 +0100
MIME-Version: 1.0
In-Reply-To: <20190219084544.GB4727@localhost.localdomain>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="VRHkVlcfhoPURzHFWlD7yivrhlqXUZmZW"
Subject: Re: [Qemu-devel] [RFC PATCH 06/11] qcow2: Don't assume 0 is an
 invalid cluster offset
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org, eblake@redhat.com, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--VRHkVlcfhoPURzHFWlD7yivrhlqXUZmZW
From: Max Reitz <mreitz@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org, eblake@redhat.com, qemu-devel@nongnu.org
Message-ID: <c5807792-f3b3-785a-692d-d81d211ca308@redhat.com>
Subject: Re: [RFC PATCH 06/11] qcow2: Don't assume 0 is an invalid cluster
 offset
References: <20190131175549.11691-1-kwolf@redhat.com>
 <20190131175549.11691-7-kwolf@redhat.com>
 <e8d7022b-5946-381f-262c-47b1596cc2a6@redhat.com>
 <20190219084544.GB4727@localhost.localdomain>
In-Reply-To: <20190219084544.GB4727@localhost.localdomain>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

On 19.02.19 09:45, Kevin Wolf wrote:
> Am 19.02.2019 um 00:13 hat Max Reitz geschrieben:
>> On 31.01.19 18:55, Kevin Wolf wrote:
>>> The cluster allocation code uses 0 as an invalid offset that is used =
in
>>> case of errors or as "offset not yet determined". With external data
>>> files, a host cluster offset of 0 becomes valid, though.
>>>
>>> Define a constant INV_OFFSET (which is not cluster aligned and will
>>> therefore never be a valid offset) that can be used for such purposes=
=2E
>>>
>>> This removes the additional host_offset =3D=3D 0 check that commit
>>> ff52aab2df5 introduced; the confusion between an invalid offset and
>>> (erroneous) allocation at offset 0 is removed with this change.
>>>
>>> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
>>> ---
>>>  block/qcow2.h         |  2 ++
>>>  block/qcow2-cluster.c | 59 ++++++++++++++++++++---------------------=
--
>>>  2 files changed, 29 insertions(+), 32 deletions(-)
>>
>> qcow2_get_cluster_offset() still returns 0 for unallocated clusters.
>> (And qcow2_co_block_status() tests for that, so it would never report =
a
>> valid offset for the first cluster in an externally allocated qcow2 fi=
le.)
>=20
> I think the bug here is in qcow2_get_cluster_offset().

You mean qcow2_co_block_status()?

>                                                        It shouldn't loo=
k
> at cluster_offset, but at ret if it wants to know the allocation status=
=2E
> So I think this needs to become something like:
>=20
>     if ((ret =3D=3D QCOW2_CLUSTER_NORMAL || ret =3D=3D QCOW2_CLUSTER_ZE=
RO_ALLOC) &&
>         !s->crypto) {
>         ...
>     }

I don't think that, because it doesn't want to know the allocation
status.  It wants to know whether it can return valid map information,
which it can if (1) qcow2_get_cluster_offset() returned a valid offset,
and (2) the data is represented in plain text (i.e. not compressed or
encrypted).

OTOH maybe having a whitelist instead of a blacklist would indeed be
more safe, in a sense.  But first, this isn't a pure whitelist, because
it still has to check "!s->crypto".  Second, it isn't like allocated
zero clusters store the data the same way it's seen in the guest.  So
even the whitelist part feels a bit weird to me.

All in all, the way it is right now makes more sense to me.

>> qcow2_alloc_compressed_cluster_offset() should return INV_OFFSET on
>> error (yeah, there are no compressed clusters in external files, but
>> this seems like the right thing to do still).
>=20
> Ok, makes sense.
>=20
>> (And there are cases like qcow2_co_preadv(), where cluster_offset is
>> initialized to 0 -- it doesn't make a difference what it's initialized=

>> to (it's just to silence the compiler, I suppose), but it should still=

>> use this new constant now.  I think.)
>=20
> I don't think I would change places where cluster_offset is never used
> at all or never used alone without checking the cluster type, too.

OK.

> qcow2_get_cluster_offset() still returns 0 for unallocated and
> non-preallocated zero clusters, and I think that's fine because it also=

> returns the cluster type, which is information about whether the offset=

> is even valid.
>=20
> In theory, it shouldn't matter at all if we return 0, INV_OFFSET or 42
> there, but in practice I'd bet neither money nor production images on
> this. If it ain't broke, don't fix it.
I don't see how an "organic growth" code base which sometimes uses 0 and
sometimes INV_OFFSET for invalid offsets is any more trustworthy, but
whatever.  I'm in a position where I don't have to learn the qcow2 code
from scratch but instead would have to review your changes, so I won't
complain further.

Max


--VRHkVlcfhoPURzHFWlD7yivrhlqXUZmZW
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlxwAqkACgkQ9AfbAGHV
z0Ad/Af+NRDNeQPK9YUV/feKGnRPAA246HHLMbL+KuY8nqhN4TZZ7WGITqBxXr7J
J5i/K3kVG/L5M6UTkz64Ux+0T7Me6PmQGUZ8W/2ZTFrzOAOppNhQ+W/bF1i12MBE
Qd76nHy5FUdxRCNUAE76WbhaQ8okhF/QajSIIkzx4dnZVeCHajKhaXUmu4F5d9id
UK1EyxXuCQtjqdGmHsjjKYRjcr7BVRhMLyd3D/CIcWY+aUSGzfyb1vF0kZi+0N5j
1ulu6KgJJy/hx5rRGp5vOo2WqQ1j8OEIoesLOPWeU8l3FtQRUltAJaslWPmSZmVD
4i/NVWmlenOB0DV0iFSaYAGQTI44Wg==
=70/e
-----END PGP SIGNATURE-----

--VRHkVlcfhoPURzHFWlD7yivrhlqXUZmZW--
