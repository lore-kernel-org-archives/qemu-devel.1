Received: from eggs.gnu.org ([2001:4830:134:3::10]:44759)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fuvrV-0006UX-8I
	for qemu-devel@nongnu.org; Wed, 29 Aug 2018 04:30:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fuvee-00012e-ID
	for qemu-devel@nongnu.org; Wed, 29 Aug 2018 04:16:45 -0400
References: <20180817190457.8292-1-jsnow@redhat.com>
	<20180817190457.8292-4-jsnow@redhat.com>
	<7c836fb4-c6f4-b590-11ef-6aadb8bc169a@redhat.com>
	<b576a1a9-ac22-599f-665f-8559e8a9faf1@redhat.com>
	<c76b3fc9-e6a9-4e0b-7607-f0bbcef30234@redhat.com>
	<2535fb2a-7079-f6cc-88d6-e25780691b7f@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <050a91d3-8b64-fe69-4f96-a21e7ba89c68@redhat.com>
Date: Wed, 29 Aug 2018 10:16:30 +0200
MIME-Version: 1.0
In-Reply-To: <2535fb2a-7079-f6cc-88d6-e25780691b7f@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="7tBJBN8nZKUhxTJU0Hmr20wQl7Lgu1f6j"
Subject: Re: [Qemu-devel] [PATCH 3/7] jobs: add exit shim
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Snow <jsnow@redhat.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, Jeff Cody <jcody@redhat.com>, jtc@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--7tBJBN8nZKUhxTJU0Hmr20wQl7Lgu1f6j
From: Max Reitz <mreitz@redhat.com>
To: John Snow <jsnow@redhat.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, Jeff Cody <jcody@redhat.com>, jtc@redhat.com
Message-ID: <050a91d3-8b64-fe69-4f96-a21e7ba89c68@redhat.com>
Subject: Re: [PATCH 3/7] jobs: add exit shim
References: <20180817190457.8292-1-jsnow@redhat.com>
 <20180817190457.8292-4-jsnow@redhat.com>
 <7c836fb4-c6f4-b590-11ef-6aadb8bc169a@redhat.com>
 <b576a1a9-ac22-599f-665f-8559e8a9faf1@redhat.com>
 <c76b3fc9-e6a9-4e0b-7607-f0bbcef30234@redhat.com>
 <2535fb2a-7079-f6cc-88d6-e25780691b7f@redhat.com>
In-Reply-To: <2535fb2a-7079-f6cc-88d6-e25780691b7f@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2018-08-27 17:54, John Snow wrote:
>=20
>=20
> On 08/25/2018 09:05 AM, Max Reitz wrote:
>> On 2018-08-22 23:52, John Snow wrote:
>>>
>>>
>>> On 08/22/2018 07:43 AM, Max Reitz wrote:
>>>> On 2018-08-17 21:04, John Snow wrote:
>>>>> All jobs do the same thing when they leave their running loop:
>>>>> - Store the return code in a structure
>>>>> - wait to receive this structure in the main thread
>>>>> - signal job completion via job_completed
>>>>>
>>>>> Few jobs do anything beyond exactly this. Consolidate this exit
>>>>> logic for a net reduction in SLOC.
>>>>>
>>>>> More seriously, when we utilize job_defer_to_main_loop_bh to call
>>>>> a function that calls job_completed, job_finalize_single will run
>>>>> in a context where it has recursively taken the aio_context lock,
>>>>> which can cause hangs if it puts down a reference that causes a flu=
sh.
>>>>>
>>>>> You can observe this in practice by looking at mirror_exit's carefu=
l
>>>>> placement of job_completed and bdrv_unref calls.
>>>>>
>>>>> If we centralize job exiting, we can signal job completion from out=
side
>>>>> of the aio_context, which should allow for job cleanup code to run =
with
>>>>> only one lock, which makes cleanup callbacks less tricky to write.
>>>>>
>>>>> Signed-off-by: John Snow <jsnow@redhat.com>
>>>>> ---
>>>>>  include/qemu/job.h |  7 +++++++
>>>>>  job.c              | 19 +++++++++++++++++++
>>>>>  2 files changed, 26 insertions(+)
>>>>
>>>> Currently all jobs do this, the question of course is why.  The answ=
er
>>>> is because they are block jobs that need to do some graph manipulati=
on
>>>> in the main thread, right?
>>>>
>>>
>>> Yep.
>>>
>>>> OK, that's reasonable enough, that sounds like even non-block jobs m=
ay
>>>> need this (i.e. modify some global qemu state that you can only do i=
n
>>>> the main loop).  Interestingly, the create job only calls
>>>> job_completed() of which it says nowhere that it needs to be execute=
d in
>>>> the main loop.
>>>>
>>>
>>> Yeah, not all jobs will have anything meaningful to do in the main lo=
op
>>> context. This is one of them.
>>>
>>>> ...on second thought, do we really want to execute job_complete() in=
 the
>>>> main loop?  First of all, all of the transactional functions will ru=
n in
>>>> the main loop.  Which makes sense, but it isn't noted anywhere.
>>>> Secondly, we may end up calling JobDriver.user_resume(), which is
>>>> probably not something we want to call in the main loop.
>>>>
>>>
>>> I think we need to execute job_complete in the main loop, or otherwis=
e
>>> restructure the code that can run between job_completed and
>>> job_finalize_single so that .prepare/.commit/.abort/.clean run in the=

>>> main thread, which is something we want to preserve.
>>
>> Sure.
>>
>>> It's simpler just to say that complete will run from the main thread,=

>>> like it does presently.
>>
>> Yes, but we don't say that.
>>
>>> Why would we not want to call user_resume from the main loop? That's
>>> directly where it's called from, since it gets invoked directly from =
the
>>> qmp thread.
>>
>> Hmm!  True indeed.
>>
>> The reason why we might not want to do it is because the job may not r=
un
>> in the main loop, so modifying the job (especially invoking a job
>> method) may be dangerous without taking precautions.
>>
>>>> OTOH, job_finish_sync() is something that has to be run in the main =
loop
>>>> because it polls the main loop (and as far as my FUSE experiments ha=
ve
>>>> told me, polling a foreign AioContext doesn't work).
>>>>
>>>> So...  I suppose it would be nice if we had a real distinction which=

>>>> functions are run in which AioContext.  It seems like we indeed want=
 to
>>>> run job_completed() in the main loop, but what to do about the
>>>> user_resume() call in job_cancel_async()?
>>>>
>>>
>>> I don't think we need to do anything -- at least, these functions
>>> *already* run from the main loop.
>>
>> Yeah, but we don't mark that anywhere.  I really don't like that.  Job=
s
>> need to know which of their functions are run in which AioContext.
>>
>>> mirror_exit et al get scheduled from job_defer_to_main_loop and call
>>> job_completed there, so it's already always done from the main loop; =
I'm
>>> just cutting out the part where the jobs have to manually schedule th=
is.
>>
>> I'm not saying what you're doing is wrong, I'm just saying tracking
>> which things are running in which context is not easy because there ar=
e
>> no comments on how it's supposed to be run.  (Apart from your new
>> .exit() method which does say that it's run in the main loop.)
>>
>> No, I don't find it obvious which functions are run in which context
>> when first I have to think about in which context those functions are
>> used (e.g. user_resume is usually the result of a QMP command, so it's=

>> run in the main loop; the transactional methods are part of completion=
,
>> which is done in the main loop, so they are also called in the main
>> loop; and so on).
>>
>> But that's not part of this series.  It just occurred to me when
>> tracking down which function belongs to which context when reviewing
>> this patch.
>>
>> Max
>>
>=20
> Oh, I see. I can mark up the functions I/we expect to run in the main
> thread with comments above the function implementation, would that help=
?

Sure, that's exactly what I mean. :-)

> Probably also a top level document would also help... We're overdue for=

> one after all the changes recently.

If you have the time, sure.

Max


--7tBJBN8nZKUhxTJU0Hmr20wQl7Lgu1f6j
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAluGVl4ACgkQ9AfbAGHV
z0CsmAf6A9fCWoMqnO0v42H8K8zLqMm6wJGrvaHfos/kp6EyHcunM4Pk4aalNMpZ
KAX+Z29K8uEBy22qvgZZFY1kKxcO3/fkNvLhVSwhIw0wdSUIsu949ZNpJuvY/eWy
oNeSdDZuvaZOoWCfPcz/TRbuMJLXPh+uRvTosdNOn5bq35Wd9Az7S6rD73jeQpVw
2woOcoVLVGL9xKMTYe4hDaH58KqWYHRonuSjrp1xYUmDYVN0BHWLorWb18CsxTba
WLfIGyUFO0YeIofrc+XFVgYd7qHKPTt79gIEhel/46faa77/vi5qyZpu86daO3iM
tro3bYvP0TeepBCqPWVq5Pzgf/DqUQ==
=IlUc
-----END PGP SIGNATURE-----

--7tBJBN8nZKUhxTJU0Hmr20wQl7Lgu1f6j--
