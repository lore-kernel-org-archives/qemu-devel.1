Received: from eggs.gnu.org ([2001:4830:134:3::10]:49945)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhang.zhanghailiang@huawei.com>) id 1d94by-0003Ar-FR
	for qemu-devel@nongnu.org; Fri, 12 May 2017 03:03:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zhang.zhanghailiang@huawei.com>) id 1d94bx-0005Tf-PX
	for qemu-devel@nongnu.org; Fri, 12 May 2017 03:03:38 -0400
References: <1492005921-15664-1-git-send-email-zhang.zhanghailiang@huawei.com>
	<1492005921-15664-6-git-send-email-zhang.zhanghailiang@huawei.com>
	<20170511191555.GB24584@stefanha-x1.localdomain>
From: Hailiang Zhang <zhang.zhanghailiang@huawei.com>
Message-ID: <59155E25.4070606@huawei.com>
Date: Fri, 12 May 2017 15:03:01 +0800
MIME-Version: 1.0
In-Reply-To: <20170511191555.GB24584@stefanha-x1.localdomain>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v4 5/6] replication: Implement block
 replication for shared disk case
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: stefanha@redhat.com, qemu-devel@nongnu.org, kwolf@redhat.com, xiecl.fnst@cn.fujitsu.com, zhangchen.fnst@cn.fujitsu.com, Wen Congyang <wencongyang2@huawei.com>, qemu-block@nongnu.org

On 2017/5/12 3:15, Stefan Hajnoczi wrote:
> On Wed, Apr 12, 2017 at 10:05:20PM +0800, zhanghailiang wrote:
>> @@ -612,6 +644,16 @@ static void replication_do_checkpoint(ReplicationState *rs, Error **errp)
>>                   error_propagate(errp, local_err);
>>                   break;
>>               }
>> +        } else {
>> +            /*
>> +             * For shared disk, we need to force SVM to re-read metadata
>> +             * that is loaded in memory, or there will be inconsistent.
>> +             */
>> +            bdrv_invalidate_cache(s->secondary_disk->bs, &local_err);
> I'm not sure this call has any effect:
>
>      if (!(bs->open_flags & BDRV_O_INACTIVE)) {
>          return;
>      }
>
> Is BDRV_O_INACTIVE set?

No, you are right, it does not take any effect. So should we set this flag for secondary_disk ?
Is it enough to set this flag only, or should we call bdrv_inactivate_recurse() ?
To be honest, i'm not quite familiar with this parts.

Thanks,
Hailiang
