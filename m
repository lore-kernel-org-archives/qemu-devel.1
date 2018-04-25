Received: from eggs.gnu.org ([2001:4830:134:3::10]:49779)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fBPI2-0001TM-2J
	for qemu-devel@nongnu.org; Wed, 25 Apr 2018 14:37:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fBPHy-0000pA-VM
	for qemu-devel@nongnu.org; Wed, 25 Apr 2018 14:37:14 -0400
References: <20180423223337.82366-1-eblake@redhat.com>
	<20180423223337.82366-6-eblake@redhat.com>
	<5cb0271b-6b03-7520-cd3d-46deff0ee682@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <99a0fa78-0d55-9b93-b29d-fd28537aeadb@redhat.com>
Date: Wed, 25 Apr 2018 13:37:06 -0500
MIME-Version: 1.0
In-Reply-To: <5cb0271b-6b03-7520-cd3d-46deff0ee682@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="EgyxH8B59iSxMQh4XaR1HUYcB3I3Pe0ef"
Subject: Re: [Qemu-devel] [PATCH v5 5/5] qcow2: Avoid memory over-allocation
 on compressed images
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, qemu-block@nongnu.org, berto@igalia.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--EgyxH8B59iSxMQh4XaR1HUYcB3I3Pe0ef
From: Eric Blake <eblake@redhat.com>
To: Max Reitz <mreitz@redhat.com>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, qemu-block@nongnu.org, berto@igalia.com
Message-ID: <99a0fa78-0d55-9b93-b29d-fd28537aeadb@redhat.com>
Subject: Re: [PATCH v5 5/5] qcow2: Avoid memory over-allocation on compressed
 images
References: <20180423223337.82366-1-eblake@redhat.com>
 <20180423223337.82366-6-eblake@redhat.com>
 <5cb0271b-6b03-7520-cd3d-46deff0ee682@redhat.com>
In-Reply-To: <5cb0271b-6b03-7520-cd3d-46deff0ee682@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 04/25/2018 10:00 AM, Max Reitz wrote:
> On 2018-04-24 00:33, Eric Blake wrote:
>> When reading a compressed image, we were allocating s->cluster_data
>> to 32*cluster_size + 512 (possibly over 64 megabytes, for an image
>> with 2M clusters).  Let's check out the history:
>>

>>
>> So, it's time to cut back on the waste.  A compressed cluster
>> written by qemu will NEVER occupy more than an uncompressed
>> cluster, but based on mid-sector alignment, we may still need
>> to read 1 cluster + 1 sector in order to recover enough bytes
>> for the decompression.  But third-party producers of qcow2 may
>> not be as smart, and gzip DOES document that because the
>> compression stream adds metadata, and because of the pigeonhole
>> principle, there are worst case scenarios where attempts to
>> compress will actually inflate an image, by up to 0.015% (or 62
>> sectors larger for an unfortunate 2M compression).
>=20
> Hm?  2M * 0.00015 < 315 (bytes!), so where does that number come from?

/me puts on the cone of shame...

Umm, it comes from me forgetting that percents need to be scaled before
multiplying.  31.5k bytes is 62 sectors, but you're right that 315 bytes
is only 1 sector.

>=20
>>                                                     In fact,
>> the qcow2 spec permits an all-ones sector count, plus a full
>> sector containing the initial offset, for a maximum read of
>> 2 full clusters; and thanks to the way decompression works,
>> even though such a value is probably too large for the actual
>> compressed data, it really doesn't matter if we read too much
>> (gzip ignores slop, once it has decoded a full cluster).  So
>> it's easier to just allocate cluster_data to be as large as we
>> can ever possibly see; even if it still wastes up to 2M on any
>> image created by qcow2, that's still an improvment of 60M less
>> waste than pre-patch.
>=20
> OK, so from the technical perspective it's irrelevant anyway, but I
> suppose the number should still be fixed in the commit message.

Hey, at least it's a math error instead of a typo ;)

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--EgyxH8B59iSxMQh4XaR1HUYcB3I3Pe0ef
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlrgytMACgkQp6FrSiUn
Q2oouQf+J/BTfw+Hv+UAzuJ9LONwaaPOEbbHvqvbk2dk2hCaDdvPXDv20sB9ACuS
1oLpuDFwX5EUtvL3c21fdP8w5eYJcR7JAXQiQFgnUb8Cp+5UzFPUej2MD4jOC/Ne
FCmjWeIxOWUU77tDnjELk1tzyt/WAXj6CEBI+o4WHNa+O3cMzilvCQo/YJOMaDNF
GP5mt8nAThkzp5GzSjTOwtnsvZ5Pcb9vElT9HIqjDhu77jKzXYHRksBEiUTM0ok1
Lfm2xdJjISdKrfnFPnNM9D43TJE/1hfngabDzPdFMQHpe259Gp5aSnEGML1coilQ
RXhPmVZSq2sEBZ5GCf1TuKQpqimj/Q==
=GfcR
-----END PGP SIGNATURE-----

--EgyxH8B59iSxMQh4XaR1HUYcB3I3Pe0ef--
