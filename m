Received: from eggs.gnu.org ([2001:4830:134:3::10]:54166)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1cZJec-0001CO-PY
	for qemu-devel@nongnu.org; Thu, 02 Feb 2017 10:50:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1cZJeY-0006tX-F8
	for qemu-devel@nongnu.org; Thu, 02 Feb 2017 10:50:34 -0500
Received: from mx1.redhat.com ([209.132.183.28]:38038)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lersek@redhat.com>) id 1cZJeY-0006tF-2Y
	for qemu-devel@nongnu.org; Thu, 02 Feb 2017 10:50:30 -0500
References: <32ff6fa9-696a-f4a2-e884-3b22f91506e5@iki.fi>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <128aeca5-099c-e82b-5cc7-314c899231de@redhat.com>
Date: Thu, 2 Feb 2017 16:50:26 +0100
MIME-Version: 1.0
In-Reply-To: <32ff6fa9-696a-f4a2-e884-3b22f91506e5@iki.fi>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] KVM/QEMU on Raspberry Pi 3
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Pekka Enberg <penberg@iki.fi>
Cc: kvm@vger.kernel.org, qemu-devel@nongnu.org, Ard Biesheuvel <ard.biesheuvel@linaro.org>

Adding Ard, just in case...

I have one (half-)comment re: GICv3:

On 02/02/17 15:44, Pekka Enberg wrote:
> Hi,
>=20
> Has anyone been able to successfully run QEMU/KVM under Raspberry Pi 3?
>=20
> I have installed 64-bit Fedora 24 by Gerd Hoffmann on the hardware:
>=20
>   https://www.kraxel.org/blog/2016/04/fedora-on-raspberry-pi-updates/
>=20
> and built a VM image using virt-builder:
>=20
>   virt-builder --root-password password:root --arch aarch64 fedora-24
>=20
> I also built the latest UEFI for QEMU from sources:
>=20
>   https://wiki.linaro.org/LEG/UEFIforQEMU
>=20
> and updated to QEMU 2.8.0 from rawhide:
>=20
>   [root@fedora-rpi2 ~]# qemu-system-aarch64 -version
>   QEMU emulator version 2.8.0(qemu-2.8.0-1.fc26)
>   Copyright (c) 2003-2016 Fabrice Bellard and the QEMU Project develope=
rs
>=20
> The VM image should be fine because I=E2=80=99m able to boot to it unde=
r CPU
> emulation:
>=20
> qemu-system-aarch64 \
>           -nographic \
>           -M virt \
>           -cpu cortex-a57 \
>           -smp 1 \
>           -m 512 \
>           -bios QEMU_EFI.fd \
>           -device virtio-blk-device,drive=3Dimage -drive
> if=3Dnone,id=3Dimage,file=3Dfedora-24.img \
>           -netdev bridge,id=3Dhn0,br=3Dvirbr0 -device
> virtio-net-pci,netdev=3Dhn0,romfile=3D \
>           -device virtio-rng-pci
>=20
> However, when I enable KVM, keyboard stops working (interrupt delivery
> issue?) and Fedora boot process hangs at random places before reaching
> login:
>=20
> qemu-system-aarch64 \
>     -nographic \
>     -M virt \
>     -cpu host \
>     -enable-kvm \
>     -smp 1 \
>     -m 512 \
>     -bios QEMU_EFI.fd \
>     -device virtio-blk-device,drive=3Dimage -drive
> if=3Dnone,id=3Dimage,file=3D$IMAGE \
>     -netdev bridge,id=3Dhn0,br=3Dvirbr0 -device
> virtio-net-pci,netdev=3Dhn0,romfile=3D \
>     -device virtio-rng-pci
>=20
> EFI stub: Booting Linux Kernel...
> ConvertPages: Incompatible memory types
> EFI stub: Using DTB from configuration table
> EFI stub: Exiting boot services and installing virtual address map...
> [    0.000000] Booting Linux on physical CPU 0x0
> [    0.000000] Linux version 4.9.5-100.fc24.aarch64
> (mockbuild@aarch64-06a.arm.fedoraproject.org) (gcc version 6.3.1
> 20161221 (Red Hat 6.3.1-1) (GCC) ) #1 SMP Tue Jan 24 21:12:07 UTC 2017
> [    0.000000] Boot CPU: AArch64 Processor [410fd034]
> [    0.000000] debug: ignoring loglevel setting.
> [    0.000000] efi: Getting EFI parameters from FDT:
> [    0.000000] efi: EFI v2.60 by EDK II
> [    0.000000] efi:  SMBIOS 3.0=3D0x58710000  ACPI 2.0=3D0x589b0000
> MEMATTR=3D0x59c03218
> [    0.000000] cma: Failed to reserve 512 MiB
> [    0.000000] NUMA: No NUMA configuration found
> [    0.000000] NUMA: Faking a node at [mem
> 0x0000000000000000-0x000000005fffffff]
> [    0.000000] NUMA: Adding memblock [0x40000000 - 0x585bffff] on node =
0
> [    0.000000] NUMA: Adding memblock [0x585c0000 - 0x5861ffff] on node =
0
> [    0.000000] NUMA: Adding memblock [0x58620000 - 0x586fffff] on node =
0
> [    0.000000] NUMA: Adding memblock [0x58700000 - 0x58b6ffff] on node =
0
> [    0.000000] NUMA: Adding memblock [0x58b70000 - 0x5be3ffff] on node =
0
> [    0.000000] NUMA: Adding memblock [0x5be40000 - 0x5becffff] on node =
0
> [    0.000000] NUMA: Adding memblock [0x5bed0000 - 0x5bedffff] on node =
0
> [    0.000000] NUMA: Adding memblock [0x5bee0000 - 0x5bffffff] on node =
0
> [    0.000000] NUMA: Adding memblock [0x5c000000 - 0x5fffffff] on node =
0
> [    0.000000] NUMA: Initmem setup node 0 [mem 0x40000000-0x5fffffff]
> [    0.000000] NUMA: NODE_DATA [mem 0x5ff62680-0x5ff6ffff]
> [    0.000000] Zone ranges:
> [    0.000000]   DMA      [mem 0x0000000040000000-0x000000005fffffff]
> [    0.000000]   Normal   empty
> [    0.000000] Movable zone start for each node
> [    0.000000] Early memory node ranges
> [    0.000000]   node   0: [mem 0x0000000040000000-0x00000000585bffff]
> [    0.000000]   node   0: [mem 0x00000000585c0000-0x000000005861ffff]
> [    0.000000]   node   0: [mem 0x0000000058620000-0x00000000586fffff]
> [    0.000000]   node   0: [mem 0x0000000058700000-0x0000000058b6ffff]
> [    0.000000]   node   0: [mem 0x0000000058b70000-0x000000005be3ffff]
> [    0.000000]   node   0: [mem 0x000000005be40000-0x000000005becffff]
> [    0.000000]   node   0: [mem 0x000000005bed0000-0x000000005bedffff]
> [    0.000000]   node   0: [mem 0x000000005bee0000-0x000000005bffffff]
> [    0.000000]   node   0: [mem 0x000000005c000000-0x000000005fffffff]
> [    0.000000] Initmem setup node 0 [mem
> 0x0000000040000000-0x000000005fffffff]
> [    0.000000] On node 0 totalpages: 8192
> [    0.000000]   DMA zone: 8 pages used for memmap
> [    0.000000]   DMA zone: 0 pages reserved
> [    0.000000]   DMA zone: 8192 pages, LIFO batch:0
> [    0.000000] psci: probing for conduit method from DT.
> [    0.000000] psci: PSCIv0.2 detected in firmware.
> [    0.000000] psci: Using standard PSCI v0.2 function IDs
> [    0.000000] psci: Trusted OS migration not required
> [    0.000000] percpu: Embedded 3 pages/cpu @ffff80001ff00000 s114840
> r8192 d73576 u196608
> [    0.000000] pcpu-alloc: s114840 r8192 d73576 u196608 alloc=3D3*65536
> [    0.000000] pcpu-alloc: [0] 0
> [    0.000000] Detected VIPT I-cache on CPU0
> [    0.000000] Built 1 zonelists in Node order, mobility grouping off.
> Total pages: 8184
> [    0.000000] Policy zone: DMA
> [    0.000000] Kernel command line:
> BOOT_IMAGE=3D/vmlinuz-4.9.5-100.fc24.aarch64
> root=3DUUID=3Dd96d0229-49ed-4ef1-8866-8e7a71b378b9 ro
> earlyprintk=3Dpl011,0x9000000 ignore_loglevel no_timer_check printk.tim=
e=3D1
> rd_NO_PLYMOUTH console=3DttyAMA0 LANG=3Den_US.UTF-8
> [    0.000000] PID hash table entries: 2048 (order: -2, 16384 bytes)
> [    0.000000] Memory: 484864K/524288K available (8188K kernel code,
> 1494K rwdata, 3584K rodata, 1408K init, 1853K bss, 39424K reserved, 0K
> cma-reserved)
> [    0.000000] Virtual kernel memory layout:
> [    0.000000]     modules : 0xffff000000000000 - 0xffff000008000000   =
(
>   128 MB)
> [    0.000000]     vmalloc : 0xffff000008000000 - 0xffff7bdfffff0000
> (126847 GB)
> [    0.000000]       .text : 0xffff000008080000 - 0xffff000008880000   =
(
>  8192 KB)
> [    0.000000]     .rodata : 0xffff000008880000 - 0xffff000008c10000   =
(
>  3648 KB)
> [    0.000000]       .init : 0xffff000008c10000 - 0xffff000008d70000   =
(
>  1408 KB)
> [    0.000000]       .data : 0xffff000008d70000 - 0xffff000008ee5a00   =
(
>  1495 KB)
> [    0.000000]        .bss : 0xffff000008ee5a00 - 0xffff0000090b50c4   =
(
>  1854 KB)
> [    0.000000]     fixed   : 0xffff7fdffe7d0000 - 0xffff7fdffec00000   =
(
>  4288 KB)
> [    0.000000]     PCI I/O : 0xffff7fdffee00000 - 0xffff7fdfffe00000   =
(
>    16 MB)
> [    0.000000]     vmemmap : 0xffff7fe000000000 - 0xffff800000000000   =
(
>   128 GB maximum)
> [    0.000000]               0xffff7fe000000000 - 0xffff7fe000080000   =
(
>     0 MB actual)
> [    0.000000]     memory  : 0xffff800000000000 - 0xffff800020000000   =
(
>   512 MB)
> [    0.000000] SLUB: HWalign=3D64, Order=3D0-3, MinObjects=3D0, CPUs=3D=
1, Nodes=3D1
> [    0.000000] Hierarchical RCU implementation.
> [    0.000000]     Build-time adjustment of leaf fanout to 64.
> [    0.000000]     RCU restricting CPUs from NR_CPUS=3D256 to nr_cpu_id=
s=3D1.
> [    0.000000] RCU: Adjusting geometry for rcu_fanout_leaf=3D64, nr_cpu=
_ids=3D1
> [    0.000000] NR_IRQS:64 nr_irqs:64 0
> [    0.000000] GICv2m: range[mem 0x08020000-0x08020fff], SPI[80:143]
> [    0.000000] arm_arch_timer: WARNING: Invalid trigger for IRQ3,
> assuming level low
> [    0.000000] arm_arch_timer: WARNING: Please fix your firmware
> [    0.000000] arm_arch_timer: Architected cp15 timer(s) running at
> 19.20MHz (virt).
> [    0.000000] clocksource: arch_sys_counter: mask: 0xffffffffffffff
> max_cycles: 0x46d987e47, max_idle_ns: 440795202767 ns
> [    0.000006] sched_clock: 56 bits at 19MHz, resolution 52ns, wraps
> every 4398046511078ns
> [    0.000151] Console: colour dummy device 80x25
> [    0.000343] Calibrating delay loop (skipped), value calculated using
> timer frequency.. 38.40 BogoMIPS (lpj=3D19200)
> [    0.000358] pid_max: default: 32768 minimum: 301
> [    0.001206] Security Framework initialized
> [    0.001220] Yama: becoming mindful.
> [    0.001245] SELinux:  Initializing.
> [    0.002125] SELinux:  Starting in permissive mode
> [    0.002372] Dentry cache hash table entries: 65536 (order: 3, 524288
> bytes)
> [    0.003087] Inode-cache hash table entries: 32768 (order: 2, 262144
> bytes)
> [    0.003493] Mount-cache hash table entries: 8192 (order: 0, 65536 by=
tes)
> [    0.003509] Mountpoint-cache hash table entries: 8192 (order: 0,
> 65536 bytes)
> [    0.005370] ftrace: allocating 29479 entries in 8 pages
> [    0.099284] ASID allocator initialised with 65536 entries
> [    0.102201] Remapping and enabling EFI services.
> [    0.102381]   EFI remap 0x0000000004000000 =3D> 0000000020000000
> [    0.102393]   EFI remap 0x0000000009010000 =3D> 0000000024000000
> [    0.102403]   EFI remap 0x0000000058700000 =3D> 0000000024010000
> [    0.102412]   EFI remap 0x0000000058770000 =3D> 0000000024080000
> [    0.102421]   EFI remap 0x00000000587c0000 =3D> 00000000240d0000
> [    0.102430]   EFI remap 0x0000000058810000 =3D> 0000000024120000
> [    0.102439]   EFI remap 0x0000000058860000 =3D> 0000000024170000
> [    0.102448]   EFI remap 0x00000000588b0000 =3D> 00000000241c0000
> [    0.102457]   EFI remap 0x0000000058900000 =3D> 0000000024210000
> [    0.102466]   EFI remap 0x0000000058950000 =3D> 0000000024260000
> [    0.102475]   EFI remap 0x00000000589c0000 =3D> 00000000242b0000
> [    0.102483]   EFI remap 0x0000000058a60000 =3D> 0000000024350000
> [    0.102492]   EFI remap 0x0000000058ac0000 =3D> 00000000243b0000
> [    0.102501]   EFI remap 0x0000000058b10000 =3D> 0000000024400000
> [    0.102511]   EFI remap 0x000000005be40000 =3D> 0000000024450000
> [    0.102520]   EFI remap 0x000000005bee0000 =3D> 00000000244e0000
> [    0.102807] Brought up 1 CPUs
> [    0.102817] SMP: Total of 1 processors activated.
> [    0.102831] CPU features: detected feature: 32-bit EL0 Support
> [    0.102869] CPU: All CPU(s) started at EL1
> [    0.104821] devtmpfs: initialized
> [    0.108484] SMBIOS 3.0.0 present.
> [    0.108823] clocksource: jiffies: mask: 0xffffffff max_cycles:
> 0xffffffff, max_idle_ns: 1911260446275000 ns
> [    0.109128] atomic64_test: passed
> [    0.109218] pinctrl core: initialized pinctrl subsystem
> [    0.110804] NET: Registered protocol family 16
> [    0.112292] cpuidle: using governor menu
> [    0.112728] vdso: 2 pages (1 code @ ffff0000088a0000, 1 data @
> ffff000008d90000)
> [    0.112741] hw-breakpoint: found 6 breakpoint and 4 watchpoint
> registers.
> [    0.113255] DMA: preallocated 256 KiB pool for atomic allocations
> [    0.113829] Serial: AMBA PL011 UART driver
> [    0.124719] 9000000.pl011: ttyAMA0 at MMIO 0x9000000 (irq =3D 38,
> base_baud =3D 0) is a PL011 rev1
> [    0.441625] console [ttyAMA0] enabled
> [    0.444399] irq: type mismatch, failed to map hwirq-27 for /intc!
> [    0.459440] HugeTLB registered 2 MB page size, pre-allocated 0 pages
> [    0.462302] HugeTLB registered 512 MB page size, pre-allocated 0 pag=
es
> [    0.467261] ACPI: Interpreter disabled.
> [    0.470087] vgaarb: loaded
> [    0.472026] SCSI subsystem initialized
> [    0.474036] libata version 3.00 loaded.
> [    0.476125] usbcore: registered new interface driver usbfs
> [    0.478641] usbcore: registered new interface driver hub
> [    0.481041] usbcore: registered new device driver usb
> [    0.483753] Registered efivars operations
> [    0.487178] NetLabel: Initializing
> [    0.488699] NetLabel:  domain hash size =3D 128
> [    0.490608] NetLabel:  protocols =3D UNLABELED CIPSOv4
> [    0.492812] NetLabel:  unlabeled traffic allowed by default
> [    0.495891] clocksource: Switched to clocksource arch_sys_counter
> [    0.559085] VFS: Disk quotas dquot_6.6.0
> [    0.561229] VFS: Dquot-cache hash table entries: 8192 (order 0, 6553=
6
> bytes)
> [    0.565523] pnp: PnP ACPI: disabled
> [    0.580598] NET: Registered protocol family 2
> [    0.583862] TCP established hash table entries: 8192 (order: 0, 6553=
6
> bytes)
> [    0.587095] TCP bind hash table entries: 8192 (order: 1, 131072 byte=
s)
> [    0.590125] TCP: Hash tables configured (established 8192 bind 8192)
> [    0.592954] UDP hash table entries: 2048 (order: 0, 65536 bytes)
> [    0.598026] UDP-Lite hash table entries: 2048 (order: 0, 65536 bytes=
)
> [    0.601490] NET: Registered protocol family 1
> [    0.603485] PCI: CLS 0 bytes, default 128
> [    0.605541] Unpacking initramfs...
> [    2.004306] Freeing initrd memory: 13504K (ffff80000f810000 -
> ffff800010540000)
> [    2.008217] kvm [1]: HYP mode not available
> [    2.010350] alg: No test for __ecb-aes-neon (__driver-ecb-aes-neon)
> [    2.014394] alg: No test for __ecb-aes-neon
> (cryptd(__driver-ecb-aes-neon))
> [    2.020656] futex hash table entries: 256 (order: -1, 32768 bytes)
> [    2.023712] audit: initializing netlink subsys (disabled)
> [    2.026198] audit: type=3D2000 audit(0.000:1): initialized
> [    2.029271] Initialise system trusted keyrings
> [    2.031861] workingset: timestamp_bits=3D37 max_order=3D13 bucket_or=
der=3D0
> [    2.050744] zbud: loaded
> [    2.058467] SELinux:  Registering netfilter hooks
> [    2.327464] alg: drbg: Test 0 failed for drbg_pr_ctr_aes128
> [    2.334902] alg: drbg: Test 0 failed for drbg_nopr_ctr_aes128
> [    2.337893] alg: drbg: Test 0 failed for drbg_nopr_ctr_aes192
> [    2.340850] alg: drbg: Test 0 failed for drbg_nopr_ctr_aes256
> [    2.347452] NET: Registered protocol family 38
> [    2.349471] Key type asymmetric registered
> [    2.351274] Asymmetric key parser 'x509' registered
> [    2.353543] Block layer SCSI generic (bsg) driver version 0.4 loaded
> (major 250)
> [    2.357015] io scheduler noop registered
> [    2.358792] io scheduler deadline registered
> [    2.360823] io scheduler cfq registered (default)
> [    2.366724] pl061_gpio 9030000.pl061: PL061 GPIO chip
> @0x0000000009030000 registered
> [    2.370689] pci_hotplug: PCI Hot Plug PCI Core version: 0.5
> [    2.373129] pciehp: PCI Express Hot Plug Controller Driver version: =
0.4
> [    2.376310] OF: PCI: host bridge /pcie@10000000 ranges:
> [    2.378654] OF: PCI:    IO 0x3eff0000..0x3effffff -> 0x00000000
> [    2.381166] OF: PCI:   MEM 0x10000000..0x3efeffff -> 0x10000000
> [    2.383718] OF: PCI:   MEM 0x8000000000..0xffffffffff -> 0x800000000=
0
> [    2.386543] pci-host-generic 3f000000.pcie: ECAM at [mem
> 0x3f000000-0x3fffffff] for [bus 00-0f]
> [    2.390576] pci-host-generic 3f000000.pcie: PCI host bridge to bus
> 0000:00
> [    2.393517] pci_bus 0000:00: root bus resource [bus 00-0f]
> [    2.395889] pci_bus 0000:00: root bus resource [io  0x0000-0xffff]
> [    2.398550] pci_bus 0000:00: root bus resource [mem
> 0x10000000-0x3efeffff]
> [    2.401452] pci_bus 0000:00: root bus resource [mem
> 0x8000000000-0xffffffffff]
> [    2.404612] pci 0000:00:00.0: [1b36:0008] type 00 class 0x060000
> [    2.408173] pci 0000:00:01.0: [1af4:1000] type 00 class 0x020000
> [    2.417494] pci 0000:00:01.0: reg 0x10: [io  0x0020-0x003f]
> [    2.427875] pci 0000:00:01.0: reg 0x14: [mem 0x10000000-0x10000fff]
> [    2.452350] pci 0000:00:01.0: reg 0x20: [mem
> 0x8000000000-0x8000003fff 64bit pref]
> [    2.467039] pci 0000:00:02.0: [1af4:1005] type 00 class 0x00ff00
> [    2.476385] pci 0000:00:02.0: reg 0x10: [io  0x0000-0x001f]
> [    2.510013] pci 0000:00:02.0: reg 0x20: [mem
> 0x8000004000-0x8000007fff 64bit pref]
> [    2.523313] pci 0000:00:01.0: BAR 4: assigned [mem
> 0x8000000000-0x8000003fff 64bit pref]
> [    2.526985] pci 0000:00:02.0: BAR 4: assigned [mem
> 0x8000004000-0x8000007fff 64bit pref]
> [    2.530513] pci 0000:00:01.0: BAR 1: assigned [mem
> 0x10000000-0x10000fff]
> [    2.533400] pci 0000:00:01.0: BAR 0: assigned [io  0x1000-0x101f]
> [    2.543649] pci 0000:00:02.0: BAR 0: assigned [io  0x1020-0x103f]
> [    2.557666] Serial: 8250/16550 driver, 32 ports, IRQ sharing enabled
> [    2.572033] msm_serial: driver initialized
> [    2.575085] Unable to detect cache hierarchy from DT for CPU 0
> [    2.579549] libphy: Fixed MDIO Bus: probed
> [    2.581978] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driv=
er
> [    2.584794] ehci-pci: EHCI PCI platform driver
> [    2.586861] ohci_hcd: USB 1.1 'Open' Host Controller (OHCI) Driver
> [    2.589494] ohci-pci: OHCI PCI platform driver
> [    2.591552] uhci_hcd: USB Universal Host Controller Interface driver
> [    2.594749] usbcore: registered new interface driver usbserial
> [    2.597329] usbcore: registered new interface driver usbserial_gener=
ic
> [    2.600204] usbserial: USB Serial support registered for generic
> [    2.603205] mousedev: PS/2 mouse device common for all mice
> [    2.606996] rtc-efi rtc-efi: rtc core: registered rtc-efi as rtc0
> [    2.611264] device-mapper: uevent: version 1.0.3
> [    2.614162] device-mapper: ioctl: 4.35.0-ioctl (2016-06-23)
> initialised: dm-devel@redhat.com
> [    2.618918] EFI Variables Facility v0.08 2004-May-17
> [    2.623822] hidraw: raw HID events driver (C) Jiri Kosina
> [    2.626625] usbcore: registered new interface driver usbhid
> [    2.628992] usbhid: USB HID core driver
> [    2.631552] drop_monitor: Initializing network drop monitor service
> [    2.634540] ip_tables: (C) 2000-2006 Netfilter Core Team
> [    2.636848] Initializing XFRM netlink socket
> [    2.639958] NET: Registered protocol family 10
> [    2.643655] mip6: Mobile IPv6
> [    2.645096] NET: Registered protocol family 17
> [    2.648428] registered taskstats version 1
> [    2.650388] Loading compiled-in X.509 certificates
> [    2.653404] alg: No test for pkcs1pad(rsa,sha256)
> (pkcs1pad(rsa-generic,sha256))
> [    2.662070] Loaded X.509 cert 'Fedora kernel signing key:
> c34822b9d8433ad2ee030f319227b680e81fec51'
> [    2.666230] zswap: loaded using pool lzo/zbud
> [    2.750989] Key type big_key registered
> [    2.753524] Key type encrypted registered
> [    2.756102] rtc-efi rtc-efi: setting system clock to 2017-02-02
> 11:08:10 UTC (1486033690)
> [    2.760004] PM: Hibernation image not present or could not be loaded=
.
> [    2.763332] uart-pl011 9000000.pl011: no DMA platform data
> [    2.767390] Freeing unused kernel memory: 1408K (ffff800000c10000 -
> ffff800000d70000)
> [    2.806927] random: systemd: uninitialized urandom read (16 bytes re=
ad)
> [    2.811785] random: systemd: uninitialized urandom read (16 bytes re=
ad)
> [    2.828177] systemd[1]: systemd 229 running in system mode. (+PAM
> +AUDIT +SELINUX +IMA -APPARMOR +SMACK +SYSVINIT +UTMP +LIBCRYPTSETUP
> +GCRYPT +GNUTLS +ACL +XZ +LZ4 +SECCOMP +BLKID +ELFUTILS +KMOD +IDN)
> [    2.836321] systemd[1]: Detected virtualization kvm.
> [    2.838547] systemd[1]: Detected architecture arm64.
> [    2.840694] systemd[1]: Running in initial RAM disk.
>=20
> Welcome to Fedora 24 (Twenty Four) dracut-044-18.git20160108.fc24
> (Initramfs)!
>=20
> [    2.847481] systemd[1]: Set hostname to <localhost.localdomain>.
> [    3.121869] random: systemd: uninitialized urandom read (16 bytes re=
ad)
> [    3.124937] random: systemd: uninitialized urandom read (16 bytes re=
ad)
> [    3.127974] random: systemd: uninitialized urandom read (16 bytes re=
ad)
> [    3.131197] random: systemd: uninitialized urandom read (16 bytes re=
ad)
> [    3.137879] random: systemd: uninitialized urandom read (16 bytes re=
ad)
> [    3.142414] random: systemd: uninitialized urandom read (16 bytes re=
ad)
> [    3.147556] random: systemd: uninitialized urandom read (16 bytes re=
ad)
> [    3.151971] random: systemd: uninitialized urandom read (16 bytes re=
ad)
> [    3.180332] systemd[1]: Listening on Journal Audit Socket.
> [  OK  ] Listening on Journal Audit Socket.
> [    3.189169] systemd[1]: Created slice System Slice.
> [  OK  ] Created slice System Slice.
> [    3.194406] systemd[1]: Reached target Slices.
> [  OK  ] Reached target Slices.
> [    3.199339] systemd[1]: Listening on udev Control Socket.
> [  OK  ] Listening on udev Control Socket.
> [    3.204751] systemd[1]: Reached target Timers.
> [  OK  ] Reached target Timers.
> [  OK  ] Listening on Journal Socket (/dev/log).
> [  OK  ] Listening on udev Kernel Socket.
> [  OK  ] Reached target Swap.
> [  OK  ] Listening on Journal Socket.
>          Starting Journal Service...
>          Starting Create list of required st... nodes for the current
> kernel...
> [  OK  ] Reached target Sockets.
>          Starting Apply Kernel Variables...
>          Starting Setup Virtual Console...
> [  OK  ] Reached target Local File Systems.
> [  OK  ] Started Journal Service.
> [    3.388992] audit: type=3D1130 audit(1486033690.500:2): pid=3D1 uid=3D=
0
> auid=3D4294967295 ses=3D4294967295 subj=3Dkernel msg=3D'unit=3Dsystemd-=
journald
> comm=3D"systemd" exe=3D"/usr/lib/systemd/systemd" hostname=3D? addr=3D?
> terminal=3D? res=3Dsuccess'
> [  OK  ] Started Create list of required sta...ce nodes for the current
> kernel.
> [    3.412971] audit: type=3D1130 audit(1486033690.500:3): pid=3D1 uid=3D=
0
> auid=3D4294967295 ses=3D4294967295 subj=3Dkernel msg=3D'unit=3Dkmod-sta=
tic-nodes
> comm=3D"systemd" exe=3D"/usr/lib/systemd/systemd" hostname=3D? addr=3D?
> terminal=3D? res=3Dsuccess'
> [  OK  ] Started Apply Kernel Variables.
> [    3.472701] audit: type=3D1130 audit(1486033690.500:4): pid=3D1 uid=3D=
0
> auid=3D4294967295 ses=3D4294967295 subj=3Dkernel msg=3D'unit=3Dsystemd-=
sysctl
> comm=3D"systemd" exe=3D"/usr/lib/systemd/systemd" hostname=3D? addr=3D?
> terminal=3D? res=3Dsuccess'
>          Starting Create Static Device Nodes in /dev...
> [  OK  ] Started Create Static Device Nodes in /dev.
> [    3.993984] audit: type=3D1130 audit(1486033690.500:5): pid=3D1 uid=3D=
0
> auid=3D4294967295 ses=3D4294967295 subj=3Dkernel
> msg=3D'unit=3Dsystemd-tmpfiles-setup-dev comm=3D"systemd"
> exe=3D"/usr/lib/systemd/systemd" hostname=3D? addr=3D? terminal=3D? res=
=3Dsuccess'
>          Starting udev Kernel Device Manager...
> [  OK  ] Started udev Kernel Device Manager.
> [    4.054457] audit: type=3D1130 audit(1486033690.500:6): pid=3D1 uid=3D=
0
> auid=3D4294967295 ses=3D4294967295 subj=3Dkernel msg=3D'unit=3Dsystemd-=
udevd
> comm=3D"systemd" exe=3D"/usr/lib/systemd/systemd" hostname=3D? addr=3D?
> terminal=3D? res=3Dsuccess'
>          Starting udev Coldplug all Devices...
> [  OK  ] Started udev Coldplug all Devices.
> [    4.423317] audit: type=3D1130 audit(1486033690.500:7): pid=3D1 uid=3D=
0
> auid=3D4294967295 ses=3D4294967295 subj=3Dkernel
> msg=3D'unit=3Dsystemd-udev-trigger comm=3D"systemd"
> exe=3D"/usr/lib/systemd/systemd" hostname=3D? addr=3D? terminal=3D? res=
=3Dsuccess'
> [  OK  ] Reached target Remote File Systems (Pre).
> [  OK  ] Reached target Remote File Systems.
>          Mounting Configuration File System...
> [  OK  ] Mounted Configuration File System.
> [    4.792555] virtio-pci 0000:00:01.0: enabling device (0005 -> 0007)
> [  OK  ] Started Setup Virtual Console.
> [    4.839330] audit: type=3D1130 audit(1486033690.500:8): pid=3D1 uid=3D=
0
> auid=3D4294967295 ses=3D4294967295 subj=3Dkernel
> msg=3D'unit=3Dsystemd-vconsole-setup comm=3D"systemd"
> exe=3D"/usr/lib/systemd/systemd" hostname=3D? addr=3D? terminal=3D? res=
=3Dsuccess'
> [  OK  ] Reached target System Initialization.
>          Starting Show Plymouth Boot Screen...
> [    5.207240] virtio-pci 0000:00:02.0: enabling device (0005 -> 0007)
> [    5.290059] input: gpio-keys as /devices/platform/gpio-keys/input/in=
put0
> [    5.709339] random: fast init done
> [    5.711632] random: crng init done
> [    5.758189]  vda: vda1 vda2 vda3 vda4 < vda5 >
> [  OK  ] Found device
> /dev/disk/by-uuid/d96d0229-49ed-4ef1-8866-8e7a71b378b9.
>          Starting File System Check on
> /dev/...9-49ed-4ef1-8866-8e7a71b378b9...
> [  OK  ] Started Show Plymouth Boot Screen.
> [    6.544988] audit: type=3D1130 audit(1486033690.500:9): pid=3D1 uid=3D=
0
> auid=3D4294967295 ses=3D4294967295 subj=3Dkernel msg=3D'unit=3Dplymouth=
-start
> comm=3D"systemd" exe=3D"/usr/lib/systemd/systemd" hostname=3D? addr=3D?
> terminal=3D? res=3Dsuccess'
> [  OK  ] Started File System Check on
> /dev/d...229-49ed-4ef1-8866-8e7a71b378b9.[    6.562998] audit: type=3D1=
130
> audit(1486033690.500:10): pid=3D1 uid=3D0 auid=3D4294967295 ses=3D42949=
67295
> subj=3Dkernel msg=3D'unit=3Dsystemd-fsck-root comm=3D"systemd"
> exe=3D"/usr/lib/systemd/systemd" hostname=3D? addr=3D? terminal=3D? res=
=3Dsuccess'
>=20
>          Mounting /sysroot...
> [  OK  ] Reached target Paths.
> [  OK  ] Started Forward Password Requests to Plymouth Directory Watch.
> [  OK  ] Reached target Basic System.
> [    6.815012] SGI XFS with ACLs, security attributes, no debug enabled
> [    6.852341] XFS (vda5): Mounting V5 Filesystem
> [    6.974989] XFS (vda5): Starting recovery (logdev: internal)
> [    6.990620] XFS (vda5): Ending recovery (logdev: internal)
> [  OK  ] Mounted /sysroot.
> [  OK  ] Reached target Initrd Root File System.
>          Starting Reload Configuration from the Real Root...
> [  OK  ] Started Reload Configuration from the Real Root.
> [  OK  ] Reached target Initrd File Systems.
> [  OK  ] Reached target Initrd Default Target.
>          Starting Cleaning Up and Shutting Down Daemons...
> [  OK  ] Stopped Cleaning Up and Shutting Down Daemons.
>          Starting Plymouth switch root service...
> [  OK  ] Stopped target Remote File Systems.
> [  OK  ] Stopped target Remote File Systems (Pre).
> [  OK  ] Stopped target Initrd Default Target.
> [  OK  ] Stopped target Basic System.
> [  OK  ] Stopped target System Initialization.
> [  OK  ] Stopped Apply Kernel Variables.
> [  OK  ] Stopped udev Coldplug all Devices.
> [  OK  ] Stopped target Local File Systems.
>          Stopping udev Kernel Device Manager...
> [  OK  ] Stopped target Slices.
> [  OK  ] Stopped target Paths.
> [  OK  ] Stopped target Sockets.
> [  OK  ] Stopped target Timers.
> [  OK  ] Stopped target Swap.
> [  OK  ] Stopped udev Kernel Device Manager.
> [  OK  ] Stopped Create Static Device Nodes in /dev.
> [  OK  ] Stopped Create list of required sta...ce nodes for the current
> kernel.
> [  OK  ] Closed udev Control Socket.
> [  OK  ] Closed udev Kernel Socket.
>          Starting Cleanup udevd DB...
> [  OK  ] Started Plymouth switch root service.
> [  OK  ] Started Cleanup udevd DB.
> [  OK  ] Reached target Switch Root.
>          Starting Switch Root...
> [    8.011088] systemd-journald[133]: Received SIGTERM from PID 1
> (systemd).
> [    8.102313] systemd: 11 output lines suppressed due to ratelimiting
> [    8.249955] SELinux: 32768 avtab hash slots, 104932 rules.
> [    8.406087] SELinux: 32768 avtab hash slots, 104932 rules.
> [    8.838270] SELinux:  8 users, 14 roles, 5021 types, 304 bools, 1
> sens, 1024 cats
> [    8.841747] SELinux:  92 classes, 104932 rules
> [    8.877564] SELinux:  Permission validate_trans in class security no=
t
> defined in policy.
> [    8.881333] SELinux:  Permission module_load in class system not
> defined in policy.
> [    8.885389] SELinux:  Class cap_userns not defined in policy.
> [    8.887968] SELinux:  Class cap2_userns not defined in policy.
> [    8.890548] SELinux: the above unknown classes and permissions will
> be allowed
> [    8.893696] SELinux:  Completing initialization.
> [    8.895757] SELinux:  Setting up existing superblocks.
> [    8.965581] systemd[1]: Successfully loaded SELinux policy in 784.66=
4ms.
> [    9.322148] systemd[1]: Relabelled /dev and /run in 275.319ms.
>=20
> Welcome to Fedora 24 (Twenty Four)!
>=20
> [  OK  ] Stopped Switch Root.
> [  OK  ] Stopped Journal Service.
>          Starting Journal Service...
> [  OK  ] Reached target Encrypted Volumes.
>          Mounting Debug File System...
> [  OK  ] Created slice system-serial\x2dgetty.slice.
>          Starting Create list of required st... nodes for the current
> kernel...
> [  OK  ] Started Forward Password Requests to Wall Directory Watch.
> [  OK  ] Stopped File System Check on Root Device.
> [  OK  ] Listening on /dev/initctl Compatibility Named Pipe.
> [  OK  ] Created slice system-sshd\x2dkeygen.slice.
>          Starting Apply Kernel Variables...
> [  OK  ] Set up automount Arbitrary Executab...ats File System Automoun=
t
> Point.
> [  OK  ] Reached target Remote File Systems.
> [  OK  ] Listening on udev Control Socket.
> [  OK  ] Created slice User and Session Slice.
> [  OK  ] Listening on udev Kernel Socket.
> [  OK  ] Stopped target Switch Root.
> [  OK  ] Stopped target Initrd File Systems.
> [  OK  ] Reached target Slices.
>          Starting Remount Root and Kernel File Systems...
>          Mounting POSIX Message Queue File System...
> [  OK  ] Listening on Process Core Dump Socket.
>          Mounting Huge Pages File System...
> [  OK  ] Created slice system-systemd\x2dfsck.slice.
> [  OK  ] Stopped target Initrd Root File System.
> [  OK  ] Reached target Paths.
>          Mounting Temporary Directory...
> [  OK  ] Created slice system-getty.slice.
> [  OK  ] Mounted Debug File System.
> [  OK  ] Mounted POSIX Message Queue File System.
> [  OK  ] Mounted Huge Pages File System.
> [  OK  ] Mounted Temporary Directory.
> [  OK  ] Started Journal Service.
> [  OK  ] Started Create list of required sta...ce nodes for the current
> kernel.
> [  OK  ] Started Apply Kernel Variables.
> [  OK  ] Started Remount Root and Kernel File Systems.
>          Starting udev Coldplug all Devices...
>          Starting Configure read-only root support...
>          Starting Create Static Device Nodes in /dev...
>          Starting Flush Journal to Persistent Storage...
> [   10.815758] systemd-journald[260]: Received request to flush runtime
> journal from PID 1
> [  OK  ] Started Create Static Device Nodes in /dev.
>          Starting udev Kernel Device Manager...
> [  OK  ] Reached target Local File Systems (Pre).
> [  OK  ] Started udev Coldplug all Devices.
> [  OK  ] Started Configure read-only root support.
>          Starting Load/Save Random Seed...
> [  OK  ] Started Load/Save Random Seed.
> [  OK  ] Started udev Kernel Device Manager.
> [   11.967825] systemd-journald[260]: File
> /var/log/journal/ee127fef6e6044e7a6c6d6a0b5bc46e5/system.journal
> corrupted or uncleanly shut down, renaming and replacing.
> [  OK  ] Found device /dev/ttyAMA0.
> [   12.618561] physmap_of_versatile: module license 'unspecified' taint=
s
> kernel.
> [   12.621748] Disabling lock debugging due to kernel taint
> [   12.624644] physmap_of_versatile: Unknown symbol regmap_write (err 0=
)
> [   12.627547] physmap_of_versatile: Unknown symbol
> syscon_node_to_regmap (err 0)
> [   12.630664] physmap_of_versatile: Unknown symbol
> regmap_update_bits_base (err 0)
> [  OK  ] Found device /dev/disk/by-uuid/53B5-4DD4.
>          Starting File System Check on /dev/disk/by-uuid/53B5-4DD4...
> [  OK  ] Found device
> /dev/disk/by-uuid/74425a5b-7a60-4f2d-9390-10669f2e2ba5.
> [  OK  ] Found device
> /dev/disk/by-uuid/9526d4b7-baa6-4ea5-8234-37d44a6ce772.
>          Activating swap
> /dev/disk/by-uuid/9...7-baa6-4ea5-8234-37d44a6ce772...
>          Starting File System Check on
> /dev/...b-7a60-4f2d-9390-10669f2e2ba5...
> [  OK  ] Started Flush Journal to Persistent Storage.
> [   13.572059] Adding 629696k swap on /dev/vda3.  Priority:-1 extents:1
> across:629696k FS
> [  OK  ] Activated swap
> /dev/disk/by-uuid/9526d4b7-baa6-4ea5-8234-37d44a6ce772.
> [  OK  ] Reached target Swap.
> [  OK  ] Started File System Check on /dev/disk/by-uuid/53B5-4DD4.
> [   14.464393] virtio_net virtio0 enp0s1: renamed from eth0
> [  OK  ] Started File System Check on
> /dev/d...a5b-7a60-4f2d-9390-10669f2e2ba5.
>          Mounting /boot...
> [   18.478569] EXT4-fs (vda2): mounted filesystem with ordered data
> mode. Opts: (null)
> [  OK  ] Mounted /boot.
>          Mounting /boot/efi...
> [  OK  ] Mounted /boot/efi.
> [  OK  ] Reached target Local File Systems.
>          Starting Restore /run/initramfs on shutdown...
>          Starting Tell Plymouth To Write Out Runtime Data...
>          Starting Create Volatile Files and Directories...
> [  OK  ] Started Restore /run/initramfs on shutdown.
> [  OK  ] Started Tell Plymouth To Write Out Runtime Data.
> [  OK  ] Started Create Volatile Files and Directories.
>          Starting Security Auditing Service...
> [  OK  ] Started Security Auditing Service.
>          Starting Update UTMP about System Boot/Shutdown...
> [  OK  ] Started Update UTMP about System Boot/Shutdown.
> [  OK  ] Reached target System Initialization.
> [  OK  ] Started dnf makecache timer.
> [  OK  ] Listening on D-Bus System Message Bus Socket.
> [  OK  ] Reached target Sockets.
> [  OK  ] Reached target Basic System.
>          Starting NTP client/server...
>          Starting Login Service...
>          Starting Permit User Sessions...
> [  OK  ] Started D-Bus System Message Bus.
>          Starting firewalld - dynamic firewall daemon...
> [  OK  ] Reached target sshd-keygen.target.
> [  OK  ] Started Daily Cleanup of Temporary Directories.
> [  OK  ] Reached target Timers.
> [  OK  ] Started Permit User Sessions.
> [  OK  ] Started NTP client/server.
> [  OK  ] Started Login Service.
> [  OK  ] Started Command Scheduler.
>          Starting Wait for Plymouth Boot Screen to Quit...
>          Starting Terminate Plymouth Boot Screen...
> [   30.618574] ip6_tables: (C) 2000-2006 Netfilter Core Team
> [   31.481359] Ebtables v2.0 registered
> [   32.378644] nf_conntrack version 0.5.0 (8192 buckets, 32768 max)
> [   33.297541] bridge: filtering via arp/ip/ip6tables is no longer
> available by default. Update your scripts to load br_netfilter if you
> need this.
> [   33.454977] Netfilter messages via NETLINK v0.30.
> [   33.492966] ip_set: protocol 6
>=20
> The QEMU process is blocked on ppoll():
>=20
> [root@fedora-rpi2 ~]# strace -f -p $(pidof qemu-system-aarch64)
> strace: Process 7116 attached with 4 threads
> [pid  7127] rt_sigtimedwait([BUS USR1],  <unfinished ...>
> [pid  7118] rt_sigtimedwait([BUS ALRM IO], NULL, NULL, 8 <unfinished ..=
.>
> [pid  7127] <... rt_sigtimedwait resumed> 0x7fb25cc1d8, {tv_sec=3D0,
> tv_nsec=3D0}, 8) =3D -1 EAGAIN (Resource temporarily unavailable)
> [pid  7117] futex(0x555d899c60, FUTEX_WAIT, 4294967295, NULL <unfinishe=
d
> ...>
> [pid  7127] rt_sigpending([], 8)        =3D 0
> [pid  7127] ioctl(15, _IOC(0, 0xae, 0x80, 0x00) <unfinished ...>
> [pid  7116] ppoll([{fd=3D0, events=3DPOLLIN}, {fd=3D4, events=3DPOLLIN}=
, {fd=3D7,
> events=3DPOLLIN}, {fd=3D9, events=3DPOLLIN}, {fd=3D10, events=3DPOLLIN}=
, {fd=3D17,
> events=3DPOLLIN}, {fd=3D18, events=3DPOLLIN}], 7, NULL, NULL, 8
>=20
> but kvm_stats indicate that the guest is causing VM exits to happen:
>=20
> [root@fedora-rpi2 ~]# kvm_stat -d -l
> exits hvc_exit_stat mmio_exit_kernel mmio_exit_user wfe_exit_stat
> wfi_exit_stat
>     209953          0          0          0          0     209879
>     210512          0          0          0          0     210403
>     210709          0          0          0          0     210626
>     210701          0          0          0          0     210583
>     210726          0          0          0          0     210624
>     210675          0          0          0          0     210570
>     210704          0          0          0          0     210595
>     210690          0          0          0          0     210594
>     210712          0          0          0          0     210605
>     210696          0          0          0          0     210597
>=20
> I also tried to enable GIC v3 by adding the =E2=80=9C-machine gic-versi=
on=3D3=E2=80=9D
> command one option but the UEFI firmware doesn=E2=80=99t like that:

The Linaro Wiki page you referenced states,

    Note that if your [emulated] hardware has a GICv3, it is essential
    that your host device tree correctly identifies the GIC as a v3, or
    KVM will kick it into a mode that is incompatible with the GICv3
    handling in UEFI running inside the guest.

Are you sure that the Raspberry Pi 3's DTB (or ACPI tables, whatever)
identify the host (i.e., physical) GIC as v3? (I know zero details about
this, it just caught my eye as a possibly related gotcha.)

Thanks
Laszlo


>=20
> Found GIC v3 (re)distributor @ 0x8000000 (0x80A0000)
>=20
>=20
> Synchronous Exception at 0x000000005BD5B820
> PC 0x00005BD5B820 (0x00005BD58000+0x00003820) [ 0] ArmGicDxe.dll
> PC 0x00005BD5BC38 (0x00005BD58000+0x00003C38) [ 0] ArmGicDxe.dll
> PC 0x00005BD593B0 (0x00005BD58000+0x000013B0) [ 0] ArmGicDxe.dll
> PC 0x00005BD590A0 (0x00005BD58000+0x000010A0) [ 0] ArmGicDxe.dll
> PC 0x00005EF1ADF4 (0x00005EF14000+0x00006DF4) [ 1] DxeCore.dll
> PC 0x00005EF32B0C (0x00005EF14000+0x0001EB0C) [ 1] DxeCore.dll
> PC 0x00005EF165E4 (0x00005EF14000+0x000025E4) [ 1] DxeCore.dll
> PC 0x00005EF15828 (0x00005EF14000+0x00001828) [ 1] DxeCore.dll
> PC 0x00005EF15024 (0x00005EF14000+0x00001024) [ 1] DxeCore.dll
>=20
> [ 0]
> /home/penberg/raspberrypi/uefi/edk2/Build/ArmVirtQemu-AARCH64/DEBUG_GCC=
5/AARCH64/ArmPkg/Drivers/ArmGic/ArmGicDxe/DEBUG/ArmGicDxe.dll
>=20
> [ 1]
> /home/penberg/raspberrypi/uefi/edk2/Build/ArmVirtQemu-AARCH64/DEBUG_GCC=
5/AARCH64/MdeModulePkg/Core/Dxe/DxeMain/DEBUG/DxeCore.dll
>=20
>=20
>   X0 0x0000000000000036   X1 0x0000000000000004   X2 0x0000000000000036
>   X3 0x0000000000000000
>   X4 0x0000000000000001   X5 0x0000000000000000   X6 0x0A01191513061C12
>   X7 0x121C06131519010A
>   X8 0x00000000041ECB83   X9 0x0000000700000000  X10 0x0000000058B60000
>  X11 0x0000000000000004
>  X12 0x0000000000000001  X13 0x0000000000000008  X14 0x0000000000000000
>  X15 0x0000000000000000
>  X16 0x000000005EF13DF0  X17 0x0000000000000000  X18 0x0000000000000000
>  X19 0x000000004007C268
>  X20 0x0000000000000000  X21 0x0000000000000000  X22 0x0000000000000000
>  X23 0x0000000000000000
>  X24 0x0000000000000000  X25 0x0000000000000000  X26 0x0000000000000000
>  X27 0x0000000000000000
>  X28 0x0000000000000000   FP 0x000000005EF13D20   LR 0x000000005BD5BC38
>=20
>   V0 0xAFAFAFAFAFAFAFAF AFAFAFAFAFAFAFAF   V1 0x0000000000000000
> 0000000000000000
>   V2 0x0000000000000000 0000000000000000   V3 0x0000000000000000
> 0000000000000000
>   V4 0x0000000000000000 0000000000000000   V5 0x0000000000000000
> 0000000000000000
>   V6 0x0000000000000000 0000000000000000   V7 0x0000000000000000
> 0000000000000000
>   V8 0x0000000000000000 0000000000000000   V9 0x0000000000000000
> 0000000000000000
>  V10 0x0000000000000000 0000000000000000  V11 0x0000000000000000
> 0000000000000000
>  V12 0x0000000000000000 0000000000000000  V13 0x0000000000000000
> 0000000000000000
>  V14 0x0000000000000000 0000000000000000  V15 0x0000000000000000
> 0000000000000000
>  V16 0x0000000000000000 0000000000000000  V17 0x0000000000000000
> 0000000000000000
>  V18 0x0000000000000000 0000000000000000  V19 0x0000000000000000
> 0000000000000000
>  V20 0x0000000000000000 0000000000000000  V21 0x0000000000000000
> 0000000000000000
>  V22 0x0000000000000000 0000000000000000  V23 0x0000000000000000
> 0000000000000000
>  V24 0x0000000000000000 0000000000000000  V25 0x0000000000000000
> 0000000000000000
>  V26 0x0000000000000000 0000000000000000  V27 0x0000000000000000
> 0000000000000000
>  V28 0x0000000000000000 0000000000000000  V29 0x0000000000000000
> 0000000000000000
>  V30 0x0000000000000000 0000000000000000  V31 0x0000000000000000
> 0000000000000000
>=20
>   SP 0x000000005EF13D20  ELR 0x000000005BD5B820  SPSR 0x80000205  FPSR
> 0x00000000
>  ESR 0x02000000          FAR 0x1DE7EC7EDBADC0DE
>=20
>  ESR : EC 0x00  IL 0x1  ISS 0x00000000
>=20
> Stack dump:
>   000005EF13C20: 0000000000000000 0000000000000000 0000000000000000
> 0000000000000000
>   000005EF13C40: 0000000000000000 0000000000000000 0000000000000000
> 0000000000000000
>   000005EF13C60: 0000000000000000 0000000000000000 0000000000000000
> 0000000000000000
>   000005EF13C80: 0000000000000000 0000000000000000 0000000000000000
> 0000000000000000
>   000005EF13CA0: 0000000000000000 0000000000000000 0000000000000000
> 0000000000000000
>   000005EF13CC0: 0000000000000000 0000000000000000 0000000000000000
> 0000000000000000
>   000005EF13CE0: 0000000000000000 0000000000000000 000000005BD5B820
> 0000000080000205
>   000005EF13D00: 0000000000000000 0000000002000000 1DE7EC7EDBADC0DE
> 121C06131519010A
>> 000005EF13D20: 000000005EF13D90 000000005BD593B0 0000000000000002
> 0000000000000002
>   000005EF13D40: 0000002000000027 000000005FFC1524 000000005BE2F000
> 000000005BD59234
>   000005EF13D60: 0000000000000000 00000000080A0000 0000000008000000
> 0000000000000000
>   000005EF13D80: 0000000000000003 000000005AD10B18 000000005EF13DC0
> 000000005BD590A0
>   000005EF13DA0: 000000005BFF0018 000000005AD10B18 000000005EF13DF0
> 0000000000000000
>   000005EF13DC0: 000000005EF13DF0 000000005EF1ADF4 000000005BFF0018
> 000000005AD10B18
>   000005EF13DE0: 000000005EF13DF0 000000005AD10818 000000005EF13E70
> 000000005EF32B0C
>   000005EF13E00: 000000005EF13E30 0000000000000000 0000000000000000
> 000000005AD10B18
> ASSERT [ArmCpuDxe]
> /home/penberg/raspberrypi/uefi/edk2/ArmPkg/Library/DefaultExceptionHand=
lerLib/AArch64/DefaultExceptionHandler.c(265):
> ((BOOLEAN)(0=3D=3D1))
>=20
> Regards,
>=20
> - Pekka
>=20
