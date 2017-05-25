Received: from eggs.gnu.org ([2001:4830:134:3::10]:54261)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhangchen.fnst@cn.fujitsu.com>) id 1dDsIh-0006Nf-D1
	for qemu-devel@nongnu.org; Thu, 25 May 2017 08:55:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zhangchen.fnst@cn.fujitsu.com>) id 1dDsIc-0000dU-Sy
	for qemu-devel@nongnu.org; Thu, 25 May 2017 08:55:35 -0400
Received: from [59.151.112.132] (port=9919 helo=heian.cn.fujitsu.com)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhangchen.fnst@cn.fujitsu.com>) id 1dDsIb-0000bM-Vz
	for qemu-devel@nongnu.org; Thu, 25 May 2017 08:55:30 -0400
References: <1495549241-23380-1-git-send-email-zhangchen.fnst@cn.fujitsu.com>
	<1495549241-23380-3-git-send-email-zhangchen.fnst@cn.fujitsu.com>
	<838b8626-c5e4-86d5-a318-ab957bc9bcbe@redhat.com>
From: Zhang Chen <zhangchen.fnst@cn.fujitsu.com>
Message-ID: <f9344c1f-fa0a-4745-bf51-658c37d1d53e@cn.fujitsu.com>
Date: Thu, 25 May 2017 20:55:40 +0800
MIME-Version: 1.0
In-Reply-To: <838b8626-c5e4-86d5-a318-ab957bc9bcbe@redhat.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH V5 2/9] net/filter-mirror.c: Make filter
 mirror support vnet support.
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



On 05/25/2017 02:04 PM, Jason Wang wrote:
>
>
> On 2017年05月23日 22:20, Zhang Chen wrote:
>> We add the vnet_hdr option for filter-mirror, default is disable.
>> If you use virtio-net-pci net driver, please enable it.
>> You can use it for example:
>> -object 
>> filter-mirror,id=m0,netdev=hn0,queue=tx,outdev=mirror0,vnet_hdr=on
>>
>> If vnet_hdr=on we change the send packet format from
>> struct {int size; const uint8_t buf[];} to {int size; int 
>> vnet_hdr_len; const uint8_t buf[];}.
>> make other module(like colo-compare) know how to parse net packet 
>> correctly.
>>
>> Signed-off-by: Zhang Chen <zhangchen.fnst@cn.fujitsu.com>
>> ---
>>   net/filter-mirror.c | 73 
>> +++++++++++++++++++++++++++++++++++++++++++++++++----
>>   qemu-options.hx     |  5 ++--
>>   2 files changed, 70 insertions(+), 8 deletions(-)
>>
>> diff --git a/net/filter-mirror.c b/net/filter-mirror.c
>> index 72fa7c2..8df0be6 100644
>> --- a/net/filter-mirror.c
>> +++ b/net/filter-mirror.c
>> @@ -38,15 +38,17 @@ typedef struct MirrorState {
>>       NetFilterState parent_obj;
>>       char *indev;
>>       char *outdev;
>> +    bool vnet_hdr;
>>       CharBackend chr_in;
>>       CharBackend chr_out;
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
>> @@ -58,14 +60,42 @@ static int filter_mirror_send(CharBackend *chr_out,
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
>> +        /*
>> +         * In anytime, nf->netdev and nf->netdev->peer both have a 
>> vnet_hdr_len,
>> +         * Here we just find out which is we need. When filter set 
>> RX or TX
>> +         * that the real vnet_hdr_len are different.
>> +         */
>> +        if (nf->netdev->using_vnet_hdr) {
>> +            vnet_hdr_len = nf->netdev->vnet_hdr_len;
>> +        } else if (nf->netdev->peer->using_vnet_hdr) {
>> +            vnet_hdr_len = nf->netdev->peer->vnet_hdr_len;
>
> Rethink about this, looks like what we really want is:
>
> - For tx direction, only check nf->netdev->vnet_hdr_len,
> - For rx direction, only check nf->netdev->peer->vnet_hdr_len

Agree, So do you means we should remove the using_vnet_hdr related codes 
then just
use the nf->direction to choice which we need check?

Thanks
Zhang Chen

>
> Thanks
>
>> +        } else {
>> +            return 0;
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
>> @@ -141,7 +171,7 @@ static ssize_t 
>> filter_mirror_receive_iov(NetFilterState *nf,
>>       MirrorState *s = FILTER_MIRROR(nf);
>>       int ret;
>>   -    ret = filter_mirror_send(&s->chr_out, iov, iovcnt);
>> +    ret = filter_mirror_send(s, iov, iovcnt);
>>       if (ret) {
>>           error_report("filter_mirror_send failed(%s)", strerror(-ret));
>>       }
>> @@ -164,7 +194,7 @@ static ssize_t 
>> filter_redirector_receive_iov(NetFilterState *nf,
>>       int ret;
>>         if (qemu_chr_fe_get_driver(&s->chr_out)) {
>> -        ret = filter_mirror_send(&s->chr_out, iov, iovcnt);
>> +        ret = filter_mirror_send(s, iov, iovcnt);
>>           if (ret) {
>>               error_report("filter_mirror_send failed(%s)", 
>> strerror(-ret));
>>           }
>> @@ -308,6 +338,13 @@ static char *filter_mirror_get_outdev(Object 
>> *obj, Error **errp)
>>       return g_strdup(s->outdev);
>>   }
>>   +static char *filter_mirror_get_vnet_hdr(Object *obj, Error **errp)
>> +{
>> +    MirrorState *s = FILTER_MIRROR(obj);
>> +
>> +    return s->vnet_hdr ? g_strdup("on") : g_strdup("off");
>> +}
>> +
>>   static void
>>   filter_mirror_set_outdev(Object *obj, const char *value, Error **errp)
>>   {
>> @@ -322,6 +359,21 @@ filter_mirror_set_outdev(Object *obj, const char 
>> *value, Error **errp)
>>       }
>>   }
>>   +static void filter_mirror_set_vnet_hdr(Object *obj,
>> +                                       const char *value,
>> +                                       Error **errp)
>> +{
>> +    MirrorState *s = FILTER_MIRROR(obj);
>> +
>> +    if (strcmp(value, "on") && strcmp(value, "off")) {
>> +        error_setg(errp, "Invalid value for filter-mirror vnet_hdr, "
>> +                         "should be 'on' or 'off'");
>> +        return;
>> +    }
>> +
>> +    s->vnet_hdr = !strcmp(value, "on");
>> +}
>> +
>>   static char *filter_redirector_get_outdev(Object *obj, Error **errp)
>>   {
>>       MirrorState *s = FILTER_REDIRECTOR(obj);
>> @@ -340,8 +392,19 @@ filter_redirector_set_outdev(Object *obj, const 
>> char *value, Error **errp)
>>     static void filter_mirror_init(Object *obj)
>>   {
>> +    MirrorState *s = FILTER_MIRROR(obj);
>> +
>>       object_property_add_str(obj, "outdev", filter_mirror_get_outdev,
>>                               filter_mirror_set_outdev, NULL);
>> +
>> +    /*
>> +     * The vnet_hdr is disabled by default, if you want to enable
>> +     * this option, you must enable all the option on related modules
>> +     * (like other filter or colo-compare).
>> +     */
>> +    s->vnet_hdr = false;
>> +    object_property_add_str(obj, "vnet_hdr", 
>> filter_mirror_get_vnet_hdr,
>> +                             filter_mirror_set_vnet_hdr, NULL);
>>   }
>>     static void filter_redirector_init(Object *obj)
>> diff --git a/qemu-options.hx b/qemu-options.hx
>> index 70c0ded..81fb96b 100644
>> --- a/qemu-options.hx
>> +++ b/qemu-options.hx
>> @@ -4024,10 +4024,9 @@ queue @var{all|rx|tx} is an option that can be 
>> applied to any netfilter.
>>   @option{tx}: the filter is attached to the transmit queue of the 
>> netdev,
>>                where it will receive packets sent by the netdev.
>>   -@item -object 
>> filter-mirror,id=@var{id},netdev=@var{netdevid},outdev=@var{chardevid}[,queue=@var{all|rx|tx}]
>> +@item -object 
>> filter-mirror,id=@var{id},netdev=@var{netdevid},outdev=@var{chardevid},vnet_hdr=@var{on|off}[,queue=@var{all|rx|tx}]
>>   -filter-mirror on netdev @var{netdevid},mirror net packet to chardev
>> -@var{chardevid}
>> +filter-mirror on netdev @var{netdevid},mirror net packet to 
>> chardev@var{chardevid}, if vnet_hdr = on, filter-mirror will mirror 
>> packet with vnet_hdr_len.
>>     @item -object 
>> filter-redirector,id=@var{id},netdev=@var{netdevid},indev=@var{chardevid},
>>   outdev=@var{chardevid}[,queue=@var{all|rx|tx}]
>
>
>
> .
>

-- 
Thanks
Zhang Chen
