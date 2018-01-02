Received: from eggs.gnu.org ([2001:4830:134:3::10]:39250)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1eWFdp-0006z6-BM
	for qemu-devel@nongnu.org; Tue, 02 Jan 2018 01:01:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1eWFdl-0001ok-IO
	for qemu-devel@nongnu.org; Tue, 02 Jan 2018 01:01:37 -0500
Received: from mail-io0-x22c.google.com ([2607:f8b0:4001:c06::22c]:37553)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <aik@ozlabs.ru>) id 1eWFdl-0001oJ-Cg
	for qemu-devel@nongnu.org; Tue, 02 Jan 2018 01:01:33 -0500
Received: by mail-io0-x22c.google.com with SMTP id n14so24692986iob.4
	for <qemu-devel@nongnu.org>; Mon, 01 Jan 2018 22:01:33 -0800 (PST)
References: <20171222064151.29266-1-tiwei.bie@intel.com>
	<367b37c2-a315-5e61-8ac0-69b92c01b9cf@ozlabs.ru>
	<D0158A423229094DA7ABF71CF2FA0DA34E8420DE@SHSMSX104.ccr.corp.intel.com>
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Message-ID: <3c88cc5e-b864-019d-1744-6f400c7ecfeb@ozlabs.ru>
Date: Tue, 2 Jan 2018 17:01:25 +1100
MIME-Version: 1.0
In-Reply-To: <D0158A423229094DA7ABF71CF2FA0DA34E8420DE@SHSMSX104.ccr.corp.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-AU
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC 0/3] Extend vhost-user to support VFIO based
 accelerators
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Liang, Cunming" <cunming.liang@intel.com>, "Bie, Tiwei" <tiwei.bie@intel.com>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "mst@redhat.com" <mst@redhat.com>, "alex.williamson@redhat.com" <alex.williamson@redhat.com>, "pbonzini@redhat.com" <pbonzini@redhat.com>, "stefanha@redhat.com" <stefanha@redhat.com>
Cc: "Tan, Jianfeng" <jianfeng.tan@intel.com>, "Wang, Xiao W" <xiao.w.wang@intel.com>, "Wang, Zhihong" <zhihong.wang@intel.com>, "Daly, Dan" <dan.daly@intel.com>

On 02/01/18 16:49, Liang, Cunming wrote:
> 
> 
>> -----Original Message-----
>> From: Alexey Kardashevskiy [mailto:aik@ozlabs.ru]
>> Sent: Tuesday, January 2, 2018 10:42 AM
>> To: Bie, Tiwei <tiwei.bie@intel.com>; virtio-dev@lists.oasis-open.org; qemu-
>> devel@nongnu.org; mst@redhat.com; alex.williamson@redhat.com;
>> pbonzini@redhat.com; stefanha@redhat.com
>> Cc: Tan, Jianfeng <jianfeng.tan@intel.com>; Liang, Cunming
>> <cunming.liang@intel.com>; Wang, Xiao W <xiao.w.wang@intel.com>; Wang,
>> Zhihong <zhihong.wang@intel.com>; Daly, Dan <dan.daly@intel.com>
>> Subject: Re: [Qemu-devel] [RFC 0/3] Extend vhost-user to support VFIO based
>> accelerators
>>
>> On 22/12/17 17:41, Tiwei Bie wrote:
>>> This RFC patch set does some small extensions to vhost-user protocol
>>> to support VFIO based accelerators, and makes it possible to get the
>>> similar performance of VFIO passthru while keeping the virtio device
>>> emulation in QEMU.
>>>
>>> When we have virtio ring compatible devices, it's possible to setup
>>> the device (DMA mapping, PCI config, etc) based on the existing info
>>> (memory-table, features, vring info, etc) which is available on the
>>> vhost-backend (e.g. DPDK vhost library). Then, we will be able to use
>>> such devices to accelerate the emulated device for the VM. And we call
>>> it vDPA: vhost DataPath Acceleration. The key difference between VFIO
>>> passthru and vDPA is that, in vDPA only the data path (e.g. ring,
>>> notify and queue interrupt) is pass-throughed, the device control path
>>> (e.g. PCI configuration space and MMIO regions) is still defined and
>>> emulated by QEMU.
>>>
>>> The benefits of keeping virtio device emulation in QEMU compared with
>>> virtio device VFIO passthru include (but not limit to):
>>>
>>> - consistent device interface from guest OS;
>>> - max flexibility on control path and hardware design;
>>> - leveraging the existing virtio live-migration framework;
>>>
>>> But the critical issue in vDPA is that the data path performance is
>>> relatively low and some host threads are needed for the data path,
>>> because some necessary mechanisms are missing to support:
>>>
>>> 1) guest driver notifies the device directly;
>>> 2) device interrupts the guest directly;
>>>
>>> So this patch set does some small extensions to vhost-user protocol to
>>> make both of them possible. It leverages the same mechanisms (e.g.
>>> EPT and Posted-Interrupt on Intel platform) as the VFIO passthru to
>>> achieve the data path pass through.
>>>
>>> A new protocol feature bit is added to negotiate the accelerator
>>> feature support. Two new slave message types are added to enable the
>>> notify and interrupt passthru for each queue. From the view of
>>> vhost-user protocol design, it's very flexible. The passthru can be
>>> enabled/disabled for each queue individually, and it's possible to
>>> accelerate each queue by different devices. More design and
>>> implementation details can be found from the last patch.
>>>
>>> There are some rough edges in this patch set (so this is a RFC patch
>>> set for now), but it's never too early to hear the thoughts from the
>>> community! So any comments and suggestions would be really appreciated!
>>
>> I am missing a lot of context here. Out of curiosity - how is this all supposed to
>> work? QEMU command line example would be useful, what will the guest see? A
>> virtio device (i.e. Redhat vendor ID) or an actual PCI device (since VFIO is
>> mentioned)? Thanks.
> 
> It's a normal virtio PCIe devices in the guest. Extensions on the host are transparent to the guest.
> 
> In terms of the usage, there's a sample may help.
> http://dpdk.org/ml/archives/dev/2017-December/085044.html
> The sample takes virtio-net device in VM as data path accelerator of virtio-net in nested VM.


Aaah, this is for nested VMs, the original description was not clear about
this. I get it now, thanks.


> When taking physical device on bare metal, it accelerates virtio-net in VM equivalently.
> There's no additional params of QEMU command line needed for vhost-user.
> 
> One more context, including vDPA enabling in DPDK vhost-user library.
> http://dpdk.org/ml/archives/dev/2017-December/084792.html



-- 
Alexey
