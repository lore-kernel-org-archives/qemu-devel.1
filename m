Received: from eggs.gnu.org ([209.51.188.92]:59699)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1gpZjG-0001JN-HV
	for qemu-devel@nongnu.org; Fri, 01 Feb 2019 09:23:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1gpZjF-0000KE-Kw
	for qemu-devel@nongnu.org; Fri, 01 Feb 2019 09:23:38 -0500
References: <20190130235251.17911-1-mreitz@redhat.com>
	<2a6ece79-0e51-4707-2427-57825f957990@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <c9df3659-ccea-1be9-2feb-31324f8f9559@redhat.com>
Date: Fri, 1 Feb 2019 15:23:11 +0100
MIME-Version: 1.0
In-Reply-To: <2a6ece79-0e51-4707-2427-57825f957990@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="JIesyO0CkjdY7D9CC1j6UoTEzuAGkedFd"
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH] iotests: Filter second
 BLOCK_JOB_ERROR from 229
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Snow <jsnow@redhat.com>, qemu-block@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org, Eric Blake <eblake@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--JIesyO0CkjdY7D9CC1j6UoTEzuAGkedFd
From: Max Reitz <mreitz@redhat.com>
To: John Snow <jsnow@redhat.com>, qemu-block@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org,
 Eric Blake <eblake@redhat.com>
Message-ID: <c9df3659-ccea-1be9-2feb-31324f8f9559@redhat.com>
Subject: Re: [Qemu-block] [PATCH] iotests: Filter second BLOCK_JOB_ERROR from
 229
References: <20190130235251.17911-1-mreitz@redhat.com>
 <2a6ece79-0e51-4707-2427-57825f957990@redhat.com>
In-Reply-To: <2a6ece79-0e51-4707-2427-57825f957990@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 31.01.19 03:21, John Snow wrote:
>=20
>=20
> On 1/30/19 6:52 PM, Max Reitz wrote:
>> Without this filter, this test sometimes fails.
>>
>> Signed-off-by: Max Reitz <mreitz@redhat.com>
>> ---
>> I intended to send this as part of my iotest fixes series, but it ende=
d
>> up on the wrong branch...  Doesn't really matter, though, as there is =
no
>> functional dependency.
>> ---
>>  tests/qemu-iotests/229     | 6 +++++-
>>  tests/qemu-iotests/229.out | 1 -
>>  2 files changed, 5 insertions(+), 2 deletions(-)
>>
>> diff --git a/tests/qemu-iotests/229 b/tests/qemu-iotests/229
>> index 893d098ad2..b0d4885fa6 100755
>> --- a/tests/qemu-iotests/229
>> +++ b/tests/qemu-iotests/229
>> @@ -81,11 +81,15 @@ echo
>>  echo '=3D=3D=3D Force cancel job paused in error state  =3D=3D=3D'
>>  echo
>> =20
>> +# Filter out BLOCK_JOB_ERROR events because they may or may not occur=
=2E
>> +# Cancelling the job means resuming it for a bit before it is actuall=
y
>> +# aborted, and in that time it may or may not re-encounter the error.=

>=20
> Oh, because the job is "paused" and cancelling it involves job_enter,
> which we then allow the job to gracefully fail through it's own pathway=
s
> -- but depending on where it failed originally, it may-or-may-not wind
> up trying something else that fails before it finds the "exit
> gracefully" signal, is that right?

That's at least how I explained it to me, yes.

> I guess there's no real way to adjust that behavior.
>=20
>>  success_or_failure=3D"y" _send_qemu_cmd $QEMU_HANDLE \
>>      "{'execute': 'block-job-cancel',
>>                   'arguments': { 'device': 'testdisk',
>>                                  'force': true}}" \
>> -     "BLOCK_JOB_CANCELLED" "Assertion"
>> +     "BLOCK_JOB_CANCELLED" "Assertion" \
>> +    | grep -v '"BLOCK_JOB_ERROR"'
>> =20
>>  # success, all done
>>  echo "*** done"
>> diff --git a/tests/qemu-iotests/229.out b/tests/qemu-iotests/229.out
>> index 4c4112805f..a3eb33788a 100644
>> --- a/tests/qemu-iotests/229.out
>> +++ b/tests/qemu-iotests/229.out
>> @@ -17,7 +17,6 @@ wrote 2097152/2097152 bytes at offset 0
>> =20
>>  {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "e=
vent": "JOB_STATUS_CHANGE", "data": {"status": "running", "id": "testdisk=
"}}
>>  {"return": {}}
>> -{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "e=
vent": "BLOCK_JOB_ERROR", "data": {"device": "testdisk", "operation": "wr=
ite", "action": "stop"}}
>>  {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "e=
vent": "JOB_STATUS_CHANGE", "data": {"status": "aborting", "id": "testdis=
k"}}
>>  {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "e=
vent": "BLOCK_JOB_CANCELLED", "data": {"device": "testdisk", "len": 20971=
52, "offset": 1048576, "speed": 0, "type": "mirror"}}
>>  *** done
>>
>=20
> I think this is fine, if we cannot help to make this any more
> deterministic, so I'm fine with:
>=20
> Reviewed-by: John Snow <jsnow@redhat.com>
>=20
> but I am curious to know if this poses any theoretical problems for
> libvirt having to deal with possibly an extra hiccup before the cancel
> registers.

Hm...  I would say the bigger issue is the error event appearing than
that not being the case.  Because it appears most of the time, I think
libvirt can deal with it.

Max


--JIesyO0CkjdY7D9CC1j6UoTEzuAGkedFd
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlxUVlAACgkQ9AfbAGHV
z0CeCQf/ZKpSE2CfWmwwtXTTPNvBP+5dw3kVxH7xxv7bXOKfLUuKNZZKqXpK1AOI
URF08PkaaK//IBjRlI6Sn3Y4GX+/JIDS/laP/t3726BDexuRecqRse+KMXuVNnrp
atrulJ9O1nU0sEaVTynm4T0F4lAKcjIr2rPVxv9PWG8bV7tqj+aMKFstT8t4Zb2t
8Lr6jzqSCuSrU151rys6EJ363Y0DdZfAGbT+fZ/oY2lgRarxtwKOWQ92XHhSpP0T
E7IJ/X+8HT2BAAORPsi22Ah9nuuuQudbloYoNtuYGmdn6savCaCBavTXHNZWCqNT
1zyAa5uZuAZzlcKoVOKXfgqg6A8Q3w==
=q4La
-----END PGP SIGNATURE-----

--JIesyO0CkjdY7D9CC1j6UoTEzuAGkedFd--
