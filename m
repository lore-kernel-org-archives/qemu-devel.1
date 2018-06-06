Received: from eggs.gnu.org ([2001:4830:134:3::10]:55992)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sridhar.samudrala@intel.com>) id 1fQd0D-0002Uw-Lb
	for qemu-devel@nongnu.org; Wed, 06 Jun 2018 14:17:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sridhar.samudrala@intel.com>) id 1fQd0A-0006aA-Gl
	for qemu-devel@nongnu.org; Wed, 06 Jun 2018 14:17:45 -0400
Received: from mga14.intel.com ([192.55.52.115]:18710)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <sridhar.samudrala@intel.com>)
	id 1fQd0A-0006ZK-5t
	for qemu-devel@nongnu.org; Wed, 06 Jun 2018 14:17:42 -0400
References: <1525734594-11134-1-git-send-email-sridhar.samudrala@intel.com>
	<fcefe501-b410-f1ec-829c-68199edcdbef@intel.com>
	<d61c88c7-0803-ba1c-08ab-fc668cffa40b@redhat.com>
From: "Samudrala, Sridhar" <sridhar.samudrala@intel.com>
Message-ID: <8e411566-1146-03a2-5372-8f8134ee0ce6@intel.com>
Date: Wed, 6 Jun 2018 11:17:36 -0700
MIME-Version: 1.0
In-Reply-To: <d61c88c7-0803-ba1c-08ab-fc668cffa40b@redhat.com>
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
To: Jason Wang <jasowang@redhat.com>, mst@redhat.com, virtualization@lists.linux-foundation.org, virtio-dev@lists.oasis-open.org, jesse.brandeburg@intel.com, alexander.h.duyck@intel.com, qemu-devel@nongnu.org, laine@redhat.com, libvir-list@redhat.com

On 6/4/2018 7:06 PM, Jason Wang wrote:
>
>
> On 2018年06月05日 09:41, Samudrala, Sridhar wrote:
>> Ping on this patch now that the kernel patches are accepted into 
>> davem's net-next tree.
>> https://patchwork.ozlabs.org/cover/920005/
>>
>>
>> On 5/7/2018 4:09 PM, Sridhar Samudrala wrote:
>>> This feature bit can be used by hypervisor to indicate virtio_net 
>>> device to
>>> act as a standby for another device with the same MAC address.
>>>
>>> I tested this with a small change to the patch to mark the STANDBY 
>>> feature 'true'
>>> by default as i am using libvirt to start the VMs.
>>> Is there a way to pass the newly added feature bit 'standby' to qemu 
>>> via libvirt
>>> XML file?
>>>
>
> Maybe you can try qemu command line passthrough:
>
> https://libvirt.org/drvqemu.html#qemucommand

It looks like this can be used to pass command line arguments to qemu.
Is it possible to specify a virtio specific attribute via this method?

For ex: to say mrg_rxbuf is off we can add the following line to virtio
section of the domain xml file.
   <host mrg_rxbuf='off'/>

I think libvirt needs to be extended to to support the new 'standby' attribute
via this mechanism.
Adding Liane Stump and libvirt to the CC list.

Michael,
Can we start with getting this patch into Qemu and an update to libvirt to
support the 'standby' feature so that this feature can be enabled via
some scripts/orchestration layer for now.

We could improve this solution by enhancing Qemu to do automatic management of the
addition/deletion of the primary device based on feature negotiation as a later patch.


>
> The patch looks good to me. Let's see if Michael have any comment.
>
> Thanks
>
>>> Signed-off-by: Sridhar Samudrala <sridhar.samudrala@intel.com>
>>> ---
>>>   hw/net/virtio-net.c                         | 2 ++
>>>   include/standard-headers/linux/virtio_net.h | 3 +++
>>>   2 files changed, 5 insertions(+)
>>>
>>> diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
>>> index 90502fca7c..38b3140670 100644
>>> --- a/hw/net/virtio-net.c
>>> +++ b/hw/net/virtio-net.c
>>> @@ -2198,6 +2198,8 @@ static Property virtio_net_properties[] = {
>>>                        true),
>>>       DEFINE_PROP_INT32("speed", VirtIONet, net_conf.speed, 
>>> SPEED_UNKNOWN),
>>>       DEFINE_PROP_STRING("duplex", VirtIONet, net_conf.duplex_str),
>>> +    DEFINE_PROP_BIT64("standby", VirtIONet, host_features, 
>>> VIRTIO_NET_F_STANDBY,
>>> +                      false),
>>>       DEFINE_PROP_END_OF_LIST(),
>>>   };
>>>   diff --git a/include/standard-headers/linux/virtio_net.h 
>>> b/include/standard-headers/linux/virtio_net.h
>>> index e9f255ea3f..01ec09684c 100644
>>> --- a/include/standard-headers/linux/virtio_net.h
>>> +++ b/include/standard-headers/linux/virtio_net.h
>>> @@ -57,6 +57,9 @@
>>>                        * Steering */
>>>   #define VIRTIO_NET_F_CTRL_MAC_ADDR 23    /* Set MAC address */
>>>   +#define VIRTIO_NET_F_STANDBY      62    /* Act as standby for 
>>> another device
>>> +                                         * with the same MAC.
>>> +                                         */
>>>   #define VIRTIO_NET_F_SPEED_DUPLEX 63    /* Device set linkspeed 
>>> and duplex */
>>>     #ifndef VIRTIO_NET_NO_LEGACY
>>
>
