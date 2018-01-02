Received: from eggs.gnu.org ([2001:4830:134:3::10]:33764)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eWTD0-0003xq-AQ
	for qemu-devel@nongnu.org; Tue, 02 Jan 2018 15:30:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eWTCz-000565-8n
	for qemu-devel@nongnu.org; Tue, 02 Jan 2018 15:30:50 -0500
References: <20171207203036.14993-1-eblake@redhat.com>
	<20171207203036.14993-19-eblake@redhat.com>
	<20171229025544.GG13004@lemon>
From: Eric Blake <eblake@redhat.com>
Message-ID: <f6d9a2af-4d85-045c-f60f-63cbe9233e93@redhat.com>
Date: Tue, 2 Jan 2018 14:30:37 -0600
MIME-Version: 1.0
In-Reply-To: <20171229025544.GG13004@lemon>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="4Y7ZKQ9hW9deWShSMlhp3KfNojTiifieQ"
Subject: Re: [Qemu-devel] [PATCH v6 18/20] vpc: Switch to
 .bdrv_co_block_status()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, vsementsov@virtuozzo.com, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--4Y7ZKQ9hW9deWShSMlhp3KfNojTiifieQ
From: Eric Blake <eblake@redhat.com>
To: Fam Zheng <famz@redhat.com>
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, vsementsov@virtuozzo.com,
 qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>
Message-ID: <f6d9a2af-4d85-045c-f60f-63cbe9233e93@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v6 18/20] vpc: Switch to
 .bdrv_co_block_status()
References: <20171207203036.14993-1-eblake@redhat.com>
 <20171207203036.14993-19-eblake@redhat.com> <20171229025544.GG13004@lemon>
In-Reply-To: <20171229025544.GG13004@lemon>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 12/28/2017 08:55 PM, Fam Zheng wrote:
> On Thu, 12/07 14:30, Eric Blake wrote:
>> We are gradually moving away from sector-based interfaces, towards
>> byte-based.  Update the vpc driver accordingly.  Drop the now-unused
>> get_sector_offset().
>=20
> No get_sector_offset change in the patch any more, it was removed by
> 778b087e513ea6fdc525c5a194ff7c9b8d3f53cb.

Will tweak the commit message if I have reason to spin v7 (at least 9/20
had a real bug, which is probably easier for me to respin than to ask
the maintainer to adjust).

>=20
>>
>> Signed-off-by: Eric Blake <eblake@redhat.com>
>>
>> ---

>> -    int64_t start, offset;
>> +    int64_t image_offset;
>>      bool allocated;
>> -    int64_t ret;
>> +    int ret;
>>      int n;
>>

>>      do {
>>          /* All sectors in a block are contiguous (without using the b=
itmap) */
>> -        n =3D ROUND_UP(sector_num + 1, s->block_size / BDRV_SECTOR_SI=
ZE)
>> -          - sector_num;
>> -        n =3D MIN(n, nb_sectors);
>> +        n =3D ROUND_UP(offset + 1, s->block_size) - offset;
>> +        n =3D MIN(n, bytes);
>=20
> Should 'n' be updated to int64_t to match the types of offset and bytes=
?

s->block_size is uint32_t, and a power of 2; therefore, rounding 'offset
+ 1' up to block size, then subtracting offset, can't exceed 32 bits.

But that's tricky to audit for; I'm not opposed to changing the type of
'n' to 64-bits if you think that is easier to read.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--4Y7ZKQ9hW9deWShSMlhp3KfNojTiifieQ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlpL6+0ACgkQp6FrSiUn
Q2r0wgf9GsHMm+NgyRYO9+TKAbTfrMy6EXAhwiZ15+RUGBeh/Lpl2HFGBCVVqSzW
qk//Zw8bTZzVUN9MTrpDppiEdlcBU9qPHWQZRqjiqxzGRFTD14ycNlpO7d8APF+S
8DzXN/hw9HAjTTDif6R7fsbByMDPwoSEuWxhFF9Ku4sYTsk6wZqmXk0uPWQBfYcP
lmngKwZk1Cp8dttNQ1sx6l/nGfu6czd8WLuZvJf13DKNJu1nz5U/H4nMKymhi54u
cQNGTqH2f5BOfQyDrx6Yr/vFGzrGMVnw9qqj31eTnHZ81+bcyqvvKluAFNonN9tL
c1rjyi2CR8+sXZow52oeGGcxrRcz1Q==
=LId7
-----END PGP SIGNATURE-----

--4Y7ZKQ9hW9deWShSMlhp3KfNojTiifieQ--
