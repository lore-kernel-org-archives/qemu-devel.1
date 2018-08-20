Received: from eggs.gnu.org ([2001:4830:134:3::10]:35007)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1frpU5-0003lR-AB
	for qemu-devel@nongnu.org; Mon, 20 Aug 2018 15:05:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1frpU3-0001jg-7y
	for qemu-devel@nongnu.org; Mon, 20 Aug 2018 15:05:00 -0400
References: <20180817190457.8292-1-jsnow@redhat.com>
	<20180817190457.8292-2-jsnow@redhat.com>
	<154f228d-9a04-5fef-f703-e41f6b75ba86@redhat.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <92b7a2cd-9dcd-b861-68c5-2ca4275c92e9@redhat.com>
Date: Mon, 20 Aug 2018 15:04:23 -0400
MIME-Version: 1.0
In-Reply-To: <154f228d-9a04-5fef-f703-e41f6b75ba86@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 1/7] jobs: change start callback to run
 callback
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, Jeff Cody <jcody@redhat.com>, jtc@redhat.com, Max Reitz <mreitz@redhat.com>



On 08/20/2018 02:28 PM, Eric Blake wrote:
> On 08/17/2018 02:04 PM, John Snow wrote:
>> Presently we codify the entry point for a job as the "start" callback,
>> but a more apt name would be "run" to clarify the idea that when this
>> function returns we consider the job to have "finished," except for
>> any cleanup which occurs in separate callbacks later.
>>
>> As part of this clarification, change the signature to include an erro=
r
>> object and a return code. The error ptr is not yet used, and the retur=
n
>> code while captured, will be overwritten by actions in the job_complet=
ed
>> function.
>>
>> Signed-off-by: John Snow <jsnow@redhat.com>
>> ---
>=20
>> +++ b/block/backup.c
>> @@ -480,9 +480,9 @@ static void
>> backup_incremental_init_copy_bitmap(BackupBlockJob *job)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bdrv_dirty_iter_free(dbi);
>> =C2=A0 }
>> =C2=A0 -static void coroutine_fn backup_run(void *opaque)
>> +static int coroutine_fn backup_run(Job *opaque_job, Error **errp)
>> =C2=A0 {
>> -=C2=A0=C2=A0=C2=A0 BackupBlockJob *job =3D opaque;
>> +=C2=A0=C2=A0=C2=A0 BackupBlockJob *job =3D container_of(opaque_job, B=
ackupBlockJob,
>> common.job);
>=20
> Hmm. Here, you used the naming pair 'opaque_job' vs. 'job',...
>=20
>> +++ b/block/commit.c
>> @@ -134,9 +134,9 @@ static void commit_complete(Job *job, void *opaque=
)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bdrv_unref(top);
>> =C2=A0 }
>> =C2=A0 -static void coroutine_fn commit_run(void *opaque)
>> +static int coroutine_fn commit_run(Job *job, Error **errp)
>> =C2=A0 {
>> -=C2=A0=C2=A0=C2=A0 CommitBlockJob *s =3D opaque;
>> +=C2=A0=C2=A0=C2=A0 CommitBlockJob *s =3D container_of(job, CommitBloc=
kJob, common.job);
>=20
> while in the majority of the other clients, it was 'job' vs. 's'. Is it
> worth making these names consistent, or is that too much bikeshed paint=
?
>=20
> Reviewed-by: Eric Blake <eblake@redhat.com>
>=20

:)

Was just trying to keep the static down, but it did annoy me that it was
different.

I can either change it for "v2" or send a follow-up, depending.

--js
