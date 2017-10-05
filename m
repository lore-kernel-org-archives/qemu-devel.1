Received: from eggs.gnu.org ([2001:4830:134:3::10]:32983)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1e015Y-0004A4-UR
	for qemu-devel@nongnu.org; Thu, 05 Oct 2017 04:01:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1e015T-0003hp-PS
	for qemu-devel@nongnu.org; Thu, 05 Oct 2017 04:01:01 -0400
Received: from indium.canonical.com ([91.189.90.7]:43850)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1e015T-0003g3-Ez
	for qemu-devel@nongnu.org; Thu, 05 Oct 2017 04:00:55 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1e015R-0004Mc-9q
	for <qemu-devel@nongnu.org>; Thu, 05 Oct 2017 08:00:53 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 486972E804E
	for <qemu-devel@nongnu.org>; Thu,  5 Oct 2017 08:00:53 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Thu, 05 Oct 2017 07:55:10 -0000
From: Peter Sabaini <peter.sabaini@canonical.com>
Reply-To: Bug 1721468 <1721468@bugs.launchpad.net>
Sender: bounces@canonical.com
Message-Id: <150719011072.13203.5552998352120576113.malonedeb@wampee.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1721468] [NEW] Free invalid pointer crash in vnc
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

Attempt to send qemu monitor command crashed the VM. I have sent the
following qemu monitor command to a running instance:

virsh qemu-monitor-command --hmp instance-xxxxxxx 'change vnc none'

At the time I was connected via VNC. Closing my xvncviewer resulted
in a crash of the VM. =


Backtrace:

*** Error in `/usr/bin/qemu-system-x86_64': free(): invalid pointer: 0x0000=
564f887a87e0 ***
=3D=3D=3D=3D=3D=3D=3D Backtrace: =3D=3D=3D=3D=3D=3D=3D=3D=3D
/lib/x86_64-linux-gnu/libc.so.6(+0x777e5)[0x7fa18b38b7e5]
/lib/x86_64-linux-gnu/libc.so.6(+0x8037a)[0x7fa18b39437a]
/lib/x86_64-linux-gnu/libc.so.6(cfree+0x4c)[0x7fa18b39853c]
/usr/bin/qemu-system-x86_64(+0x4b25dd)[0x564f871a75dd]
/usr/bin/qemu-system-x86_64(visit_type_VncServerInfo+0xa2)[0x564f871b9612]
/usr/bin/qemu-system-x86_64(qapi_free_VncServerInfo+0x30)[0x564f871a6be0]
/usr/bin/qemu-system-x86_64(+0x441bca)[0x564f87136bca]
/usr/bin/qemu-system-x86_64(vnc_disconnect_finish+0x37)[0x564f87137bf7]
/usr/bin/qemu-system-x86_64(aio_dispatch+0x68)[0x564f8715dcb8]
/usr/bin/qemu-system-x86_64(+0x45bf9e)[0x564f87150f9e]
/lib/x86_64-linux-gnu/libglib-2.0.so.0(g_main_context_dispatch+0x2a7)[0x7fa=
18c06c197]
/usr/bin/qemu-system-x86_64(main_loop_wait+0x18b)[0x564f8715c5bb]
/usr/bin/qemu-system-x86_64(main+0x17b4)[0x564f86ed64e4]
/lib/x86_64-linux-gnu/libc.so.6(__libc_start_main+0xf0)[0x7fa18b334830]
/usr/bin/qemu-system-x86_64(_start+0x29)[0x564f86edbb79]


Version info:

ii  qemu-system                          1:2.5+dfsg-5ubuntu10.16           =
         amd64        QEMU full system emulation binaries
ii  qemu-system-x86                      1:2.5+dfsg-5ubuntu10.16           =
         amd64        QEMU full system emulation binaries (x86)
ii  qemu-utils                           1:2.5+dfsg-5ubuntu10.16           =
         amd64        QEMU utilities
ii  libvirt-bin                          1.3.1-1ubuntu10.14                =
         amd64        programs for the libvirt library
ii  libvirt0:amd64                       1.3.1-1ubuntu10.14                =
         amd64        library for interfacing with different virtualization=
 systems
ii  nova-compute-libvirt                 2:13.1.4-0ubuntu3                 =
         all          OpenStack Compute - compute node libvirt support
ii  python-libvirt                       1.3.1-1ubuntu1                    =
         amd64        libvirt Python bindings

uname -a
Linux <redacted> 4.10.0-32-generic #36~16.04.1-Ubuntu SMP Wed Aug 9 09:19:0=
2 UTC 2017 x86_64 x86_64 x86_64 GNU/Linux


Qemu startup:

starting up libvirt version: 1.3.1, package: 1ubuntu10.14 (Jorge Niedbalski=
 <jorge.niedbalski@canonical.com> Thu, 10 Aug 2017 22:50:46 -0400), qemu ve=
rsion: 2.5.0 (Debian 1:2.5+dfsg-5ubuntu10.14), hostname: <redacted>
LC_ALL=3DC PATH=3D/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/=
bin QEMU_AUDIO_DRV=3Dnone /usr/bin/qemu-system-x86_64 -name instance-000015=
ea -S -machine pc-i440fx-xenial,accel=3Dkvm,usb=3Doff -cpu Haswell-noTSX,+a=
bm,+pdpe1gb,+rdrand,+f16c,+osxsave,+dca,+pdcm,+xtpr,+tm2,+est,+smx,+vmx,+ds=
_cpl,+dtes64,+pbe,+tm,+ht,+ss,+acpi,+ds,+vme -m 32768 -realtime mlock=3Doff=
 -smp 10,sockets=3D5,cores=3D1,threads=3D2 -object memory-backend-file,id=
=3Dram-node0,prealloc=3Dyes,mem-path=3D/dev/hugepages/libvirt/qemu,share=3D=
yes,size=3D34359738368,host-nodes=3D0,policy=3Dbind -numa node,nodeid=3D0,c=
pus=3D0-9,memdev=3Dram-node0 -uuid 9c2c7bdb-baae-45e7-888f-d090b3d331be -sm=
bios 'type=3D1,manufacturer=3DOpenStack Foundation,product=3DOpenStack Nova=
,version=3D13.1.4,serial=3D24efafa3-b4a7-4489-a06a-17f23a63ff2b,uuid=3D9c2c=
7bdb-baae-45e7-888f-d090b3d331be,family=3DVirtual Machine' -no-user-config =
-nodefaults -chardev socket,id=3Dcharmonitor,path=3D/var/lib/libvirt/qemu/d=
omain-instance-000015ea/monitor.sock,server,nowait -mon chardev=3Dcharmonit=
or,id=3Dmonitor,mode=3Dcontrol -rtc base=3Dutc,driftfix=3Dslew -global kvm-=
pit.lost_tick_policy=3Ddiscard -no-hpet -no-shutdown -boot strict=3Don -dev=
ice piix3-usb-uhci,id=3Dusb,bus=3Dpci.0,addr=3D0x1.0x2 -drive file=3D/srv/n=
ova/instances/9c2c7bdb-baae-45e7-888f-d090b3d331be/disk,format=3Dqcow2,if=
=3Dnone,id=3Ddrive-virtio-disk0,cache=3Dnone -device virtio-blk-pci,scsi=3D=
off,bus=3Dpci.0,addr=3D0xd,drive=3Ddrive-virtio-disk0,id=3Dvirtio-disk0,boo=
tindex=3D1 -drive file=3D/srv/nova/instances/9c2c7bdb-baae-45e7-888f-d090b3=
d331be/disk.eph0,format=3Dqcow2,if=3Dnone,id=3Ddrive-virtio-disk1,cache=3Dn=
one -device virtio-blk-pci,scsi=3Doff,bus=3Dpci.0,addr=3D0xe,drive=3Ddrive-=
virtio-disk1,id=3Dvirtio-disk1 -drive file=3D/srv/nova/instances/9c2c7bdb-b=
aae-45e7-888f-d090b3d331be/disk.swap,format=3Dqcow2,if=3Dnone,id=3Ddrive-vi=
rtio-disk2,cache=3Dnone -device virtio-blk-pci,scsi=3Doff,bus=3Dpci.0,addr=
=3D0xf,drive=3Ddrive-virtio-disk2,id=3Dvirtio-disk2 -drive file=3D/srv/nova=
/instances/9c2c7bdb-baae-45e7-888f-d090b3d331be/disk.config,format=3Draw,if=
=3Dnone,id=3Ddrive-ide0-1-1,readonly=3Don,cache=3Dnone -device ide-cd,bus=
=3Dide.1,unit=3D1,drive=3Ddrive-ide0-1-1,id=3Dide0-1-1 -netdev tap,fd=3D27,=
id=3Dhostnet0,vhost=3Don,vhostfd=3D29 -device virtio-net-pci,netdev=3Dhostn=
et0,id=3Dnet0,mac=3Dfa:16:3e:94:ae:0c,bus=3Dpci.0,addr=3D0x3 -netdev tap,fd=
=3D30,id=3Dhostnet1,vhost=3Don,vhostfd=3D31 -device virtio-net-pci,netdev=
=3Dhostnet1,id=3Dnet1,mac=3Dfa:16:3e:0e:c5:cc,bus=3Dpci.0,addr=3D0x4 -netde=
v tap,fd=3D32,id=3Dhostnet2,vhost=3Don,vhostfd=3D33 -device virtio-net-pci,=
netdev=3Dhostnet2,id=3Dnet2,mac=3Dfa:16:3e:7a:1f:cf,bus=3Dpci.0,addr=3D0x5 =
-netdev tap,fd=3D34,id=3Dhostnet3,vhost=3Don,vhostfd=3D35 -device virtio-ne=
t-pci,netdev=3Dhostnet3,id=3Dnet3,mac=3Dfa:16:3e:70:8a:21,bus=3Dpci.0,addr=
=3D0x6 -netdev tap,fd=3D36,id=3Dhostnet4,vhost=3Don,vhostfd=3D37 -device vi=
rtio-net-pci,netdev=3Dhostnet4,id=3Dnet4,mac=3Dfa:16:3e:41:2a:c9,bus=3Dpci.=
0,addr=3D0x7 -netdev tap,fd=3D38,id=3Dhostnet5,vhost=3Don,vhostfd=3D39 -dev=
ice virtio-net-pci,netdev=3Dhostnet5,id=3Dnet5,mac=3Dfa:16:3e:da:e5:4c,bus=
=3Dpci.0,addr=3D0x8 -netdev tap,fd=3D40,id=3Dhostnet6,vhost=3Don,vhostfd=3D=
41 -device virtio-net-pci,netdev=3Dhostnet6,id=3Dnet6,mac=3Dfa:16:3e:c5:0f:=
8d,bus=3Dpci.0,addr=3D0x9 -netdev tap,fd=3D42,id=3Dhostnet7,vhost=3Don,vhos=
tfd=3D43 -device virtio-net-pci,netdev=3Dhostnet7,id=3Dnet7,mac=3Dfa:16:3e:=
db:c5:4a,bus=3Dpci.0,addr=3D0xa -netdev tap,fd=3D44,id=3Dhostnet8,vhost=3Do=
n,vhostfd=3D45 -device virtio-net-pci,netdev=3Dhostnet8,id=3Dnet8,mac=3Dfa:=
16:3e:9f:b6:15,bus=3Dpci.0,addr=3D0xb -netdev tap,fd=3D46,id=3Dhostnet9,vho=
st=3Don,vhostfd=3D47 -device virtio-net-pci,netdev=3Dhostnet9,id=3Dnet9,mac=
=3Dfa:16:3e:df:f2:0b,bus=3Dpci.0,addr=3D0xc -chardev file,id=3Dcharserial0,=
path=3D/srv/nova/instances/9c2c7bdb-baae-45e7-888f-d090b3d331be/console.log=
 -device isa-serial,chardev=3Dcharserial0,id=3Dserial0 -chardev pty,id=3Dch=
arserial1 -device isa-serial,chardev=3Dcharserial1,id=3Dserial1 -device usb=
-tablet,id=3Dinput0 -vnc 0.0.0.0:0 -k en-us -device cirrus-vga,id=3Dvideo0,=
bus=3Dpci.0,addr=3D0x2 -device virtio-balloon-pci,id=3Dballoon0,bus=3Dpci.0=
,addr=3D0x10 -msg timestamp=3Don
char device redirected to /dev/pts/1 (label charserial1)

** Affects: qemu
     Importance: Undecided
         Status: New


** Tags: canonical-bootstack

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1721468

Title:
  Free invalid pointer crash in vnc

Status in QEMU:
  New

Bug description:
  Attempt to send qemu monitor command crashed the VM. I have sent the
  following qemu monitor command to a running instance:

  virsh qemu-monitor-command --hmp instance-xxxxxxx 'change vnc none'

  At the time I was connected via VNC. Closing my xvncviewer resulted
  in a crash of the VM. =


  Backtrace:

  *** Error in `/usr/bin/qemu-system-x86_64': free(): invalid pointer: 0x00=
00564f887a87e0 ***
  =3D=3D=3D=3D=3D=3D=3D Backtrace: =3D=3D=3D=3D=3D=3D=3D=3D=3D
  /lib/x86_64-linux-gnu/libc.so.6(+0x777e5)[0x7fa18b38b7e5]
  /lib/x86_64-linux-gnu/libc.so.6(+0x8037a)[0x7fa18b39437a]
  /lib/x86_64-linux-gnu/libc.so.6(cfree+0x4c)[0x7fa18b39853c]
  /usr/bin/qemu-system-x86_64(+0x4b25dd)[0x564f871a75dd]
  /usr/bin/qemu-system-x86_64(visit_type_VncServerInfo+0xa2)[0x564f871b9612]
  /usr/bin/qemu-system-x86_64(qapi_free_VncServerInfo+0x30)[0x564f871a6be0]
  /usr/bin/qemu-system-x86_64(+0x441bca)[0x564f87136bca]
  /usr/bin/qemu-system-x86_64(vnc_disconnect_finish+0x37)[0x564f87137bf7]
  /usr/bin/qemu-system-x86_64(aio_dispatch+0x68)[0x564f8715dcb8]
  /usr/bin/qemu-system-x86_64(+0x45bf9e)[0x564f87150f9e]
  /lib/x86_64-linux-gnu/libglib-2.0.so.0(g_main_context_dispatch+0x2a7)[0x7=
fa18c06c197]
  /usr/bin/qemu-system-x86_64(main_loop_wait+0x18b)[0x564f8715c5bb]
  /usr/bin/qemu-system-x86_64(main+0x17b4)[0x564f86ed64e4]
  /lib/x86_64-linux-gnu/libc.so.6(__libc_start_main+0xf0)[0x7fa18b334830]
  /usr/bin/qemu-system-x86_64(_start+0x29)[0x564f86edbb79]

  =

  Version info:

  ii  qemu-system                          1:2.5+dfsg-5ubuntu10.16         =
           amd64        QEMU full system emulation binaries
  ii  qemu-system-x86                      1:2.5+dfsg-5ubuntu10.16         =
           amd64        QEMU full system emulation binaries (x86)
  ii  qemu-utils                           1:2.5+dfsg-5ubuntu10.16         =
           amd64        QEMU utilities
  ii  libvirt-bin                          1.3.1-1ubuntu10.14              =
           amd64        programs for the libvirt library
  ii  libvirt0:amd64                       1.3.1-1ubuntu10.14              =
           amd64        library for interfacing with different virtualizati=
on systems
  ii  nova-compute-libvirt                 2:13.1.4-0ubuntu3               =
           all          OpenStack Compute - compute node libvirt support
  ii  python-libvirt                       1.3.1-1ubuntu1                  =
           amd64        libvirt Python bindings

  uname -a
  Linux <redacted> 4.10.0-32-generic #36~16.04.1-Ubuntu SMP Wed Aug 9 09:19=
:02 UTC 2017 x86_64 x86_64 x86_64 GNU/Linux

  =

  Qemu startup:

  starting up libvirt version: 1.3.1, package: 1ubuntu10.14 (Jorge Niedbals=
ki <jorge.niedbalski@canonical.com> Thu, 10 Aug 2017 22:50:46 -0400), qemu =
version: 2.5.0 (Debian 1:2.5+dfsg-5ubuntu10.14), hostname: <redacted>
  LC_ALL=3DC PATH=3D/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin=
:/bin QEMU_AUDIO_DRV=3Dnone /usr/bin/qemu-system-x86_64 -name instance-0000=
15ea -S -machine pc-i440fx-xenial,accel=3Dkvm,usb=3Doff -cpu Haswell-noTSX,=
+abm,+pdpe1gb,+rdrand,+f16c,+osxsave,+dca,+pdcm,+xtpr,+tm2,+est,+smx,+vmx,+=
ds_cpl,+dtes64,+pbe,+tm,+ht,+ss,+acpi,+ds,+vme -m 32768 -realtime mlock=3Do=
ff -smp 10,sockets=3D5,cores=3D1,threads=3D2 -object memory-backend-file,id=
=3Dram-node0,prealloc=3Dyes,mem-path=3D/dev/hugepages/libvirt/qemu,share=3D=
yes,size=3D34359738368,host-nodes=3D0,policy=3Dbind -numa node,nodeid=3D0,c=
pus=3D0-9,memdev=3Dram-node0 -uuid 9c2c7bdb-baae-45e7-888f-d090b3d331be -sm=
bios 'type=3D1,manufacturer=3DOpenStack Foundation,product=3DOpenStack Nova=
,version=3D13.1.4,serial=3D24efafa3-b4a7-4489-a06a-17f23a63ff2b,uuid=3D9c2c=
7bdb-baae-45e7-888f-d090b3d331be,family=3DVirtual Machine' -no-user-config =
-nodefaults -chardev socket,id=3Dcharmonitor,path=3D/var/lib/libvirt/qemu/d=
omain-instance-000015ea/monitor.sock,server,nowait -mon chardev=3Dcharmonit=
or,id=3Dmonitor,mode=3Dcontrol -rtc base=3Dutc,driftfix=3Dslew -global kvm-=
pit.lost_tick_policy=3Ddiscard -no-hpet -no-shutdown -boot strict=3Don -dev=
ice piix3-usb-uhci,id=3Dusb,bus=3Dpci.0,addr=3D0x1.0x2 -drive file=3D/srv/n=
ova/instances/9c2c7bdb-baae-45e7-888f-d090b3d331be/disk,format=3Dqcow2,if=
=3Dnone,id=3Ddrive-virtio-disk0,cache=3Dnone -device virtio-blk-pci,scsi=3D=
off,bus=3Dpci.0,addr=3D0xd,drive=3Ddrive-virtio-disk0,id=3Dvirtio-disk0,boo=
tindex=3D1 -drive file=3D/srv/nova/instances/9c2c7bdb-baae-45e7-888f-d090b3=
d331be/disk.eph0,format=3Dqcow2,if=3Dnone,id=3Ddrive-virtio-disk1,cache=3Dn=
one -device virtio-blk-pci,scsi=3Doff,bus=3Dpci.0,addr=3D0xe,drive=3Ddrive-=
virtio-disk1,id=3Dvirtio-disk1 -drive file=3D/srv/nova/instances/9c2c7bdb-b=
aae-45e7-888f-d090b3d331be/disk.swap,format=3Dqcow2,if=3Dnone,id=3Ddrive-vi=
rtio-disk2,cache=3Dnone -device virtio-blk-pci,scsi=3Doff,bus=3Dpci.0,addr=
=3D0xf,drive=3Ddrive-virtio-disk2,id=3Dvirtio-disk2 -drive file=3D/srv/nova=
/instances/9c2c7bdb-baae-45e7-888f-d090b3d331be/disk.config,format=3Draw,if=
=3Dnone,id=3Ddrive-ide0-1-1,readonly=3Don,cache=3Dnone -device ide-cd,bus=
=3Dide.1,unit=3D1,drive=3Ddrive-ide0-1-1,id=3Dide0-1-1 -netdev tap,fd=3D27,=
id=3Dhostnet0,vhost=3Don,vhostfd=3D29 -device virtio-net-pci,netdev=3Dhostn=
et0,id=3Dnet0,mac=3Dfa:16:3e:94:ae:0c,bus=3Dpci.0,addr=3D0x3 -netdev tap,fd=
=3D30,id=3Dhostnet1,vhost=3Don,vhostfd=3D31 -device virtio-net-pci,netdev=
=3Dhostnet1,id=3Dnet1,mac=3Dfa:16:3e:0e:c5:cc,bus=3Dpci.0,addr=3D0x4 -netde=
v tap,fd=3D32,id=3Dhostnet2,vhost=3Don,vhostfd=3D33 -device virtio-net-pci,=
netdev=3Dhostnet2,id=3Dnet2,mac=3Dfa:16:3e:7a:1f:cf,bus=3Dpci.0,addr=3D0x5 =
-netdev tap,fd=3D34,id=3Dhostnet3,vhost=3Don,vhostfd=3D35 -device virtio-ne=
t-pci,netdev=3Dhostnet3,id=3Dnet3,mac=3Dfa:16:3e:70:8a:21,bus=3Dpci.0,addr=
=3D0x6 -netdev tap,fd=3D36,id=3Dhostnet4,vhost=3Don,vhostfd=3D37 -device vi=
rtio-net-pci,netdev=3Dhostnet4,id=3Dnet4,mac=3Dfa:16:3e:41:2a:c9,bus=3Dpci.=
0,addr=3D0x7 -netdev tap,fd=3D38,id=3Dhostnet5,vhost=3Don,vhostfd=3D39 -dev=
ice virtio-net-pci,netdev=3Dhostnet5,id=3Dnet5,mac=3Dfa:16:3e:da:e5:4c,bus=
=3Dpci.0,addr=3D0x8 -netdev tap,fd=3D40,id=3Dhostnet6,vhost=3Don,vhostfd=3D=
41 -device virtio-net-pci,netdev=3Dhostnet6,id=3Dnet6,mac=3Dfa:16:3e:c5:0f:=
8d,bus=3Dpci.0,addr=3D0x9 -netdev tap,fd=3D42,id=3Dhostnet7,vhost=3Don,vhos=
tfd=3D43 -device virtio-net-pci,netdev=3Dhostnet7,id=3Dnet7,mac=3Dfa:16:3e:=
db:c5:4a,bus=3Dpci.0,addr=3D0xa -netdev tap,fd=3D44,id=3Dhostnet8,vhost=3Do=
n,vhostfd=3D45 -device virtio-net-pci,netdev=3Dhostnet8,id=3Dnet8,mac=3Dfa:=
16:3e:9f:b6:15,bus=3Dpci.0,addr=3D0xb -netdev tap,fd=3D46,id=3Dhostnet9,vho=
st=3Don,vhostfd=3D47 -device virtio-net-pci,netdev=3Dhostnet9,id=3Dnet9,mac=
=3Dfa:16:3e:df:f2:0b,bus=3Dpci.0,addr=3D0xc -chardev file,id=3Dcharserial0,=
path=3D/srv/nova/instances/9c2c7bdb-baae-45e7-888f-d090b3d331be/console.log=
 -device isa-serial,chardev=3Dcharserial0,id=3Dserial0 -chardev pty,id=3Dch=
arserial1 -device isa-serial,chardev=3Dcharserial1,id=3Dserial1 -device usb=
-tablet,id=3Dinput0 -vnc 0.0.0.0:0 -k en-us -device cirrus-vga,id=3Dvideo0,=
bus=3Dpci.0,addr=3D0x2 -device virtio-balloon-pci,id=3Dballoon0,bus=3Dpci.0=
,addr=3D0x10 -msg timestamp=3Don
  char device redirected to /dev/pts/1 (label charserial1)

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1721468/+subscriptions
