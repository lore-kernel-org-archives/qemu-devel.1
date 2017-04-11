Received: from eggs.gnu.org ([2001:4830:134:3::10]:57221)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cxxFX-0003ev-UH
	for qemu-devel@nongnu.org; Tue, 11 Apr 2017 10:58:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cxxFW-0002Ik-UY
	for qemu-devel@nongnu.org; Tue, 11 Apr 2017 10:58:32 -0400
References: <20170406150148.zwjpozqtale44jfh@perseus.local>
	<d60ea1f9-ae2c-6625-90de-944cbb490f85@redhat.com>
	<w5160ibyufr.fsf@maestria.local.igalia.com>
	<9d848582-8c76-4d88-2b31-e0e4c63b61d4@redhat.com>
	<w5137dfyq1f.fsf@maestria.local.igalia.com>
	<20170411144921.GN4516@noname.str.redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <252ecbf4-0132-0c6c-5142-20aff1fa6077@redhat.com>
Date: Tue, 11 Apr 2017 09:58:15 -0500
MIME-Version: 1.0
In-Reply-To: <20170411144921.GN4516@noname.str.redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="vN6SipaIW6nnq5CjIelGF6d1rJKufGPPk"
Subject: Re: [Qemu-devel] [RFC] Proposed qcow2 extension: subcluster
 allocation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>, Alberto Garcia <berto@igalia.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--vN6SipaIW6nnq5CjIelGF6d1rJKufGPPk
From: Eric Blake <eblake@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>, Alberto Garcia <berto@igalia.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org,
 qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>
Message-ID: <252ecbf4-0132-0c6c-5142-20aff1fa6077@redhat.com>
Subject: Re: [Qemu-devel] [RFC] Proposed qcow2 extension: subcluster
 allocation
References: <20170406150148.zwjpozqtale44jfh@perseus.local>
 <d60ea1f9-ae2c-6625-90de-944cbb490f85@redhat.com>
 <w5160ibyufr.fsf@maestria.local.igalia.com>
 <9d848582-8c76-4d88-2b31-e0e4c63b61d4@redhat.com>
 <w5137dfyq1f.fsf@maestria.local.igalia.com>
 <20170411144921.GN4516@noname.str.redhat.com>
In-Reply-To: <20170411144921.GN4516@noname.str.redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 04/11/2017 09:49 AM, Kevin Wolf wrote:

>>>> Then (3) is effectively the same as (2), just that the subcluster
>>>> bitmaps are at the end of the L2 cluster, and not next to each entry=
=2E
>>>
>>> Exactly. But it's a difference in implementation, as you won't have t=
o
>>> worry about having changed the L2 table layout; maybe that's a
>>> benefit.
>>
>> I'm not sure if that would simplify or complicate things, but it's wor=
th
>> considering.
>=20
> Note that 64k between an L2 entry and the corresponding bitmap is enoug=
h
> to make an update not atomic any more. They need to be within the same
> sector to get atomicity.

Furthermore, there is a benefit to cache line packing - alternating
64-bits for offset and 64-bits for subclusters will fit all 128 bits in
the same cache line, while having all offsets up front followed by all
subclusters later is not.  Worse, depending on architecture, if the
64-bits for the offset is at the same relative offset to overall cache
alignment as the 64-bits for the subcluster (for example, with 1M
clusters, if the offset is at 4M and the subcluster info is at 5M), the
alignments of the separate memory pages may cause you to end up with
both values competing for the same cache line, causing ping-pong
evictions and associated slowdowns.  Data locality really does want to
locate stuff that is commonly used together to also appear close
together in memory.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--vN6SipaIW6nnq5CjIelGF6d1rJKufGPPk
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJY7O8HAAoJEKeha0olJ0NqDk4H/AuebjKy0EQCK7ZexK1hFwxr
CN5FQkOEG/us+e/IP7czqoM0KmsVd2bLYTmmkG5DLXqsFsFrKQILs/gExw81Tde4
oOnwESr3H1u/vNg6XYCXH90TJhYT3upR9fSO6QsPxEZv0GODTHil/aYEpMdvnxEU
eXkNeWmCPEjmgs8hfu+5uYKZyj5y0HwUrfIgX50U3MCbmJOci5m98tr/5dG4GSHp
1DcHzKQ/59UK+qkr1DekoBltTf5FbgiifBiW7vJWdIMiOMxuaLX9YFn+u6R25gxB
inLd0XDGZyhyWx5EYG8PrMLhuAODU1FHmDF9yK/EumeFRGH+3fcF8cwxpKOvRsw=
=7qCd
-----END PGP SIGNATURE-----

--vN6SipaIW6nnq5CjIelGF6d1rJKufGPPk--
