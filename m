Received: from eggs.gnu.org ([2001:4830:134:3::10]:37451)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1clI9s-0005ns-0N
	for qemu-devel@nongnu.org; Tue, 07 Mar 2017 11:40:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1clI9o-0004bQ-Pp
	for qemu-devel@nongnu.org; Tue, 07 Mar 2017 11:40:20 -0500
Received: from mailhub.sw.ru ([195.214.232.25]:48330 helo=relay.sw.ru)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
	id 1clI9o-0004ZM-EZ
	for qemu-devel@nongnu.org; Tue, 07 Mar 2017 11:40:16 -0500
References: <20170228193340.63980-1-vsementsov@virtuozzo.com>
	<20170307134702.GM5871@noname.str.redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <b2029a01-9017-3b05-4b00-94efb32faf9b@virtuozzo.com>
Date: Tue, 7 Mar 2017 19:39:54 +0300
MIME-Version: 1.0
In-Reply-To: <20170307134702.GM5871@noname.str.redhat.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v4] backup: allow target without
 .bdrv_get_info
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, mreitz@redhat.com, jcody@redhat.com, jsnow@redhat.com, famz@redhat.com, den@openvz.org, stefanha@redhat.com

07.03.2017 16:47, Kevin Wolf wrote:
> Am 28.02.2017 um 20:33 hat Vladimir Sementsov-Ogievskiy geschrieben:
>> Currently backup to nbd target is broken, as nbd doesn't have
>> .bdrv_get_info realization.
>>
>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>> ---
>>
>> v4: use error_report()
>>      add article
>>
>> v3: fix compilation (I feel like an idiot)
>>      adjust wording (Fam)
>>      
>> v2: add WARNING
>>
>> ===
>>
>> Since commit
>>
>> commit 4c9bca7e39a6e07ad02c1dcde3478363344ec60b
>> Author: John Snow <jsnow@redhat.com>
>> Date:   Thu Feb 25 15:58:30 2016 -0500
>>
>>      block/backup: avoid copying less than full target clusters
>>
>> backup to nbd target is broken, we have "Couldn't determine the cluster size of
>> the target image".
>>
>> Proposed NBD protocol extension - NBD_OPT_INFO should finally solve this problem.
>> But until it is not realized, we need allow backup to nbd target due to backward
>> compatibility.
>>
>> Furthermore, is it entirely ok to disallow backup if bds lacks .bdrv_get_info?
>> Which behavior should be default: to fail backup or to use default cluster size?
>>
>>   block/backup.c | 12 +++++++++++-
>>   1 file changed, 11 insertions(+), 1 deletion(-)
>>
>> diff --git a/block/backup.c b/block/backup.c
>> index ea38733849..ea160e9e82 100644
>> --- a/block/backup.c
>> +++ b/block/backup.c
>> @@ -24,6 +24,7 @@
>>   #include "qemu/cutils.h"
>>   #include "sysemu/block-backend.h"
>>   #include "qemu/bitmap.h"
>> +#include "qemu/error-report.h"
>>   
>>   #define BACKUP_CLUSTER_SIZE_DEFAULT (1 << 16)
>>   #define SLICE_TIME 100000000ULL /* ns */
>> @@ -638,7 +639,16 @@ BlockJob *backup_job_create(const char *job_id, BlockDriverState *bs,
>>        * backup cluster size is smaller than the target cluster size. Even for
>>        * targets with a backing file, try to avoid COW if possible. */
>>       ret = bdrv_get_info(target, &bdi);
>> -    if (ret < 0 && !target->backing) {
>> +    if (ret == -ENOTSUP) {
> I think this should be if (ret == -ENOTSUP && !target->backing) because
> the warning explicitly says "doesn't have a backing file", and the case
> with a backing file is already handled below (without a warning).
>
> I can fix this while applying if you agree.

Ok. no problem

>
>> +        /* Cluster size is not defined */
>> +        error_report("WARNING: The target block device doesn't provide "
>> +                     "information about the block size and it doesn't have a "
>> +                     "backing file. The default block size of %u bytes is "
>> +                     "used. If the actual block size of the target exceeds "
>> +                     "this default, the backup may be unusable",
>> +                     BACKUP_CLUSTER_SIZE_DEFAULT);
>> +        job->cluster_size = BACKUP_CLUSTER_SIZE_DEFAULT;
>> +    } else if (ret < 0 && !target->backing) {
>>           error_setg_errno(errp, -ret,
>>               "Couldn't determine the cluster size of the target image, "
>>               "which has no backing file");
> Kevin


-- 
Best regards,
Vladimir
