Received: from eggs.gnu.org ([209.51.188.92]:35221)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1gsIZV-0004gw-2d
	for qemu-devel@nongnu.org; Fri, 08 Feb 2019 21:40:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1gsIZU-0003Jy-4W
	for qemu-devel@nongnu.org; Fri, 08 Feb 2019 21:40:49 -0500
Received: from indium.canonical.com ([91.189.90.7]:42652)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1gsIZT-0003Hp-Uo
	for qemu-devel@nongnu.org; Fri, 08 Feb 2019 21:40:48 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1gsIZR-0002SK-P2
	for <qemu-devel@nongnu.org>; Sat, 09 Feb 2019 02:40:45 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 95A022E80CB
	for <qemu-devel@nongnu.org>; Sat,  9 Feb 2019 02:40:45 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Sat, 09 Feb 2019 02:35:42 -0000
From: Cheng Chen <1814418@bugs.launchpad.net>
Reply-To: Bug 1814418 <1814418@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <154917314614.27692.2830748026894633212.malonedeb@soybean.canonical.com>
Message-Id: <154967974209.18918.14268141879204629622.malone@soybean.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1814418] Re: persistent bitmap will be
 inconsistent when qemu crash,
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Thanks, all:

I only want to know:

1. Is this a bug?
2. Which qemu version will fix the bug?

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1814418

Title:
  persistent bitmap will be inconsistent when qemu  crash,

Status in QEMU:
  New

Bug description:
  Follow these steps to reappear the bug:

  1. start qemu
  2. add persistent bitmap: '{ "execute": "block-dirty-bitmap-add", "argume=
nts": {"node": "drive-virtio-disk1","name": "bitmap0", "persistent":true }}'
  3. stop qemu (Friendly shutdown)
  4. re-start qemu
  5. kill -9 qemu (simulate Host crash, eg. lose power)
  6. re-start qemu

  Now, the '{ "execute": "query-block" }' can't find the bitmap0. I can
  understand at this point, because the bitmap0 has not been
  synchronized yet.

  But, when I try to add persistent bitmap0 again: '{ "execute": "block-
  dirty-bitmap-add", "arguments": {"node": "drive-virtio-disk1","name":
  "bitmap0", "persistent":true }}', It failed:

  {"id":"libvirt-42","error":{"class":"GenericError","desc":"Can't make
  bitmap 'bitmap0' persistent in 'drive-virtio-disk1': Bitmap with the
  same name is already stored"}}

  In other word, when qemu crash, the qcow2 image remain the incomplete
  persistent bitmap.

  ---

  host: centos 7.5
  qemu version: 2.12.0 and 3.1.0, other version I does not test yet.
  qemu command: qemu-system-x86_64 -name guest=3Dtest,debug-threads=3Don -S=
 -object secret,id=3DmasterKey0,format=3Draw,file=3D/var/lib/libvirt/qemu/d=
omain-190-test./master-key.aes -machine pc-i440fx-3.1,accel=3Dkvm,usb=3Doff=
,dump-guest-core=3Doff,mem-merge=3Doff -m 1024 -mem-prealloc -mem-path /dev=
/hugepages1G/libvirt/qemu/190-test -realtime mlock=3Doff -smp 1,sockets=3D1=
,cores=3D1,threads=3D1 -uuid 1c8611c2-a18a-4b1c-b40b-9d82040eafa4 -smbios t=
ype=3D1,manufacturer=3DIaaS -no-user-config -nodefaults -chardev socket,id=
=3Dcharmonitor,fd=3D31,server,nowait -mon chardev=3Dcharmonitor,id=3Dmonito=
r,mode=3Dcontrol -rtc base=3Dutc -no-shutdown -boot menu=3Don,strict=3Don -=
device piix3-usb-uhci,id=3Dusb,bus=3Dpci.0,addr=3D0x1.0x2 -device virtio-se=
rial-pci,id=3Dvirtio-serial0,bus=3Dpci.0,addr=3D0x3 -drive file=3D/opt/vol/=
sas/fb0c7c37-13e7-41fe-b3f8-f0fbaaeec7ce,format=3Dqcow2,if=3Dnone,id=3Ddriv=
e-virtio-disk0,cache=3Dwriteback -device virtio-blk-pci,scsi=3Doff,bus=3Dpc=
i.0,addr=3D0x5,drive=3Ddrive-virtio-disk0,id=3Dvirtio-disk0,bootindex=3D1,w=
rite-cache=3Don -drive file=3D/opt/vol/sas/bde66671-536d-49cd-8b46-a4f1ea7b=
e513,format=3Dqcow2,if=3Dnone,id=3Ddrive-virtio-disk1,cache=3Dwriteback -de=
vice virtio-blk-pci,scsi=3Doff,bus=3Dpci.0,addr=3D0x7,drive=3Ddrive-virtio-=
disk1,id=3Dvirtio-disk1,write-cache=3Don -netdev tap,fd=3D33,id=3Dhostnet0,=
vhost=3Don,vhostfd=3D34 -device virtio-net-pci,netdev=3Dhostnet0,id=3Dnet0,=
mac=3D00:85:45:3e:d4:3a,bus=3Dpci.0,addr=3D0x6 -chardev pty,id=3Dcharserial=
0 -device isa-serial,chardev=3Dcharserial0,id=3Dserial0 -chardev socket,id=
=3Dcharchannel0,fd=3D35,server,nowait -device virtserialport,bus=3Dvirtio-s=
erial0.0,nr=3D1,chardev=3Dcharchannel0,id=3Dchannel0,name=3Dorg.qemu.guest_=
agent.0 -device usb-tablet,id=3Dinput0,bus=3Dusb.0,port=3D1 -vnc 0.0.0.0:0,=
password -device cirrus-vga,id=3Dvideo0,bus=3Dpci.0,addr=3D0x2 -device virt=
io-balloon-pci,id=3Dballoon0,bus=3Dpci.0,addr=3D0x4 -msg timestamp=3Don

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1814418/+subscriptions
