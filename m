Received: from eggs.gnu.org ([2001:4830:134:3::10]:48025)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhangchen.fnst@cn.fujitsu.com>) id 1dTMkY-0003cT-OA
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 02:28:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zhangchen.fnst@cn.fujitsu.com>) id 1dTMkU-0002jI-RR
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 02:28:22 -0400
Received: from [59.151.112.132] (port=48443 helo=heian.cn.fujitsu.com)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhangchen.fnst@cn.fujitsu.com>) id 1dTMkU-0002iT-Et
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 02:28:18 -0400
References: <1499406231-3877-1-git-send-email-zhangchen.fnst@cn.fujitsu.com>
	<1499406231-3877-2-git-send-email-zhangchen.fnst@cn.fujitsu.com>
	<a759bab5-4042-12c4-9055-a2856d5ffc12@cn.fujitsu.com>
From: Zhang Chen <zhangchen.fnst@cn.fujitsu.com>
Message-ID: <63a954bd-09cc-9d3b-7575-5645aa60250a@cn.fujitsu.com>
Date: Fri, 7 Jul 2017 14:30:18 +0800
MIME-Version: 1.0
In-Reply-To: <a759bab5-4042-12c4-9055-a2856d5ffc12@cn.fujitsu.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Subject: Re: [Qemu-devel] [PATCH 1/4] net/colo-compare.c: Add checkpoint min
 period to optimize performance
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Li Zhijian <lizhijian@cn.fujitsu.com>, qemu devel <qemu-devel@nongnu.org>, Jason Wang <jasowang@redhat.com>
Cc: zhangchen.fnst@cn.fujitsu.com, zhanghailiang <zhang.zhanghailiang@huawei.com>



On 07/07/2017 02:06 PM, Li Zhijian wrote:
>
> On 07/07/2017 01:43 PM, Zhang Chen wrote:
>> If colo-compare find out the first different packet
>
> at this situation, why not trigger the checkpoint, and then flush all 
> primary packets and drop secondary packets?

In this time we already do this job, but before this checkpoint to be done,
a lot of checkpoint has been triggered. It is no sense do many 
checkpoint in very short time.
So we just need do once checkpoint in this situation.

Thanks
Zhang Chen

>
>
>>   that means
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
>>   +/* TODO: Should be configurable */
>> +#define CHECKPOINT_MIN_TIME 3000
>> +
>>   /*
>>     + CompareState ++
>>     |               |
>> @@ -455,6 +458,7 @@ static void colo_compare_connection(void *opaque, 
>> void *user_data)
>>       Packet *pkt = NULL;
>>       GList *result = NULL;
>>       int ret;
>> +    static int64_t checkpoint_time_ms;
>>         while (!g_queue_is_empty(&conn->primary_list) &&
>>              !g_queue_is_empty(&conn->secondary_list)) {
>> @@ -494,7 +498,14 @@ static void colo_compare_connection(void 
>> *opaque, void *user_data)
>>                */
>>               trace_colo_compare_main("packet different");
>>               g_queue_push_tail(&conn->primary_list, pkt);
>> -            /* TODO: colo_notify_checkpoint();*/
>> +
>> +            if (pkt->creation_ms - checkpoint_time_ms > 
>> CHECKPOINT_MIN_TIME) {
>> +                /*
>> +                 * TODO: Notify colo frame to do checkpoint.
>> +                 * colo_compare_inconsistent_notify();
>> +                 */
>> +                checkpoint_time_ms = pkt->creation_ms;
>> +            }
>>               break;
>>           }
>>       }
>

-- 
Thanks
Zhang Chen
