Received: from eggs.gnu.org ([2001:4830:134:3::10]:53190)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1eYUKR-0000TA-VX
	for qemu-devel@nongnu.org; Mon, 08 Jan 2018 05:06:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1eYUKO-0001CN-Oo
	for qemu-devel@nongnu.org; Mon, 08 Jan 2018 05:06:51 -0500
Received: from mx1.redhat.com ([209.132.183.28]:36848)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1eYUKO-0001An-EQ
	for qemu-devel@nongnu.org; Mon, 08 Jan 2018 05:06:48 -0500
References: <20171222064151.29266-1-tiwei.bie@intel.com>
	<fcf3858e-6643-350c-37b9-71698f1d26a5@redhat.com>
	<20180104061853.jkdzbueashv2klka@debian-xvivbkq.sh.intel.com>
	<aca10596-f8d4-417e-26b6-ed09ef766552@redhat.com>
	<D0158A423229094DA7ABF71CF2FA0DA34E845FAD@SHSMSX104.ccr.corp.intel.com>
	<a1319915-6492-af8d-a35d-5aedad61eb76@redhat.com>
	<D0158A423229094DA7ABF71CF2FA0DA34E84629B@SHSMSX104.ccr.corp.intel.com>
	<238ebde1-0fca-9472-ae4e-1d5e67ff6606@redhat.com>
	<D0158A423229094DA7ABF71CF2FA0DA34E8479EC@SHSMSX104.ccr.corp.intel.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <06f74212-4148-0630-66ea-1e2f933c63fb@redhat.com>
Date: Mon, 8 Jan 2018 18:06:10 +0800
MIME-Version: 1.0
In-Reply-To: <D0158A423229094DA7ABF71CF2FA0DA34E8479EC@SHSMSX104.ccr.corp.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Subject: Re: [Qemu-devel] [virtio-dev] Re: [virtio-dev] [RFC 0/3] Extend
 vhost-user to support VFIO based accelerators
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Liang, Cunming" <cunming.liang@intel.com>, "Bie, Tiwei" <tiwei.bie@intel.com>
Cc: "Tan, Jianfeng" <jianfeng.tan@intel.com>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, "pbonzini@redhat.com" <pbonzini@redhat.com>, "mst@redhat.com" <mst@redhat.com>, "Daly, Dan" <dan.daly@intel.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "alex.williamson@redhat.com" <alex.williamson@redhat.com>, "Wang, Xiao W" <xiao.w.wang@intel.com>, "stefanha@redhat.com" <stefanha@redhat.com>, "Wang, Zhihong" <zhihong.wang@intel.com>, Maxime Coquelin <maxime.coquelin@redhat.com>


[...]

>> chip EMC for early classification. It gives a fast path for those throughput
>> sensitive(SLA) VNF to bypass the further table lookup. It co-exists other VNF
>> whose SLA level is best effort but requires more functions(e.g. stateful
>> conntrack, security check, even higher layer WAF support) support, DPDK
>> based datapath still boost the throughput there. It's not used to be a single
>> choice of dedicated or shared datapath, usually they're co-exist.
>>
>> So if I understand this correctly, the "vswtich" here is a hardware function
>> (something like smart NICs or OVS offloaded). So the question still, is vhost-
>> user a must in this case?
> "vswitch" point to SW vswitch(e.g. OVS-DPDK). Accelerators stands for different offloading IPs on the device(e.g. smart NIC) which can be used from a userland driver.
> EMC IP used to offload OVS fastpath, so as move traffic to VM directly. Either SRIOV device assignment or vDPA helps to build datapath pass-thru context which represented by a virtual interface on management perspective. For entire "vswitch", there still co-exist none pass-thru interface(SW backend) which uses vhost-user for virtual interface.
> Both of them shall be able to replace each other.

Thanks, I kind of get the picture here.

A question is about the software backend, e.g what's the software 
counterpart for SRIOV or vDPA? E.g is there a VF or vDPA pmd connected 
to OVS-dpdk and it can switch to offload if required?

>
> There's no other user space choice yet recently for network except vhost-user. The patch of vhost-user extension has lower impact for qemu.
> If you read this patch, it's really about to reduce the doorbell and interrupt overhead.

For this patch, you need decouple pci specific stuffs out of vhost-user 
which is transport independent (at least now).

> Basic vDPA works even without any qemu change. As vhost-user is well-recognized as the vhost interface for userland backend, it's reasonable to well-support the usage of userland backend w/ I/O accelerator.

Right, so you can do all offloads in qemu, vhost-user could be still 
there. And qemu can switch between the two like a transparent bond or team?

>
> Before moving forward, it's necessary to get some alignment on two basic things.
> - Do you agree that providing userland backend via vhost-user is the right way to do with vswitch workload.
>     Otherwise, we probably shall go back to revisit vhost-user itself rather than talking anything new happening on vhost-user.

I agree.

> - Do you agree vhost-user is a right way for qemu to allow multi-process?
>     Please refer to https://www.linux-kvm.org/images/f/fc/KVM_FORUM_multi-process.pdf

This is questionable. From both performance and security points. We had 
example of performance (vIOMMU). For security, e.g in this patch, qemu 
can setup memory region based on the request from vhost-user slave, does 
this increase the attack surface?

I think you missed my point some how, as replied in previous thread, I 
did't object what you propose here. I just want to understand the reason 
you choose vhost-user. And in the cover letter, vswitch case is not 
mentioned at all, instead and it compares vDPA with VFIO. This makes 
reader easily to think that qemu will monopoly the device, so it's 
rather nature to ask why not do it inside qemu.

>
>>>>>     On workloads point of view, it's not excited to be part of qemu process.
>>>> Don't see why, qemu have dataplane for virtio-blk/scsi.
>>> Qemu has vhost-user for scsi too. I'm not saying which one is bad, just
>> point out sometime it's very workloads driven. Network is different with
>> blk/scsi/crypto.
>>
>> What's the main difference from your point of view which makes
>> vhost-user a must in this case?
> Network devices, a NIC or a Smart NIC usually has vendor specific driver. DPDK takes devices by its user space drivers to run OVS. Virtual interface is all vhost-user based talking with qemu. For some virtual interface, it now tries to bypass the traffic. It's looking forward a consistent vhost-user interface there.

So the point is probably you can keep vhost-user for sw path while 
implementing offloaded path in qemu completely?

>   Linking OVS-DPDK with qemu, TBH, it's far away from today's usage.
>
>>>>> That comes up with the idea of vhost-user extension. Userland
>> workloads
>>>> decides to enable accelerators or not, qemu provides the common control
>>>> plane infrastructure.
>>>>
>>>> It brings extra complexity: endless new types of messages and a huge
>> brunch
>>>> of bugs. And what's more important, the split model tends to be less
>> efficient
>>>> in some cases, e.g guest IOMMU integration. I'm pretty sure we will meet
>>>> more in the future.
>>> vIOMMU relevant message has been supported by vhost protocol. It's
>> independent effort there.
>>
>> The point is vIOMMU integration is very inefficient in vhost-user for
>> some cases. If you have lots of dynamic mappings, it can have only
>> 5%-10% performance compared to vIOMMU disabled. A huge amount of
>> translation request will be generated in this case. The main issue here
>> is you can not offload datapath completely to vhost-user backends
>> completely, IOMMU translations were still done in qemu. This is one of
>> the defect of vhost-user when datapath need to access the device state.
> It's vIOMMU's challenge of dynamic mapping, besides vhost-user, kernel vhost shall face the same situation. Static mapping w/ DPDK looks much better. It's not fair to blame vhost-user by vIOMMU overhead.

Yes, that's why I want a vhost dataplane inside qemu. (btw vhost-user 
should be even worse consider syscall is less expensive than IPC).

>
>>> I don't see this patch introduce endless new types.
>> Not this patch but we can imagine vhost-user protocol will become
>> complex in the future.
>>
>>> My taking of your fundamental concern is about continues adding new
>> features on vhost-user.
>>> Feel free to correct me if I misunderstood your point.
>> Unfortunately not, endless itself is not a problem but we'd better only
>> try to extend it only when it was really needed. The main questions are:
>>
>> 1) whether or not we need to split things like what you suggested here?
>> 2) if needed, is vhost-user the best method?
> Sounds good. BTW, this patch(vhost-user extention) is a performance improvement patch for DPDK vDPA usage(Refer DPDK patches). Another RFC patch stay tuned for kernel space usage which will propose a qemu native vhost adaptor for in-kernel mediated device driver.

Any pointer to this patch?

[...]

>> Why not? We've already had userspace NVME driver.
> There's huge amount of vendor specific driver for network. NVMe is much generalized than NIC.
> The idea of linking an external dataplane sounds interesting, but it's not used in real world. Looking forward the progress.
>
>>>    that's end up with another vhost-vfio in my slides.
>> I don't get why we can't implement it purely through a userspace driver
>> inside qemu.
> TBH, we think about this before. There're a few reasons stopping us.
> - qemu hasn't an abstraction layout of network device(HW NIC) for userspace drivers

Well, you can still use vhost (but not vhost-user).

> - qemu launch process, linking dpdk w/ qemu is not problem. Gap is on ovs integration, effort/impact is not small

We can keep vhost-user datapath.

> - for qemu native virtio SW backend, it lacks of efficient ways to talk with external process. The change efforts/impact is not small.

By keeping vhost-user datapath there's no such worries. Btw, we will 
probably need a channel between qemu and ovs directly which can 
negotiate more offloads.

> - qemu native userspace driver only used for qemu, userspace driver in DPDK can be used for others
>


Thanks
