Received: from eggs.gnu.org ([2001:4830:134:3::10]:43338)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhangchen.fnst@cn.fujitsu.com>) id 1cFBZV-0005ZX-FL
	for qemu-devel@nongnu.org; Thu, 08 Dec 2016 22:10:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zhangchen.fnst@cn.fujitsu.com>) id 1cFBZS-0005Sk-9S
	for qemu-devel@nongnu.org; Thu, 08 Dec 2016 22:10:05 -0500
Received: from [59.151.112.132] (port=19342 helo=heian.cn.fujitsu.com)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhangchen.fnst@cn.fujitsu.com>) id 1cFBZR-0005QI-JK
	for qemu-devel@nongnu.org; Thu, 08 Dec 2016 22:10:02 -0500
References: <1481183716-7342-1-git-send-email-zhangchen.fnst@cn.fujitsu.com>
	<1481183716-7342-3-git-send-email-zhangchen.fnst@cn.fujitsu.com>
	<8be72d20-30c4-82f1-ba6c-300176f3f94d@redhat.com>
From: Zhang Chen <zhangchen.fnst@cn.fujitsu.com>
Message-ID: <0f0eedb0-ac07-8804-51a7-f3e268dbcf66@cn.fujitsu.com>
Date: Fri, 9 Dec 2016 11:09:30 +0800
MIME-Version: 1.0
In-Reply-To: <8be72d20-30c4-82f1-ba6c-300176f3f94d@redhat.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH for-2.9 V2 2/3] Add a new qmp command to
 start/stop replication
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu devel <qemu-devel@nongnu.org>, Jason Wang <jasowang@redhat.com>
Cc: Li Zhijian <lizhijian@cn.fujitsu.com>, zhanghailiang <zhang.zhanghailiang@huawei.com>, "eddie . dong" <eddie.dong@intel.com>, Bian Naimeng <biannm@cn.fujitsu.com>, Changlong Xie <xiecl.fnst@cn.fujitsu.com>



On 12/08/2016 11:38 PM, Eric Blake wrote:
> On 12/08/2016 01:55 AM, Zhang Chen wrote:
>> We can call this qmp command to start/stop replication outside of qemu.
>> Like Xen colo need this function.
>>
>> Signed-off-by: Zhang Chen <zhangchen.fnst@cn.fujitsu.com>
>> ---
>>   docs/qmp-commands.txt | 17 +++++++++++++++++
>>   migration/colo.c      | 22 ++++++++++++++++++++++
>>   qapi-schema.json      | 19 +++++++++++++++++++
>>   3 files changed, 58 insertions(+)
>>
>> diff --git a/docs/qmp-commands.txt b/docs/qmp-commands.txt
>> index abf210a..f7bae0d 100644
>> --- a/docs/qmp-commands.txt
>> +++ b/docs/qmp-commands.txt
>> @@ -432,6 +432,23 @@ Example:
>>        "arguments": { "enable": true } }
>>   <- { "return": {} }
>>   
>> +xen-set-replication
>> +-------
> Much of this file tries to match the ----- divider lines to the length
> of the line above it (you're short by the length of '-replication')

OK~ I will add '----' match the length of '-replication',
and I find some command have same problem like 'xen-set-global-dirty-log',
Should I send another patch to fix it?

>
>> +
>> +Enable or disable replication.
>> +
>> +Arguments:
>> +
>> +- "enable": Enable it or disable it.
>> +- "primary": True for primary or false for secondary
> We aren't very consistent on whether to end in '.'

I will fix it.

>> +- "failover": Enable to do failover when stoping replcation
> "failover": Enable failover when stopping replication (optional, default
> false)

I got it.

>
>> +void qmp_xen_set_replication(bool enable, bool primary,
>> +                             bool has_failover, bool failover,
>> +                             Error **errp)
>> +{
>> +    ReplicationMode mode = primary ?
>> +                           REPLICATION_MODE_PRIMARY :
>> +                           REPLICATION_MODE_SECONDARY;
>> +
>> +    if (has_failover && enable) {
>> +        error_setg(errp, "Parameter 'failover' is only for"
>> +                   " stopping replication");
> At this point, errp is set, but you fall through...

I will add a 'return' here.

>
>> +    }
>> +
>> +    if (enable) {
>> +        replication_start_all(mode, errp);
> and could abort if something else also tries to set errp.  Simplest is
> to add a return; statement after error_setg().

Yes.

>> +    } else {
>> +        replication_stop_all(failover, failover ? NULL : errp);
>> +    }
>> +}
>> +
>>   static void colo_send_message(QEMUFile *f, COLOMessage msg,
>>                                 Error **errp)
>>   {
>> diff --git a/qapi-schema.json b/qapi-schema.json
>> index f3e9bfc..f67b0a3 100644
>> --- a/qapi-schema.json
>> +++ b/qapi-schema.json
>> @@ -4676,6 +4676,25 @@
>>   { 'command': 'xen-load-devices-state', 'data': {'filename': 'str'} }
>>   
>>   ##
>> +# @xen-set-replication
>> +#
>> +# Enable or disable replication
>> +#
>> +# @enable: true to enable, false to disable.
>> +#
>> +# @primary: true for primary or false for secondary
>> +#
>> +# @failover: #optional true to do failover, false to stop.
>> +#            default value is false.
> May want to additionally document that 'failover' cannot be specified if
> 'enable' is true.

OK.

Thanks
Zhang Chen

>> +#
>> +# Returns: nothing
>> +#
>> +# Since: 2.9
>> +##
>> +{ 'command': 'xen-set-replication',
>> +  'data': { 'enable': 'bool', 'primary': 'bool', '*failover' : 'bool' } }
>> +
>> +##
>>   # @GICCapability:
>>   #
>>   # The struct describes capability for a specific GIC (Generic
>>

-- 
Thanks
zhangchen
