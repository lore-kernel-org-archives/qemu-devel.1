Received: from eggs.gnu.org ([2001:4830:134:3::10]:59554)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1fHCyI-0006mv-FE
	for qemu-devel@nongnu.org; Fri, 11 May 2018 14:40:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1fHCyF-0001s3-7V
	for qemu-devel@nongnu.org; Fri, 11 May 2018 14:40:50 -0400
Received: from indium.canonical.com ([91.189.90.7]:34336)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1fHCyE-0001qD-TP
	for qemu-devel@nongnu.org; Fri, 11 May 2018 14:40:47 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1fHCyD-0004PW-Mf
	for <qemu-devel@nongnu.org>; Fri, 11 May 2018 18:40:45 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id A7AF92E80C7
	for <qemu-devel@nongnu.org>; Fri, 11 May 2018 18:40:45 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Fri, 11 May 2018 18:29:33 -0000
From: Ihar Hrachyshka <1770724@bugs.launchpad.net>
Reply-To: Bug 1770724 <1770724@bugs.launchpad.net>
Sender: bounces@canonical.com
Message-Id: <152606337380.25547.9159144751315221757.malonedeb@soybean.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1770724] [NEW] e1000 takes a long time (2
 seconds) to set link ready
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Public bug reported:

When a VM is booted with e1000 NIC, it takes a long time (2 seconds) for
the guest to bring up the link. This can be seen in the following dmesg
messages:

[    4.899773] IPv6: ADDRCONF(NETDEV_UP): eth0: link is not ready
[    6.889165] e1000: eth0 NIC Link is Up 1000 Mbps Full Duplex, Flow Contr=
ol: RX
[    6.891372] IPv6: ADDRCONF(NETDEV_CHANGE): eth0: link becomes ready

The first message happens when the guest calls to ifup eth0; ifup does
not hold control until the link is established. The guest I am using
(cirros 0.4.0) then starts udhcpc DHCP client that issues a DHCP
request, then waits for 60 seconds for reply, then repeats the DHCP
request. When the first request is sent, the link is not ready yet, so
the frame is lost; when the second request is sent, the link is up and
DHCP lease is received.

If I use different NICs (e1000e, virtio, rtl*), there are no dmesg
messages, and the very first DHCP request correctly reaches outside and
results in a lease acquired.

The qemu version I am using is 2.10.1 from Fedora 27. I tried to
reproduce with runtime from Fedora 29 that includes 2.12 but I have
different issues there that block me from reproducing the original issue
(there, I get kernel traces, irq interrupt errors, and no network link
at all).

For the record, the qemu in question is started by kubevirt inside a
docker container with Fedora 27 based image.

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D

The command line of qemu is as follows:

27404 ?        Sl     0:10 /usr/bin/qemu-system-x86_64 -machine
accel=3Dkvm -name guest=3Ddefault_ovm-cirros,debug-threads=3Don -S -object
secret,id=3DmasterKey0,format=3Draw,file=3D/var/lib/libvirt/qemu/domain-1
-default_ovm-cirros/master-key.aes -machine
pc-q35-2.10,accel=3Dkvm,usb=3Doff,dump-guest-core=3Doff -m 62 -realtime
mlock=3Doff -smp 1,sockets=3D1,cores=3D1,threads=3D1 -uuid
8769fdbe-d957-5567-bd71-114ba0eb4811 -no-user-config -nodefaults
-chardev socket,id=3Dcharmonitor,path=3D/var/lib/libvirt/qemu/domain-1
-default_ovm-cirros/monitor.sock,server,nowait -mon
chardev=3Dcharmonitor,id=3Dmonitor,mode=3Dcontrol -rtc base=3Dutc -no-shutd=
own
-no-acpi -boot strict=3Don -device
i82801b11-bridge,id=3Dpci.1,bus=3Dpcie.0,addr=3D0x1e -device pci-
bridge,chassis_nr=3D2,id=3Dpci.2,bus=3Dpci.1,addr=3D0x0 -device pcie-root-
port,port=3D0x10,chassis=3D3,id=3Dpci.3,bus=3Dpcie.0,multifunction=3Don,add=
r=3D0x2
-device pcie-root-
port,port=3D0x11,chassis=3D4,id=3Dpci.4,bus=3Dpcie.0,addr=3D0x2.0x1 -device=
 pcie-
root-port,port=3D0x12,chassis=3D5,id=3Dpci.5,bus=3Dpcie.0,addr=3D0x2.0x2 -d=
evice
pcie-root-port,port=3D0x13,chassis=3D6,id=3Dpci.6,bus=3Dpcie.0,addr=3D0x2.0=
x3
-device pcie-root-
port,port=3D0x14,chassis=3D7,id=3Dpci.7,bus=3Dpcie.0,addr=3D0x2.0x4 -device=
 nec-
usb-xhci,id=3Dusb,bus=3Dpci.3,addr=3D0x0 -drive file=3D/var/run/libvirt
/kubevirt-ephemeral-disk/registry-disk-data/default/ovm-
cirros/disk_registryvolume/disk-image.raw,format=3Draw,if=3Dnone,id=3Ddrive-
virtio-disk0 -device virtio-blk-pci,scsi=3Doff,bus=3Dpci.4,addr=3D0x0,drive
=3Ddrive-virtio-disk0,id=3Dvirtio-disk0,bootindex=3D1 -drive
file=3D/var/run/libvirt/kubevirt-ephemeral-disk/cloud-init-data/default
/ovm-cirros/noCloud.iso,format=3Draw,if=3Dnone,id=3Ddrive-virtio-disk1 -dev=
ice
virtio-blk-pci,scsi=3Doff,bus=3Dpci.5,addr=3D0x0,drive=3Ddrive-virtio-disk1=
,id
=3Dvirtio-disk1 -netdev tap,fd=3D23,id=3Dhostnet0 -device
e1000,netdev=3Dhostnet0,id=3Dnet0,mac=3D0a:58:0a:f4:01:e1,bus=3Dpci.2,addr=
=3D0x1
-chardev socket,id=3Dcharserial0,path=3D/var/run/kubevirt-private/default
/ovm-cirros/virt-serial0,server,nowait -device isa-
serial,chardev=3Dcharserial0,id=3Dserial0 -vnc vnc=3Dunix:/var/run/kubevirt-
private/default/ovm-cirros/virt-vnc -device
VGA,id=3Dvideo0,vgamem_mb=3D16,bus=3Dpcie.0,addr=3D0x1 -device virtio-ballo=
on-
pci,id=3Dballoon0,bus=3Dpci.6,addr=3D0x0 -msg timestamp=3Don

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D

Hypervisor versions of interest:

[vagrant@node02 ~]$ sudo docker exec -it $(sudo docker ps | grep virt-launc=
her-ovm-cirros | grep entrypoint | awk -e '{print $1}') rpm -qa | grep 'qem=
u\|libvirt'
qemu-block-curl-2.10.1-2.fc27.x86_64
qemu-block-ssh-2.10.1-2.fc27.x86_64
qemu-block-nfs-2.10.1-2.fc27.x86_64
qemu-system-x86-core-2.10.1-2.fc27.x86_64
libvirt-daemon-3.7.0-4.fc27.x86_64
libvirt-daemon-driver-storage-disk-3.7.0-4.fc27.x86_64
libvirt-daemon-driver-storage-mpath-3.7.0-4.fc27.x86_64
libvirt-daemon-driver-storage-zfs-3.7.0-4.fc27.x86_64
libvirt-daemon-driver-nwfilter-3.7.0-4.fc27.x86_64
qemu-img-2.10.1-2.fc27.x86_64
qemu-common-2.10.1-2.fc27.x86_64
qemu-block-dmg-2.10.1-2.fc27.x86_64
qemu-block-rbd-2.10.1-2.fc27.x86_64
qemu-system-x86-2.10.1-2.fc27.x86_64
libvirt-libs-3.7.0-4.fc27.x86_64
libvirt-daemon-driver-storage-core-3.7.0-4.fc27.x86_64
libvirt-daemon-driver-qemu-3.7.0-4.fc27.x86_64
libvirt-daemon-driver-storage-gluster-3.7.0-4.fc27.x86_64
libvirt-daemon-driver-storage-logical-3.7.0-4.fc27.x86_64
libvirt-daemon-driver-storage-rbd-3.7.0-4.fc27.x86_64
libvirt-daemon-driver-storage-sheepdog-3.7.0-4.fc27.x86_64
libvirt-daemon-driver-storage-3.7.0-4.fc27.x86_64
libvirt-daemon-driver-nodedev-3.7.0-4.fc27.x86_64
libvirt-daemon-driver-secret-3.7.0-4.fc27.x86_64
libvirt-client-3.7.0-4.fc27.x86_64
ipxe-roms-qemu-20161108-2.gitb991c67.fc26.noarch
qemu-block-gluster-2.10.1-2.fc27.x86_64
qemu-block-iscsi-2.10.1-2.fc27.x86_64
qemu-kvm-2.10.1-2.fc27.x86_64
libvirt-daemon-driver-network-3.7.0-4.fc27.x86_64
libvirt-daemon-driver-storage-iscsi-3.7.0-4.fc27.x86_64
libvirt-daemon-driver-storage-scsi-3.7.0-4.fc27.x86_64
libvirt-daemon-driver-interface-3.7.0-4.fc27.x86_64
libvirt-daemon-kvm-3.7.0-4.fc27.x86_64

[vagrant@node02 ~]$ uname -a
Linux node02 3.10.0-693.17.1.el7.x86_64 #1 SMP Thu Jan 25 20:13:58 UTC 2018=
 x86_64 x86_64 x86_64 GNU/Linux

[vagrant@node02 ~]$ cat /etc/redhat-release
CentOS Linux release 7.4.1708 (Core)

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D

Guest:

$ uname -a
Linux ovm-cirros 4.4.0-28-generic #47-Ubuntu SMP Fri Jun 24 10:09:13 UTC 20=
16 x86_64 GNU/Linux

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D

Bug trackers for other projects:
- cirros: https://bugs.launchpad.net/cirros/+bug/1768955
- kubevirt: https://github.com/kubevirt/kubevirt/issues/936

** Affects: qemu
     Importance: Undecided
         Status: New

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1770724

Title:
  e1000 takes a long time (2 seconds) to set link ready

Status in QEMU:
  New

Bug description:
  When a VM is booted with e1000 NIC, it takes a long time (2 seconds)
  for the guest to bring up the link. This can be seen in the following
  dmesg messages:

  [    4.899773] IPv6: ADDRCONF(NETDEV_UP): eth0: link is not ready
  [    6.889165] e1000: eth0 NIC Link is Up 1000 Mbps Full Duplex, Flow Con=
trol: RX
  [    6.891372] IPv6: ADDRCONF(NETDEV_CHANGE): eth0: link becomes ready

  The first message happens when the guest calls to ifup eth0; ifup does
  not hold control until the link is established. The guest I am using
  (cirros 0.4.0) then starts udhcpc DHCP client that issues a DHCP
  request, then waits for 60 seconds for reply, then repeats the DHCP
  request. When the first request is sent, the link is not ready yet, so
  the frame is lost; when the second request is sent, the link is up and
  DHCP lease is received.

  If I use different NICs (e1000e, virtio, rtl*), there are no dmesg
  messages, and the very first DHCP request correctly reaches outside
  and results in a lease acquired.

  The qemu version I am using is 2.10.1 from Fedora 27. I tried to
  reproduce with runtime from Fedora 29 that includes 2.12 but I have
  different issues there that block me from reproducing the original
  issue (there, I get kernel traces, irq interrupt errors, and no
  network link at all).

  For the record, the qemu in question is started by kubevirt inside a
  docker container with Fedora 27 based image.

  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D

  The command line of qemu is as follows:

  27404 ?        Sl     0:10 /usr/bin/qemu-system-x86_64 -machine
  accel=3Dkvm -name guest=3Ddefault_ovm-cirros,debug-threads=3Don -S -object
  secret,id=3DmasterKey0,format=3Draw,file=3D/var/lib/libvirt/qemu/domain-1
  -default_ovm-cirros/master-key.aes -machine
  pc-q35-2.10,accel=3Dkvm,usb=3Doff,dump-guest-core=3Doff -m 62 -realtime
  mlock=3Doff -smp 1,sockets=3D1,cores=3D1,threads=3D1 -uuid
  8769fdbe-d957-5567-bd71-114ba0eb4811 -no-user-config -nodefaults
  -chardev socket,id=3Dcharmonitor,path=3D/var/lib/libvirt/qemu/domain-1
  -default_ovm-cirros/monitor.sock,server,nowait -mon
  chardev=3Dcharmonitor,id=3Dmonitor,mode=3Dcontrol -rtc base=3Dutc -no-shu=
tdown
  -no-acpi -boot strict=3Don -device
  i82801b11-bridge,id=3Dpci.1,bus=3Dpcie.0,addr=3D0x1e -device pci-
  bridge,chassis_nr=3D2,id=3Dpci.2,bus=3Dpci.1,addr=3D0x0 -device pcie-root-
  port,port=3D0x10,chassis=3D3,id=3Dpci.3,bus=3Dpcie.0,multifunction=3Don,a=
ddr=3D0x2
  -device pcie-root-
  port,port=3D0x11,chassis=3D4,id=3Dpci.4,bus=3Dpcie.0,addr=3D0x2.0x1 -devi=
ce
  pcie-root-port,port=3D0x12,chassis=3D5,id=3Dpci.5,bus=3Dpcie.0,addr=3D0x2=
.0x2
  -device pcie-root-
  port,port=3D0x13,chassis=3D6,id=3Dpci.6,bus=3Dpcie.0,addr=3D0x2.0x3 -devi=
ce
  pcie-root-port,port=3D0x14,chassis=3D7,id=3Dpci.7,bus=3Dpcie.0,addr=3D0x2=
.0x4
  -device nec-usb-xhci,id=3Dusb,bus=3Dpci.3,addr=3D0x0 -drive
  file=3D/var/run/libvirt/kubevirt-ephemeral-disk/registry-disk-
  data/default/ovm-cirros/disk_registryvolume/disk-
  image.raw,format=3Draw,if=3Dnone,id=3Ddrive-virtio-disk0 -device virtio-b=
lk-
  pci,scsi=3Doff,bus=3Dpci.4,addr=3D0x0,drive=3Ddrive-virtio-disk0,id=3Dvir=
tio-
  disk0,bootindex=3D1 -drive file=3D/var/run/libvirt/kubevirt-ephemeral-disk
  /cloud-init-data/default/ovm-cirros/noCloud.iso,format=3Draw,if=3Dnone,id
  =3Ddrive-virtio-disk1 -device virtio-blk-
  pci,scsi=3Doff,bus=3Dpci.5,addr=3D0x0,drive=3Ddrive-virtio-disk1,id=3Dvir=
tio-
  disk1 -netdev tap,fd=3D23,id=3Dhostnet0 -device
  e1000,netdev=3Dhostnet0,id=3Dnet0,mac=3D0a:58:0a:f4:01:e1,bus=3Dpci.2,add=
r=3D0x1
  -chardev socket,id=3Dcharserial0,path=3D/var/run/kubevirt-private/default
  /ovm-cirros/virt-serial0,server,nowait -device isa-
  serial,chardev=3Dcharserial0,id=3Dserial0 -vnc vnc=3Dunix:/var/run/kubevi=
rt-
  private/default/ovm-cirros/virt-vnc -device
  VGA,id=3Dvideo0,vgamem_mb=3D16,bus=3Dpcie.0,addr=3D0x1 -device virtio-bal=
loon-
  pci,id=3Dballoon0,bus=3Dpci.6,addr=3D0x0 -msg timestamp=3Don

  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D

  Hypervisor versions of interest:

  [vagrant@node02 ~]$ sudo docker exec -it $(sudo docker ps | grep virt-lau=
ncher-ovm-cirros | grep entrypoint | awk -e '{print $1}') rpm -qa | grep 'q=
emu\|libvirt'
  qemu-block-curl-2.10.1-2.fc27.x86_64
  qemu-block-ssh-2.10.1-2.fc27.x86_64
  qemu-block-nfs-2.10.1-2.fc27.x86_64
  qemu-system-x86-core-2.10.1-2.fc27.x86_64
  libvirt-daemon-3.7.0-4.fc27.x86_64
  libvirt-daemon-driver-storage-disk-3.7.0-4.fc27.x86_64
  libvirt-daemon-driver-storage-mpath-3.7.0-4.fc27.x86_64
  libvirt-daemon-driver-storage-zfs-3.7.0-4.fc27.x86_64
  libvirt-daemon-driver-nwfilter-3.7.0-4.fc27.x86_64
  qemu-img-2.10.1-2.fc27.x86_64
  qemu-common-2.10.1-2.fc27.x86_64
  qemu-block-dmg-2.10.1-2.fc27.x86_64
  qemu-block-rbd-2.10.1-2.fc27.x86_64
  qemu-system-x86-2.10.1-2.fc27.x86_64
  libvirt-libs-3.7.0-4.fc27.x86_64
  libvirt-daemon-driver-storage-core-3.7.0-4.fc27.x86_64
  libvirt-daemon-driver-qemu-3.7.0-4.fc27.x86_64
  libvirt-daemon-driver-storage-gluster-3.7.0-4.fc27.x86_64
  libvirt-daemon-driver-storage-logical-3.7.0-4.fc27.x86_64
  libvirt-daemon-driver-storage-rbd-3.7.0-4.fc27.x86_64
  libvirt-daemon-driver-storage-sheepdog-3.7.0-4.fc27.x86_64
  libvirt-daemon-driver-storage-3.7.0-4.fc27.x86_64
  libvirt-daemon-driver-nodedev-3.7.0-4.fc27.x86_64
  libvirt-daemon-driver-secret-3.7.0-4.fc27.x86_64
  libvirt-client-3.7.0-4.fc27.x86_64
  ipxe-roms-qemu-20161108-2.gitb991c67.fc26.noarch
  qemu-block-gluster-2.10.1-2.fc27.x86_64
  qemu-block-iscsi-2.10.1-2.fc27.x86_64
  qemu-kvm-2.10.1-2.fc27.x86_64
  libvirt-daemon-driver-network-3.7.0-4.fc27.x86_64
  libvirt-daemon-driver-storage-iscsi-3.7.0-4.fc27.x86_64
  libvirt-daemon-driver-storage-scsi-3.7.0-4.fc27.x86_64
  libvirt-daemon-driver-interface-3.7.0-4.fc27.x86_64
  libvirt-daemon-kvm-3.7.0-4.fc27.x86_64

  [vagrant@node02 ~]$ uname -a
  Linux node02 3.10.0-693.17.1.el7.x86_64 #1 SMP Thu Jan 25 20:13:58 UTC 20=
18 x86_64 x86_64 x86_64 GNU/Linux

  [vagrant@node02 ~]$ cat /etc/redhat-release
  CentOS Linux release 7.4.1708 (Core)

  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D

  Guest:

  $ uname -a
  Linux ovm-cirros 4.4.0-28-generic #47-Ubuntu SMP Fri Jun 24 10:09:13 UTC =
2016 x86_64 GNU/Linux

  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D

  Bug trackers for other projects:
  - cirros: https://bugs.launchpad.net/cirros/+bug/1768955
  - kubevirt: https://github.com/kubevirt/kubevirt/issues/936

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1770724/+subscriptions
