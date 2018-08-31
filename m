Received: from eggs.gnu.org ([2001:4830:134:3::10]:54430)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <liam.merwick@oracle.com>) id 1fvjLd-0006yb-U4
	for qemu-devel@nongnu.org; Fri, 31 Aug 2018 09:20:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <liam.merwick@oracle.com>) id 1fvjLZ-0002Ad-Iz
	for qemu-devel@nongnu.org; Fri, 31 Aug 2018 09:20:25 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:38776)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <liam.merwick@oracle.com>)
	id 1fvjLZ-00026Z-8E
	for qemu-devel@nongnu.org; Fri, 31 Aug 2018 09:20:21 -0400
References: <1535644031-848-1-git-send-email-Liam.Merwick@oracle.com>
	<1535644031-848-3-git-send-email-Liam.Merwick@oracle.com>
	<83875cdc-3238-fafa-7c96-21d1df89b37a@redhat.com>
From: Liam Merwick <liam.merwick@oracle.com>
Message-ID: <dfbc9e95-70c5-fda3-a763-3aa276e1f5f3@oracle.com>
Date: Fri, 31 Aug 2018 14:22:04 +0100
MIME-Version: 1.0
In-Reply-To: <83875cdc-3238-fafa-7c96-21d1df89b37a@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 2/8] job: Fix off-by-one accesses to JobSTT
 and JobVerbTable
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org


On 30/08/18 19:34, Eric Blake wrote:
> On 08/30/2018 10:47 AM, Liam Merwick wrote:
>> In the array dereference of JobVerbTable[verb] in job_apply_verb()
>> the check of the index, verb, allows an overrun because an index
>> equal to the array size is permitted.
>>
>> Similarly, in the array dereference of JobSTT[s0][s1] with index s1
>> in job_state_transition(), an off-by-one overrun is possible.
>=20
> Fortunately, these are just assertions that are too weak; we don't have=
=20
> any actual callers passing the __MAX entry to cause an actual overrun.
>=20

True. In v2 I'll clarify that in the commit message

>>
>> Signed-off-by: Liam Merwick <Liam.Merwick@oracle.com>
>> Reviewed-by: Darren Kenny <Darren.Kenny@oracle.com>
>> Reviewed-by: Mark Kanda <Mark.Kanda@oracle.com>
>> ---
>> =C2=A0 job.c | 4 ++--
>> =C2=A0 1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> Reviewed-by: Eric Blake <eblake@redhat.com>
>=20

Thanks,
Liam


>>
>> diff --git a/job.c b/job.c
>> index e36ebaafd81c..40320566f43b 100644
>> --- a/job.c
>> +++ b/job.c
>> @@ -166,7 +166,7 @@ bool job_is_internal(Job *job)
>> =C2=A0 static void job_state_transition(Job *job, JobStatus s1)
>> =C2=A0 {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 JobStatus s0 =3D job->status;
>> -=C2=A0=C2=A0=C2=A0 assert(s1 >=3D 0 && s1 <=3D JOB_STATUS__MAX);
>> +=C2=A0=C2=A0=C2=A0 assert(s1 >=3D 0 && s1 < JOB_STATUS__MAX);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 trace_job_state_transition(job, job->re=
t,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 JobSTT[s0][s1] ? "allowed" =
:=20
>> "disallowed",
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 JobStatus_str(s0), JobStatu=
s_str(s1));
>> @@ -181,7 +181,7 @@ static void job_state_transition(Job *job,=20
>> JobStatus s1)
>> =C2=A0 int job_apply_verb(Job *job, JobVerb verb, Error **errp)
>> =C2=A0 {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 JobStatus s0 =3D job->status;
>> -=C2=A0=C2=A0=C2=A0 assert(verb >=3D 0 && verb <=3D JOB_VERB__MAX);
>> +=C2=A0=C2=A0=C2=A0 assert(verb >=3D 0 && verb < JOB_VERB__MAX);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 trace_job_apply_verb(job, JobStatus_str=
(s0), JobVerb_str(verb),
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 JobVerbTable[verb][s0] ? "allowed" :=20
>> "prohibited");
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (JobVerbTable[verb][s0]) {
>>
>=20
