Received: from eggs.gnu.org ([209.51.188.92]:57584)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1hAyLn-00048Z-CH
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 10:55:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1hAyLm-0004NV-BM
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 10:55:51 -0400
References: <20190330150702.11687-1-eblake@redhat.com>
	<20190401142135.GE4935@localhost.localdomain>
From: Eric Blake <eblake@redhat.com>
Message-ID: <78a1b9fc-6659-abc4-94e8-d77c87b3851c@redhat.com>
Date: Mon, 1 Apr 2019 09:55:23 -0500
MIME-Version: 1.0
In-Reply-To: <20190401142135.GE4935@localhost.localdomain>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="xcmsXpM6tePadP9aOsnxtZncedyJOwhrj"
Subject: Re: [Qemu-devel] [PATCH] qemu-img: Saner printing of large file
 sizes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-devel@nongnu.org, rjones@redhat.com, jsnow@redhat.com, qemu-block@nongnu.org, vsementsov@virtuozzo.com, Markus Armbruster <armbru@redhat.com>, Max Reitz <mreitz@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--xcmsXpM6tePadP9aOsnxtZncedyJOwhrj
From: Eric Blake <eblake@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-devel@nongnu.org, rjones@redhat.com, jsnow@redhat.com,
 qemu-block@nongnu.org, vsementsov@virtuozzo.com,
 Markus Armbruster <armbru@redhat.com>, Max Reitz <mreitz@redhat.com>
Message-ID: <78a1b9fc-6659-abc4-94e8-d77c87b3851c@redhat.com>
Subject: Re: [PATCH] qemu-img: Saner printing of large file sizes
References: <20190330150702.11687-1-eblake@redhat.com>
 <20190401142135.GE4935@localhost.localdomain>
In-Reply-To: <20190401142135.GE4935@localhost.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 4/1/19 9:21 AM, Kevin Wolf wrote:
> Am 30.03.2019 um 16:07 hat Eric Blake geschrieben:
>> Disk sizes close to INT64_MAX cause overflow, for some pretty
>> ridiculous output:
>>
>>   $ ./nbdkit -U - memory size=3D$((2**63 - 512)) --run 'qemu-img info =
$nbd'
>>   image: nbd+unix://?socket=3D/tmp/nbdkitHSAzNz/socket
>>   file format: raw
>>   virtual size: -8388607T (9223372036854775296 bytes)
>>   disk size: unavailable
>>
>> But there's no reason to have two separate implementations of integer
>> to human-readable abbreviation, where one has overflow and stops at
>> 'T', while the other avoids overflow and goes all the way to 'E'. With=

>> this patch, the output now claims 8EiB instead of -8388607T, which
>> really is the correct rounding of largest file size supported by qemu
>> (we could go 511 bytes larger if we used byte-accurate sizing instead
>> of rounding up to the next sector boundary, but that wouldn't change
>> the human-readable result).
>>
>> Reported-by: Richard W.M. Jones <rjones@redhat.com>
>> Signed-off-by: Eric Blake <eblake@redhat.com>
>=20
> Thanks, applied to the block-next branch for 4.1.

You'll need v2. Coming up shortly.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--xcmsXpM6tePadP9aOsnxtZncedyJOwhrj
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlyiJlsACgkQp6FrSiUn
Q2oaQwgArNJiTY6nibDKS0XpCw7CtqlMLedxcbjy95TIAte8pIOXkyEyxNz9u3ak
ueVXL4qg/Fcy/a3t1dGohUu3M6KH2OZSwwMbTGXqynaKuy5rodt0gJ/VId9FpyJX
kRyC735vSROW2LcSWONfHf0Lawi00ob1CtTNzzu9N9cfiHQ9/9fNCmnVblVPZUO4
qI9wYyPyHchuZxw7nw45t9e/BsViYqqfnHuVPwRQ1NjXE9jnGX3aA9pGQG5NciXY
QQ7G3CnqNlG7on962yWry9LAfK4fLFm+D8dUdAAEakP/PomkV9qwk9gffiXxuqWe
lUPIz4+EpXWLlN41xWrjLSfps16QoQ==
=hvyQ
-----END PGP SIGNATURE-----

--xcmsXpM6tePadP9aOsnxtZncedyJOwhrj--
