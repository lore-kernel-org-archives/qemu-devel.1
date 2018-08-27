Received: from eggs.gnu.org ([2001:4830:134:3::10]:58651)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fuEza-0006k7-H9
	for qemu-devel@nongnu.org; Mon, 27 Aug 2018 06:43:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fuEzZ-0007ra-PI
	for qemu-devel@nongnu.org; Mon, 27 Aug 2018 06:43:30 -0400
From: Max Reitz <mreitz@redhat.com>
References: <20180823220856.10094-1-jsnow@redhat.com>
	<20180823220856.10094-3-jsnow@redhat.com>
	<378eebca-2638-6e43-e922-878be8904bf7@redhat.com>
Message-ID: <6e49c0d3-7856-89c0-e21e-84143f21b72a@redhat.com>
Date: Mon, 27 Aug 2018 12:43:09 +0200
MIME-Version: 1.0
In-Reply-To: <378eebca-2638-6e43-e922-878be8904bf7@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="Z1THDgv9oXod2Au4bdmORpvHm3kXuOenw"
Subject: Re: [Qemu-devel] [PATCH v2 2/9] jobs: canonize Error object
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Snow <jsnow@redhat.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, Stefan Hajnoczi <stefanha@redhat.com>, jtc@redhat.com, Jeff Cody <jcody@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Z1THDgv9oXod2Au4bdmORpvHm3kXuOenw
From: Max Reitz <mreitz@redhat.com>
To: John Snow <jsnow@redhat.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, Stefan Hajnoczi <stefanha@redhat.com>, jtc@redhat.com,
 Jeff Cody <jcody@redhat.com>
Message-ID: <6e49c0d3-7856-89c0-e21e-84143f21b72a@redhat.com>
Subject: Re: [PATCH v2 2/9] jobs: canonize Error object
References: <20180823220856.10094-1-jsnow@redhat.com>
 <20180823220856.10094-3-jsnow@redhat.com>
 <378eebca-2638-6e43-e922-878be8904bf7@redhat.com>
In-Reply-To: <378eebca-2638-6e43-e922-878be8904bf7@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2018-08-27 11:41, Max Reitz wrote:
> On 2018-08-24 00:08, John Snow wrote:
>> Jobs presently use both an Error object in the case of the create job,=

>> and char strings in the case of generic errors elsewhere.
>>
>> Unify the two paths as just j->err, and remove the extra argument from=

>> job_completed. The integer error code for job_completed is kept for no=
w,
>> to be removed shortly in a separate patch.
>>
>> Signed-off-by: John Snow <jsnow@redhat.com>
>> ---
>>  block/backup.c            |  2 +-
>>  block/commit.c            |  2 +-
>>  block/create.c            |  5 ++---
>>  block/mirror.c            |  2 +-
>>  block/stream.c            |  2 +-
>>  include/qemu/job.h        | 10 ++++------
>>  job-qmp.c                 |  5 +++--
>>  job.c                     | 18 ++++++------------
>>  tests/test-bdrv-drain.c   |  2 +-
>>  tests/test-blockjob-txn.c |  2 +-
>>  tests/test-blockjob.c     |  2 +-
>>  11 files changed, 22 insertions(+), 30 deletions(-)
>=20
> [...]
>=20
>> diff --git a/include/qemu/job.h b/include/qemu/job.h
>> index 9cf463d228..5c92c53ef0 100644
>> --- a/include/qemu/job.h
>> +++ b/include/qemu/job.h
>> @@ -124,12 +124,12 @@ typedef struct Job {
>>      /** Estimated progress_current value at the completion of the job=
 */
>>      int64_t progress_total;
>> =20
>> -    /** Error string for a failed job (NULL if, and only if, job->ret=
 =3D=3D 0) */
>> -    char *error;
>> -
>>      /** ret code passed to job_completed. */
>>      int ret;
>> =20
>> +    /** Error object for a failed job **/
>> +    Error *err;
>> +
>=20
> My question remains why you don't keep the iff condition here...
>=20
>>      /** The completion function that will be called when the job comp=
letes.  */
>>      BlockCompletionFunc *cb;
>> =20
>=20
> [...]
>=20
>> diff --git a/job.c b/job.c
>> index 76988f6678..bc1d970df4 100644
>> --- a/job.c
>> +++ b/job.c
>=20
> [...]
>=20
>> @@ -546,7 +546,7 @@ static void coroutine_fn job_co_entry(void *opaque=
)
>> =20
>>      assert(job && job->driver && job->driver->run);
>>      job_pause_point(job);
>> -    job->ret =3D job->driver->run(job, NULL);
>> +    job->ret =3D job->driver->run(job, &job->err);
>=20
> ...by e.g. calling job_update_rc() here.
>=20
> (Which seems reasonable since this did update the return code.)
>=20
> Rest looks good, although I'm missing a "jobs: remove @ret from
> job_completed" patch in one of the two series...

"Max can't read" confirmed


--Z1THDgv9oXod2Au4bdmORpvHm3kXuOenw
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAluD1b0ACgkQ9AfbAGHV
z0D2oQf+PA4n5IyrPazJ1y4S5cxgFnwwkMWE4ZJAzzdss+tpgu9sYzrzGOuj+8Jn
O//QAOYr0KYnwlQtYkXxlYL2sEOxhW/fchNqaDlFIi9wLX12tqj8VV+W/KNBUQwl
e/yMajW7uJrFiLuP/Qusdoo4fSRQtPFMipHcrSaW3fV6/KGPB7Ip4efJlkaJa/nD
HxoBfniPnha+7q/2/bR4F7yGLmiQqoIzkZPVjw6xsjz7jbEt6E33S30Iai1dLVML
Yn56zfb1KGu+LwmAot7Htj+2AuE2i76448ufV6oG5rBvz6KYy/cIA9RPiUXudaqy
mYWmH/GyoROj28eTsbX10OMQHvFOKg==
=vrPh
-----END PGP SIGNATURE-----

--Z1THDgv9oXod2Au4bdmORpvHm3kXuOenw--
