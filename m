Received: from eggs.gnu.org ([2001:4830:134:3::10]:48297)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhangchen.fnst@cn.fujitsu.com>) id 1dX2Mk-0002US-Jb
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 05:30:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zhangchen.fnst@cn.fujitsu.com>) id 1dX2Mg-0004ek-1d
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 05:30:58 -0400
Received: from [59.151.112.132] (port=37996 helo=heian.cn.fujitsu.com)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhangchen.fnst@cn.fujitsu.com>) id 1dX2Mf-0004e1-4A
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 05:30:53 -0400
References: <1499925175-21218-1-git-send-email-zhangchen.fnst@cn.fujitsu.com>
	<1499925175-21218-2-git-send-email-zhangchen.fnst@cn.fujitsu.com>
	<20170714121040.GC2091@work-vm>
From: Zhang Chen <zhangchen.fnst@cn.fujitsu.com>
Message-ID: <3d3a3ab5-5fff-ed4a-c88c-7e1595cd94c1@cn.fujitsu.com>
Date: Mon, 17 Jul 2017 17:33:20 +0800
MIME-Version: 1.0
In-Reply-To: <20170714121040.GC2091@work-vm>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Subject: Re: [Qemu-devel] [PATCH V2 1/4] net/colo-compare.c: Add checkpoint
 min period to optimize performance
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: zhangchen.fnst@cn.fujitsu.com, qemu devel <qemu-devel@nongnu.org>, Jason Wang <jasowang@redhat.com>, Li Zhijian <lizhijian@cn.fujitsu.com>, zhanghailiang <zhang.zhanghailiang@huawei.com>



On 07/14/2017 08:10 PM, Dr. David Alan Gilbert wrote:
> * Zhang Chen (zhangchen.fnst@cn.fujitsu.com) wrote:
>> If colo-compare find out the first different packet that means
>> the following packet almost is different. we needn't do a lot
>> of checkpoint in this time, so we set the no-need-checkpoint
>> peroid, default just set 3 second.
>>
>> Signed-off-by: Zhang Chen <zhangchen.fnst@cn.fujitsu.com>
>> ---
>>   net/colo-compare.c | 13 ++++++++++++-
>>   1 file changed, 12 insertions(+), 1 deletion(-)
>>
>> diff --git a/net/colo-compare.c b/net/colo-compare.c
>> index 6d500e1..0f8e198 100644
>> --- a/net/colo-compare.c
>> +++ b/net/colo-compare.c
>> @@ -40,6 +40,9 @@
>>   /* TODO: Should be configurable */
>>   #define REGULAR_PACKET_CHECK_MS 3000
>>   
>> +/* TODO: Should be configurable */
> Yes it should!
>
>> +#define CHECKPOINT_MIN_TIME 3000
>> +
>>   /*
>>     + CompareState ++
>>     |               |
>> @@ -455,6 +458,7 @@ static void colo_compare_connection(void *opaque, void *user_data)
>>       Packet *pkt = NULL;
>>       GList *result = NULL;
>>       int ret;
>> +    static int64_t checkpoint_time_ms;
>>   
>>       while (!g_queue_is_empty(&conn->primary_list) &&
>>              !g_queue_is_empty(&conn->secondary_list)) {
>> @@ -494,7 +498,14 @@ static void colo_compare_connection(void *opaque, void *user_data)
>>                */
>>               trace_colo_compare_main("packet different");
>>               g_queue_push_tail(&conn->primary_list, pkt);
>> -            /* TODO: colo_notify_checkpoint();*/
>> +
>> +            if (pkt->creation_ms - checkpoint_time_ms > CHECKPOINT_MIN_TIME) {
>> +                /*
>> +                 * TODO: Notify colo frame to do checkpoint.
>> +                 * colo_compare_inconsistent_notify();
>> +                 */
>> +                checkpoint_time_ms = pkt->creation_ms;
>> +            }
> You need to be careful how this interacts with the actual start of the
> checkpoint.   Lets say you have two miscompared packets close to each
> other:
>
>
>      miscompare!
>           checkpoint
>      miscompare!
>           ignore it because it was close to the 1st one
>
>     That means we never trigger the 2nd checkpoint and it'll carry on
> until the maximum checkpoint length.
>
>     But also, I think you need to consider what happens to future packets
> being compared; you can't release any packets now until the checkpoint
> as soon as you know there's a miscompare.

We need some time to do the checkpoint, and in this period we can ignore
the miscompare to get better performance. Like that:

currently:

     miscompare!
          notify checkpoint
     miscompare!
          notify checkpoint
     miscompare!
          notify checkpoint
     miscompare!
          notify checkpoint
     vm_stop and do checkpoint

     vm_start and finish checkpoint

     vm_stop and do checkpoint

     vm_start and finish checkpoint

     vm_stop and do checkpoint

     vm_start and finish checkpoint

     vm_stop and do checkpoint

     vm_start and finish checkpoint


running normally.


after:

     miscompare!
          notify checkpoint
     miscompare!
          ignore
     miscompare!
          ignore
     miscompare!
          ignore
     vm_stop and do checkpoint

     vm_start and finish checkpoint

running normally.



Thanks
Zhang Chen
  


>
> Dave
>
>>               break;
>
>>           }
>>       }
>> -- 
>> 2.7.4
>>
>>
>>
>>
> --
> Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
>
>
> .
>

-- 
Thanks
Zhang Chen
