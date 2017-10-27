Received: from eggs.gnu.org ([2001:4830:134:3::10]:44326)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1e8BHM-0000J8-Us
	for qemu-devel@nongnu.org; Fri, 27 Oct 2017 16:30:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1e8BHJ-0001Jg-QB
	for qemu-devel@nongnu.org; Fri, 27 Oct 2017 16:30:56 -0400
Received: from indium.canonical.com ([91.189.90.7]:48106)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1e8BHJ-0001JI-Jc
	for qemu-devel@nongnu.org; Fri, 27 Oct 2017 16:30:53 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1e8BHI-00065f-8k
	for <qemu-devel@nongnu.org>; Fri, 27 Oct 2017 20:30:52 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 40E6A2E80CC
	for <qemu-devel@nongnu.org>; Fri, 27 Oct 2017 20:30:52 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Fri, 27 Oct 2017 20:16:12 -0000
From: Erik Rull <1366836@bugs.launchpad.net>
Reply-To: Bug 1366836 <1366836@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20140908144705.25513.64209.malonedeb@soybean.canonical.com>
Message-Id: <150913537288.4957.844270521541541262.malone@chaenomeles.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1366836] Re: Core2Duo and KVM may not boot Win8
 properly on 3.x kernels
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Please close it, it's solved with this patch commit to kvm / kernel:
Was found and fixed with great support of Paolo Bonzini

From: Paolo Bonzini
Date: Thu, 12 Feb 2015 17:04:47 +0100
Subject: KVM: emulate: fix CMPXCHG8B on 32-bit hosts

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1366836

Title:
  Core2Duo and KVM may not boot Win8 properly on 3.x kernels

Status in QEMU:
  Incomplete

Bug description:
  When I start up QEMU w/ KVM 1.7.0 on a Core2Duo machine running a vanilla=
 kernel 3.4.67 or 3.10.12 to run a Windows 8.0 guest, the guest freezes at =
Windows 8 boot without any error.
  When I dump the CPU registers via "info registers", nothing changes, that=
 means the system really stalled. Same happens with QEMU 2.0.0 and QEMU 2.1=
.0.
  It stalls when the Windows logo is displayed and the balled circle starts=
 rotating.

  But - when I run the very same guest using Kernel 2.6.32.12 and QEMU
  1.7.0 or 2.0.0 on the host side it works on the Core2Duo. Also the
  system above but just with an i3 or i5 CPU it works fine.

  I already disabled networking and USB for the guest and changed the graph=
ics
  card - no effect. I assume that some mean bits and bytes have to be set up
  properly to get the thing running.

  Seems to be related to a kvm/processor incompatibility.

  Windows XP runs on all combinations without any issues. Windows 8.1
  guests have the same issues as Windows 8.0.

  An example command line that does not boot Windows 8 is:
  qemu-system-x86_64 -machine pc-i440fx-1.5,accel=3Dkvm,kernel_irqchip=3Dof=
f -daemonize -cpu kvm32,+sep,+nx -nodefaults -vga std -readconfig /usr/X11R=
6/X11etc/ich9-ehci-uhci.cfg -device usb-host,bus=3Dehci.0,hostport=3D1.2 -d=
evice usb-tablet -drive file=3D/dev/sdb,cache=3Dwritethrough,if=3Dnone,id=
=3Dx -device ide-drive,drive=3Dx -m 1024 -monitor telnet:127.0.0.1:5100,now=
ait,server -vnc :1 -L /usr/X11R6/share/qemu -boot c -localtime -enable-kvm =
-no-shutdown

  enabling the kernel_irqchip, removing the sep, disabling usb, changing
  the machine type or changing the monitor type (SDL or VNC) has no
  effect.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1366836/+subscriptions
