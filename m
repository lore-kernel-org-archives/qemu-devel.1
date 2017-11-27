Received: from eggs.gnu.org ([2001:4830:134:3::10]:59815)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jianfeng.tan@intel.com>) id 1eJMO4-0007kA-U3
	for qemu-devel@nongnu.org; Mon, 27 Nov 2017 11:36:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jianfeng.tan@intel.com>) id 1eJMNy-0002wt-QA
	for qemu-devel@nongnu.org; Mon, 27 Nov 2017 11:36:04 -0500
Received: from mga14.intel.com ([192.55.52.115]:61400)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jianfeng.tan@intel.com>)
	id 1eJMNy-0002uy-F5
	for qemu-devel@nongnu.org; Mon, 27 Nov 2017 11:35:58 -0500
References: <20171127142515.GA450@yliu-dev>
	<f7tbmjnpulq.fsf@dhcp-25-97.bos.redhat.com>
From: "Tan, Jianfeng" <jianfeng.tan@intel.com>
Message-ID: <d2867f99-2cca-ef43-3797-75aa11281669@intel.com>
Date: Tue, 28 Nov 2017 00:35:52 +0800
MIME-Version: 1.0
In-Reply-To: <f7tbmjnpulq.fsf@dhcp-25-97.bos.redhat.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [dpdk-dev] [ovs-dev] [PATCH RFC] netdev-dpdk: Fix
 device obtain mac address when received first packet in vhost type
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Aaron Conole <aconole@redhat.com>, Yuanhan Liu <yliu@fridaylinux.org>
Cc: Chen Hailin <chenhl@arraynetworks.com.cn>, "ovs-dev@openvswitch.org" <ovs-dev@openvswitch.org>, Maxime Coquelin <maxime.coquelin@redhat.com>, qemu-devel <qemu-devel@nongnu.org>, dev <dev@dpdk.org>



On 11/28/2017 12:14 AM, Aaron Conole wrote:
> Yuanhan Liu <yliu@fridaylinux.org> writes:
>
>> On Fri, Nov 24, 2017 at 05:59:09PM +0800, Chen Hailin wrote:
>>> Hi Aaron Conole && Jianfeng,
>>>
>>> The stp could not work in ovs-dpdk vhostuser.
>>> Because the attached vhost device doesn't have MAC address.
>>>
>>> Now we have two ways to solve this problem.
>>> 1. The vhost learns MAC address from packet like as my first patch.
>> I do agree with Aaron this is not the right way.
>>
>>> 2. The virtio notifies MAC address actively to vhost user .
>> Unfortunately, AFAIK, there is no way to achieve that so far. we could
>> either let virtio/QEMU to expose the CQ to vhost or add a new VHOST_USER
>> message to carry the mac address. While vhost-user is a generic interface
>> adding a virtio-net specific message also doesn't seem quite right.
>> Exposing CQ is probably the best we can do.
>>
>> Anyway, both need spec change.
> There are other possible ways.  libvirt knows about the mac address from
> the domain xml file.  Perhaps it's possible to set the mac column in the
> database to the correct value when the port is being created in ovs?
> This would be an action taken by the orchestration tool.

In OVS db, we can only see vhost port, but not virtio port. That is to 
say, we could use different mac for vhost port from virtio port, 
especially when it works as a vrouter instead of vswitch.

>
> Additionally, there's a mechanism in virtio-net to set the mac address
> from the host to the guest.  Is it possible to expose that functionality
> through vhost-user?

We can assign mac addr when starting QEMU. After that, I suppose we 
cannot set mac addr any more, let alone setting it from vhost-user side 
(vhost-user protocol does not support it yet).

Thanks,
Jianfeng

>
> Then when the orchestration tool sets the mac, it can be propagated, and
> mac_in_use can reflect the appropriate value.  I think that's a workable
> solution, but I might have missed something.
>
>> 	--yliu
>>> In my opinions,  if we treat it as a device,  we should allocate
>>> MAC address for the device when the VM started.
>>>
>>> Which one do you think better?
>>>
>>>
>>>
>>> Best Regards,
>>> Chen Hailin
>>> chenhl@arraynetworks.com.cn
>>>   
>>> From: Aaron Conole
>>> Date: 2017-11-18 10:00
>>> To: Hailin Chen
>>> CC: ovs-dev@openvswitch.org; Maxime Coquelin; cloud@arraynetworks.com.cn
>>> Subject: Re: [ovs-dev] [PATCH RFC] netdev-dpdk: Fix device obtain
>>> mac address when received first packet in vhost type
>>> Hi Hailin,
>>>   
>>> Hailin Chen <chenhl@arraynetworks.com.cn> writes:
>>>   
>>>> The stp could not work on netdev-dpdk if network is loop.
>>>> Because the stp protocol negotiates designate port by sending
>>>> BPDU packets which contains MAC address.
>>>> However the device doesn't have MAC address in vhostuser type.
>>>> Thus, function send_bpdu_cb would not send BPDU packets.
>>>>
>>>> This patch will set the MAC for device when received first packet.
>>>>
>>>> Signed-off-by: Hailin Chen <chenhl@arraynetworks.com.cn>
>>>> ---
>>>   
>>> Thanks for the patch.
>>>   
>>> In general, I don't think this is the right approach to deal with this
>>> type of issue.  I believe the problem statement is that OvS bridge is
>>> unaware of the guest MAC address - did I get it right?  In that case, I
>>> would think that a better way to solve this would be to have virtio tell
>>> the mac address of the guest.  I don't recall right now if that's
>>> allowed in the virtio spec, but I do remember some kind of negotiation
>>> features.
>>>   
>>> I've CC'd Maxime, who is one of the maintainers of the virtio code from
>>> DPDK side.  Perhaps there is an alternate way to solve this.
>>> _______________________________________________
>>> dev mailing list
>>> dev@openvswitch.org
>>> https://mail.openvswitch.org/mailman/listinfo/ovs-dev
