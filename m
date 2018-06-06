Received: from eggs.gnu.org ([2001:4830:134:3::10]:44535)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sridhar.samudrala@intel.com>) id 1fQeH5-0004gM-EM
	for qemu-devel@nongnu.org; Wed, 06 Jun 2018 15:39:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sridhar.samudrala@intel.com>) id 1fQeH1-0000QR-3S
	for qemu-devel@nongnu.org; Wed, 06 Jun 2018 15:39:15 -0400
Received: from mga04.intel.com ([192.55.52.120]:31340)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <sridhar.samudrala@intel.com>)
	id 1fQeH0-0000Pj-QM
	for qemu-devel@nongnu.org; Wed, 06 Jun 2018 15:39:11 -0400
References: <1525734594-11134-1-git-send-email-sridhar.samudrala@intel.com>
	<fcefe501-b410-f1ec-829c-68199edcdbef@intel.com>
	<d61c88c7-0803-ba1c-08ab-fc668cffa40b@redhat.com>
	<8e411566-1146-03a2-5372-8f8134ee0ce6@intel.com>
	<20180606185214.GH6767@dnr>
From: "Samudrala, Sridhar" <sridhar.samudrala@intel.com>
Message-ID: <98da062a-9332-345d-bbd8-28346cb9a196@intel.com>
Date: Wed, 6 Jun 2018 12:39:05 -0700
MIME-Version: 1.0
In-Reply-To: <20180606185214.GH6767@dnr>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Subject: Re: [Qemu-devel] [libvirt] [PATCH] qemu: Introduce
 VIRTIO_NET_F_STANDBY feature bit to virtio_net
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?J=c3=a1n_Tomko?= <jtomko@redhat.com>
Cc: Jason Wang <jasowang@redhat.com>, mst@redhat.com, virtualization@lists.linux-foundation.org, virtio-dev@lists.oasis-open.org, jesse.brandeburg@intel.com, alexander.h.duyck@intel.com, qemu-devel@nongnu.org, laine@redhat.com, libvir-list@redhat.com



On 6/6/2018 11:52 AM, Ján Tomko wrote:
> On Wed, Jun 06, 2018 at 11:17:36AM -0700, Samudrala, Sridhar wrote:
>> On 6/4/2018 7:06 PM, Jason Wang wrote:
>>>
>>>
>>> On 2018年06月05日 09:41, Samudrala, Sridhar wrote:
>>>> Ping on this patch now that the kernel patches are accepted into
>>>> davem's net-next tree.
>>>> https://patchwork.ozlabs.org/cover/920005/
>>>>
>>>>
>>>> On 5/7/2018 4:09 PM, Sridhar Samudrala wrote:
>>>>> This feature bit can be used by hypervisor to indicate virtio_net
>>>>> device to
>>>>> act as a standby for another device with the same MAC address.
>>>>>
>>>>> I tested this with a small change to the patch to mark the STANDBY
>>>>> feature 'true'
>>>>> by default as i am using libvirt to start the VMs.
>>>>> Is there a way to pass the newly added feature bit 'standby' to qemu
>>>>> via libvirt
>>>>> XML file?
>>>>>
>>>
>>> Maybe you can try qemu command line passthrough:
>>>
>>> https://libvirt.org/drvqemu.html#qemucommand
>>
>> It looks like this can be used to pass command line arguments to qemu.
>> Is it possible to specify a virtio specific attribute via this method?
>>
>
> Yes, for testing purposes you should be able to do this via using QEMU's
> -set command line argument:
> http://blog.vmsplice.net/2011/04/how-to-pass-qemu-command-line-options.html 
>
> i.e.:
>
> <domain type='kvm' 
> xmlns:qemu='http://libvirt.org/schemas/domain/qemu/1.0'>
>  ...
>  <qemu:commandline>
>    <qemu:arg value='-set'/>
>    <qemu:arg value='device.net0.standby=on'/>
>  </qemu:commandline>
> </domain>

Thanks. Will try this.

>
>> For ex: to say mrg_rxbuf is off we can add the following line to virtio
>> section of the domain xml file.
>>   <host mrg_rxbuf='off'/>
>>
>> I think libvirt needs to be extended to to support the new 'standby' 
>> attribute
>> via this mechanism.
>> Adding Liane Stump and libvirt to the CC list.
>
> *Laine
>
>>
>> Michael,
>> Can we start with getting this patch into Qemu and an update to 
>> libvirt to
>> support the 'standby' feature so that this feature can be enabled via
>> some scripts/orchestration layer for now.
>>
>> We could improve this solution by enhancing Qemu to do automatic 
>> management of the
>> addition/deletion of the primary device based on feature negotiation 
>> as a later patch.
>>
>
> If that means the libvirt attribute would no longer be needed, I don't
> see the reason to add it to libvirt in the first place.

I think we still need this attribute supported via libvirt so that a user/admin
can enable this feature via domain XML specification.
