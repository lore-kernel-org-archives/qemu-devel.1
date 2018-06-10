Received: from eggs.gnu.org ([2001:4830:134:3::10]:52367)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1fRs07-0001vK-OW
	for qemu-devel@nongnu.org; Sun, 10 Jun 2018 00:30:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1fRs04-0004yB-J9
	for qemu-devel@nongnu.org; Sun, 10 Jun 2018 00:30:47 -0400
Received: from indium.canonical.com ([91.189.90.7]:60124)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1fRs04-0004xk-CJ
	for qemu-devel@nongnu.org; Sun, 10 Jun 2018 00:30:44 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1fRs03-0003p8-3S
	for <qemu-devel@nongnu.org>; Sun, 10 Jun 2018 04:30:43 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 15FFE2E80C7
	for <qemu-devel@nongnu.org>; Sun, 10 Jun 2018 04:30:43 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Sun, 10 Jun 2018 04:17:23 -0000
From: Launchpad Bug Tracker <657329@bugs.launchpad.net>
Reply-To: Bug 657329 <657329@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20101009135148.4804.78327.malonedeb@palladium.canonical.com>
Message-Id: <152860424339.21977.7497020934479015439.malone@loganberry.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 657329] Re: APIC unusable on QEMU
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

[Expired for QEMU because there has been no activity for 60 days.]

** Changed in: qemu
       Status: Incomplete =3D> Expired

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/657329

Title:
  APIC unusable on QEMU

Status in QEMU:
  Expired

Bug description:
  The APIC is unusable with QEMU using x86-64 system emulation.  Problem
  exists in the latest stable QEMU 0.12.5 as well as the latest git
  head.  I am using Mac OS X 10.6, 64-bit version of QEMU.

  The QEMU binary was configured with:

   ./configure --target-list=3Di386-softmmu,x86_64-softmmubck-i-search:
  conf_

  Problem is that the hw/apic.c file (as well as a few other naughty
  files) rely on the cpu_single_env global - which is set to NULL in
  cpu-exec.c.

  Below is a test reading the local APIC version register:

  Before taking it out:

  (qemu) xp 0xfee00030
  00000000fee00030: 0x00000000
  (qemu)

  After:

  (qemu) xp 0xfee00030
  00000000fee00030: 0x00050011
  (qemu)

  Quick fix below.  I don't know if there are any side effects with
  this, if this is OK maybe we can fix it like this for the stable
  versions and fix the HEAD to not rely on the cpu_single_env global.

  diff --git a/cpu-exec.c b/cpu-exec.c
  index dbdfdcc..3e966d7 100644
  --- a/cpu-exec.c
  +++ b/cpu-exec.c
  @@ -674,7 +674,17 @@ int cpu_exec(CPUState *env1)
       env =3D (void *) saved_env_reg;
   =

       /* fail safe : never use cpu_single_env outside cpu_exec() */
  +#warning fixup devices which rely on this
  +#if 0
  +    /*
  +     * Hello.  This is wrapped around an #if 0 ... #endif because that's
  +     * what should happen.  However, certain naughty devices (like the A=
PIC
  +     * for instance, and a few others), access this global variable.
  +     *
  +     * So this is here for now ... until we fix up those devices.
  +     */
       cpu_single_env =3D NULL;
  +#endif
       return ret;
   }

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/657329/+subscriptions
