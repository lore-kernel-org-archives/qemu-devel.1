Received: from eggs.gnu.org ([2001:4830:134:3::10]:45225)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fPm8c-0005GL-L1
	for qemu-devel@nongnu.org; Mon, 04 Jun 2018 05:50:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fPm8b-0006fT-JJ
	for qemu-devel@nongnu.org; Mon, 04 Jun 2018 05:50:54 -0400
References: <20180601123221.29437-1-mreitz@redhat.com>
	<c0002f27-b60c-a09c-0a2f-9dde3daaba8f@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <617f1301-4479-8c25-4ce8-92acdd690ec2@redhat.com>
Date: Mon, 4 Jun 2018 11:50:38 +0200
MIME-Version: 1.0
In-Reply-To: <c0002f27-b60c-a09c-0a2f-9dde3daaba8f@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="hkag7BwQ48cOTf3yXiYrIyBITzyVBUAFX"
Subject: Re: [Qemu-devel] [PATCH] iotests: Fix 219's timing
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
--hkag7BwQ48cOTf3yXiYrIyBITzyVBUAFX
From: Max Reitz <mreitz@redhat.com>
To: Eric Blake <eblake@redhat.com>, qemu-block@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org
Message-ID: <617f1301-4479-8c25-4ce8-92acdd690ec2@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] iotests: Fix 219's timing
References: <20180601123221.29437-1-mreitz@redhat.com>
 <c0002f27-b60c-a09c-0a2f-9dde3daaba8f@redhat.com>
In-Reply-To: <c0002f27-b60c-a09c-0a2f-9dde3daaba8f@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2018-06-01 23:36, Eric Blake wrote:
> On 06/01/2018 07:32 AM, Max Reitz wrote:
>> 219 has two issues that may lead to sporadic failure, both of which ar=
e
>> the result of issuing query-jobs too early after a job has been
>> modified.=C2=A0 This can then lead to different results based on wheth=
er the
>> modification has taken effect already or not.
>>
>> First, query-jobs is issued right after the job has been created.
>> Besides its current progress possibly being in any random state (which=

>> has already been taken care of), its total progress too is basically
>> arbitrary, because the job may not yet have been able to determine it.=

>> This patch addresses this by just filtering the total progress, like
>> what has been done for the current progress already.
>>
>> Secondly, query-jobs is issued right after a job has been resumed.=C2=A0=
 The
>> job may or may not yet have had the time to actually perform any I/O,
>> and thus its current progress may or may not have advanced.=C2=A0 To m=
ake
>> sure it has indeed advanced (which is what the reference output alread=
y
>> assumes), insert a sleep of 100 ms before query-jobs is invoked.=C2=A0=
 With a
>> slice time of 100 ms, a buffer size of 64 kB and a speed of 256 kB/s,
>> this should be the right amount of time to let the job advance by
>> exactly 64 kB.
>=20
> This still sounds a bit fragile (under heavy load, our 100ms sleep coul=
d
> turn into 200 such that more than 64k could transfer before we finally
> get a chance to query), but seems more robust that what we currently ha=
ve.

Indeed.  I'll just say I'll try to keep it in mind when I see the test
failing somewhen in the future. O:-)

(I guess I'll have to make it slower then.)

>> Signed-off-by: Max Reitz <mreitz@redhat.com>
>> ---
>> =C2=A0 tests/qemu-iotests/219=C2=A0=C2=A0=C2=A0=C2=A0 | 10 +++++++---
>> =C2=A0 tests/qemu-iotests/219.out | 10 +++++-----
>> =C2=A0 2 files changed, 12 insertions(+), 8 deletions(-)
>=20
>> @@ -58,12 +61,13 @@ def test_job_lifecycle(vm, job, job_args,
>> has_ready=3DFalse):
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 iotests.log(vm.qmp(job, job_id=3D'job0'=
, **job_args))
>> =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 # Depending on the storage, the =
first request may or may not
>> have completed
>> -=C2=A0=C2=A0=C2=A0 # yet, so filter out the progress. Later query-job=
 calls don't
>> need the
>> -=C2=A0=C2=A0=C2=A0 # filtering because the progress is made determini=
stic by the
>> block job
>> -=C2=A0=C2=A0=C2=A0 # speed
>> +=C2=A0=C2=A0=C2=A0 # yet (and the total progress may not have been fu=
lly determined
>> yet), so
>> +=C2=A0=C2=A0=C2=A0 # filter out the progress. Later query-job calls d=
on't need the
>> filtering
>> +=C2=A0=C2=A0=C2=A0 # because the progress is made deterministic by th=
e block job speed
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 result =3D vm.qmp('query-jobs')
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 for j in result['return']:
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 del j['current-=
progress']
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 del j['total-progress']
>=20
> Would this be better as:
>=20
> j['current-progress'] =3D "VALUE"
> j['total-progress'] =3D "VALUE"
>=20
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 iotests.log(result)
>> =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 # undefined -> created -> runnin=
g
>> diff --git a/tests/qemu-iotests/219.out b/tests/qemu-iotests/219.out
>> index 346801b655..740b3d06d7 100644
>> --- a/tests/qemu-iotests/219.out
>> +++ b/tests/qemu-iotests/219.out
>> @@ -3,7 +3,7 @@ Launching VM...
>> =C2=A0 =C2=A0 Starting block job: drive-mirror (auto-finalize: True;
>> auto-dismiss: True)
>> =C2=A0 {u'return': {}}
>> -{u'return': [{u'status': u'running', u'total-progress': 4194304,
>> u'id': u'job0', u'type': u'mirror'}]}
>> +{u'return': [{u'status': u'running', u'id': u'job0', u'type':
>> u'mirror'}]}
>=20
> so that the trace shows that the field was present but filtered, rather=

> than looking strange by not showing the field at all?

Yes, that would be better.  I'll change it.

> But since it was copied from pre-existing deletion rather than replacem=
ent,
> Reviewed-by: Eric Blake <eblake@redhat.com>

Thanks,

Max


--hkag7BwQ48cOTf3yXiYrIyBITzyVBUAFX
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlsVC24ACgkQ9AfbAGHV
z0CaGwf+INuPlQvn2qBeAfQefElCHTYlREJoroKkfz3LQpOcDRgL9t4ctdccsjKp
Z+LM0v/DC2hNCHx4PNUOUHg6phLb+5WbX7hwgdKjNkRCdwtemz08wAUvGqo9FpjO
k3cVebJfYJflqz3KSAi7TC8R+z2VxTYjrnKPQOhNa0SO1ECUOXVzvaTJ+M9Z0mwe
u4dFZihBLrL+182QH+lLsd7F/eg7K6Os8VXtAdbUxUHkxSss/saxXAB16VUcFuWK
nvqBwDboVAun52oti0iYj+S3zJVKxy5D5+GhlORj8ks4wSnydVEO9dstUhhIPU8w
81MmwoN2StYBxakR0Qjc55JnR27b2w==
=wapH
-----END PGP SIGNATURE-----

--hkag7BwQ48cOTf3yXiYrIyBITzyVBUAFX--
