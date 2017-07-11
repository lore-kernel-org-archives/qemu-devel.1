Received: from eggs.gnu.org ([2001:4830:134:3::10]:57477)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <umbramalison@gmail.com>) id 1dUwyS-00011s-L8
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 11:21:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <umbramalison@gmail.com>) id 1dUwyR-0000JS-FY
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 11:21:16 -0400
Received: from mail-it0-x235.google.com ([2607:f8b0:4001:c0b::235]:38619)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <umbramalison@gmail.com>)
	id 1dUwyR-0000Ib-7f
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 11:21:15 -0400
Received: by mail-it0-x235.google.com with SMTP id k192so24228923ith.1
	for <qemu-devel@nongnu.org>; Tue, 11 Jul 2017 08:21:13 -0700 (PDT)
MIME-Version: 1.0
From: Andrew Barnes <umbramalison@gmail.com>
Date: Tue, 11 Jul 2017 16:21:11 +0100
Message-ID: <CAKJ_wKQOjrXbH8OvgS_mH1bve80SmxOpYa-sb6tcHND7ektijg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: [Qemu-devel] Issue with nVMX and USB direct assignment (VFIO) in
 kernel 4.10 and newer
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

[Qemu 2.9.0, kernels as stated below]

4.10 is the first kernel to support nested VMX in a manor that is usable in
a hyper-V scenario. Whilst nVMX has been available before that, 4.10 is i
believe the first kernel that implements it further.

However, I have found the following pattern:

4.8.6 or 4.9.35 with *or* without kvm-intel.nested=1 -> USB D/Assignment
works
4.10 or 4.11.7 or 4.11.8 or 4.12 without kvm-intel.nested=1 -> USB
D/Assignment works
4.10 or 4.11.7 or 4.11.8 or 4.12 *with* kvm-intel.nested=1 -> USB
D/Assignment does *not* works

My qemu command line is as follows, which shows the USB D/Assignment as

-device vfio-pci,host=0000:00:1d.0,id=usb0,bus=pci.0
-device vfio-pci,host=0000:00:1a.0,id=usb1,bus=pci.0
-device vfio-pci,host=0000:00:14.0,id=usb2,bus=pci.0

where the third device is the usb3 host controller.

/bin/qemu-system-x86_64 -nodefaults -no-user-config -cpu
host,-hypervisor,+vmx,hv_relaxed,hv_spinlocks=0x1fff,hv_vapic,hv_time -smp
2 -M pc-i440fx-2.7,accel=kvm,usb=off,vmport=off,igd-passthru=on
-mem-prealloc -mem-path /dev/hugepages -m 5120M -global
PIIX4_PM.disable_s3=1 -global PIIX4_PM.disable_s4=1 -daemonize -qmp
tcp::10002,server,nowait -tpmdev
passthrough,id=tpm0,path=/dev/tpm0,cancel-path=/sys/class/tpm/tpm0/device/cancel
-device tpm-tis,tpmdev=tpm0 -drive file=/data/c.qcow2,if=virtio,id=c -drive
file=/data/d.qcow2,if=virtio,id=d -boot strict=on -device
vfio-pci,host=0000:00:02.0,id=vga0,bus=pci.0,addr=0x2 -nographic -vga none
-device vfio-pci,host=0000:00:03.0,id=snd0,bus=pci.0,addr=0x3 -device
vfio-pci,host=0000:00:1d.0,id=usb0,bus=pci.0 -device
vfio-pci,host=0000:00:1a.0,id=usb1,bus=pci.0 -device
vfio-pci,host=0000:00:14.0,id=usb2,bus=pci.0 -net
tap,vlan=0,ifname=tp-int-embi,script=no,downscript=no -net
tap,vlan=1,ifname=tp-ext-embi,script=no,downscript=no -net
nic,vlan=0,model=virtio,addr=0x4,macaddr=DE:AD:BE:EF:5a:6c -net
nic,vlan=1,model=virtio,addr=0x5,macaddr=DE:AD:BE:EF:33:FB"


I don't believe anything is wrong there, as it works fine in all other
scenarios.
However I need to move to a 4.10 or later for the improved nVMX, but it
seems that conflicts with USB D/Assignment.

As you can see, i'm also using IGD D/Assignment, and this works fine. I
have not explored if other devices can be reassigned successfully or not,
it may be just USB or it may be (more likely that IGD is special, as I
should know)

Any thoughts? it is not immediately clear to me how these two components
could effect each other.

Many thanks,

Andy
