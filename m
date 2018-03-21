Received: from eggs.gnu.org ([2001:4830:134:3::10]:59857)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1eygAq-0004ay-HY
	for qemu-devel@nongnu.org; Wed, 21 Mar 2018 12:01:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1eygAk-0005Bn-IH
	for qemu-devel@nongnu.org; Wed, 21 Mar 2018 12:01:12 -0400
Received: from indium.canonical.com ([91.189.90.7]:34046)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1eygAk-0005BN-Ck
	for qemu-devel@nongnu.org; Wed, 21 Mar 2018 12:01:06 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1eygAi-0000Va-Ai
	for <qemu-devel@nongnu.org>; Wed, 21 Mar 2018 16:01:04 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 4EDE92E84C6
	for <qemu-devel@nongnu.org>; Wed, 21 Mar 2018 16:01:04 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 21 Mar 2018 15:46:11 -0000
From: philmd <1757363@bugs.launchpad.net>
Reply-To: Bug 1757363 <1757363@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <152162151775.22331.14638507477656772309.malonedeb@soybean.canonical.com>
Message-Id: <152164717129.25539.6087118256841774398.launchpad@gac.canonical.com>
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

** Tags added: mips

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
