Received: from eggs.gnu.org ([2001:4830:134:3::10]:36868)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1eqlAZ-00025Q-HH
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 14:44:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1eqlAY-0002Y3-SL
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 14:44:11 -0500
References: <20180223235142.21501-1-jsnow@redhat.com>
	<20180223235142.21501-10-jsnow@redhat.com>
	<9dc66db9-3d67-5eb3-7008-7dc4fd1f2482@redhat.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <10d7fbea-158c-d23a-f0da-1bd68dfebbab@redhat.com>
Date: Tue, 27 Feb 2018 14:44:03 -0500
MIME-Version: 1.0
In-Reply-To: <9dc66db9-3d67-5eb3-7008-7dc4fd1f2482@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC v4 09/21] blockjobs: add CONCLUDED state
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-block@nongnu.org
Cc: kwolf@redhat.com, pkrempa@redhat.com, jtc@redhat.com, qemu-devel@nongnu.org



On 02/27/2018 02:38 PM, Eric Blake wrote:
> On 02/23/2018 05:51 PM, John Snow wrote:
>> add a new state "CONCLUDED" that identifies a job that has ceased all
>> operations. The wording was chosen to avoid any phrasing that might
>> imply success, error, or cancellation. The task has simply ceased all
>> operation and can never again perform any work.
>>
>> ("finished", "done", and "completed" might all imply success.)
>>
>> Transitions:
>> Running=C2=A0 -> Concluded: normal completion
>> Ready=C2=A0=C2=A0=C2=A0 -> Concluded: normal completion
>> Aborting -> Concluded: error and cancellations
>>
>> Verbs:
>> None as of this commit. (a future commit adds 'dismiss')
>>
>=20
>=20
>> @@ -620,7 +623,9 @@ void block_job_user_resume(BlockJob *job, Error
>> **errp)
>> =C2=A0 =C2=A0 void block_job_cancel(BlockJob *job)
>> =C2=A0 {
>> -=C2=A0=C2=A0=C2=A0 if (block_job_started(job)) {
>> +=C2=A0=C2=A0=C2=A0 if (job->status =3D=3D BLOCK_JOB_STATUS_CONCLUDED)=
 {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return;
>> +=C2=A0=C2=A0=C2=A0 } else if (block_job_started(job)) {
>=20
> It's also possible to do:
>=20
> if () {
> =C2=A0 return ;
> }
> if (...)
>=20
> instead of chaining with an 'else if'.=C2=A0 Matter of personal taste, =
so I
> won't make you change it.
>=20
> Reviewed-by: Eric Blake <eblake@redhat.com>
>=20

I guess because in this case, what I did adds two SLOC instead of three.
If the other code did not need to be guarded by an if(), I'd otherwise
agree.
