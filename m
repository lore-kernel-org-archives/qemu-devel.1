Received: from eggs.gnu.org ([2001:4830:134:3::10]:51510)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1eRaBn-0003b1-GF
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 03:57:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1eRaBk-0003nT-Pb
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 03:57:23 -0500
Received: from mx1.redhat.com ([209.132.183.28]:45032)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1eRaBk-0003mT-F7
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 03:57:20 -0500
References: <1513148690-23440-1-git-send-email-jianjay.zhou@huawei.com>
	<217eb906-023e-b3ff-8f65-1af84655ca25@redhat.com>
	<B2D15215269B544CADD246097EACE7473AB0D08F@DGGEMM505-MBS.china.huawei.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <ce633ca0-92c8-de17-fc94-cd9454ca29ad@redhat.com>
Date: Wed, 20 Dec 2017 16:56:59 +0800
MIME-Version: 1.0
In-Reply-To: <B2D15215269B544CADD246097EACE7473AB0D08F@DGGEMM505-MBS.china.huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC PATCH] vhost-user: quit infinite loop while
 used memslots is more than the backend limit
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Zhoujian (jay)" <jianjay.zhou@huawei.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "mst@redhat.com" <mst@redhat.com>, "Gonglei (Arei)" <arei.gonglei@huawei.com>, "marcandre.lureau@redhat.com" <marcandre.lureau@redhat.com>, "Huangweidong (C)" <weidong.huang@huawei.com>, "wangxin (U)" <wangxinxin.wang@huawei.com>, Maxime Coquelin <maxime.coquelin@redhat.com>



On 2017=E5=B9=B412=E6=9C=8819=E6=97=A5 18:21, Zhoujian (jay) wrote:
>
>> -----Original Message-----
>> From: Jason Wang [mailto:jasowang@redhat.com]
>> Sent: Tuesday, December 19, 2017 5:24 PM
>> To: Zhoujian (jay) <jianjay.zhou@huawei.com>; qemu-devel@nongnu.org
>> Cc: mst@redhat.com; Gonglei (Arei) <arei.gonglei@huawei.com>;
>> marcandre.lureau@redhat.com; Huangweidong (C) <weidong.huang@huawei.co=
m>;
>> wangxin (U) <wangxinxin.wang@huawei.com>
>> Subject: Re: [RFC PATCH] vhost-user: quit infinite loop while used
>> memslots is more than the backend limit
>>
>>
>>
>> On 2017=E5=B9=B412=E6=9C=8813=E6=97=A5 15:04, Jay Zhou wrote:
>>> Steps to 100% reproduce:
>>> (1) start a VM with two VFIO 82599 PCI NICs successfully
>>> (2) hot plug a RAM, which is attached successfully
>>> (3) hot plug another RAM, which is attached successfully
>>> (4) hot plug a vhost-user NIC, which is attached successfully
>>> (5) hot plug another vhost-user NIC, which is hanged
>>>
>>> then the qemu process infinitely and quickly print the logs below:
>>>       [...]
>>>       vhost backend memory slots limit is less than current number of
>> present memory slots
>>>       failed to init vhost_net for queue 0
>>>       vhost backend memory slots limit is less than current number of
>> present memory slots
>>>       failed to init vhost_net for queue 0
>>>       vhost backend memory slots limit is less than current number of
>> present memory slots
>>>       failed to init vhost_net for queue 0
>>>       [...]
>>>
>>> and the cpu utilization of the systemd-journal process on host is
>>> 100%, the reason is clear:
>>>       "used_memslots > hdev->vhost_ops-
>>> vhost_backend_memslots_limit(hdev)"
>>> is true in vhost_dev_init, and the main thread in the infinite do and
>>> while loop in net_vhost_user_init.
>>>
>>> One way is to increase the vhost backend memory slots limit, some
>>> discussions are here:
>>>
>>> https://lists.gnu.org/archive/html/qemu-devel/2017-11/msg04572.html
>>>
>>> I think if
>>>       "used_memslots > hdev->vhost_ops-
>>> vhost_backend_memslots_limit(hdev)"
>>> is true, it does not make sense to try to initialize the vhost-user
>>> again and again, because the main thread can not handle other qmps at
>>> all, which means it can not reduce the number of memslots, it must be
>>> failed at last.
>> You should include the reason why we hit infinite loop in the commit l=
og,
>> and what's more important, is this issue specific to memslots only?
>> What if you hit errors other than this in vhost_dev_init() for vhost-u=
ser?
> If the new hot plugged vhost-user NIC failed to initialize in vhost_dev=
_init,
> the s->started in net_vhost_user_init is always false, so we hit infini=
te loop
> in net_vhost_user_init().
> It is not specific to memslots only, e.g. if the backend lacks some fea=
ture
> masks, it will hit infinite loop too.
>
> Is it available to identify the cases that MAY be failed and MUST be fa=
iled
> at initialization?
>      - If it must be failed, quit the loop at once.
>      - If it may be failed, then we should do the loop to wait the conn=
ection
>        established, i.e. wait the s->started becomes true. And some sle=
ep time
>        may be added to reduce the CPU utilization.

Then I think you probably need another flag e.g s->error and set it on=20
fatal error.

>
>> Is this better to disable event source in this case?
> The "event source" you mean is the logs printed?
> If it is disabled, the reason why initialization failed is not explicit=
,
> this is the drawback.
>

No I mean the thing that triggers the loop which is s->started here.

Thanks

> Regards,
> Jay
>
>> Thanks
>>
>>> Signed-off-by: Jay Zhou <jianjay.zhou@huawei.com>
>>> ---
>>>    hw/virtio/vhost.c         | 3 +++
>>>    include/hw/virtio/vhost.h | 2 ++
>>>    net/vhost-user.c          | 5 +++++
>>>    3 files changed, 10 insertions(+)
>>>
>>> diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c index
>>> e4290ce..1cc4a18 100644
>>> --- a/hw/virtio/vhost.c
>>> +++ b/hw/virtio/vhost.c
>>> @@ -47,6 +47,8 @@ static unsigned int used_memslots;
>>>    static QLIST_HEAD(, vhost_dev) vhost_devices =3D
>>>        QLIST_HEAD_INITIALIZER(vhost_devices);
>>>
>>> +bool used_memslots_exceeded;
>>> +
>>>    bool vhost_has_free_slot(void)
>>>    {
>>>        unsigned int slots_limit =3D ~0U;
>>> @@ -1254,6 +1256,7 @@ int vhost_dev_init(struct vhost_dev *hdev, void
>> *opaque,
>>>        if (used_memslots > hdev->vhost_ops-
>>> vhost_backend_memslots_limit(hdev)) {
>>>            error_report("vhost backend memory slots limit is less"
>>>                    " than current number of present memory slots");
>>> +        used_memslots_exceeded =3D true;
>>>            r =3D -1;
>>>            goto fail;
>>>        }
>>> diff --git a/include/hw/virtio/vhost.h b/include/hw/virtio/vhost.h
>>> index 467dc77..bcc66d9 100644
>>> --- a/include/hw/virtio/vhost.h
>>> +++ b/include/hw/virtio/vhost.h
>>> @@ -6,6 +6,8 @@
>>>    #include "hw/virtio/virtio.h"
>>>    #include "exec/memory.h"
>>>
>>> +extern bool used_memslots_exceeded;
>>> +
>>>    /* Generic structures common for any vhost based device. */
>>>    struct vhost_virtqueue {
>>>        int kick;
>>> diff --git a/net/vhost-user.c b/net/vhost-user.c index
>>> c23927c..8b7bfff 100644
>>> --- a/net/vhost-user.c
>>> +++ b/net/vhost-user.c
>>> @@ -17,6 +17,7 @@
>>>    #include "qemu/error-report.h"
>>>    #include "qmp-commands.h"
>>>    #include "trace.h"
>>> +#include "include/hw/virtio/vhost.h"
>>>
>>>    typedef struct VhostUserState {
>>>        NetClientState nc;
>>> @@ -311,6 +312,10 @@ static int net_vhost_user_init(NetClientState *p=
eer,
>> const char *device,
>>>            qemu_chr_fe_set_handlers(&s->chr, NULL, NULL,
>>>                                     net_vhost_user_event, NULL, nc0->=
name,
>> NULL,
>>>                                     true);
>>> +        if (used_memslots_exceeded) {
>>> +            error_report("used memslots exceeded the backend limit,
>> quit loop");
>>> +            return -1;
>>> +        }
>>>        } while (!s->started);
>>>
>>>        assert(s->vhost_net);
