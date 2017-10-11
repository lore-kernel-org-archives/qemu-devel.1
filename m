Received: from eggs.gnu.org ([2001:4830:134:3::10]:53182)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1e2MFc-00036U-S4
	for qemu-devel@nongnu.org; Wed, 11 Oct 2017 15:01:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1e2MFZ-0007Gd-R7
	for qemu-devel@nongnu.org; Wed, 11 Oct 2017 15:01:04 -0400
Received: from indium.canonical.com ([91.189.90.7]:40732)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1e2MFZ-0007GB-KM
	for qemu-devel@nongnu.org; Wed, 11 Oct 2017 15:01:01 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1e2MFY-0001qN-A3
	for <qemu-devel@nongnu.org>; Wed, 11 Oct 2017 19:01:00 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 4A2072E80C7
	for <qemu-devel@nongnu.org>; Wed, 11 Oct 2017 19:01:00 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 11 Oct 2017 18:52:56 -0000
From: Geoffrey McRae <1722884@bugs.launchpad.net>
Reply-To: Bug 1722884 <1722884@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <150774787109.964.13450141235232669497.malonedeb@chaenomeles.canonical.com>
Message-Id: <150774797681.15993.17479196111110317394.malone@soybean.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1722884] Re: keyboard input while mouse moving
 triggers mouse failure
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Here is a backtrace of the PS2 reset event:

#0  ps2_write_mouse (opaque=3D0x55804518ae30, val=3D255) at /home/geoff/Pro=
jects/qemu/qemu/hw/input/ps2.c:1033
#1  0x00005580420e1dd9 in kbd_write_data (opaque=3D0x558045147aa0, addr=3D0=
, val=3D255, size=3D1) at /home/geoff/Projects/qemu/qemu/hw/input/pckbd.c:3=
57
#2  0x0000558041e7e64f in memory_region_write_accessor (mr=3D0x558045147ae0=
, addr=3D0, value=3D0x7f9ec016f478, size=3D1, shift=3D0, mask=3D255, attrs=
=3D...)
    at /home/geoff/Projects/qemu/qemu/memory.c:560                         =
                                                                   =

#3  0x0000558041e7e867 in access_with_adjusted_size (addr=3D0, value=3D0x7f=
9ec016f478, size=3D1, access_size_min=3D1, access_size_max=3D1,
    access_fn=3D0x558041e7e565 <memory_region_write_accessor>, mr=3D0x55804=
5147ae0, attrs=3D...) at /home/geoff/Projects/qemu/qemu/memory.c:627
#4  0x0000558041e814e9 in memory_region_dispatch_write (mr=3D0x558045147ae0=
, addr=3D0, data=3D255, size=3D1, attrs=3D...)
    at /home/geoff/Projects/qemu/qemu/memory.c:1503                        =
                                    =

#5  0x0000558041e31302 in flatview_write_continue (fv=3D0x7f9e90010c10, add=
r=3D96, attrs=3D..., buf=3D0x7f9eee9de000 "\377\006", len=3D1, addr1=3D0, l=
=3D1,
    mr=3D0x558045147ae0) at /home/geoff/Projects/qemu/qemu/exec.c:2900     =
                                                                    =

#6  0x0000558041e31450 in flatview_write (fv=3D0x7f9e90010c10, addr=3D96, a=
ttrs=3D..., buf=3D0x7f9eee9de000 "\377\006", len=3D1)
    at /home/geoff/Projects/qemu/qemu/exec.c:2945                          =
                                           =

#7  0x0000558041e31827 in flatview_rw (fv=3D0x7f9e90010c10, addr=3D96, attr=
s=3D..., buf=3D0x7f9eee9de000 "\377\006", len=3D1, is_write=3Dtrue)
    at /home/geoff/Projects/qemu/qemu/exec.c:3054                          =
                                                       =

#8  0x0000558041e318df in address_space_rw (as=3D0x558042a4c940 <address_sp=
ace_io>, addr=3D96, attrs=3D..., buf=3D0x7f9eee9de000 "\377\006", len=3D1, =
is_write=3Dtrue)
    at /home/geoff/Projects/qemu/qemu/exec.c:3064                          =
                                                                           =
    =

#9  0x0000558041e9617e in kvm_handle_io (port=3D96, attrs=3D..., data=3D0x7=
f9eee9de000, direction=3D1, size=3D1, count=3D1)
    at /home/geoff/Projects/qemu/qemu/accel/kvm/kvm-all.c:1698             =
                                    =

#10 0x0000558041e968c2 in kvm_cpu_exec (cpu=3D0x5580444f4650) at /home/geof=
f/Projects/qemu/qemu/accel/kvm/kvm-all.c:1938
#11 0x0000558041e670d9 in qemu_kvm_cpu_thread_fn (arg=3D0x5580444f4650) at =
/home/geoff/Projects/qemu/qemu/cpus.c:1128
#12 0x00007f9ed49c5494 in start_thread (arg=3D0x7f9ec0172700) at pthread_cr=
eate.c:333
#13 0x00007f9ed4707aff in clone () at ../sysdeps/unix/sysv/linux/x86_64/clo=
ne.S:97

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1722884

Title:
  keyboard input while mouse moving triggers mouse failure

Status in QEMU:
  New

Bug description:
  When QEMU is getting a ton of mouse input events if keys are pressed
  on the keyboard the scan code will be corrupted causing erroneous
  behavior. I have confirmed this problem in the latest version in git
  (530049bc1dcc24c1178a29d99ca08b6dd08413e0).

  After the erroneous behavior the operating system issues a keyboard
  reset which prevents the mouse from functioning until the operating
  system is restarted.

  This seems to only occur if the PS2 mouse is being used as the input,
  the tablet input device doesn't exhibit this behavior.

  The same problem was reported here also:
  https://openxt.atlassian.net/browse/OXT-562

  Host  : Debian 9
  CPU   : Ryzen 1700X
  RAM   : 16GB
  Kernel: 4.12.0-0.bpo.2-amd64

  Guest : Windows 10 (KVM)
  RAM   : 8GB (1GB Huge pages)

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1722884/+subscriptions
