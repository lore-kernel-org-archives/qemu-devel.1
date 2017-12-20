Received: from eggs.gnu.org ([2001:4830:134:3::10]:42578)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcel@redhat.com>) id 1eRfyD-000660-By
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 10:07:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcel@redhat.com>) id 1eRfy7-0000Wm-3N
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 10:07:45 -0500
Received: from mx1.redhat.com ([209.132.183.28]:49728)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcel@redhat.com>) id 1eRfy6-0000Vl-Rt
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 10:07:39 -0500
References: <20171217125457.3429-1-marcel@redhat.com>
	<20171219194951-mutt-send-email-mst@kernel.org>
From: Marcel Apfelbaum <marcel@redhat.com>
Message-ID: <77710384-30d0-cb76-9dbc-6195b831f050@redhat.com>
Date: Wed, 20 Dec 2017 17:07:38 +0200
MIME-Version: 1.0
In-Reply-To: <20171219194951-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH V2 0/5] hw/pvrdma: PVRDMA device
 implementation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org, ehabkost@redhat.com, imammedo@redhat.com, yuval.shaia@oracle.com, pbonzini@redhat.com

On 19/12/2017 20:05, Michael S. Tsirkin wrote:
> On Sun, Dec 17, 2017 at 02:54:52PM +0200, Marcel Apfelbaum wrote:
>> RFC -> V2:
>>   - Full implementation of the pvrdma device
>>   - Backend is an ibdevice interface, no need for the KDBR module
>>
>> General description
>> ===================
>> PVRDMA is the QEMU implementation of VMware's paravirtualized RDMA device.
>> It works with its Linux Kernel driver AS IS, no need for any special guest
>> modifications.
>>
>> While it complies with the VMware device, it can also communicate with bare
>> metal RDMA-enabled machines and does not require an RDMA HCA in the host, it
>> can work with Soft-RoCE (rxe).
>>
>> It does not require the whole guest RAM to be pinned
> 

Hi Michael,

> What happens if guest attempts to register all its memory?
> 

Then we loose, is not different from bare metal, reg_mr will pin all the RAM.
However this is only one scenario, and hopefully not much used
for RoCE. (I know IPoIB does that, but it doesn't make sense to use it with RoCE).

>> allowing memory
>> over-commit
>> and, even if not implemented yet, migration support will be
>> possible with some HW assistance.
> 
> What does "HW assistance" mean here?

Several things:
1. We need to be able to pass resource numbers when we create
them on the destination machine.
2. We also need a way to stall prev connections while starting the new ones.
3. Last, we need the HW to pass resources states.

> Can it work with any existing hardware?
> 

Sadly no, however we talked with Mellanox at the last year
Plumbers Conference and all the above are on their plans.
We hope this submission will help, since now we will have
a fast way to test and use it.

For Soft-RoCE backend is doable, but is best to wait first to
see how HCAs are going to expose the changes.

>>
>>   Design
>>   ======
>>   - Follows the behavior of VMware's pvrdma device, however is not tightly
>>     coupled with it
> 
> Everything seems to be in pvrdma. Since it's not coupled, could you
> split code to pvrdma specific and generic parts?
> 
>> and most of the code can be reused if we decide to
>>     continue to a Virtio based RDMA device.
> 
> I suspect that without virtio we won't be able to do any future
> extensions.
> 

While I do agree is harder to work with a 3rd party spec, their
Linux driver is open source and we may be able to do sane
modifications.

>>   - It exposes 3 BARs:
>>      BAR 0 - MSIX, utilize 3 vectors for command ring, async events and
>>              completions
>>      BAR 1 - Configuration of registers

[...]

>> The pvrdma backend is an ibdevice interface that can be exposed
>> either by a Soft-RoCE(rxe) device on machines with no RDMA device,
>> or an HCA SRIOV function(VF/PF).
>> Note that ibdevice interfaces can't be shared between pvrdma devices,
>> each one requiring a separate instance (rxe or SRIOV VF).
> 
> So what's the advantage of this over pass-through then?
> 

1. We can work also with the same ibdevice for multiple pvrdma
devices using multiple GIDs; it works (tested).
The problem begins when we think about migration, the way
HCAs work today is one resource namespace per ibdevice,
not per GID. I emphasize that this can be changed,  however
we don't have a timeline for it.

2. We do have advantages:
- Guest agnostic device (we can change host HCA)
- Memory over commit (unless the guest registers all the memory)
- Future migration support
- A friendly migration of RDMA VMWare guests to QEMU.

3. In case when live migration is not a must we can
    use multiple GIDs of the same port, so we do not
    depend on SRIOV.

4. We support Soft RoCE backend, people can test their
    software on guest without RDMA hw.


Thanks,
Marcel

> 
>>
>> Tests and performance
>> =====================
>> Tested with SoftRoCE backend (rxe)/Mellanox ConnectX3,
>> and Mellanox ConnectX4 HCAs with:
>>    - VMs in the same host
>>    - VMs in different hosts
>>    - VMs to bare metal.
>>
>> The best performance achieved with ConnectX HCAs and buffer size
>> bigger than 1MB which was the line rate ~ 50Gb/s.
>> The conclusion is that using the PVRDMA device there are no
>> actual performance penalties compared to bare metal for big enough
>> buffers (which is quite common when using RDMA), while allowing
>> memory overcommit.
>>
>> Marcel Apfelbaum (3):
>>    mem: add share parameter to memory-backend-ram
>>    docs: add pvrdma device documentation.
>>    MAINTAINERS: add entry for hw/net/pvrdma
>>
>> Yuval Shaia (2):
>>    pci/shpc: Move function to generic header file
>>    pvrdma: initial implementation
>>

[...]
