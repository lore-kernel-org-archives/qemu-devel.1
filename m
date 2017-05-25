Received: from eggs.gnu.org ([2001:4830:134:3::10]:40800)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wei.w.wang@intel.com>) id 1dDrG7-0005qE-Mv
	for qemu-devel@nongnu.org; Thu, 25 May 2017 07:48:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <wei.w.wang@intel.com>) id 1dDrG4-0007bf-EQ
	for qemu-devel@nongnu.org; Thu, 25 May 2017 07:48:51 -0400
Received: from mga11.intel.com ([192.55.52.93]:63798)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <wei.w.wang@intel.com>)
	id 1dDrG4-0007b0-3p
	for qemu-devel@nongnu.org; Thu, 25 May 2017 07:48:48 -0400
Message-ID: <5926C519.6080508@intel.com>
Date: Thu, 25 May 2017 19:50:49 +0800
From: Wei Wang <wei.w.wang@intel.com>
MIME-Version: 1.0
References: <1495161139-28757-1-git-send-email-wei.w.wang@intel.com>
	<20170519233750-mutt-send-email-mst@kernel.org>
	<5922D0EC.6060405@intel.com>
	<b415fea9-9d48-9390-0ec2-46f69b7a54b0@redhat.com>
	<5923C557.3020301@intel.com>
	<ac8a484d-744a-8bdf-eba2-05239c6eefb1@redhat.com>
	<5924109F.6090608@intel.com>
	<48ec0c88-801f-fc1f-401f-51cb2ca3fed2@redhat.com>
	<592541D9.3030303@intel.com>
	<781faa1c-9253-d212-f616-2a899087edc1@redhat.com>
In-Reply-To: <781faa1c-9253-d212-f616-2a899087edc1@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [virtio-dev] Re: [PATCH RFC] virtio-net: enable
 configurable tx queue size
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jason Wang <jasowang@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
Cc: virtio-dev@lists.oasis-open.org, stefanha@gmail.com, qemu-devel@nongnu.org, jan.scheurich@ericsson.com, marcandre.lureau@gmail.com, pbonzini@redhat.com

On 05/25/2017 03:49 PM, Jason Wang wrote:
>
>
> On 2017年05月24日 16:18, Wei Wang wrote:
>> On 05/24/2017 11:19 AM, Jason Wang wrote:
>>>
>>>
>>> On 2017年05月23日 18:36, Wei Wang wrote:
>>>> On 05/23/2017 02:24 PM, Jason Wang wrote:
>>>>>
>>>>>
>>>>> On 2017年05月23日 13:15, Wei Wang wrote:
>>>>>> On 05/23/2017 10:04 AM, Jason Wang wrote:
>>>>>>>
>>>>>>>
>>>>>>> On 2017年05月22日 19:52, Wei Wang wrote:
>>>>>>>> On 05/20/2017 04:42 AM, Michael S. Tsirkin wrote:
>>>>>>>>> On Fri, May 19, 2017 at 10:32:19AM +0800, Wei Wang wrote:
>>>>>>>>>> This patch enables the virtio-net tx queue size to be 
>>>>>>>>>> configurable
>>>>>>>>>> between 256 (the default queue size) and 1024 by the user. 
>>>>>>>>>> The queue
>>>>>>>>>> size specified by the user should be power of 2.
>>>>>>>>>>
>>>>>>>>>> Setting the tx queue size to be 1024 requires the guest 
>>>>>>>>>> driver to
>>>>>>>>>> support the VIRTIO_NET_F_MAX_CHAIN_SIZE feature.
>>>>>>>>> This should be a generic ring feature, not one specific to 
>>>>>>>>> virtio net.
>>>>>>>> OK. How about making two more changes below:
>>>>>>>>
>>>>>>>> 1) make the default tx queue size = 1024 (instead of 256).
>>>>>>>
>>>>>>> As has been pointed out, you need compat the default value too 
>>>>>>> in this case.
>>>>>>
>>>>>> The driver gets the size info from the device, then would it 
>>>>>> cause any
>>>>>> compatibility issue if we change the default ring size to 1024 in 
>>>>>> the
>>>>>> vhost case? In other words, is there any software (i.e. any 
>>>>>> virtio-net driver)
>>>>>> functions based on the assumption of 256 queue size?
>>>>>
>>>>> I don't know. But is it safe e.g we migrate from 1024 to an older 
>>>>> qemu with 256 as its queue size?
>>>>
>>>> Yes, I think it is safe, because the default queue size is used 
>>>> when the device is being
>>>> set up (e.g. feature negotiation).
>>>> During migration (the device has already been running), the 
>>>> destination machine will
>>>> load the device state based on the the queue size that is being 
>>>> used (i.e. vring.num).
>>>> The default value is not used any more after the setup phase.
>>>
>>> I haven't checked all cases, but there's two obvious things:
>>>
>>> - After migration and after a reset, it will go back to 256 on dst.
>>
>> Please let me clarify what we want first: when QEMU boots and it 
>> realizes the
>> virtio-net device, if the tx_queue_size is not given by the command 
>> line, we want
>> to use 1024 as the queue size, that is, virtio_add_queue(,1024,), 
>> which sets
>> vring.num=1024 and vring.num_default=1024.
>>
>> When migration happens, the vring.num variable (has been 1024) is 
>> sent to
>> the destination machine, where virtio_load() will assign the 
>> destination side vring.num
>> to that value (1024). So, vring.num=1024 continues to work on the 
>> destination machine
>> with old QEMU. I don't see an issue here.
>>
>> If reset happens, I think the device and driver will re-do the 
>> initialization steps. So, if they are
>> with the old QEMU, then they use the old qemu realize() function to 
>> do virtio_add_queue(,256,),
>> and the driver will re-do the probe() steps and take vring.num=256, 
>> then everything works fine.
>
> Probably works fine but the size is 256 forever after migration. 
> Instead of using 1024 which work just one time and maybe risky, isn't 
> it better to just use 256 for old machine types?
>

If it migrates to the old QEMU, then I think everything should work in 
the old QEMU style after
reset (not just our virtio-net case). I think this should be something 
natural and reasonable.

Why would the change depends on machine types?

>>
>>
>>> - ABI is changed, e.g -M pc-q35-2.10 returns 1024 on 2.11
>>>
>> Didn't get this. Could you please explain more? which ABI would be 
>> changed, and why it affects q35?
>>
>
> Nothing specific to q35, just to point out the machine type of 2.10.
>
> E.g on 2.10, -M pc-q35-2.10, vring.num is 256; On 2.11 -M pc-q35-2.10 
> vring.num is 1024.
>

I think it's not related to the machine type.

Probably we can use QEMU version to discuss here.
Suppose this change will be made to the next version, QEMU 2.10. Then 
with QEMU 2.10, when
people create a virtio-net device as usual:
-device virtio-net-pci,netdev=net1,mac=52:54:00:00:00:01
it will creates a device with queue size = 1024.
If they use QEMU 2.9, then the queue size = 256.

What ABI change did you mean?

>>
>>>>
>>>>>
>>>>>>
>>>>>> For live migration, the queue size that is being used will also 
>>>>>> be transferred
>>>>>> to the destination.
>>>>>>
>>>>>>>
>>>>>>>> We can reduce the size (to 256) if the MAX_CHAIN_SIZE feature
>>>>>>>> is not supported by the guest.
>>>>>>>> In this way, people who apply the QEMU patch can directly use the
>>>>>>>> largest queue size(1024) without adding the booting command line.
>>>>>>>>
>>>>>>>> 2) The vhost backend does not use writev, so I think when the 
>>>>>>>> vhost
>>>>>>>> backed is used, using 1024 queue size should not depend on the
>>>>>>>> MAX_CHAIN_SIZE feature.
>>>>>>>
>>>>>>> But do we need to consider even larger queue size now?
>>>>>>
>>>>>> Need Michael's feedback on this. Meanwhile, I'll get the next 
>>>>>> version of
>>>>>> code ready and check if larger queue size would cause any corner 
>>>>>> case.
>>>>>
>>>>> The problem is, do we really need a new config filed for this? Or 
>>>>> just introduce a flag which means "I support up to 1024 sgs" is 
>>>>> sufficient?
>>>>>
>>>>
>>>> For now, it also works without the new config field, max_chain_size,
>>>> But I would prefer to keep the new config field, because:
>>>>
>>>> Without that, the driver will work on  an assumed value, 1023.
>>>
>>> This is the fact, and it's too late to change legacy driver.
>>>
>>>> If the future, QEMU needs to change it to 1022, then how can the
>>>> new QEMU tell the old driver, which supports the MAX_CHAIN_SIZE
>>>> feature but works with the old hardcode value 1023?
>>>
>>> Can config filed help in this case? The problem is similar to 
>>> ANY_HEADER_SG, the only thing we can is to clarify the limitation 
>>> for new drivers.
>>>
>>
>> I think it helps, because the driver will do
>> virtio_cread_feature(vdev, VIRTIO_NET_F_MAX_CHAIN_SIZE,
>>                                   struct virtio_net_config, 
>> max_chain_size, &chain_size);
>> to get the max_chain_size from the device. So when new QEMU has a new 
>> value of max_chain_size, old driver
>> will get the new value.
>
> I think we're talking about old drivers, so this won't work. It can 
> only work with assumptions (implicitly).
>
> Thanks
>
Not the case. Old drivers which don't have VIRTIO_NET_F_MAX_CHAIN_SIZE 
feature support, will not allow
the device to use 1024 queue size. So, in that case, the device will use 
the old, 256, queue size.

The point of using the config field here is, when tomorrow's device is 
released with a requirement for the driver
to use max_chain_size=1022 (not today's 1023), today's driver will 
naturally support tomorrow's device without
any modification, since it reads the max_chain_size from the config 
field which is filled by the device (either today's
device or tomorrow's device with different values).

Best,
Wei
