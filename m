Received: from eggs.gnu.org ([2001:4830:134:3::10]:43070)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1e07MH-0007RH-1Q
	for qemu-devel@nongnu.org; Thu, 05 Oct 2017 10:42:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1e07MG-0000pR-3y
	for qemu-devel@nongnu.org; Thu, 05 Oct 2017 10:42:41 -0400
References: <20171004014347.25099-1-eblake@redhat.com>
	<20171004014347.25099-3-eblake@redhat.com>
	<20171005143509.GF10969@stefanha-x1.localdomain>
From: Eric Blake <eblake@redhat.com>
Message-ID: <ed2c2c4b-3894-6de1-082d-9476391a12ed@redhat.com>
Date: Thu, 5 Oct 2017 09:41:59 -0500
MIME-Version: 1.0
In-Reply-To: <20171005143509.GF10969@stefanha-x1.localdomain>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="XpQqrDfke0e75fCAAeS8oAgoJqN7fcW5N"
Subject: Re: [Qemu-devel] [PATCH v2 2/5] block: Uniform handling of 0-length
 bdrv_get_block_status()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, jsnow@redhat.com, jcody@redhat.com, qemu-block@nongnu.org, Fam Zheng <famz@redhat.com>, Max Reitz <mreitz@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--XpQqrDfke0e75fCAAeS8oAgoJqN7fcW5N
From: Eric Blake <eblake@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, jsnow@redhat.com,
 jcody@redhat.com, qemu-block@nongnu.org, Fam Zheng <famz@redhat.com>,
 Max Reitz <mreitz@redhat.com>
Message-ID: <ed2c2c4b-3894-6de1-082d-9476391a12ed@redhat.com>
Subject: Re: [PATCH v2 2/5] block: Uniform handling of 0-length
 bdrv_get_block_status()
References: <20171004014347.25099-1-eblake@redhat.com>
 <20171004014347.25099-3-eblake@redhat.com>
 <20171005143509.GF10969@stefanha-x1.localdomain>
In-Reply-To: <20171005143509.GF10969@stefanha-x1.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 10/05/2017 09:35 AM, Stefan Hajnoczi wrote:
> On Tue, Oct 03, 2017 at 08:43:44PM -0500, Eric Blake wrote:
>> Handle a 0-length block status request up front, with a uniform
>> return value claiming the area is not allocated.
>>
>> Most callers don't pass a length of 0 to bdrv_get_block_status()
>> and friends; but it definitely happens with a 0-length read when
>> copy-on-read is enabled.  While we could audit all callers to
>> ensure that they never make a 0-length request, and then assert
>> that fact, it was just as easy to fix things to always report
>> success (as long as the callers are careful to not go into an
>> infinite loop).  However, we had inconsistent behavior on whether
>> the status is reported as allocated or defers to the backing
>> layer, depending on what callbacks the driver implements, and
>> possibly wasting quite a few CPU cycles to get to that answer.
>> Consistently reporting unallocated up front doesn't really hurt
>> anything, and makes it easier both for callers (0-length requests
>> now have well-defined behavior) and for drivers (drivers don't
>> have to deal with 0-length requests).
>>
>> Signed-off-by: Eric Blake <eblake@redhat.com>
>>

> Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
>=20
> If you respin, please consider using a separate if statement to make th=
e
> code clearer:
>=20
>   if (!nb_sectors) {
>       *pnum =3D 0;
>       return 0;
>   }
>   if (sector_num >=3D total_sectors) {
>       *pnum =3D 0;
>       return BDRV_BLOCK_EOF;
>   }

In fact, I think I would prefer to prioritize BDRV_BLOCK_EOF as the
first condition, rather than the second, by swapping those two
statements (that is, reading beyond EOF should set the EOF bit,
regardless of whether nb_sectors was non-zero).

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--XpQqrDfke0e75fCAAeS8oAgoJqN7fcW5N
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlnWRLcACgkQp6FrSiUn
Q2rgeAgAlAOOkoU0FlSSmkoZf8gdxf5+rgMlI72kpvcwkY/y7BmWWhAOBu/+Mok6
pdzdsKUGL5fAi9ugQHcpIBzGVB4MRDfNR6Pdnz0fflpqGDCFCCeL9IwtgORDpkuC
j7iZ6NWNY1M8I10I/ALCBDY53+aj9LSDuk5uUHYXeoyMWtf4NB+yFgH6MX2PgQMK
Z6ptc11sWq7ANN22ifywYAkKqmSLlZqAe9gkr3a5JvldG230trv9ILEag0XTuFYC
83t+46B1h/7qFpvc/UZGi/23rdUVsfZmWTi91rNGyOxzkHkxtdfzlqW9H+mV+lwV
EV1E84mvuUeLe1rCrT+2MY0vm9Cfvw==
=SHT4
-----END PGP SIGNATURE-----

--XpQqrDfke0e75fCAAeS8oAgoJqN7fcW5N--
