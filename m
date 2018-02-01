Received: from eggs.gnu.org ([2001:4830:134:3::10]:52551)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <liliang.opensource@gmail.com>) id 1eh4TF-00044i-Ts
	for qemu-devel@nongnu.org; Wed, 31 Jan 2018 21:19:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <liliang.opensource@gmail.com>) id 1eh4TE-0001V6-Ee
	for qemu-devel@nongnu.org; Wed, 31 Jan 2018 21:19:25 -0500
From: Liang Li <liliang.opensource@gmail.com>
Content-Type: text/plain;
	charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0 (Mac OS X Mail 11.1 \(3445.4.7\))
Message-Id: <153D07A7-F411-4EF4-A48D-D244621E97E9@gmail.com>
Date: Thu, 1 Feb 2018 10:19:10 +0800
Subject: Re: [Qemu-devel] [PATCH] block/mirror: change the semantic of
 'force' of block-job-cancel
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Snow <jsnow@redhat.com>
Cc: Liang Li <liliang.opensource@gmail.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Markus Armbruster <armbru@redhat.com>, Kevin Wolf <kwolf@redhat.com>, eblake@redhat.com, Paolo Bonzini <pbonzini@redhat.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org, Liang Li <liliangleo@didichuxing.com>, Huaitong Han <huanhuaitong@didichuxing.com>

On Tue, Jan 30, 2018 at 03:18:31PM -0500, John Snow wrote:
>=20
>=20
> On 01/30/2018 03:38 AM, Liang Li wrote:
>> When doing drive mirror to a low speed shared storage, if there was =
heavy
>> BLK IO write workload in VM after the 'ready' event, drive mirror =
block job
>> can't be canceled immediately, it would keep running until the heavy =
BLK IO
>> workload stopped in the VM.
>>=20
>> Because libvirt depends on block-job-cancel for block live migration, =
the
>> current block-job-cancel has the semantic to make sure data is in =
sync after
>> the 'ready' event.  This semantic can't meet some requirement, for =
example,
>> people may use drive mirror for realtime backup while need the =
ability of
>> block live migration. If drive mirror can't not be cancelled =
immediately,
>> it means block live migration need to wait, because libvirt make use =
drive
>> mirror to implement block live migration and only one drive mirror =
block
>> job is allowed at the same time for a give block dev.
>>=20
>> We need a new interface for 'force cancel', which could quit block =
job
>> immediately if don't care about whether data is in sync or not.
>>=20
>> 'force' is not used by libvirt currently, to make things simple, =
change
>> it's semantic slightly, hope it will not break some use case which =
need its
>> original semantic.
>>=20
>> Cc: Paolo Bonzini <pbonzini@redhat.com>
>> Cc: Jeff Cody <jcody@redhat.com>
>> Cc: Kevin Wolf <kwolf@redhat.com>
>> Cc: Max Reitz <mreitz@redhat.com>
>> Cc: Eric Blake <eblake@redhat.com>
>> Cc: John Snow <jsnow@redhat.com>
>> Reported-by: Huaitong Han <huanhuaitong@didichuxing.com>
>> Signed-off-by: Huaitong Han <huanhuaitong@didichuxing.com>
>> Signed-off-by: Liang Li <liliangleo@didichuxing.com>
>> ---
>> block/mirror.c            |  9 +++------
>> blockdev.c                |  4 ++--
>> blockjob.c                | 11 ++++++-----
>> hmp-commands.hx           |  3 ++-
>> include/block/blockjob.h  |  9 ++++++++-
>> qapi/block-core.json      |  6 ++++--
>> tests/test-blockjob-txn.c |  8 ++++----
>> 7 files changed, 29 insertions(+), 21 deletions(-)
>>=20
>> diff --git a/block/mirror.c b/block/mirror.c
>> index c9badc1..c22dff9 100644
>> --- a/block/mirror.c
>> +++ b/block/mirror.c
>> @@ -869,11 +869,8 @@ static void coroutine_fn mirror_run(void =
*opaque)
>>=20
>>         ret =3D 0;
>>         trace_mirror_before_sleep(s, cnt, s->synced, delay_ns);
>> -        if (!s->synced) {
>> -            block_job_sleep_ns(&s->common, delay_ns);
>> -            if (block_job_is_cancelled(&s->common)) {
>> -                break;
>> -            }
>> +        if (block_job_is_cancelled(&s->common) && s->common.force) {
>> +            break;
>=20
> what's the justification for removing the sleep in the case that
> !s->synced && !block_job_is_cancelled(...) ?
>=20
if !block_job_is_cancelled() satisfied, the code in 'if =
(!should_complete) {}'
will execute, there is a block_job_sleep_ns there.

block_job_sleep_ns is for rate throttling, if there is no more data to =
sync,=20
sleep is not needed, right?

>>         } else if (!should_complete) {
>>             delay_ns =3D (s->in_flight =3D=3D 0 && cnt =3D=3D 0 ? =
SLICE_TIME : 0);
>>             block_job_sleep_ns(&s->common, delay_ns);
>> @@ -887,7 +884,7 @@ immediate_exit:
>>          * or it was cancelled prematurely so that we do not =
guarantee that
>>          * the target is a copy of the source.
>>          */
>> -        assert(ret < 0 || (!s->synced && =
block_job_is_cancelled(&s->common)));
>> +        assert(ret < 0 || block_job_is_cancelled(&s->common));
>=20
> This assertion gets weaker in the case where force isn't provided, is
> that desired?
>=20
yes. if force quit is used, the following condition can be true

(ret >=3D 0) && (s->synced) && (block_job_is_cancelled(&s->common))=20

so the above assert should be changed, or it will be failed.

>>         assert(need_drain);
>>         mirror_wait_for_all_io(s);
>>     }
>> diff --git a/blockdev.c b/blockdev.c
>> index 8e977ee..039f156 100644
>> --- a/blockdev.c
>> +++ b/blockdev.c
>> @@ -145,7 +145,7 @@ void blockdev_mark_auto_del(BlockBackend *blk)
>>         aio_context_acquire(aio_context);
>>=20
>>         if (bs->job) {
>> -            block_job_cancel(bs->job);
>> +            block_job_cancel(bs->job, false);
>>         }
>>=20
>>         aio_context_release(aio_context);
>> @@ -3802,7 +3802,7 @@ void qmp_block_job_cancel(const char *device,
>>     }
>>=20
>>     trace_qmp_block_job_cancel(job);
>> -    block_job_cancel(job);
>> +    block_job_cancel(job, force);
>> out:
>>     aio_context_release(aio_context);
>> }
>> diff --git a/blockjob.c b/blockjob.c
>> index f5cea84..0aacb50 100644
>> --- a/blockjob.c
>> +++ b/blockjob.c
>> @@ -365,7 +365,7 @@ static void block_job_completed_single(BlockJob =
*job)
>>     block_job_unref(job);
>> }
>>=20
>> -static void block_job_cancel_async(BlockJob *job)
>> +static void block_job_cancel_async(BlockJob *job, bool force)
>> {
>>     if (job->iostatus !=3D BLOCK_DEVICE_IO_STATUS_OK) {
>>         block_job_iostatus_reset(job);
>> @@ -376,6 +376,7 @@ static void block_job_cancel_async(BlockJob *job)
>>         job->pause_count--;
>>     }
>>     job->cancelled =3D true;
>> +    job->force =3D force;
>> }
>>=20
>=20
> I suppose this is okay; we're setting a permanent property of the job =
as
> part of a limited operation.
>=20
> Granted, the job should disappear afterwards, so it should never
> conflict, but it made me wonder for a moment.
>=20
> What happens if we cancel with force =3D true and then immediately =
cancel
> again with force =3D false? What happens? Can it cause issues?
>=20

Indeed. It can be fixed by:

if (!job->force)
   job->force =3D force

it's that ok ?

>> static int block_job_finish_sync(BlockJob *job,
>> @@ -437,7 +438,7 @@ static void =
block_job_completed_txn_abort(BlockJob *job)
>>      * on the caller, so leave it. */
>>     QLIST_FOREACH(other_job, &txn->jobs, txn_list) {
>>         if (other_job !=3D job) {
>> -            block_job_cancel_async(other_job);
>> +            block_job_cancel_async(other_job, true);
>=20
> What's the rationale for deciding that transactional cancellations are
> always force=3Dtrue?
>=20

no particular reason, just try to speed up the abort process. :)

> Granted, this doesn't matter currently because mirror isn't a
> transactional job, but that makes the decision all the more curious.
>=20
>>         }
>>     }

Thanks for your comments.

Liang=
