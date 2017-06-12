Received: from eggs.gnu.org ([2001:4830:134:3::10]:39713)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhangchen.fnst@cn.fujitsu.com>) id 1dKLci-0000sJ-4H
	for qemu-devel@nongnu.org; Mon, 12 Jun 2017 05:27:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zhangchen.fnst@cn.fujitsu.com>) id 1dKLcd-0001ws-HA
	for qemu-devel@nongnu.org; Mon, 12 Jun 2017 05:27:00 -0400
Received: from [59.151.112.132] (port=27961 helo=heian.cn.fujitsu.com)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhangchen.fnst@cn.fujitsu.com>) id 1dKLcc-0001vr-Gt
	for qemu-devel@nongnu.org; Mon, 12 Jun 2017 05:26:55 -0400
References: <1496829322-17099-1-git-send-email-zhangchen.fnst@cn.fujitsu.com>
	<1496829322-17099-3-git-send-email-zhangchen.fnst@cn.fujitsu.com>
	<4d998686-136d-1b6d-a641-9332930dcc93@redhat.com>
From: Zhang Chen <zhangchen.fnst@cn.fujitsu.com>
Message-ID: <28122598-b6b3-9eb6-b726-bd7c22735780@cn.fujitsu.com>
Date: Mon, 12 Jun 2017 17:27:55 +0800
MIME-Version: 1.0
In-Reply-To: <4d998686-136d-1b6d-a641-9332930dcc93@redhat.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Subject: Re: [Qemu-devel] [PATCH V6 02/10] net/filter-mirror.c: Make filter
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



On 06/09/2017 02:08 PM, Jason Wang wrote:
>
>
> On 2017年06月07日 17:55, Zhang Chen wrote:
>> We add the vnet_hdr_support option for filter-mirror, default is 
>> disable.
>
> s/disable/disabled/
>
>> If you use virtio-net-pci net driver, please enable it.
>> You can use it for example:
>> -object 
>> filter-mirror,id=m0,netdev=hn0,queue=tx,outdev=mirror0,vnet_hdr_support
>>
>> If have vnet_hdr_support flag,
>
> If it has
>
>>   we will change the send packet format from
>
> s/send/sending/
>
>> struct {int size; const uint8_t buf[];} to {int size; int 
>> vnet_hdr_len; const uint8_t buf[];}.
>> make other module(like colo-compare) know how to parse net packet 
>> correctly.
>
> Please double check the commit logs, some have obvious grammar issues.

OK, I will fix the garmmar issues.

>
>>
>> Signed-off-by: Zhang Chen <zhangchen.fnst@cn.fujitsu.com>
>> ---
>>   net/filter-mirror.c | 69 
>> +++++++++++++++++++++++++++++++++++++++++++++++++----
>>   qemu-options.hx     |  5 ++--
>>   2 files changed, 66 insertions(+), 8 deletions(-)
>>
>> diff --git a/net/filter-mirror.c b/net/filter-mirror.c
>> index 72fa7c2..50aa81b 100644
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
>
> This function were renamed to filter_send in your commit 
> e05dc4cf56d70225fc76225a3fd7df9f7b8ca5f9 ("net/filter-mirror.c: Rename 
> filter_mirror_send() and fix codestyle")

I will rebase the code for upstream.

>
>>   {
>> +    NetFilterState *nf = NETFILTER(s);
>>       int ret = 0;
>>       ssize_t size = 0;
>>       uint32_t len = 0;
>> @@ -58,14 +60,43 @@ static int filter_mirror_send(CharBackend *chr_out,
>>       }
>>         len = htonl(size);
>> -    ret = qemu_chr_fe_write_all(chr_out, (uint8_t *)&len, sizeof(len));
>> +    ret = qemu_chr_fe_write_all(&s->chr_out, (uint8_t *)&len, 
>> sizeof(len));
>
> This looks a independent change, please do it in another patch.

OK.

>
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
>
> Let's remove the comment and let code explain itself.

I will remove it in next version.

>
>> +        if (nf->direction == NET_FILTER_DIRECTION_RX ||
>> +            nf->direction == NET_FILTER_DIRECTION_ALL) {
>> +            vnet_hdr_len = nf->netdev->vnet_hdr_len;
>
> This can only work if e.g virtio-net set its own vnet_hdr_len. But 
> looks like it use guest_hdr_len instead.

I see in hw/net/virtio-net.c use the "qemu_set_vnet_hdr_len(nc->peer, 
n->guest_hdr_len);" to
set the nf->netdev->vnet_hdr_len, any case not include here?

>
> And using NET_FILTER_DIRECTION_ALL looks suspicious. Maybe we should 
> accept sender from its caller and compare it with nf->netdev to get 
> the correct direction.
>
>> +        } else if (nf->direction == NET_FILTER_DIRECTION_TX) {
>> +            vnet_hdr_len = nf->netdev->peer->vnet_hdr_len;
>
> This looks wrong, TX means the packet were sent from netdev, we should 
> care nf->netdev's hdrlen.

I rethink and test the code, you are right. I will remove it.

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
>> @@ -141,7 +172,7 @@ static ssize_t 
>> filter_mirror_receive_iov(NetFilterState *nf,
>>       MirrorState *s = FILTER_MIRROR(nf);
>>       int ret;
>>   -    ret = filter_mirror_send(&s->chr_out, iov, iovcnt);
>> +    ret = filter_mirror_send(s, iov, iovcnt);
>>       if (ret) {
>>           error_report("filter_mirror_send failed(%s)", strerror(-ret));
>>       }
>> @@ -164,7 +195,7 @@ static ssize_t 
>> filter_redirector_receive_iov(NetFilterState *nf,
>>       int ret;
>>         if (qemu_chr_fe_get_driver(&s->chr_out)) {
>> -        ret = filter_mirror_send(&s->chr_out, iov, iovcnt);
>> +        ret = filter_mirror_send(s, iov, iovcnt);
>>           if (ret) {
>>               error_report("filter_mirror_send failed(%s)", 
>> strerror(-ret));
>>           }
>> @@ -308,6 +339,13 @@ static char *filter_mirror_get_outdev(Object 
>> *obj, Error **errp)
>>       return g_strdup(s->outdev);
>>   }
>>   +static bool filter_mirror_get_vnet_hdr(Object *obj, Error **errp)
>> +{
>> +    MirrorState *s = FILTER_MIRROR(obj);
>> +
>> +    return s->vnet_hdr;
>> +}
>> +
>>   static void
>>   filter_mirror_set_outdev(Object *obj, const char *value, Error **errp)
>>   {
>> @@ -322,6 +360,15 @@ filter_mirror_set_outdev(Object *obj, const char 
>> *value, Error **errp)
>>       }
>>   }
>>   +static void filter_mirror_set_vnet_hdr(Object *obj,
>> +                                       bool value,
>> +                                       Error **errp)
>> +{
>> +    MirrorState *s = FILTER_MIRROR(obj);
>> +
>> +    s->vnet_hdr = value;
>> +}
>> +
>>   static char *filter_redirector_get_outdev(Object *obj, Error **errp)
>>   {
>>       MirrorState *s = FILTER_REDIRECTOR(obj);
>> @@ -340,8 +387,20 @@ filter_redirector_set_outdev(Object *obj, const 
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
>
> This comment makes sense for docs but is useless here, let code 
> explain itself.

OK.

Thanks
Zhang Chen

>
> Thanks
>
>> +    s->vnet_hdr = false;
>> +    object_property_add_bool(obj, "vnet_hdr_support",
>> +                             filter_mirror_get_vnet_hdr,
>> +                             filter_mirror_set_vnet_hdr, NULL);
>>   }
>>     static void filter_redirector_init(Object *obj)
>> diff --git a/qemu-options.hx b/qemu-options.hx
>> index 70c0ded..5c09fae 100644
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
>> filter-mirror,id=@var{id},netdev=@var{netdevid},outdev=@var{chardevid},queue=@var{all|rx|tx}[,vnet_hdr_support]
>>   -filter-mirror on netdev @var{netdevid},mirror net packet to chardev
>> -@var{chardevid}
>> +filter-mirror on netdev @var{netdevid},mirror net packet to 
>> chardev@var{chardevid}, if have the vnet_hdr_support flag, 
>> filter-mirror will mirror packet with vnet_hdr_len.
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
