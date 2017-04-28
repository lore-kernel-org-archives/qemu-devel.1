Received: from eggs.gnu.org ([2001:4830:134:3::10]:56607)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1d4AgF-0005oW-Vg
	for qemu-devel@nongnu.org; Fri, 28 Apr 2017 14:31:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1d4AgE-0002PE-Ga
	for qemu-devel@nongnu.org; Fri, 28 Apr 2017 14:31:48 -0400
References: <73ecd486-2d5c-e204-1588-a0b6324ba77b@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <a18117bb-bf65-1263-48f0-72a2696cdc0b@redhat.com>
Date: Fri, 28 Apr 2017 13:31:32 -0500
MIME-Version: 1.0
In-Reply-To: <73ecd486-2d5c-e204-1588-a0b6324ba77b@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="qLEaRoEsGJAvU6wrs5lsmJGCMxHUKRSgB"
Subject: Re: [Qemu-devel] RFC: some problems with bdrv_get_block_status
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Denis V. Lunev" <den@virtuozzo.com>, QEMU <qemu-devel@nongnu.org>, Qemu-block <qemu-block@nongnu.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--qLEaRoEsGJAvU6wrs5lsmJGCMxHUKRSgB
From: Eric Blake <eblake@redhat.com>
To: "Denis V. Lunev" <den@virtuozzo.com>, QEMU <qemu-devel@nongnu.org>,
 Qemu-block <qemu-block@nongnu.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi
 <stefanha@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <a18117bb-bf65-1263-48f0-72a2696cdc0b@redhat.com>
Subject: Re: RFC: some problems with bdrv_get_block_status
References: <73ecd486-2d5c-e204-1588-a0b6324ba77b@virtuozzo.com>
In-Reply-To: <73ecd486-2d5c-e204-1588-a0b6324ba77b@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 04/28/2017 11:17 AM, Denis V. Lunev wrote:
> Hello, All!
>=20
> Recently we have experienced problems with very slow
> bdrv_get_block_status call, which is massive called f.e.
> from mirror_run().
>=20
> The problem was narrowed down to slow lseek64() system
> call, which can take 1-2-3 seconds.

I'm guessing you meant one-to-three (the range), not one-two-three
(three separate digits), and just had an unfortunate abbreviation of
'to' turning into the phonetically-similar '2'.

>=20
> root@s158 ~]# strace -f -p 77048 -T  -e lseek
> Process 77048 attached with 14 threads
> [pid 77053] lseek(23, 6359613440, SEEK_DATA) =3D 6360276992 <1.250323>

That sounds like a bug in your choice of filesystem.  It's been
mentioned before that lseek has some pathetically poor behavior (I think
tmpfs was one of the culprits), but I maintain that it is better to
hammer on the kernel folks to fix the poor behavior than it is to have
to implement user-space workarounds in every single affected program.

That said, a workaround of being able to request the avoidance of lseek
has been brought up on this list before.


> The problem comes from this branch of the code
>=20
> bdrv_co_get_block_status
>     .......
>     if (bs->file &&
>         (ret & BDRV_BLOCK_DATA) && !(ret & BDRV_BLOCK_ZERO) &&
>         (ret & BDRV_BLOCK_OFFSET_VALID)) {
>         int file_pnum;
>=20
>         ret2 =3D bdrv_co_get_block_status(bs->file, ret >> BDRV_SECTOR_=
BITS,
>                                         *pnum, &file_pnum);
>         if (ret2 >=3D 0) {
>             /* Ignore errors.  This is just providing extra information=
, it
>              * is useful but not necessary.
>              */
>             if (!file_pnum) {
>                 /* !file_pnum indicates an offset at or beyond the EOF;=

> it is
>                  * perfectly valid for the format block driver to point=

> to such
>                  * offsets, so catch it and mark everything as zero */
>                 ret |=3D BDRV_BLOCK_ZERO;
>             } else {
>                 /* Limit request to the range reported by the protocol
> driver */
>                 *pnum =3D file_pnum;
>                 ret |=3D (ret2 & BDRV_BLOCK_ZERO);
>             }
>         }
>     }

I don't see anything wrong with this code. It's nice to know that we
have data (qcow2 says we have allocated bytes due to this layer, so
don't refer to the backing files), but when the underlying file can ALSO
tell us that the underlying protocol is sparse and we are on a hole,
then we know that we have BDRV_BLOCK_ZERO condition which can in turn
enable other optimizations in quite a bit of the stack.  It IS valid to
return BDRV_BLOCK_DATA | BDRV_BLOCK_ZERO (we don't have to limit
ourselves to BDRV_BLOCK_DATA), and we should probably do so any time
that such computation is cheap.

I agree with your analysis that on a poor filesystem where lseek()
behavior sucks that it is no longer cheap to determine where the holes ar=
e.

But the proper workaround for those filesystems should NOT be made by
undoing this part of bdrv_co_get_block_status(), but should rather be
fixed in file-posix.c by the addition of a user-controllable knob on
whether to skip lseek().  In other words, if we're going to work around
the poor filesystem performance, the workaround should live in
file-posix.c, not in the generic block/io.c.  Once the workaround is
enabled, the 'ret2 =3D bdrv_co_get_block_status()' nested call should be
lightning fast (because file-posix.c would no longer be using lseek when
you've requested the workaround).

> Frankly speaking, this optimization should not give much.
> If upper layer format (QCOW2) says that we have data
> here, then nowadays in 99.9% we do have the data.

You are correct that we have BDRV_BLOCK_DATA; but it IS useful to ALSO
know if that data reads back as all zeros (so we can skip reading it).
Just because qcow2 reports something as data does NOT rule out whether
the data still reads as zeros.

> Meanwhile this branch can cause problems. We would
> need block cleared entirely to get the benefit for most
> cases in mirror and backup operations.
>=20
> At my opinion it worth to drop this at all.
>=20
> Guys, do you have any opinion?

Again, my opinion is to not change this part of block/io.c.  Rather,
work should be expended on individual protocol drivers to quit wasting
unnecessary time on reporting BDRV_BLOCK_ZERO if the time spent to
determine that is not worth the effort (as it is when using lseek() on
inefficient filesystems).  It is always safe for a protocol driver to
report BDRV_BLOCK_DATA instead of BDRV_BLOCK_ZERO, if asking the
question is too expensive (treating holes as data may pessimize other
operations, but that's okay if the penalty for asking is worse than what
optimizations are able to regain).

>=20
> Den
>=20
> P.S. The kernel is one based on RedHat 3.10.0-514. The same
>       problem was observed in 3.10.0-327 too.

Red Hat is always two words (I'm allowed to point that out, as they
employ me ;).  But if it really is a Red Hat kernel problem, be sure to
use your support contract to point out the kernel developers that they
really need to fix lseek() - and you'll need to give details on which
filesystem you're using (as not all filesystems have that abysmal
performance).

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--qLEaRoEsGJAvU6wrs5lsmJGCMxHUKRSgB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJZA4qEAAoJEKeha0olJ0NqajAH/igjHln8FmXbt3ToLXtqY/mA
8GBiwjHcdL09aDLEBrhSU4hWilgtWSyKH7rM6L8YlqZwYsdZrpn1GzpfJNKA6qRq
Odnpg9LPC0kJ4+vObJdHxz4Vx8sGUFdx9iFRh0zd4a0QsnVvxwnOIW3dnStvLYSI
d+JU4oLVLuImUA+YkTe+xR8ZNtqhj2LvQumzaZ3SDHMQ7vPauAPq/iVzT3mQ4waa
tXBbnvKVCtV8VIoEhFwz2kWo4jLdqvixQZlSKVvztaA8d06pYop4nlLEQwJeC4Ux
5RAWvogRfFruCUuaA41hZkyTtC1amumhmwVeMQW9TbZLnpNWcUhT3/yUUEJpdp4=
=KA1e
-----END PGP SIGNATURE-----

--qLEaRoEsGJAvU6wrs5lsmJGCMxHUKRSgB--
