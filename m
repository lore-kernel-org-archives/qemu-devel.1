Received: from eggs.gnu.org ([2001:4830:134:3::10]:42204)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcel@redhat.com>) id 1ciiuK-0003ul-Tm
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 09:37:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcel@redhat.com>) id 1ciiuH-0007Sm-Os
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 09:37:40 -0500
Received: from mx1.redhat.com ([209.132.183.28]:53652)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcel@redhat.com>) id 1ciiuH-0007RZ-Fv
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 09:37:37 -0500
References: <1487742565-2513-1-git-send-email-peterx@redhat.com>
	<20170222103047.2c1b63f2@t450s.home>
	<20170223030647.GB4015@pxdev.xzpeter.org>
	<7cd743a2-b4c2-1d96-892e-c3a7db07da16@redhat.com>
	<20170223081616.GI4015@pxdev.xzpeter.org>
	<52e4d43f-c51f-0ac5-7409-f3087f61f44e@redhat.com>
	<20170223083533.17899e2f@t450s.home>
From: Marcel Apfelbaum <marcel@redhat.com>
Message-ID: <ef511d05-b839-7ffc-a17d-1df69187bea1@redhat.com>
Date: Tue, 28 Feb 2017 16:37:32 +0200
MIME-Version: 1.0
In-Reply-To: <20170223083533.17899e2f@t450s.home>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] intel_iommu: make sure its init before PCI
 dev
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alex Williamson <alex.williamson@redhat.com>
Cc: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org, yi.l.liu@intel.com, "\\ Michael S . Tsirkin \\ " <mst@redhat.com>, Jintack Lim <jintack@cs.columbia.edu>, Paolo Bonzini <pbonzini@redhat.com>

On 02/23/2017 05:35 PM, Alex Williamson wrote:
> On Thu, 23 Feb 2017 14:02:07 +0200
> Marcel Apfelbaum <marcel@redhat.com> wrote:
>
>> On 02/23/2017 10:16 AM, Peter Xu wrote:
>>> On Thu, Feb 23, 2017 at 10:10:57AM +0200, Marcel Apfelbaum wrote:
>>>> On 02/23/2017 05:06 AM, Peter Xu wrote:
>>>>> On Wed, Feb 22, 2017 at 10:30:47AM -0700, Alex Williamson wrote:
>>>>>> On Wed, 22 Feb 2017 13:49:25 +0800
>>>>>> Peter Xu <peterx@redhat.com> wrote:
>>>>>>
>>>>>>> Intel vIOMMU devices are created with "-device" parameter, while here
>>>>>>> actually we need to make sure this device will be created before some
>>>>>>> other PCI devices (like vfio-pci devices) so that we know iommu_fn will
>>>>>>> be setup correctly before realizations of those PCI devices.
>>>>>>>
>>>>>>> Here we do explicit check to make sure intel-iommu device will be inited
>>>>>>> before all the rest of the PCI devices. This is done by checking against
>>>>>>> the devices dangled under current root PCIe bus and we should see
>>>>>>> nothing there besides integrated ICH9 ones.
>>>>
>>>> Hi,
>>>>
>>>> Commit b86eacb8 (hw/pci: delay bus_master_enable_region initialization)
>>>> creates the IOMMU memory region at machine_done time so the
>>>> devices creation order wouldn't matter.
>>>>
>>>> I don't think we use the iommu_fn before machine_done.
>>>> What have I missed?
>>>
>>> Hi, Marcel,
>>>
>>> The problem is that vfio-pci will need to fetch the pci address space
>>> during realization (pci_device_iommu_address_space() is called in
>>> vfio_realize()).
>>>
>>> Any thoughts? Thanks,
>>
>> Sure, I'll try to find a solution, but first I need to
>> understand why vfio-pci need to access the pci_device_iommu_address_space
>> so early. Maybe we can delay this also to machine_done stage.
>
> It's the architecture of vfio, the user only gets access to the device
> when the container has iommu protection, therefore vfio needs to look
> at the device address space to determine if it can share a container
> with other devices.  Without an iommu all devices share the system
> address space and use the same container.  With an iommu, each device
> is in a separate address space and each gets its own container.
> Without a container, the user doesn't get access to the device.
> Deferring the address space to machine done would essentially defer the
> entire vfio device initialization or else we'd need to close the
> device and re-open and initialize it through a new container at that
> time.  Thanks,
>

I understand. Maybe we should follow the same "template" as disk/drive, nic/netdev ?
I mean something like -device iommu,id=i1, -device vfio-pci,iommu=e1 .
I saw that you can mix the order in command line and still works.
I don't really know how they do it...

Thanks,
Marcel


> Alex
>
