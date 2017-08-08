Received: from eggs.gnu.org ([2001:4830:134:3::10]:55301)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1dextF-0005h6-4f
	for qemu-devel@nongnu.org; Tue, 08 Aug 2017 02:21:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1dext8-0004zp-QY
	for qemu-devel@nongnu.org; Tue, 08 Aug 2017 02:21:17 -0400
Received: from indium.canonical.com ([91.189.90.7]:56941)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1dext8-0004yw-I7
	for qemu-devel@nongnu.org; Tue, 08 Aug 2017 02:21:10 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1dext7-0000F8-Mf
	for <qemu-devel@nongnu.org>; Tue, 08 Aug 2017 06:21:09 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id A7A022E8030
	for <qemu-devel@nongnu.org>; Tue,  8 Aug 2017 06:21:09 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 08 Aug 2017 06:07:42 -0000
From: Thomas Huth <1359383@bugs.launchpad.net>
Reply-To: Bug 1359383 <1359383@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20140820203003.5648.91284.malonedeb@gac.canonical.com>
Message-Id: <150217246300.8072.5713642462679255546.malone@soybean.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1359383] Re: kernel panic at smpboot.c:134 when
 rebooting qemu with multiple cores
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Triaging old bug tickets ... can you still reproduce this issue with the
latest version of QEMU and the kernel, or did the patch mentioned in
comment #2 fix it?

** Changed in: qemu
       Status: New =3D> Incomplete

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1359383

Title:
  kernel panic at smpboot.c:134 when rebooting qemu with multiple cores

Status in QEMU:
  Incomplete

Bug description:
  Hi all,

  I can reproduce this with kernel 3.14 and 3.17rc1. I suspect it is a
  qemu issue, but I'm not sure. The test case is the following script:

  qemu-system-x86_64 -machine accel=3Dkvm -pidfile /tmp/pid$$ -m 512M -smp
  8,sockets=3D8 -kernel vmlinuz -append "init=3D/sbin/reboot -f
  console=3DttyS0,115200 kgdboc=3DttyS2,115200 root=3D/dev/sda rw" -nograph=
ic
  -serial stdio -drive format=3Draw,snapshot=3Don,file=3D/var/lib/ktest/root

  Note that we pass /sbin/reboot as the init program so it just reboots
  forever. After a dozen or so iterations, I hit this:

  [    0.000000] Initializing cgroup subsys cpuset
  [    0.000000] Initializing cgroup subsys cpu
  [    0.000000] Initializing cgroup subsys cpuacct
  [    0.000000] Linux version 3.17.0-rc1-0-2014.sp (sp@vodka) (gcc version=
 4.8.2 20140120 (Red Hat 4.8.2-16) (GCC) ) #209 SMP Wed Aug 20 20:17:46 UTC=
 2014
  [    0.000000] Command line: init=3D/sbin/reboot -f console=3DttyS0,11520=
0 kgdboc=3DttyS2,115200 root=3D/dev/sda rw ktest.priority=3D9
  [    0.000000] e820: BIOS-provided physical RAM map:
  [    0.000000] BIOS-e820: [mem 0x0000000000000000-0x000000000009fbff] usa=
ble
  [    0.000000] BIOS-e820: [mem 0x000000000009fc00-0x000000000009ffff] res=
erved
  [    0.000000] BIOS-e820: [mem 0x00000000000f0000-0x00000000000fffff] res=
erved
  [    0.000000] BIOS-e820: [mem 0x0000000000100000-0x000000001fffcfff] usa=
ble
  [    0.000000] BIOS-e820: [mem 0x000000001fffd000-0x000000001fffffff] res=
erved
  [    0.000000] BIOS-e820: [mem 0x00000000feffc000-0x00000000feffffff] res=
erved
  [    0.000000] BIOS-e820: [mem 0x00000000fffc0000-0x00000000ffffffff] res=
erved
  [    0.000000] process: using polling idle threads
  [    0.000000] NX (Execute Disable) protection: active
  [    0.000000] SMBIOS 2.4 present.
  [    0.000000] Hypervisor detected: KVM
  [    0.000000] e820: last_pfn =3D 0x1fffd max_arch_pfn =3D 0x400000000
  [    0.000000] PAT not supported by CPU.
  [    0.000000] init_memory_mapping: [mem 0x00000000-0x000fffff]
  [    0.000000] init_memory_mapping: [mem 0x1fc00000-0x1fdfffff]
  [    0.000000] init_memory_mapping: [mem 0x1c000000-0x1fbfffff]
  [    0.000000] init_memory_mapping: [mem 0x00100000-0x1bffffff]
  [    0.000000] init_memory_mapping: [mem 0x1fe00000-0x1fffcfff]
  [    0.000000] ACPI: Early table checksum verification disabled
  [    0.000000] ACPI: RSDP 0x00000000000F0A90 000014 (v00 BOCHS )
  [    0.000000] ACPI: RSDT 0x000000001FFFFC21 000034 (v01 BOCHS  BXPCRSDT =
00000001 BXPC 00000001)
  [    0.000000] ACPI: FACP 0x000000001FFFEF40 000074 (v01 BOCHS  BXPCFACP =
00000001 BXPC 00000001)                                                    =
                                           =

  [    0.000000] ACPI: DSDT 0x000000001FFFDDC0 001180 (v01 BOCHS  BXPCDSDT =
00000001 BXPC 00000001)                                                    =
                                           =

  [    0.000000] ACPI: FACS 0x000000001FFFDD80 000040                      =
                                                                           =
                                           =

  [    0.000000] ACPI: SSDT 0x000000001FFFEFB4 000B85 (v01 BOCHS  BXPCSSDT =
00000001 BXPC 00000001)                                                    =
                                           =

  [    0.000000] ACPI: APIC 0x000000001FFFFB39 0000B0 (v01 BOCHS  BXPCAPIC =
00000001 BXPC 00000001)                                                    =
                                           =

  [    0.000000] ACPI: HPET 0x000000001FFFFBE9 000038 (v01 BOCHS  BXPCHPET =
00000001 BXPC 00000001)                                                    =
                                           =

  [    0.000000] No NUMA configuration found                               =
                                                                           =
                                           =

  [    0.000000] Faking a node at [mem 0x0000000000000000-0x000000001fffcff=
f]                                                                         =
                                           =

  [    0.000000] Initmem setup node 0 [mem 0x00000000-0x1fffcfff]          =
                                                                           =
                                           =

  [    0.000000]   NODE_DATA [mem 0x1fffa000-0x1fffcfff]                   =
                                                                           =
                                           =

  [    0.000000] kvm-clock: Using msrs 4b564d01 and 4b564d00               =
                                                                           =
                                           =

  [    0.000000] kvm-clock: cpu 0, msr 0:1fff9001, primary cpu clock       =
                                                                           =
                                           =

  [    0.000000] Zone ranges:                                              =
                                                                           =
                                           =

  [    0.000000]   DMA      [mem 0x00001000-0x00ffffff]
  [    0.000000]   DMA32    [mem 0x01000000-0xffffffff]
  [    0.000000]   Normal   empty
  [    0.000000] Movable zone start for each node
  [    0.000000] Early memory node ranges
  [    0.000000]   node   0: [mem 0x00001000-0x0009efff]
  [    0.000000]   node   0: [mem 0x00100000-0x1fffcfff]
  [    0.000000] ACPI: PM-Timer IO Port: 0xb008
  [    0.000000] ACPI: LAPIC (acpi_id[0x00] lapic_id[0x00] enabled)
  [    0.000000] ACPI: LAPIC (acpi_id[0x01] lapic_id[0x01] enabled)
  [    0.000000] ACPI: LAPIC (acpi_id[0x02] lapic_id[0x02] enabled)
  [    0.000000] ACPI: LAPIC (acpi_id[0x03] lapic_id[0x03] enabled)
  [    0.000000] ACPI: LAPIC (acpi_id[0x04] lapic_id[0x04] enabled)
  [    0.000000] ACPI: LAPIC (acpi_id[0x05] lapic_id[0x05] enabled)
  [    0.000000] ACPI: LAPIC (acpi_id[0x06] lapic_id[0x06] enabled)
  [    0.000000] ACPI: LAPIC (acpi_id[0x07] lapic_id[0x07] enabled)
  [    0.000000] ACPI: LAPIC_NMI (acpi_id[0xff] dfl dfl lint[0x1])
  [    0.000000] ACPI: IOAPIC (id[0x00] address[0xfec00000] gsi_base[0])
  [    0.000000] IOAPIC[0]: apic_id 0, version 17, address 0xfec00000, GSI =
0-23
  [    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
  [    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 5 global_irq 5 high level)
  [    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
  [    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 10 global_irq 10 high lev=
el)
  [    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 11 global_irq 11 high lev=
el)
  [    0.000000] Using ACPI (MADT) for SMP configuration information
  [    0.000000] ACPI: HPET id: 0x8086a201 base: 0xfed00000
  [    0.000000] smpboot: Allowing 8 CPUs, 0 hotplug CPUs
  [    0.000000] e820: [mem 0x20000000-0xfeffbfff] available for PCI devices
  [    0.000000] Booting paravirtualized kernel on KVM
  [    0.000000] setup_percpu: NR_CPUS:64 nr_cpumask_bits:64 nr_cpu_ids:8 n=
r_node_ids:1
  [    0.000000] PERCPU: Embedded 27 pages/cpu @ffff88001fc00000 s80064 r81=
92 d22336 u262144
  [    0.000000] KVM setup async PF for cpu 0
  [    0.000000] kvm-stealtime: cpu 0, msr 1fc0d000
  [    0.000000] Built 1 zonelists in Node order, mobility grouping on.  To=
tal pages: 128902
  [    0.000000] Policy zone: DMA32
  [    0.000000] Kernel command line: mlx4_core.port_type_array=3D2,2 intel=
_idle.max_cstate=3D0 processor.max_cstate=3D1 idle=3Dpoll init=3D/sbin/rebo=
ot -f console=3DttyS0,115200 kgdboc=3DttyS2,115200 root=3D/dev/sda rw ktest=
.priority=3D9
  [    0.000000] PID hash table entries: 2048 (order: 2, 16384 bytes)
  [    0.000000] Memory: 497836K/523884K available (6197K kernel code, 845K=
 rwdata, 2312K rodata, 968K init, 2676K bss, 26048K reserved)
  [    0.000000] SLUB: HWalign=3D64, Order=3D0-3, MinObjects=3D0, CPUs=3D8,=
 Nodes=3D1
  [    0.000000] Hierarchical RCU implementation.
  [    0.000000]  RCU restricting CPUs from NR_CPUS=3D64 to nr_cpu_ids=3D8.
  [    0.000000] RCU: Adjusting geometry for rcu_fanout_leaf=3D16, nr_cpu_i=
ds=3D8
  [    0.000000] NR_IRQS:4352 nr_irqs:488 0
  [    0.000000] Console: colour VGA+ 80x25
  [    0.000000] console [ttyS0] enabled
  [    0.000000] tsc: Detected 3491.912 MHz processor
  [    0.008000] Calibrating delay loop (skipped) preset value.. 6983.82 Bo=
goMIPS (lpj=3D13967648)
  [    0.008000] pid_max: default: 32768 minimum: 301
  [    0.008000] ACPI: Core revision 20140724
  [    0.008000] ACPI: All ACPI Tables successfully acquired
  [    0.008000] Security Framework initialized
  [    0.008000] Dentry cache hash table entries: 65536 (order: 7, 524288 b=
ytes)
  [    0.008000] Inode-cache hash table entries: 32768 (order: 6, 262144 by=
tes)
  [    0.008000] Mount-cache hash table entries: 1024 (order: 1, 8192 bytes)
  [    0.008000] Mountpoint-cache hash table entries: 1024 (order: 1, 8192 =
bytes)
  [    0.008106] Initializing cgroup subsys devices
  [    0.008379] Initializing cgroup subsys freezer
  [    0.008647] Initializing cgroup subsys net_cls
  [    0.008913] Initializing cgroup subsys blkio
  [    0.009169] Initializing cgroup subsys perf_event
  [    0.009486] mce: CPU supports 10 MCE banks
  [    0.009759] Last level iTLB entries: 4KB 0, 2MB 0, 4MB 0
  [    0.009759] Last level dTLB entries: 4KB 0, 2MB 0, 4MB 0, 1GB 0
  [    0.010597] Freeing SMP alternatives memory: 28K (ffffffff81dc7000 - f=
fffffff81dce000)
  [    0.013902] ..TIMER: vector=3D0x30 apic1=3D0 pin1=3D2 apic2=3D-1 pin2=
=3D-1
  [    0.014366] smpboot: CPU0: Intel QEMU Virtual CPU version 2.0.0 (fam: =
06, model: 06, stepping: 03)
  [    0.016000] Performance Events: Broken PMU hardware detected, using so=
ftware events only.
  [    0.016000] Failed to access perfctr msr (MSR c1 is 0)
  [    0.016000] NMI watchdog: disabled (cpu0): hardware events not enabled
  [    0.016000] x86: Booting SMP configuration:
  [    0.016000] .... node  #0, CPUs:      #1
  [    0.008000] kvm-clock: cpu 1, msr 0:1fff9041, secondary cpu clock
  [    0.028010] KVM setup async PF for cpu 1
  [    0.028358]  #2
  [    0.028358] kvm-stealtime: cpu 1, msr 1fc4d000
  [    0.008000] kvm-clock: cpu 2, msr 0:1fff9081, secondary cpu clock
  [    0.044008] KVM setup async PF for cpu 2
  [    0.044506]  #3
  [    0.044507] kvm-stealtime: cpu 2, msr 1fc8d000
  [    0.008000] kvm-clock: cpu 3, msr 0:1fff90c1, secondary cpu clock
  [    0.060011] KVM setup async PF for cpu 3
  [    0.060416]  #4
  [    0.060416] kvm-stealtime: cpu 3, msr 1fccd000
  [    0.008000] kvm-clock: cpu 4, msr 0:1fff9101, secondary cpu clock
  [    0.072010] KVM setup async PF for cpu 4
  [    0.072461]  #5
  [    0.072461] kvm-stealtime: cpu 4, msr 1fd0d000
  [    0.008000] kvm-clock: cpu 5, msr 0:1fff9141, secondary cpu clock
  [    0.088001] KVM setup async PF for cpu 5
  [    0.088001]  #6
  [    0.088001] kvm-stealtime: cpu 5, msr 1fd4d000
  [    0.008000] kvm-clock: cpu 6, msr 0:1fff9181, secondary cpu clock
  [    0.108008] ------------[ cut here ]------------
  [    0.108366] WARNING: CPU: 0 PID: 1 at /src/linux-bcache/kernel/workque=
ue.c:4473 workqueue_cpu_up_callback+0x36e/0x380()
  [    0.109172] Modules linked in:
  [    0.109419] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 3.17.0-rc1-0-201=
4.sp #209
  [    0.112001] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIO=
S Bochs 01/01/2011
  [    0.112606]  0000000000000009 ffff88001e927db8 ffffffff81601466 000000=
0000000000
  [    0.113208]  ffff88001e927df0 ffffffff810b4bb8 ffff88001fd92400 ffff88=
001fd92730
  [    0.113813]  ffff88001fd92708 0000000000000006 ffff88001ea92540 ffff88=
001e927e00
  [    0.114422] Call Trace:
  [    0.114616]  [<ffffffff81601466>] dump_stack+0x45/0x56
  [    0.115011]  [<ffffffff810b4bb8>] warn_slowpath_common+0x78/0xa0
  [    0.115474]  [<ffffffff810b4c95>] warn_slowpath_null+0x15/0x20
  [    0.116002]  [<ffffffff810cca2e>] workqueue_cpu_up_callback+0x36e/0x380
  [    0.116507]  [<ffffffff810d0f5c>] notifier_call_chain+0x4c/0x70
  [    0.116962]  [<ffffffff810d1059>] __raw_notifier_call_chain+0x9/0x10
  [    0.117458]  [<ffffffff810b4dee>] cpu_notify+0x1e/0x40
  [    0.117857]  [<ffffffff810b5006>] cpu_up+0x186/0x1b0
  [    0.118249]  [<ffffffff81d06272>] smp_init+0x63/0x7d
  [    0.118633]  [<ffffffff81cea12e>] kernel_init_freeable+0xe9/0x200
  [    0.119114]  [<ffffffff815f99a0>] ? rest_init+0x80/0x80
  [    0.119524]  [<ffffffff815f99a9>] kernel_init+0x9/0xf0
  [    0.120002]  [<ffffffff816077bc>] ret_from_fork+0x7c/0xb0
  [    0.120443]  [<ffffffff815f99a0>] ? rest_init+0x80/0x80
  [    0.120867] ---[ end trace bac34f2af212d79e ]---
  [    0.121255] ------------[ cut here ]------------
  [    0.121243] KVM setup async PF for cpu 6
  [    0.121243] kvm-stealtime: cpu 6, msr 1fd8d000
  [    0.122309] kernel BUG at /src/linux-bcache/kernel/smpboot.c:134!
  [    0.122799] invalid opcode: 0000 [#1] SMP
  [    0.123150] Modules linked in:
  [    0.123406] CPU: 0 PID: 36 Comm: watchdog/6 Tainted: G        W      3=
.17.0-rc1-0-2014.sp #209
  [    0.124000] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIO=
S Bochs 01/01/2011
  [    0.124000] task: ffff88001eb00000 ti: ffff88001eb08000 task.ti: ffff8=
8001eb08000
  [    0.124000] RIP: 0010:[<ffffffff810d390f>]  [<ffffffff810d390f>] smpbo=
ot_thread_fn+0x19f/0x1b0
  [    0.124000] RSP: 0000:ffff88001eb0be88  EFLAGS: 00010206
  [    0.124000] RAX: 0000000000000000 RBX: ffff88001eb00000 RCX: 000000000=
0000000
  [    0.124000] RDX: ffff88001eb0bfd8 RSI: ffff88001eb00000 RDI: 000000000=
0000006
  [    0.124000] RBP: ffff88001eb0bec8 R08: ffff88001eb08000 R09: ffff88001=
eb01a89
  [    0.124000] R10: 0000000000000010 R11: 0000000000000001 R12: ffff88001=
e801930
  [    0.124000] R13: ffffffff81c4b720 R14: ffff88001eb00000 R15: ffff88001=
eb00000
  [    0.124000] FS:  0000000000000000(0000) GS:ffff88001fc00000(0000) knlG=
S:0000000000000000
  [    0.124000] CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003b
  [    0.124000] CR2: 00000000ffffffff CR3: 0000000001c14000 CR4: 000000000=
00006f0
  [    0.124000] Stack:
  [    0.124000]  0000000000000000 ffff88001eb0bea0 ffffffff81603714 ffff88=
001e90bb00
  [    0.124000]  ffff88001e801930 ffffffff810d3770 0000000000000000 000000=
0000000000
  [    0.124000]  ffff88001eb0bf48 ffffffff810d00cd 0000000000000001 000000=
0000000006
  [    0.124000] Call Trace:
  [    0.124000]  [<ffffffff81603714>] ? schedule+0x24/0x70
  [    0.124000]  [<ffffffff810d3770>] ? SyS_setgroups+0x190/0x190
  [    0.124000]  [<ffffffff810d00cd>] kthread+0xcd/0xf0
  [    0.124000]  [<ffffffff810d0000>] ? kthread_create_on_node+0x170/0x170
  [    0.124000]  [<ffffffff816077bc>] ret_from_fork+0x7c/0xb0
  [    0.124000]  [<ffffffff810d0000>] ? kthread_create_on_node+0x170/0x170
  [    0.124000] Code: 89 fa 48 0f a3 11 19 d2 31 f6 85 d2 40 0f 95 c6 ff d=
0 4c 89 e7 e8 82 16 0f 00 48 83 c4 18 31 c0 5b 41 5c 41 5d 41 5e 41 5f 5d c=
3 <0f> 0b 0f 0b 66 66 66 66 2e 0f 1f 84 00 00 00 00 00 89 d0 55 48
  [    0.124000] RIP  [<ffffffff810d390f>] smpboot_thread_fn+0x19f/0x1b0
  [    0.124000]  RSP <ffff88001eb0be88>
  [    0.124002] ---[ end trace bac34f2af212d79f ]---
  [    0.124456] Kernel panic - not syncing: Fatal exception
  [    0.128000] Shutting down cpus with NMI
  [    0.128000] ---[ end Kernel panic - not syncing: Fatal exception

  Note there's an SMP-related warning coming out of workqueue.c right
  before the panic.

  I have attached the .config I'm using with the kernel.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1359383/+subscriptions
