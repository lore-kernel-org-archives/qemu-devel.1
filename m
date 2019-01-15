Received: from eggs.gnu.org ([209.51.188.92]:46244)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gjT8s-0000QJ-FG
	for qemu-devel@nongnu.org; Tue, 15 Jan 2019 13:08:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gjT8p-0007cG-MD
	for qemu-devel@nongnu.org; Tue, 15 Jan 2019 13:08:50 -0500
References: <20190112175812.27068-1-eblake@redhat.com>
	<20190112175812.27068-4-eblake@redhat.com>
	<20190115180036.GH27120@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <64295a6d-4a71-5542-d08d-c8e6f7c1254d@redhat.com>
Date: Tue, 15 Jan 2019 12:08:25 -0600
MIME-Version: 1.0
In-Reply-To: <20190115180036.GH27120@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="2sKW9c1LnZTHnoOoZ3ABv9TKxSFmTzPQ9"
Subject: Re: [Qemu-devel] [PATCH v3 03/19] qemu-nbd: Sanity check partition
 bounds
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Richard W.M. Jones" <rjones@redhat.com>
Cc: qemu-devel@nongnu.org, nsoffer@redhat.com, jsnow@redhat.com, vsementsov@virtuozzo.com, qemu-block@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--2sKW9c1LnZTHnoOoZ3ABv9TKxSFmTzPQ9
From: Eric Blake <eblake@redhat.com>
To: "Richard W.M. Jones" <rjones@redhat.com>
Cc: qemu-devel@nongnu.org, nsoffer@redhat.com, jsnow@redhat.com,
 vsementsov@virtuozzo.com, qemu-block@nongnu.org
Message-ID: <64295a6d-4a71-5542-d08d-c8e6f7c1254d@redhat.com>
Subject: Re: [PATCH v3 03/19] qemu-nbd: Sanity check partition bounds
References: <20190112175812.27068-1-eblake@redhat.com>
 <20190112175812.27068-4-eblake@redhat.com>
 <20190115180036.GH27120@redhat.com>
In-Reply-To: <20190115180036.GH27120@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 1/15/19 12:00 PM, Richard W.M. Jones wrote:
> On Sat, Jan 12, 2019 at 11:57:56AM -0600, Eric Blake wrote:
>> When the user requests a partition, we were using data read
>> from the disk as disk offsets without a bounds check. We got
>> lucky that even when computed offsets are out-of-bounds,
>> blk_pread() will gracefully catch the error later (so I don't
>> think a malicious image can crash or exploit qemu-nbd, and am
>> not treating this as a security flaw), but it's better to
>> flag the problem up front than to risk permanent EIO death of
>> the block device down the road.  Also, note that the
>> partition code blindly overwrites any offset passed in by the
>> user; so make the -o/-P combo an error for less confusion.
>>
>> This can be tested with nbdkit:
>> $ echo hi > file
>> $ nbdkit -fv --filter=3Dtruncate partitioning file truncate=3D64k
>>
>> Pre-patch:
>> $ qemu-nbd -p 10810 -P 1 -f raw nbd://localhost:10809 &
>> $ qemu-io -f raw nbd://localhost:10810
>> qemu-io> r -v 0 1
>> Disconnect client, due to: Failed to send reply: reading from file fai=
led: Input/output error
>> Connection closed
>> read failed: Input/output error
>> qemu-io> q
>> [1]+  Done                    qemu-nbd -p 10810 -P 1 -f raw nbd://loca=
lhost:10809
>>
>> Post-patch:
>> $ qemu-nbd -p 10810 -P 1 -f raw nbd://localhost:10809
>> qemu-nbd: Discovered partition 1 at offset 1048576 size 512, but size =
exceeds file length 65536
>>
>> Signed-off-by: Eric Blake <eblake@redhat.com>
>> ---
>> v3: new patch
>> ---
>>  qemu-nbd.c | 18 +++++++++++++++++-
>>  1 file changed, 17 insertions(+), 1 deletion(-)
>>
>> diff --git a/qemu-nbd.c b/qemu-nbd.c
>> index 51b55f2e066..ff4adb9b3eb 100644
>> --- a/qemu-nbd.c
>> +++ b/qemu-nbd.c
>> @@ -1013,12 +1013,28 @@ int main(int argc, char **argv)
>>      fd_size -=3D dev_offset;
>>
>>      if (partition !=3D -1) {
>> -        ret =3D find_partition(blk, partition, &dev_offset, &fd_size)=
;
>> +        off_t limit;
>=20
> I was only vaguely following the other review comments, but off_t does
> seem odd here.  Even though we can assume that _FILE_OFFSET_BITS=3D64
> maybe we should just use {u,}int64_t?  Does this represent an offset
> in a host file?  Only in the case where qemu-nbd is serving a raw
> format file.  In other cases (say, qcow2) the partition size exists in
> an abstract virtual space.

Yes, later patches switch it to int64_t.  Here, it remains off_t because
find_partition(&limit) still expects off_t.  I suppose in my later
patches, I could use uint64_t limit in spite of keeping int64_t fd_size,
and change the signature of find_partition() accordingly, since I've
decoupled the MBR partition lookup (which is a 41-bit value, always
positive) from the file size checks.

>=20
> But it's not a big deal, so:

Yeah, no need to rewrite this patch, since later patches improve the
type anyway (whether or not I stick to int64_t or uint64_t for the
find_partition() code).

>=20
> Reviewed-by: Richard W.M. Jones <rjones@redhat.com>
>=20
> Rich.
>=20

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--2sKW9c1LnZTHnoOoZ3ABv9TKxSFmTzPQ9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlw+IZkACgkQp6FrSiUn
Q2qKZwf/UQq7krJLedhSfOupOWMwYcRxb8joRgrCM+jjfF5wOMzN9O4Z/sA8VfHI
tZFKqQEwRleiXW309B7oyK/Zv2nD+ANxDGIQ311FmCM/3JQRhfz8oVJbaBOjJCb4
ceKBlwazw3Q/2wUwBygmU1x+NFoZXsIYKcBetmmRV+BXTFtbFbrqOYXf4pYORaMp
nvYmzBBr6TiLI5pRgjhA25p9+yv4biGW8naI8CtuTsnWVZ9khSYh752k0dzb6JUK
ck/y11XyD+GvX4+V0ZhFsxWViVmQ6dAExeHPEODb14Fqa5tli08XzWX68PsZzmvJ
9QFNy2kl2RujT4fNWMc5cnYiRgY2Ug==
=n9u5
-----END PGP SIGNATURE-----

--2sKW9c1LnZTHnoOoZ3ABv9TKxSFmTzPQ9--
