Received: from eggs.gnu.org ([2001:4830:134:3::10]:43487)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1dko9p-00028p-E6
	for qemu-devel@nongnu.org; Thu, 24 Aug 2017 05:10:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1dko9m-0006Qo-30
	for qemu-devel@nongnu.org; Thu, 24 Aug 2017 05:10:33 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56522)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1dko9l-0006QS-Oj
	for qemu-devel@nongnu.org; Thu, 24 Aug 2017 05:10:30 -0400
Date: Thu, 24 Aug 2017 10:10:24 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20170824091023.GA2737@work-vm>
References: <599E21EE.8070104@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <599E21EE.8070104@windriver.com>
Subject: Re: [Qemu-devel] anyone seen or heard of large delays/stalls
 running qemu with kvm support?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Chris Friesen <chris.friesen@windriver.com>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com

* Chris Friesen (chris.friesen@windriver.com) wrote:
> 
> Hi all,
> 
> I need to apologize up front, this is going to be a long email.  Basically
> the executive summary is that we're seeing issues where a VM is apparently
> not making forward progress in the guest, while at the same time spinning in
> a busy loop on the host.  I'm looking for any pointers/suggestions on what
> might be going on or how to narrow it down.
> 
> We're using qemu-kvm-ev-2.6.0 in the context of an OpenStack compute node
> running CentOS 7.
> 
> While running a test involving a cold migration of a VM from one host to
> another (basically shutting down the guest, moving all the files over to
> another host, then starting the guest back up) we have on a couple of cases
> had a VM get into a state where it was displaying "Guest has not initialized
> the display (yet)." on the console.  Running strace or gdb on the host
> against the guest qemu process seems to allow it to make forward progress.

cc'ing in Paolo.


> Here's what I've got:
> 
> 1) The root disk seems to be fine.  The root disk for the VM is iSCSI, and
> is accessible from the host.  Starting up a new VM with the same root disk
> and mostly the same commandline works fine.  (The serial port of the new VM
> was directed to stdio and the vnc option was removed.)
> 
> 2) Investigating the apparently-hung instance it seems 2 of its 3 vCPUs are
> running a busy-loop:
> 
>    PID USER PR NI VIRT RES SHR S %CPU %MEM TIME+ COMMAND
> 192577 root 20 0 3816972 38360 10916 R 99.9 0.0 75:15.17 CPU 1/KVM
> 192578 root -2 0 3816972 38360 10916 R 99.9 0.0 75:15.36 CPU 2/KVM
> 
> (Each of the vCPU threads is affined to a separate physical CPU.)
> 
> 
> 3) Trying to retrieve the cpu info via libvirt didn't return within 10 seconds:
> 
> compute-0:/home/wrsroot# start=$SECONDS; timeout 10 virsh
> qemu-monitor-command --hmp instance-0000006e info cpus || echo "timeout
> after $((SECONDS - start)) seconds"
> timeout after 10 seconds
> 
> 
> 4) Running gdb on 192577 shows the following backtrace:

How about getting a copy of the kernel stack for all the threads from
 /proc/(pid of qemu)/task/*/stack ?


> Thread 1 (process 192577):
> #0 0x00007f8c596e4537 in ioctl () from /lib64/libc.so.6
> #1 0x00007f8c70fe0234 in kvm_vcpu_ioctl ()
> #2 0x00007f8c70fe02ed in kvm_cpu_exec ()
> #3 0x00007f8c70fcee76 in qemu_kvm_cpu_thread_fn ()
> #4 0x00007f8c599bedc5 in start_thread () from /lib64/libpthread.so.0
> #5 0x00007f8c596ed76d in clone () from /lib64/libc.so.6
> 
> 5) Running gdb on 192578 gives the same backtrace.
> 
> 6) Strace shows most of the time spent in ioctl...with 39K syscalls in 30
> seconds across those two PIDs:

I've got vague memories of a recent bug report about something stuck
with the host eating CPU similarly, but I can't remember if it was
during boot or any other details.

> compute-0:/home/wrsroot# timeout 30 strace -c -q -T -p 192577 -p 192578
> % time seconds usecs/call calls errors syscall
> ------ ----------- ----------- --------- --------- ----------------
>  99.86 0.297753 9 32325 ioctl
>   0.12 0.000354 0 6730 writev
>   0.02 0.000059 0 384 60 futex
>   0.00 0.000000 0 10 write
>   0.00 0.000000 0 2 rt_sigpending
>   0.00 0.000000 0 2 2 rt_sigtimedwait
> ------ ----------- ----------- --------- --------- ----------------
> 100.00 0.298166 39453 62 total
> 
> 
> 7) Running strace is enough to allow the VM to make forward progress, here
> are kernel logs from within the guest:
> 
> [ 2540.964492] INFO: rcu_preempt self-detected stall on CPU { 0} (t=2202996
> jiffies g=-108 c=-109 q=1676)
> [ 2540.984656] Task dump for CPU 0:
> [ 2540.985911] systemd R running task 0 1 0 0x00000008
> [ 2540.988028] ffff88003b660000 0000000084d8f1f4 ffff88003e003d90 ffffffff810a8676
> [ 2540.990869] 0000000000000000 ffffffff81a44d40 ffff88003e003da8 ffffffff810abed9
> [ 2540.993975] 0000000000000001 ffff88003e003dd8 ffffffff8110e1a0 ffff88003e00ec40
> [ 2540.996815] Call Trace:
> [ 2540.997995] <IRQ> [<ffffffff810a8676>] sched_show_task+0xb6/0x120
> [ 2540.999958] [<ffffffff810abed9>] dump_cpu_task+0x39/0x70
> [ 2541.001559] [<ffffffff8110e1a0>] rcu_dump_cpu_stacks+0x90/0xd0
> [ 2541.002425] [<ffffffff81111e34>] rcu_check_callbacks+0x434/0x7f0
> [ 2541.003154] [<ffffffff810d6590>] ? tick_sched_handle.isra.13+0x60/0x60
> [ 2541.003981] [<ffffffff8107f507>] update_process_times+0x47/0x80
> [ 2541.004755] [<ffffffff810d6555>] tick_sched_handle.isra.13+0x25/0x60
> [ 2541.005528] [<ffffffff810d65d1>] tick_sched_timer+0x41/0x70
> [ 2541.006225] [<ffffffff81099c4c>] __hrtimer_run_queues+0xfc/0x320
> [ 2541.006976] [<ffffffff8109a2b0>] hrtimer_interrupt+0xb0/0x1e0
> [ 2541.007751] [<ffffffff810421b7>] local_apic_timer_interrupt+0x37/0x60
> [ 2541.008541] [<ffffffff816d7b3f>] smp_apic_timer_interrupt+0x3f/0x60
> [ 2541.009290] [<ffffffff816d621d>] apic_timer_interrupt+0x6d/0x80
> [ 2541.009996] <EOI> [<ffffffff810ccd39>] ? get_monotonic_boottime+0xb9/0x100
> [ 2541.010976] [<ffffffff81093cd1>] posix_get_boottime+0x11/0x20
> [ 2541.011740] [<ffffffff810952e4>] SyS_clock_gettime+0x54/0xc0
> [ 2541.012437] [<ffffffff816d5649>] system_call_fastpath+0x16/0x1b
> 
> [ 2602.140152] NMI watchdog: BUG: soft lockup - CPU#2 stuck for 22s!
> [systemd-udevd:232]
> [ 2602.140438] NMI watchdog: BUG: soft lockup - CPU#0 stuck for 23s! [ksoftirqd/0:3]
> [[ 2602.140455] Modules linked in: ata_piix(+) serio_raw virtio_blk(+)
> virtio_net floppy(+) libata sunrpc
> [32m OK [0m] Started udev Coldplug all Devices.
> [ 2602.140457] CPU: 0 PID: 3 Comm: ksoftirqd/0 Not tainted
> 3.10.0-514.16.1.el7.24.tis.x86_64 #1
> [ 2602.140458] Hardware name: Fedora Project OpenStack Nova, BIOS
> 1.9.1-5.el7_3.2.tis.1 04/01/2014

Hmm.  There were a pair of fixes that went into seabios and my reading
of our release history is that they're in the build just after that
(1.9.1-5.el7_3.3)
They could cause occasional boot hangs in odd ways - but your symptoms
dont quite seem to fit what I saw when I found them; but there again
they were pretty random.

Dave

> [ 2602.140472] task: ffff88003b661620 ti: ffff88003b6a0000 task.ti: ffff88003b6a0000
> [ 2602.140478] RIP: 0010:[<ffffffff8110f765>] [<ffffffff8110f765>]
> rcu_process_gp_end+0x15/0x80
> [ 2602.140488] RSP: 0018:ffff88003b6a3d70 EFLAGS: 00000202
> [ 2602.140489] RAX: 0000000000000202 RBX: 00000000000120dd RCX: ffffffff81ae2f80
> [ 2602.140490] RDX: ffff88003e000000 RSI: ffff88003e00ec40 RDI: ffffffff81a44d40
> [ 2602.140490] RBP: ffff88003b6a3d90 R08: ffff88003f14f600 R09: 0000000180100005
> [ 2602.140491] R10: ffffffff81a44d40 R11: 0000000000000000 R12: ffff88003b661688
> [ 2602.140491] R13: ffffffff810c21c1 R14: ffff88003b6a3cf8 R15: 0000000180100005
> [ 2602.140492] FS: 0000000000000000(0000) GS:ffff88003e000000(0000)
> knlGS:0000000000000000
> [ 2602.140493] CS: 0010 DS: 0000 ES: 0000 CR0: 000000008005003b
> [ 2602.140494] CR2: 00007fea58b37628 CR3: 000000003b068000 CR4: 00000000000006f0
> [ 2602.140504] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> [ 2602.140505] DR3: 0000000000000000 DR6: 00000000ffff0ff0 DR7: 0000000000000400
> [ 2602.140505] Stack:
> [ 2602.140516] ffffffff81a44d40 0000000000000009 ffff88003cc02300 ffffffff819f7108
> [ 2602.140517] ffff88003b6a3df0 ffffffff8111001e ffff88003aa52e30 0000000000000000
> [ 2602.140518] ffff88003e00ef88 ffff88003b661620 ffff88003b6a3fd8 0000000000000009
> [ 2602.140524] Call Trace:
> [ 2602.140534] [<ffffffff8111001e>] rcu_process_callbacks+0x9e/0x5c0
> [ 2602.140545] [<ffffffff81075ba0>] __do_softirq+0x100/0x300
> [ 2602.140546] [<ffffffff81075dd8>] run_ksoftirqd+0x38/0x50
> [ 2602.140555] [<ffffffff8109e62f>] smpboot_thread_fn+0x12f/0x240
> [ 2602.140557] [<ffffffff8109e500>] ? lg_double_unlock+0xb0/0xb0
> [ 2602.140559] [<ffffffff8109596f>] kthread+0xcf/0xe0
> [ 2602.140569] [<ffffffff810958a0>] ? kthread_create_on_node+0x140/0x140
> [ 2602.140572] [<ffffffff816d5598>] ret_from_fork+0x58/0x90
> [ 2602.140574] [<ffffffff810958a0>] ? kthread_create_on_node+0x140/0x140
> [ 2602.140595] Code: 00 31 ff e8 fe ed ff ff 48 89 df 57 9d 0f 1f 44 00 00
> 5b 5d c3 90 0f 1f 44 00 00 55 48 89 e5 41 56 41 55 41 54 49 89 f4 53 9c 58
> <0f> 1f 44 00 00 48 89 c3 fa 66 0f 1f 44 00 00 4c 8b 6e 18 49 8b
> [ 2602.146398] FDC 0 is a S82078B
> [ 2602.290420] Modules linked in: ata_piix(+) serio_raw virtio_blk(+)
> virtio_net floppy libata sunrpc
> [ 2602.290422] CPU: 2 PID: 232 Comm: systemd-udevd Tainted: G L ------------
> 3.10.0-514.16.1.el7.24.tis.x86_64 #1
> [ 2602.290422] Hardware name: Fedora Project OpenStack Nova, BIOS
> 1.9.1-5.el7_3.2.tis.1 04/01/2014
> [ 2602.290423] task: ffff88003faeeea0 ti: ffff88003fad4000 task.ti: ffff88003fad4000
> [ 2602.290428] RIP: 0010:[<ffffffff810dcd2a>] [<ffffffff810dcd2a>]
> smp_call_function_many+0x20a/0x270
> [ 2602.290428] RSP: 0018:ffff88003fad7740 EFLAGS: 00000202
> [ 2602.290429] RAX: 0000000000000000 RBX: ffff88003e116280 RCX: ffff88003e018fd8
> [ 2602.290430] RDX: 0000000000000000 RSI: 0000000000000100 RDI: 0000000000000000
> [ 2602.290430] RBP: ffff88003fad7778 R08: ffff88003e116288 R09: 0000000000000004
> [ 2602.290431] R10: ffff88003e116288 R11: 0000000000000000 R12: ffffffff81ae2f80
> [ 2602.290431] R13: 000c00003e341958 R14: 00000000000000fc R15: 0000000000000292
> [ 2602.290432] FS: 00007fb91a4648c0(0000) GS:ffff88003e100000(0000)
> knlGS:0000000000000000
> [ 2602.290433] CS: 0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [ 2602.290434] CR2: 00007febbb741000 CR3: 000000003f921000 CR4: 00000000000006e0
> [ 2602.290436] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> [ 2602.290436] DR3: 0000000000000000 DR6: 00000000ffff0ff0 DR7: 0000000000000400
> [ 2602.290437] Stack:
> [ 2602.290438] 0000000100000001 0000000000016240 ffffffff81e1aa00 0000000000000000
> [ 2602.290439] ffffffff81154e30 0000000000000002 0000000000000286 ffff88003fad77a8
> [ 2602.290440] ffffffff810dcfaa 0000000000000002 0000000000000100 0000000000000100
> [ 2602.290441] Call Trace:
> [ 2602.290444] [<ffffffff81154e30>] ? drain_pages+0xb0/0xb0
> [ 2602.290446] [<ffffffff810dcfaa>] on_each_cpu_mask+0x3a/0xa0
> [ 2602.290448] [<ffffffff811521d5>] drain_all_pages+0xb5/0xc0
> [ 2602.290450] [<ffffffff811b9d0f>] set_migratetype_isolate+0xaf/0xf0
> [ 2602.290452] [<ffffffff811b9e90>] start_isolate_page_range+0x70/0xf0
> [ 2602.290453] [<ffffffff81155632>] alloc_contig_range+0xe2/0x320
> [ 2602.290458] [<ffffffff814130af>] dma_alloc_from_contiguous+0xaf/0x200
> [ 2602.290461] [<ffffffff81021238>] dma_generic_alloc_coherent+0x88/0x1c0
> [ 2602.290463] [<ffffffff8141bd42>] dmam_alloc_coherent+0xb2/0x140
> [ 2602.290471] [<ffffffffa007d3c4>] ata_bmdma_port_start+0x44/0x60 [libata]
> [ 2602.290474] [<ffffffffa00f034b>] piix_port_start+0x1b/0x20 [ata_piix]
> [ 2602.290478] [<ffffffffa0069185>] ata_host_start.part.32+0xf5/0x1e0 [libata]
> [ 2602.290483] [<ffffffffa007e6c0>] ? ata_bmdma_port_intr+0x120/0x120 [libata]
> [ 2602.290486] [<ffffffffa0069289>] ata_host_start+0x19/0x20 [libata]
> [ 2602.290491] [<ffffffffa007cfe5>] ata_pci_sff_activate_host+0x45/0x250 [libata]
> [ 2602.290493] [<ffffffff8134a0ac>] ? pci_write_config_byte+0x1c/0x20
> [ 2602.290496] [<ffffffff81352226>] ? pcibios_set_master+0x76/0xa0
> [ 2602.290498] [<ffffffffa00f0e9e>] piix_init_one+0x57e/0x975 [ata_piix]
> [ 2602.290500] [<ffffffff81353935>] local_pci_probe+0x45/0xa0
> [ 2602.290501] [<ffffffff81354c75>] ? pci_match_device+0xe5/0x120
> [ 2602.290503] [<ffffffff81354df1>] pci_device_probe+0x101/0x150
> [ 2602.290505] [<ffffffff8140bac5>] driver_probe_device+0x145/0x3c0
> [ 2602.290507] [<ffffffff8140be13>] __driver_attach+0x93/0xa0
> [ 2602.290509] [<ffffffff8140bd80>] ? __device_attach+0x40/0x40
> [ 2602.290510] [<ffffffff81409723>] bus_for_each_dev+0x73/0xc0
> [ 2602.290511] [<ffffffff8140b40e>] driver_attach+0x1e/0x20
> [ 2602.290513] [<ffffffff8140af60>] bus_add_driver+0x200/0x2d0
> [ 2602.290514] [<ffffffff8140c494>] driver_register+0x64/0xf0
> [ 2602.290516] [<ffffffff813548d5>] __pci_register_driver+0xa5/0xc0
> [ 2602.290517] [<ffffffffa00f8000>] ? 0xffffffffa00f7fff
> [ 2602.290519] [<ffffffffa00f801e>] piix_init+0x1e/0x2e [ata_piix]
> [ 2602.290521] [<ffffffff810003a8>] do_one_initcall+0xb8/0x230
> [ 2602.290523] [<ffffffff810e3201>] load_module+0x2171/0x2810
> [ 2602.290525] [<ffffffff81337380>] ? ddebug_proc_write+0xf0/0xf0
> [ 2602.290528] [<ffffffff810df3e3>] ? copy_module_from_fd.isra.46+0x53/0x150
> [ 2602.290529] [<ffffffff810e3a56>] SyS_finit_module+0xa6/0xd0
> [ 2602.290531] [<ffffffff816d5649>] system_call_fastpath+0x16/0x1b
> 
> 
> 8) Running strace in a loop doesn't reliably kick qemu-kvm to run some more
> guest code. Found another method that works better:
> 
> cpu_kvm_busy=$(top -b -n1 -H -o+%CPU -p $(pgrep qemu-kvm) | awk '/KVM/ &&
> $9>50 {print $1;}'); while true; do for tid in $cpu_kvm_busy; do gdb --batch
> --quiet -ex 'bt' -ex 'quit' /usr/libexec/qemu-kvm $tid; done; done
> 
> This basically just finds qemu threads that are using more than 50% CPU,
> attaches gdb to them, prints stack trace, and exits.
> 
> With this running the instance can boot up to the login prompt on the vnc
> console and access the rootfs.
> 
> 
> Thanks for reading this far...if you have any pointers/suggestions I'd love
> to hear them.
> 
> Chris
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
