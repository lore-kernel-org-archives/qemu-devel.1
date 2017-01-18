Received: from eggs.gnu.org ([2001:4830:134:3::10]:54887)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhang.zhanghailiang@huawei.com>) id 1cTk7l-0004ev-Kd
	for qemu-devel@nongnu.org; Wed, 18 Jan 2017 01:53:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zhang.zhanghailiang@huawei.com>) id 1cTk7k-0005MK-Nj
	for qemu-devel@nongnu.org; Wed, 18 Jan 2017 01:53:37 -0500
References: <1480926904-17596-1-git-send-email-zhang.zhanghailiang@huawei.com>
	<1480926904-17596-6-git-send-email-zhang.zhanghailiang@huawei.com>
	<20170117131916.GJ4265@stefanha-x1.localdomain>
From: Hailiang Zhang <zhang.zhanghailiang@huawei.com>
Message-ID: <587F10D4.9050608@huawei.com>
Date: Wed, 18 Jan 2017 14:53:08 +0800
MIME-Version: 1.0
In-Reply-To: <20170117131916.GJ4265@stefanha-x1.localdomain>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH RFC v2 5/6] replication: Implement block
 replication for shared disk case
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: xuquan8@huawei.com, qemu-devel@nongnu.org, qemu-block@nongnu.org, kwolf@redhat.com, mreitz@redhat.com, pbonzini@redhat.com, wency@cn.fujitsu.com, xiecl.fnst@cn.fujitsu.com, Zhang Chen <zhangchen.fnst@cn.fujitsu.com>

Hi Stefan,

On 2017/1/17 21:19, Stefan Hajnoczi wrote:
> On Mon, Dec 05, 2016 at 04:35:03PM +0800, zhanghailiang wrote:
>> @@ -663,8 +695,12 @@ static void replication_stop(ReplicationState *rs, bool failover, Error **errp)
>>
>>       switch (s->mode) {
>>       case REPLICATION_MODE_PRIMARY:
>> -        s->replication_state = BLOCK_REPLICATION_DONE;
>> -        s->error = 0;
>> +        if (s->is_shared_disk && s->primary_disk->bs->job) {
>> +            block_job_cancel(s->primary_disk->bs->job);
>
> Should this be block_job_cancel_sync()?
>

No, here it is different from the secondary side which needs to wait
until backup job been canceled before resumes to run (Or there will be
an error, https://patchwork.kernel.org/patch/9128841/).

For primary VM, Just as you can see the design scenario in patch 1,
It accesses the shared disk directly, the backup job whose source side
is just the shared disk does not influence primary VM's running,
So IMHO, it is safe to call block_job_cancel here.

Thanks,
Hailiang


>> +        } else {
>> +            s->replication_state = BLOCK_REPLICATION_DONE;
>> +            s->error = 0;
>> +        }
>>           break;
>>       case REPLICATION_MODE_SECONDARY:
>>           /*
>> --
>> 1.8.3.1
>>
>>
