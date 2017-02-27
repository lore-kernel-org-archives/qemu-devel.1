Received: from eggs.gnu.org ([2001:4830:134:3::10]:53288)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <xyjxie@linux.vnet.ibm.com>) id 1ciCvQ-0008W8-B6
	for qemu-devel@nongnu.org; Sun, 26 Feb 2017 23:28:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <xyjxie@linux.vnet.ibm.com>) id 1ciCvN-0007Vt-5W
	for qemu-devel@nongnu.org; Sun, 26 Feb 2017 23:28:40 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:59436
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <xyjxie@linux.vnet.ibm.com>)
	id 1ciCvN-0007V2-0M
	for qemu-devel@nongnu.org; Sun, 26 Feb 2017 23:28:37 -0500
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v1R4EiXY103547
	for <qemu-devel@nongnu.org>; Sun, 26 Feb 2017 23:28:35 -0500
Received: from e17.ny.us.ibm.com (e17.ny.us.ibm.com [129.33.205.207])
	by mx0b-001b2d01.pphosted.com with ESMTP id 28urfuhhh7-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Sun, 26 Feb 2017 23:28:34 -0500
Received: from localhost
	by e17.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <xyjxie@linux.vnet.ibm.com>;
	Sun, 26 Feb 2017 23:28:34 -0500
References: <1487659615-15820-1-git-send-email-xyjxie@linux.vnet.ibm.com>
	<5edff645-12e8-d3e0-1849-302b6986c232@ozlabs.ru>
	<148816231660.24134.11740535448495534378@loki>
	<4d32c104-25e8-3a90-37c9-544ca9ed6775@ozlabs.ru>
From: Yongji Xie <xyjxie@linux.vnet.ibm.com>
Date: Mon, 27 Feb 2017 12:28:24 +0800
MIME-Version: 1.0
In-Reply-To: <4d32c104-25e8-3a90-37c9-544ca9ed6775@ozlabs.ru>
Content-Type: text/plain; charset=koi8-r; format=flowed
Content-Transfer-Encoding: 7bit
Message-Id: <8df6bd1d-e775-edd6-5047-6d1b2d6f4b10@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [PATCH] memory: make ram device read/write endian
 sensitive
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alexey Kardashevskiy <aik@ozlabs.ru>, Michael Roth <mdroth@linux.vnet.ibm.com>, pbonzini@redhat.com
Cc: Peter Maydell <peter.maydell@linaro.org>, zhong@linux.vnet.ibm.com, qemu-devel@nongnu.org, alex.williamson@redhat.com, Paul Mackerras <paulus@samba.org>, David Gibson <david@gibson.dropbear.id.au>

on 2017/2/27 11:25, Alexey Kardashevskiy wrote:

> On 27/02/17 13:25, Michael Roth wrote:
>> Quoting Alexey Kardashevskiy (2017-02-22 22:20:25)
>>> On 21/02/17 17:46, Yongji Xie wrote:
>>>> At the moment ram device's memory regions are NATIVE_ENDIAN. This does
>>>> not work on PPC64 because VFIO PCI device is little endian but PPC64
>>>> always defines static macro TARGET_WORDS_BIGENDIAN.
>>>>
>>>> This fixes endianness for ram device the same way as it is done
>>>> for VFIO region in commit 6758008e2c4e79fb6bd04fe8e7a41665fa583965.
>>>>
>>>> Signed-off-by: Yongji Xie <xyjxie@linux.vnet.ibm.com>
>>>> ---
>>>>   memory.c |   14 +++++++-------
>>>>   1 files changed, 7 insertions(+), 7 deletions(-)
>>>>
>>>> diff --git a/memory.c b/memory.c
>>>> index 6c58373..1ccb99f 100644
>>>> --- a/memory.c
>>>> +++ b/memory.c
>>>> @@ -1139,13 +1139,13 @@ static uint64_t memory_region_ram_device_read(void *opaque,
>>>>           data = *(uint8_t *)(mr->ram_block->host + addr);
>>>>           break;
>>>>       case 2:
>>>> -        data = *(uint16_t *)(mr->ram_block->host + addr);
>>>> +        data = le16_to_cpu(*(uint16_t *)(mr->ram_block->host + addr));
>>>>           break;
>>>>       case 4:
>>>> -        data = *(uint32_t *)(mr->ram_block->host + addr);
>>>> +        data = le32_to_cpu(*(uint32_t *)(mr->ram_block->host + addr));
>>>>           break;
>>>>       case 8:
>>>> -        data = *(uint64_t *)(mr->ram_block->host + addr);
>>>> +        data = le64_to_cpu(*(uint64_t *)(mr->ram_block->host + addr));
>>>>           break;
>>>>       }
>>>>   
>>>> @@ -1166,13 +1166,13 @@ static void memory_region_ram_device_write(void *opaque, hwaddr addr,
>>>>           *(uint8_t *)(mr->ram_block->host + addr) = (uint8_t)data;
>>>>           break;
>>>>       case 2:
>>>> -        *(uint16_t *)(mr->ram_block->host + addr) = (uint16_t)data;
>>>> +        *(uint16_t *)(mr->ram_block->host + addr) = cpu_to_le16((uint16_t)data);
>>>>           break;
>>>>       case 4:
>>>> -        *(uint32_t *)(mr->ram_block->host + addr) = (uint32_t)data;
>>>> +        *(uint32_t *)(mr->ram_block->host + addr) = cpu_to_le32((uint32_t)data);
>>>>           break;
>>>>       case 8:
>>>> -        *(uint64_t *)(mr->ram_block->host + addr) = data;
>>>> +        *(uint64_t *)(mr->ram_block->host + addr) = cpu_to_le64(data);
>>>>           break;
>>>>       }
>>>>   }
>>>> @@ -1180,7 +1180,7 @@ static void memory_region_ram_device_write(void *opaque, hwaddr addr,
>>>>   static const MemoryRegionOps ram_device_mem_ops = {
>>>>       .read = memory_region_ram_device_read,
>>>>       .write = memory_region_ram_device_write,
>>>> -    .endianness = DEVICE_NATIVE_ENDIAN,
>>>> +    .endianness = DEVICE_LITTLE_ENDIAN,
>>>>       .valid = {
>>>>           .min_access_size = 1,
>>>>           .max_access_size = 8,
>>>>
>>>          
>>>
>>> I did some debugging today.
>>>
>>> First, Paolo is right and ram_device_mem_ops::endianness should be
>>> host-endian which happens to be little in our test case (ppc64le) so
>>> changes to .read/.write are actually no-op (I believe so, have not checked).
>>>
>>>
>>> But I was wondering why this gets executed at all.
>>>
>>> The test case is:
>>>
>>> qemu-system-ppc64 ...
>>> -device "vfio-pci,id=vfio0001_03_00_0,host=0001:03:00.0
>>> -drive id=DRIVE0,if=none,file=./test.qcow2,format=qcow2
>>> -device virtio-blk-pci,id=vblk0,drive=DRIVE0
>>>
>>> The host kernel is v4.10, ppc64le (little endian), 64K system page size,
>>> QEMU is v2.8.0.
>>>
>>> When this boots, lspci shows:
>>>
>>> 00:00.0 Ethernet controller: Chelsio Communications Inc T310 10GbE Single
>>> Port Adapter
>>>          Subsystem: IBM Device 038c
>>>          Flags: bus master, fast devsel, latency 0, IRQ 18
>>>          Memory at 210000004000 (64-bit, non-prefetchable) [size=4K]
>>>          Memory at 210000800000 (64-bit, non-prefetchable) [size=8M]
>>>          Memory at 210001000000 (64-bit, non-prefetchable) [size=4K]
>>>          Expansion ROM at 2000c0080000 [disabled] [size=512K]
>>>          Capabilities: [40] Power Management version 3
>>>          Capabilities: [48] MSI: Enable- Count=1/32 Maskable- 64bit+
>>>          Capabilities: [58] Express Endpoint, MSI 00
>>>          Capabilities: [94] Vital Product Data
>>>          Capabilities: [9c] MSI-X: Enable+ Count=32 Masked-
>>>          Kernel driver in use: cxgb3
>>>
>>> 00:01.0 SCSI storage controller: Red Hat, Inc Virtio block device
>>>          Subsystem: Red Hat, Inc Device 0002
>>>          Physical Slot: C16
>>>          Flags: bus master, fast devsel, latency 0, IRQ 17
>>>          I/O ports at 0040 [size=64]
>>>          Memory at 2000c0000000 (32-bit, non-prefetchable) [size=4K]
>>>          Memory at 210000000000 (64-bit, prefetchable) [size=16K]
>>>          Capabilities: [98] MSI-X: Enable+ Count=2 Masked-
>>>          Capabilities: [84] Vendor Specific Information: Len=14 <?>
>>>          Capabilities: [70] Vendor Specific Information: Len=14 <?>
>>>          Capabilities: [60] Vendor Specific Information: Len=10 <?>
>>>          Capabilities: [50] Vendor Specific Information: Len=10 <?>
>>>          Capabilities: [40] Vendor Specific Information: Len=10 <?>
>>>          Kernel driver in use: virtio-pci
>>>
>>>
>>> As we can see, BAR0 of Chelsio is 210000004000 - not aligned (it should
>>> have been aligned but it is not - this is another bug, in QEMU). Normally
>> I think SLOF is the culprit in this case. The patch below enforces
>> 64k alignment for mmio/mem regions at boot-time. I'm not sure if this
>> should be done for all devices, or limited specifically to VFIO though
>> (controlled perhaps via a per-device property? or at the machine-level
>> at least?):
>
> I was sure we have this in SLOF and now I see that we don't. Hm :)
>

I have a quick check. Seems like the SLOF patch was only in pkvm3.1.1 
SLOF tree...

Thanks,
Yongji
