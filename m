Received: from eggs.gnu.org ([2001:4830:134:3::10]:43794)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sridhar.samudrala@intel.com>) id 1fSxKN-0003kn-53
	for qemu-devel@nongnu.org; Wed, 13 Jun 2018 00:24:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sridhar.samudrala@intel.com>) id 1fSxKI-00013p-Pt
	for qemu-devel@nongnu.org; Wed, 13 Jun 2018 00:24:11 -0400
Received: from mga18.intel.com ([134.134.136.126]:9432)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <sridhar.samudrala@intel.com>)
	id 1fSxKI-00013d-Dc
	for qemu-devel@nongnu.org; Wed, 13 Jun 2018 00:24:06 -0400
References: <1525734594-11134-1-git-send-email-sridhar.samudrala@intel.com>
	<fcefe501-b410-f1ec-829c-68199edcdbef@intel.com>
	<20180605152344-mutt-send-email-mst@kernel.org>
	<a45625c9-d2cd-f8f7-ce31-37c558e70b88@redhat.com>
	<20180612144743-mutt-send-email-mst@kernel.org>
	<5718de66-74c9-1362-a87b-2eba02475b48@redhat.com>
From: "Samudrala, Sridhar" <sridhar.samudrala@intel.com>
Message-ID: <c29a5ac9-cfb5-0a19-f28c-30d41bd5efcf@intel.com>
Date: Tue, 12 Jun 2018 21:24:01 -0700
MIME-Version: 1.0
In-Reply-To: <5718de66-74c9-1362-a87b-2eba02475b48@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Subject: Re: [Qemu-devel] [PATCH] qemu: Introduce VIRTIO_NET_F_STANDBY
 feature bit to virtio_net
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jason Wang <jasowang@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
Cc: virtualization@lists.linux-foundation.org, virtio-dev@lists.oasis-open.org, jesse.brandeburg@intel.com, alexander.h.duyck@intel.com, qemu-devel@nongnu.org

On 6/12/2018 7:38 PM, Jason Wang wrote:
>
>
> On 2018年06月12日 19:54, Michael S. Tsirkin wrote:
>> On Wed, Jun 06, 2018 at 10:29:03AM +0800, Jason Wang wrote:
>>>
>>> On 2018年06月05日 20:33, Michael S. Tsirkin wrote:
>>>> I don't think this is sufficient.
>>>>
>>>> If both primary and standby devices are present, a legacy guest 
>>>> without
>>>> support for the feature might see two devices with same mac and get
>>>> confused.
>>>>
>>>> I think that we should only make primary visible after guest acked the
>>>> backup feature bit.
>>> I think we want exactly the reverse? E.g fail the negotiation when 
>>> guest
>>> does not ack backup feature.
>>>
>>> Otherwise legacy guest won't even have the chance to see primary 
>>> device in
>>> the guest.
>> That's by design.
>
> So management needs to know the capability of guest to set the backup 
> feature. This looks a chicken or egg problem to me.

I don't think so. If the tenant requests 'accelerated datapath feature', the management
will set 'standby' feature bit on virtio-net interface and if the guest virtio-net driver
supports this feature, then the tenant VM will get that capability via a hot-plugged
primary device.


>
>>
>>>> And on reset or when backup is cleared in some other way, unplug the
>>>> primary.
>>> What if guest does not support hotplug?
>> It shouldn't ack the backup feature then and it's a good point.
>> We should both document this and check kernel config has
>> hotplug support. Sridhar could you take a look pls?
>>
>>>> Something like the below will do the job:
>>>>
>>>> Primary device is added with a special "primary-failover" flag.
>>>> A virtual machine is then initialized with just a standby virtio
>>>> device. Primary is not yet added.
>>> A question is how to do the matching? Qemu knows nothing about e.g mac
>>> address of a pass-through device I believe?
>> Supply a flag to the VFIO when it's added, this way QEMU will know.
>>
>>>> Later QEMU detects that guest driver device set DRIVER_OK.
>>>> It then exposes the primary device to the guest, and triggers
>>>> a device addition event (hot-plug event) for it.
>>> Do you mean we won't have primary device in the initial qemu cli?
>> No, that's not what I mean.
>>
>> I mean management will supply a flag to VFIO and then
>>
>>
>> - VFIO defers exposing
>> primary to guest until guest acks the feature bit.
>> - When we see guest ack, initiate hotplug.
>> - On reboot, hide it again.
>> - On reset without reboot, request hot-unplug and on eject hide it 
>> again.
>
> This sounds much like a kind of bonding in qemu.
>
>>
>>>> If QEMU detects guest driver removal, it initiates a hot-unplug 
>>>> sequence
>>>> to remove the primary driver.  In particular, if QEMU detects guest
>>>> re-initialization (e.g. by detecting guest reset) it immediately 
>>>> removes
>>>> the primary device.
>>> I believe guest failover module should handle this gracefully?
>> It can't control enumeration order, if primary is enumerated before
>> standby then guest will load its driver and it's too late
>> when failover driver is loaded.
>
> Well, even if we can delay the visibility of primary until DRIVER_OK, 
> there still be a race I think? And it looks to me it's still a bug of 
> guest:
>
> E.g primary could be probed before failover_register() in guest. Then 
> we will miss the enslaving of primary forever.

That is not an issue. Even if the primary is probed before failover driver, it will
enslave the primary via the call to failover_existing_slave_register() as part of
failover_register() routine.

>
> Thanks
>
>>
>>> Thanks
>>>
>>>> We can move some of this code to management as well, 
>>>> architecturally it
>>>> does not make too much sense but it might be easier 
>>>> implementation-wise.
>>>>
>>>> HTH
>>>>
>>>> On Mon, Jun 04, 2018 at 06:41:48PM -0700, Samudrala, Sridhar wrote:
>>>>> Ping on this patch now that the kernel patches are accepted into 
>>>>> davem's net-next tree.
>>>>> https://patchwork.ozlabs.org/cover/920005/
>>>>>
>>>>>
>>>>> On 5/7/2018 4:09 PM, Sridhar Samudrala wrote:
>>>>>> This feature bit can be used by hypervisor to indicate virtio_net 
>>>>>> device to
>>>>>> act as a standby for another device with the same MAC address.
>>>>>>
>>>>>> I tested this with a small change to the patch to mark the 
>>>>>> STANDBY feature 'true'
>>>>>> by default as i am using libvirt to start the VMs.
>>>>>> Is there a way to pass the newly added feature bit 'standby' to 
>>>>>> qemu via libvirt
>>>>>> XML file?
>>>>>>
>>>>>> Signed-off-by: Sridhar Samudrala <sridhar.samudrala@intel.com>
>>>>>> ---
>>>>>>     hw/net/virtio-net.c                         | 2 ++
>>>>>>     include/standard-headers/linux/virtio_net.h | 3 +++
>>>>>>     2 files changed, 5 insertions(+)
>>>>>>
>>>>>> diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
>>>>>> index 90502fca7c..38b3140670 100644
>>>>>> --- a/hw/net/virtio-net.c
>>>>>> +++ b/hw/net/virtio-net.c
>>>>>> @@ -2198,6 +2198,8 @@ static Property virtio_net_properties[] = {
>>>>>>                          true),
>>>>>>         DEFINE_PROP_INT32("speed", VirtIONet, net_conf.speed, 
>>>>>> SPEED_UNKNOWN),
>>>>>>         DEFINE_PROP_STRING("duplex", VirtIONet, 
>>>>>> net_conf.duplex_str),
>>>>>> +    DEFINE_PROP_BIT64("standby", VirtIONet, host_features, 
>>>>>> VIRTIO_NET_F_STANDBY,
>>>>>> +                      false),
>>>>>>         DEFINE_PROP_END_OF_LIST(),
>>>>>>     };
>>>>>> diff --git a/include/standard-headers/linux/virtio_net.h 
>>>>>> b/include/standard-headers/linux/virtio_net.h
>>>>>> index e9f255ea3f..01ec09684c 100644
>>>>>> --- a/include/standard-headers/linux/virtio_net.h
>>>>>> +++ b/include/standard-headers/linux/virtio_net.h
>>>>>> @@ -57,6 +57,9 @@
>>>>>>                          * Steering */
>>>>>>     #define VIRTIO_NET_F_CTRL_MAC_ADDR 23    /* Set MAC address */
>>>>>> +#define VIRTIO_NET_F_STANDBY      62    /* Act as standby for 
>>>>>> another device
>>>>>> +                                         * with the same MAC.
>>>>>> +                                         */
>>>>>>     #define VIRTIO_NET_F_SPEED_DUPLEX 63    /* Device set 
>>>>>> linkspeed and duplex */
>>>>>>     #ifndef VIRTIO_NET_NO_LEGACY
>
