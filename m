Received: from eggs.gnu.org ([209.51.188.92]:39685)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1gud6q-0005Hm-2a
	for qemu-devel@nongnu.org; Fri, 15 Feb 2019 08:00:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1gud6o-0001ju-Vc
	for qemu-devel@nongnu.org; Fri, 15 Feb 2019 08:00:51 -0500
Received: from indium.canonical.com ([91.189.90.7]:46662)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1gud6n-0001Yi-6k
	for qemu-devel@nongnu.org; Fri, 15 Feb 2019 08:00:49 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1gud6l-00064T-MP
	for <qemu-devel@nongnu.org>; Fri, 15 Feb 2019 13:00:47 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 75E6E2E80CB
	for <qemu-devel@nongnu.org>; Fri, 15 Feb 2019 13:00:47 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Fri, 15 Feb 2019 12:47:17 -0000
From: Laurent Vivier <Laurent@vivier.eu>
Reply-To: Bug 1815911 <1815911@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <155015240171.6215.11220706309348619396.malonedeb@soybean.canonical.com>
Message-Id: <155023483785.1243.17367221566041086008.malone@gac.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1815911] Re: aptitude crashes qemu-m68k with
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

It seems it crashes during futex syscall:

...
[pid     4] getpid()                    =3D 4
[pid     4] tgkill(4, 24, SIGRT_1)      =3D 0
[pid    24] <... futex resumed> )       =3D ? ERESTARTSYS (To be restarted =
if SA_RESTART is set)
[pid    24] --- SIGRT_1 {si_signo=3DSIGRT_1, si_code=3DSI_TKILL, si_pid=3D4=
, si_uid=3D0} ---
[pid     4] futex(0x7f77abb4f610, FUTEX_WAIT_PRIVATE, 16777216, NULL <unfin=
ished ...>
[pid    24] getpid()                    =3D 4
[pid    24] --- SIGSEGV {si_signo=3DSIGSEGV, si_code=3DSEGV_MAPERR, si_addr=
=3D0x10} ---
...

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
