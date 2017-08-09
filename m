Received: from eggs.gnu.org ([2001:4830:134:3::10]:42821)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1dfFSM-00014m-FR
	for qemu-devel@nongnu.org; Tue, 08 Aug 2017 21:06:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1dfFSJ-00014E-0a
	for qemu-devel@nongnu.org; Tue, 08 Aug 2017 21:06:42 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53110)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lersek@redhat.com>) id 1dfFSI-000137-D7
	for qemu-devel@nongnu.org; Tue, 08 Aug 2017 21:06:38 -0400
From: Laszlo Ersek <lersek@redhat.com>
References: <743158bc-15e4-46fe-38cb-161397b5b240@linaro.org>
	<3685aed3-735f-ae62-73a9-8f4a5c7cd459@redhat.com>
Message-ID: <9be585e2-4641-329e-f442-69ae05faadba@redhat.com>
Date: Wed, 9 Aug 2017 03:06:29 +0200
MIME-Version: 1.0
In-Reply-To: <3685aed3-735f-ae62-73a9-8f4a5c7cd459@redhat.com>
Content-Type: multipart/mixed; boundary="------------96ED07348D9A3F82D48ECD0E"
Content-Language: en-US
Subject: Re: [Qemu-devel] Qemu and 32 PCIe devices
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>, Marcel Apfelbaum <marcel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Drew Jones <drjones@redhat.com>, Christoffer Dall <cdall@linaro.org>, Peter Maydell <peter.maydell@linaro.org>, Gema Gomez-Solano <gema.gomez-solano@linaro.org>, Marc Zygnier <marc.zyngier@arm.com>

This is a multi-part message in MIME format.
--------------96ED07348D9A3F82D48ECD0E
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit

On 08/08/17 17:51, Laszlo Ersek wrote:
> On 08/08/17 12:39, Marcin Juszkiewicz wrote:

>> Anyway, beyond the things written in that comment, there is one very
>> interesting symptom that makes me think another (milder?) bottleneck
>> could be in QEMU:
>>
>> When having a large number of PCI(e) devices (to the tune of 100+),
>> even the printing of DEBUG messages slows down extremely, to the
>> point where I can basically follow, with the naked eye, the printing
>> of *individual* characters, on the QEMU debug port. (Obviously such
>> printing is unrelated to PCI devices; the QEMU debug port is a simple
>> platform device on Q35 and i440fx). This suggests to me that the high
>> number of MemoryRegion objects in QEMU, used for the BARs of PCI(e)
>> devices and bridges, could slow down the dispatching of the
>> individual IO or MMIO accesses. I don't know what data structure QEMU
>> uses for representing the "flat view" of the address sapce, but I
>> think it *could* be a bottleneck. At least I tried to profile a few
>> bits in the firmware, and found nothing related specifically to the
>> slowdown of DEBUG prints.
>
> (Paolo says the data structure is a radix tree, so the bottleneck
> being there would be surprising. Also Paolo has given me tips for
> profiling, so I'm looking into it.)

I have some results here. They are probably not as well compiled as they
would be by someone who profiles stuff every morning for breakfast, but
it's a start I hope.


(1) My command script was the following. I used virtio-scsi-pci
controllers because they don't need backends and also have no pflash
impact in the firmware.

The PCI hierarchy is basically a DMI-PCI bridge plugged into the PCI
Express root complex, with up to five PCI-PCI bridges on that, and then
31 virtio-scsi-pci devices on each PCI-PCI bridge. By moving the "exit
0" around, I could control the number of virtio PCI devices. Pretty
crude, but it worked.

Also, I used PCI (and not PCI Express) bridges and devices because I
didn't want to run out of IO space for this test. (That's a different
question, related to other points in this (and other) threads.)

> CODE=/home/virt-images/OVMF_CODE.4m.fd
> TMPL=/home/virt-images/OVMF_VARS.4m.fd
>
> cd ~/tmp/
>
> if ! [ -e vars16.fd ]; then
>   cp $TMPL vars16.fd
> fi
>
> qemu-system-x86_64 \
>   \
>   -machine q35,vmport=off,accel=kvm \
>   -drive if=pflash,readonly,format=raw,file=$CODE \
>   -drive if=pflash,format=raw,file=vars16.fd \
>   -net none \
>   -display none \
>   -fw_cfg name=opt/ovmf/PcdResizeXterm,string=y \
>   -m 2048 \
>   -debugcon file:debug16.log \
>   -global isa-debugcon.iobase=0x402 \
>   -name debug-threads=on \
>   -s \
>   -chardev stdio,signal=off,mux=on,id=char0 \
>   -mon chardev=char0,mode=readline \
>   -serial chardev:char0 \
>   \
>   -trace enable='pci_update_mappings*' \
>   \
>   -device i82801b11-bridge,id=dmi-pci-bridge \
>   \
>   -device pci-bridge,id=bridge-1,chassis_nr=1,bus=dmi-pci-bridge \
>   -device pci-bridge,id=bridge-2,chassis_nr=2,bus=dmi-pci-bridge \
>   -device pci-bridge,id=bridge-3,chassis_nr=3,bus=dmi-pci-bridge \
>   -device pci-bridge,id=bridge-4,chassis_nr=4,bus=dmi-pci-bridge \
>   -device pci-bridge,id=bridge-5,chassis_nr=5,bus=dmi-pci-bridge \
>   \
>   -device virtio-scsi-pci,bus=bridge-1,addr=0x1.0 \
>   -device virtio-scsi-pci,bus=bridge-1,addr=0x2.0 \
>   -device virtio-scsi-pci,bus=bridge-1,addr=0x3.0 \
>   -device virtio-scsi-pci,bus=bridge-1,addr=0x4.0 \
>   -device virtio-scsi-pci,bus=bridge-1,addr=0x5.0 \
>   -device virtio-scsi-pci,bus=bridge-1,addr=0x6.0 \
>   -device virtio-scsi-pci,bus=bridge-1,addr=0x7.0 \
>   -device virtio-scsi-pci,bus=bridge-1,addr=0x8.0 \
>   -device virtio-scsi-pci,bus=bridge-1,addr=0x9.0 \
>   -device virtio-scsi-pci,bus=bridge-1,addr=0xa.0 \
>   -device virtio-scsi-pci,bus=bridge-1,addr=0xb.0 \
>   -device virtio-scsi-pci,bus=bridge-1,addr=0xc.0 \
>   -device virtio-scsi-pci,bus=bridge-1,addr=0xd.0 \
>   -device virtio-scsi-pci,bus=bridge-1,addr=0xe.0 \
>   -device virtio-scsi-pci,bus=bridge-1,addr=0xf.0 \
>   -device virtio-scsi-pci,bus=bridge-1,addr=0x10.0 \
>   -device virtio-scsi-pci,bus=bridge-1,addr=0x11.0 \
>   -device virtio-scsi-pci,bus=bridge-1,addr=0x12.0 \
>   -device virtio-scsi-pci,bus=bridge-1,addr=0x13.0 \
>   -device virtio-scsi-pci,bus=bridge-1,addr=0x14.0 \
>   -device virtio-scsi-pci,bus=bridge-1,addr=0x15.0 \
>   -device virtio-scsi-pci,bus=bridge-1,addr=0x16.0 \
>   -device virtio-scsi-pci,bus=bridge-1,addr=0x17.0 \
>   -device virtio-scsi-pci,bus=bridge-1,addr=0x18.0 \
>   -device virtio-scsi-pci,bus=bridge-1,addr=0x19.0 \
>   -device virtio-scsi-pci,bus=bridge-1,addr=0x1a.0 \
>   -device virtio-scsi-pci,bus=bridge-1,addr=0x1b.0 \
>   -device virtio-scsi-pci,bus=bridge-1,addr=0x1c.0 \
>   -device virtio-scsi-pci,bus=bridge-1,addr=0x1d.0 \
>   -device virtio-scsi-pci,bus=bridge-1,addr=0x1e.0 \
>   -device virtio-scsi-pci,bus=bridge-1,addr=0x1f.0 \
>   \
>   -device virtio-scsi-pci,bus=bridge-2,addr=0x1.0 \
>   -device virtio-scsi-pci,bus=bridge-2,addr=0x2.0 \
>   -device virtio-scsi-pci,bus=bridge-2,addr=0x3.0 \
>   -device virtio-scsi-pci,bus=bridge-2,addr=0x4.0 \
>   -device virtio-scsi-pci,bus=bridge-2,addr=0x5.0 \
>   -device virtio-scsi-pci,bus=bridge-2,addr=0x6.0 \
>   -device virtio-scsi-pci,bus=bridge-2,addr=0x7.0 \
>   -device virtio-scsi-pci,bus=bridge-2,addr=0x8.0 \
>   -device virtio-scsi-pci,bus=bridge-2,addr=0x9.0 \
>   -device virtio-scsi-pci,bus=bridge-2,addr=0xa.0 \
>   -device virtio-scsi-pci,bus=bridge-2,addr=0xb.0 \
>   -device virtio-scsi-pci,bus=bridge-2,addr=0xc.0 \
>   -device virtio-scsi-pci,bus=bridge-2,addr=0xd.0 \
>   -device virtio-scsi-pci,bus=bridge-2,addr=0xe.0 \
>   -device virtio-scsi-pci,bus=bridge-2,addr=0xf.0 \
>   -device virtio-scsi-pci,bus=bridge-2,addr=0x10.0 \
>   -device virtio-scsi-pci,bus=bridge-2,addr=0x11.0 \
>   -device virtio-scsi-pci,bus=bridge-2,addr=0x12.0 \
>   -device virtio-scsi-pci,bus=bridge-2,addr=0x13.0 \
>   -device virtio-scsi-pci,bus=bridge-2,addr=0x14.0 \
>   -device virtio-scsi-pci,bus=bridge-2,addr=0x15.0 \
>   -device virtio-scsi-pci,bus=bridge-2,addr=0x16.0 \
>   -device virtio-scsi-pci,bus=bridge-2,addr=0x17.0 \
>   -device virtio-scsi-pci,bus=bridge-2,addr=0x18.0 \
>   -device virtio-scsi-pci,bus=bridge-2,addr=0x19.0 \
>   -device virtio-scsi-pci,bus=bridge-2,addr=0x1a.0 \
>   -device virtio-scsi-pci,bus=bridge-2,addr=0x1b.0 \
>   -device virtio-scsi-pci,bus=bridge-2,addr=0x1c.0 \
>   -device virtio-scsi-pci,bus=bridge-2,addr=0x1d.0 \
>   -device virtio-scsi-pci,bus=bridge-2,addr=0x1e.0 \
>   -device virtio-scsi-pci,bus=bridge-2,addr=0x1f.0 \
>   \
>   -device virtio-scsi-pci,bus=bridge-3,addr=0x1.0 \
>   -device virtio-scsi-pci,bus=bridge-3,addr=0x2.0 \
>   -device virtio-scsi-pci,bus=bridge-3,addr=0x3.0 \
>   -device virtio-scsi-pci,bus=bridge-3,addr=0x4.0 \
>   -device virtio-scsi-pci,bus=bridge-3,addr=0x5.0 \
>   -device virtio-scsi-pci,bus=bridge-3,addr=0x6.0 \
>   -device virtio-scsi-pci,bus=bridge-3,addr=0x7.0 \
>   -device virtio-scsi-pci,bus=bridge-3,addr=0x8.0 \
>   -device virtio-scsi-pci,bus=bridge-3,addr=0x9.0 \
>   -device virtio-scsi-pci,bus=bridge-3,addr=0xa.0 \
>   -device virtio-scsi-pci,bus=bridge-3,addr=0xb.0 \
>   -device virtio-scsi-pci,bus=bridge-3,addr=0xc.0 \
>   -device virtio-scsi-pci,bus=bridge-3,addr=0xd.0 \
>   -device virtio-scsi-pci,bus=bridge-3,addr=0xe.0 \
>   -device virtio-scsi-pci,bus=bridge-3,addr=0xf.0 \
>   -device virtio-scsi-pci,bus=bridge-3,addr=0x10.0 \
>   -device virtio-scsi-pci,bus=bridge-3,addr=0x11.0 \
>   -device virtio-scsi-pci,bus=bridge-3,addr=0x12.0 \
>   -device virtio-scsi-pci,bus=bridge-3,addr=0x13.0 \
>   -device virtio-scsi-pci,bus=bridge-3,addr=0x14.0 \
>   -device virtio-scsi-pci,bus=bridge-3,addr=0x15.0 \
>   -device virtio-scsi-pci,bus=bridge-3,addr=0x16.0 \
>   -device virtio-scsi-pci,bus=bridge-3,addr=0x17.0 \
>   -device virtio-scsi-pci,bus=bridge-3,addr=0x18.0 \
>   -device virtio-scsi-pci,bus=bridge-3,addr=0x19.0 \
>   -device virtio-scsi-pci,bus=bridge-3,addr=0x1a.0 \
>   -device virtio-scsi-pci,bus=bridge-3,addr=0x1b.0 \
>   -device virtio-scsi-pci,bus=bridge-3,addr=0x1c.0 \
>   -device virtio-scsi-pci,bus=bridge-3,addr=0x1d.0 \
>   -device virtio-scsi-pci,bus=bridge-3,addr=0x1e.0 \
>   -device virtio-scsi-pci,bus=bridge-3,addr=0x1f.0 \
>
> exit 0
>
>   \
>   -device virtio-scsi-pci,bus=bridge-4,addr=0x1.0 \
>   -device virtio-scsi-pci,bus=bridge-4,addr=0x2.0 \
>   -device virtio-scsi-pci,bus=bridge-4,addr=0x3.0 \
>   -device virtio-scsi-pci,bus=bridge-4,addr=0x4.0 \
>   -device virtio-scsi-pci,bus=bridge-4,addr=0x5.0 \
>   -device virtio-scsi-pci,bus=bridge-4,addr=0x6.0 \
>   -device virtio-scsi-pci,bus=bridge-4,addr=0x7.0 \
>   -device virtio-scsi-pci,bus=bridge-4,addr=0x8.0 \
>   -device virtio-scsi-pci,bus=bridge-4,addr=0x9.0 \
>   -device virtio-scsi-pci,bus=bridge-4,addr=0xa.0 \
>   -device virtio-scsi-pci,bus=bridge-4,addr=0xb.0 \
>   -device virtio-scsi-pci,bus=bridge-4,addr=0xc.0 \
>   -device virtio-scsi-pci,bus=bridge-4,addr=0xd.0 \
>   -device virtio-scsi-pci,bus=bridge-4,addr=0xe.0 \
>   -device virtio-scsi-pci,bus=bridge-4,addr=0xf.0 \
>   -device virtio-scsi-pci,bus=bridge-4,addr=0x10.0 \
>   -device virtio-scsi-pci,bus=bridge-4,addr=0x11.0 \
>   -device virtio-scsi-pci,bus=bridge-4,addr=0x12.0 \
>   -device virtio-scsi-pci,bus=bridge-4,addr=0x13.0 \
>   -device virtio-scsi-pci,bus=bridge-4,addr=0x14.0 \
>   -device virtio-scsi-pci,bus=bridge-4,addr=0x15.0 \
>   -device virtio-scsi-pci,bus=bridge-4,addr=0x16.0 \
>   -device virtio-scsi-pci,bus=bridge-4,addr=0x17.0 \
>   -device virtio-scsi-pci,bus=bridge-4,addr=0x18.0 \
>   -device virtio-scsi-pci,bus=bridge-4,addr=0x19.0 \
>   -device virtio-scsi-pci,bus=bridge-4,addr=0x1a.0 \
>   -device virtio-scsi-pci,bus=bridge-4,addr=0x1b.0 \
>   -device virtio-scsi-pci,bus=bridge-4,addr=0x1c.0 \
>   -device virtio-scsi-pci,bus=bridge-4,addr=0x1d.0 \
>   -device virtio-scsi-pci,bus=bridge-4,addr=0x1e.0 \
>   -device virtio-scsi-pci,bus=bridge-4,addr=0x1f.0 \
>   \
>   -device virtio-scsi-pci,bus=bridge-5,addr=0x1.0 \
>   -device virtio-scsi-pci,bus=bridge-5,addr=0x2.0 \
>   -device virtio-scsi-pci,bus=bridge-5,addr=0x3.0 \
>   -device virtio-scsi-pci,bus=bridge-5,addr=0x4.0 \
>   -device virtio-scsi-pci,bus=bridge-5,addr=0x5.0 \
>   -device virtio-scsi-pci,bus=bridge-5,addr=0x6.0 \
>   -device virtio-scsi-pci,bus=bridge-5,addr=0x7.0 \
>   -device virtio-scsi-pci,bus=bridge-5,addr=0x8.0 \
>   -device virtio-scsi-pci,bus=bridge-5,addr=0x9.0 \
>   -device virtio-scsi-pci,bus=bridge-5,addr=0xa.0 \
>   -device virtio-scsi-pci,bus=bridge-5,addr=0xb.0 \
>   -device virtio-scsi-pci,bus=bridge-5,addr=0xc.0 \
>   -device virtio-scsi-pci,bus=bridge-5,addr=0xd.0 \
>   -device virtio-scsi-pci,bus=bridge-5,addr=0xe.0 \
>   -device virtio-scsi-pci,bus=bridge-5,addr=0xf.0 \
>   -device virtio-scsi-pci,bus=bridge-5,addr=0x10.0 \
>   -device virtio-scsi-pci,bus=bridge-5,addr=0x11.0 \
>   -device virtio-scsi-pci,bus=bridge-5,addr=0x12.0 \
>   -device virtio-scsi-pci,bus=bridge-5,addr=0x13.0 \
>   -device virtio-scsi-pci,bus=bridge-5,addr=0x14.0 \
>   -device virtio-scsi-pci,bus=bridge-5,addr=0x15.0 \
>   -device virtio-scsi-pci,bus=bridge-5,addr=0x16.0 \
>   -device virtio-scsi-pci,bus=bridge-5,addr=0x17.0 \
>   -device virtio-scsi-pci,bus=bridge-5,addr=0x18.0 \
>   -device virtio-scsi-pci,bus=bridge-5,addr=0x19.0 \
>   -device virtio-scsi-pci,bus=bridge-5,addr=0x1a.0
>
> exit 0
>
>   -drive id=iso,if=none,format=raw,readonly,file=/usr/share/OVMF/UefiShell.iso \
>   -device ide-cd,drive=iso,bootindex=0 \
>   \


(2) At first I did some super crude measurements, basically from VM
start to UEFI shell prompt:

- 31 devices (single PCI-PCI bridge):  14 seconds
- 46 devices (two PCI-PCI bridges):    31 seconds
- 62 devices (two PCI-PCI bridges):    64 seconds
- 93 devices (three PCI-PCI bridges): 203 seconds

The device count and runtime multipliers are, relative to the first
line:
- 31/31  = 1;     14/14  =  1
- 46/31 ~= 1.48;  31/14 ~=  2.21 (note: 1.48 * 1.48 ~= 2.19)
- 62/31  = 2;     64/14 ~=  4.57 (note: 2    * 2     = 4)
- 93/31  = 3;    203/14 ~= 14.5  (note: 3    * 3     = 9)

So the boot time seems to be a super-quadratic function of the virtio
PCI device count.


(3) Paolo told me to grab a "perf top" screenshot of when the firmware
was in one of those parts that seemed to slow down when adding more
devices.

I took several such screenshots (from different slowed-down parts, with
different device counts), and they were all close variants of the
following:

>   20.14%  qemu-system-x86_64                  [.] render_memory_region
>   17.14%  qemu-system-x86_64                  [.] subpage_register
>   10.31%  qemu-system-x86_64                  [.] int128_add
>    7.86%  qemu-system-x86_64                  [.] addrrange_end
>    7.30%  qemu-system-x86_64                  [.] int128_ge
>    4.89%  qemu-system-x86_64                  [.] int128_nz
>    3.94%  qemu-system-x86_64                  [.] phys_page_compact
>    2.73%  qemu-system-x86_64                  [.] phys_map_node_alloc

and

>   25.53%  qemu-system-x86_64                  [.] subpage_register
>   15.14%  qemu-system-x86_64                  [.] render_memory_region
>    7.99%  qemu-system-x86_64                  [.] int128_add
>    6.17%  qemu-system-x86_64                  [.] addrrange_end
>    5.61%  qemu-system-x86_64                  [.] int128_ge
>    3.94%  qemu-system-x86_64                  [.] int128_nz
>    3.82%  qemu-system-x86_64                  [.] phys_page_compact
>    2.73%  qemu-system-x86_64                  [.] phys_map_node_alloc

and

>   30.16%  qemu-system-x86_64             [.] subpage_register
>   14.44%  qemu-system-x86_64             [.] render_memory_region
>    7.92%  qemu-system-x86_64             [.] int128_add
>    6.02%  qemu-system-x86_64             [.] addrrange_end
>    5.57%  qemu-system-x86_64             [.] int128_ge
>    3.86%  qemu-system-x86_64             [.] int128_nz
>    2.20%  libc-2.17.so                   [.] __memset_sse2

(Note, this was an unoptimized, debug build of QEMU, if that matters.)

In the middle case, I even probed into the firmware (using QEMU's GDB
server), which gave me:

> #0  0x000000007fce71cd in MmioRead16 (Address=2148630532)
>     at MdePkg/Library/BaseIoLibIntrinsic/IoLib.c:154
> #1  0x000000007fce670f in PciExpressRead16 (Address=1146884)
>     at MdePkg/Library/BasePciExpressLib/PciExpressLib.c:483
> #2  0x000000007fce1faa in PciRead16 (Address=1146884)
>     at OvmfPkg/Library/DxePciLibI440FxQ35/PciLib.c:454
> #3  0x000000007fce2e0d in PciSegmentRead16 (Address=1146884)
>     at MdePkg/Library/BasePciSegmentLibPci/PciSegmentLib.c:428
> #4  0x000000007fce3068 in PciSegmentReadBuffer (StartAddress=1146884,
>     Size=2, Buffer=0x7feef8fe) at
>     MdePkg/Library/BasePciSegmentLibPci/PciSegmentLib.c:1174
> #5  0x000000007fce011b in RootBridgeIoPciAccess (This=0x7f6051c0,
>     Read=1 '\001', Width=EfiPciWidthUint16,  Address=1146884, Count=1,
>     Buffer=0x7feef8fe) at
>     MdeModulePkg/Bus/Pci/PciHostBridgeDxe/PciRootBridgeIo.c:964
> #6  0x000000007fce01a9 in RootBridgeIoPciRead (This=0x7f6051c0,
>     Width=EfiPciWidthUint16, Address=16973828, Count=1,
>     Buffer=0x7feef8fe) at
>     MdeModulePkg/Bus/Pci/PciHostBridgeDxe/PciRootBridgeIo.c:996
> #7  0x000000007ea9a8e0 in PciIoConfigRead (This=0x7f59e828,
>     Width=EfiPciIoWidthUint16, Offset=4, Count=1,  Buffer=0x7feef8fe)
>     at MdeModulePkg/Bus/Pci/PciBusDxe/PciIo.c:753
> #8  0x000000007ea93240 in PciOperateRegister (PciIoDevice=0x7f59e818,
>     Command=0, Offset=4 '\004',  Operation=3 '\003', PtrCommand=0x0)
>     at MdeModulePkg/Bus/Pci/PciBusDxe/PciCommand.c:46
> #9  0x000000007ea9bad1 in PciIoAttributes (This=0x7f59e828,
>     Operation=EfiPciIoAttributeOperationEnable,  Attributes=0,
>     Result=0x0) at MdeModulePkg/Bus/Pci/PciBusDxe/PciIo.c:1743
> #10 0x000000007ea9bb48 in PciIoAttributes (This=0x7f59c428,
>     Operation=EfiPciIoAttributeOperationEnable,  Attributes=1792,
>     Result=0x0) at MdeModulePkg/Bus/Pci/PciBusDxe/PciIo.c:1753
> #11 0x000000007eb1a98d in DetectAndPreparePlatformPciDevicePath
>     (Handle=0x7f120418, PciIo=0x7f59c428, Pci=0x7feefaa0) at
>     OvmfPkg/Library/PlatformBootManagerLib/BdsPlatform.c:834
> #12 0x000000007eb1a92e in VisitingAPciInstance (Handle=0x7f120418,
>     Instance=0x7f59c428,  Context=0x7eb1a958
>     <DetectAndPreparePlatformPciDevicePath>) at
>     OvmfPkg/Library/PlatformBootManagerLib/BdsPlatform.c:789
> #13 0x000000007eb1a894 in VisitAllInstancesOfProtocol (Id=0x7eb2dd40
>     <gEfiPciIoProtocolGuid>,  CallBackFunction=0x7eb1a8c2
>     <VisitingAPciInstance>, Context=0x7eb1a958
>     <DetectAndPreparePlatformPciDevicePath>) at
>     OvmfPkg/Library/PlatformBootManagerLib/BdsPlatform.c:748
> #14 0x000000007eb1a956 in VisitAllPciInstances
>     (CallBackFunction=0x7eb1a958
>     <DetectAndPreparePlatformPciDevicePath>) at
>     OvmfPkg/Library/PlatformBootManagerLib/BdsPlatform.c:804
> #15 0x000000007eb1ab5a in DetectAndPreparePlatformPciDevicePaths
>     (DetectVgaOnly=0 '\000') at
>     OvmfPkg/Library/PlatformBootManagerLib/BdsPlatform.c:904
> #16 0x000000007eb1abba in PlatformInitializeConsole
>     (PlatformConsole=0x7eb2e280) at
>     OvmfPkg/Library/PlatformBootManagerLib/BdsPlatform.c:938
> #17 0x000000007eb1a157 in PlatformBootManagerBeforeConsole ()
>     at OvmfPkg/Library/PlatformBootManagerLib/BdsPlatform.c:397
> #18 0x000000007eb05d20 in BdsEntry (This=0x7eb2de08)
>     at MdeModulePkg/Universal/BdsDxe/BdsEntry.c:908
> #19 0x000000007fef1263 in DxeMain (HobStart=0x7fca3018)
>     at MdeModulePkg/Core/Dxe/DxeMain/DxeMain.c:521
> #20 0x000000007fef0589 in ProcessModuleEntryPointList
>     (HobStart=0x7bf56000) at
>     Build/OvmfX64/NOOPT_GCC48/X64/MdeModulePkg/Core/Dxe/DxeMain/DEBUG/AutoGen.c:417
> #21 0x000000007fef0260 in _ModuleEntryPoint (HobStart=0x7bf56000)
>     at MdePkg/Library/DxeCoreEntryPoint/DxeCoreEntryPoint.c:54

In advance: the interesting frames are those with
"EfiPciIoAttributeOperationEnable".


(4) Two very visible slowdowns occur when (a)
"OvmfPkg/AcpiPlatformDxe/PciDecoding.c" temporarily enables, in a loop,
IO and MMIO decoding for all PCI devices that were enumerated earlier --
so that the AML generation in QEMU could take their BARs in account --,
and (b) when the (legacy) virtio driver is bound to the virtio PCI
devices.

Loop (a) consists basically purely of PCI command register massaging.

Part (b) needed a bit ^W whole lot more investigation, so I learned how
to enable edk2's built-in profiling for OVMF, added a few "perf points"
to the VirtioPciDeviceBindingStart() function in
"OvmfPkg/VirtioPciDeviceDxe/VirtioPciDevice.c", and printed the
following measurements at the UEFI shell prompt with the DP (display
perf) utility:

When booting with 31 devices:

> ==[ Cumulative ]========
> (Times in microsec.)     Cumulative   Average     Shortest    Longest
>    Name         Count     Duration    Duration    Duration    Duration
> -------------------------------------------------------------------------------
> DB:Support:      25558      137584           5           2         242
>   DB:Start:        175     7021314       40121           0     1221468
>   OpenProto         31         124           3           0           5
>  GetPciAttr         31          84           2           0           3
>    EnaPciIo         31     2671566       86179           0      102605
>    VPciInit         31        1927          62           0          72
>  InstVProto         31       12302         396           0         543

When booting with 93 devices:

> ==[ Cumulative ]========
> (Times in microsec.)     Cumulative   Average     Shortest    Longest
>    Name         Count     Duration    Duration    Duration    Duration
> -------------------------------------------------------------------------------
> DB:Support:      37214      274119           7           2         414
>   DB:Start:        423    87530041      206926           0     3730887
>   OpenProto         93         510           5           0           9
>  GetPciAttr         93         302           3           0          11
>    EnaPciIo         93    62163154      668420           0     1008274
>    VPciInit         93        6564          70           0         239
>  InstVProto         93       42478         456           0        1128

The DB:Support and DB:Start intervals are generic (they cover all other
drivers as well); they reflect the call counts and durations of when any
driver is asked to determine whether it supports a given device, and
when -- after a positive answer -- the same is asked to actually bind
the device.

The other six lines are specific actions in
VirtioPciDeviceBindingStart().

We see the following, when going from 31 to 93 virtio PCI devices:

- the call counts (less than) triple on all rows, good

- the average, shortest and longest durations remain mostly unchanged
  for the DB:Support, OpenProto, GetPciAttr, VPciInit, InstVProto rows,

- on the "EnaPciIo" row (which stands for enabling IO decoding in the
  legacy or transitional virtio device's command register), the average
  duration gets multiplied by ~7.8 (668420/86179), while the max
  duration is multiplied by ~9.8 (1008274/102605),

- the DB:Start row is similar: it includes "EnaPciIo", but it is
  smoothed by UEFI drivers that don't bind to PciIo protocol instances,

- the cumulative duration for EnaPciIo goes from ~2.7 seconds to ~62.2
  seconds (a factor of ~23.3, corresponding to three times as many
  devices bound, times the avg. EnaPciIo duration getting multiplied by
  ~7.8).


(5) After this, I turned to QEMU, and applied the following patch:

> diff --git a/hw/pci/pci.c b/hw/pci/pci.c
> index 258fbe51e2ee..a3c250483211 100644
> --- a/hw/pci/pci.c
> +++ b/hw/pci/pci.c
> @@ -1289,19 +1289,27 @@ static void pci_update_mappings(PCIDevice *d)
>              trace_pci_update_mappings_del(d, pci_bus_num(d->bus),
>                                            PCI_SLOT(d->devfn),
>                                            PCI_FUNC(d->devfn),
>                                            i, r->addr, r->size);
>              memory_region_del_subregion(r->address_space, r->memory);
> +            trace_pci_update_mappings_del_done(d, pci_bus_num(d->bus),
> +                                               PCI_SLOT(d->devfn),
> +                                               PCI_FUNC(d->devfn),
> +                                               i, r->addr, r->size);
>          }
>          r->addr = new_addr;
>          if (r->addr != PCI_BAR_UNMAPPED) {
>              trace_pci_update_mappings_add(d, pci_bus_num(d->bus),
>                                            PCI_SLOT(d->devfn),
>                                            PCI_FUNC(d->devfn),
>                                            i, r->addr, r->size);
>              memory_region_add_subregion_overlap(r->address_space,
>                                                  r->addr, r->memory, 1);
> +            trace_pci_update_mappings_add_done(d, pci_bus_num(d->bus),
> +                                               PCI_SLOT(d->devfn),
> +                                               PCI_FUNC(d->devfn),
> +                                               i, r->addr, r->size);
>          }
>      }
>
>      pci_update_vga(d);
>  }
> diff --git a/hw/pci/trace-events b/hw/pci/trace-events
> index f68c178afc2b..ffb5c473e048 100644
> --- a/hw/pci/trace-events
> +++ b/hw/pci/trace-events
> @@ -1,10 +1,12 @@
>  # See docs/devel/tracing.txt for syntax documentation.
>
>  # hw/pci/pci.c
>  pci_update_mappings_del(void *d, uint32_t bus, uint32_t slot, uint32_t func, int bar, uint64_t addr, uint64_t size) "d=%p %02x:%02x.%x %d,0x%"PRIx64"+0x%"PRIx64
>  pci_update_mappings_add(void *d, uint32_t bus, uint32_t slot, uint32_t func, int bar, uint64_t addr, uint64_t size) "d=%p %02x:%02x.%x %d,0x%"PRIx64"+0x%"PRIx64
> +pci_update_mappings_del_done(void *d, uint32_t bus, uint32_t slot, uint32_t func, int bar, uint64_t addr, uint64_t size) "d=%p %02x:%02x.%x %d,0x%"PRIx64"+0x%"PRIx64
> +pci_update_mappings_add_done(void *d, uint32_t bus, uint32_t slot, uint32_t func, int bar, uint64_t addr, uint64_t size) "d=%p %02x:%02x.%x %d,0x%"PRIx64"+0x%"PRIx64
>
>  # hw/pci/pci_host.c
>  pci_cfg_read(const char *dev, unsigned devid, unsigned fnid, unsigned offs, unsigned val) "%s %02u:%u @0x%x -> 0x%x"
>  pci_cfg_write(const char *dev, unsigned devid, unsigned fnid, unsigned offs, unsigned val) "%s %02u:%u @0x%x <- 0x%x"

(This is matched by the "-trace enable='pci_update_mappings*'" option
under (1).)

With this patch, I only tested the "93 devices" case, as the slowdown
became visible to the naked eye from the trace messages, as the firmware
enabled more and more BARs / command registers (and inversely, the
speedup was perceivable when the firmware disabled more and more BARs /
command registers).

I will attach the trace output (compressed), from the launch of the VM
to reaching the UEFI shell. It would be interesting to plot the time
differences between the add/del and matching add_done/del_done trace
points (the difference grows continuously as more and more BARs are
enabled); for now I'll quote two extremes from the BAR-enablement loop:

Lines 2311-2312:

> 13602@1502236033.130033:pci_update_mappings_add       d=0x55567cfd4620  02:01.0  0,0xa780+0x40
> 13602@1502236033.133795:pci_update_mappings_add_done  d=0x55567cfd4620  02:01.0  0,0xa780+0x40

Lines 2863-2864:

> 13602@1502236107.343233:pci_update_mappings_add       d=0x555702401bf0  04:1f.0  0,0x8000+0x40
> 13602@1502236107.751508:pci_update_mappings_add_done  d=0x555702401bf0  04:1f.0  0,0x8000+0x40

Enabling IO decoding (hence BAR 0) for the first virtio-scsi-pci device,
02:01.0, took 3.762 msecs.

Enabling IO decoding (hence BAR 0), at the end of the same firmware
loop, for the last virtio-scsi-pci device, 04:1f.0, took 408.275 msecs,
which is approx. 108 times as long. (Almost half a second -- it's
human-perceivable.)


I didn't try to follow QEMU more deeply. Hopefully this is useful for
something.

Thanks
Laszlo

--------------96ED07348D9A3F82D48ECD0E
Content-Type: application/x-xz;
 name="trace-column-t.txt.xz"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="trace-column-t.txt.xz"

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
AgAAAAAEWVo=
--------------96ED07348D9A3F82D48ECD0E--
