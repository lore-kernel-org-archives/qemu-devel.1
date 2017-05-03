Received: from eggs.gnu.org ([2001:4830:134:3::10]:48486)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhangchen.fnst@cn.fujitsu.com>) id 1d5kHS-0004rJ-SA
	for qemu-devel@nongnu.org; Tue, 02 May 2017 22:44:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zhangchen.fnst@cn.fujitsu.com>) id 1d5kHP-0004m0-Ik
	for qemu-devel@nongnu.org; Tue, 02 May 2017 22:44:42 -0400
Received: from [59.151.112.132] (port=56544 helo=heian.cn.fujitsu.com)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhangchen.fnst@cn.fujitsu.com>) id 1d5kHO-0004lL-Eh
	for qemu-devel@nongnu.org; Tue, 02 May 2017 22:44:39 -0400
References: <1493372840-24551-1-git-send-email-zhangchen.fnst@cn.fujitsu.com>
	<1493372840-24551-6-git-send-email-zhangchen.fnst@cn.fujitsu.com>
	<7bde3681-280c-764a-71df-f4a1cc4b7011@redhat.com>
From: Zhang Chen <zhangchen.fnst@cn.fujitsu.com>
Message-ID: <4cc14276-55bc-2981-cbdd-4d66ae6be59e@cn.fujitsu.com>
Date: Wed, 3 May 2017 10:43:31 +0700
MIME-Version: 1.0
In-Reply-To: <7bde3681-280c-764a-71df-f4a1cc4b7011@redhat.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH V3 05/10] net/net.c: Add vnet header length
 to SocketReadState
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jason Wang <jasowang@redhat.com>, qemu devel <qemu-devel@nongnu.org>
Cc: zhangchen.fnst@cn.fujitsu.com, zhanghailiang <zhang.zhanghailiang@huawei.com>, weifuqiang <weifuqiang@huawei.com>, "eddie
	. dong" <eddie.dong@intel.com>, bian naimeng <biannm@cn.fujitsu.com>, Li Zhijian <lizhijian@cn.fujitsu.com>



On 05/02/2017 12:53 PM, Jason Wang wrote:
>
>
> On 2017年04月28日 17:47, Zhang Chen wrote:
>> Address Jason Wang's comments add vnet header length to SocketReadState.
>
> Instead of saying this, you can add "Suggested-by: Jason Wang 
> <jasowang@redhat.com>" above your sign-off.

OK.

>
>> So we change net_fill_rstate() to read
>> struct  {int size; int vnet_hdr_len; const uint8_t buf[];}.
>
> This makes me thinking about the backward compatibility. I think we'd 
> better try to keep it as much as possible. E.g how about pack 
> vnet_hdr_len into higher bits of size?
>

Do you means split uint32_t size to uint16_t size and uint16_t 
vnet_hdr_len ?
If yes, we also can't keep compatibility with old version.
Old code send a uint32_t size, we read it as uint16_t size is always wrong.

Thanks
Zhang Chen


> Thanks
>
>>
>> Signed-off-by: Zhang Chen <zhangchen.fnst@cn.fujitsu.com>
>> ---
>>   include/net/net.h |  4 +++-
>>   net/net.c         | 24 ++++++++++++++++++++++--
>>   2 files changed, 25 insertions(+), 3 deletions(-)
>>
>> diff --git a/include/net/net.h b/include/net/net.h
>> index 402d913..865cb98 100644
>> --- a/include/net/net.h
>> +++ b/include/net/net.h
>> @@ -115,9 +115,11 @@ typedef struct NICState {
>>   } NICState;
>>     struct SocketReadState {
>> -    int state; /* 0 = getting length, 1 = getting data */
>> +    /* 0 = getting length, 1 = getting vnet header length, 2 = 
>> getting data */
>> +    int state;
>>       uint32_t index;
>>       uint32_t packet_len;
>> +    uint32_t vnet_hdr_len;
>>       uint8_t buf[NET_BUFSIZE];
>>       SocketReadStateFinalize *finalize;
>>   };
>> diff --git a/net/net.c b/net/net.c
>> index f69260f..5a6b5ac 100644
>> --- a/net/net.c
>> +++ b/net/net.c
>> @@ -1639,8 +1639,12 @@ int net_fill_rstate(SocketReadState *rs, const 
>> uint8_t *buf, int size)
>>       unsigned int l;
>>         while (size > 0) {
>> -        /* reassemble a packet from the network */
>> -        switch (rs->state) { /* 0 = getting length, 1 = getting data */
>> +        /* Reassemble a packet from the network.
>> +         * 0 = getting length.
>> +         * 1 = getting vnet header length.
>> +         * 2 = getting data.
>> +         */
>> +        switch (rs->state) {
>>           case 0:
>>               l = 4 - rs->index;
>>               if (l > size) {
>> @@ -1658,6 +1662,22 @@ int net_fill_rstate(SocketReadState *rs, const 
>> uint8_t *buf, int size)
>>               }
>>               break;
>>           case 1:
>> +            l = 4 - rs->index;
>> +            if (l > size) {
>> +                l = size;
>> +            }
>> +            memcpy(rs->buf + rs->index, buf, l);
>> +            buf += l;
>> +            size -= l;
>> +            rs->index += l;
>> +            if (rs->index == 4) {
>> +                /* got vnet header length */
>> +                rs->vnet_hdr_len = ntohl(*(uint32_t *)rs->buf);
>> +                rs->index = 0;
>> +                rs->state = 2;
>> +            }
>> +            break;
>> +        case 2:
>>               l = rs->packet_len - rs->index;
>>               if (l > size) {
>>                   l = size;
>
>
>
> .
>

-- 
Thanks
Zhang Chen
