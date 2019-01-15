Received: from eggs.gnu.org ([209.51.188.92]:48547)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gjS0k-0002Pm-0j
	for qemu-devel@nongnu.org; Tue, 15 Jan 2019 11:56:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gjRy8-0004gm-6A
	for qemu-devel@nongnu.org; Tue, 15 Jan 2019 11:53:41 -0500
References: <20190112175812.27068-1-eblake@redhat.com>
	<20190112175812.27068-4-eblake@redhat.com>
	<134a0393-e661-5f8f-55ae-8dd6c1e9ec97@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <e94bcbd7-bdb2-abc8-816c-974f1878b78b@redhat.com>
Date: Tue, 15 Jan 2019 10:53:22 -0600
MIME-Version: 1.0
In-Reply-To: <134a0393-e661-5f8f-55ae-8dd6c1e9ec97@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="ndBOP0xTOqBLiR78U9Cddg6eubP8R9UhM"
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
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "nsoffer@redhat.com" <nsoffer@redhat.com>, "rjones@redhat.com" <rjones@redhat.com>, "jsnow@redhat.com" <jsnow@redhat.com>, "qemu-block@nongnu.org" <qemu-block@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--ndBOP0xTOqBLiR78U9Cddg6eubP8R9UhM
From: Eric Blake <eblake@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "nsoffer@redhat.com" <nsoffer@redhat.com>,
 "rjones@redhat.com" <rjones@redhat.com>, "jsnow@redhat.com"
 <jsnow@redhat.com>, "qemu-block@nongnu.org" <qemu-block@nongnu.org>
Message-ID: <e94bcbd7-bdb2-abc8-816c-974f1878b78b@redhat.com>
Subject: Re: [PATCH v3 03/19] qemu-nbd: Sanity check partition bounds
References: <20190112175812.27068-1-eblake@redhat.com>
 <20190112175812.27068-4-eblake@redhat.com>
 <134a0393-e661-5f8f-55ae-8dd6c1e9ec97@virtuozzo.com>
In-Reply-To: <134a0393-e661-5f8f-55ae-8dd6c1e9ec97@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 1/15/19 10:20 AM, Vladimir Sementsov-Ogievskiy wrote:
> 12.01.2019 20:57, Eric Blake wrote:
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
>>   qemu-nbd.c | 18 +++++++++++++++++-
>>   1 file changed, 17 insertions(+), 1 deletion(-)
>>
>> diff --git a/qemu-nbd.c b/qemu-nbd.c
>> index 51b55f2e066..ff4adb9b3eb 100644
>> --- a/qemu-nbd.c
>> +++ b/qemu-nbd.c
>> @@ -1013,12 +1013,28 @@ int main(int argc, char **argv)
>>       fd_size -=3D dev_offset;
>>
>>       if (partition !=3D -1) {
>> -        ret =3D find_partition(blk, partition, &dev_offset, &fd_size)=
;
>> +        off_t limit;
>> +
>> +        if (dev_offset) {
>> +            error_report("Cannot request partition and offset togethe=
r");
>=20
> hmm, but you still allow to request partition and set -o 0, I think it'=
s better
> to forbid it too.

Not worth the bother. Someday, we may want to permit -o and -P together,
where we first calculate the bounds of the partition from -P, and then
use -o to further restrict an even smaller subset of the image exposed
to the user.  Under that interpretation, the added error makes sense as
a short-term stop-gap that prevents us from doing what we want (since we
did not actually treat a non-zero offset as an offset within the
partition), but an offset of 0 is the same as omitting the offset.  So I
didn't see the point to complicate the code just to check whether -o had
been explicitly supplied with its already-default value.

>=20
>> +            exit(EXIT_FAILURE);
>> +        }
>> +        ret =3D find_partition(blk, partition, &dev_offset, &limit);
>>           if (ret < 0) {
>>               error_report("Could not find partition %d: %s", partitio=
n,
>>                            strerror(-ret));
>>               exit(EXIT_FAILURE);
>>           }
>> +        /* partition limits are (32-bit << 9); can't overflow 64 bits=
 */
>> +        assert(dev_offset >=3D 0 && dev_offset + limit >=3D dev_offse=
t);
>=20
> hmm, so these values are read from file and may be whatsoever. Why to a=
ssert instead
> of error_report and exit() ?

The assertion is letting the compiler know that we can't get a negative
value.  (off_t)(uint32_t << 9)*2 is always a positive value for 64-bit
off_t, but the compiler doesn't necessarily know that ((off_t)a +
(off_t)b >=3D a) is going to be true if it doesn't track the range
limitations imposed by find_partition().  You are right that we are
doing an assertion based on data obtained by reading from potentially
malicious data, but the assertion is safe because it will NEVER fail,
but is rather augmenting the compiler's data-type analysis.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--ndBOP0xTOqBLiR78U9Cddg6eubP8R9UhM
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlw+EAIACgkQp6FrSiUn
Q2rfewgArWwO+RgipYZMrMULK1ZGsH7IhlAEm0Q2sNdxSiORo3JG08k7mNQOjIHV
yfwmf3PTV2w5dicbVQFwz8jw0Q/g3fMquycoQDa139m90CUyfLmuzyjMX0SxOoSY
M62Al3ndxaFWA3tpz6QeH64Pnw+vamFBCbCiKWv9kbPVY/5HROv4KkCu9uaZ5Eyg
+PfOn/8SY1BJdXWWnF7+JGRvhLLmIjiPRMe7jsUe0brFyCtOyWwwLmtO1a7wacpY
v1WV1a7Vg6uD+Kx0Jj028JQs6hDPBSTUWPuKTGPxuXjtdthBOWcydmnT+Ner0Wio
m+TYjXn2vUKt3nJSWdQgT1Zfc21VrA==
=BQri
-----END PGP SIGNATURE-----

--ndBOP0xTOqBLiR78U9Cddg6eubP8R9UhM--
