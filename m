Received: from eggs.gnu.org ([209.51.188.92]:52921)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gr5za-0007nL-Md
	for qemu-devel@nongnu.org; Tue, 05 Feb 2019 14:02:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gr5zZ-0004GR-DE
	for qemu-devel@nongnu.org; Tue, 05 Feb 2019 14:02:46 -0500
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:54787)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1gr5zX-00045J-S6
	for qemu-devel@nongnu.org; Tue, 05 Feb 2019 14:02:43 -0500
Received: by mail-wm1-x343.google.com with SMTP id a62so44880wmh.4
	for <qemu-devel@nongnu.org>; Tue, 05 Feb 2019 11:02:29 -0800 (PST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Tue,  5 Feb 2019 19:02:18 +0000
Message-Id: <20190205190224.2198-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH  v2 0/6] HWCAP_CPUID registers for aarch64
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>

Hi,

I've re-spun the cpuid patches with the changes suggested by Peter's
review. The biggest change is the squashing of bits is now all data
driven with ARMCPRegUserSpaceInfo being used to control how bits are
altered for userspace presentation. This includes using glob matching
to set whole bunches to RAZ.

The testcase isn't as comprehensive as it could be because you need a
fairly new compiler (binutils) to emit all the various system register
id's to test. I did look into upgrading debian-arm64-cross with Buster
but I managed to find a bug in Debian's dependencies which rules out
upgrading for now.

checkpatch is complaining about the _m macro I used to group together
words in the masks I defined. I'm not sure adding the spaces makes it
as readable though.

The following patches need review:
 patch 0001/target arm relax permission checks for HWCAP_CPUI.patch
 patch 0002/target arm expose CPUID registers to userspace.patch
 patch 0003/target arm expose MPIDR_EL1 to userspace.patch
 patch 0004/target arm expose remaining CPUID registers as RA.patch
 patch 0006/tests tcg aarch64 userspace system register test.patch


Alex Bennée (6):
  target/arm: relax permission checks for HWCAP_CPUID registers
  target/arm: expose CPUID registers to userspace
  target/arm: expose MPIDR_EL1 to userspace
  target/arm: expose remaining CPUID registers as RAZ
  linux-user/elfload: enable HWCAP_CPUID for AArch64
  tests/tcg/aarch64: userspace system register test

 linux-user/elfload.c              |   1 +
 target/arm/cpu.h                  |  36 +++++++
 target/arm/helper.c               | 106 ++++++++++++++++--
 tests/tcg/aarch64/Makefile.target |   4 +-
 tests/tcg/aarch64/sysregs.c       | 172 ++++++++++++++++++++++++++++++
 5 files changed, 310 insertions(+), 9 deletions(-)
 create mode 100644 tests/tcg/aarch64/sysregs.c

-- 
2.20.1
