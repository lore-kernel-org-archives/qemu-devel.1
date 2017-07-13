Received: from eggs.gnu.org ([2001:4830:134:3::10]:35583)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <padhu@hpe.com>) id 1dVne2-0001MQ-2u
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 19:35:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <padhu@hpe.com>) id 1dVndy-0004bN-TT
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 19:35:42 -0400
Received: from g4t3426.houston.hpe.com ([15.241.140.75]:51042)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <padhu@hpe.com>) id 1dVndy-0004XM-MN
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 19:35:38 -0400
From: "Nagarajan, Padhu (HPE Storage)" <padhu@hpe.com>
Date: Thu, 13 Jul 2017 23:34:56 +0000
Message-ID: <AT5PR84MB01648353F49E25D22EB79EFBA0AC0@AT5PR84MB0164.NAMPRD84.PROD.OUTLOOK.COM>
References: <AT5PR84MB01644325A091571A2841C65EA0A90@AT5PR84MB0164.NAMPRD84.PROD.OUTLOOK.COM>
	<20170711091841.GE17792@stefanha-x1.localdomain>
In-Reply-To: <20170711091841.GE17792@stefanha-x1.localdomain>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] Disparity between host and guest CPU utilization
 during disk IO benchmark
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>

Thanks Stefan. Couldn't get to this earlier. Did another run and took a dif=
f of /proc/interrupts before and after the run. It shows all the interrupts=
 for 'virtio7-req.0' going to CPU1. I guess that explains the "CPU1/KVM" vc=
pu utilization on the host.

34:        147     666085          0          0   PCI-MSI-edge      virtio7=
-req.0

The only remaining question is the high CPU utilization of the vCPU threads=
 for this workload. Even when I run a light fio workload (queue depth of 1 =
which gives 8K IOPS), the vCPU threads are close to 100% utilization. Why i=
s it high and does it have an impact on guest code that could be executing =
on the same CPU ?

fio command line: fio --time_based --ioengine=3Dlibaio --randrepeat=3D1 --d=
irect=3D1 --invalidate=3D1 --verify=3D0 --offset=3D0 --verify_fatal=3D0 --g=
roup_reporting --numjobs=3D1 --name=3Drandread --rw=3Drandread --blocksize=
=3D8K --iodepth=3D1 --runtime=3D60 --filename=3D/dev/vdb

qemu command line: qemu-system-x86_64 -L /usr/share/seabios/ -enable-kvm -n=
ame node1,debug-threads=3Don -name node1 -S -machine pc-i440fx-2.8,accel=3D=
kvm,usb=3Doff -cpu SandyBridge -m 7680 -realtime mlock=3Doff -smp 4,sockets=
=3D4,cores=3D1,threads=3D1 -object iothread,id=3Diothread1 -object iothread=
,id=3Diothread2 -object iothread,id=3Diothread3 -object iothread,id=3Diothr=
ead4 -uuid XX -nographic -no-user-config -nodefaults -chardev socket,id=3Dc=
harmonitor,path=3D/var/lib/libvirt/qemu/node1fs.monitor,server,nowait -mon =
chardev=3Dcharmonitor,id=3Dmonitor,mode=3Dcontrol -rtc base=3Dutc,driftfix=
=3Dslew -global kvm-pit.lost_tick_policy=3Ddiscard -no-hpet -no-shutdown -b=
oot strict=3Don -device piix3-usb-uhci,id=3Dusb,bus=3Dpci.0,addr=3D0x1.0x2 =
-device lsi,id=3Dscsi0,bus=3Dpci.0,addr=3D0x6 -device virtio-scsi-pci,id=3D=
scsi1,bus=3Dpci.0,addr=3D0x7 -device virtio-scsi-pci,id=3Dscsi2,bus=3Dpci.0=
,addr=3D0x8 -drive file=3Drhel7.qcow2,if=3Dnone,id=3Ddrive-virtio-disk0,for=
mat=3Dqcow2 -device virtio-blk-pci,scsi=3Doff,bus=3Dpci.0,addr=3D0x4,drive=
=3Ddrive-virtio-disk0,id=3Dvirtio-disk0,bootindex=3D1 -drive file=3D/dev/sd=
c,if=3Dnone,id=3Ddrive-virtio-disk1,format=3Draw,cache=3Dnone,aio=3Dnative =
-device virtio-blk-pci,iothread=3Diothread1,scsi=3Doff,bus=3Dpci.0,addr=3D0=
x17,drive=3Ddrive-virtio-disk1,id=3Dvirtio-disk1 -drive file=3D/dev/sdc,if=
=3Dnone,id=3Ddrive-scsi1-0-0-0,format=3Draw,cache=3Dnone,aio=3Dnative -devi=
ce scsi-hd,bus=3Dscsi1.0,channel=3D0,scsi-id=3D0,lun=3D0,drive=3Ddrive-scsi=
1-0-0-0,id=3Dscsi1-0-0-0 -netdev tap,fd=3D24,id=3Dhostnet0,vhost=3Don,vhost=
fd=3D25 -device virtio-net-pci,netdev=3Dhostnet0,id=3Dnet0,mac=3DXXX,bus=3D=
pci.0,addr=3D0x2 -netdev tap,fd=3D26,id=3Dhostnet1,vhost=3Don,vhostfd=3D27 =
-device virtio-net-pci,netdev=3Dhostnet1,id=3Dnet1,mac=3DYYY,bus=3Dpci.0,mu=
ltifunction=3Don,addr=3D0x15 -netdev tap,fd=3D28,id=3Dhostnet2,vhost=3Don,v=
hostfd=3D29 -device virtio-net-pci,netdev=3Dhostnet2,id=3Dnet2,mac=3DZZZ,bu=
s=3Dpci.0,multifunction=3Don,addr=3D0x16 -chardev pty,id=3Dcharserial0 -dev=
ice isa-serial,chardev=3Dcharserial0,id=3Dserial0 -device virtio-balloon-pc=
i,id=3Dballoon0,bus=3Dpci.0,addr=3D0x3 -msg timestamp=3Don

# qemu-system-x86_64 --version
QEMU emulator version 2.8.0(Debian 1:2.8+dfsg-3~bpo8+1)
Copyright (c) 2003-2016 Fabrice Bellard and the QEMU Project developers

Note that I had the same host block device (/dev/sdc in this case) exposed =
over both virtio-scsi and virtio-blk to the guest VM for perf comparisons.

I see poor performance for 8K random reads inside the guest over both virti=
o-scsi and virtio-blk, compared to the host performance. Let me open anothe=
r thread for that problem, but let me know if something obvious pops up bas=
ed on the qemu command line.

~Padhu.

-----Original Message-----
From: Stefan Hajnoczi [mailto:stefanha@gmail.com]=20
Sent: Tuesday, July 11, 2017 5:19 AM
To: Nagarajan, Padhu (HPE Storage) <padhu@hpe.com>
Cc: qemu-devel@nongnu.org
Subject: Re: [Qemu-devel] Disparity between host and guest CPU utilization =
during disk IO benchmark

On Mon, Jul 10, 2017 at 05:27:15PM +0000, Nagarajan, Padhu (HPE Storage) wr=
ote:
> Posted this in qemu-discuss and did not get a response. Hoping that someo=
ne here might be able to offer insights.
>=20
> I was running an 8K random-read fio benchmark inside the guest with iodep=
th=3D32. The device used inside the guest for the test was a virtio-blk dev=
ice with iothread enabled, mapped on to a raw block device on the host. Whi=
le this workload was running, I took a snapshot of the CPU utilization repo=
rted by the host and the guest. The guest had 4 cores. top inside guest sho=
ws 3 idle cores and one core being 74% utilized by fio (active on core 3). =
The host had 12 cores and three cores were completely consumed by three qem=
u threads. top inside host shows three qemu threads, each utilizing the CPU=
 core to a near 100%. These threads are "CPU 1/KVM", "CPU 3/KVM" and "IO io=
thread1". The CPU utilization story on the host side is the same, even if I=
 run a light fio workload inside the guest (for ex. iodepth=3D1).=20
>=20
> Why do I see two "CPU/KVM" threads occupying 100% CPU, even though only o=
ne core inside the guest is being utilized ? Note that I had 'accel=3Dkvm' =
turned on for the guest.

fio might be submitting I/O requests on one vcpu and the completion
interrupts are processed on another vcpu.

To discuss further, please post:
1. Full QEMU command-line
2. Full fio command-line and job file (if applicable)
3. Output of cat /proc/interrupts inside the guest after running the
   benchmark
