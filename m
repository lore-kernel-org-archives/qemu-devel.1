Received: from eggs.gnu.org ([2001:4830:134:3::10]:35760)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1cPXxB-0002rB-N5
	for qemu-devel@nongnu.org; Fri, 06 Jan 2017 12:05:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1cPXx8-000466-EM
	for qemu-devel@nongnu.org; Fri, 06 Jan 2017 12:05:21 -0500
Received: from chuckie.co.uk ([82.165.15.123]:52158
	helo=s16892447.onlinehome-server.info)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mark.cave-ayland@ilande.co.uk>)
	id 1cPXx7-00042l-VE
	for qemu-devel@nongnu.org; Fri, 06 Jan 2017 12:05:18 -0500
References: <bd0ad06c-1dce-03c9-73b0-d8d6e4ca333b@roeck-us.net>
	<4b04ec32-b647-5047-7830-269cfc217550@ilande.co.uk>
	<3bee832c-1d2a-50a2-a763-c58ab34caf08@roeck-us.net>
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Message-ID: <3a90611b-a7c4-31c4-b373-3a16ddae5f4c@ilande.co.uk>
Date: Fri, 6 Jan 2017 17:04:58 +0000
MIME-Version: 1.0
In-Reply-To: <3bee832c-1d2a-50a2-a763-c58ab34caf08@roeck-us.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] Problems with qemu "modern" virtio on sparc64
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Guenter Roeck <linux@roeck-us.net>, "qemu-devel@nongnu.org >> QEMU Developers" <qemu-devel@nongnu.org>
Cc: "Michael S. Tsirkin" <mst@redhat.com>

On 30/12/16 19:57, Guenter Roeck wrote:

> On 12/30/2016 10:18 AM, Mark Cave-Ayland wrote:
>> On 25/11/16 18:11, Guenter Roeck wrote:
>>
>>> Hi,
>>>
>>> I am using virtio on sparc64 for my Linux kernel runtime tests.
>>>
>>> Starting with qemu v2.7, I noticed that the kernel either gets stuck or
>>> crashes.
>>> After adding some debug information to the kernel, I found that the
>>> problem happens
>>> in vp_reset().
>>>
>>> Interestingly, when running v4.9-rc6 without modification, the kernel
>>> crashes on me.
>>> If I add pr_info just before and after the vp_iowrite8() in
>>> virtio_pci_modern.c:vp_reset(),
>>> the kernel gets stuck in the vp_iowrite8().
>>>
>>> Here is the relevant part of the crash:
>>>
>>> [    3.151167] Unable to handle kernel NULL pointer dereference
>>> [    3.151809] tsk->{mm,active_mm}->context = 0000000000000000
>>> [    3.152430] tsk->{mm,active_mm}->pgd = fffff80000402000
>>> [    3.153032]               \|/ ____ \|/
>>> [    3.153032]               "@'/ .. \`@"
>>> [    3.153032]               /_| \__/ |_\
>>> [    3.153032]                  \__U_/
>>> [    3.154042] swapper(1): Oops [#1]
>>> [    3.154773] CPU: 0 PID: 1 Comm: swapper Not tainted 4.9.0-rc5+ #4
>>> [    3.155375] task: fffff8001f0af620 task.stack: fffff8001f0b0000
>>> [    3.155958] TSTATE: 0000009980001606 TPC: 00000000006edf44 TNPC:
>>> 00000000006edf48 Y: 00000000    Not tainted
>>> [    3.156901] TPC: <vp_reset+0x4/0x40>
>>>
>>> None of the pointers used in vp_reset() is NULL. As mentioned above,
>>> adding a pr_info
>>> just before vp_iowrite8() makes the crash disappear and the kernel is
>>> stuck instead.
>>> Here is how it looks like:
>>>
>>> [    3.104243] Hi there
>>> [   26.912509] NMI watchdog: BUG: soft lockup - CPU#0 stuck for 23s!
>>> [swapper:1]
>>> [   26.913102] Modules linked in:
>>> [   26.914061] CPU: 0 PID: 1 Comm: swapper Not tainted 4.9.0-rc5+ #5
>>> [   26.914633] task: fffff8001f0af620 task.stack: fffff8001f0b0000
>>> [   26.915156] TSTATE: 0000004480001605 TPC: 00000000006edf50 TNPC:
>>> 00000000006edf54 Y: 00000412    Not tainted
>>> [   26.915954] TPC: <vp_reset+0x10/0x60>
>>>
>>> Another pr_info() after vp_iowrite8() is never printed, suggesting that
>>> the code never
>>> gets to that point.
>>>
>>> The kernel configuration is sparc64_defconfig with the following
>>> configuration
>>> options enabled.
>>>
>>> CONFIG_DEVTMPFS=y
>>> CONFIG_VIRTIO=y
>>> CONFIG_VIRTIO_PCI=y
>>> CONFIG_VIRTIO_BLK=y
>>> CONFIG_VIRTIO_NET=y
>>> CONFIG_VIRTIO_BALLOON=y
>>> CONFIG_VIRTIO_CONSOLE=y
>>> CONFIG_SCSI_VIRTIO=y
>>>
>>> Command line is
>>>
>>> qemu-system-sparc64 -M sun4u -cpu "TI UltraSparc IIi" -m 512 \
>>>     -drive file=simple-root-filesystem-sparc.ext3,if=virtio,format=raw \
>>>     -kernel arch/sparc/boot/image -no-reboot \
>>>     -append "root=/dev/vda init=/sbin/init.sh console=ttyS0" \
>>>     -nographic -monitor none
>>>
>>> Does anyone have an idea what might be wrong ?
>>>
>>> Thanks,
>>> Guenter
>>
>> Hi Guenter,
>>
>> Have you been able to investigate this issue any further? Does the 2.8
>> release solve the issue for you?
>>
> 
> I did not make any progress, and reverted to qemu v2.6.
> 
> Problem is still seen with v2.8 (release); it crashes. The recent virtio
> related patch does not make a difference. v2.7.1 also still crashes.
> Only difference with both versions is the crash traceback.

I can recreate a similar crash here, and it seems to be caused by using
virtio with legacy mode disabled (note that I'm testing a virtio patch
for OpenBIOS which explains the different command line):

$ ./qemu-system-sparc64 \
-drive
file=debian-9.0-sparc64-NETINST1.iso,if=none,index=0,id=cd,media=cdrom \
-device virtio-blk-pci,drive=cd \
-nographic \
-bios openbios-builtin.elf.nostrip \
-m 256

[    0.000000] PROMLIB: Sun IEEE Boot Prom 'OBP 3.10.24 1999/01/01 01:01'
[    0.000000] PROMLIB: Root node compatible: sun4u
[    0.000000] Initializing cgroup subsys cpuset
[    0.000000] Initializing cgroup subsys cpu
[    0.000000] Initializing cgroup subsys cpuacct
[    0.000000] Linux version 4.3.0-1-sparc64
(debian-kernel@lists.debian.org) (gcc version 4.9.3 (Debian 4.9.3-10) )
#1 Debian 4.3.3-2 (2015-12-17)
[    0.000000] bootconsole [earlyprom0] enabled
[    0.000000] ARCH: SUN4U

(lots cut)

[   14.971631] Unpacking initramfs...
[   15.662728] Freeing initrd memory: 8296K (fffff80004400000 -
fffff80004c1a000)
[   15.667565] futex hash table entries: 256 (order: -1, 6144 bytes)
[   15.668290] audit: initializing netlink subsys (disabled)
[   15.669175] audit: type=2000 audit(1.116:1): initialized
[   15.673590] HugeTLB registered 8 MB page size, pre-allocated 0 pages
[   15.674040] zbud: loaded
[   15.676552] VFS: Disk quotas dquot_6.6.0
[   15.676772] VFS: Dquot-cache hash table entries: 1024 (order 0, 8192
bytes)
[   15.705203] Block layer SCSI generic (bsg) driver version 0.4 loaded
(major 252)
[   15.705981] io scheduler noop registered
[   15.706114] io scheduler deadline registered
[   15.706854] io scheduler cfq registered (default)
[   15.713107] ffe30ea0: ttyS0 at MMIO 0x1fe020043f8 (irq = 5, base_baud
= 115387) is a 16550A
[   15.713393] Console: ttyS0 (SU)
[   15.747368] console [ttyS0] enabled
[   15.752638] mousedev: PS/2 mouse device common for all mice
[   15.762844] rtc-m48t59 rtc-m48t59.0: rtc core: registered m48t59 as rtc0
[   15.764132] ledtrig-cpu: registered to indicate activity on CPUs
[   15.766301] NET: Registered protocol family 10
[   15.783012] mip6: Mobile IPv6
[   15.783469] NET: Registered protocol family 17
[   15.783979] mpls_gso: MPLS GSO support
[   15.787055] registered taskstats version 1
[   15.788251] zswap: loaded using pool lzo/zbud
[   15.793110] rtc-m48t59 rtc-m48t59.0: setting system clock to
2017-01-06 16:45:13 UTC (1483721113)
[   16.232741] random: systemd-udevd urandom read with 0 bits of entropy
available
[   17.364137] ne2k-pci.c:v1.03 9/22/2003 D. Becker/P. Gortmaker
[   17.419850] ne2k-pci 0000:00:04.0 eth0: RealTek RTL-8029 found at
0x1fe02008000, IRQ 6, 52:54:00:12:34:56.
[   17.437419] Unable to handle kernel NULL pointer dereference
[   17.437894] tsk->{mm,active_mm}->context = 0000000000000020
[   17.438299] tsk->{mm,active_mm}->pgd = fffff8000f53a000
[   17.438823]               \|/ ____ \|/
[   17.438823]               "@'/ .. \`@"
[   17.438823]               /_| \__/ |_\
[   17.438823]                  \__U_/
[   17.439865] systemd-udevd(63): Oops [#1]
[   17.440435] CPU: 0 PID: 63 Comm: systemd-udevd Not tainted
4.3.0-1-sparc64 #1 Debian 4.3.3-2
[   17.441063] task: fffff8000f4280e0 ti: fffff8000f590000 task.ti:
fffff8000f590000
[   17.441601] TSTATE: 0000009911001601 TPC: 000000001002426c TNPC:
0000000010024270 Y: 00000000    Not tainted
[   17.442760] TPC: <vp_reset+0xc/0x40 [virtio_pci]>
[   17.443210] g0: 00000000006b03c0 g1: 000001ff04040014 g2:
fffffffffffb0000 g3: 0000000000000000
[   17.443804] g4: fffff8000f4280e0 g5: 00000000002ca680 g6:
fffff8000f590000 g7: 0000000000000001
[   17.444400] o0: 0000000000000001 o1: fffff8000f5903f8 o2:
0000000010024264 o3: 0000000000000000
[   17.444993] o4: 0000000000000032 o5: 0000000000000000 sp:
fffff8000f592991 ret_pc: 000000000040564c
[   17.445613] RPC: <__spitfire_cee_trap_continue+0xb8/0xc8>
[   17.446027] l0: 0000000000001000 l1: 0000009911001600 l2:
0000000010024260 l3: 0000000000000400
[   17.446691] l4: 0000000000000000 l5: 0000000000000001 l6:
0000000000000000 l7: 0000000000000008
[   17.447269] i0: 0000000000000000 i1: 000000001000ad08 i2:
fffff8000f593380 i3: fffff8000f41a880
[   17.447844] i4: fffff8000f41a888 i5: fffff8000f5b92a0 i6:
fffff8000f592a41 i7: 0000000000764384
[   17.448447] I7: <dev_set_name+0x24/0x40>
[   17.448768] Call Trace:
[   17.449032]  [0000000000764384] dev_set_name+0x24/0x40
[   17.449466]  [000000001000a4e4] register_virtio_device+0x64/0x100
[virtio]
[   17.449919]  [0000000010025820] virtio_pci_probe+0xa0/0x160 [virtio_pci]
[   17.450426]  [00000000006eaf40] pci_device_probe+0x80/0x100
[   17.450799]  [000000000076928c] driver_probe_device+0x16c/0x480
[   17.451194]  [0000000000769628] __driver_attach+0x88/0xa0
[   17.451565]  [0000000000766fdc] bus_for_each_dev+0x5c/0xa0
[   17.451934]  [0000000000768c1c] driver_attach+0x1c/0x40
[   17.452300]  [0000000000768710] bus_add_driver+0x1f0/0x2a0
[   17.452668]  [000000000076a114] driver_register+0x74/0x120
[   17.453030]  [00000000006e9894] __pci_register_driver+0x34/0x60
[   17.453467]  [000000001002a018] virtio_pci_driver_init+0x18/0x28
[virtio_pci]
[   17.453928]  [0000000000426c58] do_one_initcall+0xb8/0x200
[   17.454294]  [0000000000525200] do_init_module+0x50/0x1f0
[   17.454728]  [00000000004c2514] load_module+0x1c54/0x23c0
[   17.455092]  [00000000004c2e74] SyS_finit_module+0x94/0xe0
[   17.455507] Disabling lock debugging due to kernel taint
[   17.455957] Caller[0000000000764384]: dev_set_name+0x24/0x40
[   17.456380] Caller[000000001000a4e4]:
register_virtio_device+0x64/0x100 [virtio]
[   17.456875] Caller[0000000010025820]: virtio_pci_probe+0xa0/0x160
[virtio_pci]
[   17.457355] Caller[00000000006eaf40]: pci_device_probe+0x80/0x100
[   17.457753] Caller[000000000076928c]: driver_probe_device+0x16c/0x480
[   17.458167] Caller[0000000000769628]: __driver_attach+0x88/0xa0
[   17.458642] Caller[0000000000766fdc]: bus_for_each_dev+0x5c/0xa0
[   17.459038] Caller[0000000000768c1c]: driver_attach+0x1c/0x40
[   17.459416] Caller[0000000000768710]: bus_add_driver+0x1f0/0x2a0
[   17.459808] Caller[000000000076a114]: driver_register+0x74/0x120
[   17.460208] Caller[00000000006e9894]: __pci_register_driver+0x34/0x60
[   17.460631] Caller[000000001002a018]:
virtio_pci_driver_init+0x18/0x28 [virtio_pci]
[   17.461134] Caller[0000000000426c58]: do_one_initcall+0xb8/0x200
[   17.461526] Caller[0000000000525200]: do_init_module+0x50/0x1f0
[   17.461912] Caller[00000000004c2514]: load_module+0x1c54/0x23c0
[   17.462295] Caller[00000000004c2e74]: SyS_finit_module+0x94/0xe0
[   17.462758] Caller[00000000004060f4]: linux_sparc_syscall+0x34/0x44
[   17.463195] Caller[fffff801005fe708]: 0xfffff801005fe708
[   17.463597] Instruction DUMP: 9de3bf50  01000000  01000000 <c25e22f8>
82006014  c0a843a0  c25e22f8  82006014  c28843a0

Disabling "modern" mode enables boot to proceed as normal:

$ ./qemu-system-sparc64 \
-drive
file=debian-9.0-sparc64-NETINST1.iso,if=none,index=0,id=cd,media=cdrom \
-device virtio-blk-pci,disable-modern=on,drive=cd \
-nographic \
-bios openbios-builtin.elf.nostrip \
-m 256

[    0.000000] PROMLIB: Sun IEEE Boot Prom 'OBP 3.10.24 1999/01/01 01:01'
[    0.000000] PROMLIB: Root node compatible: sun4u
[    0.000000] Initializing cgroup subsys cpuset
[    0.000000] Initializing cgroup subsys cpu
[    0.000000] Initializing cgroup subsys cpuacct
[    0.000000] Linux version 4.3.0-1-sparc64
(debian-kernel@lists.debian.org) (gcc version 4.9.3 (Debian 4.9.3-10) )
#1 Debian 4.3.3-2 (2015-12-17)
[    0.000000] bootconsole [earlyprom0] enabled
[    0.000000] ARCH: SUN4U

(lots cut)

[   11.390769] Unpacking initramfs...
[   12.082838] Freeing initrd memory: 8296K (fffff80004400000 -
fffff80004c1a000)
[   12.087735] futex hash table entries: 256 (order: -1, 6144 bytes)
[   12.088461] audit: initializing netlink subsys (disabled)
[   12.089350] audit: type=2000 audit(1.116:1): initialized
[   12.094237] HugeTLB registered 8 MB page size, pre-allocated 0 pages
[   12.094830] zbud: loaded
[   12.097379] VFS: Disk quotas dquot_6.6.0
[   12.097616] VFS: Dquot-cache hash table entries: 1024 (order 0, 8192
bytes)
[   12.126631] Block layer SCSI generic (bsg) driver version 0.4 loaded
(major 252)
[   12.127420] io scheduler noop registered
[   12.127555] io scheduler deadline registered
[   12.127905] io scheduler cfq registered (default)
[   12.133862] ffe30ea0: ttyS0 at MMIO 0x1fe020043f8 (irq = 5, base_baud
= 115387) is a 16550A
[   12.134133] Console: ttyS0 (SU)
[   12.188942] console [ttyS0] enabled
[   12.195464] mousedev: PS/2 mouse device common for all mice
[   12.204837] rtc-m48t59 rtc-m48t59.0: rtc core: registered m48t59 as rtc0
[   12.206309] ledtrig-cpu: registered to indicate activity on CPUs
[   12.208736] NET: Registered protocol family 10
[   12.227061] mip6: Mobile IPv6
[   12.227679] NET: Registered protocol family 17
[   12.228391] mpls_gso: MPLS GSO support
[   12.232356] registered taskstats version 1
[   12.233854] zswap: loaded using pool lzo/zbud
[   12.239243] rtc-m48t59 rtc-m48t59.0: setting system clock to
2017-01-06 16:52:10 UTC (1483721530)
[   12.697036] random: systemd-udevd urandom read with 0 bits of entropy
available
[   13.796267] ne2k-pci.c:v1.03 9/22/2003 D. Becker/P. Gortmaker
[   13.840168] ne2k-pci 0000:00:04.0 eth0: RealTek RTL-8029 found at
0x1fe02008000, IRQ 6, 52:54:00:12:34:56.
[   13.860059] virtio-pci 0000:00:06.0: virtio_pci: leaving for legacy
driver
[   14.710597] ne2k-pci 0000:00:04.0 enp0s4: renamed from eth0
[   14.714208]  vda: vda1 vda2 vda3 vda4 vda5 vda6 vda7 vda8


Guenter, can you try a similar command line and confirm whether it fixes
the issue for you under QEMU 2.7 and 2.8? I have no idea as to why the
difference in legacy/non-legacy codepaths should crash the kernel though.


ATB,

Mark.
