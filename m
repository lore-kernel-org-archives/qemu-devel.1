Received: from eggs.gnu.org ([2001:4830:134:3::10]:44169)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhang.zhanghailiang@huawei.com>) id 1d941F-0007t1-90
	for qemu-devel@nongnu.org; Fri, 12 May 2017 02:25:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zhang.zhanghailiang@huawei.com>) id 1d941E-00088V-45
	for qemu-devel@nongnu.org; Fri, 12 May 2017 02:25:41 -0400
References: <1492005921-15664-1-git-send-email-zhang.zhanghailiang@huawei.com>
	<1492005921-15664-3-git-send-email-zhang.zhanghailiang@huawei.com>
	<58F5AB45.1050505@cn.fujitsu.com>
From: Hailiang Zhang <zhang.zhanghailiang@huawei.com>
Message-ID: <59155546.1080109@huawei.com>
Date: Fri, 12 May 2017 14:25:10 +0800
MIME-Version: 1.0
In-Reply-To: <58F5AB45.1050505@cn.fujitsu.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v4 2/6] replication: add shared-disk and
 shared-disk-id options
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: xiechanglong.d@gmail.com, stefanha@redhat.com, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, kwolf@redhat.com, zhangchen.fnst@cn.fujitsu.com, Wen Congyang <wency@cn.fujitsu.com>

On 2017/4/18 13:59, Xie Changlong wrote:
>
> On 04/12/2017 10:05 PM, zhanghailiang wrote:
>> We use these two options to identify which disk is
>> shared
>>
>> Signed-off-by: zhanghailiang <zhang.zhanghailiang@huawei.com>
>> Signed-off-by: Wen Congyang <wency@cn.fujitsu.com>
>> Signed-off-by: Zhang Chen <zhangchen.fnst@cn.fujitsu.com>
>> ---
>> v4:
>> - Add proper comment for primary_disk (Stefan)
>> v2:
>> - Move g_free(s->shared_disk_id) to the common fail process place (Stefan)
>> - Fix comments for these two options
>> ---
>>    block/replication.c  | 43 +++++++++++++++++++++++++++++++++++++++++--
>>    qapi/block-core.json | 10 +++++++++-
>>    2 files changed, 50 insertions(+), 3 deletions(-)
>>
>> diff --git a/block/replication.c b/block/replication.c
>> index bf3c395..418b81b 100644
>> --- a/block/replication.c
>> +++ b/block/replication.c
>> @@ -25,9 +25,12 @@
>>    typedef struct BDRVReplicationState {
>>        ReplicationMode mode;
>>        int replication_state;
>> +    bool is_shared_disk;
>> +    char *shared_disk_id;
>>        BdrvChild *active_disk;
>>        BdrvChild *hidden_disk;
>>        BdrvChild *secondary_disk;
>> +    BdrvChild *primary_disk;
>>        char *top_id;
>>        ReplicationState *rs;
>>        Error *blocker;
>> @@ -53,6 +56,9 @@ static void replication_stop(ReplicationState *rs, bool failover,
>>    
>>    #define REPLICATION_MODE        "mode"
>>    #define REPLICATION_TOP_ID      "top-id"
>> +#define REPLICATION_SHARED_DISK "shared-disk"
>> +#define REPLICATION_SHARED_DISK_ID "shared-disk-id"
>> +
>>    static QemuOptsList replication_runtime_opts = {
>>        .name = "replication",
>>        .head = QTAILQ_HEAD_INITIALIZER(replication_runtime_opts.head),
>> @@ -65,6 +71,14 @@ static QemuOptsList replication_runtime_opts = {
>>                .name = REPLICATION_TOP_ID,
>>                .type = QEMU_OPT_STRING,
>>            },
>> +        {
>> +            .name = REPLICATION_SHARED_DISK_ID,
>> +            .type = QEMU_OPT_STRING,
>> +        },
>> +        {
>> +            .name = REPLICATION_SHARED_DISK,
>> +            .type = QEMU_OPT_BOOL,
>> +        },
>>            { /* end of list */ }
>>        },
>>    };
>> @@ -85,6 +99,9 @@ static int replication_open(BlockDriverState *bs, QDict *options,
>>        QemuOpts *opts = NULL;
>>        const char *mode;
>>        const char *top_id;
>> +    const char *shared_disk_id;
>> +    BlockBackend *blk;
>> +    BlockDriverState *tmp_bs;
>>    
>>        bs->file = bdrv_open_child(NULL, options, "file", bs, &child_file,
>>                                   false, errp);
>> @@ -125,12 +142,33 @@ static int replication_open(BlockDriverState *bs, QDict *options,
>>                       "The option mode's value should be primary or secondary");
>>            goto fail;
>>        }
>> +    s->is_shared_disk = qemu_opt_get_bool(opts, REPLICATION_SHARED_DISK,
>> +
> What If secondary side is supplied with 'REPLICATION_SHARED_DISK_ID'?
> Pls refer f4f2539bc to pefect the logical.

Hmm, we should not configure it for secondary side, i'll fix it in next version.


>>                                           false);
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
>> +        /* We have a BlockBackend for the primary disk but use BdrvChild for
>> +         * consistency - active_disk, secondary_disk, etc are also BdrvChild.
>> +         */
>> +        tmp_bs = blk_bs(blk);
>> +        s->primary_disk = QLIST_FIRST(&tmp_bs->parents);
>> +    }
>>    
>>        s->rs = replication_new(bs, &replication_ops);
>>    
>> -    ret = 0;
>> -
>> +    qemu_opts_del(opts);
>> +    return 0;
>>    fail:
>> +    g_free(s->shared_disk_id);
>>        qemu_opts_del(opts);
>>        error_propagate(errp, local_err);
>>    
>> @@ -141,6 +179,7 @@ static void replication_close(BlockDriverState *bs)
>>    {
>>        BDRVReplicationState *s = bs->opaque;
>>    
>> +    g_free(s->shared_disk_id);
>>        if (s->replication_state == BLOCK_REPLICATION_RUNNING) {
>>            replication_stop(s->rs, false, NULL);
>>        }
>> diff --git a/qapi/block-core.json b/qapi/block-core.json
>> index 033457c..361c932 100644
>> --- a/qapi/block-core.json
>> +++ b/qapi/block-core.json
>> @@ -2661,12 +2661,20 @@
>>    #          node who owns the replication node chain. Must not be given in
>>    #          primary mode.
>>    #
>> +# @shared-disk-id: Id of shared disk while is replication mode, if @shared-disk
>> +#                  is true, this option is required (Since: 2.10)
>> +#
> Further explanations:
>
> For @shared-disk-id, it must/only be given when @shared-disk enable on
> Primary side.

OK.
>> +# @shared-disk: To indicate whether or not a disk is shared by primary VM
>> +#               and secondary VM. (The default is false) (Since: 2.10)
>> +#
> Further explanations:
>
> For @shared-disk, it must be given or not-given on both side at the same
> time.

OK, will fix it, thanks.

>>    # Since: 2.9
>>    ##
>>    { 'struct': 'BlockdevOptionsReplication',
>>      'base': 'BlockdevOptionsGenericFormat',
>>      'data': { 'mode': 'ReplicationMode',
>> -            '*top-id': 'str' } }
>> +            '*top-id': 'str',
>> +            '*shared-disk-id': 'str',
>> +            '*shared-disk': 'bool' } }
>>    
>>    ##
>>    # @NFSTransport:
>
>
>
> .
>
