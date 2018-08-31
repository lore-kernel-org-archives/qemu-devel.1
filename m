Received: from eggs.gnu.org ([2001:4830:134:3::10]:46150)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fvfOb-0001Ih-JM
	for qemu-devel@nongnu.org; Fri, 31 Aug 2018 05:07:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fvfOa-0001Ca-Cr
	for qemu-devel@nongnu.org; Fri, 31 Aug 2018 05:07:13 -0400
References: <20180823220856.10094-1-jsnow@redhat.com>
	<20180823220856.10094-2-jsnow@redhat.com>
	<86874359-e26c-4974-c2ec-bbc4e8ade264@redhat.com>
	<d9592097-39f1-86f3-7a34-cb82b3025147@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <a11d4660-af0a-26dc-abf2-65bd4e050ae7@redhat.com>
Date: Fri, 31 Aug 2018 11:06:53 +0200
MIME-Version: 1.0
In-Reply-To: <d9592097-39f1-86f3-7a34-cb82b3025147@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="fyzBxhN9mjpJtb3PpjzIInAnnIaslGX2c"
Subject: Re: [Qemu-devel] [PATCH v2 1/9] jobs: change start callback to run
 callback
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
--fyzBxhN9mjpJtb3PpjzIInAnnIaslGX2c
From: Max Reitz <mreitz@redhat.com>
To: John Snow <jsnow@redhat.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, Stefan Hajnoczi <stefanha@redhat.com>, jtc@redhat.com,
 Jeff Cody <jcody@redhat.com>
Message-ID: <a11d4660-af0a-26dc-abf2-65bd4e050ae7@redhat.com>
Subject: Re: [PATCH v2 1/9] jobs: change start callback to run callback
References: <20180823220856.10094-1-jsnow@redhat.com>
 <20180823220856.10094-2-jsnow@redhat.com>
 <86874359-e26c-4974-c2ec-bbc4e8ade264@redhat.com>
 <d9592097-39f1-86f3-7a34-cb82b3025147@redhat.com>
In-Reply-To: <d9592097-39f1-86f3-7a34-cb82b3025147@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2018-08-30 02:06, John Snow wrote:
>=20
>=20
> On 08/27/2018 05:30 AM, Max Reitz wrote:
>> On 2018-08-24 00:08, John Snow wrote:
>>> Presently we codify the entry point for a job as the "start" callback=
,
>>> but a more apt name would be "run" to clarify the idea that when this=

>>> function returns we consider the job to have "finished," except for
>>> any cleanup which occurs in separate callbacks later.
>>>
>>> As part of this clarification, change the signature to include an err=
or
>>> object and a return code. The error ptr is not yet used, and the retu=
rn
>>> code while captured, will be overwritten by actions in the job_comple=
ted
>>> function.
>>>
>>> Signed-off-by: John Snow <jsnow@redhat.com>
>>> ---
>>>  block/backup.c            |  7 ++++---
>>>  block/commit.c            |  7 ++++---
>>>  block/create.c            |  8 +++++---
>>>  block/mirror.c            | 10 ++++++----
>>>  block/stream.c            |  7 ++++---
>>>  include/qemu/job.h        |  2 +-
>>>  job.c                     |  6 +++---
>>>  tests/test-bdrv-drain.c   |  7 ++++---
>>>  tests/test-blockjob-txn.c | 16 ++++++++--------
>>>  tests/test-blockjob.c     |  7 ++++---
>>>  10 files changed, 43 insertions(+), 34 deletions(-)
>>
>> Reviewed-by: Max Reitz <mreitz@redhat.com>
>>
>> But I see a discrepancy in the upcoming s->ret <=3D> s->err relationsh=
ip
>> now.  And that is if .run() doesn't return an Error *...
>>
>> That could be remedied immediately in job_co_entry(), though, either b=
y
>> calling job_update_rc(), or by inlining its "if (!job->err)" part.
>>
>> Max
>>
>=20
> Jobs currently exist in ... five-ish phases.
>=20
> Phase 0: Not started. (Always UNDEFINED or CREATED.)
> Phase 1: In the coroutine. (RUNNING, READY, STANDBY, PAUSED.)
> Phase 2: Deferred to main, but job_completed not yet called. [Not
> dignified with a formal status, but job->deferred_to_main_loop set.]
> Phase 3: job_completed has been called. (ABORTING, WAITING, PENDING)
> Phase 4: job_finalize_single has been called. (CONCLUDED, NULL)
>=20
> Broadly, though, we separate these out into two main clusters:
>=20
> (A): job_is_completed =3D=3D FALSE; Phases 0, 1 and 2 above.
> (B): job_is_completed =3D=3D TRUE; Phases 3 and 4 above.
>=20
> The ABORTING status as it exists now is a phase 3 status. It never gets=

> set before this call, so it is a reliable indicator of being in phase 3=
=2E
>=20
> If I adjust the usage of job_update_rc like you asked in several
> reviews, it changes it to being a status that can exist in either Phase=

> 2 *or* 3, which complicates the code a bit as it requires an audit of
> every caller to job_is_completed and replacing it with something more
> appropriate. Worse, we have no way to identify phase 2 anymore without
> adding a new status or a new boolean.
>=20
> I think this is a change worth making, but I must beg to defer this
> change for a later patchset for the time-being, and leave the
> job_update_rc calls alone for the present patchset so I can focus on
> more pressing matters.
>=20
> It might be simplest to say that at CONCLUDED time, the "err iff ret"
> relationship will be true but potentially not before then. I think this=

> is reasonable as the error code cannot be held to be final until, well,=

> the job has finished.

It's OK making the change at a later point.

Maybe it would make more sense to pull out the
"set @err if @ret && !@err" part from job_update_rc() into an own
function, and then call that every time @ret has been updated.  (And
call the rest of the function, which does a possible state transition,
only where that makes sense.)

Max


--fyzBxhN9mjpJtb3PpjzIInAnnIaslGX2c
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAluJBS0ACgkQ9AfbAGHV
z0CSpAgAoHk7zJT55MMOm7EX5LdgFSHZJUt6mXHfcwXZCfHkruP/WzKNu+fcFML5
U8mjn3wSEFaAfAoK3uBXdSDbLFWoCuWlkAmG+2YHRkKAE5z6VKQVdscyQQOeNJk6
u/fwUBQlZBrwJSLWnBYvnMjBAedDoROhOIURJTlHcmzyWXs2ETXg3O3qcuDzxzhY
kc4HUxQU2oHSjyRrSebt6FmNtLgT3rgmCsXU3gQXZ1K2cCfOKheVNuiwa/EU5xhR
FBWIjX5mTfyZWDG1Vv0FXpaPFUrMQEDN38WT7DBqp+rie4KvJdWwFOjWvY3ZbvbK
JgBMXcEcmKwNvL/nuTCweA4upOEFGA==
=tayG
-----END PGP SIGNATURE-----

--fyzBxhN9mjpJtb3PpjzIInAnnIaslGX2c--
