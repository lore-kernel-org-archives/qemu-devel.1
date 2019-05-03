Received: from eggs.gnu.org ([209.51.188.92]:44121)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1hMQ2g-0004V4-O0
	for qemu-devel@nongnu.org; Fri, 03 May 2019 00:43:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1hMQ2f-0007fO-Nf
	for qemu-devel@nongnu.org; Fri, 03 May 2019 00:43:26 -0400
References: <e3e75fd5-661e-95ab-d7d6-f9a7bf6548d4@redhat.com>
	<316d5b3f-d25a-6f9d-6d28-a91f7d2bc22e@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <d2a3e561-8f17-8d97-3396-e275f0262cf2@redhat.com>
Date: Fri, 3 May 2019 06:43:18 +0200
MIME-Version: 1.0
In-Reply-To: <316d5b3f-d25a-6f9d-6d28-a91f7d2bc22e@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="J5DIB8I5de95q2y7MIyLNEDAkbm6DzUQI"
Subject: Re: [Qemu-devel] Failing QEMU iotest 221
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, Qemu-block <qemu-block@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>
Cc: Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--J5DIB8I5de95q2y7MIyLNEDAkbm6DzUQI
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 03/05/2019 00.02, Eric Blake wrote:
> On 4/28/19 10:21 AM, Thomas Huth wrote:
>> QEMU iotest 221 is failing for me, too, when I run it with -raw:
>=20
> Which filesystem?

ext4 again.

$ stat -f /home/thuth/tmp/qemu-build/tests/qemu-iotests/
  File: "/home/thuth/tmp/qemu-build/tests/qemu-iotests/"
    ID: 1e68b4a412e09716 Namelen: 255     Type: ext2/ext3
Block size: 1024       Fundamental block size: 1024

Maybe the "check" script should report the output of "stat -f", too?

>> tests/qemu-iotests$ ./check -raw 221
>> QEMU          -- "/home/thuth/tmp/qemu-build/tests/qemu-iotests/../../=
x86_64-softmmu/qemu-system-x86_64" -nodefaults -machine accel=3Dqtest
>> QEMU_IMG      -- "/home/thuth/tmp/qemu-build/tests/qemu-iotests/../../=
qemu-img"=20
>> QEMU_IO       -- "/home/thuth/tmp/qemu-build/tests/qemu-iotests/../../=
qemu-io"  --cache writeback -f raw
>> QEMU_NBD      -- "/home/thuth/tmp/qemu-build/tests/qemu-iotests/../../=
qemu-nbd"=20
>> IMGFMT        -- raw
>> IMGPROTO      -- file
>> PLATFORM      -- Linux/x86_64 thuth 3.10.0-957.10.1.el7.x86_64
>> TEST_DIR      -- /home/thuth/tmp/qemu-build/tests/qemu-iotests/scratch=

>> SOCKET_SCM_HELPER -- /home/thuth/tmp/qemu-build/tests/qemu-iotests/soc=
ket_scm_helper
>>
>> 221         - output mismatch (see 221.out.bad)
>> --- /home/thuth/devel/qemu/tests/qemu-iotests/221.out	2019-04-23 16:43=
:12.000000000 +0200
>> +++ /home/thuth/tmp/qemu-build/tests/qemu-iotests/221.out.bad	2019-04-=
28 17:18:52.000000000 +0200
>> @@ -7,10 +7,10 @@
>>  [{ "start": 0, "length": 43520, "depth": 0, "zero": true, "data": fal=
se, "offset": OFFSET}]
>>  wrote 1/1 bytes at offset 43008
>>  1 bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
>> -[{ "start": 0, "length": 40960, "depth": 0, "zero": true, "data": fal=
se, "offset": OFFSET},
>> -{ "start": 40960, "length": 2049, "depth": 0, "zero": false, "data": =
true, "offset": OFFSET},
>> +[{ "start": 0, "length": 43008, "depth": 0, "zero": true, "data": fal=
se, "offset": OFFSET},
>> +{ "start": 43008, "length": 1, "depth": 0, "zero": false, "data": tru=
e, "offset": OFFSET},
>=20
> Ugh. Hole granularities are file-system specific, so we need to figure
> out some way to fuzz the input. It might also be possible to pick nicer=

> size numbers - perhaps if the test image is sized at 64k+1 instead of
> 43009 (84*512, but NOT evenly divisible by 4k), the +1 byte is more
> likely to be directly one a hole boundary, rather than being somewhere
> that causes rounding the hole boundary 2k earlier because of 4k or 64k
> sizing constraints.

Ok ... sounds like that's definitely something I'd like to leave to you
or one of the block guys to fix.

 Thomas


--J5DIB8I5de95q2y7MIyLNEDAkbm6DzUQI
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJcy8bmAAoJEC7Z13T+cC21xnIP/3qeFILC1W7KyGC+i+ZWrOGE
/akPatxVqFq+xZqOhfS4jML3IREtMpsi0taydA6s8SY3fds1jxuO0zhjg51B15DH
HWSB9p/jEywnMOIhBCBQr0DtvYHigVZOGXR5JPvl/mwokAgBaGAkp6FlvPludFMI
nxwqC5rLf17RsZqtr/n2DX1VXpfzUcSm8TlsKMAt5ebyzsZPgR0pwsvJUxxFNLJu
3JhSixqB99jaoEm4M/g92ep7/iDgnZGE17d3S8cCOl5lJHZ3HtmWkIBXeHfPP4NP
Vi54YiZ8snIIpCiynyk1cbpftzlkl2KUsg5MMjHxQ7AIP+QgqDiIbg1tgeQyiG7l
LkTexsndRoitZZSMO1Yb9cqaiYcxDC5RW6GywU1Frtc7LRgvoXAA1FUg7hlfhTin
9iZU1YNWH6V4mcylnZSN2CldmTwwqpz++65mDPsFvS1pTHh6oaTTQjScRa1r9FHz
hlnY2kLxevVjeTW2vXG6hkA7VmrBt0YRtl2lXKLyJGhXECaqwd7ui6fFumVlKcbg
N0WGpPmDlHa7buNyegUID9MBfFuB08dYglwVUXJzb9ri0aEuDbLIxzpFOT3B7ETl
NuVRnkVN3yBndndrz6lVj6HPwbYywPBw9AHGcZEL7Nb3Jzw+dSO9lG0b1s2OcSe5
TN3QqRoeSUnh4DdCvZG4
=pz3s
-----END PGP SIGNATURE-----

--J5DIB8I5de95q2y7MIyLNEDAkbm6DzUQI--
