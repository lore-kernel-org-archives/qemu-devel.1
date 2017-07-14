Received: from eggs.gnu.org ([2001:4830:134:3::10]:53996)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <padhu@hpe.com>) id 1dVsDH-0002vA-11
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 00:28:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <padhu@hpe.com>) id 1dVsDD-0003zc-Qz
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 00:28:23 -0400
Received: from g9t5009.houston.hpe.com ([15.241.48.73]:57388)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <padhu@hpe.com>) id 1dVsDD-0003yV-Hf
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 00:28:19 -0400
Received: from G4W9119.americas.hpqcorp.net (exchangepmrr1.us.hpecorp.net
	[16.210.20.214])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
	(No client certificate requested)
	by g9t5009.houston.hpe.com (Postfix) with ESMTPS id 38E5F52
	for <qemu-devel@nongnu.org>; Fri, 14 Jul 2017 04:28:17 +0000 (UTC)
From: "Nagarajan, Padhu (HPE Storage)" <padhu@hpe.com>
Date: Fri, 14 Jul 2017 04:28:12 +0000
Message-ID: <AT5PR84MB0164562E6BDB62601F376F87A0AD0@AT5PR84MB0164.NAMPRD84.PROD.OUTLOOK.COM>
Content-Language: en-US
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] Poor 8K random IO performance inside the guest
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>

During an 8K random-read fio benchmark, we observed poor performance inside=
 the guest in comparison to the performance seen on the host block device. =
The table below shows the IOPS on the host and inside the guest with both v=
irtioscsi (scsimq) and virtioblk (blkmq).

-----------------------------------
config        | IOPS  | fio gst hst
-----------------------------------
host-q32-t1   | 79478 | 401     271scsimq-q8-t4  | 45958 | 693 639 351blkmq=
-q8-t4   | 49247 | 647 589 308-----------------------------------host-q48-t=
1   | 85599 | 559     291
scsimq-q12-t4 | 50237 | 952 807 358blkmq-q12-t4  | 54016 | 885 786 329-----=
------------------------------
fio gst hst =3D> latencies in usecs, as
               seen by fio, guest and
               host block layers.
q8-t4 =3D> qdepth=3D8, numjobs=3D4
host  =3D> fio run directly on the host
scsimq,blkmq =3D> fio run inside the guest

Shouldn't we get a much better performance inside the guest ?

When fio inside the guest was generating 32 outstanding IOs, iostat on the =
host shows avgqu-sz of only 16. For 48 outstanding IOs inside the guest, av=
gqu-sz on the host was only marginally better.

qemu command line: qemu-system-x86_64 -L /usr/share/seabios/ -name node1,de=
bug-threads=3Don -name node1 -S -machine pc,accel=3Dkvm,usb=3Doff -cpu Sand=
yBridge -m 7680 -realtime mlock=3Doff -smp 4,sockets=3D4,cores=3D1,threads=
=3D1 -object iothread,id=3Diothread1 -object iothread,id=3Diothread2 -objec=
t iothread,id=3Diothread3 -object iothread,id=3Diothread4 -uuid XX -nograph=
ic -no-user-config -nodefaults -chardev socket,id=3Dcharmonitor,path=3D/var=
/lib/libvirt/qemu/node1.monitor,server,nowait -mon chardev=3Dcharmonitor,id=
=3Dmonitor,mode=3Dcontrol -rtc base=3Dutc,driftfix=3Dslew -global kvm-pit.l=
ost_tick_policy=3Ddiscard -no-hpet -no-shutdown -boot strict=3Don -device p=
iix3-usb-uhci,id=3Dusb,bus=3Dpci.0,addr=3D0x1.0x2 -device lsi,id=3Dscsi0,bu=
s=3Dpci.0,addr=3D0x6 -device virtio-scsi-pci,ioeventfd=3Don,num_queues=3D4,=
iothread=3Diothread2,id=3Dscsi1,bus=3Dpci.0,addr=3D0x7 -device virtio-scsi-=
pci,ioeventfd=3Don,num_queues=3D4,iothread=3Diothread2,id=3Dscsi2,bus=3Dpci=
.0,addr=3D0x8 -drive file=3Drhel7.qcow2,if=3Dnone,id=3Ddrive-virtio-disk0,f=
ormat=3Dqcow2 -device virtio-blk-pci,ioeventfd=3Don,num-queues=3D4,iothread=
=3Diothread1,scsi=3Doff,bus=3Dpci.0,addr=3D0x4,drive=3Ddrive-virtio-disk0,i=
d=3Dvirtio-disk0,bootindex=3D1 -drive file=3D/dev/sdc,if=3Dnone,id=3Ddrive-=
virtio-disk1,format=3Draw,cache=3Dnone,aio=3Dnative -device virtio-blk-pci,=
ioeventfd=3Don,num-queues=3D4,iothread=3Diothread1,iothread=3Diothread1,scs=
i=3Doff,bus=3Dpci.0,addr=3D0x17,drive=3Ddrive-virtio-disk1,id=3Dvirtio-disk=
1 -drive file=3D/dev/sdc,if=3Dnone,id=3Ddrive-scsi1-0-0-0,format=3Draw,cach=
e=3Dnone,aio=3Dnative -device scsi-hd,bus=3Dscsi1.0,channel=3D0,scsi-id=3D0=
,lun=3D0,drive=3Ddrive-scsi1-0-0-0,id=3Dscsi1-0-0-0 -netdev tap,fd=3D24,id=
=3Dhostnet0,vhost=3Don,vhostfd=3D25 -device virtio-net-pci,netdev=3Dhostnet=
0,id=3Dnet0,mac=3DXXX,bus=3Dpci.0,addr=3D0x2 -netdev tap,fd=3D26,id=3Dhostn=
et1,vhost=3Don,vhostfd=3D27 -device virtio-net-pci,netdev=3Dhostnet1,id=3Dn=
et1,mac=3DYYY,bus=3Dpci.0,multifunction=3Don,addr=3D0x15 -netdev tap,fd=3D2=
8,id=3Dhostnet2,vhost=3Don,vhostfd=3D29 -device virtio-net-pci,netdev=3Dhos=
tnet2,id=3Dnet2,mac=3DZZZ,bus=3Dpci.0,multifunction=3Don,addr=3D0x16 -chard=
ev pty,id=3Dcharserial0 -device isa-serial,chardev=3Dcharserial0,id=3Dseria=
l0 -device virtio-balloon-pci,id=3Dballoon0,bus=3Dpci.0,addr=3D0x3 -msg tim=
estamp=3Don

fio command line: /tmp/fio --time_based --ioengine=3Dlibaio --randrepeat=3D=
1 --direct=3D1 --invalidate=3D1 --verify=3D0 --offset=3D0 --verify_fatal=3D=
0 --group_reporting --numjobs=3D$jobs --name=3Drandread --rw=3Drandread --b=
locksize=3D8K --iodepth=3D$qd --runtime=3D60 --filename=3D{/dev/vdb or /dev=
/sda}

# qemu-system-x86_64 --version
QEMU emulator version 2.8.0(Debian 1:2.8+dfsg-3~bpo8+1)
Copyright (c) 2003-2016 Fabrice Bellard and the QEMU Project developers

The guest was running RHEL 7.3 and the host was Debian 8.

Any thoughts on what could be happening here ?

~Padhu.
