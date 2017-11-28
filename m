Received: from eggs.gnu.org ([2001:4830:134:3::10]:41794)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jianfeng.tan@intel.com>) id 1eJiPW-00074D-P2
	for qemu-devel@nongnu.org; Tue, 28 Nov 2017 11:07:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jianfeng.tan@intel.com>) id 1eJiPR-0007kU-0y
	for qemu-devel@nongnu.org; Tue, 28 Nov 2017 11:07:02 -0500
Received: from mga11.intel.com ([192.55.52.93]:9644)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jianfeng.tan@intel.com>)
	id 1eJiPQ-0007i4-NC
	for qemu-devel@nongnu.org; Tue, 28 Nov 2017 11:06:56 -0500
References: <20171127142515.GA450@yliu-dev>
	<411329b7-5164-c24e-2e5e-8cf25079c4b9@intel.com>
	<f7tfu8zodu2.fsf@dhcp-25-97.bos.redhat.com>
From: "Tan, Jianfeng" <jianfeng.tan@intel.com>
Message-ID: <c424711c-6214-18cf-a494-17200abda76b@intel.com>
Date: Wed, 29 Nov 2017 00:06:50 +0800
MIME-Version: 1.0
In-Reply-To: <f7tfu8zodu2.fsf@dhcp-25-97.bos.redhat.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 8bit
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
To: Aaron Conole <aconole@redhat.com>
Cc: Yuanhan Liu <yliu@fridaylinux.org>, Chen Hailin <chenhl@arraynetworks.com.cn>, "ovs-dev@openvswitch.org" <ovs-dev@openvswitch.org>, Maxime Coquelin <maxime.coquelin@redhat.com>, cloud <cloud@arraynetworks.com.cn>, qemu-devel <qemu-devel@nongnu.org>, dev <dev@dpdk.org>



On 11/28/2017 1:01 AM, Aaron Conole wrote:
> "Tan, Jianfeng" <jianfeng.tan@intel.com> writes:
>
>> On 11/27/2017 10:27 PM, Yuanhan Liu wrote:
>>> On Fri, Nov 24, 2017 at 05:59:09PM +0800, Chen Hailin wrote:
>>>> Hi Aaron Conole && Jianfeng,
>>>>
>>>> The stp could not work in ovs-dpdk vhostuser.
>>>> Because the attached vhost device doesn't have MAC address.
>>>>
>>>> Now we have two ways to solve this problem.
>>>> 1. The vhost learns MAC address from packet like as my first patch.
>>> I do agree with Aaron this is not the right way.
>> I do think it should be the vswitch's responsibility to learn mac of
>> vhost port.
>>
>> Except that it's the only feasible way without modifying the spec
>> (yuanhan already makes it very clear below), we can treat the vswitch
>> as a phsical switch, VM as a physical server, virtio/vhost port as a
>> back-to-back connected NICs, the only way of the physical switch to
>> know the mac of the NIC on the other side is ARP learning.
>>
>> Might I ask why you don't think it's a right way?
> As a quick example, I think a malicious guest in a multi-tenant
> environment could send traffic out to manipulate this feature into
> learning an incorrect mac address.

Instead, I think it's not right to stop such mac spoofing behavior 
(suppose someone wants to have such an experiment in an overlay 
networking). And it actually only affects one “LAN", instead of all "LANs".

And it's usually not the switch's responsibility to detect mac spoofing 
behavior IMHO.

> To get this right requires doing deep packet inspection, and making sure
> to only learn based on certain l2 traffic.
>

Yes, should learn based on ARP packets. Your concern is the performance? 
I suppose there is not to many such packets.

Thanks,
Jianfeng
