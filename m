Received: from eggs.gnu.org ([2001:4830:134:3::10]:51198)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1f5pDp-000733-VW
	for qemu-devel@nongnu.org; Tue, 10 Apr 2018 05:05:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1f5pDk-0002u0-Sn
	for qemu-devel@nongnu.org; Tue, 10 Apr 2018 05:05:49 -0400
Received: from indium.canonical.com ([91.189.90.7]:53804)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1f5pDk-0002tG-ME
	for qemu-devel@nongnu.org; Tue, 10 Apr 2018 05:05:44 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1f5pDj-00066d-Kv
	for <qemu-devel@nongnu.org>; Tue, 10 Apr 2018 09:05:43 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 978E12E80C8
	for <qemu-devel@nongnu.org>; Tue, 10 Apr 2018 09:05:43 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 10 Apr 2018 08:50:55 -0000
From: Thomas Huth <657329@bugs.launchpad.net>
Reply-To: Bug 657329 <657329@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20101009135148.4804.78327.malonedeb@palladium.canonical.com>
Message-Id: <152335025549.3422.15900749706411898578.malone@wampee.canonical.com>
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

Looking through old bug tickets... can you still reproduce this issue
with the latest version of QEMU? Or could we close this ticket nowadays?


** Changed in: qemu
       Status: New =3D> Incomplete

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/657329

Title:
  APIC unusable on QEMU

Status in QEMU:
  Incomplete

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
