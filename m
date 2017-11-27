Received: from eggs.gnu.org ([2001:4830:134:3::10]:49678)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aconole@redhat.com>) id 1eJMn3-0002m3-PY
	for qemu-devel@nongnu.org; Mon, 27 Nov 2017 12:01:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aconole@redhat.com>) id 1eJMmy-0004Sp-0p
	for qemu-devel@nongnu.org; Mon, 27 Nov 2017 12:01:53 -0500
Received: from mx1.redhat.com ([209.132.183.28]:41576)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aconole@redhat.com>) id 1eJMmx-0004Qs-OD
	for qemu-devel@nongnu.org; Mon, 27 Nov 2017 12:01:47 -0500
From: Aaron Conole <aconole@redhat.com>
References: <20171127142515.GA450@yliu-dev>
	<411329b7-5164-c24e-2e5e-8cf25079c4b9@intel.com>
Date: Mon, 27 Nov 2017 12:01:41 -0500
In-Reply-To: <411329b7-5164-c24e-2e5e-8cf25079c4b9@intel.com> (Jianfeng Tan's
	message of "Mon, 27 Nov 2017 23:34:10 +0800")
Message-ID: <f7tfu8zodu2.fsf@dhcp-25-97.bos.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
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
To: "Tan, Jianfeng" <jianfeng.tan@intel.com>
Cc: Yuanhan Liu <yliu@fridaylinux.org>, Chen Hailin <chenhl@arraynetworks.com.cn>, "ovs-dev@openvswitch.org" <ovs-dev@openvswitch.org>, Maxime Coquelin <maxime.coquelin@redhat.com>, cloud <cloud@arraynetworks.com.cn>, qemu-devel <qemu-devel@nongnu.org>, dev <dev@dpdk.org>

"Tan, Jianfeng" <jianfeng.tan@intel.com> writes:

> On 11/27/2017 10:27 PM, Yuanhan Liu wrote:
>> On Fri, Nov 24, 2017 at 05:59:09PM +0800, Chen Hailin wrote:
>>> Hi Aaron Conole && Jianfeng,
>>>
>>> The stp could not work in ovs-dpdk vhostuser.
>>> Because the attached vhost device doesn't have MAC address.
>>>
>>> Now we have two ways to solve this problem.
>>> 1. The vhost learns MAC address from packet like as my first patch.
>> I do agree with Aaron this is not the right way.
>
> I do think it should be the vswitch's responsibility to learn mac of
> vhost port.
>
> Except that it's the only feasible way without modifying the spec
> (yuanhan already makes it very clear below), we can treat the vswitch
> as a phsical switch, VM as a physical server, virtio/vhost port as a
> back-to-back connected NICs, the only way of the physical switch to
> know the mac of the NIC on the other side is ARP learning.
>
> Might I ask why you don't think it's a right way?

As a quick example, I think a malicious guest in a multi-tenant
environment could send traffic out to manipulate this feature into
learning an incorrect mac address.

To get this right requires doing deep packet inspection, and making sure
to only learn based on certain l2 traffic.

> Thanks,
> Jianfeng
>
>>
>>> 2. The virtio notifies MAC address actively to vhost user .
>> Unfortunately, AFAIK, there is no way to achieve that so far. we could
>> either let virtio/QEMU to expose the CQ to vhost or add a new VHOST_USER
>> message to carry the mac address. While vhost-user is a generic interface
>> adding a virtio-net specific message also doesn't seem quite right.
>> Exposing CQ is probably the best we can do.
>>
>> Anyway, both need spec change.
>>
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
>>>   From: Aaron Conole
>>> Date: 2017-11-18 10:00
>>> To: Hailin Chen
>>> CC: ovs-dev@openvswitch.org; Maxime Coquelin; cloud@arraynetworks.com.cn
>>> Subject: Re: [ovs-dev] [PATCH RFC] netdev-dpdk: Fix device obtain
>>> mac address when received first packet in vhost type
>>> Hi Hailin,
>>>   Hailin Chen <chenhl@arraynetworks.com.cn> writes:
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
>>>   Thanks for the patch.
>>>   In general, I don't think this is the right approach to deal with
>>> this
>>> type of issue.  I believe the problem statement is that OvS bridge is
>>> unaware of the guest MAC address - did I get it right?  In that case, I
>>> would think that a better way to solve this would be to have virtio tell
>>> the mac address of the guest.  I don't recall right now if that's
>>> allowed in the virtio spec, but I do remember some kind of negotiation
>>> features.
>>>   I've CC'd Maxime, who is one of the maintainers of the virtio
>>> code from
>>> DPDK side.  Perhaps there is an alternate way to solve this.
>>> _______________________________________________
>>> dev mailing list
>>> dev@openvswitch.org
>>> https://mail.openvswitch.org/mailman/listinfo/ovs-dev
