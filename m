Received: from eggs.gnu.org ([2001:4830:134:3::10]:44064)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhangchen.fnst@cn.fujitsu.com>) id 1dAAWV-0003xi-Nl
	for qemu-devel@nongnu.org; Mon, 15 May 2017 03:34:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zhangchen.fnst@cn.fujitsu.com>) id 1dAAWS-0001LY-JI
	for qemu-devel@nongnu.org; Mon, 15 May 2017 03:34:31 -0400
Received: from [59.151.112.132] (port=48220 helo=heian.cn.fujitsu.com)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhangchen.fnst@cn.fujitsu.com>) id 1dAAWR-0001Jq-Jv
	for qemu-devel@nongnu.org; Mon, 15 May 2017 03:34:28 -0400
References: <1494553288-30764-1-git-send-email-zhangchen.fnst@cn.fujitsu.com>
	<1494553288-30764-4-git-send-email-zhangchen.fnst@cn.fujitsu.com>
	<86fb06ff-fe11-17db-7abd-5327d7bd69a9@redhat.com>
From: Zhang Chen <zhangchen.fnst@cn.fujitsu.com>
Message-ID: <5ac3897b-6843-9f6f-63a9-44841850a2bf@cn.fujitsu.com>
Date: Mon, 15 May 2017 15:34:28 +0800
MIME-Version: 1.0
In-Reply-To: <86fb06ff-fe11-17db-7abd-5327d7bd69a9@redhat.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH V4 03/12] net/filter-mirror.c: Make
 filter_mirror_send support vnet support.
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



On 05/15/2017 11:28 AM, Jason Wang wrote:
>
>
> On 2017年05月12日 09:41, Zhang Chen wrote:
>> In this patch, if vnet_hdr=on we change the send packet format from
>> struct {int size; const uint8_t buf[];} to {int size; int 
>> vnet_hdr_len; const uint8_t buf[];}.
>> make other module(like colo-compare) know how to parse net packet 
>> correctly.
>>
>> Signed-off-by: Zhang Chen <zhangchen.fnst@cn.fujitsu.com>
>> ---
>>   net/filter-mirror.c | 35 ++++++++++++++++++++++++++++++-----
>>   1 file changed, 30 insertions(+), 5 deletions(-)
>>
>> diff --git a/net/filter-mirror.c b/net/filter-mirror.c
>> index 3766414..64323fc 100644
>> --- a/net/filter-mirror.c
>> +++ b/net/filter-mirror.c
>> @@ -44,10 +44,11 @@ typedef struct MirrorState {
>>       SocketReadState rs;
>>   } MirrorState;
>>   -static int filter_mirror_send(CharBackend *chr_out,
>> +static int filter_mirror_send(MirrorState *s,
>>                                 const struct iovec *iov,
>>                                 int iovcnt)
>>   {
>> +    NetFilterState *nf = NETFILTER(s);
>>       int ret = 0;
>>       ssize_t size = 0;
>>       uint32_t len = 0;
>> @@ -59,14 +60,38 @@ static int filter_mirror_send(CharBackend *chr_out,
>>       }
>>         len = htonl(size);
>> -    ret = qemu_chr_fe_write_all(chr_out, (uint8_t *)&len, sizeof(len));
>> +    ret = qemu_chr_fe_write_all(&s->chr_out, (uint8_t *)&len, 
>> sizeof(len));
>>       if (ret != sizeof(len)) {
>>           goto err;
>>       }
>>   +    if (s->vnet_hdr) {
>> +        /*
>> +         * If vnet_hdr = on, we send vnet header len to make other
>> +         * module(like colo-compare) know how to parse net
>> +         * packet correctly.
>> +         */
>> +        ssize_t vnet_hdr_len;
>> +
>> +        if (nf->netdev->using_vnet_hdr) {
>> +            vnet_hdr_len = nf->netdev->vnet_hdr_len;
>> +        } else if (nf->netdev->peer->using_vnet_hdr) {
>> +            vnet_hdr_len = nf->netdev->peer->vnet_hdr_len;
>
> Still questionable here, may need a comment to explain.
>

OK, I will add comments in next version.

>> +        } else {
>> +            error_report("filter get vnet_hdr_len failed");
>
> Why need error here, could we just use zero?

Yes,we can.

Thanks
Zhang Chen

>
> Thanks
>
>> +            goto err;
>> +        }
>> +
>> +        len = htonl(vnet_hdr_len);
>> +        ret = qemu_chr_fe_write_all(&s->chr_out, (uint8_t *)&len, 
>> sizeof(len));
>> +        if (ret != sizeof(len)) {
>> +            goto err;
>> +        }
>> +    }
>> +
>>       buf = g_malloc(size);
>>       iov_to_buf(iov, iovcnt, 0, buf, size);
>> -    ret = qemu_chr_fe_write_all(chr_out, (uint8_t *)buf, size);
>> +    ret = qemu_chr_fe_write_all(&s->chr_out, (uint8_t *)buf, size);
>>       g_free(buf);
>>       if (ret != size) {
>>           goto err;
>> @@ -142,7 +167,7 @@ static ssize_t 
>> filter_mirror_receive_iov(NetFilterState *nf,
>>       MirrorState *s = FILTER_MIRROR(nf);
>>       int ret;
>>   -    ret = filter_mirror_send(&s->chr_out, iov, iovcnt);
>> +    ret = filter_mirror_send(s, iov, iovcnt);
>>       if (ret) {
>>           error_report("filter_mirror_send failed(%s)", strerror(-ret));
>>       }
>> @@ -165,7 +190,7 @@ static ssize_t 
>> filter_redirector_receive_iov(NetFilterState *nf,
>>       int ret;
>>         if (qemu_chr_fe_get_driver(&s->chr_out)) {
>> -        ret = filter_mirror_send(&s->chr_out, iov, iovcnt);
>> +        ret = filter_mirror_send(s, iov, iovcnt);
>>           if (ret) {
>>               error_report("filter_mirror_send failed(%s)", 
>> strerror(-ret));
>>           }
>
>
>
> .
>

-- 
Thanks
Zhang Chen
