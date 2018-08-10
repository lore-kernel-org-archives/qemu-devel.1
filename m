Received: from eggs.gnu.org ([2001:4830:134:3::10]:46125)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1fo6pZ-0002o2-A5
	for qemu-devel@nongnu.org; Fri, 10 Aug 2018 08:47:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1fo6pU-0002SJ-Bm
	for qemu-devel@nongnu.org; Fri, 10 Aug 2018 08:47:49 -0400
Received: from chuckie.co.uk ([82.165.15.123]:45590
	helo=s16892447.onlinehome-server.info)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mark.cave-ayland@ilande.co.uk>)
	id 1fo6pU-0002Ql-5L
	for qemu-devel@nongnu.org; Fri, 10 Aug 2018 08:47:44 -0400
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Message-ID: <91881647-66be-1894-52c2-d796fb9b34fe@ilande.co.uk>
Date: Fri, 10 Aug 2018 13:47:34 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] qemu-system-ppc host process stuck at 100% CPU (due to
 badly programmed virtio device)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel <qemu-devel@nongnu.org>
Cc: "Michael S . Tsirkin" <mst@redhat.com>

Hi all,

I've been experimenting with adding virtio-blk support to the QEMU
PPC/SPARC64 machines and have found that it is possible for a guest to
program a virtio-blk-pci device such that the qemu-system-ppc process on
the host gets stuck at 100% CPU and requires a "kill -9" to remove it.

The easiest reproducer is to boot certain (old) OSs from a
virtio-blk-pci device (those that don't specifically have virtio
drivers) and then shutdown the VM which causes the qemu process to get
stuck in a loop.

The quick guide:

1) Clone my working branch from github at
https://github.com/mcayland/qemu/tree/openbios-bootindex3 (this is only
a few commits behind git master)

2) Configure as follows: './configure' '--target-list=ppc-softmmu'

3) Grab a copy of MacOS 9 from
https://www.ilande.co.uk/tmp/qemu/MacOS921-vanilla.iso

4) Start QEMU like this:

$ qemu-system-ppc -drive
file=MacOS921-vanilla.iso,if=none,index=0,id=cd,media=cdrom -device
virtio-blk-pci,drive=cd,bootindex=0 -m 256 -boot d -M mac99

(Note the warning on the console: qemu-system-ppc: virtio: zero sized
buffers are not allowed)

5) Wait until the broken disk icon appears in the GTK display, then
close the GTK window

In my local tests this places qemu-system-ppc in a 100% CPU loop
requiring a "kill -9" to break. Using gdb the top part of the backtrace
looks like this:

Thread 1 "qemu-system-ppc" received signal SIGINT, Interrupt.
0x000055555591fc7e in vring_used_flags_set_bit (vq=0x7fffc3ede010,
mask=1) at /home/build/src/qemu/git/qemu/hw/virtio/virtio.c:297
297         virtio_stw_phys_cached(vdev, &caches->used, pa, flags | mask);
(gdb) bt
#0  0x000055555591fc7e in vring_used_flags_set_bit (vq=0x7fffc3ede010,
mask=1) at /home/build/src/qemu/git/qemu/hw/virtio/virtio.c:297
#1  0x000055555591fe81 in virtio_queue_set_notification
(vq=0x7fffc3ede010, enable=0) at
/home/build/src/qemu/git/qemu/hw/virtio/virtio.c:342
#2  0x00005555558d73ce in virtio_blk_handle_vq (s=0x5555571239b0,
vq=0x7fffc3ede010) at
/home/build/src/qemu/git/qemu/hw/block/virtio-blk.c:604
#3  0x00005555558d9f2d in virtio_blk_data_plane_handle_output
(vdev=0x5555571239b0, vq=0x7fffc3ede010) at
/home/build/src/qemu/git/qemu/hw/block/dataplane/virtio-blk.c:164
#4  0x0000555555922ddb in virtio_queue_notify_aio_vq (vq=0x7fffc3ede010)
at /home/build/src/qemu/git/qemu/hw/virtio/virtio.c:1518
#5  0x0000555555924fc2 in virtio_queue_host_notifier_aio_poll
(opaque=0x7fffc3ede078) at
/home/build/src/qemu/git/qemu/hw/virtio/virtio.c:2412
#6  0x0000555555e49ac0 in run_poll_handlers_once (ctx=0x5555569c56b0) at
util/aio-posix.c:497
#7  0x0000555555e49cd8 in try_poll_mode (ctx=0x5555569c56b0,
blocking=true) at util/aio-posix.c:573
#8  0x0000555555e49d83 in aio_poll (ctx=0x5555569c56b0, blocking=true)
at util/aio-posix.c:602
#9  0x0000555555e45ac7 in aio_wait_bh_oneshot (ctx=0x5555569c56b0,
cb=0x5555558da2be <virtio_blk_data_plane_stop_bh>,
opaque=0x55555712e970) at util/aio-wait.c:70
#10 0x00005555558da476 in virtio_blk_data_plane_stop
(vdev=0x5555571239b0) at
/home/build/src/qemu/git/qemu/hw/block/dataplane/virtio-blk.c:282
#11 0x0000555555c69019 in virtio_bus_stop_ioeventfd (bus=0x555557123938)
at hw/virtio/virtio-bus.c:246
#12 0x0000555555c6b337 in virtio_pci_stop_ioeventfd
(proxy=0x55555711b840) at hw/virtio/virtio-pci.c:293
#13 0x0000555555c6d0da in virtio_pci_vmstate_change (d=0x55555711b840,
running=false) at hw/virtio/virtio-pci.c:1078
#14 0x000055555592481b in virtio_vmstate_change (opaque=0x5555571239b0,
running=0, state=RUN_STATE_SHUTDOWN) at
/home/build/src/qemu/git/qemu/hw/virtio/virtio.c:2222
#15 0x0000555555a670e1 in vm_state_notify (running=0,
state=RUN_STATE_SHUTDOWN) at vl.c:1532
#16 0x000055555587beef in do_vm_stop (state=RUN_STATE_SHUTDOWN,
send_stop=false) at /home/build/src/qemu/git/qemu/cpus.c:1012
#17 0x000055555587bf2b in vm_shutdown () at
/home/build/src/qemu/git/qemu/cpus.c:1030
#18 0x0000555555a6f239 in main (argc=15, argv=0x7fffffffe8d8,
envp=0x7fffffffe958) at vl.c:4649
(gdb) q
A debugging session is active.

        Inferior 1 [process 851] will be killed.

It looks like there is an interaction with the oneshot triggered via
virtio_vmstate_change which causes the host process to get stuck in a
loop on exit.


ATB,

Mark.
