Received: from eggs.gnu.org ([2001:4830:134:3::10]:59655)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhangchen.fnst@cn.fujitsu.com>) id 1cgAJo-0005CG-MH
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 08:17:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zhangchen.fnst@cn.fujitsu.com>) id 1cgAJk-00035v-4U
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 08:17:24 -0500
Received: from [59.151.112.132] (port=25769 helo=heian.cn.fujitsu.com)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhangchen.fnst@cn.fujitsu.com>) id 1cgAJj-00034l-7t
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 08:17:20 -0500
References: <1486531462-13882-1-git-send-email-zhangchen.fnst@cn.fujitsu.com>
	<1486531462-13882-3-git-send-email-zhangchen.fnst@cn.fujitsu.com>
	<58AC3A15.7090800@huawei.com>
From: Zhang Chen <zhangchen.fnst@cn.fujitsu.com>
Message-ID: <c4e11c8f-ab12-54fb-9bda-d9ec6126e7e6@cn.fujitsu.com>
Date: Tue, 21 Feb 2017 21:16:31 +0800
MIME-Version: 1.0
In-Reply-To: <58AC3A15.7090800@huawei.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH V7 2/2] Add a new qmp command to do
 checkpoint, query xen replication status
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Hailiang Zhang <zhang.zhanghailiang@huawei.com>, qemu devel <qemu-devel@nongnu.org>, Eric Blake <eblake@redhat.com>
Cc: zhangchen.fnst@cn.fujitsu.com, xuquan8@huawei.com, Li Zhijian <lizhijian@cn.fujitsu.com>, Jason Wang <jasowang@redhat.com>, "eddie . dong" <eddie.dong@intel.com>, Wen Congyang <wencongyang@gmail.com>, bian naimeng <biannm@cn.fujitsu.com>



On 02/21/2017 09:01 PM, Hailiang Zhang wrote:
> On 2017/2/8 13:24, Zhang Chen wrote:
>> We can call this qmp command to do checkpoint outside of qemu.
>> Xen colo will need this function.
>>
>> Signed-off-by: Zhang Chen <zhangchen.fnst@cn.fujitsu.com>
>> Signed-off-by: Wen Congyang <wencongyang@gmail.com>
>> ---
>>   migration/colo.c | 17 ++++++++++++++++
>>   qapi-schema.json | 60 
>> ++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>>   2 files changed, 77 insertions(+)
>>
>> diff --git a/migration/colo.c b/migration/colo.c
>> index 6fc2ade..2f98a33 100644
>> --- a/migration/colo.c
>> +++ b/migration/colo.c
>> @@ -127,6 +127,23 @@ void qmp_xen_set_replication(bool enable, bool 
>> primary,
>>       }
>>   }
>>
>> +ReplicationResult *qmp_query_xen_replication_status(Error **errp)
>> +{
>> +    Error *err = NULL;
>> +    ReplicationResult *result = g_new0(ReplicationResult, 1);
>
> Indent, line break.

OK~~ will fix in next version.

>
>> +    replication_get_error_all(&err);
>> +    result->status = err ?
>> +                     REPLICATION_STATUS_ERROR :
>> +                     REPLICATION_STATUS_NORMAL;
>> +    error_free(err);
>> +    return result;
>> +}
>> +
>> +void qmp_xen_do_checkpoint(Error **errp)
>> +{
>> +    replication_do_checkpoint_all(errp);
>> +}
>> +
>>   static void colo_send_message(QEMUFile *f, COLOMessage msg,
>>                                 Error **errp)
>>   {
>> diff --git a/qapi-schema.json b/qapi-schema.json
>> index 9445b93..719744a 100644
>> --- a/qapi-schema.json
>> +++ b/qapi-schema.json
>> @@ -5931,6 +5931,66 @@
>>     'data': { 'enable': 'bool', 'primary': 'bool', '*failover' : 
>> 'bool' } }
>>
>>   ##
>> +# @ReplicationStatus:
>> +#
>> +# Describe the status of replication.
>> +#
>> +# @error: Replication has an error.
>> +#
>> +# @normal: Replication is running normally.
>> +#
>> +# Since: 2.9
>> +##
>> +{ 'enum': 'ReplicationStatus',
>> +  'data': [ 'error', 'normal' ] }
>> +
>> +##
>> +# @ReplicationResult:
>> +#
>> +# The result format for 'query-xen-replication-status'.
>> +#
>> +# @status: enum of @ReplicationStatus, which shows current
>> +#          replication error status
>> +#
>> +# Since: 2.9
>> +##
>> +{ 'struct': 'ReplicationResult',
>> +  'data': { 'status': 'ReplicationStatus'} }
>                                            ^ Space

OK.

>
>> +
>> +##
>> +# @query-xen-replication-status:
>> +#
>> +# Query replication status while the vm is running.
>> +#
>> +# Returns: A @ReplicationResult objects showing the status.
>> +#
>> +# Example:
>> +#
>> +# -> { "execute": "query-xen-replication-status" }
>> +# <- { "return": { "status": "normal" } }
>> +#
>> +# Since: 2.9
>> +##
>> +{ 'command': 'query-xen-replication-status',
>> +  'returns': 'ReplicationResult' }
>> +
>> +##
>> +# @xen-do-checkpoint:
>> +#
>
> Maybe use the name 'xen-checkpoint-notify' or 
> 'xen-colo-checkpoint-notify' ?

I will change the name to 'xen-colo-checkpoint-notify'.

Thank
Zhang Chen

>
>> +# Xen uses this command to notify replication to trigger a checkpoint.
>> +#
>> +# Returns: nothing.
>> +#
>> +# Example:
>> +#
>> +# -> { "execute": "xen-do-checkpoint" }
>> +# <- { "return": {} }
>> +#
>> +# Since: 2.9
>> +##
>> +{ 'command': 'xen-do-checkpoint' }
>> +
>> +##
>>   # @GICCapability:
>>   #
>>   # The struct describes capability for a specific GIC (Generic
>>
>
>
>
> .
>

-- 
Thanks
Zhang Chen
