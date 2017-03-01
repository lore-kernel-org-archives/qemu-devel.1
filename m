Received: from eggs.gnu.org ([2001:4830:134:3::10]:39875)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhang.zhanghailiang@huawei.com>) id 1civKk-0000an-Eh
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 22:53:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zhang.zhanghailiang@huawei.com>) id 1civKj-0003AS-Lz
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 22:53:46 -0500
References: <1484884080-28836-1-git-send-email-zhang.zhanghailiang@huawei.com>
	<1484884080-28836-3-git-send-email-zhang.zhanghailiang@huawei.com>
	<20170227171052.GI10201@stefanha-x1.localdomain>
From: Hailiang Zhang <zhang.zhanghailiang@huawei.com>
Message-ID: <58B645AA.3030301@huawei.com>
Date: Wed, 1 Mar 2017 11:53:14 +0800
MIME-Version: 1.0
In-Reply-To: <20170227171052.GI10201@stefanha-x1.localdomain>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 2/6] replication: add shared-disk and
 shared-disk-id options
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: xuquan8@huawei.com, qemu-devel@nongnu.org, qemu-block@nongnu.org, kwolf@redhat.com, mreitz@redhat.com, xiecl.fnst@cn.fujitsu.com, zhangchen.fnst@cn.fujitsu.com, Eric Blake <eblake@redhat.com>, Wen Congyang <wency@cn.fujitsu.com>

On 2017/2/28 1:10, Stefan Hajnoczi wrote:
> On Fri, Jan 20, 2017 at 11:47:56AM +0800, zhanghailiang wrote:
>> @@ -119,12 +136,31 @@ static int replication_open(BlockDriverState *bs, QDict *options,
>>                      "The option mode's value should be primary or secondary");
>>           goto fail;
>>       }
>> +    s->is_shared_disk = qemu_opt_get_bool(opts, REPLICATION_SHARED_DISK,
>> +                                          false);
>> +    if (s->is_shared_disk && (s->mode == REPLICATION_MODE_PRIMARY)) {
>> +        shared_disk_id = qemu_opt_get(opts, REPLICATION_SHARED_DISK_ID);
>> +        if (!shared_disk_id) {
>> +            error_setg(&local_err, "Missing shared disk blk option");
>> +            goto fail;
>> +        }
>> +        s->shared_disk_id = g_strdup(shared_disk_id);
>> +        blk = blk_by_name(s->shared_disk_id);
>> +        if (!blk) {
>> +            error_setg(&local_err, "There is no %s block", s->shared_disk_id);
>> +            goto fail;
>> +        }
>> +        /* We can't access root member of BlockBackend directly */
>> +        tmp_bs = blk_bs(blk);
>> +        s->primary_disk = QLIST_FIRST(&tmp_bs->parents);
>
> Why is this necessary?
>
> We already have the BlockBackend for the primary disk.  I'm not sure why
> the BdrvChild is needed.
>

Er, the helper backup_job_create() needs the BlockDriverState for the primary disk,
besides, we want to make it same with 'secondary_disk' in struct BDRVReplicationState.

Thanks.
Hailiang

> Stefan
>
