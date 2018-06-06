Received: from eggs.gnu.org ([2001:4830:134:3::10]:60827)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <arei.gonglei@huawei.com>) id 1fQYUi-0007ru-2j
	for qemu-devel@nongnu.org; Wed, 06 Jun 2018 09:28:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <arei.gonglei@huawei.com>) id 1fQYUd-0000Aa-45
	for qemu-devel@nongnu.org; Wed, 06 Jun 2018 09:28:56 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:2329 helo=huawei.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <arei.gonglei@huawei.com>)
	id 1fQYUc-00006k-3C
	for qemu-devel@nongnu.org; Wed, 06 Jun 2018 09:28:51 -0400
From: "Gonglei (Arei)" <arei.gonglei@huawei.com>
Date: Wed, 6 Jun 2018 13:28:24 +0000
Message-ID: <33183CC9F5247A488A2544077AF19020DB00F4E4@dggeml511-mbx.china.huawei.com>
References: <7CECC2DFC21538489F72729DF5EFB4D9C1486C@DGGEMM501-MBX.china.huawei.com>
	<20180601122307.3e6ade66@redhat.com>
In-Reply-To: <20180601122307.3e6ade66@redhat.com>
Content-Language: zh-CN
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] An emulation failure occurs,
 if I hotplug vcpus immediately after the VM start
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>, xuyandong <xuyandong2@huawei.com>
Cc: "pbonzini@redhat.com" <pbonzini@redhat.com>, Zhanghailiang <zhang.zhanghailiang@huawei.com>, "wangxin (U)" <wangxinxin.wang@huawei.com>, lidonglin <lidonglin@huawei.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "Huangweidong (C)" <weidong.huang@huawei.com>

Hi Igor,

Thanks for your response firstly. :)

> -----Original Message-----
> From: Igor Mammedov [mailto:imammedo@redhat.com]
> Sent: Friday, June 01, 2018 6:23 PM
>=20
> On Fri, 1 Jun 2018 08:17:12 +0000
> xuyandong <xuyandong2@huawei.com> wrote:
>=20
> > Hi there,
> >
> > I am doing some test on qemu vcpu hotplug and I run into some trouble.
> > An emulation failure occurs and qemu prints the following msg:
> >
> > KVM internal error. Suberror: 1
> > emulation failure
> > EAX=3D00000000 EBX=3D00000000 ECX=3D00000000 EDX=3D00000600
> > ESI=3D00000000 EDI=3D00000000 EBP=3D00000000 ESP=3D0000fff8
> > EIP=3D0000ff53 EFL=3D00010082 [--S----] CPL=3D0 II=3D0 A20=3D1 SMM=3D0 =
HLT=3D0
> > ES =3D0000 00000000 0000ffff 00009300
> > CS =3Df000 000f0000 0000ffff 00009b00
> > SS =3D0000 00000000 0000ffff 00009300
> > DS =3D0000 00000000 0000ffff 00009300
> > FS =3D0000 00000000 0000ffff 00009300
> > GS =3D0000 00000000 0000ffff 00009300
> > LDT=3D0000 00000000 0000ffff 00008200
> > TR =3D0000 00000000 0000ffff 00008b00if
> > GDT=3D     00000000 0000ffff
> > IDT=3D     00000000 0000ffff
> > CR0=3D60000010 CR2=3D00000000 CR3=3D00000000 CR4=3D00000000
> > DR0=3D0000000000000000 DR1=3D0000000000000000 DR2=3D0000000000000000
> DR3=3D0000000000000000
> > DR6=3D00000000ffff0ff0 DR7=3D0000000000000400
> > EFER=3D0000000000000000
> > Code=3D31 d2 eb 04 66 83 ca ff 66 89 d0 66 5b 66 c3 66 89 d0 66 c3 <cf>=
 66 68
> 21 8a 00 00 e9 08 d7 66 56 66 53 66 83 ec 0c 66 89 c3 66 e8 ce 7b ff ff 6=
6 89 c6
> >
> > I notice that guest is still running SeabBIOS in real mode when the vcp=
u has
> just been pluged.
> > This emulation failure can be steadly reproduced if I am doing vcpu hot=
plug
> during VM launch process.
> > After some digging, I find this KVM internal error shows up because KVM
> cannot emulate some MMIO (gpa 0xfff53 ).
> >
> > So I am confused,
> > (1) does qemu support vcpu hotplug even if guest is running seabios ?
> There is no code that forbids it, and I would expect it not to trigger er=
ror
> and be NOP.
>=20
> > (2) the gpa (0xfff53) is an address of BIOS ROM section, why does kvm
> confirm it as a mmio address incorrectly?
> KVM trace and bios debug log might give more information to guess where t=
o
> look
> or even better would be to debug Seabios and find out what exactly
> goes wrong if you could do it.

This issue can't be reproduced when we opened Seabios debug log or KVM trac=
e. :(

After a few days of debugging, we found that this problem occurs every time=
 when=20
the memory region is cleared (memory_size is 0) and the VFIO device is hot-=
plugged.=20

The key function is kvm_set_user_memory_region(), I added some logs in it.

gonglei********: mem.slot: 3, mem.guest_phys_addr=3D0xc0000, mem.userspace_=
addr=3D0x7fc751e00000, mem.flags=3D0, memory_size=3D0x20000
gonglei********: mem.slot: 3, mem.guest_phys_addr=3D0xc0000, mem.userspace_=
addr=3D0x7fc751e00000, mem.flags=3D0, memory_size=3D0x0
gonglei********: mem.slot: 3, mem.guest_phys_addr=3D0xc0000, mem.userspace_=
addr=3D0x7fc343ec0000, mem.flags=3D0, memory_size=3D0x10000
gonglei********: mem.slot: 3, mem.guest_phys_addr=3D0xc0000, mem.userspace_=
addr=3D0x7fc343ec0000, mem.flags=3D0, memory_size=3D0x0
gonglei********: mem.slot: 3, mem.guest_phys_addr=3D0xc0000, mem.userspace_=
addr=3D0x7fc343ec0000, mem.flags=3D0, memory_size=3D0xbff40000
gonglei********: mem.slot: 3, mem.guest_phys_addr=3D0xc0000, mem.userspace_=
addr=3D0x7fc343ec0000, mem.flags=3D0, memory_size=3D0x0
gonglei********: mem.slot: 3, mem.guest_phys_addr=3D0xc0000, mem.userspace_=
addr=3D0x7fc343ec0000, mem.flags=3D0, memory_size=3D0xbff40000
gonglei********: mem.slot: 3, mem.guest_phys_addr=3D0xc0000, mem.userspace_=
addr=3D0x7fc343ec0000, mem.flags=3D0, memory_size=3D0x0
gonglei********: mem.slot: 3, mem.guest_phys_addr=3D0xc0000, mem.userspace_=
addr=3D0x7fc343ec0000, mem.flags=3D0, memory_size=3D0x9000

When the memory region is cleared, the KVM will tell the slot to be
invalid (which it is set to KVM_MEMSLOT_INVALID).=20

If SeaBIOS accesses this memory and cause page fault, it will find an inval=
id value according to=20
gfn (by __gfn_to_pfn_memslot), and finally it will return an invalid value,=
 and finally it will return a failure.

The function calls process is as follows in KVM:

kvm_mmu_page_fault
	tdp_page_fault
		try_async_pf
			__gfn_to_pfn_memslot
		__direct_map // return true;
	x86_emulate_instruction
		handle_emulation_failure

The function calls process is as follows in Qemu:

Breakpoint 1, kvm_set_user_memory_region (kml=3D0x564aa1e2c890, slot=3D0x56=
4aa1e2d230) at /mnt/sdb/gonglei/qemu/kvm-all.c:261
(gdb) bt
#0  kvm_set_user_memory_region (kml=3D0x564aa1e2c890, slot=3D0x564aa1e2d230=
) at /mnt/sdb/gonglei/qemu/kvm-all.c:261
#1  0x0000564a9e7e3096 in kvm_set_phys_mem (kml=3D0x564aa1e2c890, section=
=3D0x7febeb296500, add=3Dfalse) at /mnt/sdb/gonglei/qemu/kvm-all.c:887
#2  0x0000564a9e7e34c7 in kvm_region_del (listener=3D0x564aa1e2c890, sectio=
n=3D0x7febeb296500) at /mnt/sdb/gonglei/qemu/kvm-all.c:999
#3  0x0000564a9e7ea884 in address_space_update_topology_pass (as=3D0x564a9f=
2b2640 <address_space_memory>, old_view=3D0x7febdc3449c0, new_view=3D0x7feb=
dc3443c0, adding=3Dfalse)
    at /mnt/sdb/gonglei/qemu/memory.c:849
#4  0x0000564a9e7eac49 in address_space_update_topology (as=3D0x564a9f2b264=
0 <address_space_memory>) at /mnt/sdb/gonglei/qemu/memory.c:890
#5  0x0000564a9e7ead40 in memory_region_commit () at /mnt/sdb/gonglei/qemu/=
memory.c:933
#6  0x0000564a9e7eae26 in memory_region_transaction_commit () at /mnt/sdb/g=
onglei/qemu/memory.c:950
#7  0x0000564a9ea53e05 in i440fx_update_memory_mappings (d=3D0x564aa2089280=
) at hw/pci-host/piix.c:155
#8  0x0000564a9ea53ea3 in i440fx_write_config (dev=3D0x564aa2089280, addres=
s=3D88, val=3D286330880, len=3D4) at hw/pci-host/piix.c:168
#9  0x0000564a9ea63ad1 in pci_host_config_write_common (pci_dev=3D0x564aa20=
89280, addr=3D88, limit=3D256, val=3D286330880, len=3D4) at hw/pci/pci_host=
.c:66
#10 0x0000564a9ea63bf8 in pci_data_write (s=3D0x564aa2038d70, addr=3D214748=
3736, val=3D286330880, len=3D4) at hw/pci/pci_host.c:100
#11 0x0000564a9ea63d1a in pci_host_data_write (opaque=3D0x564aa2036ae0, add=
r=3D0, val=3D286330880, len=3D4) at hw/pci/pci_host.c:153
#12 0x0000564a9e7e9384 in memory_region_write_accessor (mr=3D0x564aa2036ee0=
, addr=3D0, value=3D0x7febeb2967c8, size=3D4, shift=3D0, mask=3D4294967295,=
 attrs=3D...)
    at /mnt/sdb/gonglei/qemu/memory.c:527
#13 0x0000564a9e7e958f in access_with_adjusted_size (addr=3D0, value=3D0x7f=
ebeb2967c8, size=3D4, access_size_min=3D1, access_size_max=3D4, access=3D
    0x564a9e7e92a3 <memory_region_write_accessor>, mr=3D0x564aa2036ee0, att=
rs=3D...) at /mnt/sdb/gonglei/qemu/memory.c:593
#14 0x0000564a9e7ebd00 in memory_region_dispatch_write (mr=3D0x564aa2036ee0=
, addr=3D0, data=3D286330880, size=3D4, attrs=3D...) at /mnt/sdb/gonglei/qe=
mu/memory.c:1338
#15 0x0000564a9e798cda in address_space_write_continue (as=3D0x564a9f2b2520=
 <address_space_io>, addr=3D3324, attrs=3D..., buf=3D0x7febf8170000 "", len=
=3D4, addr1=3D0, l=3D4,=20
    mr=3D0x564aa2036ee0) at /mnt/sdb/gonglei/qemu/exec.c:3167
#16 0x0000564a9e798e99 in address_space_write (as=3D0x564a9f2b2520 <address=
_space_io>, addr=3D3324, attrs=3D..., buf=3D0x7febf8170000 "", len=3D4)
    at /mnt/sdb/gonglei/qemu/exec.c:3224
#17 0x0000564a9e7991c7 in address_space_rw (as=3D0x564a9f2b2520 <address_sp=
ace_io>, addr=3D3324, attrs=3D..., buf=3D0x7febf8170000 "", len=3D4, is_wri=
te=3Dtrue)
    at /mnt/sdb/gonglei/qemu/exec.c:3326
#18 0x0000564a9e7e55f6 in kvm_handle_io (port=3D3324, attrs=3D..., data=3D0=
x7febf8170000, direction=3D1, size=3D4, count=3D1) at /mnt/sdb/gonglei/qemu=
/kvm-all.c:1995
#19 0x0000564a9e7e5c35 in kvm_cpu_exec (cpu=3D0x564aa1e63580) at /mnt/sdb/g=
onglei/qemu/kvm-all.c:2189
#20 0x0000564a9e7ccc1a in qemu_kvm_cpu_thread_fn (arg=3D0x564aa1e63580) at =
/mnt/sdb/gonglei/qemu/cpus.c:1078
#21 0x0000564a9ec4afcb in qemu_thread_start (args=3D0x564aa1e8b490) at util=
/qemu-thread-posix.c:496
#22 0x00007febf4efedc5 in start_thread () from /lib64/libpthread.so.0
#23 0x00007febf1ce079d in clone () from /lib64/libc.so.6

So, My questions are:

1) Why don't we hold kvm->slots_lock during page fault processing?

2) How do we assure that vcpus will not access the corresponding
  region when deleting an memory slot?


Thanks,
-Gonglei
