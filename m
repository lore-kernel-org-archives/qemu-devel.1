Received: from eggs.gnu.org ([209.51.188.92]:50974)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1hMfCI-0000tY-Bk
	for qemu-devel@nongnu.org; Fri, 03 May 2019 16:54:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1hMfCH-0000ns-31
	for qemu-devel@nongnu.org; Fri, 03 May 2019 16:54:22 -0400
References: <e3e75fd5-661e-95ab-d7d6-f9a7bf6548d4@redhat.com>
	<316d5b3f-d25a-6f9d-6d28-a91f7d2bc22e@redhat.com>
	<d2a3e561-8f17-8d97-3396-e275f0262cf2@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <3e34678e-daa2-a7e0-3da9-dbd3d1c27e64@redhat.com>
Date: Fri, 3 May 2019 15:54:13 -0500
MIME-Version: 1.0
In-Reply-To: <d2a3e561-8f17-8d97-3396-e275f0262cf2@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="IIyiWqaavXnBD0SAYKC24TlEPzNk3oPMC"
Subject: Re: [Qemu-devel] Failing QEMU iotest 221
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, Qemu-block <qemu-block@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>
Cc: Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--IIyiWqaavXnBD0SAYKC24TlEPzNk3oPMC
From: Eric Blake <eblake@redhat.com>
To: Thomas Huth <thuth@redhat.com>, Qemu-block <qemu-block@nongnu.org>,
 QEMU Developers <qemu-devel@nongnu.org>
Cc: Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>
Message-ID: <3e34678e-daa2-a7e0-3da9-dbd3d1c27e64@redhat.com>
Subject: Re: Failing QEMU iotest 221
References: <e3e75fd5-661e-95ab-d7d6-f9a7bf6548d4@redhat.com>
 <316d5b3f-d25a-6f9d-6d28-a91f7d2bc22e@redhat.com>
 <d2a3e561-8f17-8d97-3396-e275f0262cf2@redhat.com>
In-Reply-To: <d2a3e561-8f17-8d97-3396-e275f0262cf2@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 5/2/19 11:43 PM, Thomas Huth wrote:
> On 03/05/2019 00.02, Eric Blake wrote:
>> On 4/28/19 10:21 AM, Thomas Huth wrote:
>>> QEMU iotest 221 is failing for me, too, when I run it with -raw:
>>
>> Which filesystem?
>=20
> ext4 again.
>=20
> $ stat -f /home/thuth/tmp/qemu-build/tests/qemu-iotests/
>   File: "/home/thuth/tmp/qemu-build/tests/qemu-iotests/"
>     ID: 1e68b4a412e09716 Namelen: 255     Type: ext2/ext3
> Block size: 1024       Fundamental block size: 1024

Odd that it is so small; these days, most ext4 systems have a block size
of 4k.

>=20
> Maybe the "check" script should report the output of "stat -f", too?

Wouldn't hurt, although that doesn't tell us all of the file system
tuning parameters that might be important to reproducing a problem.


>>> +++ /home/thuth/tmp/qemu-build/tests/qemu-iotests/221.out.bad	2019-04=
-28 17:18:52.000000000 +0200
>>> @@ -7,10 +7,10 @@
>>>  [{ "start": 0, "length": 43520, "depth": 0, "zero": true, "data": fa=
lse, "offset": OFFSET}]
>>>  wrote 1/1 bytes at offset 43008
>>>  1 bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
>>> -[{ "start": 0, "length": 40960, "depth": 0, "zero": true, "data": fa=
lse, "offset": OFFSET},
>>> -{ "start": 40960, "length": 2049, "depth": 0, "zero": false, "data":=
 true, "offset": OFFSET},
>>> +[{ "start": 0, "length": 43008, "depth": 0, "zero": true, "data": fa=
lse, "offset": OFFSET},
>>> +{ "start": 43008, "length": 1, "depth": 0, "zero": false, "data": tr=
ue, "offset": OFFSET},
>>
>> Ugh. Hole granularities are file-system specific, so we need to figure=

>> out some way to fuzz the input. It might also be possible to pick nice=
r
>> size numbers - perhaps if the test image is sized at 64k+1 instead of
>> 43009 (84*512, but NOT evenly divisible by 4k), the +1 byte is more
>> likely to be directly one a hole boundary, rather than being somewhere=

>> that causes rounding the hole boundary 2k earlier because of 4k or 64k=

>> sizing constraints.
>=20
> Ok ... sounds like that's definitely something I'd like to leave to you=

> or one of the block guys to fix.

I can certainly prepare a patch that widens the file to 64k+1 instead of
43008+1, but since I can't (yet) reproduce the failure, I'd be relying
on you to verify that it makes a difference.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--IIyiWqaavXnBD0SAYKC24TlEPzNk3oPMC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlzMqnUACgkQp6FrSiUn
Q2rLWQf/ZnycWxcGiOfsWyEogzcjcJ5NNO4Q/xEjvfeHzTaxiVwBlPlifNPJT4CS
8tv1DNWsoXp6I3K9vZIRAkw8MuPSACAAn1LbOPXyTcgJF6OWAJr3N1W07PwBgbox
BkzeYwIztWmuZVvD8Q1bjAo/QfDlFGKmEXoPFZXJwU/5j8a5FpydYg+zopo6RqTE
R4JW9i2M30MWZz+eFOUVzruANLNU0tpkbgzEDznHMFBcI2HiQWANlVrMvrs9HzoV
5RMyxTdkztNQ3DIs3Qvy7CaDHrUBDY7Pj0dZjA+1QFcXCPA9XUKELS9HYUUm5KBC
WdQHC/o9ySau9vzEdx9CPrHy28CMaQ==
=xfCm
-----END PGP SIGNATURE-----

--IIyiWqaavXnBD0SAYKC24TlEPzNk3oPMC--
