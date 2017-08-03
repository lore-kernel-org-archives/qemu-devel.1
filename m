Received: from eggs.gnu.org ([2001:4830:134:3::10]:51902)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Tomasz.Nowicki@cavium.com>) id 1ddD6U-0004Ya-53
	for qemu-devel@nongnu.org; Thu, 03 Aug 2017 06:11:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <Tomasz.Nowicki@cavium.com>) id 1ddD6T-0000nx-2q
	for qemu-devel@nongnu.org; Thu, 03 Aug 2017 06:11:42 -0400
References: <1499633493-19865-1-git-send-email-eric.auger@redhat.com>
	<a8fd7038-a840-8667-0db2-5765624903d3@caviumnetworks.com>
	<50d1685e-bfa6-02ac-2650-37637745431a@redhat.com>
From: Tomasz Nowicki <tnowicki@caviumnetworks.com>
Message-ID: <35467208-4e8f-b944-c247-c049c2301878@caviumnetworks.com>
Date: Thu, 3 Aug 2017 12:11:12 +0200
MIME-Version: 1.0
In-Reply-To: <50d1685e-bfa6-02ac-2650-37637745431a@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC v5 0/8] ARM SMMUv3 Emulation Support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Auger Eric <eric.auger@redhat.com>, eric.auger.pro@gmail.com, peter.maydell@linaro.org, qemu-arm@nongnu.org, qemu-devel@nongnu.org, alex.williamson@redhat.com, prem.mallappa@gmail.com
Cc: drjones@redhat.com, christoffer.dall@linaro.org, Radha.Chintakuntla@cavium.com, Sunil.Goutham@cavium.com, mohun106@gmail.com, tcain@qti.qualcomm.com, bharat.bhushan@nxp.com, mst@redhat.com, will.deacon@arm.com, jean-philippe.brucker@arm.com, robin.murphy@arm.com, peterx@redhat.com, edgar.iglesias@gmail.com, "Nair, Jayachandran" <Jayachandran.Nair@cavium.com>

Hi Eric,

On 01.08.2017 15:07, Auger Eric wrote:
> Hi Tomasz,
> On 01/08/2017 13:01, Tomasz Nowicki wrote:
>> Hi Eric,
>>
>> Just letting you know that I am facing another issue with the following
>> setup:
>> 1. host (4.12 kernel & 64K page) and VM (4.12 kernel & 64K page)
>> 2. QEMU + -netdev type=tap,ifname=tap,id=net0 -device
>> virtio-net-pci,netdev=net0,iommu_platform,disable-modern=off,disable-legacy=on
>>
>> 2. On VM, I allocate some huge pages and run DPDK testpmd app:
>> # echo 4 > /sys/kernel/mm/hugepages/hugepages-524288kB/nr_hugepages
>> # ./dpdk/usertools/dpdk-devbind.py -b vfio-pci  0000:00:02.0
>> # ./dpdk/build/app/testpmd -l 0-13 -n 4 -w 0000:00:02.0 --
>> --disable-hw-vlan-filter --disable-rss -i
>> EAL: Detected 14 lcore(s)
>> EAL: Probing VFIO support...
>> EAL: VFIO support initialized
>> EAL: PCI device 0000:00:02.0 on NUMA socket -1
>> EAL:   probe driver: 1af4:1041 net_virtio
>> EAL:   using IOMMU type 1 (Type 1)
>> EAL: iommu_map_dma vaddr ffff20000000 size 80000000 iova 120000000
>> EAL: Can't write to PCI bar (0) : offset (12)
>> EAL: Can't read from PCI bar (0) : offset (12)
>> EAL: Can't read from PCI bar (0) : offset (12)
>> EAL: Can't write to PCI bar (0) : offset (12)
>> EAL: Can't read from PCI bar (0) : offset (12)
>> EAL: Can't write to PCI bar (0) : offset (12)
>> EAL: Can't read from PCI bar (0) : offset (0)
>> EAL: Can't write to PCI bar (0) : offset (4)
>> EAL: Can't write to PCI bar (0) : offset (14)
>> EAL: Can't write to PCI bar (0) : offset (e)
>> EAL: Can't read from PCI bar (0) : offset (c)
>> EAL: Requested device 0000:00:02.0 cannot be used
>> EAL: No probed ethernet devices
>> Interactive-mode selected
>> USER1: create a new mbuf pool <mbuf_pool_socket_0>: n=251456, size=2176,
>> socket=0
>>
>> When VM uses *4K pages* the same setup works fine. I will work on this
>> but please let me know in case you already know what is going on.
> 
> No I did not face that one. I was able to launch testpmd without such
> early message. However I assigned an igbvf device to the guest and then
> to DPDK. I've never tested your config.
> 
> However as stated in my cover letter at the moment DPDK is not working
> for me because of storms of tlbi-on-maps. I intend to work on this as
> soon as get some bandwidth, sorry.

I found what was the reason of failure.

QEMU creates BARs for VIRTIO PCI device. The size of it depends on what 
is necessary for VIRTIO protocol. In my case the BAR is 16K size which 
is too small to be mmapable for kernel with 64K pages:
vfio_pci_enable() -> vfio_pci_probe_mmaps() ->
here guest kernel checks that BAR size is smaller than current PAGE_SIZE 
and clears VFIO_REGION_INFO_FLAG_MMAP flag which prevents BAR from being 
mmapped later on. I added -device virtio-net-pci,...,page-per-vq=on to 
enlarge BAR size to 8M and now testpmd works fine. I wonder how the same 
setup is working with e.g. Intel or AMD IOMMU.

Thanks,
Tomasz
