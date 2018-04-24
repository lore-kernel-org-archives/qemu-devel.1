Received: from eggs.gnu.org ([2001:4830:134:3::10]:32874)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1fB5lK-0002lK-5k
	for qemu-devel@nongnu.org; Tue, 24 Apr 2018 17:46:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1fB5lH-00072B-22
	for qemu-devel@nongnu.org; Tue, 24 Apr 2018 17:46:10 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:42386 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lersek@redhat.com>) id 1fB5lG-00071h-TI
	for qemu-devel@nongnu.org; Tue, 24 Apr 2018 17:46:06 -0400
From: Laszlo Ersek <lersek@redhat.com>
Date: Tue, 24 Apr 2018 23:45:44 +0200
Message-Id: <20180424214550.32549-1-lersek@redhat.com>
Subject: [Qemu-devel] [PATCH 0/6] qapi: introduce the SysEmuTarget
 enumeration
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: "Daniel P. Berrange" <berrange@redhat.com>, Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, David Gibson <dgibson@redhat.com>, Eric Blake <eblake@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Kashyap Chamarthy <kchamart@redhat.com>, Laurent Vivier <laurent@vivier.eu>, Markus Armbruster <armbru@redhat.com>, Michael Clark <mjc@sifive.com>, Palmer Dabbelt <palmer@sifive.com>, Paolo Bonzini <pbonzini@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Richard Henderson <rth@twiddle.net>, Riku Voipio <riku.voipio@iki.fi>, Sagar Karandikar <sagark@eecs.berkeley.edu>, Thomas Huth <thuth@redhat.com>

This patch set adds the @SysEmuTarget enum type, and rebases a few other
types to it. Here's the "anatomy" of the series:

- Patches #1 and #2 fix QAPI bugs that have crept in in the 2.12
  development cycle. I noticed the bugs while working on patch #6; i.e.
  patch #6 depends on #1 and #2. The issues should likely be fixed in
  2.12.1, so patches #1 and #2 are CC'd to qemu-stable.

- Patch #3 is what I primarily care about in this series. It introduces
  the @SysEmuTarget enum, for the sake of my end-goal patch at:

    [Qemu-devel] [qemu RFC v3 3/3] qapi: add "firmware.json"
    http://mid.mail-archive.com/20180420231246.23130-4-lersek@redhat.com

  (BTW review comments for that RFCv3 patch are still super welcome).

- Patch #4 is a small cleanup that utilizes @SysEmuTarget, rebasing
  @TargetInfo to it.

- Patch #5 is an attempt at normalizing @CpuInfo and @CpuInfoFast, by
  factoring out @CpuInfoCommon. I'm proposing this in order to save some
  busy-work for patch #6. If patch #5 is doing the wrong thing, it can
  be dropped, with relatively small updates to patch #6.

- Patch #6 demotes the current discriminator field of @CpuInfo and
  @CpuInfoFast, namely @arch (of type @CpuInfoArch), to "normal base
  struct field", and introduces @target (of type @SysEmuTarget) in its
  place. This is a pretty intrusive patch which caused me hours of
  struggle. Similarly to patch #4, the goal is to help clean up the fuzz
  around the "target architecture" concept in QAPI. I'm proposing this
  patch because Markus suggested that I might try :) If significantly
  more work was necessary to hammer this patch into acceptable shape,
  then I'd prefer to limit the scope, just add @target, and keep @arch
  as the discriminator.

Sorry about the humongous CC list.

Cc: "Daniel P. Berrange" <berrange@redhat.com>
Cc: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
Cc: David Gibson <dgibson@redhat.com>
Cc: Eric Blake <eblake@redhat.com>
Cc: Gerd Hoffmann <kraxel@redhat.com>
Cc: Kashyap Chamarthy <kchamart@redhat.com>
Cc: Laurent Vivier <laurent@vivier.eu>
Cc: Markus Armbruster <armbru@redhat.com>
Cc: Michael Clark <mjc@sifive.com>
Cc: Palmer Dabbelt <palmer@sifive.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Peter Crosthwaite <crosthwaite.peter@gmail.com>
Cc: Richard Henderson <rth@twiddle.net>
Cc: Riku Voipio <riku.voipio@iki.fi>
Cc: Sagar Karandikar <sagark@eecs.berkeley.edu>
Cc: Thomas Huth <thuth@redhat.com>

Thanks
Laszlo

Laszlo Ersek (6):
  qapi: fill in CpuInfoFast.arch in query-cpus-fast
  qapi: handle the riscv CpuInfoArch in query-cpus-fast
  qapi: add SysEmuTarget to "common.json"
  qapi: change the type of TargetInfo.arch from string to enum
    SysEmuTarget
  qapi: extract CpuInfoCommon to mitigate schema duplication
  qapi: discriminate CpuInfo[Fast] on SysEmuTarget, not CpuInfoArch

 qapi/common.json                    |  19 +++
 qapi/misc.json                      | 196 ++++++++++++++++++++-------
 qapi/qapi-schema.json               |   2 +-
 arch_init.c                         |  10 +-
 cpus.c                              | 261 ++++++++++++++++++++++++++++--------
 tests/test-x86-cpuid-compat.c       |   2 +-
 tests/migration/guestperf/engine.py |   2 +-
 7 files changed, 380 insertions(+), 112 deletions(-)

-- 
2.14.1.3.gb7cf6e02401b
