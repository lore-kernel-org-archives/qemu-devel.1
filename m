Received: from eggs.gnu.org ([2001:4830:134:3::10]:37022)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fNdmC-0003h1-IC
	for qemu-devel@nongnu.org; Tue, 29 May 2018 08:30:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fNdmB-0005uF-Do
	for qemu-devel@nongnu.org; Tue, 29 May 2018 08:30:56 -0400
References: <20180518132114.4070-1-kwolf@redhat.com>
	<20180518132114.4070-22-kwolf@redhat.com>
	<26778cd3-3150-734b-d8c6-afa6e41f0215@redhat.com>
	<20180524082412.GC4008@localhost.localdomain>
	<1988292d-467a-9c63-e64d-035b0e93348a@redhat.com>
	<20180525080035.GA5562@localhost.localdomain>
	<20180529115907.GA1933@paraplu>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <e380991d-dab8-1923-fb03-bab40e489f1f@redhat.com>
Date: Tue, 29 May 2018 14:30:47 +0200
MIME-Version: 1.0
In-Reply-To: <20180529115907.GA1933@paraplu>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="999OCwumA6NH06fs8825xMybLGi9tz4hr"
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH v2 21/40] job: Convert
 block_job_cancel_async() to Job
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kashyap Chamarthy <kchamart@redhat.com>, Kevin Wolf <kwolf@redhat.com>
Cc: John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org, armbru@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--999OCwumA6NH06fs8825xMybLGi9tz4hr
From: Max Reitz <mreitz@redhat.com>
To: Kashyap Chamarthy <kchamart@redhat.com>, Kevin Wolf <kwolf@redhat.com>
Cc: John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org,
 qemu-block@nongnu.org, armbru@redhat.com
Message-ID: <e380991d-dab8-1923-fb03-bab40e489f1f@redhat.com>
Subject: Re: [Qemu-block] [Qemu-devel] [PATCH v2 21/40] job: Convert
 block_job_cancel_async() to Job
References: <20180518132114.4070-1-kwolf@redhat.com>
 <20180518132114.4070-22-kwolf@redhat.com>
 <26778cd3-3150-734b-d8c6-afa6e41f0215@redhat.com>
 <20180524082412.GC4008@localhost.localdomain>
 <1988292d-467a-9c63-e64d-035b0e93348a@redhat.com>
 <20180525080035.GA5562@localhost.localdomain> <20180529115907.GA1933@paraplu>
In-Reply-To: <20180529115907.GA1933@paraplu>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2018-05-29 13:59, Kashyap Chamarthy wrote:
> On Fri, May 25, 2018 at 10:00:35AM +0200, Kevin Wolf wrote:
>> Am 24.05.2018 um 19:42 hat John Snow geschrieben:
>=20
> [...]
>=20
> (Randomly chiming in for a small clarification.)
>=20
>>>>> or some other mechanism that accomplishes the same type of behavior=
=2E It
>>>>> would be nice if it did not have to be determined at job creation t=
ime
>>>>> but instead could be determined later.
>>>>
>>>> I agree. We already made sure that job-cancel really means cancel on=
 the
>>>> QAPI level, so we're free to do that. We just need to keep supportin=
g
>>>> block-job-cancel with the old semantics, so what I have is the easy
>>>> conversion. We can change the internal implementation when we actual=
ly
>>>> implement the selection of a completion mode.
>>>>
>>>> Kevin
>>>>
>>>
>>> We need this before 3.0 though, yeah? unless we make job-cancel
>>> x-job-cancel or some other warning that the way it works might change=
, yeah?
>>>
>>> Or do I misunderstand our leeway to change this at a later point in t=
ime?
>>>
>>> (can job-cancel apply to block jobs created with the legacy
>>> infrastructure? My reading was "yes.")
>>
>> It can, and it already has its final semantics, so nothing has to chan=
ge
>> before 3.0. job-cancel is equivalent to block-job-cancel with fixed
>> force=3Dtrue. If you want the complete-by-cancel behaviour of mirror, =
you
>> have to use block-job-cancel for now, because job-cancel doesn't provi=
de
>> that functionality.
>=20
> I think by "complete-by-cancel" you are referring to this[*] magic
> behaviour, mentioned in the last sentence here:
>=20
>     When you cancel an in-progress =E2=80=98mirror=E2=80=99 job before =
the source and
>     target are synchronized, block-job-cancel will emit the event
>     BLOCK_JOB_CANCELLED. However, note that if you cancel a =E2=80=98mi=
rror=E2=80=99 job
>     after it has indicated (via the event BLOCK_JOB_READY) that the
>     source and target have reached synchronization, then the event
>     emitted by block-job-cancel changes to BLOCK_JOB_COMPLETED.
>=20
>=20
> [*] https://git.qemu.org/?p=3Dqemu.git;a=3Dblob;f=3Ddocs/interop/live-b=
lock-operations.rst#l515
>=20
>> So what we can change later is adding a way to initiate this secondary=

>> completion mode with a job-* command (probably with a new option for
>> job-complete). But we wouldn't change the semantics of exisiting
>> commands.
>=20
> Ah, so if I'm understanding it correctly, the existing subtle magic of
> "complete-by-cancel" will be rectified by separting the two distinct
> operations: 'job-cancel' and 'job-complete'.

Not really, because we already had those two operations for block jobs.
The thing is that block-job-complete (and thus job-complete) will pivot
to the target disk, but block-job-cancel doesn't.

The special behavior is that you can use block-job-cancel after
BLOCK_JOB_READY to complete the job, but not pivot to it.  I don't think
we have a real plan on how to represent that with the generic job
commands, we just know that we don't want to use job-cancel.

(Maybe we can add a flag to job-complete (which to me does not sound
like a good idea), or you could set flags on jobs while they are
running, so you can set a do-not-pivot flag on the mirror job before you
complete it.)

Max


--999OCwumA6NH06fs8825xMybLGi9tz4hr
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlsNR/cACgkQ9AfbAGHV
z0C21Af/enXMvuhj3BrWOOB3JVkTrBw5nRdpEAJ+Q4oLyVBPmrhk+h8Vj79tJnmJ
wFxV1yFtEjcxJNLzObtk956hrnNrmbs+mLaSnE+LtIyEW6Ltlf+ytbneK9zc1zXg
WMFPUlghiSJYnlUwNppasdEJrVIn07A0c979hKGsjmBWMHe2UY5XoA9OdIi9iZba
sa4ExQ/1R7/wH6fLBE/Nvw6qUlIgkzEGLIGekIp9Dwmek+NzKoamATlWK0kl54dT
uiN6H+Jf7i7EqbALL9WrRh2luvqEGs810Rdn33vmMmsvkr9LNRf41ggPdfd0xLbX
qGOabDPWSpbQ6uf4MbKtBmW/39jiQQ==
=f4fy
-----END PGP SIGNATURE-----

--999OCwumA6NH06fs8825xMybLGi9tz4hr--
