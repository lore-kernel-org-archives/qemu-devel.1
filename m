Received: from eggs.gnu.org ([2001:4830:134:3::10]:57212)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhangchen.fnst@cn.fujitsu.com>) id 1d6Yqt-0006Kk-Ip
	for qemu-devel@nongnu.org; Fri, 05 May 2017 04:44:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zhangchen.fnst@cn.fujitsu.com>) id 1d6Yqp-0006zv-27
	for qemu-devel@nongnu.org; Fri, 05 May 2017 04:44:39 -0400
Received: from [59.151.112.132] (port=7337 helo=heian.cn.fujitsu.com)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhangchen.fnst@cn.fujitsu.com>) id 1d6Yqo-0006uJ-Dz
	for qemu-devel@nongnu.org; Fri, 05 May 2017 04:44:34 -0400
References: <1493372840-24551-1-git-send-email-zhangchen.fnst@cn.fujitsu.com>
	<1493372840-24551-5-git-send-email-zhangchen.fnst@cn.fujitsu.com>
	<d0bb0735-7b25-5236-bbfa-45b751395e7e@redhat.com>
	<c05b73cc-fb91-abc4-2dee-27576df0add7@cn.fujitsu.com>
	<c8cf702f-8fdb-76d1-33bb-037ce495106b@redhat.com>
From: Zhang Chen <zhangchen.fnst@cn.fujitsu.com>
Message-ID: <13c41d79-09fe-26a9-d874-4ac5a942c15b@cn.fujitsu.com>
Date: Fri, 5 May 2017 16:44:11 +0800
MIME-Version: 1.0
In-Reply-To: <c8cf702f-8fdb-76d1-33bb-037ce495106b@redhat.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH V3 04/10] net/filter-mirror.c: Add
 filter-mirror and filter-redirector vnet support.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jason Wang <jasowang@redhat.com>, qemu devel <qemu-devel@nongnu.org>
Cc: zhangchen.fnst@cn.fujitsu.com, zhanghailiang <zhang.zhanghailiang@huawei.com>, Li Zhijian <lizhijian@cn.fujitsu.com>, weifuqiang <weifuqiang@huawei.com>, "eddie . dong" <eddie.dong@intel.com>, bian naimeng <biannm@cn.fujitsu.com>



On 05/03/2017 06:19 PM, Jason Wang wrote:
>
>
> On 2017年05月03日 11:18, Zhang Chen wrote:
>>
>>
>> On 05/02/2017 12:47 PM, Jason Wang wrote:
>>>
>>>
>>> On 2017年04月28日 17:47, Zhang Chen wrote:
>>>> In this patch, we change the send packet format from
>>>> struct {int size; const uint8_t buf[];} to {int size; int 
>>>> vnet_hdr_len; const uint8_t buf[];}.
>>>> make other module(like colo-compare) know how to parse net packet 
>>>> correctly.
>>>>
>>>> Signed-off-by: Zhang Chen <zhangchen.fnst@cn.fujitsu.com>
>>>> ---
>>>>   net/filter-mirror.c | 28 +++++++++++++++++++++++-----
>>>>   1 file changed, 23 insertions(+), 5 deletions(-)
>>>>
>>>> diff --git a/net/filter-mirror.c b/net/filter-mirror.c
>>>> index 72fa7c2..bb9ecf3 100644
>>>> --- a/net/filter-mirror.c
>>>> +++ b/net/filter-mirror.c
>>>> @@ -43,12 +43,14 @@ typedef struct MirrorState {
>>>>       SocketReadState rs;
>>>>   } MirrorState;
>>>>   -static int filter_mirror_send(CharBackend *chr_out,
>>>> +static int filter_mirror_send(MirrorState *s,
>>>>                                 const struct iovec *iov,
>>>>                                 int iovcnt)
>>>>   {
>>>> +    NetFilterState *nf = NETFILTER(s);
>>>>       int ret = 0;
>>>>       ssize_t size = 0;
>>>> +    ssize_t vnet_hdr_len;
>>>>       uint32_t len = 0;
>>>>       char *buf;
>>>>   @@ -58,14 +60,30 @@ static int filter_mirror_send(CharBackend 
>>>> *chr_out,
>>>>       }
>>>>         len = htonl(size);
>>>> -    ret = qemu_chr_fe_write_all(chr_out, (uint8_t *)&len, 
>>>> sizeof(len));
>>>> +    ret = qemu_chr_fe_write_all(&s->chr_out, (uint8_t *)&len, 
>>>> sizeof(len));
>>>> +    if (ret != sizeof(len)) {
>>>> +        goto err;
>>>> +    }
>>>> +
>>>> +    /*
>>>> +     * We send vnet header len make other module(like colo-compare)
>>>> +     * know how to parse net packet correctly.
>>>> +     */
>>>> +    if (qemu_get_using_vnet_hdr(nf->netdev)) {
>>>> +        vnet_hdr_len = qemu_get_vnet_hdr_len(nf->netdev);
>>>> +    } else {
>>>> +        vnet_hdr_len = qemu_get_vnet_hdr_len(nf->netdev->peer);
>>>> +    }
>>>
>>> Any reason to query peer here?
>>
>> That's depend on using NetClientState, If we using nf->netdev that 
>> need to query,
>> Otherwise we query nf->netdev->peer, then we can get the real 
>> vnet_hdr_len in my test.
>>
>> Thanks
>> Zhang Chen 
>
> Confused, I think nf->netdev won't be a nic?

I don't know whether I fully understand.
I think it's depend on the sender, we must query sender to get real 
vnet_hdr_len ,
like that in filter.c:

         if (sender == nf->netdev) {
             /* This packet is sent by netdev itself */
             direction = NET_FILTER_DIRECTION_TX;
         } else {
             direction = NET_FILTER_DIRECTION_RX;
         }

Thanks
Zhang Chen


>
> Thanks
>
>
> .
>

-- 
Thanks
Zhang Chen
