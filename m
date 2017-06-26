Received: from eggs.gnu.org ([2001:4830:134:3::10]:34111)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1dPP1z-0000Wc-D2
	for qemu-devel@nongnu.org; Mon, 26 Jun 2017 04:06:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1dPP1w-0001H8-5g
	for qemu-devel@nongnu.org; Mon, 26 Jun 2017 04:05:59 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34086)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1dPP1v-0001Gw-Sm
	for qemu-devel@nongnu.org; Mon, 26 Jun 2017 04:05:56 -0400
References: <1498185154-29015-1-git-send-email-wei.w.wang@intel.com>
	<9c3402b1-961d-b953-ca6c-188b03ed756b@redhat.com>
	<595093A8.1080902@intel.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <c4aac325-3775-ab86-eb5f-b951339eafd7@redhat.com>
Date: Mon, 26 Jun 2017 16:05:44 +0800
MIME-Version: 1.0
In-Reply-To: <595093A8.1080902@intel.com>
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
To: Wei Wang <wei.w.wang@intel.com>, mst@redhat.com, eblake@redhat.com, virtio-dev@lists.oasis-open.org, qemu-devel@nongnu.org
Cc: stefanha@gmail.com, armbru@redhat.com, jan.scheurich@ericsson.com, marcandre.lureau@gmail.com, pbonzini@redhat.com



On 2017=E5=B9=B406=E6=9C=8826=E6=97=A5 12:55, Wei Wang wrote:
> On 06/26/2017 11:18 AM, Jason Wang wrote:
>>
>> On 2017=E5=B9=B406=E6=9C=8823=E6=97=A5 10:32, Wei Wang wrote:
>>> This patch enables the virtio-net tx queue size to be configurable
>>> between 256 (the default queue size) and 1024 by the user when the
>>> vhost-user backend is used.
>>>
>>> Currently, the maximum tx queue size for other backends is 512 due
>>> to the following limitations:
>>> - QEMU backend: the QEMU backend implementation in some cases may
>>> send 1024+1 iovs to writev.
>>> - Vhost_net backend: there are possibilities that the guest sends
>>> a vring_desc of memory which corsses a MemoryRegion thereby
>>> generating more than 1024 iovs after translattion from guest-physical
>>> address in the backend.
>>>
>>> Signed-off-by: Wei Wang <wei.w.wang@intel.com>
>>> ---
>>>   hw/net/virtio-net.c            | 45=20
>>> +++++++++++++++++++++++++++++++++---------
>>>   include/hw/virtio/virtio-net.h |  1 +
>>>   2 files changed, 37 insertions(+), 9 deletions(-)
>>>
>>> diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
>>> index 91eddaf..d13ca60 100644
>>> --- a/hw/net/virtio-net.c
>>> +++ b/hw/net/virtio-net.c
>>> @@ -34,8 +34,11 @@
>>>     /* previously fixed value */
>>>   #define VIRTIO_NET_RX_QUEUE_DEFAULT_SIZE 256
>>> +
>>> +    /*
>>> +     * Currently, backends other than vhost-user don't support 1024=20
>>> queue
>>> +     * size.
>>> +     */
>>> +    if (n->net_conf.tx_queue_size =3D=3D VIRTQUEUE_MAX_SIZE &&
>>> +        nc->peer->info->type !=3D NET_CLIENT_DRIVER_VHOST_USER) {
>>> +        n->net_conf.tx_queue_size =3D VIRTIO_NET_TX_QUEUE_DEFAULT_SI=
ZE;
>>
>> Do we really want assume all vhost-user backend support 1024 queue siz=
e?
>>
>
>  Do you know any vhost-user backend implementation that doesn't support
> 1024 tx queue size?
>
>

I don't but the issue is vhost-user uditis an open protocol, there could=20
be even closed source implementation on this. So we can't audit all=20
kinds of backends.

>
>>> +    }
>>> +
>>> +    for (i =3D 0; i < n->max_queues; i++) {
>>> +        virtio_net_add_queue(n, i);
>>> +    }
>>
>> Any reason to move virtio_net_add_queue() here?
>>
>
> Please check the whole init steps.  It was moved here (after=20
> qemu_new_nic())
> to make sure nc->peer is not NULL.

I don't get here, can't you get peer just from nic_conf.peers?

Thanks

>
> Best,
> Wei
>
> ---------------------------------------------------------------------
> To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
> For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org
>
