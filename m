Received: from eggs.gnu.org ([2001:4830:134:3::10]:36484)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1gBxtM-00028u-CF
	for qemu-devel@nongnu.org; Mon, 15 Oct 2018 04:06:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1gBxtK-0005Oo-5Y
	for qemu-devel@nongnu.org; Mon, 15 Oct 2018 04:06:20 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36566)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1gBxtJ-0005Ls-1s
	for qemu-devel@nongnu.org; Mon, 15 Oct 2018 04:06:18 -0400
References: <1539266915-15216-1-git-send-email-wexu@redhat.com>
	<1539266915-15216-10-git-send-email-wexu@redhat.com>
	<fb04c68b-024b-5be8-00ea-e558f9ae0d12@redhat.com>
	<20181015080343.GE27871@wei-ubt>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <e6c8b457-210f-bf90-8345-5473f537305e@redhat.com>
Date: Mon, 15 Oct 2018 16:05:58 +0800
MIME-Version: 1.0
In-Reply-To: <20181015080343.GE27871@wei-ubt>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [[RFC v3 09/12] virtio-net: fill head desc after
 done all in a chain
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Wei Xu <wexu@redhat.com>
Cc: maxime.coquelin@redhat.com, jfreimann@redhat.com, qemu-devel@nongnu.org, tiwei.bie@intel.com



On 2018=E5=B9=B410=E6=9C=8815=E6=97=A5 16:03, Wei Xu wrote:
> On Mon, Oct 15, 2018 at 03:45:46PM +0800, Jason Wang wrote:
>>
>> On 2018=E5=B9=B410=E6=9C=8811=E6=97=A5 22:08, wexu@redhat.com wrote:
>>> From: Wei Xu <wexu@redhat.com>
>>>
>>> With the support of marking a descriptor used/unused in 'flags'
>>> field for 1.1, the current way of filling a chained descriptors
>>> does not work since driver side may get the wrong 'num_buffer'
>>> information in case of the head descriptor has been filled in
>>> while the subsequent ones are still in processing in device side.
>>>
>>> This patch fills the head one after done all the others one.
>>>
>>> Signed-off-by: Wei Xu <wexu@redhat.com>
>>> ---
>>>   hw/net/virtio-net.c | 11 ++++++++++-
>>>   1 file changed, 10 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
>>> index 4bdd5b8..186c86cd2 100644
>>> --- a/hw/net/virtio-net.c
>>> +++ b/hw/net/virtio-net.c
>>> @@ -1198,6 +1198,8 @@ static ssize_t virtio_net_receive_rcu(NetClient=
State *nc, const uint8_t *buf,
>>>       struct virtio_net_hdr_mrg_rxbuf mhdr;
>>>       unsigned mhdr_cnt =3D 0;
>>>       size_t offset, i, guest_offset;
>>> +    VirtQueueElement head;
>>> +    int head_len =3D 0;
>>>       if (!virtio_net_can_receive(nc)) {
>>>           return -1;
>>> @@ -1275,7 +1277,13 @@ static ssize_t virtio_net_receive_rcu(NetClien=
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
>>> @@ -1286,6 +1294,7 @@ static ssize_t virtio_net_receive_rcu(NetClient=
State *nc, const uint8_t *buf,
>>>                        &mhdr.num_buffers, sizeof mhdr.num_buffers);
>>>       }
>>> +    virtqueue_fill(q->rx_vq, &head, head_len, 0);
>> It's not a good idea to fix API in device implementation. Let's introd=
uce
>> new API and fix it there.
>>
>> E.g virtqueue_fill_n() and update the flag of first elem at the last s=
tep.
> OK, I haven't considered about the other devices so far.

It will be an issue if they use virtqueue_fill() directly.

Thanks

>
> Wei
>
>> Thanks
>>
>>>       virtqueue_flush(q->rx_vq, i);
>>>       virtio_notify(vdev, q->rx_vq);
>>
