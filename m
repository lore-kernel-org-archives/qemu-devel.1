Received: from eggs.gnu.org ([2001:4830:134:3::10]:59085)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhangchen.fnst@cn.fujitsu.com>) id 1dDseb-0006Ve-8h
	for qemu-devel@nongnu.org; Thu, 25 May 2017 09:18:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zhangchen.fnst@cn.fujitsu.com>) id 1dDseX-00082g-8U
	for qemu-devel@nongnu.org; Thu, 25 May 2017 09:18:13 -0400
Received: from [59.151.112.132] (port=31329 helo=heian.cn.fujitsu.com)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhangchen.fnst@cn.fujitsu.com>) id 1dDseV-00081s-Sg
	for qemu-devel@nongnu.org; Thu, 25 May 2017 09:18:09 -0400
References: <1495549241-23380-1-git-send-email-zhangchen.fnst@cn.fujitsu.com>
	<1495549241-23380-7-git-send-email-zhangchen.fnst@cn.fujitsu.com>
	<9f0e7f5e-7da7-4d78-95d9-be544b1bd28e@redhat.com>
From: Zhang Chen <zhangchen.fnst@cn.fujitsu.com>
Message-ID: <b4ad4d4a-a469-edff-ed98-06cb7d4ecc8f@cn.fujitsu.com>
Date: Thu, 25 May 2017 21:18:36 +0800
MIME-Version: 1.0
In-Reply-To: <9f0e7f5e-7da7-4d78-95d9-be544b1bd28e@redhat.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH V5 6/9] net/colo-compare.c: Make
 colo-compare support vnet_hdr_len
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



On 05/25/2017 02:22 PM, Jason Wang wrote:
>
>
> On 2017年05月23日 22:20, Zhang Chen wrote:
>> We add the vnet_hdr option for colo-compare, default is disable.
>> If you use virtio-net-pci net driver, please enable it.
>> You can use it for example:
>> -object 
>> colo-compare,id=comp0,primary_in=compare0-0,secondary_in=compare1,outdev=compare_out0,vnet_hdr=on
>
> This is not accurate since virtio-net-pci is not the only card that 
> uses vnet_hdr. E1000E is another one.

Good catch, I will add the e1000e in this commit log.

>
>>
>> COLO-compare can get vnet header length from filter,
>> Add vnet_hdr_len to struct packet and output packet with
>> the vnet_hdr_len.
>>
>> Signed-off-by: Zhang Chen <zhangchen.fnst@cn.fujitsu.com>
>> ---
>>   net/colo-compare.c | 76 
>> +++++++++++++++++++++++++++++++++++++++++++++++-------
>>   qemu-options.hx    |  4 +--
>>   2 files changed, 69 insertions(+), 11 deletions(-)
>>
>> diff --git a/net/colo-compare.c b/net/colo-compare.c
>> index bf0b856..f89b380 100644
>> --- a/net/colo-compare.c
>> +++ b/net/colo-compare.c
>> @@ -73,6 +73,7 @@ typedef struct CompareState {
>>       CharBackend chr_out;
>>       SocketReadState pri_rs;
>>       SocketReadState sec_rs;
>> +    bool vnet_hdr;
>>         /* connection list: the connections belonged to this NIC 
>> could be found
>>        * in this list.
>> @@ -97,9 +98,10 @@ enum {
>>       SECONDARY_IN,
>>   };
>>   -static int compare_chr_send(CharBackend *out,
>> +static int compare_chr_send(CompareState *s,
>>                               const uint8_t *buf,
>> -                            uint32_t size);
>> +                            uint32_t size,
>> +                            uint32_t vnet_hdr_len);
>>     static gint seq_sorter(Packet *a, Packet *b, gpointer data)
>>   {
>> @@ -472,7 +474,10 @@ static void colo_compare_connection(void 
>> *opaque, void *user_data)
>>           }
>>             if (result) {
>> -            ret = compare_chr_send(&s->chr_out, pkt->data, pkt->size);
>> +            ret = compare_chr_send(s,
>> +                                   pkt->data,
>> +                                   pkt->size,
>> +                                   pkt->vnet_hdr_len);
>
> Why not check vnet_hdr support here?  And don't we need strip vnet_hdr 
> here? (Since the redirector on destination does not do this)

If we create a normal qemu guest that use virtio-net-pci driver, the 
guest's send packet have the vnet_hdr,
qemu virtio-net-pci driver will strip vnet_hdr then send to external 
network. In COLO we just redirect
or mirror the packet, finally the packet will back to primary qemu 
virtio-net-pci driver, So we just send
the packet.

Thanks
Zhang Chen

>
>>               if (ret < 0) {
>>                   error_report("colo_send_primary_packet failed");
>>               }
>> @@ -493,9 +498,10 @@ static void colo_compare_connection(void 
>> *opaque, void *user_data)
>>       }
>>   }
>>   -static int compare_chr_send(CharBackend *out,
>> +static int compare_chr_send(CompareState *s,
>>                               const uint8_t *buf,
>> -                            uint32_t size)
>> +                            uint32_t size,
>> +                            uint32_t vnet_hdr_len)
>>   {
>>       int ret = 0;
>>       uint32_t len = htonl(size);
>> @@ -504,12 +510,24 @@ static int compare_chr_send(CharBackend *out,
>>           return 0;
>>       }
>>   -    ret = qemu_chr_fe_write_all(out, (uint8_t *)&len, sizeof(len));
>> +    ret = qemu_chr_fe_write_all(&s->chr_out, (uint8_t *)&len, 
>> sizeof(len));
>>       if (ret != sizeof(len)) {
>>           goto err;
>>       }
>>   -    ret = qemu_chr_fe_write_all(out, (uint8_t *)buf, size);
>> +    if (s->vnet_hdr) {
>> +        /*
>> +         * We send vnet header len make other module(like 
>> filter-redirector)
>> +         * know how to parse net packet correctly.
>> +         */
>
> But redirector does not strip the vnet header, does this really work?

Sorry, Here is a typo, I will fix it to "like colo-compare".

Thanks
ZhangChen

>
> Thanks
>
>
> .
>

-- 
Thanks
Zhang Chen
