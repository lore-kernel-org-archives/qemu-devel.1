Received: from eggs.gnu.org ([2001:4830:134:3::10]:45526)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhangchen.fnst@cn.fujitsu.com>) id 1cR9tX-0006ug-L0
	for qemu-devel@nongnu.org; Tue, 10 Jan 2017 22:48:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zhangchen.fnst@cn.fujitsu.com>) id 1cR9tU-0004zL-Hl
	for qemu-devel@nongnu.org; Tue, 10 Jan 2017 22:48:15 -0500
Received: from [59.151.112.132] (port=26547 helo=heian.cn.fujitsu.com)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhangchen.fnst@cn.fujitsu.com>) id 1cR9tT-0004rk-FR
	for qemu-devel@nongnu.org; Tue, 10 Jan 2017 22:48:12 -0500
References: <1482831516-21862-1-git-send-email-zhangchen.fnst@cn.fujitsu.com>
	<1482831516-21862-3-git-send-email-zhangchen.fnst@cn.fujitsu.com>
	<e642e588-b874-f7ca-ded6-a5bcaa9dab48@redhat.com>
From: Zhang Chen <zhangchen.fnst@cn.fujitsu.com>
Message-ID: <6a6da191-57fc-f382-8d10-d452e5c974c0@cn.fujitsu.com>
Date: Wed, 11 Jan 2017 11:47:32 +0800
MIME-Version: 1.0
In-Reply-To: <e642e588-b874-f7ca-ded6-a5bcaa9dab48@redhat.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH V5 2/2] Add a new qmp command to do
 checkpoint, query xen replication status
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu devel <qemu-devel@nongnu.org>, zhanghailiang <zhang.zhanghailiang@huawei.com>
Cc: Jason Wang <jasowang@redhat.com>, Li Zhijian <lizhijian@cn.fujitsu.com>, "eddie . dong" <eddie.dong@intel.com>, Bian Naimeng <biannm@cn.fujitsu.com>, Wen Congyang <wencongyang@gmail.com>

Hi~~ Eric:

     I have send the V6 to fix the issues below, Have any comments?


Thanks

Zhang Chen


On 01/05/2017 04:40 AM, Eric Blake wrote:
> On 12/27/2016 03:38 AM, Zhang Chen wrote:
>> We can call this qmp command to do checkpoint outside of qemu.
>> Like Xen colo need this function.
> That sentence is awkward; maybe:
>
> Xen colo will need this function.
>
>> Signed-off-by: Zhang Chen <zhangchen.fnst@cn.fujitsu.com>
>> Signed-off-by: Wen Congyang <wencongyang@gmail.com>
>> ---
>>   docs/qmp-commands.txt | 24 ++++++++++++++++++++++++
>>   migration/colo.c      | 17 +++++++++++++++++
>>   qapi-schema.json      | 50 ++++++++++++++++++++++++++++++++++++++++++++++++++
>>   3 files changed, 91 insertions(+)
>>
>> diff --git a/docs/qmp-commands.txt b/docs/qmp-commands.txt
>> index d182147..a146745 100644
>> --- a/docs/qmp-commands.txt
>> +++ b/docs/qmp-commands.txt
>> @@ -450,6 +450,30 @@ Example:
>>        "arguments": {"enable": true, "primary": false} }
>>   <- { "return": {} }
>>   
>> +query-xen-replication-status
>> +----------------------------
>> +
>> +Query replication status when vm is running.
>> +
>> +Arguments: None.
>> +
>> +Example:
>> +
>> +-> { "execute": "query-xen-replication-status" }
>> +<- { "return": { "status": "normal" } }
>> +
>> +xen-do-checkpoint
>> +-----------------
>> +
>> +Xen use this command to notify replication to do checkpoint.
> s/use/uses/
> s/do/trigger a/
>
>> +
>> +Arguments: None.
>> +
>> +Example:
>> +
>> +-> { "execute": "xen-do-checkpoint" }
>> +<- { "return": {} }
>> +
>>   migrate
>>   -------
>>   
>> diff --git a/migration/colo.c b/migration/colo.c
>> index 6fc2ade..7fc9f8a 100644
>> --- a/migration/colo.c
>> +++ b/migration/colo.c
>> @@ -127,6 +127,23 @@ void qmp_xen_set_replication(bool enable, bool primary,
>>       }
>>   }
>>   
>> +ReplicationErrorResult *qmp_query_xen_replication_status(Error **errp)
>> +{
>> +    Error *err = NULL;
>> +    ReplicationErrorResult *result = g_new0(ReplicationErrorResult, 1);
>> +    replication_get_error_all(&err);
>> +    result->status = err ?
>> +                     REPLICATION_ERROR_STATUS_ERROR :
>> +                     REPLICATION_ERROR_STATUS_NORMAL;
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
>> index 78802f4..6c162a5 100644
>> --- a/qapi-schema.json
>> +++ b/qapi-schema.json
>> @@ -4695,6 +4695,56 @@
>>     'data': { 'enable': 'bool', 'primary': 'bool', '*failover' : 'bool' } }
>>   
>>   ##
>> +# @ReplicationErrorStatus
>> +#
>> +# Describe the status of replication error.
>> +#
>> +# @error: Replication have a error.
> s/have a/has an/
>
>> +#
>> +# @normal:  Replication running normal.
> s/running normal/is running normally/
>
>> +#
>> +# Since 2.9
>> +##
>> +{ 'enum': 'ReplicationErrorStatus',
>> +  'data': [ 'error', 'normal' ] }
>> +
>> +##
>> +# @ReplicationErrorResult
> The name of this struct is misleading (but harmless, since struct names
> are not part of the API).  Better might be: ReplicationStatus
>
>> +#
>> +# The result format for 'xen-get-replication-error'.
> Wrong name; you renamed the command 'query-xen-replication-status'.
>
>> +#
>> +# @status: enum of @ReplicationErrorStatus, which shows current
>> +#          replication error status
>> +#
>> +# Since 2.9
>> +##
>> +{ 'struct': 'ReplicationErrorResult',
>> +  'data': { 'status': 'ReplicationErrorStatus'} }
>> +
>> +##
>> +# @query-xen-replication-status
>> +#
>> +# Query replication error that occurs when the vm is running.
> Since you might extend this in the future, I'd just leave it at:
>
> Query replication status while the vm is running.
>
>> +#
>> +# Returns: A @ReplicationErrorResult objects showing the status.
>> +#
>> +# Since: 2.9
>> +##
>> +{ 'command': 'query-xen-replication-status',
>> +  'returns': 'ReplicationErrorResult' }
> Again, the struct name is misleading.
>
>> +
>> +##
>> +# @xen-do-checkpoint
>> +#
>> +# Xen use this command to notify replication to do checkpoint.
> s/use/uses/
>
>> +#
>> +# Returns: nothing.
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
> Getting closer!
>

-- 
Thanks
Zhang Chen
