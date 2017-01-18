Received: from eggs.gnu.org ([2001:4830:134:3::10]:55041)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhang.zhanghailiang@huawei.com>) id 1cTk8d-00053i-43
	for qemu-devel@nongnu.org; Wed, 18 Jan 2017 01:54:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zhang.zhanghailiang@huawei.com>) id 1cTk8a-0005kl-2W
	for qemu-devel@nongnu.org; Wed, 18 Jan 2017 01:54:31 -0500
References: <1480926904-17596-1-git-send-email-zhang.zhanghailiang@huawei.com>
	<1480926904-17596-5-git-send-email-zhang.zhanghailiang@huawei.com>
	<5859274F.7090002@cn.fujitsu.com>
From: Hailiang Zhang <zhang.zhanghailiang@huawei.com>
Message-ID: <587F1103.2090503@huawei.com>
Date: Wed, 18 Jan 2017 14:53:55 +0800
MIME-Version: 1.0
In-Reply-To: <5859274F.7090002@cn.fujitsu.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH RFC v2 4/6] replication: fix code logic
 with the new shared_disk option
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Changlong Xie <xiecl.fnst@cn.fujitsu.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: xuquan8@huawei.com, stefanha@redhat.com, kwolf@redhat.com, mreitz@redhat.com, pbonzini@redhat.com, wency@cn.fujitsu.com

On 2016/12/20 20:42, Changlong Xie wrote:
> On 12/05/2016 04:35 PM, zhanghailiang wrote:
>> Some code logic only be needed in non-shared disk, here
>> we adjust these codes to prepare for shared disk scenario.
>>
>> Signed-off-by: zhanghailiang <zhang.zhanghailiang@huawei.com>
>> ---
>>    block/replication.c | 47 ++++++++++++++++++++++++++++-------------------
>>    1 file changed, 28 insertions(+), 19 deletions(-)
>>
>> diff --git a/block/replication.c b/block/replication.c
>> index 35e9ab3..6574cc2 100644
>> --- a/block/replication.c
>> +++ b/block/replication.c
>> @@ -531,21 +531,28 @@ static void replication_start(ReplicationState *rs, ReplicationMode mode,
>>                aio_context_release(aio_context);
>>                return;
>>            }
>> -        bdrv_op_block_all(top_bs, s->blocker);
>> -        bdrv_op_unblock(top_bs, BLOCK_OP_TYPE_DATAPLANE, s->blocker);
>>
>> -        job = backup_job_create(NULL, s->secondary_disk->bs, s->hidden_disk->bs,
>> -                                0, MIRROR_SYNC_MODE_NONE, NULL, false,
>> +        /*
>> +         * Only in the case of non-shared disk,
>> +         * the backup job is in the secondary side
>> +         */
>> +        if (!s->is_shared_disk) {
>> +            bdrv_op_block_all(top_bs, s->blocker);
>> +            bdrv_op_unblock(top_bs, BLOCK_OP_TYPE_DATAPLANE, s->blocker);
>> +            job = backup_job_create(NULL, s->secondary_disk->bs,
>> +                                s->hidden_disk->bs, 0,
>> +                                MIRROR_SYNC_MODE_NONE, NULL, false,
>>                                    BLOCKDEV_ON_ERROR_REPORT,
>>                                    BLOCKDEV_ON_ERROR_REPORT, BLOCK_JOB_INTERNAL,
>>                                    backup_job_completed, bs, NULL, &local_err);
>
> Coding style here.
>

Will fix it in next version, thanks.

>> -        if (local_err) {
>> -            error_propagate(errp, local_err);
>> -            backup_job_cleanup(bs);
>> -            aio_context_release(aio_context);
>> -            return;
>> +            if (local_err) {
>> +                error_propagate(errp, local_err);
>> +                backup_job_cleanup(bs);
>> +                aio_context_release(aio_context);
>> +                return;
>> +            }
>> +            block_job_start(job);
>>            }
>> -        block_job_start(job);
>>
>>            secondary_do_checkpoint(s, errp);
>>            break;
>> @@ -575,14 +582,16 @@ static void replication_do_checkpoint(ReplicationState *rs, Error **errp)
>>        case REPLICATION_MODE_PRIMARY:
>>            break;
>>        case REPLICATION_MODE_SECONDARY:
>> -        if (!s->secondary_disk->bs->job) {
>> -            error_setg(errp, "Backup job was cancelled unexpectedly");
>> -            break;
>> -        }
>> -        backup_do_checkpoint(s->secondary_disk->bs->job, &local_err);
>> -        if (local_err) {
>> -            error_propagate(errp, local_err);
>> -            break;
>> +        if (!s->is_shared_disk) {
>> +            if (!s->secondary_disk->bs->job) {
>> +                error_setg(errp, "Backup job was cancelled unexpectedly");
>> +                break;
>> +            }
>> +            backup_do_checkpoint(s->secondary_disk->bs->job, &local_err);
>> +            if (local_err) {
>> +                error_propagate(errp, local_err);
>> +                break;
>> +            }
>>            }
>>            secondary_do_checkpoint(s, errp);
>>            break;
>> @@ -663,7 +672,7 @@ static void replication_stop(ReplicationState *rs, bool failover, Error **errp)
>>             * before the BDS is closed, because we will access hidden
>>             * disk, secondary disk in backup_job_completed().
>>             */
>> -        if (s->secondary_disk->bs->job) {
>> +        if (!s->is_shared_disk && s->secondary_disk->bs->job) {
>>                block_job_cancel_sync(s->secondary_disk->bs->job);
>>            }
>>
>>
>
>
>
> .
>
