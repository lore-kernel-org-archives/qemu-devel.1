Received: from eggs.gnu.org ([2001:4830:134:3::10]:58893)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cTSWc-0006Ih-Sz
	for qemu-devel@nongnu.org; Tue, 17 Jan 2017 07:06:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cTSWZ-0001Na-24
	for qemu-devel@nongnu.org; Tue, 17 Jan 2017 07:06:06 -0500
Received: from indium.canonical.com ([91.189.90.7]:43398)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1cTSWY-0001NM-SY
	for qemu-devel@nongnu.org; Tue, 17 Jan 2017 07:06:02 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1cTSWY-0001xw-2v
	for <qemu-devel@nongnu.org>; Tue, 17 Jan 2017 12:06:02 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 13A022E80AE
	for <qemu-devel@nongnu.org>; Tue, 17 Jan 2017 12:06:02 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 17 Jan 2017 11:50:09 -0000
From: Thomas Huth <1618431@bugs.launchpad.net>
Reply-To: Bug 1618431 <1618431@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20160830115830.15931.71622.malonedeb@soybean.canonical.com>
Message-Id: <20170117115009.27129.11345.malone@chaenomeles.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1618431] Re: windows hangs after live migration
 with virtio
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

The patches should be part of QEMU v2.8 =3D=3D> Fix released

** Changed in: qemu
       Status: Fix Committed =3D> Fix Released

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1618431

Title:
  windows hangs after live migration with virtio

Status in QEMU:
  Fix Released

Bug description:
  Several of our users reported problems with windows machines hanging
  after live migrations. The common denominator _seems_ to be virtio
  devices.
  I've managed to reproduce this reliably on a windows 10 (+
  virtio-win-0.1.118) guest, always within 1 to 5 migrations, with a
  virtio-scsi hard drive and a virtio-net network device. (When I
  replace the virtio-net device with an e1000 it takes 10 or more
  migrations, and without virtio devices I have not (yet) been able to
  reproduce this problem. I also could not reproduce this with a linux
  guest. Also spice seems to improve the situation, but doesn't solve
  it completely).

  I've tested quite a few tags from qemu-git (v2.2.0 through v2.6.1,
  and 2.6.1 with the patches mentioned on qemu-stable by Peter Lieven)
  and the behavior is the same everywhere.

  The reproducibility seems to be somewhat dependent on the host
  hardware, which makes investigating this issue that much harder.

  Symptoms:
  After the migration the windows graphics stack just hangs.
  Background processes are still running (eg. after installing an ssh
  server I could still login and get a command prompt after the hang was
  triggered... not that I'd know what to do with that on a windows
  machine...) - commands which need no GUI access work, the rest just
  hangs there on the command line, too.
  It's also capable of responding to an NMI sent via the qemu monitor:
  it then seems to "recover" and manages to show the blue sad-face
  screen that something happened, reboots successfully and is usable
  again without restarting the qemu process in between.
  From there whole the process can be repeated.

  Here's what our command line usually looks like:

  /usr/bin/qemu -daemonize \
  	-enable-kvm \
  	-chardev socket,id=3Dqmp,path=3D/var/run/qemu-server/101.qmp,server,nowa=
it -mon chardev=3Dqmp,mode=3Dcontrol \
  	-pidfile /var/run/qemu-server/101.pid \
  	-smbios type=3D1,uuid=3D07fc916e-24c2-4eef-9827-4ab4026501d4 \
  	-name win10 \
  	-smp 6,sockets=3D1,cores=3D6,maxcpus=3D6 \
  	-nodefaults \
  	-boot menu=3Don,strict=3Don,reboot-timeout=3D1000 \
  	-vga std \
  	-vnc unix:/var/run/qemu-server/101.vnc \
  	-no-hpet \
  	-cpu kvm64,hv_spinlocks=3D0x1fff,hv_vapic,hv_time,hv_reset,hv_vpindex,hv=
_runtime,hv_relaxed,+lahf_lm,+sep,+kvm_pv_unhalt,+kvm_pv_eoi,enforce \
  	-m 2048 \
  	-device pci-bridge,id=3Dpci.2,chassis_nr=3D2,bus=3Dpci.0,addr=3D0x1f \
  	-device pci-bridge,id=3Dpci.1,chassis_nr=3D1,bus=3Dpci.0,addr=3D0x1e \
  	-device piix3-usb-uhci,id=3Duhci,bus=3Dpci.0,addr=3D0x1.0x2 \
  	-device usb-tablet,id=3Dtablet,bus=3Duhci.0,port=3D1 \
  	-device virtio-balloon-pci,id=3Dballoon0,bus=3Dpci.0,addr=3D0x3 \
  	-iscsi initiator-name=3Diqn.1993-08.org.debian:01:1ba48d46fb8 \
  	-drive if=3Dnone,id=3Ddrive-ide0,media=3Dcdrom,aio=3Dthreads \
  	-device ide-cd,bus=3Dide.0,unit=3D0,drive=3Ddrive-ide0,id=3Dide0,bootind=
ex=3D200 \
  	-device virtio-scsi-pci,id=3Dscsihw0,bus=3Dpci.0,addr=3D0x5 \
  	-drive file=3D/mnt/pve/data1/images/101/vm-101-disk-1.qcow2,if=3Dnone,id=
=3Ddrive-scsi0,cache=3Dwriteback,discard=3Don,format=3Dqcow2,aio=3Dthreads,=
detect-zeroes=3Dunmap \
  	-device scsi-hd,bus=3Dscsihw0.0,channel=3D0,scsi-id=3D0,lun=3D0,drive=3D=
drive-scsi0,id=3Dscsi0,bootindex=3D100 \
  	-netdev type=3Dtap,id=3Dnet0,ifname=3Dtap101i0,script=3D/var/lib/qemu-se=
rver/pve-bridge,downscript=3D/var/lib/qemu-server/pve-bridgedown,vhost=3Don=
 \
  	-device virtio-net-pci,mac=3DF2:2B:20:37:E6:D7,netdev=3Dnet0,bus=3Dpci.0=
,addr=3D0x12,id=3Dnet0,bootindex=3D300 \
  	-rtc driftfix=3Dslew,base=3Dlocaltime \
  	-global kvm-pit.lost_tick_policy=3Ddiscard

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1618431/+subscriptions
