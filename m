Received: from eggs.gnu.org ([2001:4830:134:3::10]:50274)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sochin.jiang@huawei.com>) id 1cJ8YC-0000At-Kt
	for qemu-devel@nongnu.org; Mon, 19 Dec 2016 19:45:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sochin.jiang@huawei.com>) id 1cJ8Y9-0002PN-He
	for qemu-devel@nongnu.org; Mon, 19 Dec 2016 19:45:04 -0500
References: <1482187106-85065-1-git-send-email-sochin.jiang@huawei.com>
	<5c75620e-6c60-5cae-a0d7-9d64c3de6044@redhat.com>
From: "sochin.jiang" <sochin.jiang@huawei.com>
Message-ID: <0f2588f0-4461-8384-6d8c-ca8d7da8a156@huawei.com>
Date: Tue, 20 Dec 2016 08:44:32 +0800
MIME-Version: 1.0
In-Reply-To: <5c75620e-6c60-5cae-a0d7-9d64c3de6044@redhat.com>
Content-Type: text/plain; charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] mirror: prevent 'top' mode mirroring when
 no backing file specified on the destination
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>, jcody@redhat.com, kwolf@redhat.com
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, xieyingtai@huawei.com, eric.fangyi@huawei.com, subo7@huawei.com, wangjie88@huawei.com

 I got the idea, thanks, Max.


 Sochin.Jiang

On 2016/12/19 23:31, Max Reitz wrote:
> On 19.12.2016 23:38, sochin jiang wrote:
>>  Mirroring using 'top' mode without backing file specified on the target can be success,
>>  but end with a disaster.
>>
>>  For example:
>>    Migration can be success in this situation while the virtual machine on the destination
>>  is no longer usable because of backing lost.
>>
>>  Remind the user earlier and return error in case of misoperation.
>>
>> Signed-off-by: sochin jiang <sochin.jiang@huawei.com>
>> ---
>>  block/mirror.c | 6 ++++++
>>  1 file changed, 6 insertions(+)
>>
>> diff --git a/block/mirror.c b/block/mirror.c
>> index 301ba92..3476696 100644
>> --- a/block/mirror.c
>> +++ b/block/mirror.c
>> @@ -1038,6 +1038,12 @@ void mirror_start(const char *job_id, BlockDriverState *bs,
>>          error_setg(errp, "Sync mode 'incremental' not supported");
>>          return;
>>      }
>> +    if (mode == MIRROR_SYNC_MODE_TOP && !backing_bs(target))
>> +    {
> 
> Syntactic issue: The opening brace should be on the same line as the "if".
> 
>> +        error_setg(errp, "Target Backing required using Sync mode 'top'");
>> +        return;
>> +    }
>> +
>>      is_none_mode = mode == MIRROR_SYNC_MODE_NONE;
>>      base = mode == MIRROR_SYNC_MODE_TOP ? backing_bs(bs) : NULL;
>>      mirror_start_job(job_id, bs, BLOCK_JOB_DEFAULT, target, replaces,
> 
> General issue: For blockdev-mirror, I think this is a legitimate use
> case. As far as I'm aware, libvirt uses the mirror block job for all
> backups -- they do so by cancelling the block job after the
> BLOCK_JOB_READY event instead of letting it complete. So a user might
> want to mirror some drive somewhere else (in sync=top mode, with the new
> location not yet having assigned a backing file to it), then cancel the
> block job after BLOCK_JOB_READY and only assign the backing file at some
> later point.
> 
> An even greater issue is that qmp_drive_mirror() opens the target BDS
> with BDRV_O_NO_BACKING. Therefore, this will always error out with
> drive-mirror and sync=top (unless the source image does not have a
> backing file, in which case the sync=top will silently be converted to
> sync=full).
> 
> For drive-mirror, the target's backing chain will not be set up until
> mirror_complete().
> 
> Max
> 
