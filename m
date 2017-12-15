Received: from eggs.gnu.org ([2001:4830:134:3::10]:43034)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1ePsnz-0000Mu-53
	for qemu-devel@nongnu.org; Fri, 15 Dec 2017 11:25:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1ePsnw-0008Hn-TA
	for qemu-devel@nongnu.org; Fri, 15 Dec 2017 11:25:47 -0500
Received: from indium.canonical.com ([91.189.90.7]:56048)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1ePsnw-0008DE-MZ
	for qemu-devel@nongnu.org; Fri, 15 Dec 2017 11:25:44 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1ePsnt-0005YH-Mr
	for <qemu-devel@nongnu.org>; Fri, 15 Dec 2017 16:25:41 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 32ADD2E8137
	for <qemu-devel@nongnu.org>; Fri, 15 Dec 2017 16:25:41 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Fri, 15 Dec 2017 16:17:41 -0000
From: Thomas Huth <1721221@bugs.launchpad.net>
Reply-To: Bug 1721221 <1721221@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <150711207545.12908.17996297593812507930.malonedeb@wampee.canonical.com>
Message-Id: <151335466291.24699.6501684422973559288.launchpad@wampee.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1721221] Re: PCI-E passthrough of Nvidia GTX GFX
 card to Win 10 guest fails with "kvm_set_phys_mem: error registering slot:
 Invalid argument"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

** Changed in: qemu
       Status: Fix Committed =3D> Fix Released

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1721221

Title:
  PCI-E passthrough of Nvidia GTX GFX card to Win 10 guest fails with
  "kvm_set_phys_mem: error registering slot: Invalid argument"

Status in QEMU:
  Fix Released

Bug description:
  Problem: =

  Passthrough of a PCI-E Nvidia GTX 970 GFX card to a Windows 10 guest from=
 a Debian Stretch host fails after recent changes to kvm in QEMU master/tru=
nk. Before this recent commit, everything worked as expected.

  QEMU Version:
  Master/trunk pulled from github 4/10/17 ( git reflog: d147f7e815 HEAD@{0}=
 )

  Host:
  Debian Stretch kernel SMP Debian 4.9.30-2+deb9u5 (2017-09-19) x86_64 GNU/=
Linux

  Guest:
  Windows 10 Professional

  Issue is with this commit:
  https://github.com/qemu/qemu/commit/f357f564be0bd45245b3ccfbbe20ace08fe83=
ca8

  Subsequent commit does not help:
  https://github.com/qemu/qemu/commit/3110cdbd8a4845c5b5fb861b0a664c56d993d=
d3c#diff-7b7a17f6e8ba4195198dd685073f43cb

  Error output from qemu: =

  (qemu) kvm_set_phys_mem: error registering slot: Invalid argument

  QEMU commandline used:

  ./sources/qemu/x86_64-softmmu/qemu-system-x86_64 -machine q35,accel=3Dkvm=
 -serial none -parallel none -name Windows \
  -enable-kvm -cpu host,kvm=3Doff,hv_vendor_id=3Dsugoidesu,-hypervisor -smp=
 6,sockets=3D1,cores=3D3,threads=3D2 \
  -m 8G -mem-path /dev/hugepages -mem-prealloc -balloon none \
  -drive if=3Dpflash,format=3Draw,readonly,file=3Dvms/ovmf-x64/ovmf-x64/OVM=
F_CODE-pure-efi.fd \
  -drive if=3Dpflash,format=3Draw,file=3Dvms/ovmf-x64/ovmf-x64/OVMF_VARS-pu=
re-efi.fd \
  -rtc clock=3Dhost,base=3Dlocaltime \
  -readconfig ./vms/q35-virtio-graphical.cfg \
  -object iothread,id=3Diothread0 -object iothread,id=3Diothread1 -object i=
othread,id=3Diothread2 -object iothread,id=3Diothread3 \
  -device virtio-scsi-pci,iothread=3Diothread0,id=3Dscsi0 -device virtio-sc=
si-pci,iothread=3Diothread1,id=3Dscsi1 -device virtio-scsi-pci,iothread=3Di=
othread2,id=3Dscsi2 -device virtio-scsi-pci,iothread=3Diothread3,id=3Dscsi3=
 \
  -device scsi-hd,bus=3Dscsi0.0,drive=3Ddrive0,bootindex=3D1 -device scsi-h=
d,bus=3Dscsi1.0,drive=3Ddrive1 -device scsi-hd,bus=3Dscsi2.0,drive=3Ddrive2=
 -device scsi-hd,bus=3Dscsi3.0,drive=3Ddrive3 -device scsi-hd,bus=3Dscsi1.0=
,drive=3Ddrive4 -device scsi-hd,bus=3Dscsi2.0,drive=3Ddrive5 -device scsi-h=
d,bus=3Dscsi3.0,drive=3Ddrive6 -device scsi-hd,bus=3Dscsi1.0,drive=3Ddrive7=
 -device scsi-hd,bus=3Dscsi2.0,drive=3Ddrive8 -device scsi-hd,bus=3Dscsi3.0=
,drive=3Ddrive9 \
  -drive if=3Dnone,id=3Ddrive0,file=3Dvms/w10p64.qcow2,format=3Dqcow2,cache=
=3Dnone,discard=3Dunmap \
  -drive if=3Dnone,id=3Ddrive1,file=3Dvms/w10p64-2.qcow2,format=3Dqcow2,cac=
he=3Dnone,discard=3Dunmap \
  -drive if=3Dnone,id=3Ddrive2,file=3D/dev/mapper/w10p64-3,format=3Draw,cac=
he=3Dnone \
  -drive if=3Dnone,id=3Ddrive3,file=3Dvms/w10p64-4.qcow2,format=3Dqcow2,cac=
he=3Dnone \
  -drive if=3Dnone,id=3Ddrive4,file=3Dvms/w10p64-5.qcow2,format=3Dqcow2,cac=
he=3Dnone \
  -drive if=3Dnone,id=3Ddrive5,file=3Dvms/w10p64-6.qcow2,format=3Dqcow2,cac=
he=3Dnone,discard=3Dunmap \
  -drive if=3Dnone,id=3Ddrive6,file=3D/dev/mapper/w10p64-7,format=3Draw,cac=
he=3Dnone \
  -drive if=3Dnone,id=3Ddrive7,file=3Dvms/w10p64-8.qcow2,format=3Dqcow2,cac=
he=3Dnone,discard=3Dunmap \
  -device vfio-pci,host=3D01:00.0,multifunction=3Don,x-vga=3Don \
  -device vfio-pci,host=3D01:00.1,multifunction=3Don \
  -netdev type=3Dtap,id=3Dnet1,ifname=3Dtap1,script=3Dno,downscript=3Dno,vh=
ost=3Don \
  -device virtio-net-pci,netdev=3Dnet1,mac=3D52:54:00:18:32:c9,bus=3Dpcie.2=
,addr=3D00.0,ioeventfd=3Don \
  -device usb-host,bus=3Dusb.0,hostbus=3D3,hostport=3D2.1 \
  -device usb-host,hostbus=3D3,hostport=3D2.2 \
  -device usb-host,bus=3Dich9-ehci-1.0,hostbus=3D3,hostport=3D2.4 \
  -object input-linux,id=3Dkbd1,evdev=3D/dev/input/event0,grab_all=3Dyes,re=
peat=3Don \
  -drive if=3Dnone,id=3Ddrive8,file=3Dvms/w10p64.qcow2-9,format=3Dqcow2,dis=
card=3Dunmap \
  -drive if=3Dnone,id=3Ddrive9,file=3Dvms/w10p64-10.qcow2,format=3Dqcow2,ca=
che=3Dnone,discard=3Dunmap \
  -device usb-host,bus=3Dusb.0,hostbus=3D3,hostport=3D9 \
  -monitor stdio

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1721221/+subscriptions
