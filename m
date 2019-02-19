Received: from eggs.gnu.org ([209.51.188.92]:56728)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1gw5A2-0002iA-Be
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 08:10:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1gw59x-00023H-Cs
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 08:10:10 -0500
Received: from mx1.redhat.com ([209.132.183.28]:55108)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1gw59x-0001lG-1U
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 08:10:05 -0500
References: <1550118402-4057-1-git-send-email-wexu@redhat.com>
	<1550118402-4057-10-git-send-email-wexu@redhat.com>
	<1c16f234-af83-23c8-2194-94be63574299@redhat.com>
	<20190219105155.GD15343@wei-ubt>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <b6469e59-0db7-5f6d-8b21-355ffdebb689@redhat.com>
Date: Tue, 19 Feb 2019 21:09:33 +0800
MIME-Version: 1.0
In-Reply-To: <20190219105155.GD15343@wei-ubt>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v4 09/11] virtio-net: update the head
 descriptor in a chain lastly
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Wei Xu <wexu@redhat.com>
Cc: qemu-devel@nongnu.org, maxime.coquelin@redhat.com, tiwei.bie@intel.com, jfreiman@redhat.com, mst@redhat.com


On 2019/2/19 =E4=B8=8B=E5=8D=886:51, Wei Xu wrote:
> On Tue, Feb 19, 2019 at 03:23:01PM +0800, Jason Wang wrote:
>> On 2019/2/14 =E4=B8=8B=E5=8D=8812:26, wexu@redhat.com wrote:
>>> From: Wei Xu <wexu@redhat.com>
>>>
>>> This is a helper for packed ring.
>>>
>>> To support packed ring, the head descriptor in a chain should be upda=
ted
>>> lastly since no 'avail_idx' like in packed ring to explicitly tell th=
e
>>> driver side that all payload is ready after having done the chain, so
>>> the head is always visible immediately.
>>>
>>> This patch fills the header after done all the other ones.
>>>
>>> Signed-off-by: Wei Xu <wexu@redhat.com>
>>
>> It's really odd to workaround API issue in the implementation of devic=
e.
>> Please introduce batched used updating helpers instead.
> Can you elaborate a bit more? I don't get it as well.
>
> The exact batch as vhost-net or dpdk pmd is not supported by userspace
> backend. The change here is to keep the header descriptor updated at
> last in case of a chaining descriptors and the helper might not help
> too much.
>
> Wei


Of course we can add batching support why not?

Your code assumes the device know the virtio layout specific assumption=20
which breaks the layer. Device should not care about the actual layout.

Thanks


>> Thanks
>>
>>
>>> ---
>>>   hw/net/virtio-net.c | 11 ++++++++++-
>>>   1 file changed, 10 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
>>> index 3f319ef..330abea 100644
>>> --- a/hw/net/virtio-net.c
>>> +++ b/hw/net/virtio-net.c
>>> @@ -1251,6 +1251,8 @@ static ssize_t virtio_net_receive_rcu(NetClient=
State *nc, const uint8_t *buf,
>>>       struct virtio_net_hdr_mrg_rxbuf mhdr;
>>>       unsigned mhdr_cnt =3D 0;
>>>       size_t offset, i, guest_offset;
>>> +    VirtQueueElement head;
>>> +    int head_len =3D 0;
>>>       if (!virtio_net_can_receive(nc)) {
>>>           return -1;
>>> @@ -1328,7 +1330,13 @@ static ssize_t virtio_net_receive_rcu(NetClien=
tState *nc, const uint8_t *buf,
>>>           }
>>>           /* signal other side */
>>> -        virtqueue_fill(q->rx_vq, elem, total, i++);
>>> +        if (i =3D=3D 0) {
>>> +            head_len =3D total;
>>> +            head =3D *elem;
>>> +        } else {
>>> +            virtqueue_fill(q->rx_vq, elem, len, i);
>>> +        }
>>> +        i++;
>>>           g_free(elem);
>>>       }
>>> @@ -1339,6 +1347,7 @@ static ssize_t virtio_net_receive_rcu(NetClient=
State *nc, const uint8_t *buf,
>>>                        &mhdr.num_buffers, sizeof mhdr.num_buffers);
>>>       }
>>> +    virtqueue_fill(q->rx_vq, &head, head_len, 0);
>>>       virtqueue_flush(q->rx_vq, i);
>>>       virtio_notify(vdev, q->rx_vq);
