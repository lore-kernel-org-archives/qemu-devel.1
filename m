Received: from eggs.gnu.org ([2001:4830:134:3::10]:44178)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhangchen.fnst@cn.fujitsu.com>) id 1d5jt6-0007lF-Gl
	for qemu-devel@nongnu.org; Tue, 02 May 2017 22:19:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zhangchen.fnst@cn.fujitsu.com>) id 1d5jt3-0002Y4-Q7
	for qemu-devel@nongnu.org; Tue, 02 May 2017 22:19:32 -0400
Received: from [59.151.112.132] (port=24799 helo=heian.cn.fujitsu.com)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhangchen.fnst@cn.fujitsu.com>) id 1d5jt2-0002Xs-Tq
	for qemu-devel@nongnu.org; Tue, 02 May 2017 22:19:29 -0400
References: <1493372840-24551-1-git-send-email-zhangchen.fnst@cn.fujitsu.com>
	<1493372840-24551-5-git-send-email-zhangchen.fnst@cn.fujitsu.com>
	<d0bb0735-7b25-5236-bbfa-45b751395e7e@redhat.com>
From: Zhang Chen <zhangchen.fnst@cn.fujitsu.com>
Message-ID: <c05b73cc-fb91-abc4-2dee-27576df0add7@cn.fujitsu.com>
Date: Wed, 3 May 2017 10:18:20 +0700
MIME-Version: 1.0
In-Reply-To: <d0bb0735-7b25-5236-bbfa-45b751395e7e@redhat.com>
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
Cc: zhangchen.fnst@cn.fujitsu.com, zhanghailiang <zhang.zhanghailiang@huawei.com>, weifuqiang <weifuqiang@huawei.com>, "eddie
	. dong" <eddie.dong@intel.com>, bian naimeng <biannm@cn.fujitsu.com>, Li Zhijian <lizhijian@cn.fujitsu.com>



On 05/02/2017 12:47 PM, Jason Wang wrote:
>
>
> On 2017年04月28日 17:47, Zhang Chen wrote:
>> In this patch, we change the send packet format from
>> struct {int size; const uint8_t buf[];} to {int size; int 
>> vnet_hdr_len; const uint8_t buf[];}.
>> make other module(like colo-compare) know how to parse net packet 
>> correctly.
>>
>> Signed-off-by: Zhang Chen <zhangchen.fnst@cn.fujitsu.com>
>> ---
>>   net/filter-mirror.c | 28 +++++++++++++++++++++++-----
>>   1 file changed, 23 insertions(+), 5 deletions(-)
>>
>> diff --git a/net/filter-mirror.c b/net/filter-mirror.c
>> index 72fa7c2..bb9ecf3 100644
>> --- a/net/filter-mirror.c
>> +++ b/net/filter-mirror.c
>> @@ -43,12 +43,14 @@ typedef struct MirrorState {
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
>> +    ssize_t vnet_hdr_len;
>>       uint32_t len = 0;
>>       char *buf;
>>   @@ -58,14 +60,30 @@ static int filter_mirror_send(CharBackend 
>> *chr_out,
>>       }
>>         len = htonl(size);
>> -    ret = qemu_chr_fe_write_all(chr_out, (uint8_t *)&len, sizeof(len));
>> +    ret = qemu_chr_fe_write_all(&s->chr_out, (uint8_t *)&len, 
>> sizeof(len));
>> +    if (ret != sizeof(len)) {
>> +        goto err;
>> +    }
>> +
>> +    /*
>> +     * We send vnet header len make other module(like colo-compare)
>> +     * know how to parse net packet correctly.
>> +     */
>> +    if (qemu_get_using_vnet_hdr(nf->netdev)) {
>> +        vnet_hdr_len = qemu_get_vnet_hdr_len(nf->netdev);
>> +    } else {
>> +        vnet_hdr_len = qemu_get_vnet_hdr_len(nf->netdev->peer);
>> +    }
>
> Any reason to query peer here?

That's depend on using NetClientState, If we using nf->netdev that need 
to query,
Otherwise we query nf->netdev->peer, then we can get the real 
vnet_hdr_len in my test.

Thanks
Zhang Chen

>
>> +
>> +    len = htonl(vnet_hdr_len);
>> +    ret = qemu_chr_fe_write_all(&s->chr_out, (uint8_t *)&len, 
>> sizeof(len));
>>       if (ret != sizeof(len)) {
>>           goto err;
>>       }
>>         buf = g_malloc(size);
>>       iov_to_buf(iov, iovcnt, 0, buf, size);
>> -    ret = qemu_chr_fe_write_all(chr_out, (uint8_t *)buf, size);
>> +    ret = qemu_chr_fe_write_all(&s->chr_out, (uint8_t *)buf, size);
>>       g_free(buf);
>>       if (ret != size) {
>>           goto err;
>> @@ -141,7 +159,7 @@ static ssize_t 
>> filter_mirror_receive_iov(NetFilterState *nf,
>>       MirrorState *s = FILTER_MIRROR(nf);
>>       int ret;
>>   -    ret = filter_mirror_send(&s->chr_out, iov, iovcnt);
>> +    ret = filter_mirror_send(s, iov, iovcnt);
>>       if (ret) {
>>           error_report("filter_mirror_send failed(%s)", strerror(-ret));
>>       }
>> @@ -164,7 +182,7 @@ static ssize_t 
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
> Do we need to strip vnet_hdr_len in redirector_to_filter() ?
>
> Thanks
>
>
>
> .
>

-- 
Thanks
Zhang Chen
