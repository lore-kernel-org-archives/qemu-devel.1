Received: from eggs.gnu.org ([2001:4830:134:3::10]:52618)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1fPvoi-0007TL-Nx
	for qemu-devel@nongnu.org; Mon, 04 Jun 2018 16:11:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1fPvof-0001SW-Cz
	for qemu-devel@nongnu.org; Mon, 04 Jun 2018 16:11:00 -0400
Received: from indium.canonical.com ([91.189.90.7]:39614)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1fPvof-0001S2-5t
	for qemu-devel@nongnu.org; Mon, 04 Jun 2018 16:10:57 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1fPvoe-0005mC-4b
	for <qemu-devel@nongnu.org>; Mon, 04 Jun 2018 20:10:56 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 1F1C12E80C8
	for <qemu-devel@nongnu.org>; Mon,  4 Jun 2018 20:10:56 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Mon, 04 Jun 2018 20:04:48 -0000
From: =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <1757363@bugs.launchpad.net>
Reply-To: Bug 1757363 <1757363@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <152162151775.22331.14638507477656772309.malonedeb@soybean.canonical.com>
Message-Id: <152814268805.26200.10002120343627998151.malone@wampee.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1757363] Re: infinite loop due to improper deal
 with "eret" on mips32
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

What model/cpu is your router?

Which MIPS guest CPU are you using? Are you sure it matches the CPU of
your router?

Is your tplink firmware publicly available? (to reproduce your problem).

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1757363

Title:
  infinite loop due to improper deal with "eret" on mips32

Status in QEMU:
  New

Bug description:
  1.qemu 2.9.1 release on the official web build with tcg
  2.cmd: qemu-system-mips -kernel kernelfile
  3. host: ubuntu 16.04.1 with linux kernel 4.6.2 x86_64
     guest: mips bigendian 32bit (tplink firmware)

  =

  detail:

  static inline void exception_return(CPUMIPSState *env)
  {
      debug_pre_eret(env);
      if (env->CP0_Status & (1 << CP0St_ERL)) {
          set_pc(env, env->CP0_ErrorEPC);
          env->CP0_Status &=3D ~(1 << CP0St_ERL);
      } else {
          set_pc(env, env->CP0_EPC);
          env->CP0_Status &=3D ~(1 << CP0St_EXL);=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D> ISSUE????
      }
      compute_hflags(env);
      debug_post_eret(env);
  }

  void helper_eret(CPUMIPSState *env)
  {
      exception_return(env);
      env->lladdr =3D 1;
  }

  =

  In the Issue Line, there is no check CP0_Status whether int is disabled (=
should not enter int routine),
  that result in the cpu can not jump out the int routine.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1757363/+subscriptions
