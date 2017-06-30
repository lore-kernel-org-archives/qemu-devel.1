Received: from eggs.gnu.org ([2001:4830:134:3::10]:48610)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1dQmAD-00028M-IE
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 23:00:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1dQmAC-0006cD-IW
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 23:00:09 -0400
References: <20170616135847.17726-1-mreitz@redhat.com>
	<0bed1851-9298-0ba5-0604-9686ca5cf569@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <ac1c3cbf-e238-aa84-fffd-0acf68c1f51e@redhat.com>
Date: Fri, 30 Jun 2017 04:59:56 +0200
MIME-Version: 1.0
In-Reply-To: <0bed1851-9298-0ba5-0604-9686ca5cf569@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="oJecBx5ueCiv7Q3s2qFLvSlnhN5LarMSf"
Subject: Re: [Qemu-devel] [PATCH] iotests: Add test for failing qemu-img
 commit
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-block@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--oJecBx5ueCiv7Q3s2qFLvSlnhN5LarMSf
From: Max Reitz <mreitz@redhat.com>
To: Eric Blake <eblake@redhat.com>, qemu-block@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org
Message-ID: <ac1c3cbf-e238-aa84-fffd-0acf68c1f51e@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] iotests: Add test for failing qemu-img
 commit
References: <20170616135847.17726-1-mreitz@redhat.com>
 <0bed1851-9298-0ba5-0604-9686ca5cf569@redhat.com>
In-Reply-To: <0bed1851-9298-0ba5-0604-9686ca5cf569@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2017-06-27 21:52, Eric Blake wrote:
> On 06/16/2017 08:58 AM, Max Reitz wrote:
>> Signed-off-by: Max Reitz <mreitz@redhat.com>
>> ---
>> In order to pass, this depends on "fix: avoid an infinite loop or a
>> dangling pointer problem in img_commit"
>> (http://lists.nongnu.org/archive/html/qemu-block/2017-06/msg00443.html=
)
>=20
> Looks like that is now 4172a003
>=20
>> and on the "block: Don't compare strings in bdrv_reopen_prepare()"
>> series
>> (http://lists.nongnu.org/archive/html/qemu-block/2017-06/msg00424.html=
).
>=20
> Still pending.

By the way, yes, it's still pending because I got stopped in the middle
of writing the QObject test case and now a bit of other stuff came up
this week... I haven't forgotten, but let's see whether I get to finish
it later today.

>> ---
>>  tests/qemu-iotests/020     | 27 +++++++++++++++++++++++++++
>>  tests/qemu-iotests/020.out | 17 +++++++++++++++++
>>  2 files changed, 44 insertions(+)
>>
>> diff --git a/tests/qemu-iotests/020 b/tests/qemu-iotests/020
>> index 7a11110..83d5ef0 100755
>> --- a/tests/qemu-iotests/020
>> +++ b/tests/qemu-iotests/020
>> @@ -110,6 +110,33 @@ for offset in $TEST_OFFSETS; do
>>      io_zero readv $(( offset + 64 * 1024 + 65536 * 4 )) 65536 65536 1=

>>  done
>>  _check_test_img
>> +_cleanup
>> +TEST_IMG=3D$TEST_IMG_SAVE
>> +
>> +echo
>> +echo 'Testing failing commit'
>> +echo
>> +
>> +# Create an image with a null backing file to which committing will f=
ail (with
>> +# ENOSPC so we can distinguish the result from some generic EIO which=
 may be
>> +# generated anywhere in the block layer)
>> +_make_test_img -b "json:{'driver': 'raw',
>> +                         'file': {
>> +                             'driver': 'blkdebug',
>> +                             'inject-error': [{
>> +                                 'event': 'write_aio',
>> +                                 'errno': 28,
>=20
> Still nasty that we encoded an errno value rather than using a
> stringified enum, but that's not your problem.
>=20
>> +                                 'once': true
>> +                             }],
>> +                             'image': {
>> +                                 'driver': 'null-co'
>> +                             }}}"
>=20
> The comment does wonders for explaining how it all works!
>=20
>> +
>> +# Just write anything so comitting will not be a no-op
>=20
> s/comitting/committing/
>=20
> With the typo fix,
> Reviewed-by: Eric Blake <eblake@redhat.com>

Thanks, as always!

Max


--oJecBx5ueCiv7Q3s2qFLvSlnhN5LarMSf
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEvBAEBCAAZBQJZVb6tEhxtcmVpdHpAcmVkaGF0LmNvbQAKCRD0B9sAYdXPQDWp
CACqv1PehCcHHHa7/418oOu7vD28P/3gjv4MMytSNI4vBZAbGrDoq0lX0l220o7V
tCrsE21q1ZUeitNJLfA4nxfdR1Ca/kKAHaq3rPLuAWs0pTF4kyMf/ErLH9f+9ocT
ud3dfsigP/pw9zMDGoT5bllElxQVOVAMNMWFcg+mitTXu453eUZJLpPyaeT9xAiI
UOI3jFLQTOp8k3ZTyziQ3dY8FcyUcvLPCdwpK1tOvm/9L4188pR1DEl9cTjXDPKn
X84hxRYgJI77OngGKk7rroVrqMcDacepBxmzDoJPoz2rAtaqum4Gag9quoKdp0BJ
THy6pOnP9FfIVUFJaMJNjmMt
=c8pI
-----END PGP SIGNATURE-----

--oJecBx5ueCiv7Q3s2qFLvSlnhN5LarMSf--
