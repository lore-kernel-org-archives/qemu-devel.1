Received: from eggs.gnu.org ([2001:4830:134:3::10]:51755)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <liliang.opensource@gmail.com>) id 1eh4OL-0001TZ-Fl
	for qemu-devel@nongnu.org; Wed, 31 Jan 2018 21:14:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <liliang.opensource@gmail.com>) id 1eh4OJ-0006KF-R6
	for qemu-devel@nongnu.org; Wed, 31 Jan 2018 21:14:21 -0500
From: Liang Li <liliang.opensource@gmail.com>
Content-Type: text/plain;
	charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0 (Mac OS X Mail 11.1 \(3445.4.7\))
Message-Id: <53662888-14CE-4635-BF6F-065B6D60F41B@gmail.com>
Date: Thu, 1 Feb 2018 10:14:05 +0800
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
To: eblake@redhat.com
Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>, armbru@redhat.com, Jeff Cody <jcody@redhat.com>, Kevin Wolf <kwolf@redhat.com>, pbonzini@redhat.com, qemu-block@nongnu.org, qemu-devel@nongnu.org, John Snow <jsnow@redhat.com>, Huaitong Han <huanhuaitong@didichuxing.com>

On Tue, Jan 30, 2018 at 08:20:03AM -0600, Eric Blake wrote:
> On 01/30/2018 02:38 AM, Liang Li wrote:
>> When doing drive mirror to a low speed shared storage, if there was =
heavy
>> BLK IO write workload in VM after the 'ready' event, drive mirror =
block job
>> can't be canceled immediately, it would keep running until the heavy =
BLK IO
>> workload stopped in the VM.
>=20
> So far so good.   But the grammar and explanation in the rest of the
> commit is a bit hard to read; let me give a shot at an alternative =
wording:
>=20
> Libvirt depends on the current block-job-cancel semantics, which is =
that
> when used without a flag after the 'ready' event, the command blocks
> until data is in sync.  However, these semantics are awkward in other
> situations, for example, people may use drive mirror for realtime
> backups while still wanting to use block live migration.  Libvirt =
cannot
> start a block live migration while another drive mirror is in =
progress,
> but the user would rather abandon the backup attempt as broken and
> proceed with the live migration than be stuck waiting for the current
> drive mirror backup to finish.
>=20
> The drive-mirror command already includes a 'force' flag, which =
libvirt
> does not use, although it documented the flag as only being useful to
> quit a job which is paused.  However, since quitting a paused job has
> the same effect as abandoning a backup in a non-paused job (namely, =
the
> destination file is not in sync, and the command completes =
immediately),
> we can just improve the documentation to make the force flag obviously
> useful.
>=20

much better, will include in the v2. Thanks!
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
>=20
>=20
>> +++ b/hmp-commands.hx
>> @@ -106,7 +106,8 @@ ETEXI
>>         .args_type  =3D "force:-f,device:B",
>>         .params     =3D "[-f] device",
>>         .help       =3D "stop an active background block operation =
(use -f"
>> -                      "\n\t\t\t if the operation is currently =
paused)",
>> +                      "\n\t\t\t if you want to abort the operation =
immediately"
>> +                      "\n\t\t\t instead of keep running until data =
is in sync )",
>=20
> s/sync )/sync)/
>=20

done
>>         .cmd        =3D hmp_block_job_cancel,
>>     },
>>=20
>> diff --git a/include/block/blockjob.h b/include/block/blockjob.h
>> index 00403d9..4a96c42 100644
>> --- a/include/block/blockjob.h
>> +++ b/include/block/blockjob.h
>> @@ -63,6 +63,12 @@ typedef struct BlockJob {
>>     bool cancelled;
>>=20
>>     /**
>> +     * Set to true if the job should be abort immediately without =
waiting
>=20
> s/be //

done
>=20
>> +     * for data is in sync.
>=20
> s/is/to be/
>=20

done
>> +     */
>> +    bool force;
>> +
>> +    /**
>>      * Counter for pause request. If non-zero, the block job is =
either paused,
>>      * or if busy =3D=3D true will pause itself as soon as possible.
>>      */
>> @@ -218,10 +224,11 @@ void block_job_start(BlockJob *job);
>> /**
>>  * block_job_cancel:
>>  * @job: The job to be canceled.
>> + * @force: Quit a job without waiting data is in sync.
>=20
> s/data is/for data to be/
>=20

done
>> +++ b/qapi/block-core.json
>> @@ -2098,8 +2098,10 @@
>> #          the name of the parameter), but since QEMU 2.7 it can have
>> #          other values.
>> #
>> -# @force: whether to allow cancellation of a paused job (default
>> -#         false).  Since 1.3.
>> +# @force: #optional whether to allow cancellation a job without =
waiting data is
>=20
> The '#optional' tag should no longer be added.
>=20
>> +#         in sync, please not that since 2.12 it's semantic is not =
exactly the
>> +#         same as before, from 1.3 to 2.11 it means whether to allow =
cancellation
>> +#         of a paused job (default false).  Since 1.3.
>=20
> Reads awkwardly.  I suggest:
>=20
> @force: If true, and the job has already emitted the event
> BLOCK_JOB_READY, abandon the job immediately (even if it is paused)
> instead of waiting for the destination to complete its final
> synchronization (since 1.3)
>=20

much more clear
>=20
>> +++ b/tests/test-blockjob-txn.c
>> @@ -125,7 +125,7 @@ static void test_single_job(int expected)
>>     block_job_start(job);
>>=20
>>     if (expected =3D=3D -ECANCELED) {
>> -        block_job_cancel(job);
>> +        block_job_cancel(job, false);
>>     }
>>=20
>>     while (result =3D=3D -EINPROGRESS) {
>> @@ -173,10 +173,10 @@ static void test_pair_jobs(int expected1, int =
expected2)
>>     block_job_txn_unref(txn);
>>=20
>>     if (expected1 =3D=3D -ECANCELED) {
>> -        block_job_cancel(job1);
>> +        block_job_cancel(job1, false);
>>     }
>>     if (expected2 =3D=3D -ECANCELED) {
>> -        block_job_cancel(job2);
>> +        block_job_cancel(job2, false);
>>     }
>>=20
>>     while (result1 =3D=3D -EINPROGRESS || result2 =3D=3D =
-EINPROGRESS) {
>> @@ -231,7 +231,7 @@ static void test_pair_jobs_fail_cancel_race(void)
>>     block_job_start(job1);
>>     block_job_start(job2);
>>=20
>> -    block_job_cancel(job1);
>> +    block_job_cancel(job1, false);
>>=20
>>     /* Now make job2 finish before the main loop kicks jobs.  This =
simulates
>>      * the race between a pending kick and another job completing.
>>=20
>=20
> The testsuite should probably also test block_job_cancel(..., true).
>=20

will change in v2, thanks!

Liang


> --=20
> Eric Blake, Principal Software Engineer
> Red Hat, Inc.           +1-919-301-3266
> Virtualization:  qemu.org | libvirt.org
