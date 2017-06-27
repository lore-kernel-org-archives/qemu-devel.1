Received: from eggs.gnu.org ([2001:4830:134:3::10]:53849)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1dPg6T-00012I-Sl
	for qemu-devel@nongnu.org; Mon, 26 Jun 2017 22:19:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1dPg6P-0002y3-Ra
	for qemu-devel@nongnu.org; Mon, 26 Jun 2017 22:19:45 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34766)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1dPg6P-0002xV-ID
	for qemu-devel@nongnu.org; Mon, 26 Jun 2017 22:19:41 -0400
References: <1498185154-29015-1-git-send-email-wei.w.wang@intel.com>
	<9c3402b1-961d-b953-ca6c-188b03ed756b@redhat.com>
	<595093A8.1080902@intel.com>
	<c4aac325-3775-ab86-eb5f-b951339eafd7@redhat.com>
	<5950E331.6050409@intel.com>
	<20170627002016-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <9a1fa44b-36ef-b50c-2f1c-2d4ff7628270@redhat.com>
Date: Tue, 27 Jun 2017 10:19:32 +0800
MIME-Version: 1.0
In-Reply-To: <20170627002016-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [virtio-dev] Re: [PATCH v3 1/2] virtio-net: enable
 configurable tx queue size
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>, Wei Wang <wei.w.wang@intel.com>
Cc: eblake@redhat.com, virtio-dev@lists.oasis-open.org, qemu-devel@nongnu.org, stefanha@gmail.com, armbru@redhat.com, jan.scheurich@ericsson.com, marcandre.lureau@gmail.com, pbonzini@redhat.com



On 2017=E5=B9=B406=E6=9C=8827=E6=97=A5 05:21, Michael S. Tsirkin wrote:
> On Mon, Jun 26, 2017 at 06:34:25PM +0800, Wei Wang wrote:
>> On 06/26/2017 04:05 PM, Jason Wang wrote:
>>>
>>> On 2017=E5=B9=B406=E6=9C=8826=E6=97=A5 12:55, Wei Wang wrote:
>>>> On 06/26/2017 11:18 AM, Jason Wang wrote:
>>>>> On 2017=E5=B9=B406=E6=9C=8823=E6=97=A5 10:32, Wei Wang wrote:
>>>>>> This patch enables the virtio-net tx queue size to be configurable
>>>>>> between 256 (the default queue size) and 1024 by the user when the
>>>>>> vhost-user backend is used.
>>>>>>
>>>>>> Currently, the maximum tx queue size for other backends is 512 due
>>>>>> to the following limitations:
>>>>>> - QEMU backend: the QEMU backend implementation in some cases may
>>>>>> send 1024+1 iovs to writev.
>>>>>> - Vhost_net backend: there are possibilities that the guest sends
>>>>>> a vring_desc of memory which corsses a MemoryRegion thereby
>>>>>> generating more than 1024 iovs after translattion from guest-physi=
cal
>>>>>> address in the backend.
>>>>>>
>>>>>> Signed-off-by: Wei Wang <wei.w.wang@intel.com>
>>>>>> ---
>>>>>>    hw/net/virtio-net.c            | 45
>>>>>> +++++++++++++++++++++++++++++++++---------
>>>>>>    include/hw/virtio/virtio-net.h |  1 +
>>>>>>    2 files changed, 37 insertions(+), 9 deletions(-)
>>>>>>
>>>>>> diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
>>>>>> index 91eddaf..d13ca60 100644
>>>>>> --- a/hw/net/virtio-net.c
>>>>>> +++ b/hw/net/virtio-net.c
>>>>>> @@ -34,8 +34,11 @@
>>>>>>      /* previously fixed value */
>>>>>>    #define VIRTIO_NET_RX_QUEUE_DEFAULT_SIZE 256
>>>>>> +
>>>>>> +    /*
>>>>>> +     * Currently, backends other than vhost-user don't
>>>>>> support 1024 queue
>>>>>> +     * size.
>>>>>> +     */
>>>>>> +    if (n->net_conf.tx_queue_size =3D=3D VIRTQUEUE_MAX_SIZE &&
>>>>>> +        nc->peer->info->type !=3D NET_CLIENT_DRIVER_VHOST_USER) {
>>>>>> +        n->net_conf.tx_queue_size =3D VIRTIO_NET_TX_QUEUE_DEFAULT=
_SIZE;
>>>>> Do we really want assume all vhost-user backend support 1024
>>>>> queue size?
>>>>>
>>>>   Do you know any vhost-user backend implementation that doesn't sup=
port
>>>> 1024 tx queue size?
>>>>
>>>>
>>> I don't but the issue is vhost-user uditis an open protocol, there co=
uld
>>> be even closed source implementation on this. So we can't audit all
>>> kinds of backends.
>>>
>> This is the discussion left before. Here is my thought:
>>
>> Until now, nobody is officially using 1024 tx queue size, including th=
e
>> unknown
>> vhost-user backend implementation. So, applying this patch won't affec=
t any
>> already deployed products.
>>
>> If someday, people whose products are based on the unknown vhost-user
>> implementation change to try with 1024 tx queue size and apply this pa=
tch,
>> and find 1024 doesn't work for them, they can simply set the value to =
512
>> (which
>> is better than the 256 size they were using) or apply the 2nd patch en=
titled
>> "VIRTIO_F_MAX_CHAIN_SIZE" to use 1024 queue size.
>>
>> I didn't see any big issue here. Would you see any issues?
>>
>> @Michael, what is your opinion?
> Since the default does not change, I think it's fine.
> You need to both have a non-default value and be using
> a backend that does not support the 1024 size.
> Seems unlikely to me.

But this patch in fact allows 1024 to be used even for vhost-kernel=20
after migration from vhost-user?

Thanks

>
>
>>>>>> +    }
>>>>>> +
>>>>>> +    for (i =3D 0; i < n->max_queues; i++) {
>>>>>> +        virtio_net_add_queue(n, i);
>>>>>> +    }
>>>>> Any reason to move virtio_net_add_queue() here?
>>>>>
>>>> Please check the whole init steps.  It was moved here (after
>>>> qemu_new_nic())
>>>> to make sure nc->peer is not NULL.
>>> I don't get here, can't you get peer just from nic_conf.peers?
>>>
>> Correct, nic_conf.peers also works. Thanks.
>>
>> Best,
>> Wei
>>
>>
>>
> ---------------------------------------------------------------------
> To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
> For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org
>
