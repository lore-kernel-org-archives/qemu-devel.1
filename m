Received: from eggs.gnu.org ([2001:4830:134:3::10]:48805)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1eKpK0-0006NC-CZ
	for qemu-devel@nongnu.org; Fri, 01 Dec 2017 12:41:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1eKpJw-0007v9-7V
	for qemu-devel@nongnu.org; Fri, 01 Dec 2017 12:41:56 -0500
Received: from indium.canonical.com ([91.189.90.7]:51780)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1eKpJw-0007ue-0a
	for qemu-devel@nongnu.org; Fri, 01 Dec 2017 12:41:52 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1eKeSA-0000qo-Ti
	for <qemu-devel@nongnu.org>; Fri, 01 Dec 2017 06:05:38 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id DE8AA2E80C3
	for <qemu-devel@nongnu.org>; Fri,  1 Dec 2017 06:05:38 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Fri, 01 Dec 2017 05:58:15 -0000
From: Joey Jiao <1735653@bugs.launchpad.net>
Reply-To: Bug 1735653 <1735653@bugs.launchpad.net>
Sender: bounces@canonical.com
Message-Id: <151210789540.11140.601756006906517496.malonedeb@soybean.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1735653] [NEW] qemu aarch64 cannot boot linux
 kernel v4.6+
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

Hi,
I tested the latest qemu-system-aarch64 cannot boot linux mainline kernel s=
ince v4.6 from https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/lin=
ux.git.

Environment info:
# host
 ubuntu 16.04
# qemu
 Master branch from git://git.qemu.org/qemu.git, and now the HEAD is c11d61=
271b9e6e7a1f0479ef1ca8fb55fa457a62.
# build command
 ./configure --target-list=3Daarch64-softmmu
 make
# qemu commmand
 qemu-system-aarch64 -machine virt -cpu cortex-a57 -machine type=3Dvirt -sm=
p 4 -m 1024 -nographic -s -kernel ~/workspace/linux/arch/arm64/boot/Image -=
device e1000,netdev=3Dnet0 -netdev user,id=3Dnet0,hostfwd=3Dtcp::2222-:22

Error info:
 No error prompted, actually no any log which means I couldn't see the usua=
lly kernel boot message.

Debug info:
 I did a git bisect on linux, and found with this kernel commit, qemu faile=
d to boot. Parent of 406e308770a92bd33995b2e5b681e86358328bb0 can boot.
 commit 406e308770a92bd33995b2e5b681e86358328bb0
    Author: James Morse <james.morse@arm.com>
    Date:   Fri Feb 5 14:58:47 2016 +0000

    arm64: add ARMv8.2 id_aa64mmfr2 boiler plate

    ARMv8.2 adds a new feature register id_aa64mmfr2. This patch adds the
    cpu feature boiler plate used by the actual features in later patches.

    Signed-off-by: James Morse <james.morse@arm.com>
    Reviewed-by: Suzuki K Poulose <suzuki.poulose@arm.com>
    Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
 The main change in the patch is to add reg_id_aa64mmfr2 in to arch/arm64/i=
nclude/asm/cpu.h, so might it be any struct change not included in qemu?

Can you please help check how to fix it?

Thanks

- Joey

** Affects: qemu
     Importance: Undecided
         Status: New


** Tags: qemu-system-aarch64

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1735653

Title:
  qemu aarch64 cannot boot linux kernel v4.6+

Status in QEMU:
  New

Bug description:
  Hi,
  I tested the latest qemu-system-aarch64 cannot boot linux mainline kernel=
 since v4.6 from https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/l=
inux.git.

  Environment info:
  # host
   ubuntu 16.04
  # qemu
   Master branch from git://git.qemu.org/qemu.git, and now the HEAD is c11d=
61271b9e6e7a1f0479ef1ca8fb55fa457a62.
  # build command
   ./configure --target-list=3Daarch64-softmmu
   make
  # qemu commmand
   qemu-system-aarch64 -machine virt -cpu cortex-a57 -machine type=3Dvirt -=
smp 4 -m 1024 -nographic -s -kernel ~/workspace/linux/arch/arm64/boot/Image=
 -device e1000,netdev=3Dnet0 -netdev user,id=3Dnet0,hostfwd=3Dtcp::2222-:22

  Error info:
   No error prompted, actually no any log which means I couldn't see the us=
ually kernel boot message.

  Debug info:
   I did a git bisect on linux, and found with this kernel commit, qemu fai=
led to boot. Parent of 406e308770a92bd33995b2e5b681e86358328bb0 can boot.
   commit 406e308770a92bd33995b2e5b681e86358328bb0
      Author: James Morse <james.morse@arm.com>
      Date:   Fri Feb 5 14:58:47 2016 +0000

      arm64: add ARMv8.2 id_aa64mmfr2 boiler plate

      ARMv8.2 adds a new feature register id_aa64mmfr2. This patch adds the
      cpu feature boiler plate used by the actual features in later patches.

      Signed-off-by: James Morse <james.morse@arm.com>
      Reviewed-by: Suzuki K Poulose <suzuki.poulose@arm.com>
      Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
   The main change in the patch is to add reg_id_aa64mmfr2 in to arch/arm64=
/include/asm/cpu.h, so might it be any struct change not included in qemu?

  Can you please help check how to fix it?

  Thanks

  - Joey

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1735653/+subscriptions
