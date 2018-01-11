Received: from eggs.gnu.org ([2001:4830:134:3::10]:51960)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prasad.singamsetty@oracle.com>) id 1eZfaf-0002yu-8P
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 11:20:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prasad.singamsetty@oracle.com>) id 1eZfab-0006Ka-UR
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 11:20:29 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:60574)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <prasad.singamsetty@oracle.com>)
	id 1eZfab-0006JI-8a
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 11:20:25 -0500
References: <20171114231350.286025-1-prasad.singamsetty@oracle.com>
	<20171114231350.286025-3-prasad.singamsetty@oracle.com>
	<20171201112952.GC31366@sky-dev>
	<11a95513-73af-7a80-48bf-f78fa8740439@oracle.com>
	<A2975661238FB949B60364EF0F2C257439B3FF82@SHSMSX104.ccr.corp.intel.com>
From: Prasad Singamsetty <prasad.singamsetty@oracle.com>
Message-ID: <b4de9b7f-7432-a5dd-270d-91b73e9e3918@oracle.com>
Date: Thu, 11 Jan 2018 08:19:07 -0800
MIME-Version: 1.0
In-Reply-To: <A2975661238FB949B60364EF0F2C257439B3FF82@SHSMSX104.ccr.corp.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v1 2/2] intel-iommu: Extend address width
 to 48 bits
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Liu, Yi L" <yi.l.liu@intel.com>, "Liu, Yi L" <yi.l.liu@linux.intel.com>
Cc: "ehabkost@redhat.com" <ehabkost@redhat.com>, "mst@redhat.com" <mst@redhat.com>, "konrad.wilk@oracle.com" <konrad.wilk@oracle.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "peterx@redhat.com" <peterx@redhat.com>, "imammedo@redhat.com" <imammedo@redhat.com>, "pbonzini@redhat.com" <pbonzini@redhat.com>, "rth@twiddle.net" <rth@twiddle.net>



On 1/10/2018 6:46 PM, Liu, Yi L wrote:
>> -----Original Message-----
>> From: Qemu-devel [mailto:qemu-devel-bounces+yi.l.liu=intel.com@nongnu.org] On
>> Behalf Of Prasad Singamsetty
>> Sent: Thursday, January 11, 2018 8:06 AM
>> To: Liu, Yi L <yi.l.liu@linux.intel.com>
>> Cc: ehabkost@redhat.com; mst@redhat.com; konrad.wilk@oracle.com; qemu-
>> devel@nongnu.org; peterx@redhat.com; imammedo@redhat.com;
>> pbonzini@redhat.com; rth@twiddle.net
>> Subject: Re: [Qemu-devel] [PATCH v1 2/2] intel-iommu: Extend address width to 48
>> bits
>>
>>
>> Hi Yi L,
>>
>> On 12/1/2017 3:29 AM, Liu, Yi L wrote:
>>> On Tue, Nov 14, 2017 at 06:13:50PM -0500, prasad.singamsetty@oracle.com
>> wrote:
>>>> From: Prasad Singamsetty <prasad.singamsetty@oracle.com>
>>>>
>>>> The current implementation of Intel IOMMU code only supports 39 bits
>>>> iova address width. This patch provides a new parameter (x-aw-bits)
>>>> for intel-iommu to extend its address width to 48 bits but keeping
>>>> the default the same (39 bits). The reason for not changing the
>>>> default is to avoid potential compatibility problems with live
>>>> migration of intel-iommu enabled QEMU guest. The only valid values for 'x-aw-
>> bits'
>>>> parameter are 39 and 48.
>>>>
>>>> After enabling larger address width (48), we should be able to map
>>>> larger iova addresses in the guest. For example, a QEMU guest that is
>>>> configured with large memory ( >=1TB ). To check whether 48 bits aw
>>>> is enabled, we can grep in the guest dmesg output with line:
>>>> "DMAR: Host address width 48".
>>>>
>>>> Signed-off-by: Prasad Singamsetty <prasad.singamsety@oracle.com>
>>>
>>> Prasad,
>>>
>>> Have you tested the scenario with physical device assigned to a guest?
>>
>> Sorry for the long delay in following up on this.
>>
>> I did some testing with vfio-pci devices assigned to the guest.
>> This is done on the latest qemu code base (2.11.50).
>>
>> Here are the test cases/results:
>>
>> 1. Booting VM with one or two vfio-pci (network) devices
>>      and multiple memory size configs (up to 256G). Assigned pci
>>      devices (network interfaces) worked fine and no issues
>>      in using these devices. This test is run for both address
>>      widths (39 and 48).
>> 2. If the guest VM is configured to use 512G and address
>>      width is the default 39 bits then guest OS fails to
>>      boot due to DMA failures. The same is observed without
>>      applying the patch set. The guest OS ends up booting into
>>      dracut shell. This problem is not seen if we set the address
>>      width to 48 bits. So, the patch set addresses a latent bug
>>      with large memory config.
>>
>> ISSUE - VM could take long time to boot with vfio-pci devices
>>
>> Qemu process could take a long time to initialize the VM when vfio-pci device is
>> configured depending on the memory size. For small memory sizes (less than 32G) it
>> is not noticeable (<30s). For larger memory sizes, the delay ranges from several
>> minutes and longer (2-40min). For more than 512G, qemu process appears to hang
>> but can be interrupted. This behavior is observed without patch set applied also. The
>> slowness is due to VFIO_IOMMU_MAP_DMA ioctl taking long time to map the
>> system ram assigned to the guest. This is when qemu process is initializing the vfio
>> device where it maps all the assigned ram memory regions. Here is the stack trace
>> from gdb:
>>
>> #0  vfio_dma_map (container=0x5555582709d0, iova=4294967296,
>>                     size=547608330240, vaddr=0x7f7fd3e00000,
>>                     readonly=false)
>>       at /home/psingams/qemu-upstream-v2/hw/vfio/common.c:250
>> #1  0x000055555584f471 in vfio_listener_region_add(
>>                     listener=0x5555582709e0,
>>                     section=0x7fffffffc7f0)
>>       at /home/psingams/qemu-upstream-v2/hw/vfio/common.c:521
>> #2  0x00005555557f08fc in listener_add_address_space (
>>                     listener=0x5555582709e0, as=0x55555813b790)
>>       at /home/psingams/qemu-upstream-v2/memory.c:2600
>> #3  0x00005555557f0bbe in memory_listener_register (
>>                     listener=0x5555582709e0, as=0x55555813b790)
>>       at /home/psingams/qemu-upstream-v2/memory.c:2643
>> #4  0x00005555558511ef in vfio_connect_container (group=0x555558270960,
>>                     as=0x55555813b790, errp=0x7fffffffdae8)
>>       at /home/psingams/qemu-upstream-v2/hw/vfio/common.c:1130
>> ****
>> (gdb) print/x size
>> $2 = 0x7f80000000
>>
>> This is before guest OS gets to boot. The host is running 4.15.0-rc6 kernel with qemu
>> version 2.11.50.
>>
>> I am not sure if this is a known issue and someone is already working on fixing the
>> implementation of VFIO_IOMMU_MAP_DMA ioctl.
> 
> It seems to be same issue with the one reported by Bob.
> https://lists.gnu.org/archive/html/qemu-devel/2017-12/msg05098.html
> 
> Per chatted with them, the reason looks to be no enough memory in host. how about
> the memory size in your host?

The host system has 1.2TB memory and just one VM with one vfio-pci
device assigned to it. I don't think it is the same issue as not
enough memory.

Regards,
--Prasad

> 
>> This issue is not related to this patch set and need to be investigated separately.
>>
>> Please let me know if there are other comments on this patch set.
>>
> 
> Regards,
> Yi L
> 
