Received: from eggs.gnu.org ([2001:4830:134:3::10]:37510)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1g0swH-0004sN-Ct
	for qemu-devel@nongnu.org; Fri, 14 Sep 2018 14:35:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1g0swE-0001DP-7J
	for qemu-devel@nongnu.org; Fri, 14 Sep 2018 14:35:33 -0400
Received: from indium.canonical.com ([91.189.90.7]:38340)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1g0swE-0001Ch-0U
	for qemu-devel@nongnu.org; Fri, 14 Sep 2018 14:35:30 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1g0swC-0002Ad-T7
	for <qemu-devel@nongnu.org>; Fri, 14 Sep 2018 18:35:28 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id AE9EA2E8078
	for <qemu-devel@nongnu.org>; Fri, 14 Sep 2018 18:35:28 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Fri, 14 Sep 2018 18:26:21 -0000
From: Marshall Porter <1792523@bugs.launchpad.net>
Reply-To: Bug 1792523 <1792523@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <153690806645.16635.9456702675801152758.malonedeb@chaenomeles.canonical.com>
Message-Id: <153694958174.19439.16867622431010349229.malone@wampee.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1792523] Re: usb passthrough not resetting on
 host after vm shutdown if started with -daemonize
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

The usb-host devices have the problem.

It does not seem to matter if 1 or all 3 are specified.. I had thought
maybe only one of them was causing the issue.. but all of them are
affected if '-daemonize' is specified at startup.

Correct, the vfio-pci device 1:00.x is an Nvidia GPU+audio, and 4:00.0
is an Asmedia USB controller.

But all of the vfio arguments and binding parts of this script can be
removed, and replaced with '-vga std -display gtk' arguments, and the
host has the same behavior of not regaining control of the usb-host
devices until they are unplugged and plugged back in after the VM shuts
down.

No messages appear in dmesg or any stdout from Qemu related to errors or
USB that stand out to me as a problem.. I am happy to try any
suggestions to further narrow down the cause.

Thanks for replying!

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1792523

Title:
  usb passthrough not resetting on host after vm shutdown if started
  with -daemonize

Status in QEMU:
  New

Bug description:
  Below is the full Qemu command used to launch the VM. Have been using
  this same setup since Qemu 2.12, plus a couple of cherry picked patch
  commits fixing ide-hd and e1000e in Windows guests. Both sets of
  patches have now been merged to 3.0, so decided to update to 3.0.

  The VM launches and runs fine, but after shutting down, the usb
  devices that are passed through from the host (keyboard, mouse) do not
  work until unplugged and plugged in again. Have narrowed this down to
  the -daemonize -pidfile arguments.. if those lines are removed, usb
  devices work in the host again right away after VM shutdown.

  CPU: Intel(R) Core(TM) i5-6600K CPU @ 3.50GHz
  OS: Linux dev 4.18.6-arch1-1-ARCH #1 SMP PREEMPT Wed Sep 5 11:54:09 UTC 2=
018 x86_64 GNU/Linux

  Thank you for looking into this!

  =

  #!/usr/bin/env bash

  echo vfio-pci > /sys/bus/pci/devices/0000:04:00.0/driver_override
  echo 0000:04:00.0 > /sys/bus/pci/devices/0000:04:00.0/driver/unbind
  echo 0000:04:00.0 > /sys/bus/pci/drivers/vfio-pci/bind
  echo > /sys/bus/pci/devices/0000:04:00.0/driver_override

  /usr/bin/qemu-system-x86_64 \
  -name winnt \
  -daemonize \
  -pidfile /run/vms/qemu/winnt.pid \
  -boot menu=3Don \
  -drive if=3Dpflash,format=3Draw,readonly,file=3D/opt/vms/qemu/machines/ov=
mf_code_patched.fd \
  -drive if=3Dpflash,format=3Draw,file=3D/opt/vms/qemu/machines/winnt/ovmf_=
vars_patched.fd \
  -machine pc-q35-3.0,accel=3Dkvm \
  -nodefaults \
  -cpu host,kvm=3Doff,hv_vendor_id=3DRedHat,hv_time,hv_relaxed,hv_vapic,hv_=
spinlocks=3D0x1fff \
  -accel kvm \
  -smp 4,sockets=3D1,cores=3D4,threads=3D1 \
  -m 16G \
  -nic bridge,br=3Dbr0,mac=3D52:54:00:12:34:77,model=3De1000e \
  -device vfio-pci,host=3D01:00.0,multifunction=3Don \
  -device vfio-pci,host=3D01:00.1 \
  -vga none \
  -display none \
  -monitor none \
  -blockdev raw,node-name=3Dide-hd.0,cache.direct=3Don,discard=3Dunmap,file=
.driver=3Dhost_device,file.aio=3Dnative,file.filename=3D/dev/disk/by-id/ata=
-WDC_WDS500G2B0A-00SM50_181265803048 \
  -device ide-hd,drive=3Dide-hd.0,bus=3Dide.0,rotation_rate=3D1 \
  -blockdev raw,node-name=3Dide-hd.1,cache.direct=3Don,file.driver=3Dhost_d=
evice,file.aio=3Dnative,file.filename=3D/dev/disk/by-id/ata-TOSHIBA_HDWE160=
_X746K8ZTF56D-part1 \
  -device ide-hd,drive=3Dide-hd.1,bus=3Dide.1 \
  -device vfio-pci,host=3D04:00.0 \
  -device qemu-xhci \
  -device usb-host,vendorid=3D0x04d9,productid=3D0x0171 \
  -device usb-host,vendorid=3D0x1532,productid=3D0x005c \
  -device usb-host,vendorid=3D0x1b1c,productid=3D0x0c09

  echo 0000:04:00.0 > /sys/bus/pci/devices/0000:04:00.0/driver/unbind
  echo 0000:04:00.0 > /sys/bus/pci/drivers_probe

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1792523/+subscriptions
