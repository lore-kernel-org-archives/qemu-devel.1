Received: from eggs.gnu.org ([2001:4830:134:3::10]:33405)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sgarzare@redhat.com>) id 1gNgl5-0001iD-MI
	for qemu-devel@nongnu.org; Fri, 16 Nov 2018 11:14:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sgarzare@redhat.com>) id 1gNgl1-0004jk-NY
	for qemu-devel@nongnu.org; Fri, 16 Nov 2018 11:14:15 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:33591)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <sgarzare@redhat.com>) id 1gNgl1-0004jZ-JP
	for qemu-devel@nongnu.org; Fri, 16 Nov 2018 11:14:11 -0500
Received: by mail-qk1-f196.google.com with SMTP id o89so38231242qko.0
	for <qemu-devel@nongnu.org>; Fri, 16 Nov 2018 08:14:10 -0800 (PST)
MIME-Version: 1.0
From: Stefano Garzarella <sgarzare@redhat.com>
Date: Fri, 16 Nov 2018 17:13:59 +0100
Message-ID: <CAGxU2F658=XjoHnF6Qq5FqBZAE68BBtMFt-6HcKp_PVxTynOnw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: [Qemu-devel] SeaBIOS booting time optimization
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: seabios@seabios.org
Cc: qemu-devel@nongnu.org, Rob Bradford <robert.bradford@intel.com>, Samuel Ortiz <sameo@linux.intel.com>, Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

Hi,
I'm investigating the SeaBIOS booting time, to understand if we can reduce
the boot time in some cases (e.g. legacy hardware is not needed). I think
this
can be interesting also for NEMU developers.

Following this thread (
https://mail.coreboot.org/pipermail/seabios/2015-July/009497.html),
I'm using qboot (https://github.com/bonzini/qboot) to compare the SeaBIOS
booting time.

As Paolo did in qboot, I manually add small debug port writes in SeaBIOS and
linuxboot_dma.c (QEMU) to trace the events with perf (kvm_pio events)

The goal is to have only one image of SeaBIOS configurable at runtime to
reduce
the boot time, avoiding unnecessary initialization.

Any pointers or suggestions would be helpful.

Following I put some preliminary measurements that I obtained:
I used this QEMU command line:
./qemu-system-x86_64 -bios $BIOS -m 1G -cpu host -M accel=kvm \
-kernel /boot/vmlinuz-4.18.18-300.fc29.x86_64 -append 'console=ttyS0' \
-nographic -serial mon:stdio

For each test, I measured these times (in milliseconds) relative to the
"sched_process_exec" event:
- qemu_init_end: first kvm_entry (i.e. QEMU initialized has finished)
- fw_start: first entry of the BIOS
- fw_do_boot: after the BIOS initialization (e.g. PCI setup, etc.)
- linux_start_boot: before the jump to the Linux kernel

# qboot
BIOS=/home/stefano/repos/qboot/bios.bin
 qemu_init_end: 40.561234
 fw_start: 40.721729 (+0.160495)
 fw_do_boot: 47.025591 (+6.303862)
 linux_start_boot: 48.874112 (+1.848521)

# SeaBIOS with default configuration
BIOS=/home/stefano/repos/seabios/out_default/bios.bin
 qemu_init_end: 40.419451
 fw_start: 40.639967 (+0.220516)
 fw_do_boot: 886.668828 (+846.028861)
 linux_start_boot: 889.723547 (+3.054719)

# SeaBIOS with Kevin's configuration
# (https://mail.coreboot.org/pipermail/seabios/2015-July/009508.html)
# Note: this SeaBIOS setup is so stripped down that it can't actually boot
an OS
BIOS=/home/stefano/repos/seabios/out_kevin/bios.bin
 qemu_init_end: 40.676412
 fw_start: 40.755757 (+0.079345)
 fw_do_boot: 56.427023 (+15.671266)

I did the same tests also with NEMU (without using -M virt) and I have
approximately the same results.

As the next step, I'll start from Kevin's configuration to have a minimal
SeaBIOS image ables to boot a Linux kernel.

Thanks,
Stefano

-- 
Stefano Garzarella
Red Hat
