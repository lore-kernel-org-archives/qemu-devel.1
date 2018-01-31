Received: from eggs.gnu.org ([2001:4830:134:3::10]:59503)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1egxC3-0004rQ-95
	for qemu-devel@nongnu.org; Wed, 31 Jan 2018 13:33:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1egxBy-0003BA-JH
	for qemu-devel@nongnu.org; Wed, 31 Jan 2018 13:33:11 -0500
References: <1516297747-107232-1-git-send-email-anton.nefedov@virtuozzo.com>
	<1516297747-107232-9-git-send-email-anton.nefedov@virtuozzo.com>
	<7b84e8fe-2141-5609-3f86-1890fc314b6d@redhat.com>
	<2e58f0a9-7db4-b562-e1d0-b8c712a67b21@virtuozzo.com>
	<4b7846c3-bec4-b1a0-50e3-58aa337028ac@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <cfcdb124-b343-ae2f-726d-5b084c9b86bb@redhat.com>
Date: Wed, 31 Jan 2018 12:32:27 -0600
MIME-Version: 1.0
In-Reply-To: <4b7846c3-bec4-b1a0-50e3-58aa337028ac@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="MdDCa1m1AuDmJVXhKrSijv8ghM2OAOqU0"
Subject: Re: [Qemu-devel] [PATCH v7 8/9] qcow2: skip writing zero buffers to
 empty COW areas
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>, Anton Nefedov <anton.nefedov@virtuozzo.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, kwolf@redhat.com, den@virtuozzo.com, berto@igalia.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--MdDCa1m1AuDmJVXhKrSijv8ghM2OAOqU0
From: Eric Blake <eblake@redhat.com>
To: Max Reitz <mreitz@redhat.com>, Anton Nefedov
 <anton.nefedov@virtuozzo.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, kwolf@redhat.com, den@virtuozzo.com,
 berto@igalia.com
Message-ID: <cfcdb124-b343-ae2f-726d-5b084c9b86bb@redhat.com>
Subject: Re: [PATCH v7 8/9] qcow2: skip writing zero buffers to empty COW
 areas
References: <1516297747-107232-1-git-send-email-anton.nefedov@virtuozzo.com>
 <1516297747-107232-9-git-send-email-anton.nefedov@virtuozzo.com>
 <7b84e8fe-2141-5609-3f86-1890fc314b6d@redhat.com>
 <2e58f0a9-7db4-b562-e1d0-b8c712a67b21@virtuozzo.com>
 <4b7846c3-bec4-b1a0-50e3-58aa337028ac@redhat.com>
In-Reply-To: <4b7846c3-bec4-b1a0-50e3-58aa337028ac@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 01/31/2018 11:40 AM, Max Reitz wrote:

>> Maybe it's good enough to cover these cases:
>> =C2=A01. no backing
>> =C2=A02. beyond bdrv_getlength() in backing
>> =C2=A03. unallocated in backing qcow2 (covers 'beyond bdrv_getlength()=

>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 in backing->file')
>>
>> 1 & 2 are easy to check;
>=20
> Not sure how useful 2 is, though.  (I don't know.  I always hear about
> people wanting to optimize for such a case where a backing file is
> shorter than the overlay, but I can't imagine a real use case for that.=
)

I can; here's what's happened to me personally.  I created an image, and
took internal snapshots (yeah, I know those aren't in fashion these
days, but this was long ago).  Later, I ran out of space.  I wanted to
resize the image, but am not convinced whether resizing the image will
play nicely with the internal snapshots (in fact, I don't recall
off-hand whether this was something we prevented in the past and now
support, or if it is still unsupported now...) - so the easiest way is
to create a larger overlay image.

>=20
>> 3: if that's not too hacky maybe we can do the bdrv_is_allocated() che=
ck
>> for qcow2 exclusively and if there is raw (or any other format) backin=
g
>> image - do the COW
>=20
> Yes, well, it seems useful in principle...  But it would require genera=
l
> block layer work indeed.  Maybe a new flag for bdrv_block_status*() tha=
t
> says only to look into the format layer?

Maybe indeed - but first I want my byte-based block_status stuff to land =
;)

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--MdDCa1m1AuDmJVXhKrSijv8ghM2OAOqU0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlpyC7sACgkQp6FrSiUn
Q2qHZwgAmuVnZ2PRsMfMF7xsd+ozP2kxc10/nrO7rZ3cyhK2uR1GuQzGagaEZAn6
CV2QRQ9hkjfpD3vAutCKzvgijDGbjZNbwEHmjy69TiMmZbNAaHU5DHsMkwwzSB4C
GPugx+Vi/vtLB8jKnS1jQzGW6GDWiDBBofswElOfDg2bUmbzwsBK8mAE9MLu8tsM
AP3gak5sjFEVeOF833V8AaB5U4qhRePb498M8YRN7/rrD8iIO1bV1qO0tWdQqANf
2rYdCUwWz2+a4uoHb6h00gon+hTZ8DGQHdcpM2Ro/y/zHqq9Rx2xo+dMbT4HbiJS
3bE0xKCrlcHevuIg8N7qlqg7KHZPJA==
=cToS
-----END PGP SIGNATURE-----

--MdDCa1m1AuDmJVXhKrSijv8ghM2OAOqU0--
