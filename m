Received: from eggs.gnu.org ([2001:4830:134:3::10]:43447)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cnQDn-00017b-Me
	for qemu-devel@nongnu.org; Mon, 13 Mar 2017 09:41:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cnQDi-00076M-Mh
	for qemu-devel@nongnu.org; Mon, 13 Mar 2017 09:41:11 -0400
Received: from indium.canonical.com ([91.189.90.7]:43026)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1cnQDi-00075a-FR
	for qemu-devel@nongnu.org; Mon, 13 Mar 2017 09:41:06 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1cnQDf-0005pY-Jc
	for <qemu-devel@nongnu.org>; Mon, 13 Mar 2017 13:41:03 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 443F82E81D3
	for <qemu-devel@nongnu.org>; Mon, 13 Mar 2017 13:41:00 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Mon, 13 Mar 2017 13:29:27 -0000
From: Maskim Bakulin <1672383@bugs.launchpad.net>
Reply-To: Bug 1672383 <1672383@bugs.launchpad.net>
Sender: bounces@canonical.com
Message-Id: <20170313132927.15361.96547.malonedeb@soybean.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1672383] [NEW] Slow Windows XP load after commit
 a9353fe897ca2687e5b3385ed39e3db3927a90e0
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Public bug reported:

I've recently discovered, that in QEMU 2.8+ my Windows XP loading time
has significantly worsened. In 2.7 it took 30-40 second to boot, but in
2.8 it became 2-2,5 minutes.

I've used Git bisect, and found out that the change happened after
commit a9353fe897ca2687e5b3385ed39e3db3927a90e0, which, as far as I can
tell from the commit message, handled race condition when invalidating
breakpoint.

I've set a breakpoint in static void breakpoint_invalidate(CPUState *cpu, t=
arget_ulong pc), and here's a backtrace:
#0  cpu_breakpoint_insert (cpu=3Dcpu@entry=3D0x555556a73be0, pc=3D144, =

    flags=3Dflags@entry=3D32, breakpoint=3Dbreakpoint@entry=3D0x555556a7c67=
0)
    at /media/sdd2/qemu-work/exec.c:830
#1  0x00005555558746ac in hw_breakpoint_insert (env=3Denv@entry=3D0x555556a=
7be60, =

    index=3Dindex@entry=3D0) at /media/sdd2/qemu-work/target-i386/bpt_helpe=
r.c:64
#2  0x00005555558748ed in cpu_x86_update_dr7 (env=3D0x555556a7be60, =

    new_dr7=3D<optimised out>)
    at /media/sdd2/qemu-work/target-i386/bpt_helper.c:160
#3  0x00007fffa17421f6 in code_gen_buffer ()
#4  0x000055555577fcb4 in cpu_tb_exec (itb=3D<optimised out>, =

    itb=3D<optimised out>, cpu=3D0x7fff8b7763b0)
    at /media/sdd2/qemu-work/cpu-exec.c:164
It seems that XP sets some breakpoints during it's load, and it leads to fr=
equent TB flushes and slow execution.

** Affects: qemu
     Importance: Undecided
         Status: New

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1672383

Title:
  Slow Windows XP load after commit
  a9353fe897ca2687e5b3385ed39e3db3927a90e0

Status in QEMU:
  New

Bug description:
  I've recently discovered, that in QEMU 2.8+ my Windows XP loading time
  has significantly worsened. In 2.7 it took 30-40 second to boot, but
  in 2.8 it became 2-2,5 minutes.

  I've used Git bisect, and found out that the change happened after
  commit a9353fe897ca2687e5b3385ed39e3db3927a90e0, which, as far as I
  can tell from the commit message, handled race condition when
  invalidating breakpoint.

  I've set a breakpoint in static void breakpoint_invalidate(CPUState *cpu,=
 target_ulong pc), and here's a backtrace:
  #0  cpu_breakpoint_insert (cpu=3Dcpu@entry=3D0x555556a73be0, pc=3D144, =

      flags=3Dflags@entry=3D32, breakpoint=3Dbreakpoint@entry=3D0x555556a7c=
670)
      at /media/sdd2/qemu-work/exec.c:830
  #1  0x00005555558746ac in hw_breakpoint_insert (env=3Denv@entry=3D0x55555=
6a7be60, =

      index=3Dindex@entry=3D0) at /media/sdd2/qemu-work/target-i386/bpt_hel=
per.c:64
  #2  0x00005555558748ed in cpu_x86_update_dr7 (env=3D0x555556a7be60, =

      new_dr7=3D<optimised out>)
      at /media/sdd2/qemu-work/target-i386/bpt_helper.c:160
  #3  0x00007fffa17421f6 in code_gen_buffer ()
  #4  0x000055555577fcb4 in cpu_tb_exec (itb=3D<optimised out>, =

      itb=3D<optimised out>, cpu=3D0x7fff8b7763b0)
      at /media/sdd2/qemu-work/cpu-exec.c:164
  It seems that XP sets some breakpoints during it's load, and it leads to =
frequent TB flushes and slow execution.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1672383/+subscriptions
