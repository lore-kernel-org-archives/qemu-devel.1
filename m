Received: from eggs.gnu.org ([2001:4830:134:3::10]:35582)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wei.w.wang@intel.com>) id 1dPeuz-0000eV-Qw
	for qemu-devel@nongnu.org; Mon, 26 Jun 2017 21:03:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <wei.w.wang@intel.com>) id 1dPeuw-0000YM-Nt
	for qemu-devel@nongnu.org; Mon, 26 Jun 2017 21:03:49 -0400
Received: from mga04.intel.com ([192.55.52.120]:40018)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <wei.w.wang@intel.com>)
	id 1dPeuw-0000XE-EJ
	for qemu-devel@nongnu.org; Mon, 26 Jun 2017 21:03:46 -0400
Message-ID: <5951AF7F.3010603@intel.com>
Date: Tue, 27 Jun 2017 09:06:07 +0800
From: Wei Wang <wei.w.wang@intel.com>
MIME-Version: 1.0
References: <1498185154-29015-1-git-send-email-wei.w.wang@intel.com>
	<9c3402b1-961d-b953-ca6c-188b03ed756b@redhat.com>
	<595093A8.1080902@intel.com>
	<c4aac325-3775-ab86-eb5f-b951339eafd7@redhat.com>
	<5950E331.6050409@intel.com>
	<20170627002016-mutt-send-email-mst@kernel.org>
In-Reply-To: <20170627002016-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
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
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Jason Wang <jasowang@redhat.com>, eblake@redhat.com, virtio-dev@lists.oasis-open.org, qemu-devel@nongnu.org, stefanha@gmail.com, armbru@redhat.com, jan.scheurich@ericsson.com, marcandre.lureau@gmail.com, pbonzini@redhat.com

On 06/27/2017 05:21 AM, Michael S. Tsirkin wrote:
> On Mon, Jun 26, 2017 at 06:34:25PM +0800, Wei Wang wrote:
>> On 06/26/2017 04:05 PM, Jason Wang wrote:
>>>
>>> On 2017年06月26日 12:55, Wei Wang wrote:
>>>> On 06/26/2017 11:18 AM, Jason Wang wrote:
>>>>> On 2017年06月23日 10:32, Wei Wang wrote:
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
>>>>>> generating more than 1024 iovs after translattion from guest-physical
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
>>>>>> +    if (n->net_conf.tx_queue_size == VIRTQUEUE_MAX_SIZE &&
>>>>>> +        nc->peer->info->type != NET_CLIENT_DRIVER_VHOST_USER) {
>>>>>> +        n->net_conf.tx_queue_size = VIRTIO_NET_TX_QUEUE_DEFAULT_SIZE;
>>>>> Do we really want assume all vhost-user backend support 1024
>>>>> queue size?
>>>>>
>>>>   Do you know any vhost-user backend implementation that doesn't support
>>>> 1024 tx queue size?
>>>>
>>>>
>>> I don't but the issue is vhost-user uditis an open protocol, there could
>>> be even closed source implementation on this. So we can't audit all
>>> kinds of backends.
>>>
>> This is the discussion left before. Here is my thought:
>>
>> Until now, nobody is officially using 1024 tx queue size, including the
>> unknown
>> vhost-user backend implementation. So, applying this patch won't affect any
>> already deployed products.
>>
>> If someday, people whose products are based on the unknown vhost-user
>> implementation change to try with 1024 tx queue size and apply this patch,
>> and find 1024 doesn't work for them, they can simply set the value to 512
>> (which
>> is better than the 256 size they were using) or apply the 2nd patch entitled
>> "VIRTIO_F_MAX_CHAIN_SIZE" to use 1024 queue size.
>>
>> I didn't see any big issue here. Would you see any issues?
>>
>> @Michael, what is your opinion?
> Since the default does not change, I think it's fine.
> You need to both have a non-default value and be using
> a backend that does not support the 1024 size.
> Seems unlikely to me.
>

Were you referring to the use of 512 queue size? I think that's already 
supported
for all the backends.

The above code only makes a non-vhost-user backend, which doesn't 
support 1024,
use the default value when the user specified 1024 queue size. It won't 
make any
change if 512 was given.

Now, we treat all vhost-user backends as the ones that support 1024. If 
a user got an
unknown issue due to their special vhost-user backend 
implementation(maybe bugs
generated by their own) with 1024 queue size, they'll need to re-start 
with 512, and
the code will work with 512.

Best,
Wei
