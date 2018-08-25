Received: from eggs.gnu.org ([2001:4830:134:3::10]:38794)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1ftYGP-0004Th-0Y
	for qemu-devel@nongnu.org; Sat, 25 Aug 2018 09:06:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1ftYGO-00016g-0Q
	for qemu-devel@nongnu.org; Sat, 25 Aug 2018 09:06:00 -0400
References: <20180817190457.8292-1-jsnow@redhat.com>
	<20180817190457.8292-4-jsnow@redhat.com>
	<7c836fb4-c6f4-b590-11ef-6aadb8bc169a@redhat.com>
	<b576a1a9-ac22-599f-665f-8559e8a9faf1@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <c76b3fc9-e6a9-4e0b-7607-f0bbcef30234@redhat.com>
Date: Sat, 25 Aug 2018 15:05:45 +0200
MIME-Version: 1.0
In-Reply-To: <b576a1a9-ac22-599f-665f-8559e8a9faf1@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="wB9CL32gAdB0IIHs9BOBOQg7o3s1YGtOI"
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
--wB9CL32gAdB0IIHs9BOBOQg7o3s1YGtOI
From: Max Reitz <mreitz@redhat.com>
To: John Snow <jsnow@redhat.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, Jeff Cody <jcody@redhat.com>, jtc@redhat.com
Message-ID: <c76b3fc9-e6a9-4e0b-7607-f0bbcef30234@redhat.com>
Subject: Re: [PATCH 3/7] jobs: add exit shim
References: <20180817190457.8292-1-jsnow@redhat.com>
 <20180817190457.8292-4-jsnow@redhat.com>
 <7c836fb4-c6f4-b590-11ef-6aadb8bc169a@redhat.com>
 <b576a1a9-ac22-599f-665f-8559e8a9faf1@redhat.com>
In-Reply-To: <b576a1a9-ac22-599f-665f-8559e8a9faf1@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2018-08-22 23:52, John Snow wrote:
>=20
>=20
> On 08/22/2018 07:43 AM, Max Reitz wrote:
>> On 2018-08-17 21:04, John Snow wrote:
>>> All jobs do the same thing when they leave their running loop:
>>> - Store the return code in a structure
>>> - wait to receive this structure in the main thread
>>> - signal job completion via job_completed
>>>
>>> Few jobs do anything beyond exactly this. Consolidate this exit
>>> logic for a net reduction in SLOC.
>>>
>>> More seriously, when we utilize job_defer_to_main_loop_bh to call
>>> a function that calls job_completed, job_finalize_single will run
>>> in a context where it has recursively taken the aio_context lock,
>>> which can cause hangs if it puts down a reference that causes a flush=
=2E
>>>
>>> You can observe this in practice by looking at mirror_exit's careful
>>> placement of job_completed and bdrv_unref calls.
>>>
>>> If we centralize job exiting, we can signal job completion from outsi=
de
>>> of the aio_context, which should allow for job cleanup code to run wi=
th
>>> only one lock, which makes cleanup callbacks less tricky to write.
>>>
>>> Signed-off-by: John Snow <jsnow@redhat.com>
>>> ---
>>>  include/qemu/job.h |  7 +++++++
>>>  job.c              | 19 +++++++++++++++++++
>>>  2 files changed, 26 insertions(+)
>>
>> Currently all jobs do this, the question of course is why.  The answer=

>> is because they are block jobs that need to do some graph manipulation=

>> in the main thread, right?
>>
>=20
> Yep.
>=20
>> OK, that's reasonable enough, that sounds like even non-block jobs may=

>> need this (i.e. modify some global qemu state that you can only do in
>> the main loop).  Interestingly, the create job only calls
>> job_completed() of which it says nowhere that it needs to be executed =
in
>> the main loop.
>>
>=20
> Yeah, not all jobs will have anything meaningful to do in the main loop=

> context. This is one of them.
>=20
>> ...on second thought, do we really want to execute job_complete() in t=
he
>> main loop?  First of all, all of the transactional functions will run =
in
>> the main loop.  Which makes sense, but it isn't noted anywhere.
>> Secondly, we may end up calling JobDriver.user_resume(), which is
>> probably not something we want to call in the main loop.
>>
>=20
> I think we need to execute job_complete in the main loop, or otherwise
> restructure the code that can run between job_completed and
> job_finalize_single so that .prepare/.commit/.abort/.clean run in the
> main thread, which is something we want to preserve.

Sure.

> It's simpler just to say that complete will run from the main thread,
> like it does presently.

Yes, but we don't say that.

> Why would we not want to call user_resume from the main loop? That's
> directly where it's called from, since it gets invoked directly from th=
e
> qmp thread.

Hmm!  True indeed.

The reason why we might not want to do it is because the job may not run
in the main loop, so modifying the job (especially invoking a job
method) may be dangerous without taking precautions.

>> OTOH, job_finish_sync() is something that has to be run in the main lo=
op
>> because it polls the main loop (and as far as my FUSE experiments have=

>> told me, polling a foreign AioContext doesn't work).
>>
>> So...  I suppose it would be nice if we had a real distinction which
>> functions are run in which AioContext.  It seems like we indeed want t=
o
>> run job_completed() in the main loop, but what to do about the
>> user_resume() call in job_cancel_async()?
>>
>=20
> I don't think we need to do anything -- at least, these functions
> *already* run from the main loop.

Yeah, but we don't mark that anywhere.  I really don't like that.  Jobs
need to know which of their functions are run in which AioContext.

> mirror_exit et al get scheduled from job_defer_to_main_loop and call
> job_completed there, so it's already always done from the main loop; I'=
m
> just cutting out the part where the jobs have to manually schedule this=
=2E

I'm not saying what you're doing is wrong, I'm just saying tracking
which things are running in which context is not easy because there are
no comments on how it's supposed to be run.  (Apart from your new
=2Eexit() method which does say that it's run in the main loop.)

No, I don't find it obvious which functions are run in which context
when first I have to think about in which context those functions are
used (e.g. user_resume is usually the result of a QMP command, so it's
run in the main loop; the transactional methods are part of completion,
which is done in the main loop, so they are also called in the main
loop; and so on).

But that's not part of this series.  It just occurred to me when
tracking down which function belongs to which context when reviewing
this patch.

Max


--wB9CL32gAdB0IIHs9BOBOQg7o3s1YGtOI
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAluBVCkACgkQ9AfbAGHV
z0DYIAf+Lb3xqTOg6pPWS07RbPycXJtTnfi//OLKwpQD1IZ599X9EN3oW3FNBG/s
ZpCW7iXcGmXh+ACSfDGv8NjH3Oy1xHexB2/FDxTs4nYHvSgAPrT98JpsAwoj0zvP
p3lcaYCyMOk5Z35MX/5eR8rgynsAKjYvKT1MLAnqpRzRKJyOnUSgI/FV/I9iCvRp
o8jtoBVtkV5qhfWl9leHP6M7Vi9kLW/akE/EQyEoiqxbHVaP+/QCOHX6dXt2AsoR
8RrBZD/rY0/tu+hFuBH6s/6fhGFRq2HjFRLK+Tki1tAUhcH76q39YvkLgWVudDB2
r89x7DScwFC561jY9xnw4pMean/ofQ==
=330t
-----END PGP SIGNATURE-----

--wB9CL32gAdB0IIHs9BOBOQg7o3s1YGtOI--
