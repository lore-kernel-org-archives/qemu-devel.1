Received: from eggs.gnu.org ([2001:4830:134:3::10]:45662)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhangchen.fnst@cn.fujitsu.com>) id 1ch70T-0002bz-Nn
	for qemu-devel@nongnu.org; Thu, 23 Feb 2017 22:57:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zhangchen.fnst@cn.fujitsu.com>) id 1ch70Q-0007P5-Lc
	for qemu-devel@nongnu.org; Thu, 23 Feb 2017 22:57:21 -0500
Received: from [59.151.112.132] (port=51369 helo=heian.cn.fujitsu.com)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhangchen.fnst@cn.fujitsu.com>) id 1ch70Q-0007Nd-A1
	for qemu-devel@nongnu.org; Thu, 23 Feb 2017 22:57:18 -0500
References: <1487834070-31374-1-git-send-email-zhangchen.fnst@cn.fujitsu.com>
	<1487834070-31374-2-git-send-email-zhangchen.fnst@cn.fujitsu.com>
	<c07b7cf1-20a1-abc2-a59d-f37d43421769@redhat.com>
From: Zhang Chen <zhangchen.fnst@cn.fujitsu.com>
Message-ID: <b7211f64-babe-3832-0d9c-9ccab027f366@cn.fujitsu.com>
Date: Fri, 24 Feb 2017 11:56:33 +0800
MIME-Version: 1.0
In-Reply-To: <c07b7cf1-20a1-abc2-a59d-f37d43421769@redhat.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH V8 1/2] Add a new qmp command to start/stop
 replication
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu devel <qemu-devel@nongnu.org>, zhanghailiang <zhang.zhanghailiang@huawei.com>, Markus Armbruster <armbru@redhat.com>, Stefano Stabellini <sstabellini@kernel.org>
Cc: zhangchen.fnst@cn.fujitsu.com, Jason Wang <jasowang@redhat.com>, Li Zhijian <lizhijian@cn.fujitsu.com>, "eddie . dong" <eddie.dong@intel.com>, bian naimeng <biannm@cn.fujitsu.com>, Wen Congyang <wencongyang@gmail.com>



On 02/23/2017 11:31 PM, Eric Blake wrote:
> On 02/23/2017 01:14 AM, Zhang Chen wrote:
>> We can call this qmp command to start/stop replication outside of qemu.
>> Like Xen colo need this function.
>>
>> Signed-off-by: Zhang Chen <zhangchen.fnst@cn.fujitsu.com>
>> Signed-off-by: Wen Congyang <wencongyang@gmail.com>
>> Reviewed-by: Eric Blake <eblake@redhat.com>
>> Reviewed-by: Stefano Stabellini <sstabellini@kernel.org>
>> Reviewed-by: zhanghailiang <zhang.zhanghailiang@huawei.com>
>>
>> ---
>> @@ -104,6 +106,27 @@ void colo_do_failover(MigrationState *s)
>>       }
>>   }
>>   
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
>> +        return;
>> +    }
>> +
>> +    if (enable) {
>> +        replication_start_all(mode, errp);
>> +    } else {
>> +        replication_stop_all(failover, failover ? NULL : errp);
> Technically, this is use of failover without first checking
> has_failover; it would be safer if you inserted:
>
> if (!has_failover) {
>      failover = NULL;
> }

OK, I will insert this code in next version.

Thanks
Zhang Chen

> earlier in the function to be safe against any callers that don't go
> through the QAPI-generated code.  Fortunately, our QAPI generated code
> guarantees that failover is NULL when has_failover is false, so my R-b
> can stand as-is if there is no other reason for a respin.

-- 
Thanks
Zhang Chen
