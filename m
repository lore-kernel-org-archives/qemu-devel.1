Received: from eggs.gnu.org ([2001:4830:134:3::10]:48872)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fIu4k-0004eP-EF
	for qemu-devel@nongnu.org; Wed, 16 May 2018 06:54:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fIu4j-0007kR-C2
	for qemu-devel@nongnu.org; Wed, 16 May 2018 06:54:30 -0400
References: <20180509162637.15575-1-kwolf@redhat.com>
	<20180509162637.15575-40-kwolf@redhat.com>
	<1212f284-2af7-e586-ec95-18e77a53d13a@redhat.com>
	<20180515140850.GE4442@localhost.localdomain>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <fb9ae66c-cf35-144c-0acd-0d27558845f3@redhat.com>
Date: Wed, 16 May 2018 12:54:17 +0200
MIME-Version: 1.0
In-Reply-To: <20180515140850.GE4442@localhost.localdomain>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="YrnLOUu4WhZGWJUrewRZfKw4tFO3k23cp"
Subject: Re: [Qemu-devel] [PATCH 39/42] job: Add lifecycle QMP commands
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org, eblake@redhat.com, jsnow@redhat.com, armbru@redhat.com, jcody@redhat.com, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--YrnLOUu4WhZGWJUrewRZfKw4tFO3k23cp
From: Max Reitz <mreitz@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org, eblake@redhat.com, jsnow@redhat.com,
 armbru@redhat.com, jcody@redhat.com, qemu-devel@nongnu.org
Message-ID: <fb9ae66c-cf35-144c-0acd-0d27558845f3@redhat.com>
Subject: Re: [PATCH 39/42] job: Add lifecycle QMP commands
References: <20180509162637.15575-1-kwolf@redhat.com>
 <20180509162637.15575-40-kwolf@redhat.com>
 <1212f284-2af7-e586-ec95-18e77a53d13a@redhat.com>
 <20180515140850.GE4442@localhost.localdomain>
In-Reply-To: <20180515140850.GE4442@localhost.localdomain>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

On 2018-05-15 16:08, Kevin Wolf wrote:
> Am 15.05.2018 um 00:31 hat Max Reitz geschrieben:
>> On 2018-05-09 18:26, Kevin Wolf wrote:
>>> This adds QMP commands that control the transition between states of =
the
>>> job lifecycle.
>>>
>>> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
>>> ---
>>>  qapi/job.json | 112 ++++++++++++++++++++++++++++++++++++++++++++++
>>>  job-qmp.c     | 140 ++++++++++++++++++++++++++++++++++++++++++++++++=
++++++++++
>>>  MAINTAINERS   |   1 +
>>>  Makefile.objs |   2 +-
>>>  trace-events  |   9 ++++
>>>  5 files changed, 263 insertions(+), 1 deletion(-)
>>>  create mode 100644 job-qmp.c
>>>
>>> diff --git a/qapi/job.json b/qapi/job.json
>>> index bd88a358d0..7b84158292 100644
>>> --- a/qapi/job.json
>>> +++ b/qapi/job.json
>>> @@ -63,3 +63,115 @@
>>>  { 'event': 'JOB_STATUS_CHANGE',
>>>    'data': { 'id': 'str',
>>>              'status': 'JobStatus' } }
>>> +
>>> +##
>>> +# @job-pause:
>>> +#
>>> +# Pause an active job.
>>> +#
>>> +# This command returns immediately after marking the active job for =
pausing.
>>> +# Pausing an already paused job has no cumulative effect; a single j=
ob-resume
>>> +# command will resume the job.
>>
>> Pausing an already paused job is, in fact, an error.
>>
>> (Which should be noted here instead of making it appear like it'd be
>> idempotent.)
>=20
> Aye. Interestingly, I managed to fix it below in job-resume, but missed=

> it here. I should also stick in a patch somewhere early in the series
> that fixes the documentation of block-job-pause/resume.
>=20
>>> +##
>>> +# @job-cancel:
>>> +#
>>> +# Instruct an active background job to cancel at the next opportunit=
y.
>>> +# This command returns immediately after marking the active job for
>>> +# cancellation.
>>> +#
>>> +# The job will cancel as soon as possible and then emit a JOB_STATUS=
_CHANGE
>>> +# event. Usually, the status will change to ABORTING, but it is poss=
ible that
>>> +# a job successfully completes (e.g. because it was almost done and =
there was
>>> +# no opportunity to cancel earlier than completing the job) and tran=
sitions to
>>> +# PENDING instead.
>>> +#
>>> +# Note that if you issue 'job-cancel' after a mirror block job has i=
ndicated
>>> +# (via the event BLOCK_JOB_READY, and by transitioning into the READ=
Y state)
>>> +# that the source and destination are synchronized, then the job alw=
ays
>>> +# completes successfully and transitions to PENDING as well as trigg=
ering the
>>> +# event BLOCK_JOB_COMPLETED, to indicate that the mirroring has ende=
d and the
>>> +# destination now has a point-in-time copy tied to the time of the
>>> +# cancellation.
>>> +#
>>> +# @id: The job identifier.
>>> +#
>>> +# @force: If true, and the job is already in the READY state, abando=
n the job
>>> +#         immediately (even if it is paused) instead of waiting for =
the
>>> +#         destination to complete its final synchronization
>>
>> The note on "final synchronization" is extremely mirror-specific.  I s=
ee
>> three choices here:
>>
>> (1) If mirror stays the only job with this special cancel semantics,
>> then we are free to note that this is a mirror-specific flag here.
>>
>> (2) Even if some other job might come along at some point where use of=

>> @force may make sense, that doesn't stop us from now noting that only
>> mirror supports this, which helps readers understand what "destination=
"
>> and "final synchronization" mean.
>>
>> (Yes, so (1) and (2) are basically the same.)
>>
>> (3) We try to find some general description and drop the last part.
>> Like "If a job would normally decide to complete instead of actually
>> aborting, this flag can be used to convince it otherwise."  But that's=

>> so handwavy, I'd rather just mark it as a special mirror flag for now.=

>=20
> Or how about this one?
>=20
> (4) Mirror is really abusing cancel for a second completion mode and we=

>     don't want to have this kind of ugliness in job-cancel.

Yeah, well, right, that was implicit and I tried to be more diplomatic
by calling it "special semantics". :-)

>                                                             Remove
>     @force from the schema and internally always use force=3Dtrue. For
>     now, block-job-cancel does the job (no pun intended) for mirror, an=
d
>     maybe we can later introduce a way to select completion mode with
>     job-complete.

Sounds good to me.

> This would also get us rid of that whole long paragraph above that
> explains how mirror jobs have an exceptional behaviour.

Yes.

Max

>>> diff --git a/Makefile.objs b/Makefile.objs
>>> index 3df8d58e49..253e0356f3 100644
>>> --- a/Makefile.objs
>>> +++ b/Makefile.objs
>>> @@ -66,7 +66,7 @@ chardev-obj-y =3D chardev/
>>>  # block-obj-y is code used by both qemu system emulation and qemu-im=
g
>>> =20
>>>  block-obj-y +=3D nbd/
>>> -block-obj-y +=3D block.o blockjob.o job.o
>>> +block-obj-y +=3D block.o blockjob.o job.o job-qmp.o
>>
>> Shouldn't this be in common-obj-y like blockdev?
>=20
> Seems to build with that change, so it can't be wrong...
>=20
> Kevin
>=20



--YrnLOUu4WhZGWJUrewRZfKw4tFO3k23cp
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlr8DdkACgkQ9AfbAGHV
z0AM9Af9Hh4AbwcGBt8yNYjoVyl+h90gJDjFilPdjSK2gQEj31FK8lUV0DerCntj
BoNiB83cQIAE6ZOPKVGD9UhSr/d1x8YQWrpFdNHmdaO7OtpFxPUKVrQxLZR3r6Aq
5Oqz+Vnd88ZqzWmkVpQvaH6S/PALKJLMsmsL2bzI448DOOtwMM1zSn8jhYU6918Q
Hp968G+XPmauzvWAIfh0pD+yunma1QzfGxPId0kg7Q58M9neLa+1wsVG8S5k3V9z
zqe2dzd3SgrU4hX0JUrbwoQrfQekFPAgRCdA1Rq6qGh4kVYRnkeG8al9XhTdTbG+
MQIThuti0g3nU4Kk2WxNE5XFJ5WeEQ==
=b1wG
-----END PGP SIGNATURE-----

--YrnLOUu4WhZGWJUrewRZfKw4tFO3k23cp--
