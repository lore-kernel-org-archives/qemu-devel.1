Received: from eggs.gnu.org ([209.51.188.92]:45669)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ghzGr-0001zG-K4
	for qemu-devel@nongnu.org; Fri, 11 Jan 2019 11:02:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ghzGn-0002T7-Sh
	for qemu-devel@nongnu.org; Fri, 11 Jan 2019 11:02:55 -0500
References: <20190110132048.49451-1-vsementsov@virtuozzo.com>
	<acf4d082-dabd-55ec-4435-da3e93b6c4ab@redhat.com>
	<2ad46997-01aa-7a7a-ed53-4463a60ca564@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <5854b5b8-4682-2188-0c00-55c8d413be5e@redhat.com>
Date: Fri, 11 Jan 2019 10:02:33 -0600
MIME-Version: 1.0
In-Reply-To: <2ad46997-01aa-7a7a-ed53-4463a60ca564@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="HASx7Z1SWXXP3nswDYLfPm6HIvhC68SjE"
Subject: Re: [Qemu-devel] [PATCH] block: don't probe zeroes in bs->file by
 default on block_status
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "qemu-block@nongnu.org" <qemu-block@nongnu.org>
Cc: "armbru@redhat.com" <armbru@redhat.com>, "fam@euphon.net" <fam@euphon.net>, "stefanha@redhat.com" <stefanha@redhat.com>, "mreitz@redhat.com" <mreitz@redhat.com>, "kwolf@redhat.com" <kwolf@redhat.com>, "pbonzini@redhat.com" <pbonzini@redhat.com>, Denis Lunev <den@virtuozzo.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--HASx7Z1SWXXP3nswDYLfPm6HIvhC68SjE
From: Eric Blake <eblake@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>
Cc: "armbru@redhat.com" <armbru@redhat.com>, "fam@euphon.net"
 <fam@euphon.net>, "stefanha@redhat.com" <stefanha@redhat.com>,
 "mreitz@redhat.com" <mreitz@redhat.com>, "kwolf@redhat.com"
 <kwolf@redhat.com>, "pbonzini@redhat.com" <pbonzini@redhat.com>,
 Denis Lunev <den@virtuozzo.com>
Message-ID: <5854b5b8-4682-2188-0c00-55c8d413be5e@redhat.com>
Subject: Re: [PATCH] block: don't probe zeroes in bs->file by default on
 block_status
References: <20190110132048.49451-1-vsementsov@virtuozzo.com>
 <acf4d082-dabd-55ec-4435-da3e93b6c4ab@redhat.com>
 <2ad46997-01aa-7a7a-ed53-4463a60ca564@virtuozzo.com>
In-Reply-To: <2ad46997-01aa-7a7a-ed53-4463a60ca564@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 1/11/19 1:54 AM, Vladimir Sementsov-Ogievskiy wrote:

>>
>> How much performance can we buy back without any knobs at all, if we
>> just taught posix-file.c to cache lseek() results?  That is, when
>> visiting a file sequentially, if lseek(fd, 0, SEEK_HOLE) returns EOF o=
n
>> our first block status query, then all subsequent block status queries=

>> fall within what we know to be data, and we can skip the lseek() calls=
=2E
>=20
> EOF is bad mark I think. We may have a small hole not far from EOF, whi=
ch
> will lead to the same performance, but not EOF returned.

EOF was just an example for a file that has no holes. But even for a
file with holes, caching should help.  That is, if I have a raw file with=
:

1M data | 1M hole | 1M data | EOF

but a qcow2 file that was created in an out-of-order fashion, so that
all clusters are discontiguous, then our current code may do something
like the following sequence:

block_status 0 - maps to 64k of host file at offset 0x20000
 - lseek(0x20000) detects that we are in a data portion, and the next
hole begins at 0x100000
 - but because the next cluster is not at 0x30000, we throw away the
information for 0x30000 to 0x100000
block_status 64k - maps to 64k of host file at offset 0x40000
 - lseek(0x40000) detects that we are in a data portion, and the next
hole begins at 0x100000
 - but because the next cluster is not at 0x50000, we throw away the
information for 0x50000 to 0x100000
block status 128k - maps to 64k of host file at offset 0x30000
 - lseek(0x30000) detects that we are in a data portion, and the next
hole begins at 0x100000
=2E..

Even a dumb most-recent use cache will speed this up: both the second
and third queries above can be avoided because we know that both 0x40000
and 0x30000 the second query at 0x40000 can be skipped (0x40000 is
between our most recent lseek at 0x20000 and hole at 0x10000)

Make the cache slightly larger, or use a bitmap with 2 bits per cluster
(tracking unknown, known-data, known-hole), with proper flushing of the
cache as we write to the image, or whatever, and we should automatically
get some performance improvements by using fewer lseek() anywhere that
we remember what previous lseek() already told us, with no knobs needed.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--HASx7Z1SWXXP3nswDYLfPm6HIvhC68SjE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlw4vhkACgkQp6FrSiUn
Q2oczggAjhCZlIyOxFMLjlQjBlxVA9EMqMhnGxSxuPXAcTggWAWVI7/GXsF58AKP
3Tm9lvMQ2aHn8SZPf4GdNFC6TT0bIJZu6hQEPfxD2SPthOF++ysBVrxRi7eI/5tI
fxBvMuvv6Ee1MI6F9uVHJ6pJC5sXW9JPJ9zKptInmFFDcQLjnH1bam0ZkqzbP4mK
H6+nmAePiDkE+XqpeKRIMMJ7ggKcsyL260KPC97VsmpbA7GhO0nRD9gD5lAnmLGF
bEoIfwHIvUBMcJJYDhb9kLKN6lsFUkkebO+7eiN7/Zt/IhFx5n5b5KnVrpKK79l1
uTG6VgboXCi10N99ecdmIZX5ronZ2Q==
=ObOE
-----END PGP SIGNATURE-----

--HASx7Z1SWXXP3nswDYLfPm6HIvhC68SjE--
