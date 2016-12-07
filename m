Received: from eggs.gnu.org ([2001:4830:134:3::10]:38167)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cEdwJ-0003bU-Hm
	for qemu-devel@nongnu.org; Wed, 07 Dec 2016 10:15:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cEdwI-0001F2-Cu
	for qemu-devel@nongnu.org; Wed, 07 Dec 2016 10:15:23 -0500
References: <20161202192223.15153-1-eblake@redhat.com>
	<20161202192223.15153-3-eblake@redhat.com>
	<20161207135510.GE4773@noname.str.redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <577bdae2-5d47-ce0b-5722-a4f3e171d0d2@redhat.com>
Date: Wed, 7 Dec 2016 09:15:12 -0600
MIME-Version: 1.0
In-Reply-To: <20161207135510.GE4773@noname.str.redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="CLwFx7gpvHxEM33fxACdUE7qDpaGf4fnk"
Subject: Re: [Qemu-devel] [PATCH v3 2/5] blkdebug: Add pass-through
 write_zero and discard support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-devel@nongnu.org, mreitz@redhat.com, qemu-block@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--CLwFx7gpvHxEM33fxACdUE7qDpaGf4fnk
From: Eric Blake <eblake@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-devel@nongnu.org, mreitz@redhat.com, qemu-block@nongnu.org
Message-ID: <577bdae2-5d47-ce0b-5722-a4f3e171d0d2@redhat.com>
Subject: Re: [PATCH v3 2/5] blkdebug: Add pass-through write_zero and discard
 support
References: <20161202192223.15153-1-eblake@redhat.com>
 <20161202192223.15153-3-eblake@redhat.com>
 <20161207135510.GE4773@noname.str.redhat.com>
In-Reply-To: <20161207135510.GE4773@noname.str.redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 12/07/2016 07:55 AM, Kevin Wolf wrote:
> Am 02.12.2016 um 20:22 hat Eric Blake geschrieben:
>> In order to test the effects of artificial geometry constraints
>> on operations like write zero or discard, we first need blkdebug
>> to manage these actions.  It also allows us to inject errors on
>> those operations, just like we can for read/write/flush.
>>

>>
>>
>> +static int coroutine_fn blkdebug_co_pwrite_zeroes(BlockDriverState *b=
s,
>> +                                                  int64_t offset, int=
 count,
>> +                                                  BdrvRequestFlags fl=
ags)
>> +{
>> +    BDRVBlkdebugState *s =3D bs->opaque;
>> +    BlkdebugRule *rule =3D NULL;
>> +    uint32_t align =3D MAX(bs->bl.request_alignment,
>> +                         bs->bl.pwrite_zeroes_alignment);
>> +
>> +    /* Only pass through requests that are larger than requested
>> +     * preferred alignment (so that we test the fallback to writes on=

>> +     * unaligned portions), and check that the block layer never hand=
s
>> +     * us anything crossing an alignment boundary.  */
>> +    if (count < align) {
>> +        return -ENOTSUP;
>> +    }

This early exit bypasses the checks for error injection - but the block
layer will then fall back to write which will perform the check there.

>> +    assert(QEMU_IS_ALIGNED(offset, align));
>> +    assert(QEMU_IS_ALIGNED(count, align));
>> +    if (bs->bl.max_pwrite_zeroes) {
>> +        assert(count <=3D bs->bl.max_pwrite_zeroes);
>> +    }
>> +
>> +    QSIMPLEQ_FOREACH(rule, &s->active_rules, active_next) {
>> +        if (rule->options.inject.offset =3D=3D -1) {
>=20
> We do have offset and bytes parameters in this function, so I guess we
> should check overlaps like in the read/write functions instead of only
> executing the rule if it doesn't specify an offset.

Oh, right. I copied and pasted from flush, when I should have copied
from read.

>> +    return bdrv_co_pwrite_zeroes(bs->file, offset, count, flags);
>> +}
>> +
>> +
>=20
> Why two newlines?
>=20

Habit; they aren't essential, so I'll trim to 1 for consistency with the
rest of the file.

>> +static int coroutine_fn blkdebug_co_pdiscard(BlockDriverState *bs,
>> +                                             int64_t offset, int coun=
t)
>> +{
>> +    BDRVBlkdebugState *s =3D bs->opaque;
>> +    BlkdebugRule *rule =3D NULL;
>> +    uint32_t align =3D bs->bl.pdiscard_alignment;
>> +
>> +    /* Only pass through requests that are larger than requested
>> +     * minimum alignment, and ensure that unaligned requests do not
>> +     * cross optimum discard boundaries. */
>> +    if (count < bs->bl.request_alignment) {
>> +        return -ENOTSUP;
>> +    }

Here, the early exit is a no-op; we never see the error injection
because there is no fallback path at the block layer.  But I guess
that's still okay - when we are discarding the unaligned portion of a
request, there really is no I/O and therefore no way to inject an error
representing failed I/O.

Looks like I get to spin a v4 for the error injection to do specific
range checking.

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--CLwFx7gpvHxEM33fxACdUE7qDpaGf4fnk
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYSCeAAAoJEKeha0olJ0NqzeQH/1PVqyuXEvVeZfacwTrY2H5N
PWEtOxLBDEjEN6SeBF2yi23GiPVwIP87i/LEhZ3DGcIxO2SGYshqYSvmjKhVWB6U
Latdf6cE/RKUNumb+i0XYfaqk5Xz9Wr9CSg3c5PJkiPzp3+8KegjAlqKLdXtl1w6
bJ8tJxuU9t/EdOqS5dBqugzTO4AT3nsj53DFidOj78PyGh56f/5sWnMmsJuGS4rB
JnJhu4ZOvzJ0ga4RDZyBsJ6lBu1L8CEmiZYlYaMGjqNeRPB4EMXFrl0d1BsE5ihk
QLU+tN+bl5dyU4tJSz9lJmRhhftoENJj2mYdUgfVwbgiEepr9zXy93Zjvf4C5e4=
=Vh9K
-----END PGP SIGNATURE-----

--CLwFx7gpvHxEM33fxACdUE7qDpaGf4fnk--
