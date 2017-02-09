Received: from eggs.gnu.org ([2001:4830:134:3::10]:45822)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cbvuD-0008LC-TV
	for qemu-devel@nongnu.org; Thu, 09 Feb 2017 16:05:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cbvuC-0003ox-RX
	for qemu-devel@nongnu.org; Thu, 09 Feb 2017 16:05:29 -0500
References: <20161220191523.5779-1-eblake@redhat.com>
	<20161220191523.5779-3-eblake@redhat.com>
	<c251adb7-7269-95f1-66aa-6d2457e5d8f6@redhat.com>
	<08d6f722-22b5-5604-46f7-0d1f812756f5@redhat.com>
	<47a9569b-791e-2c16-7a13-d73d5e0bcd58@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <00d5e214-e991-5033-f11d-c6594614b94b@redhat.com>
Date: Thu, 9 Feb 2017 15:05:14 -0600
MIME-Version: 1.0
In-Reply-To: <47a9569b-791e-2c16-7a13-d73d5e0bcd58@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="hAwHWvnohsPMjvgG5F6HBk3nfBhnm0nTi"
Subject: Re: [Qemu-devel] [PATCH v4 2/7] qcow2: Discard/zero clusters by
 byte count
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, "open list:qcow2" <qemu-block@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--hAwHWvnohsPMjvgG5F6HBk3nfBhnm0nTi
From: Eric Blake <eblake@redhat.com>
To: Max Reitz <mreitz@redhat.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, "open list:qcow2" <qemu-block@nongnu.org>
Message-ID: <00d5e214-e991-5033-f11d-c6594614b94b@redhat.com>
Subject: Re: [PATCH v4 2/7] qcow2: Discard/zero clusters by byte count
References: <20161220191523.5779-1-eblake@redhat.com>
 <20161220191523.5779-3-eblake@redhat.com>
 <c251adb7-7269-95f1-66aa-6d2457e5d8f6@redhat.com>
 <08d6f722-22b5-5604-46f7-0d1f812756f5@redhat.com>
 <47a9569b-791e-2c16-7a13-d73d5e0bcd58@redhat.com>
In-Reply-To: <47a9569b-791e-2c16-7a13-d73d5e0bcd58@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 01/31/2017 07:54 PM, Max Reitz wrote:

>>> Another thing: I'm not quite positive whether qcow2_cluster_zeroize()=

>>> can actually handle a byte count greater than INT_MAX. If you could p=
ass
>>> such a number to it, the multiplication "ret * s->cluster_size" might=

>>> overflow. It's only caller qcow2_co_pwrite_zeroes() will never exceed=

>>> that limit, but maybe this should be made clear somewhere -- either b=
y
>>> making the parameter an int instead of a uint64_t or by asserting it =
in
>>> the function.
>>
>> I'd lean towards an assertion, especially since it would be nice to
>> someday unify all the internal block interfaces to get to a 64-bit
>> interface wherever possible
>=20
> Kevin once said "We should write code that makes sense today, not code
> that will make sense some day in the future." Or something like that. :=
-)

Hmm. I looked a bit further.  The calculation of "ret * s->cluster_size"
is bounded by the maximum value of the earlier "ret =3D zero_single_l2()"=
,
which is limited to the number of clusters in a single L2 table.  But
when you have an image with 2M clusters, a single L2 page thus covers
2M/8 (or 262144) clusters, but that is in turn much larger than INT_MAX.
 My v5 will fix things to track the int return value separately from the
64-bit crawl through zero_single_l2() (in other words, quit overloading
'ret' to serve two purposes).

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--hAwHWvnohsPMjvgG5F6HBk3nfBhnm0nTi
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYnNmKAAoJEKeha0olJ0NqjZAH/03BJgnVGdslu9E7fwSol5h9
ZcNrXk+iq9dWiyJ2aXzJk+ylBlKDSQEHKG4FE6uW/a88FjhVSG6qLXZ40Jwo2AAb
z+nGVAxCBLIoLyJk06DkiqAALy4dK8vUFh1rJdM9iysvcj631RxPAVZDJLg5NtMy
kneol5AoaUPv8+r0y5TibDZo1SEKcfOcftAXsVS2tzfOQ2m73QzM+NLyBoRRt1OX
X3jutuAdbaNgq4Xl0piroT/i+e84fKrzUrrl4kcOy+7LKhd01MKRBq3HBEIfPmkG
7GD7QH0RBGsRJYaipgS0VQhQdhAl5o47ZIHPJBKBQK9uswZCeA8UrYQi5QATXBc=
=+lo1
-----END PGP SIGNATURE-----

--hAwHWvnohsPMjvgG5F6HBk3nfBhnm0nTi--
