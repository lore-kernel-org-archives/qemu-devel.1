Received: from eggs.gnu.org ([2001:4830:134:3::10]:39830)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhang.zhanghailiang@huawei.com>) id 1cTlTe-0002sd-7y
	for qemu-devel@nongnu.org; Wed, 18 Jan 2017 03:20:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zhang.zhanghailiang@huawei.com>) id 1cTlTa-0000BM-3n
	for qemu-devel@nongnu.org; Wed, 18 Jan 2017 03:20:18 -0500
Received: from szxga02-in.huawei.com ([119.145.14.65]:27166)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <zhang.zhanghailiang@huawei.com>) id 1cTlTZ-0008UK-8t
	for qemu-devel@nongnu.org; Wed, 18 Jan 2017 03:20:14 -0500
References: <1484657864-21708-1-git-send-email-zhang.zhanghailiang@huawei.com>
	<1484657864-21708-4-git-send-email-zhang.zhanghailiang@huawei.com>
	<c79e149c-7d0e-76ae-20f5-b99a595650b5@redhat.com>
From: Hailiang Zhang <zhang.zhanghailiang@huawei.com>
Message-ID: <587F2526.70406@huawei.com>
Date: Wed, 18 Jan 2017 16:19:50 +0800
MIME-Version: 1.0
In-Reply-To: <c79e149c-7d0e-76ae-20f5-b99a595650b5@redhat.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 3/3] COLO: Don't process failover request
 while loading VM's state
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: xuquan8@huawei.com, amit.shah@redhat.com, quintela@redhat.com, dgilbert@redhat.com, eddie.dong@intel.com, lizhijian@cn.fujitsu.com, zhangchen.fnst@cn.fujitsu.com

On 2017/1/18 2:24, Eric Blake wrote:
> On 01/17/2017 06:57 AM, zhanghailiang wrote:
>> We should not do failover work while the main thread is loading
>> VM's state. Otherwise the consistent of VM's memory and
>> device state will be broken.
>>
>> We will restart the loading process after jump over the stage,
>> The new failover status 'RELAUNCH' will help to record if we
>> need to restart the process.
>>
>> Cc: Eric Blake <eblake@redhat.com>
>> Signed-off-by: zhanghailiang <zhang.zhanghailiang@huawei.com>
>> Signed-off-by: Li Zhijian <lizhijian@cn.fujitsu.com>
>> Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
>> ---
>>   migration/colo.c | 26 ++++++++++++++++++++++++++
>>   qapi-schema.json |  4 +++-
>>   2 files changed, 29 insertions(+), 1 deletion(-)
>>
>
>> +++ b/qapi-schema.json
>> @@ -856,10 +856,12 @@
>>   #
>>   # @completed: finish the process of failover
>>   #
>> +# @relaunch: restart the failover process, from 'none' -> 'completed'
>
> You'll need to add a '(since 2.9)' tag
>

OK, I'll add it in next version, thanks.

>> +#
>>   # Since: 2.8
>>   ##
>>   { 'enum': 'FailoverStatus',
>> -  'data': [ 'none', 'require', 'active', 'completed'] }
>> +  'data': [ 'none', 'require', 'active', 'completed', 'relaunch' ] }
>>
>>   ##
>>   # @x-colo-lost-heartbeat:
>>
>
