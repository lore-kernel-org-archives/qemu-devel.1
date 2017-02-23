Received: from eggs.gnu.org ([2001:4830:134:3::10]:54252)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1cgktR-0003vT-7w
	for qemu-devel@nongnu.org; Wed, 22 Feb 2017 23:20:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1cgktO-00085X-3W
	for qemu-devel@nongnu.org; Wed, 22 Feb 2017 23:20:37 -0500
Received: from mail-pg0-x244.google.com ([2607:f8b0:400e:c05::244]:34105)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <aik@ozlabs.ru>) id 1cgktN-000856-Ql
	for qemu-devel@nongnu.org; Wed, 22 Feb 2017 23:20:34 -0500
Received: by mail-pg0-x244.google.com with SMTP id s67so3099449pgb.1
	for <qemu-devel@nongnu.org>; Wed, 22 Feb 2017 20:20:32 -0800 (PST)
References: <1487659615-15820-1-git-send-email-xyjxie@linux.vnet.ibm.com>
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Message-ID: <5edff645-12e8-d3e0-1849-302b6986c232@ozlabs.ru>
Date: Thu, 23 Feb 2017 15:20:25 +1100
MIME-Version: 1.0
In-Reply-To: <1487659615-15820-1-git-send-email-xyjxie@linux.vnet.ibm.com>
Content-Type: text/plain; charset=koi8-r
Content-Transfer-Encoding: 7bit
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
To: Yongji Xie <xyjxie@linux.vnet.ibm.com>, pbonzini@redhat.com
Cc: qemu-devel@nongnu.org, alex.williamson@redhat.com, zhong@linux.vnet.ibm.com, Peter Maydell <peter.maydell@linaro.org>, David Gibson <david@gibson.dropbear.id.au>, Paul Mackerras <paulus@samba.org>

On 21/02/17 17:46, Yongji Xie wrote:
> At the moment ram device's memory regions are NATIVE_ENDIAN. This does
> not work on PPC64 because VFIO PCI device is little endian but PPC64
> always defines static macro TARGET_WORDS_BIGENDIAN.
> 
> This fixes endianness for ram device the same way as it is done
> for VFIO region in commit 6758008e2c4e79fb6bd04fe8e7a41665fa583965.
> 
> Signed-off-by: Yongji Xie <xyjxie@linux.vnet.ibm.com>
> ---
>  memory.c |   14 +++++++-------
>  1 files changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/memory.c b/memory.c
> index 6c58373..1ccb99f 100644
> --- a/memory.c
> +++ b/memory.c
> @@ -1139,13 +1139,13 @@ static uint64_t memory_region_ram_device_read(void *opaque,
>          data = *(uint8_t *)(mr->ram_block->host + addr);
>          break;
>      case 2:
> -        data = *(uint16_t *)(mr->ram_block->host + addr);
> +        data = le16_to_cpu(*(uint16_t *)(mr->ram_block->host + addr));
>          break;
>      case 4:
> -        data = *(uint32_t *)(mr->ram_block->host + addr);
> +        data = le32_to_cpu(*(uint32_t *)(mr->ram_block->host + addr));
>          break;
>      case 8:
> -        data = *(uint64_t *)(mr->ram_block->host + addr);
> +        data = le64_to_cpu(*(uint64_t *)(mr->ram_block->host + addr));
>          break;
>      }
>  
> @@ -1166,13 +1166,13 @@ static void memory_region_ram_device_write(void *opaque, hwaddr addr,
>          *(uint8_t *)(mr->ram_block->host + addr) = (uint8_t)data;
>          break;
>      case 2:
> -        *(uint16_t *)(mr->ram_block->host + addr) = (uint16_t)data;
> +        *(uint16_t *)(mr->ram_block->host + addr) = cpu_to_le16((uint16_t)data);
>          break;
>      case 4:
> -        *(uint32_t *)(mr->ram_block->host + addr) = (uint32_t)data;
> +        *(uint32_t *)(mr->ram_block->host + addr) = cpu_to_le32((uint32_t)data);
>          break;
>      case 8:
> -        *(uint64_t *)(mr->ram_block->host + addr) = data;
> +        *(uint64_t *)(mr->ram_block->host + addr) = cpu_to_le64(data);
>          break;
>      }
>  }
> @@ -1180,7 +1180,7 @@ static void memory_region_ram_device_write(void *opaque, hwaddr addr,
>  static const MemoryRegionOps ram_device_mem_ops = {
>      .read = memory_region_ram_device_read,
>      .write = memory_region_ram_device_write,
> -    .endianness = DEVICE_NATIVE_ENDIAN,
> +    .endianness = DEVICE_LITTLE_ENDIAN,
>      .valid = {
>          .min_access_size = 1,
>          .max_access_size = 8,
>
	

I did some debugging today.

First, Paolo is right and ram_device_mem_ops::endianness should be
host-endian which happens to be little in our test case (ppc64le) so
changes to .read/.write are actually no-op (I believe so, have not checked).


But I was wondering why this gets executed at all.

The test case is:

qemu-system-ppc64 ...
-device "vfio-pci,id=vfio0001_03_00_0,host=0001:03:00.0
-drive id=DRIVE0,if=none,file=./test.qcow2,format=qcow2
-device virtio-blk-pci,id=vblk0,drive=DRIVE0

The host kernel is v4.10, ppc64le (little endian), 64K system page size,
QEMU is v2.8.0.

When this boots, lspci shows:

00:00.0 Ethernet controller: Chelsio Communications Inc T310 10GbE Single
Port Adapter
        Subsystem: IBM Device 038c
        Flags: bus master, fast devsel, latency 0, IRQ 18
        Memory at 210000004000 (64-bit, non-prefetchable) [size=4K]
        Memory at 210000800000 (64-bit, non-prefetchable) [size=8M]
        Memory at 210001000000 (64-bit, non-prefetchable) [size=4K]
        Expansion ROM at 2000c0080000 [disabled] [size=512K]
        Capabilities: [40] Power Management version 3
        Capabilities: [48] MSI: Enable- Count=1/32 Maskable- 64bit+
        Capabilities: [58] Express Endpoint, MSI 00
        Capabilities: [94] Vital Product Data
        Capabilities: [9c] MSI-X: Enable+ Count=32 Masked-
        Kernel driver in use: cxgb3

00:01.0 SCSI storage controller: Red Hat, Inc Virtio block device
        Subsystem: Red Hat, Inc Device 0002
        Physical Slot: C16
        Flags: bus master, fast devsel, latency 0, IRQ 17
        I/O ports at 0040 [size=64]
        Memory at 2000c0000000 (32-bit, non-prefetchable) [size=4K]
        Memory at 210000000000 (64-bit, prefetchable) [size=16K]
        Capabilities: [98] MSI-X: Enable+ Count=2 Masked-
        Capabilities: [84] Vendor Specific Information: Len=14 <?>
        Capabilities: [70] Vendor Specific Information: Len=14 <?>
        Capabilities: [60] Vendor Specific Information: Len=10 <?>
        Capabilities: [50] Vendor Specific Information: Len=10 <?>
        Capabilities: [40] Vendor Specific Information: Len=10 <?>
        Kernel driver in use: virtio-pci


As we can see, BAR0 of Chelsio is 210000004000 - not aligned (it should
have been aligned but it is not - this is another bug, in QEMU). Normally
such a BAR would be emulated by VFIO. However, since 95251725e335 "vfio:
Add support for mmapping sub-page MMIO BARs" we mmap such BARs to QEMU in a
hope they will be registered later via KVM_SET_USER_MEMORY_REGION - and
this fails as the guest address is not host page size aligned.

So we end up having the following memory tree:

memory-region: pci@800000020000000.mmio
  0000000000000000-ffffffffffffffff (prio 0, RW): pci@800000020000000.mmio
    00000000c0000000-00000000c0000fff (prio 1, RW): virtio-blk-pci-msix
      00000000c0000000-00000000c000001f (prio 0, RW): msix-table
      00000000c0000800-00000000c0000807 (prio 0, RW): msix-pba
    0000210000000000-0000210000003fff (prio 1, RW): virtio-pci
      0000210000000000-0000210000000fff (prio 0, RW): virtio-pci-common
      0000210000001000-0000210000001fff (prio 0, RW): virtio-pci-isr
      0000210000002000-0000210000002fff (prio 0, RW): virtio-pci-device
      0000210000003000-0000210000003fff (prio 0, RW): virtio-pci-notify
    0000210000004000-0000210000004fff (prio 1, RW): 0001:03:00.0 BAR 0
      0000210000004000-0000210000004fff (prio 0, RW): 0001:03:00.0 BAR 0
mmaps[0]
    0000210000800000-0000210000ffffff (prio 1, RW): 0001:03:00.0 BAR 2
      0000210000800000-0000210000ffffff (prio 0, RW): 0001:03:00.0 BAR 2
mmaps[0]
    0000210001000000-0000210001000fff (prio 1, RW): 0001:03:00.0 BAR 4
      0000210001000000-00002100010001ff (prio 0, RW): msix-table
      0000210001000800-0000210001000807 (prio 0, RW): msix-pba [disabled]

The problem region which this patch is fixing is "0001:03:00.0 BAR 0
mmaps[0]". It is mmaped to QEMU and not registered in KVM. So when the
guest accesses this BAR, we trap into KVM, KVM passes it to QEMU and QEMU
read/writes this memory region.

A simple hack like below fixes it - it basically removes mmap'd memory
region from the tree and MMIO starts being handled by the parent MR -
"0001:03:00.0 BAR 0" (which is "little endian" - vfio_region_ops).


I am wondering now what would be a correct approach here?

Add/remove mmap'd MRs once we detect aligned/unaligned BARs?

Keep things where they are in the VFIO department and just fix
ram_device_mem_ops::endianness?

Thanks.



diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index d7dbe0e3e0..0657a27623 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -1109,7 +1109,10 @@ static void
vfio_sub_page_bar_update_mapping(PCIDevice *pdev, int bar)
     memory_region_transaction_begin();

     memory_region_set_size(mr, size);
-    memory_region_set_size(mmap_mr, size);
+    if (bar_addr & qemu_real_host_page_mask)
+          memory_region_del_subregion(mr, mmap_mr);
+    else
+        memory_region_set_size(mmap_mr, size);
     if (size != region->size && memory_region_is_mapped(mr)) {
         memory_region_del_subregion(r->address_space, mr);
         memory_region_add_subregion_overlap(r->address_space,



-- 
Alexey
