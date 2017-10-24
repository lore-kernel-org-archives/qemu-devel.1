Received: from eggs.gnu.org ([2001:4830:134:3::10]:33099)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1e6vfT-0001ux-So
	for qemu-devel@nongnu.org; Tue, 24 Oct 2017 05:38:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1e6vfO-0001Jt-US
	for qemu-devel@nongnu.org; Tue, 24 Oct 2017 05:38:39 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55144)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1e6vfO-0001IP-Lx
	for qemu-devel@nongnu.org; Tue, 24 Oct 2017 05:38:34 -0400
Date: Tue, 24 Oct 2017 10:38:29 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20171024093829.GA3780@work-vm>
References: <20171024110543.e532d1536d31dd3005efdd3f@fennosys.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171024110543.e532d1536d31dd3005efdd3f@fennosys.fi>
Subject: Re: [Qemu-devel] Migration - Random guest kernel panics on target
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fennosys <reader@fennosys.fi>
Cc: qemu-devel@nongnu.org

* Fennosys (reader@fennosys.fi) wrote:
> Hi,
> 
> I'm encountering random guest kernel crashes while doing live migration with qemu (using qemu cli and monitor commands). 

That shouldn't happen!

> QEMU emulator version 2.10.0

Can you try backing up to 2.9 and see if the problem still happens?

> Host kernel: 4.13.9-gentoo
> Guest kernel: 4.13.9-gentoo
> 
> Host cpu: 
> model name	: AMD Opteron(tm) Processor 6128
> stepping	: 1
> microcode	: 0x10000d9

Are both hosts identical 6128 ?

> 
> example of vm starup cli: 
> qemu-system-x86_64 -daemonize -name VM50 -vnc :50 -enable-kvm -cpu host -serial file:/var/log/kvm/50-serial.log -k fi \
> -kernel /somepath/bzImage \
> root=/dev/vda -m 4096 -smp 4 -runas kvm-user \
> -netdev type=tap,ifname=vm50,id=VM50,script=/etc/openvswitch/scripts/ifup-br0-50,downscript=/etc/openvswitch/scripts/ifdown-br0,vhost=on \
> -device virtio-net-pci,mac=xx:xx:xx:xx:xx:xx,netdev=VM50 \
> -drive file=/dev/drbd1,format=raw,if=virtio

You should add a   ,cache=none   to that -drive - but that wont cause
that kernel panic.

> 
> backtrace:
> [  370.984297] BUG: unable to handle kernel paging request at ffffcc40fe000020
> [  370.985542] IP: receive_buf+0x7db/0xd20
> [  370.986131] PGD 0 
> [  370.986132] P4D 0 
> [  370.986450] 
> [  370.987463] Oops: 0000 [#1] SMP
> [  370.987972] Modules linked in: kvm_amd kvm irqbypass
> [  370.988787] CPU: 1 PID: 14 Comm: ksoftirqd/1 Not tainted 4.13.9-gentoo #3
> [  370.989816] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.10.2-1.fc27 04/01/2014
> [  370.991131] task: ffff8ec1baae6c00 task.stack: ffff9cd9406b0000
> [  370.992018] RIP: 0010:receive_buf+0x7db/0xd20
> [  370.992673] RSP: 0018:ffff9cd9406b3d10 EFLAGS: 00010286
> [  370.993454] RAX: 0000713f00000000 RBX: 00000000000007dd RCX: 0000000000002b9d
> [  370.994508] RDX: ffffca7c00000000 RSI: ffff9cd9406b3d4c RDI: ffff8ec1ba11c000
> [  370.995571] RBP: ffff9cd9406b3d98 R08: 0000000000000000 R09: 0000000000000600
> [  370.996618] R10: ffffcc40fe000000 R11: ffff8ec1ba44d740 R12: ffff8ec1ba10f800
> [  370.997676] R13: ffff8ec1b9bf2400 R14: 0000000080000000 R15: ffff8ec1b9bf2d00
> [  370.998728] FS:  0000000000000000(0000) GS:ffff8ec1bfc80000(0000) knlGS:0000000000000000
> [  370.999924] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [  371.000770] CR2: ffffcc40fe000020 CR3: 000000013a551000 CR4: 00000000000006a0
> [  371.001828] Call Trace:
> [  371.002231]  ? load_balance+0x144/0x970
> [  371.002802]  virtnet_poll+0x14e/0x260
> [  371.003433]  net_rx_action+0x1ab/0x2b0
> [  371.003996]  __do_softirq+0xdb/0x1e0
> [  371.004558]  run_ksoftirqd+0x24/0x50
> [  371.005107]  smpboot_thread_fn+0x107/0x160
> [  371.005718]  kthread+0xff/0x140
> [  371.006195]  ? sort_range+0x20/0x20
> [  371.006725]  ? kthread_create_on_node+0x40/0x40
> [  371.007415]  ret_from_fork+0x25/0x30
> [  371.007965] Code: 0a 8c 00 4d 01 f2 72 0e 48 c7 c0 00 00 00 80 48 2b 05 ba 6e 8e 00 49 01 c2 48 8b 15 a0 6e 8e 00 49 c1 ea 0c 49 c1 e2 06 49 01 d2 <49> 8b 42 20 a8 01 48 8d 48 ff 8b 45 b4 4c 0f 45 d1 49 39 c1 0f 
> [  371.010846] RIP: receive_buf+0x7db/0xd20 RSP: ffff9cd9406b3d10
> [  371.011701] CR2: ffffcc40fe000020
> [  371.012241] ---[ end trace b32e281709829620 ]---
> [  371.012929] Kernel panic - not syncing: Fatal exception in interrupt
> [  371.013999] Kernel Offset: 0x31000000 from 0xffffffff81000000 (relocation range: 0xffffffff80000000-0xffffffffbfffffff)
> [  371.015543] ---[ end Kernel panic - not syncing: Fatal exception in interrupt
> 
> conditions:
> With low work-load the migration seems to perform as expected. 
> 
> If load average is between 3-4 the issue can be reproduced relatively easily (2-5 live migration till it's crashing).
> 
> The drbd block device is in dual primary mode during the migration.

Since the failure is a non-filesystem related kernel panic, I don't
think it's block device related.

If you use anything other than virtio-net-pci does it work?

Dave

> RAM (ECC) on both hosts has been tested before these test.
> 
> Cheers,
> Antti
> 
> 
> -- 
> Fennosys <reader@fennosys.fi>
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
