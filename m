Received: from eggs.gnu.org ([2001:4830:134:3::10]:52227)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dSjBy-0005Jk-8v
	for qemu-devel@nongnu.org; Wed, 05 Jul 2017 08:14:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dSjBx-0004eE-3d
	for qemu-devel@nongnu.org; Wed, 05 Jul 2017 08:14:02 -0400
References: <20170627192458.15519-1-eblake@redhat.com>
	<20170627192458.15519-5-eblake@redhat.com>
	<20170704150057.GI4253@noname.str.redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <49ade40a-49d2-a888-3c01-041f416b01b2@redhat.com>
Date: Wed, 5 Jul 2017 07:13:49 -0500
MIME-Version: 1.0
In-Reply-To: <20170704150057.GI4253@noname.str.redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="bQAeHTjUbLNR6MRmmonm5TtPu1ir3frqP"
Subject: Re: [Qemu-devel] [PATCH v3 04/20] stream: Switch stream_run() to
 byte-based
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, jsnow@redhat.com, Jeff Cody <jcody@redhat.com>, Max Reitz <mreitz@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--bQAeHTjUbLNR6MRmmonm5TtPu1ir3frqP
From: Eric Blake <eblake@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, jsnow@redhat.com,
 Jeff Cody <jcody@redhat.com>, Max Reitz <mreitz@redhat.com>
Message-ID: <49ade40a-49d2-a888-3c01-041f416b01b2@redhat.com>
Subject: Re: [PATCH v3 04/20] stream: Switch stream_run() to byte-based
References: <20170627192458.15519-1-eblake@redhat.com>
 <20170627192458.15519-5-eblake@redhat.com>
 <20170704150057.GI4253@noname.str.redhat.com>
In-Reply-To: <20170704150057.GI4253@noname.str.redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 07/04/2017 10:00 AM, Kevin Wolf wrote:
> Am 27.06.2017 um 21:24 hat Eric Blake geschrieben:
>> We are gradually converting to byte-based interfaces, as they are
>> easier to reason about than sector-based.  Change the internal
>> loop iteration of streaming to track by bytes instead of sectors
>> (although we are still guaranteed that we iterate by steps that
>> are sector-aligned).
>>
>> Signed-off-by: Eric Blake <eblake@redhat.com>
>> Reviewed-by: John Snow <jsnow@redhat.com>
>>
>> ---
>> v2: no change
>> ---
>>  block/stream.c | 24 ++++++++++--------------
>>  1 file changed, 10 insertions(+), 14 deletions(-)
>>
>> diff --git a/block/stream.c b/block/stream.c
>> index 746d525..2f9618b 100644
>> --- a/block/stream.c
>> +++ b/block/stream.c
>> @@ -108,12 +108,11 @@ static void coroutine_fn stream_run(void *opaque=
)
>>      BlockBackend *blk =3D s->common.blk;
>>      BlockDriverState *bs =3D blk_bs(blk);
>>      BlockDriverState *base =3D s->base;
>> -    int64_t sector_num =3D 0;
>> -    int64_t end =3D -1;
>=20
> Here, end was initialised to -1. This made a differnce for early 'goto
> out' paths because otherwise data->reached_end would incorrectly be tru=
e
> in stream_complete.

Oh, good call.

>=20
> Because we also check data->ret, I think the only case where it actuall=
y
> makes a difference is for the !bs->backing case: This used to result in=

> data->reached_end =3D=3D false, but now it ends up as true. This is bec=
ause
> s->common.len hasn't been set yet, so it is still 0.

When !bs->backing, ret is 0; so that means my commit message is wrong
about there being no semantic change.  But remember, when !bs->backing,
stream is a no-op (there was no backing file to stream into the current
layer, anyways) - so which do we want, declaring that the operation
never reached the end (odd, since we did nothing), or that it is
complete?  In other words, is this something where I should fix the
semantics (perhaps as a separate bug-fix patch), or where I need to fix
this patch to preserve existing semantics?

The next code reached is stream_complete().  Before my patch, it skipped
the main body of the function (because !data->reached_end); with my
patch, we are now calling bdrv_change_backing_file() (presumably a no-op
when there is no backing?)

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--bQAeHTjUbLNR6MRmmonm5TtPu1ir3frqP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJZXNf9AAoJEKeha0olJ0NqUaUH/2T0sx/KMqJIb56XodCJ8u0W
6AyNYvjGUxUqArU9u91qTFSGxcpiAV9w5qlRCQroIFeEyMW+Ec0bxtBjywf3Dvkt
75UQA03AayiDk8LX05vUd1aOML9orEm3CeHKEcKnhtgSt5X6lHpFWHlydPG+dquC
H3IshlQu73gNX0mCQkNecaH/+ctFNwLfguU6hD8pE5npmfl6h/u/mKU0ZA5k05Qf
bipdztQ9W+J6S5j28F2k0sAEZlWxBRrIHCndI1doLVLJ1YI83KPG1ZIk6YJTI2zH
km9J9sZklKmLakEiSrd7th3rwiaXgoVQSAtXi/6iF+g76+CdnSPHfO6Trwy97wE=
=29tM
-----END PGP SIGNATURE-----

--bQAeHTjUbLNR6MRmmonm5TtPu1ir3frqP--
