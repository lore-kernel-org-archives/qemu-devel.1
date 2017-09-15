Received: from eggs.gnu.org ([2001:4830:134:3::10]:51100)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1dsmex-0005MI-94
	for qemu-devel@nongnu.org; Fri, 15 Sep 2017 05:11:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1dsmes-0007jQ-9P
	for qemu-devel@nongnu.org; Fri, 15 Sep 2017 05:11:39 -0400
Received: from indium.canonical.com ([91.189.90.7]:34343)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1dsmes-0007jF-33
	for qemu-devel@nongnu.org; Fri, 15 Sep 2017 05:11:34 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1dsmep-0004UI-MJ
	for <qemu-devel@nongnu.org>; Fri, 15 Sep 2017 09:11:31 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id A74412E848E
	for <qemu-devel@nongnu.org>; Fri, 15 Sep 2017 09:11:31 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Fri, 15 Sep 2017 08:58:08 -0000
From: Thomas Huth <1679126@bugs.launchpad.net>
Reply-To: Bug 1679126 <1679126@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20170403115539.1125.50319.malonedeb@gac.canonical.com>
Message-Id: <150546588816.16396.1067756252610723611.malone@soybean.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1679126] Re: null pointer access on migration
 resume of systemrescuecd boot menu with qxl-vga
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

The fix has apparently been included here:
https://git.qemu.org/?p=3Dqemu.git;a=3Dcommitdiff;h=3Da703d3aef5991b72a5a45=
880e7491232b8032f09
... and has been released with QEMU v2.9 already.

** Changed in: qemu
       Status: Confirmed =3D> Fix Released

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1679126

Title:
  null pointer access on migration resume of systemrescuecd boot menu
  with qxl-vga

Status in QEMU:
  Fix Released

Bug description:
  With qemu-2.8.0 up to 2.9.0-rc2 and git master (6954cdc), when
  resuming from a migration state file created from a VM suspended while
  showing the System Rescue CD 4.9.2 boot menu and using the QXL VGA
  device, I get a null point access in pixman_image_get_data called from
  qemu_spice_create_update (spice-display.c:215).  When I added
  assert(ssd->mirror !=3D NULL) above that line, assert failed.  I don't
  get the crash when using standard VGA or cirrus-vga.  I am using
  gcc-4.9.3 on Gentoo x86_64 with Intel i7-4700HQ CPU and kernel:
  4.9.15-gentoo.

  Here is the valgrind trace from the git version:
  =3D=3D2634=3D=3D Thread 1:
  =3D=3D2634=3D=3D Invalid read of size 4
  =3D=3D3516=3D=3D    at 0x65F3050: pixman_image_get_data (in /usr/lib64/li=
bpixman-1.so.0.34.0)
  =3D=3D3516=3D=3D    by 0x6F0CEB: qemu_spice_create_update (spice-display.=
c:215)
  =3D=3D3516=3D=3D    by 0x6F1CC7: qemu_spice_display_refresh (spice-displa=
y.c:502)
  =3D=3D3516=3D=3D    by 0x58CF77: display_refresh (qxl.c:1948)
  =3D=3D3516=3D=3D    by 0x6E8084: do_safe_dpy_refresh (console.c:1591)
  =3D=3D3516=3D=3D    by 0x6E80D5: dpy_refresh (console.c:1604)
  =3D=3D3516=3D=3D    by 0x6E4508: gui_update (console.c:201)
  =3D=3D3516=3D=3D    by 0x81898E: timerlist_run_timers (qemu-timer.c:536)
  =3D=3D3516=3D=3D    by 0x8189D6: qemu_clock_run_timers (qemu-timer.c:547)
  =3D=3D3516=3D=3D    by 0x818D98: qemu_clock_run_all_timers (qemu-timer.c:=
662)
  =3D=3D3516=3D=3D    by 0x81952A: main_loop_wait (main-loop.c:514)
  =3D=3D3516=3D=3D    by 0x4ADD29: main_loop (vl.c:1898)

  Minimal steps to reproduce:

  Compile (debug compile flags are just so valgrind works, the crash occurs=
 with non-debug compile flags as well):
  CFLAGS=3D"-g -O0" CXXFLAGS=3D"-g -O0" ./configure --target-list=3Di386-so=
ftmmu,x86_64-softmmu
  ./configure
  make

  Start VM and leave it on the System Rescue CD graphical boot menu:
  x86_64-softmmu/qemu-system-x86_64 -nodefaults -machine pc -drive file=3Ds=
ystemrescuecd-x86-4.9.2.iso,if=3Dnone,id=3Dcdrom-cd,readonly=3Don -device i=
de-cd,bus=3Dide.0,drive=3Dcdrom-cd,bootindex=3D1 -device qxl-vga -monitor u=
nix:monitor.sock,server,nowait -display gtk

  Suspend VM and save state:
  socat - unix:monitor.sock
    stop
    migrate "exec:cat > vm.state"
    quit

  Attempt to resume VM (but this crashes):
  x86_64-softmmu/qemu-system-x86_64 -nodefaults -machine pc -drive file=3Ds=
ystemrescuecd-x86-4.9.2.iso,if=3Dnone,id=3Dcdrom-cd,readonly=3Don -device i=
de-cd,bus=3Dide.0,drive=3Dcdrom-cd,bootindex=3D1 -device qxl-vga -monitor u=
nix:monitor.sock,server,nowait -display gtk -incoming exec:"cat vm.state"

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1679126/+subscriptions
