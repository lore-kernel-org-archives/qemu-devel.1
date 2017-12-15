Received: from eggs.gnu.org ([2001:4830:134:3::10]:60791)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1ePsQj-000739-9E
	for qemu-devel@nongnu.org; Fri, 15 Dec 2017 11:01:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1ePsQf-00048m-DO
	for qemu-devel@nongnu.org; Fri, 15 Dec 2017 11:01:45 -0500
Received: from indium.canonical.com ([91.189.90.7]:48552)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1ePsQd-000470-Fx
	for qemu-devel@nongnu.org; Fri, 15 Dec 2017 11:01:41 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1ePsQO-0008HK-FA
	for <qemu-devel@nongnu.org>; Fri, 15 Dec 2017 16:01:25 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id D15772E81C1
	for <qemu-devel@nongnu.org>; Fri, 15 Dec 2017 16:01:19 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Fri, 15 Dec 2017 15:53:02 -0000
From: Thomas Huth <1718118@bugs.launchpad.net>
Reply-To: Bug 1718118 <1718118@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <150580625533.32282.1265641231641467649.malonedeb@soybean.canonical.com>
Message-Id: <151335318285.26077.10812705741771225081.malone@wampee.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1718118] Re: qemu crashes with
 hw/ppc/spapr_drc.c:417:spapr_drc_detach: assertion failed: (drc->dev)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Fix has been released with QEMU 2.11:
https://git.qemu.org/?p=3Dqemu.git;a=3Dcommitdiff;h=3D2a129767ebb13ffc29dad

** Changed in: qemu
       Status: New =3D> Fix Released

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1718118

Title:
  qemu crashes with hw/ppc/spapr_drc.c:417:spapr_drc_detach: assertion
  failed: (drc->dev)

Status in QEMU:
  Fix Released

Bug description:
  Qemu crashes with error "hw/ppc/spapr_drc.c:417:spapr_drc_detach:
  assertion failed: (drc->dev)" when memory hotplug and hotunplug was
  done continuously.

  Steps to re-produce:
  1. git clone (today's i.e 19th Sept)
  2. Bring up ppc64le guest with memory hotplug capabilities ( I used libvi=
rt xml to do this).
  3. And do continuous memory hotplug and unplug using the following memory=
 xml (mem_hp_8g.xml)
  <memory model=3D'dimm'>
  <target>
  <size unit=3D'KiB'>8388608</size>
  <node>1</node>
  </target>
  </memory>
  4. Run the following =

  for i in `seq 1 100`; do virsh attach-device nrs mem_hp_8g.xml --live; vi=
rsh detach-device nrs mem_hp_8g.xml --live; done
  5. Guest will crash
  6. Following is from qemu log

  LC_ALL=3DC PATH=3D/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin QEMU_=
AUDIO_DRV=3Dnone /usr/local/bin/qemu-system-ppc64 -name guest=3Dnrs,debug-t=
hreads=3Don -S -object secret,id=3DmasterKey0,format=3Draw,file=3D/var/lib/=
libvirt/qemu/domain-19-nrs/master-key.aes -machine pseries-2.10,accel=3Dkvm=
,usb=3Doff,dump-guest-core=3Doff -m size=3D8388608k,slots=3D256,maxmem=3D41=
9430400k -realtime mlock=3Doff -smp 4,sockets=3D4,cores=3D1,threads=3D1 -nu=
ma node,nodeid=3D0,cpus=3D0-1,mem=3D4096 -numa node,nodeid=3D1,cpus=3D2-3,m=
em=3D4096 -uuid d7987973-2467-43ff-b8d2-acefc6ac59e5 -display none -no-user=
-config -nodefaults -chardev socket,id=3Dcharmonitor,path=3D/var/lib/libvir=
t/qemu/domain-19-nrs/monitor.sock,server,nowait -mon chardev=3Dcharmonitor,=
id=3Dmonitor,mode=3Dcontrol -rtc base=3Dutc -no-shutdown -boot strict=3Don =
-device qemu-xhci,id=3Dusb,bus=3Dpci.0,addr=3D0x3 -device virtio-scsi-pci,i=
d=3Dscsi0,bus=3Dpci.0,addr=3D0x2 -drive file=3D/home/nasastry/pegas-1.0-ppc=
64le.qcow2,format=3Dqcow2,if=3Dnone,id=3Ddrive-scsi0-0-0-0 -device scsi-hd,=
bus=3Dscsi0.0,channel=3D0,scsi-id=3D0,lun=3D0,drive=3Ddrive-scsi0-0-0-0,id=
=3Dscsi0-0-0-0,bootindex=3D1 -netdev tap,fd=3D28,id=3Dhostnet0,vhost=3Don,v=
hostfd=3D30 -device virtio-net-pci,netdev=3Dhostnet0,id=3Dnet0,mac=3D52:54:=
00:89:8a:8b,bus=3Dpci.0,addr=3D0x1 -chardev pty,id=3Dcharserial0 -device sp=
apr-vty,chardev=3Dcharserial0,reg=3D0x30000000 -device virtio-balloon-pci,i=
d=3Dballoon0,bus=3Dpci.0,addr=3D0x4 -s -msg timestamp=3Don
  2017-09-19 06:59:07.878+0000: Domain id=3D19 is tainted: custom-argv
  2017-09-19T06:59:07.918273Z qemu-system-ppc64: -chardev pty,id=3Dcharseri=
al0: char device redirected to /dev/pts/5 (label charserial0)
  **
  ERROR:/home/nasastry/qemu/hw/ppc/spapr_drc.c:417:spapr_drc_detach: assert=
ion failed: (drc->dev)
  2017-09-19 06:59:51.428+0000: shutting down, reason=3Dcrashed

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1718118/+subscriptions
