Received: from eggs.gnu.org ([209.51.188.92]:34150)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1gv3dm-0001Xp-SP
	for qemu-devel@nongnu.org; Sat, 16 Feb 2019 12:20:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1gv3dl-0006NV-RY
	for qemu-devel@nongnu.org; Sat, 16 Feb 2019 12:20:38 -0500
Received: from indium.canonical.com ([91.189.90.7]:54430)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1gv3dl-0006Mt-Ip
	for qemu-devel@nongnu.org; Sat, 16 Feb 2019 12:20:37 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1gv3dj-0003W1-9U
	for <qemu-devel@nongnu.org>; Sat, 16 Feb 2019 17:20:35 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 41C122E80C8
	for <qemu-devel@nongnu.org>; Sat, 16 Feb 2019 17:20:35 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Sat, 16 Feb 2019 17:11:37 -0000
From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Reply-To: Bug 1815911 <1815911@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <155015240171.6215.11220706309348619396.malonedeb@soybean.canonical.com>
	<155023483785.1243.17367221566041086008.malone@gac.canonical.com>
Message-Id: <8fe09f41-96e2-70e0-d8b6-1e53f0d0ab69@physik.fu-berlin.de>
Errors-To: bounces@canonical.com
Subject: Re: [Qemu-devel] [Bug 1815911] Re: aptitude crashes qemu-m68k with
 handle_cpu_signal received signal outside vCPU context
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

On 2/15/19 1:47 PM, Laurent Vivier wrote:
> It seems it crashes during futex syscall:
> =

> ...
> [pid     4] getpid()                    =3D 4
> [pid     4] tgkill(4, 24, SIGRT_1)      =3D 0
> [pid    24] <... futex resumed> )       =3D ? ERESTARTSYS (To be restarte=
d if SA_RESTART is set)
> [pid    24] --- SIGRT_1 {si_signo=3DSIGRT_1, si_code=3DSI_TKILL, si_pid=
=3D4, si_uid=3D0} ---
> [pid     4] futex(0x7f77abb4f610, FUTEX_WAIT_PRIVATE, 16777216, NULL <unf=
inished ...>
> [pid    24] getpid()                    =3D 4
> [pid    24] --- SIGSEGV {si_signo=3DSIGSEGV, si_code=3DSEGV_MAPERR, si_ad=
dr=3D0x10} ---
> ...

The crash also reproduces with qemu-sh4, so it's not specific to m68k.

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1815911

Title:
  aptitude crashes qemu-m68k with handle_cpu_signal received signal
  outside vCPU context

Status in QEMU:
  New

Bug description:
  When building a package with sbuild on Debian, sbuild can use aptitude
  to resolve dependencies.

  Recently, some changes introduced to aptitude or related packages
  cause qemu to crash:

  (sid-m68k-sbuild)root@nofan:/# aptitude -y --without-recommends -o Dpkg::=
Options::=3D--force-confold -o Aptitude::CmdLine::Ignore-Trust-Violations=
=3Dfalse -o Aptitude::ProblemResolver::StepScore=3D100 -o Aptitude::Problem=
Resolver::SolutionCost=3D"safety, priority, non-default-versions" -o Aptitu=
de::ProblemResolver::Hints::KeepDummy=3D"reject sbuild-build-depends-core-d=
ummy :UNINST" -o Aptitude::ProblemResolver::Keep-All-Level=3D55000 -o Aptit=
ude::ProblemResolver::Remove-Essential-Level=3Dmaximum install vim
  Warning: Invalid locale (please review locale settings, this might lead t=
o problems later):
    locale::facet::_S_create_c_locale name not valid
  The following NEW packages will be installed:
    libgpm2{a} vim vim-common{a} vim-runtime{a} xxd{a} =

  0 packages upgraded, 5 newly installed, 0 to remove and 1 not upgraded.
  Need to get 7225 kB/7260 kB of archives. After unpacking 33.5 MB will be =
used.
  qemu:handle_cpu_signal received signal outside vCPU context @ pc=3D0x6019=
d1bf
  qemu:handle_cpu_signal received signal outside vCPU context @ pc=3D0x601b=
64ab
  Segmentation fault
  (sid-m68k-sbuild)root@nofan:/#

  The crash does not reproduce on real hardware running Debian unstable.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1815911/+subscriptions
