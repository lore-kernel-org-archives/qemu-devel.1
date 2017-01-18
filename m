Received: from eggs.gnu.org ([2001:4830:134:3::10]:55810)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhang.zhanghailiang@huawei.com>) id 1cTkDp-0007N1-T2
	for qemu-devel@nongnu.org; Wed, 18 Jan 2017 01:59:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zhang.zhanghailiang@huawei.com>) id 1cTkDp-0000DI-8p
	for qemu-devel@nongnu.org; Wed, 18 Jan 2017 01:59:53 -0500
References: <1480926904-17596-1-git-send-email-zhang.zhanghailiang@huawei.com>
	<1480926904-17596-3-git-send-email-zhang.zhanghailiang@huawei.com>
	<20170117112531.GG4265@stefanha-x1.localdomain>
From: Hailiang Zhang <zhang.zhanghailiang@huawei.com>
Message-ID: <587F1140.2070702@huawei.com>
Date: Wed, 18 Jan 2017 14:54:56 +0800
MIME-Version: 1.0
In-Reply-To: <20170117112531.GG4265@stefanha-x1.localdomain>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH RFC v2 2/6] replication: add shared-disk
 and shared-disk-id options
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

On 2017/1/17 19:25, Stefan Hajnoczi wrote:
> On Mon, Dec 05, 2016 at 04:35:00PM +0800, zhanghailiang wrote:
>> @@ -85,6 +99,9 @@ static int replication_open(BlockDriverState *bs, QDict *options,
>>       QemuOpts *opts = NULL;
>>       const char *mode;
>>       const char *top_id;
>> +    const char *shared_disk_id;
>> +    BlockBackend *blk;
>> +    BlockDriverState *tmp_bs;
>>
>>       ret = -EINVAL;
>>       opts = qemu_opts_create(&replication_runtime_opts, NULL, 0, &error_abort);
>> @@ -119,6 +136,25 @@ static int replication_open(BlockDriverState *bs, QDict *options,
>>                      "The option mode's value should be primary or secondary");
>>           goto fail;
>>       }
>> +    s->is_shared_disk = qemu_opt_get_bool(opts, REPLICATION_SHARED_DISK,
>> +                                          false);
>> +    if (s->is_shared_disk && (s->mode == REPLICATION_MODE_PRIMARY)) {
>> +        shared_disk_id = qemu_opt_get(opts, REPLICATION_SHARED_DISK_ID);
>> +        if (!shared_disk_id) {
>> +            error_setg(&local_err, "Missing shared disk blk");
>> +            goto fail;
>> +        }
>> +        s->shared_disk_id = g_strdup(shared_disk_id);
>> +        blk = blk_by_name(s->shared_disk_id);
>> +        if (!blk) {
>> +            g_free(s->shared_disk_id);
>> +            error_setg(&local_err, "There is no %s block", s->shared_disk_id);
>> +            goto fail;
>
> Please move the g_free() to the fail label to prevent future code
> changes from introducing a memory leak.
>

OK, I will fix it in next version, thanks very much.
