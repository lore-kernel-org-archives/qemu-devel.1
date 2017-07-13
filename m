Received: from eggs.gnu.org ([2001:4830:134:3::10]:56038)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1dVZNx-000477-FT
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 04:22:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1dVZNs-0001ZG-FX
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 04:22:09 -0400
Received: from 18.mo7.mail-out.ovh.net ([188.165.56.163]:35488)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1dVZNs-0001Yd-5A
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 04:22:04 -0400
Received: from player788.ha.ovh.net (b6.ovh.net [213.186.33.56])
	by mo7.mail-out.ovh.net (Postfix) with ESMTP id BBE5762109
	for <qemu-devel@nongnu.org>; Thu, 13 Jul 2017 10:22:01 +0200 (CEST)
References: <20170608063608.17855-1-nikunj@linux.vnet.ibm.com>
	<20170609020141.GB26521@umbus.fritz.box>
	<87mv9heota.fsf@abhimanyu.i-did-not-set--mail-host-address--so-tickle-me>
	<20170609102714.GK26521@umbus.fritz.box>
	<87eftlar4a.fsf@abhimanyu.i-did-not-set--mail-host-address--so-tickle-me>
	<1ec762f9-d8b2-5195-1ffe-f4cde35571fd@kaod.org>
	<b54ec156-725d-d954-1d05-ade845caa2a2@kaod.org>
	<878tjsbwj4.fsf@abhimanyu.i-did-not-set--mail-host-address--so-tickle-me>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <5fa5cb00-ee28-0ba4-2084-b0a43b8429f1@kaod.org>
Date: Thu, 13 Jul 2017 10:21:51 +0200
MIME-Version: 1.0
In-Reply-To: <878tjsbwj4.fsf@abhimanyu.i-did-not-set--mail-host-address--so-tickle-me>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [Qemu-ppc] [PATCH RFC] spapr: ignore interrupts
 during reset state
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>, David Gibson <david@gibson.dropbear.id.au>
Cc: alex.bennee@linaro.org, bharata@linux.vnet.ibm.com, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, rth@twiddle.net

On 07/13/2017 09:55 AM, Nikunj A Dadhania wrote:
> C=C3=A9dric Le Goater <clg@kaod.org> writes:
>=20
>>>> How about the following, we do not report work until MSR_EE is disab=
led:
>>>
>>> With this fix, I could test the XIVE<->XICS transitions at reboot=20
>>> under TCG. However, the second boot is very slow for some reason.=20
>>
>> hmm, I am not sure this is related but I just got :=20
>=20
> Havent seen in my setup after around 10 reboot cycles, I was using 2
> cores pseries setup. Lets give it some more testing. When did this
> happen, during boot ?

yes.=20

I could not reproduce either :/ but I am keeping the patch. qemu runs
with :

-m 2G -M pseries -accel tcg,thread=3Dmulti -cpu POWER9 -smp cores=3D4,max=
cpus=3D8 -realtime mlock=3Doff -kernel ./vmlinux-4.12.0+ -initrd ./initrd=
.img-4.12.0+ -append 'console=3Dhvc0 dyndbg=3D"file arch/powerpc/sysdev/x=
ive/* +p"' -nographic -nodefaults -serial mon:stdio -snapshot  -d guest_e=
rrors,unimp -no-shutdown

For the records, here is what I have kept from the issue.

Thanks,

C.=20

Booting from memory...
OF stdout device is: /vdevice/vty@71000000
Preparing to boot Linux version 4.12.0+ (legoater@vm2) (gcc version 6.3.0=
 20170406 (Ubuntu 6.3.0-12ubuntu2) ) #10 SMP Wed Jul 12 17:09:12 BST 2017
Detected machine type: 0000000000000101
command line: console=3Dhvc0 dyndbg=3D"file arch/powerpc/sysdev/xive/* +p=
"
Max number of cores passed to firmware: 2048 (NR_CPUS =3D 2048)
Calling ibm,client-architecture-support... done
memory layout at init:
  memory_limit : 0000000000000000 (16 MB aligned)
  alloc_bottom : 0000000001c10000
  alloc_top    : 0000000030000000
  alloc_top_hi : 0000000080000000
  rmo_top      : 0000000030000000
  ram_top      : 0000000080000000
instantiating rtas at 0x000000002fff0000...Unimplemented SPAPR hcall 0x00=
0000000000f003
 done
prom_hold_cpus: skipped
copying OF device tree...
Building dt strings...
Building dt structure...
Device tree strings 0x0000000002220000 -> 0x00000000022209f1
Device tree struct  0x0000000002230000 -> 0x0000000002240000
Quiescing Open Firmware ...
Booting Linux via __start() @ 0x0000000000400000 ...
[    0.000000] bootconsole [udbg0] enabled
 -> early_setup(), dt_ptr: 0x2210000
[    0.000000] Allocated 2359296 bytes for 2048 pacas at c00000000fdc0000
[    0.000000] Page sizes from device-tree:
[    0.000000] Page size shift =3D 12 AP=3D0x0
[    0.000000] Page size shift =3D 16 AP=3D0x5
[    0.000000] Page size shift =3D 21 AP=3D0x1
[    0.000000] Page size shift =3D 30 AP=3D0x2
[    0.000000]  -> fw_vec5_feature_init()
[    0.000000]  <- fw_vec5_feature_init()
[    0.000000]  -> fw_hypertas_feature_init()
[    0.000000]  <- fw_hypertas_feature_init()
[    0.000000] Using radix MMU under hypervisor
[    0.000000] Mapped range 0x0 - 0x80000000 with 0x40000000
[    0.000000] Process table c00000007f000000 and radix root for kernel: =
c000000001500000
 <- early_setup()
[    0.000000] Linux version 4.12.0+ (legoater@vm2) (gcc version 6.3.0 20=
170406 (Ubuntu 6.3.0-12ubuntu2) ) #10 SMP Wed Jul 12 17:09:12 BST 2017
 -> initialize_cache_info()
 <- initialize_cache_info()
[    0.000000] Found initrd at 0xc000000001c10000:0xc000000002153423
[    0.000000] Machine is LPAR !
[    0.000000]  -> pseries_init()
[    0.000000]  -> fw_cmo_feature_init()
[    0.000000] CMO not available
[    0.000000]  <- fw_cmo_feature_init()
[    0.000000]  <- pseries_init()
[    0.000000] Using pSeries machine description
[    0.000000] Partition configured for 8 cpus.
[    0.000000] CPU maps initialized for 1 thread per core
[    0.000000]  (thread shift is 0)
[    0.000000] Freed 2293760 bytes for unused pacas
 -> smp_release_cpus()
spinning_secondaries =3D 3
 <- smp_release_cpus()
[    0.000000] -----------------------------------------------------
[    0.000000] ppc64_pft_size    =3D 0x0
[    0.000000] phys_mem_size     =3D 0x80000000
[    0.000000] dcache_bsize      =3D 0x80
[    0.000000] icache_bsize      =3D 0x80
[    0.000000] cpu_features      =3D 0x075c7a7c18500249
[    0.000000]   possible        =3D 0x5fffffff18500649
[    0.000000]   always          =3D 0x0000000018100040
[    0.000000] cpu_user_features =3D 0xdc0065c2 0xaee00000
[    0.000000] mmu_features      =3D 0x3c006041
[    0.000000] firmware_features =3D 0x00000001405a445f
[    0.000000] -----------------------------------------------------
[    0.000000] numa:   NODE_DATA [mem 0x7ffeb280-0x7fff4f7f]
[    0.000000]  -> smp_init_pSeries()
[    0.000000]  <- smp_init_pSeries()
[    0.000000] PCI host bridge /pci@800000020000000  ranges:
[    0.000000]   IO 0x0000200000000000..0x000020000000ffff -> 0x000000000=
0000000
[    0.000000]  MEM 0x0000200080000000..0x00002000ffffffff -> 0x000000008=
0000000=20
[    0.000000]  MEM 0x0000210000000000..0x000021ffffffffff -> 0x000021000=
0000000=20
[    0.000000] PPC64 nvram contains 65536 bytes
[    0.000000] Top of RAM: 0x80000000, Total RAM: 0x80000000
[    0.000000] Memory hole size: 0MB
[    0.000000] Zone ranges:
[    0.000000]   DMA      [mem 0x0000000000000000-0x000000007fffffff]
[    0.000000]   DMA32    empty
[    0.000000]   Normal   empty
[    0.000000] Movable zone start for each node
[    0.000000] Early memory node ranges
[    0.000000]   node   0: [mem 0x0000000000000000-0x000000007fffffff]
[    0.000000] Initmem setup node 0 [mem 0x0000000000000000-0x000000007ff=
fffff]
[    0.000000] On node 0 totalpages: 32768
[    0.000000]   DMA zone: 32 pages used for memmap
[    0.000000]   DMA zone: 0 pages reserved
[    0.000000]   DMA zone: 32768 pages, LIFO batch:1
[    0.000000] percpu: Embedded 4 pages/cpu @c00000007fb90000 s160408 r0 =
d101736 u262144
[    0.000000] pcpu-alloc: s160408 r0 d101736 u262144 alloc=3D4*65536
[    0.000000] pcpu-alloc: [0] 0 [0] 1 [0] 2 [0] 3 [0] 4 [0] 5 [0] 6 [0] =
7=20
[    0.000000] Built 1 zonelists in Node order, mobility grouping on.  To=
tal pages: 32736
[    0.000000] Policy zone: DMA
[    0.000000] Kernel command line: console=3Dhvc0 dyndbg=3D"file arch/po=
werpc/sysdev/xive/* +p"
[    0.000000] PID hash table entries: 4096 (order: -1, 32768 bytes)
[    0.000000] Memory: 1987200K/2097152K available (11712K kernel code, 2=
048K rwdata, 3240K rodata, 4480K init, 3023K bss, 109952K reserved, 0K cm=
a-reserved)
[    0.000000] SLUB: HWalign=3D128, Order=3D0-3, MinObjects=3D0, CPUs=3D8=
, Nodes=3D1
[    0.000000] ftrace: allocating 32106 entries in 12 pages
[    0.000000] Hierarchical RCU implementation.
[    0.000000] 	RCU restricting CPUs from NR_CPUS=3D2048 to nr_cpu_ids=3D=
8.
[    0.000000] RCU: Adjusting geometry for rcu_fanout_leaf=3D16, nr_cpu_i=
ds=3D8
[    0.000000] NR_IRQS:512 nr_irqs:512 16
[    0.000000] xive: Using LISN range [ 16 - 23 ]
[    0.000000] xive: Interrupt handling intialized with spapr backend
[    0.000000] xive: Using priority 7 for all interrupts
[    0.000000] xive: Using 64kB queues
[    0.000000] time_init: decrementer frequency =3D 512.000000 MHz
[    0.000000] time_init: processor frequency   =3D 1000.000000 MHz
[    0.000087] time_init: 32 bit decrementer (max: 7fffffff)
[    0.000373] clocksource: timebase: mask: 0xffffffffffffffff max_cycles=
: 0x761537d007, max_idle_ns: 440795202126 ns
[    0.000801] clocksource: timebase mult[1f40000] shift[24] registered
[    0.001095] clockevent: decrementer mult[83126e98] shift[32] cpu[0]
[    0.005111] Console: colour dummy device 80x25
[    0.005700] console [hvc0] enabled
[    0.005700] console [hvc0] enabled
[    0.008285] bootconsole [udbg0] disabled
[    0.008285] bootconsole [udbg0] disabled
[    0.009577] pid_max: default: 32768 minimum: 301
[    0.010949] Security Framework initialized
[    0.011082] Yama: becoming mindful.
[    0.014936] AppArmor: AppArmor initialized
[    0.017147] Dentry cache hash table entries: 262144 (order: 5, 2097152=
 bytes)
[    0.019998] Inode-cache hash table entries: 131072 (order: 4, 1048576 =
bytes)
[    0.021575] Mount-cache hash table entries: 8192 (order: 0, 65536 byte=
s)
[    0.021693] Mountpoint-cache hash table entries: 8192 (order: 0, 65536=
 bytes)
[    0.048330] EEH: pSeries platform initialized
[    0.048609] POWER9 performance monitor hardware support registered
[    0.060806] smp: Bringing up secondary CPUs ...
[    0.063527] xive: Setting up IPI for CPU 1
[    0.065294] xive: (Old HW value: 00000000)
[    0.065484] xive: (New HW value: 00000000)
[    0.081162] xive: Setting up IPI for CPU 2
[    0.081396] xive: (Old HW value: 00000000)
[    0.081422] xive: (New HW value: 00000000)
[    0.083437] xive: Setting up IPI for CPU 3
[    0.083641] xive: (Old HW value: 00000000)
[    0.083665] xive: (New HW value: 00000000)
[    0.084250] smp: Brought up 1 node, 4 CPUs
[    0.086147] numa: Node 0 CPUs: 0-3
[    0.109093] devtmpfs: initialized
[    0.283454] evm: security.selinux
[    0.283546] evm: security.SMACK64
[    0.283574] evm: security.SMACK64EXEC
[    0.283589] evm: security.SMACK64TRANSMUTE
[    0.283603] evm: security.SMACK64MMAP
[    0.283628] evm: security.ima
[    0.283657] evm: security.capability
[    0.287822] clocksource: jiffies: mask: 0xffffffff max_cycles: 0xfffff=
fff, max_idle_ns: 7645041785100000 ns
[    0.288050] futex hash table entries: 2048 (order: 2, 262144 bytes)
[    0.299826] NET: Registered protocol family 16
[    0.302008] EEH: No capable adapters found
[    0.307382] cpuidle: using governor ladder
[    0.307619] cpuidle: using governor menu
[    0.308590] RTAS daemon started
[    0.309846] pstore: using zlib compression
[    0.310090] pstore: Registered nvram as persistent store backend
Linux ppc64le
#10 SMP Wed Jul [    0.310803] rtas_msi: Registering RTAS MSI callbacks.
[    0.325984] PCI: Probing PCI hardware
[    0.326906] no ibm,pcie-link-speed-stats property
[    0.327970] PCI host bridge to bus 0000:00
[    0.328452] pci_bus 0000:00: root bus resource [io  0x10000-0x1ffff] (=
bus address [0x0000-0xffff])
[    0.328560] pci_bus 0000:00: root bus resource [mem 0x200080000000-0x2=
000ffffffff] (bus address [0x80000000-0xffffffff])
[    0.328605] pci_bus 0000:00: root bus resource [mem 0x210000000000-0x2=
1ffffffffff]
[    0.328841] pci_bus 0000:00: root bus resource [bus 00-ff]
[    0.329047] pci_dma_bus_setup_pSeriesLP: setting up bus /pci@800000020=
000000
[    0.329184]   parent is /pci@800000020000000, iommu_table: 0x         =
 (null)
[    0.332961] IOMMU table initialized, virtual merging enabled
[    0.333386]   created table: c00000007a1f5d00
[    0.334156] PCI: Probing PCI hardware done
[    0.356170] HugeTLB registered 2 MB page size, pre-allocated 0 pages
[    0.368261] vgaarb: loaded
[    0.372292] SCSI subsystem initialized
[    0.373666] libata version 3.00 loaded.
[    0.374758] usbcore: registered new interface driver usbfs
[    0.375090] usbcore: registered new interface driver hub
[    0.375558] usbcore: registered new device driver usb
[    0.376035] pps_core: LinuxPPS API ver. 1 registered
[    0.376069] pps_core: Software ver. 5.3.6 - Copyright 2005-2007 Rodolf=
o Giometti <giometti@linux.it>
[    0.376160] PTP clock support registered
[    0.377285] EDAC MC: Ver: 3.0.0
[    0.385365] NetLabel: Initializing
[    0.385434] NetLabel:  domain hash size =3D 128
[    0.385475] NetLabel:  protocols =3D UNLABELED CIPSOv4 CALIPSO
[    0.387076] NetLabel:  unlabeled traffic allowed by default
[   28.311559] NMI watchdog: BUG: soft lockup - CPU#0 stuck for 23s! [mig=
ration/0:10]
[   28.311856] Modules linked in:
[   28.312058] CPU: 0 PID: 10 Comm: migration/0 Not tainted 4.12.0+ #10
[   28.312165] task: c00000007a842c00 task.stack: c00000007a12c000
[   28.312214] NIP: c0000000001bf6b0 LR: c0000000001bf788 CTR: c000000000=
1bf5b0
[   28.312253] REGS: c00000007a12f9d0 TRAP: 0901   Not tainted  (4.12.0+)
[   28.312284] MSR: 8000000002009033 <SF,VEC,EE,ME,IR,DR,RI,LE>
[   28.312399]   CR: 20004202  XER: 20040000
[   28.312457] CFAR: c0000000001bf6c4 SOFTE: 1=20
[   28.312457] GPR00: c0000000001bf9c8 c00000007a12fc50 c00000000147f000 =
0000000000000000=20
[   28.312457] GPR04: 0000000000000000 0000000000000000 0000000000000000 =
0000000000000000=20
[   28.312457] GPR08: 0000000000000000 0000000000000001 0000000000000001 =
000000000000002b=20
[   28.312457] GPR12: 0000000000000000 c00000000fdc0000=20
[   28.313029] NIP [c0000000001bf6b0] multi_cpu_stop+0x100/0x1f0
[   28.313074] LR [c0000000001bf788] multi_cpu_stop+0x1d8/0x1f0
[   28.313136] Call Trace:
[   28.313334] [c00000007a12fc50] [c00000007a12fd30] 0xc00000007a12fd30 (=
unreliable)
[   28.313428] [c00000007a12fca0] [c0000000001bf9c8] cpu_stopper_thread+0=
xd8/0x220
[   28.313480] [c00000007a12fd60] [c000000000113c10] smpboot_thread_fn+0x=
290/0x2a0
[   28.313571] [c00000007a12fdc0] [c00000000010dc04] kthread+0x164/0x1b0
[   28.313640] [c00000007a12fe30] [c00000000000b268] ret_from_kernel_thre=
ad+0x5c/0x74
[   28.313742] Instruction dump:
[   28.313924] 2fa90000 409e001c 813d0020 815d0010 39290001 915e0000 7c20=
04ac 913d0020=20
[   28.314001] 2b9f0004 419e003c 7fe9fb78 7c210b78 <7c421378> 83fd0020 7f=
89f840 409eff94=20
[   28.331638] NMI watchdog: BUG: soft lockup - CPU#1 stuck for 23s! [mig=
ration/1:15]
[   28.331724] Modules linked in:
[   28.331834] CPU: 1 PID: 15 Comm: migration/1 Tainted: G             L =
 4.12.0+ #10
[   28.331885] task: c00000007a858c00 task.stack: c00000007a15c000
[   28.331924] NIP: c0000000001bf6b0 LR: c0000000001bf788 CTR: c000000000=
1bf5b0
[   28.331965] REGS: c00000007a15f9d0 TRAP: 0901   Tainted: G            =
 L   (4.12.0+)
[   28.332004] MSR: 8000000000009033 <SF,EE,ME,IR,DR,RI,LE>
[   28.332053]   CR: 20002202  XER: 20040000
[   28.332102] CFAR: c0000000001bf6c4 SOFTE: 1=20
[   28.332102] GPR00: c0000000001bf9c8 c00000007a15fc50 c00000000147f000 =
0000000000000000=20
[   28.332102] GPR04: 0000000000000000 0000000000000000 0000000000000000 =
0000000000000000=20
[   28.332102] GPR08: 0000000000000000 0000000000000001 0000000000000000 =
00000000ffffffff=20
[   28.332102] GPR12: 0000000000000000 c00000000fdc0480=20
[   28.332323] NIP [c0000000001bf6b0] multi_cpu_stop+0x100/0x1f0
[   28.332356] LR [c0000000001bf788] multi_cpu_stop+0x1d8/0x1f0
[   28.332383] Call Trace:
[   28.332411] [c00000007a15fc50] [c00000007a15fd30] 0xc00000007a15fd30 (=
unreliable)
[   28.332456] [c00000007a15fca0] [c0000000001bf9c8] cpu_stopper_thread+0=
xd8/0x220
[   28.332498] [c00000007a15fd60] [c000000000113c10] smpboot_thread_fn+0x=
290/0x2a0
[   28.332538] [c00000007a15fdc0] [c00000000010dc04] kthread+0x164/0x1b0
[   28.332590] [c00000007a15fe30] [c00000000000b268] ret_from_kernel_thre=
ad+0x5c/0x74
[   28.332649] Instruction dump:
[   28.332692] 2fa90000 409e001c 813d0020 815d0010 39290001 915e0000 7c20=
04ac 913d0020=20
[   28.332765] 2b9f0004 419e003c 7fe9fb78 7c210b78 <7c421378> 83fd0020 7f=
89f840 409eff94=20
[   28.339692] NMI watchdog: BUG: soft lockup - CPU#2 stuck for 23s! [mig=
ration/2:21]
[   28.339769] Modules linked in:
[   28.339821] CPU: 2 PID: 21 Comm: migration/2 Tainted: G             L =
 4.12.0+ #10
[   28.339866] task: c00000007a8c8400 task.stack: c00000007a174000
[   28.339904] NIP: c0000000001bf6b4 LR: c0000000001bf788 CTR: c000000000=
1bf5b0
[   28.339947] REGS: c00000007a1779d0 TRAP: 0901   Tainted: G            =
 L   (4.12.0+)
[   28.339976] MSR: 8000000000009033 <SF,EE,ME,IR,DR,RI,LE>
[   28.340022]   CR: 20002202  XER: 20040000
[   28.340065] CFAR: c0000000001bf6c4 SOFTE: 1=20
[   28.340065] GPR00: c0000000001bf9c8 c00000007a177c50 c00000000147f000 =
0000000000000000=20
[   28.340065] GPR04: 0000000000000000 0000000000000000 0000000000000000 =
0000000000000000=20
[   28.340065] GPR08: 0000000000000000 0000000000000001 0000000000000000 =
0000000000000400=20
[   28.340065] GPR12: 0000000000000000 c00000000fdc0900=20
[   28.340299] NIP [c0000000001bf6b4] multi_cpu_stop+0x104/0x1f0
[   28.340332] LR [c0000000001bf788] multi_cpu_stop+0x1d8/0x1f0
[   28.340359] Call Trace:
[   28.340391] [c00000007a177c50] [c00000007a177d30] 0xc00000007a177d30 (=
unreliable)
[   28.340450] [c00000007a177ca0] [c0000000001bf9c8] cpu_stopper_thread+0=
xd8/0x220
[   28.340501] [c00000007a177d60] [c000000000113c10] smpboot_thread_fn+0x=
290/0x2a0
[   28.340554] [c00000007a177dc0] [c00000000010dc04] kthread+0x164/0x1b0
[   28.340601] [c00000007a177e30] [c00000000000b268] ret_from_kernel_thre=
ad+0x5c/0x74
[   28.340664] Instruction dump:
[   28.340705] 409e001c 813d0020 815d0010 39290001 915e0000 7c2004ac 913d=
0020 2b9f0004=20
[   28.340780] 419e003c 7fe9fb78 7c210b78 7c421378 <83fd0020> 7f89f840 40=
9eff94 2b890001=20
QEMU 2.9.50 monitor - type 'help' for more information
(qemu) info cpus
* CPU #0: nip=3D0xc0000000001bf6b0 thread_id=3D1580
  CPU #1: nip=3D0xc0000000001bf6b0 thread_id=3D1581
  CPU #2: nip=3D0xc0000000001bf6b0 thread_id=3D1582
  CPU #3: nip=3D0xc000000000004500 (halted) thread_id=3D1583
