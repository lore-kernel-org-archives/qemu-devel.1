Received: from eggs.gnu.org ([2001:4830:134:3::10]:38815)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhangchen.fnst@cn.fujitsu.com>) id 1dWzhi-00073L-8G
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 02:40:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zhangchen.fnst@cn.fujitsu.com>) id 1dWzhd-00027i-O7
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 02:40:26 -0400
Received: from [59.151.112.132] (port=51094 helo=heian.cn.fujitsu.com)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhangchen.fnst@cn.fujitsu.com>) id 1dWzhd-00020X-Bn
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 02:40:21 -0400
References: <1499925175-21218-1-git-send-email-zhangchen.fnst@cn.fujitsu.com>
	<1499925175-21218-2-git-send-email-zhangchen.fnst@cn.fujitsu.com>
	<80774faf-ebc4-4ffa-feb6-211b63495339@redhat.com>
From: Zhang Chen <zhangchen.fnst@cn.fujitsu.com>
Message-ID: <b3bfd799-e2f0-9ea3-27c5-8de6c2426322@cn.fujitsu.com>
Date: Mon, 17 Jul 2017 14:42:33 +0800
MIME-Version: 1.0
In-Reply-To: <80774faf-ebc4-4ffa-feb6-211b63495339@redhat.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
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
To: Jason Wang <jasowang@redhat.com>, qemu devel <qemu-devel@nongnu.org>
Cc: zhangchen.fnst@cn.fujitsu.com, zhanghailiang <zhang.zhanghailiang@huawei.com>, Li Zhijian <lizhijian@cn.fujitsu.com>



On 07/14/2017 11:22 AM, Jason Wang wrote:
>
>
> On 2017年07月13日 13:52, Zhang Chen wrote:
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
>
> Let's avoid static variable here since we support more than one 
> compare instance.

OK, I will add the "checkpoint_time_ms" to CompareState.

Thanks
Zhang Chen

>
> Thanks
>
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
>
>
> .
>

-- 
Thanks
Zhang Chen
