Received: from eggs.gnu.org ([2001:4830:134:3::10]:46320)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhangchen.fnst@cn.fujitsu.com>) id 1cg9Vr-0007gJ-T9
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 07:25:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zhangchen.fnst@cn.fujitsu.com>) id 1cg9Vn-0005ma-TE
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 07:25:47 -0500
Received: from [59.151.112.132] (port=25354 helo=heian.cn.fujitsu.com)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhangchen.fnst@cn.fujitsu.com>) id 1cg9Vm-0005m2-Kp
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 07:25:43 -0500
References: <1486531462-13882-1-git-send-email-zhangchen.fnst@cn.fujitsu.com>
	<1486531462-13882-3-git-send-email-zhangchen.fnst@cn.fujitsu.com>
	<8760k3zteg.fsf@dusky.pond.sub.org>
From: Zhang Chen <zhangchen.fnst@cn.fujitsu.com>
Message-ID: <3f2d885b-f4c3-e26c-348b-b3996ad5410e@cn.fujitsu.com>
Date: Tue, 21 Feb 2017 20:24:55 +0800
MIME-Version: 1.0
In-Reply-To: <8760k3zteg.fsf@dusky.pond.sub.org>
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
To: Markus Armbruster <armbru@redhat.com>
Cc: zhangchen.fnst@cn.fujitsu.com, qemu devel <qemu-devel@nongnu.org>, Eric Blake <eblake@redhat.com>, Li Zhijian <lizhijian@cn.fujitsu.com>, Jason Wang <jasowang@redhat.com>, "eddie . dong" <eddie.dong@intel.com>, Wen Congyang <wencongyang@gmail.com>, bian naimeng <biannm@cn.fujitsu.com>



On 02/21/2017 07:15 PM, Markus Armbruster wrote:
> Zhang Chen <zhangchen.fnst@cn.fujitsu.com> writes:
>
>> We can call this qmp command to do checkpoint outside of qemu.
>> Xen colo will need this function.
> I know nothing about "Xen colo", but I'll try anyway.
>
> I *guess* "Xen colo" is a long-running activity, and the new commands
> interact with it.  Correct?

Yes, you are right.
By the way this patch has been reviewed by Eric black.

https://lists.nongnu.org/archive/html/qemu-devel/2017-02/msg03435.html



>
>> Signed-off-by: Zhang Chen <zhangchen.fnst@cn.fujitsu.com>
>> Signed-off-by: Wen Congyang <wencongyang@gmail.com>
>> ---
>>   migration/colo.c | 17 ++++++++++++++++
>>   qapi-schema.json | 60 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>>   2 files changed, 77 insertions(+)
>>
>> diff --git a/migration/colo.c b/migration/colo.c
>> index 6fc2ade..2f98a33 100644
>> --- a/migration/colo.c
>> +++ b/migration/colo.c
>> @@ -127,6 +127,23 @@ void qmp_xen_set_replication(bool enable, bool primary,
>>       }
>>   }
>>   
>> +ReplicationResult *qmp_query_xen_replication_status(Error **errp)
>> +{
>> +    Error *err = NULL;
>> +    ReplicationResult *result = g_new0(ReplicationResult, 1);
>> +    replication_get_error_all(&err);
>> +    result->status = err ?
>> +                     REPLICATION_STATUS_ERROR :
>> +                     REPLICATION_STATUS_NORMAL;
> Reports only that there is an error, throws away the actual error
> message.  Naive question: could the error message be good to know for
> the QMP user?

Yes, Xen colo will handle it.

>
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
>>     'data': { 'enable': 'bool', 'primary': 'bool', '*failover' : 'bool' } }
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
> Do you expect more status values in the future?
>
> If yes, what should clients do when they see a status value they don't
> know?

We will add other status for it, now, that's enough.

>
> If no, why not simply use bool?
>
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
> The naming is a bit unfortunate: query-xen-replication-status returns
> ReplicationResult, which contains ReplicationStatus.

I will change the name in next version.

Thanks
Zhang Chen

>
>> +
>> +##
>> +# @xen-do-checkpoint:
>> +#
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
>
> .
>

-- 
Thanks
Zhang Chen
