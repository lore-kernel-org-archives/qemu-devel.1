Received: from eggs.gnu.org ([2001:4830:134:3::10]:41057)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sgarzare@redhat.com>) id 1gRJw0-0001Fi-0T
	for qemu-devel@nongnu.org; Mon, 26 Nov 2018 11:40:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sgarzare@redhat.com>) id 1gRJvv-0002Ji-V6
	for qemu-devel@nongnu.org; Mon, 26 Nov 2018 11:40:31 -0500
Received: from mail-it1-f176.google.com ([209.85.166.176]:52261)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <sgarzare@redhat.com>) id 1gRJvv-0002HV-QZ
	for qemu-devel@nongnu.org; Mon, 26 Nov 2018 11:40:27 -0500
Received: by mail-it1-f176.google.com with SMTP id i7so29295455iti.2
	for <qemu-devel@nongnu.org>; Mon, 26 Nov 2018 08:40:25 -0800 (PST)
MIME-Version: 1.0
From: Stefano Garzarella <sgarzare@redhat.com>
Date: Mon, 26 Nov 2018 17:40:13 +0100
Message-ID: <CAGxU2F7+NZUS-BQ1hCnKynVxfsVUYTHRCWQvJwBA12bYmg0ZJA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: [Qemu-devel] QEMU/NEMU boot time with several x86 firmwares
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Samuel Ortiz <sameo@linux.intel.com>, Rob Bradford <robert.bradford@intel.com>
Cc: qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>

Hi Samuel, Rob,
I'm proceeding to compare several x86 firmwares in order to understand
which suits better with -kernel option to have a fast boot with
QEMU/NEMU.

For your use cases, what boot time do you expect?


I compared SeaBIOS, qboot, and OVMF. I started each test using this
qemu parameters: "./qemu-system-x86_64 -bios path/to/bios.bin -m 1G
-cpu host -M accel=kvm -vga none -kernel path/to/bzImage -initrd
path/to/rootfs.cpio ..."

As Samuel suggested, I added the total time to userspace adding a
probe in the kernel_init(), so the times (in msec) that I measured
are:
- qemu_init_end: first kvm_entry (i.e. QEMU initialized has finished)
- fw_start: first entry of the firmware
- fw_do_boot: after the firmware initialization (e.g. PCI setup, etc.)
- linux_start_boot: before the jump to the Linux kernel
- linux_start_user: before starting the init process

* SeaBIOS
Default configuration without debug messages (CONFIG_DEBUG_LEVEL=0) +
Stephen's patch (tpm: Check for TPM related ACPI tables before
attempting hw) + my patch (qemu: fast boot when linuxboot optionrom is
used).
 qemu_init_end: 41.634812
 fw_start: 41.857374 (+0.222562)
 fw_do_boot: 52.754109 (+10.896735)
 linux_start_boot: 54.117220 (+1.363111)
 linux_start_user: 495.684199 (+441.566979)

* qboot
Default configuration + my patch (pci: reduce pci_foreach() calls).
 qemu_init_end: 40.233717
 fw_start: 40.384048 (+0.150331)
 fw_do_boot: 45.660497 (+5.276449)
 linux_start_boot: 47.252119 (+1.591622)
 linux_start_user: 509.173886 (+461.921767)

* OVMF (https://github.com/intel/ovmf-virt)
I followed this script
(https://github.com/intel/nemu/blob/topic/virt-x86/tools/CI/run_nats.sh)
to build OVMF.
Note: I put the "fw_start" probe in the BdsEntry()
[MdeModulePkg/Universal/BdsDxe/BdsEntry.c], I'm not sure if it is
"near" to the real entry point.
 qemu_init_end: 42.734555
 fw_start: 163.611506 (+120.876951)
 fw_do_boot: 369.713760 (+206.102254)
 linux_start_boot: 370.960364 (+1.246604)
 linux_start_user: 796.799667 (+425.839303)

For OVMF case, are reasonable the times that I measured? Do you use a
different configuration?

Thanks,
Stefano

-- 
Stefano Garzarella
Red Hat
