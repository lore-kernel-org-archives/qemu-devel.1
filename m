Received: from eggs.gnu.org ([2001:4830:134:3::10]:48363)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1dIO0C-00012t-19
	for qemu-devel@nongnu.org; Tue, 06 Jun 2017 19:35:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1dIO06-0002xl-SX
	for qemu-devel@nongnu.org; Tue, 06 Jun 2017 19:35:08 -0400
Received: from indium.canonical.com ([91.189.90.7]:47240)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1dIO06-0002xd-Ln
	for qemu-devel@nongnu.org; Tue, 06 Jun 2017 19:35:02 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1dIO05-0007hS-9A
	for <qemu-devel@nongnu.org>; Tue, 06 Jun 2017 23:35:01 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id E036F2E8195
	for <qemu-devel@nongnu.org>; Tue,  6 Jun 2017 23:35:00 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 06 Jun 2017 23:17:35 -0000
From: ChristianEhrhardt <1319100@bugs.launchpad.net>
Reply-To: Bug 1319100 <1319100@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20140513155625.16564.49635.malonedeb@soybean.canonical.com>
Message-Id: <149679105555.506.3586317168986798744.malone@chaenomeles.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1319100] Re: qemu-arm-static bug in signal
 handling causes mono and java to hang
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

I can't guess very well how important this would be for an SRU (or not),
leaving that up for user feedback to be decided.

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1319100

Title:
  qemu-arm-static bug in signal handling causes mono and java to hang

Status in QEMU:
  Fix Released
Status in qemu-kvm package in Ubuntu:
  Fix Released
Status in qemu-kvm package in Debian:
  Fix Released

Bug description:
  Note, this bug is already reported to debian, but it seems to also affect=
 the upstream code.
  https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=3D748043

  running mono in a chroot environment with qemu-user-static is not posible
  because at least one signal used during termination of mono is routed to =
the
  host.

  This can be reproduced by:
  debootstrap --include=3Dmono-runtime --foreign --arch=3Darmel "wheezy" "m=
ono-test" "http://ftp.de.debian.org//debian"
  cp /usr/bin/qemu-arm-static mono-test/usr/bin
  mount -t proc none mono-test/proc
  mount -o bind /dev mono-test/dev
  mount -o bind /sys mono-test/sys
  chroot mono-test
  ../debootstrap/debootstrap --second-stage
  exit
  mount -t proc none mono-test/proc
  mount -o bind /sys mono-test/sys
  chroot mono-test
  QEMU_STRACE=3D1 /usr/bin/mono /usr/lib/mono/4.0/gacutil.exe

  This will block on a futex:

  --8<--
  18663 sched_yield(0,0,2582980,0,0,2582928) =3D 0
  18663 clock_gettime(1,-150996384,2,1,2585016,2585600) =3D 0
  18663 tgkill(18663,18664,30,18664,30,-161951744) =3D 0
  18663 futex(0x00293774,FUTEX_PRIVATE_FLAG|FUTEX_WAIT,0,NULL,NULL,0)
  --8<--

  If you use mono within strace on a native x86 box you can see, that signa=
ls
  between threads are used during termination:

  strace -f -o log.txt /usr/bin/mono /usr/lib/mono/4.0/gacutil.exe

  --8<--
  14075 sched_yield()                     =3D 0                            =
         =

  14075 tgkill(14075, 14083, SIGPWR)      =3D 0                            =
         =

  14075 futex(0x983f00, FUTEX_WAIT_PRIVATE, 0, NULL <unfinished ...>       =
       =

  14083 <... futex resumed> )             =3D ? ERESTARTSYS (To be restarte=
d)       =

  14083 --- SIGPWR (Power failure) @ 0 (0) ---                             =
       =

  14083 futex(0x983f00, FUTEX_WAKE_PRIVATE, 1) =3D 1                       =
         =

  14075 <... futex resumed> )             =3D 0                            =
         =

  14083 rt_sigsuspend(~[INT QUIT ABRT TERM XCPU RTMIN RT_1] <unfinished ...=
>      =

  14075 futex(0x94d9a4, FUTEX_CMP_REQUEUE_PRIVATE, 1, 2147483647, 0x94da20,=
 24) =3D 3
  14078 <... futex resumed> )             =3D 0                            =
         =

  14078 futex(0x94da20, FUTEX_WAKE_PRIVATE, 1) =3D 1                       =
         =

  14077 <... futex resumed> )             =3D 0                            =
         =

  14075 futex(0x94d9a4, FUTEX_CMP_REQUEUE_PRIVATE, 1, 2147483647, 0x94da20,=
 26 <unfinished ...>
  --8<--

  This also blocks the installation of libnunit2.6-cil within a armel chroo=
t,
  because it uses mono in its postinst script.
  E.g. (/usr/bin/mono /usr/share/mono/MonoGetAssemblyName.exe /usr/lib/cli/=
nunit.core-2.6/nunit.core.dll)

  Obviously the same as described in:
  http://lists.opensuse.org/opensuse-arm/2011-12/msg00000.html
  is happening here.

  There is an openSuSE patch against qemu:
  https://build.opensuse.org/package/view_file/Virtualization:Qemu/qemu/000=
2-XXX-work-around-SA_RESTART-race-wit.patch?expand=3D1

  This patch also applies against qemu from backports-wheezy and resolves t=
his
  issue.

  As it seems, that this issue is not Debian specific i will also report it=
 to
  the qemu project and reference this bug report.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1319100/+subscriptions
