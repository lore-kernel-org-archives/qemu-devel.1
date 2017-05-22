Received: from eggs.gnu.org ([2001:4830:134:3::10]:51912)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <arei.gonglei@huawei.com>) id 1dChUX-0001DF-3Y
	for qemu-devel@nongnu.org; Mon, 22 May 2017 03:10:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <arei.gonglei@huawei.com>) id 1dChUR-0003cJ-UY
	for qemu-devel@nongnu.org; Mon, 22 May 2017 03:10:56 -0400
Received: from szxga03-in.huawei.com ([45.249.212.189]:3881)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <arei.gonglei@huawei.com>) id 1dChUQ-0003bn-RR
	for qemu-devel@nongnu.org; Mon, 22 May 2017 03:10:51 -0400
From: "Gonglei (Arei)" <arei.gonglei@huawei.com>
Date: Mon, 22 May 2017 07:10:36 +0000
Message-ID: <33183CC9F5247A488A2544077AF19020DA2AF6ED@DGGEMA505-MBX.china.huawei.com>
Content-Language: zh-CN
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [RFC] memory consumption of Qemu is twice as much
 as the previous version in KVM
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Gonglei (Arei)" <arei.gonglei@huawei.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>

Attaching the backtrace [call kvm_set_user_memory_region() twice]:

In the KVM side:

[3287581.559570] gonglei: vzalloc, size=3D10485760
[3287581.564108] CPU: 19 PID: 3240 Comm: qemu-system-x86 Tainted: G        =
   OE  ---- -------   3.10.0-327.44.58.25_6.x86_64 #1
[3287581.575761] Hardware name: To be filled by O.E.M. RH2288H V3/BC11HGSA0=
, BIOS 1.26 12/22/2014
[3287581.776627] Call Trace:
[3287581.779427]  [<ffffffff81643dbc>] dump_stack+0x19/0x1b
[3287581.784922]  [<ffffffffa02e70e9>] kvm_kvzalloc.part.55+0x23/0x2e [kvm]
[3287581.791803]  [<ffffffffa02a52c3>] kvm_kvzalloc+0x23/0x30 [kvm]
[3287581.797989]  [<ffffffffa02bcd02>] kvm_arch_create_memslot+0x52/0x1a0 [=
kvm]
[3287581.805213]  [<ffffffffa02a5a60>] __kvm_set_memory_region+0x790/0xa90 =
[kvm]
[3287581.812520]  [<ffffffffa02a5d8b>] kvm_set_memory_region+0x2b/0x40 [kvm=
]
[3287581.819492]  [<ffffffffa02a61f4>] kvm_vm_ioctl+0x454/0x700 [kvm]
[3287581.825850]  [<ffffffff811fd6c5>] do_vfs_ioctl+0x2e5/0x4c0
[3287581.831681]  [<ffffffff8164f633>] ? __do_page_fault+0x183/0x470
[3287581.837953]  [<ffffffff811fd941>] SyS_ioctl+0xa1/0xc0
[3287581.843329]  [<ffffffff81654149>] system_call_fastpath+0x16/0x1b

[3287588.130837] gonglei: vzalloc, size=3D10485760
[3287588.135367] CPU: 19 PID: 3240 Comm: qemu-system-x86 Tainted: G        =
   OE  ---- -------   3.10.0-327.44.58.25_6.x86_64 #1
[3287588.347737] Call Trace:
[3287588.350543]  [<ffffffff81643dbc>] dump_stack+0x19/0x1b
[3287588.359764]  [<ffffffffa02e70e9>] kvm_kvzalloc.part.55+0x23/0x2e [kvm]
[3287588.366633]  [<ffffffffa02a52c3>] kvm_kvzalloc+0x23/0x30 [kvm]
[3287588.372791]  [<ffffffffa02bcd02>] kvm_arch_create_memslot+0x52/0x1a0 [=
kvm]
[3287588.380014]  [<ffffffffa02a5a60>] __kvm_set_memory_region+0x790/0xa90 =
[kvm]
[3287588.387298]  [<ffffffffa02a5d8b>] kvm_set_memory_region+0x2b/0x40 [kvm=
]
[3287588.394261]  [<ffffffffa02a61f4>] kvm_vm_ioctl+0x454/0x700 [kvm]
[3287588.400585]  [<ffffffff811fd6c5>] do_vfs_ioctl+0x2e5/0x4c0
[3287588.406420]  [<ffffffff8164f633>] ? __do_page_fault+0x183/0x470
[3287588.412687]  [<ffffffff811fd941>] SyS_ioctl+0xa1/0xc0
[3287588.418084]  [<ffffffff81654149>] system_call_fastpath+0x16/0x1b


In the Qemu side:

gdb) bt
#0  0x00007fb4449e39ad in kvm_set_user_memory_region (kml=3D0x7fb4463da640,=
 slot=3D0x7fb4463da710)
    at /mnt/sdb/gonglei/qemu/kvm-all.c:260
#1  0x00007fb4449e4a71 in kvm_set_phys_mem (kml=3D0x7fb4463da640, section=
=3D0x7ffeec275c30, add=3Dtrue)
    at /mnt/sdb/gonglei/qemu/kvm-all.c:824
#2  0x00007fb4449e4aff in kvm_region_add (listener=3D0x7fb4463da640, sectio=
n=3D0x7ffeec275c30)
    at /mnt/sdb/gonglei/qemu/kvm-all.c:838
#3  0x00007fb4449ebc8b in address_space_update_topology_pass (as=3D0x7fb445=
3caa60 <address_space_memory>, old_view=3D0x7fb44645aec0,=20
    new_view=3D0x7fb44645ee20, adding=3Dtrue) at /mnt/sdb/gonglei/qemu/memo=
ry.c:870
#4  0x00007fb4449ebd52 in address_space_update_topology (as=3D0x7fb4453caa6=
0 <address_space_memory>)
    at /mnt/sdb/gonglei/qemu/memory.c:885
#5  0x00007fb4449ebe7e in memory_region_transaction_commit () at /mnt/sdb/g=
onglei/qemu/memory.c:925
#6  0x00007fb4449eeb9a in memory_region_update_container_subregions (subreg=
ion=3D0x7fb44645e770)
    at /mnt/sdb/gonglei/qemu/memory.c:1902
#7  0x00007fb4449eec09 in memory_region_add_subregion_common (mr=3D0x7fb446=
3c7640, offset=3D4294967296, subregion=3D0x7fb44645e770)
    at /mnt/sdb/gonglei/qemu/memory.c:1912
#8  0x00007fb4449eec4f in memory_region_add_subregion (mr=3D0x7fb4463c7640,=
 offset=3D4294967296, subregion=3D0x7fb44645e770)
    at /mnt/sdb/gonglei/qemu/memory.c:1921
#9  0x00007fb444a5c91a in pc_memory_init (pcms=3D0x7fb4463c3fc0, system_mem=
ory=3D0x7fb4463c7640, rom_memory=3D0x7fb446468d40,=20
    ram_memory=3D0x7ffeec275ee8) at /mnt/sdb/gonglei/qemu/hw/i386/pc.c:1338
#10 0x00007fb444a5ee16 in pc_init1 (machine=3D0x7fb4463c3fc0, host_type=3D0=
x7fb444e4740c "i440FX-pcihost",=20
    pci_type=3D0x7fb444e47405 "i440FX") at /mnt/sdb/gonglei/qemu/hw/i386/pc=
_piix.c:158
#11 0x00007fb444a5f8f5 in pc_init_v2_6 (machine=3D0x7fb4463c3fc0)
    at /mnt/sdb/gonglei/qemu/hw/i386/pc_piix.c:432
#12 0x00007fb444b0970b in main (argc=3D81, argv=3D0x7ffeec2763c8, envp=3D0x=
7fb445a313e0) at vl.c:4839
(gdb) p *slot
$1 =3D {start_addr =3D 4294967296, memory_size =3D 5368709120, ram =3D 0x7f=
b2f4a00000, slot =3D 1, flags =3D 0}
 (gdb) c
Continuing.

Program received signal SIGINT, Interrupt.
0x00007fb4449e39ad in kvm_set_user_memory_region (kml=3D0x7fb445429d00 <smr=
am_listener>, slot=3D0x7fb44787d2b0)
    at /mnt/sdb/gonglei/qemu/kvm-all.c:260
260         while(debug_halt);
Missing separate debuginfos, use: debuginfo-install cyrus-sasl-md5-2.1.26-1=
7.x86_64 libdb-5.3.21-17.1.x86_64
(gdb) bt
#0  0x00007fb4449e39ad in kvm_set_user_memory_region (kml=3D0x7fb445429d00 =
<smram_listener>, slot=3D0x7fb44787d2b0)
    at /mnt/sdb/gonglei/qemu/kvm-all.c:260
#1  0x00007fb4449e4a71 in kvm_set_phys_mem (kml=3D0x7fb445429d00 <smram_lis=
tener>, section=3D0x7ffeec275ed0, add=3Dtrue)
    at /mnt/sdb/gonglei/qemu/kvm-all.c:824
#2  0x00007fb4449e4aff in kvm_region_add (listener=3D0x7fb445429d00 <smram_=
listener>, section=3D0x7ffeec275ed0)
    at /mnt/sdb/gonglei/qemu/kvm-all.c:838
#3  0x00007fb4449ef9d1 in listener_add_address_space (listener=3D0x7fb44542=
9d00 <smram_listener>,=20
    as=3D0x7fb445429ba0 <smram_address_space>) at /mnt/sdb/gonglei/qemu/mem=
ory.c:2179
#4  0x00007fb4449efb65 in memory_listener_register (listener=3D0x7fb445429d=
00 <smram_listener>,=20
    filter=3D0x7fb445429ba0 <smram_address_space>) at /mnt/sdb/gonglei/qemu=
/memory.c:2208
#5  0x00007fb4449e4ef2 in kvm_memory_listener_register (s=3D0x7fb4463d95a0,=
 kml=3D0x7fb445429d00 <smram_listener>,=20
    as=3D0x7fb445429ba0 <smram_address_space>, as_id=3D1) at /mnt/sdb/gongl=
ei/qemu/kvm-all.c:950
#6  0x00007fb444add51b in register_smram_listener (n=3D0x7fb445429cd0 <smra=
m_machine_done>, unused=3D0x0)
    at /mnt/sdb/gonglei/qemu/target-i386/kvm.c:1094
#7  0x00007fb444e195f8 in notifier_list_notify (list=3D0x7fb44542bc60 <mach=
ine_init_done_notifiers>, data=3D0x0) at util/notify.c:40
#8  0x00007fb444b04f48 in qemu_run_machine_init_done_notifiers () at vl.c:2=
890
#9  0x00007fb444b09958 in main (argc=3D81, argv=3D0x7ffeec2763c8, envp=3D0x=
7fb445a313e0) at vl.c:4940
(gdb) p *slot
$2 =3D {start_addr =3D 4294967296, memory_size =3D 5368709120, ram =3D 0x7f=
b2f4a00000, slot =3D 5, flags =3D 0}

Regards,
-Gonglei


> -----Original Message-----
> From: Gonglei (Arei)
> Sent: Monday, May 22, 2017 3:05 PM
> To: 'Paolo Bonzini'
> Cc: qemu-devel@nongnu.org; kvm@vger.kernel.org
> Subject: [RFC] memory consumption of Qemu is twice as much as the previou=
s
> version in KVM
>=20
> Hi Paolo,
>=20
> I found that the latest Qemu eat 2 time memory in KVM since Qemu-2.3.0.
>=20
> Replication Steps:
>=20
> 1. I created a CentOS 7 with 4U8G using Qemu-2.3.0,
>=20
> # grep kvm_kvzalloc /proc/vmallocinfo | awk '{total+=3D$2}; END {print to=
tal}'
> 16932864
> # grep kvm_kvzalloc /proc/vmallocinfo
> 0xffffc900205c7000-0xffffc90020fc8000 10489856 kvm_kvzalloc+0x3c/0x40
> [kvm] pages=3D2560 vmalloc vpages N1=3D2560
> 0xffffc90020fc8000-0xffffc90020fce000   24576 kvm_kvzalloc+0x3c/0x40 [kvm=
]
> pages=3D5 vmalloc N1=3D5
> 0xffffc90020fce000-0xffffc90020fd4000   24576 kvm_kvzalloc+0x3c/0x40 [kvm=
]
> pages=3D5 vmalloc N1=3D5
> 0xffffc90020fd4000-0xffffc90020fd8000   16384 kvm_kvzalloc+0x3c/0x40
> [kvm] pages=3D3 vmalloc N1=3D3
> 0xffffc9002438b000-0xffffc9002498c000 6295552 kvm_kvzalloc+0x3c/0x40
> [kvm] pages=3D1536 vmalloc vpages N1=3D1536
> 0xffffc9002498c000-0xffffc90024990000   16384 kvm_kvzalloc+0x3c/0x40
> [kvm] pages=3D3 vmalloc N1=3D3
> 0xffffc90024990000-0xffffc90024994000   16384 kvm_kvzalloc+0x3c/0x40
> [kvm] pages=3D3 vmalloc N1=3D3
> 0xffffc90024994000-0xffffc90024997000   12288 kvm_kvzalloc+0x3c/0x40
> [kvm] pages=3D2 vmalloc N1=3D2
> 0xffffc90024a75000-0xffffc90024a7e000   36864 kvm_kvzalloc+0x3c/0x40
> [kvm] pages=3D8 vmalloc N1=3D8
>=20
> PS: There is only this VM in my host.
>=20
> 2. Do the same test using the latest Qemu:
>=20
> # grep kvm_kvzalloc /proc/vmallocinfo | awk '{total+=3D$2}; END {print to=
tal}'
> 33865728
> linux-PsHdkO:~ # grep kvm_kvzalloc /proc/vmallocinfo
> 0xffffc9001f181000-0xffffc9001fb82000 10489856 kvm_kvzalloc+0x25/0x30
> [kvm] pages=3D2560 vmalloc vpages N1=3D2560
> 0xffffc9001fb82000-0xffffc9001fb88000   24576 kvm_kvzalloc+0x25/0x30
> [kvm] pages=3D5 vmalloc N1=3D5
> 0xffffc9001fb88000-0xffffc9001fb8e000   24576 kvm_kvzalloc+0x25/0x30
> [kvm] pages=3D5 vmalloc N1=3D5
> 0xffffc9001fb8e000-0xffffc9001fb92000   16384 kvm_kvzalloc+0x25/0x30
> [kvm] pages=3D3 vmalloc N1=3D3
> 0xffffc90020854000-0xffffc90021255000 10489856 kvm_kvzalloc+0x25/0x30
> [kvm] pages=3D2560 vmalloc vpages N1=3D2560
> 0xffffc90021255000-0xffffc9002125b000   24576 kvm_kvzalloc+0x25/0x30
> [kvm] pages=3D5 vmalloc N1=3D5
> 0xffffc9002125b000-0xffffc90021261000   24576 kvm_kvzalloc+0x25/0x30
> [kvm] pages=3D5 vmalloc N1=3D5
> 0xffffc90021261000-0xffffc90021265000   16384 kvm_kvzalloc+0x25/0x30
> [kvm] pages=3D3 vmalloc N1=3D3
> 0xffffc9002616e000-0xffffc90026172000   16384 kvm_kvzalloc+0x25/0x30
> [kvm] pages=3D3 vmalloc N1=3D3
> 0xffffc90026172000-0xffffc90026176000   16384 kvm_kvzalloc+0x25/0x30
> [kvm] pages=3D3 vmalloc N1=3D3
> 0xffffc90026176000-0xffffc90026179000   12288 kvm_kvzalloc+0x25/0x30
> [kvm] pages=3D2 vmalloc N1=3D2
> 0xffffc900261a9000-0xffffc900261ad000   16384 kvm_kvzalloc+0x25/0x30
> [kvm] pages=3D3 vmalloc N1=3D3
> 0xffffc900261ad000-0xffffc900261b1000   16384 kvm_kvzalloc+0x25/0x30
> [kvm] pages=3D3 vmalloc N1=3D3
> 0xffffc900261b1000-0xffffc900261b4000   12288 kvm_kvzalloc+0x25/0x30
> [kvm] pages=3D2 vmalloc N1=3D2
> 0xffffc900280fe000-0xffffc900286ff000 6295552 kvm_kvzalloc+0x25/0x30 [kvm=
]
> pages=3D1536 vmalloc vpages N1=3D1536
> 0xffffc900286ff000-0xffffc90028d00000 6295552 kvm_kvzalloc+0x25/0x30 [kvm=
]
> pages=3D1536 vmalloc vpages N1=3D1536
> 0xffffc90028d87000-0xffffc90028d90000   36864 kvm_kvzalloc+0x25/0x30
> [kvm] pages=3D8 vmalloc N1=3D8
> 0xffffc90028d9c000-0xffffc90028da5000   36864 kvm_kvzalloc+0x25/0x30
> [kvm] pages=3D8 vmalloc N1=3D8
>=20
>=20
> 3. I found the first bad commit by 'git biscet'
>=20
> linux-arei:/mnt/sdb/gonglei/opensource/qemu # git bisect bad
> 6410848bec38089424d54a6a8f10d4cf77182b5d is the first bad commit
> commit 6410848bec38089424d54a6a8f10d4cf77182b5d
> Author: Paolo Bonzini <pbonzini@redhat.com>
> Date:   Thu Jun 18 18:30:16 2015 +0200
>=20
>     target-i386: register a separate KVM address space including SMRAM
> regions
>=20
>     Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
>=20
> :040000 040000 b2435d7cd0829e6416b316f1ae2856e6f7b0023d
> 1acb81aecaf50f2d313b33f2b61a24f7f0bd6f07 M      target-i386
> linux-PsHdkO:/mnt/sdb/gonglei/opensource/qemu #
>=20
>=20
> Any ideas about this change? Do we really need to trigger two times memor=
y
> region allocation?
>=20
>=20
> Thanks,
> -Gonglei
>=20
