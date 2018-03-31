Received: from eggs.gnu.org ([2001:4830:134:3::10]:50450)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1f2KnE-00017h-Oh
	for qemu-devel@nongnu.org; Sat, 31 Mar 2018 13:59:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1f2KnB-0007Pn-MS
	for qemu-devel@nongnu.org; Sat, 31 Mar 2018 13:59:56 -0400
Received: from indium.canonical.com ([91.189.90.7]:60916)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1f2KnB-0007Od-F8
	for qemu-devel@nongnu.org; Sat, 31 Mar 2018 13:59:53 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1f2KnA-0003MC-98
	for <qemu-devel@nongnu.org>; Sat, 31 Mar 2018 17:59:52 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 400882E80D2
	for <qemu-devel@nongnu.org>; Sat, 31 Mar 2018 17:59:52 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Sat, 31 Mar 2018 17:48:00 -0000
From: Andreas Gustafsson <gson@gson.org>
Reply-To: Bug 1481272 <1481272@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20150804095638.25012.1470.malonedeb@chaenomeles.canonical.com>
Message-Id: <152251848077.2846.11194735289406662946.malone@wampee.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1481272] Re: main-loop: WARNING: I/O thread spun
 for 1000 iterations
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

I no longer see the "WARNING: I/O thread spun for 1000 iterations"
message.  A bisection showed that it disappeared with the following
commit:

commit e330c118f2a5a5365409b123cd0dd2c7d575bf05
Author: Paolo Bonzini <pbonzini@redhat.com>
Date:   Fri Mar 3 11:51:07 2017 +0100

    main-loop: remove now unnecessary optimization

    This optimization is not necessary anymore, because the vCPU now drops
    the I/O thread lock even with TCG.  Drop it to simplify the code and
    avoid the "I/O thread spun for 1000 iterations" warning.

    Reviewed-by: Alex Benn=C3=83=C2=A9e <alex.bennee@linaro.org>
    Reviewed-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
    Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>

The amount of system time consumed by the qemu process, which had
incrased 300-fold with commit 05e514b1d4d5bd4209e2c8bbc76ff05c85a235f3,
is also back to normal.

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1481272

Title:
  main-loop: WARNING: I/O thread spun for 1000 iterations

Status in QEMU:
  New

Bug description:
  I compile the latest qemu to launch a VM but the monitor output the
  "main-loop: WARNING: I/O thread spun for 1000 iterations".

  # /usr/local/bin/qemu-system-x86_64 -name rhel6 -S -no-kvm -m 1024M -real=
time mlock=3Doff -smp 1,sockets=3D1,cores=3D1,threads=3D1 -uuid c9dd2a5c-40=
f2-fd3d-3c54-9cd84f8b9174 -rtc base=3Dutc  -drive file=3D/home/samba-share/=
ubuntu.img,if=3Dnone,id=3Ddrive-virtio-disk0,format=3Dqcow2,cache=3Dnone -d=
evice virtio-blk-pci,bus=3Dpci.0,addr=3D0x4,drive=3Ddrive-virtio-disk0,id=
=3Ddisk,serial=3D425618d4-871f-4021-bc5d-bcd7f1b5ca9c,bootindex=3D0 -vnc :1=
 -boot menu=3Don -monitor stdio
  QEMU 2.3.93 monitor - type 'help' for more information
  (qemu) c
  (qemu) main-loop: WARNING: I/O thread spun for 1000 iterations           =
    <-----------------------

  qemu]# git branch -v
  * master               e95edef Merge remote-tracking branch 'remotes/ssta=
bellini/tags/xen-migration-2.4-tag' into staging

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1481272/+subscriptions
