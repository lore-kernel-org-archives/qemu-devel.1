Received: from eggs.gnu.org ([2001:4830:134:3::10]:48367)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fIu1i-0002sz-6K
	for qemu-devel@nongnu.org; Wed, 16 May 2018 06:51:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fIu1g-0006vq-T3
	for qemu-devel@nongnu.org; Wed, 16 May 2018 06:51:22 -0400
References: <20180509162637.15575-1-kwolf@redhat.com>
	<20180509162637.15575-18-kwolf@redhat.com>
	<65bf7408-bdd9-6a7d-6c77-318715a4cc59@redhat.com>
	<20180515121725.GB4442@localhost.localdomain>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <1cfc121c-c258-dceb-5aeb-189c1b08346b@redhat.com>
Date: Wed, 16 May 2018 12:51:09 +0200
MIME-Version: 1.0
In-Reply-To: <20180515121725.GB4442@localhost.localdomain>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="7rjpjV34yZA7LiFO5sFz0917NPso3KQH2"
Subject: Re: [Qemu-devel] [PATCH 17/42] job: Move defer_to_main_loop to Job
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org, eblake@redhat.com, jsnow@redhat.com, armbru@redhat.com, jcody@redhat.com, qemu-devel@nongnu.org, stefanha@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--7rjpjV34yZA7LiFO5sFz0917NPso3KQH2
From: Max Reitz <mreitz@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org, eblake@redhat.com, jsnow@redhat.com,
 armbru@redhat.com, jcody@redhat.com, qemu-devel@nongnu.org,
 stefanha@redhat.com
Message-ID: <1cfc121c-c258-dceb-5aeb-189c1b08346b@redhat.com>
Subject: Re: [PATCH 17/42] job: Move defer_to_main_loop to Job
References: <20180509162637.15575-1-kwolf@redhat.com>
 <20180509162637.15575-18-kwolf@redhat.com>
 <65bf7408-bdd9-6a7d-6c77-318715a4cc59@redhat.com>
 <20180515121725.GB4442@localhost.localdomain>
In-Reply-To: <20180515121725.GB4442@localhost.localdomain>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

On 2018-05-15 14:17, Kevin Wolf wrote:
> Am 14.05.2018 um 17:52 hat Max Reitz geschrieben:
>> On 2018-05-09 18:26, Kevin Wolf wrote:
>>> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
>>> ---
>>>  include/block/blockjob.h     |  5 ----
>>>  include/block/blockjob_int.h | 19 ---------------
>>>  include/qemu/job.h           | 20 ++++++++++++++++
>>>  block/backup.c               |  7 +++---
>>>  block/commit.c               | 11 +++++----
>>>  block/mirror.c               | 15 ++++++------
>>>  block/stream.c               | 14 +++++------
>>>  blockjob.c                   | 57 ++++------------------------------=
----------
>>>  job.c                        | 33 +++++++++++++++++++++++++
>>>  tests/test-bdrv-drain.c      |  7 +++---
>>>  tests/test-blockjob-txn.c    | 13 +++++-----
>>>  tests/test-blockjob.c        |  7 +++---
>>>  12 files changed, 98 insertions(+), 110 deletions(-)
>>
>> [...]
>>
>>> diff --git a/block/commit.c b/block/commit.c
>>> index 85baea8f92..d326766e4d 100644
>>> --- a/block/commit.c
>>> +++ b/block/commit.c
>>> @@ -72,9 +72,10 @@ typedef struct {
>>>      int ret;
>>>  } CommitCompleteData;
>>> =20
>>> -static void commit_complete(BlockJob *job, void *opaque)
>>> +static void commit_complete(Job *job, void *opaque)
>>>  {
>>> -    CommitBlockJob *s =3D container_of(job, CommitBlockJob, common);=

>>> +    CommitBlockJob *s =3D container_of(job, CommitBlockJob, common.j=
ob);
>>
>> Now this is just abuse.
>>
>> ...but it's not the first time someone packs two container_of() into
>> one, it appears.  So, whatever, I guess.
>=20
> I don't think it's abuse. Why wouldn't I directly cast to the type that=

> I really want instead of casting to each of the uninteresting parent
> classes, too?

Because the final parameter is called "member" and not "path". :-)

>>> @@ -170,3 +171,35 @@ void job_unref(Job *job)
>>>          g_free(job);
>>>      }
>>>  }
>>> +
>>> +typedef struct {
>>> +    Job *job;
>>> +    JobDeferToMainLoopFn *fn;
>>> +    void *opaque;
>>> +} JobDeferToMainLoopData;
>>> +
>>> +static void job_defer_to_main_loop_bh(void *opaque)
>>> +{
>>> +    JobDeferToMainLoopData *data =3D opaque;
>>> +    Job *job =3D data->job;
>>> +    AioContext *aio_context =3D job->aio_context;
>>> +
>>> +    /* Prevent race with job_defer_to_main_loop() */
>>> +    aio_context_acquire(aio_context);
>>
>> I don't have a good feeling about this.  The original code had this
>> comment above an aio_context_acquire() for a context that might
>> decidedly not have anything to do with the BB's context;
>> block_job_defer_to_main_loop()'s description was that it would acquire=

>> the latter, so why did it acquire the former at all?
>>
>> We wouldn't need this comment here at all, because acquiring this
>> AioContext is part of the interface.  That's why I don't have a good
>> feeling.
>=20
> To be honest, I don't fully understand what the old code was trying to
> do or what race it was talking about, because I don't see any potential=

> race with job_defer_to_main_loop() (neither in the old nor in the new
> code).
>=20
> My suspicion is that Stefan solved the race that you reported [1] (and
> which was not with job_defer_to_main_loop(), but with random code that
> runs between that and the BH) just by adding some more code that made
> the scenario safe, but missed that this also made the existing code
> redundant. In other words, I think taking data->aio_context didn't serv=
e
> a purpose even in the old code.

Possible, yes.

Also seems more likely than any of the explanations I tried to come up wi=
th.

> The only thing it could possibly protect is the access of data->job->bs=
,
> but that's not something that changes between job_defer_to_main_loop()
> and the execution of the BH.
>=20
> [1] https://lists.gnu.org/archive/html/qemu-devel/2014-10/msg00260.html=

>=20
>> The best explanation I can come up with is that the original code
>> acquired the AioContext both of the block device at the time of the BH=

>> (because that needs to be done), and at the time of
>> block_job_defer_to_main_loop() -- because the latter is probably the
>> context the block_job_defer_to_main_loop() call came from, so it shoul=
d
>> be (b)locked.
>>
>> But if that's the case, then the same should be done here.  The contex=
t
>> of the job may change between scheduling the BH and the BH being
>> executed, so we might lock a different context here than the one
>> job_defer_to_main_loop() ran in (i.e., job->aio_context at the time of=

>> job_defer_to_main_loop() running).  And maybe we should lock that old
>> context, too -- just like block_job_defer_to_main_loop_bh() did.
>=20
> Why should we lock the old context? We don't access anything protected
> by it. Even the data->job->bs access has gone away because we now have
> job->aio_context.

Because the old code did so and I don't know why. O:-)

Your explanation does make sense to me, though, so:

Reviewed-by: Max Reitz <mreitz@redhat.com>


--7rjpjV34yZA7LiFO5sFz0917NPso3KQH2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlr8DR0ACgkQ9AfbAGHV
z0BBBAgAl35aoEgrFfjXa5g6nEU0xRgVCSB+Uht2Wz+bGiNI+5dnxmgGHZIS0/z4
aBp7Vf0B6sfoj5/+npGB7JkPvLYsrmQ9jzm1aaoO3XHp/uMFcSn8gfBo0Fb9yCsT
y9BhERHyEfKck4YFzau1WJnRg4ScksMv0riGnybczAeIhaF8KMRrW5KiiU8VeAxB
QjcA2fVCzRkE/rAewHny8ZkVFbMPFvjHm1tTjAsMqLRkaNqelCkMD0+jpRaWtF6D
R8t3np/7RBQp5G88VLgQhIdW+1cRRHDeVe7xmR2q2cMBDFgA3XDOlByQUXLgg0w4
RenR8xFsVQEHYbUdmrhkQp2xcFzw6w==
=NGIQ
-----END PGP SIGNATURE-----

--7rjpjV34yZA7LiFO5sFz0917NPso3KQH2--
