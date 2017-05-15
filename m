Received: from eggs.gnu.org ([2001:4830:134:3::10]:39107)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhangchen.fnst@cn.fujitsu.com>) id 1dA9wz-0002nx-30
	for qemu-devel@nongnu.org; Mon, 15 May 2017 02:57:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zhangchen.fnst@cn.fujitsu.com>) id 1dA9wu-0004m1-Ju
	for qemu-devel@nongnu.org; Mon, 15 May 2017 02:57:49 -0400
Received: from [59.151.112.132] (port=53297 helo=heian.cn.fujitsu.com)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhangchen.fnst@cn.fujitsu.com>) id 1dA9wt-0004lh-JQ
	for qemu-devel@nongnu.org; Mon, 15 May 2017 02:57:44 -0400
References: <1494553288-30764-1-git-send-email-zhangchen.fnst@cn.fujitsu.com>
	<1494553288-30764-3-git-send-email-zhangchen.fnst@cn.fujitsu.com>
	<a9e278bc-2131-3ed2-d8ab-e5e32c2b4df5@redhat.com>
From: Zhang Chen <zhangchen.fnst@cn.fujitsu.com>
Message-ID: <41f030e4-fa05-5ba8-3e4a-3068615cb594@cn.fujitsu.com>
Date: Mon, 15 May 2017 14:57:50 +0800
MIME-Version: 1.0
In-Reply-To: <a9e278bc-2131-3ed2-d8ab-e5e32c2b4df5@redhat.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH V4 02/12] net/filter-mirror.c: Add new
 option to enable vnet support for filter-mirror
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



On 05/15/2017 11:26 AM, Jason Wang wrote:
>
>
> On 2017年05月12日 09:41, Zhang Chen wrote:
>> We add the vnet_hdr option for filter-mirror, default is disable.
>> If you use virtio-net-pci net driver, please enable it.
>> You can use it for example:
>> -object 
>> filter-mirror,id=m0,netdev=hn0,queue=tx,outdev=mirror0,vnet_hdr=on
>>
>> Signed-off-by: Zhang Chen <zhangchen.fnst@cn.fujitsu.com>
>> ---
>>   net/filter-mirror.c | 34 ++++++++++++++++++++++++++++++++++
>>   qemu-options.hx     |  5 +++--
>>   2 files changed, 37 insertions(+), 2 deletions(-)
>>
>> diff --git a/net/filter-mirror.c b/net/filter-mirror.c
>> index 72fa7c2..3766414 100644
>> --- a/net/filter-mirror.c
>> +++ b/net/filter-mirror.c
>> @@ -38,6 +38,7 @@ typedef struct MirrorState {
>>       NetFilterState parent_obj;
>>       char *indev;
>>       char *outdev;
>> +    bool vnet_hdr;
>>       CharBackend chr_in;
>>       CharBackend chr_out;
>>       SocketReadState rs;
>> @@ -308,6 +309,13 @@ static char *filter_mirror_get_outdev(Object 
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
>> @@ -322,6 +330,21 @@ filter_mirror_set_outdev(Object *obj, const char 
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
>> @@ -340,8 +363,19 @@ filter_redirector_set_outdev(Object *obj, const 
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
>
> We'd better squash this into patch 3 and even after the changes for 
> net_fill_rstate().

OK, I will squash it in next version.

>
>>     static void filter_redirector_init(Object *obj)
>> diff --git a/qemu-options.hx b/qemu-options.hx
>> index 70c0ded..1e08481 100644
>> --- a/qemu-options.hx
>> +++ b/qemu-options.hx
>> @@ -4024,10 +4024,11 @@ queue @var{all|rx|tx} is an option that can 
>> be applied to any netfilter.
>>   @option{tx}: the filter is attached to the transmit queue of the 
>> netdev,
>>                where it will receive packets sent by the netdev.
>>   -@item -object 
>> filter-mirror,id=@var{id},netdev=@var{netdevid},outdev=@var{chardevid}[,queue=@var{all|rx|tx}]
>> +@item -object 
>> filter-mirror,id=@var{id},netdev=@var{netdevid},outdev=@var{chardevid},vnet_hdr=@var{on|off}[,queue=@var{all|rx|tx}]
>>     filter-mirror on netdev @var{netdevid},mirror net packet to chardev
>> -@var{chardevid}
>> +@var{chardevid}, if vnet_hdr = on, filter-mirror will mirror packet
>> +with vnet_hdr_len.
>
> As pointed by Eric, we'd better keep the long line here.

OK.

Thanks
Zhang Chen

>
> Thanks
>
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
