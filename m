Received: from eggs.gnu.org ([2001:4830:134:3::10]:35155)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vijay.kilari@gmail.com>) id 1cEfh2-0002Ao-CZ
	for qemu-devel@nongnu.org; Wed, 07 Dec 2016 12:07:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vijay.kilari@gmail.com>) id 1cEfh1-0000QD-FJ
	for qemu-devel@nongnu.org; Wed, 07 Dec 2016 12:07:44 -0500
From: vijay.kilari@gmail.com
Date: Wed,  7 Dec 2016 22:36:10 +0530
Message-Id: <1481130374-5147-1-git-send-email-vijay.kilari@gmail.com>
Subject: [Qemu-devel] [PATCH v5 0/3] Live migration optimization for
 Thunderx platform
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-arm@nongnu.org, peter.maydell@linaro.org, pbonzini@redhat.com, rth@twiddle.net
Cc: qemu-devel@nongnu.org, vijay.kilari@gmail.com, Vijaya Kumar K <Vijaya.Kumar@cavium.com>

From: Vijaya Kumar K <Vijaya.Kumar@cavium.com>

The CPU MIDR_EL1 register is exposed to userspace for arm64
with the below patch.
https://lkml.org/lkml/2016/7/8/467

Thunderx platform requires explicit prefetch instruction to
provide prefetch hint. Using MIDR_EL1 information, provided
by above kernel patch, prefetch is executed if the platform
is Thunderx.

The results of live migration time improvement is provided
in commit message of patch 3.

Note: Check for size of while prefetching beyond page is
not added. Making this check is counter productive on
performance of live migration.

v4 => v5:
   - Compile util/aarch64-cpuid.c when CONFIG_LINUX enabled
   - Added stubs include/qemu/aarch64-cpuid.h if __aarch64__ and
     CONFIG_LINUX are not enabled.
v3 => v4:
   - Dropped allocation of memory for buf in
     qemu_read_aarch64_midr_el1()
   - Moved MIDR reg definitions to header file
   - Dropped arm64 and thunder specific code from generic
     function.

v2 => v3:
   - Rebased on top of richard's patches.
   - Consider cache line size and line number to prefetch
   - Passed optional parameters to __builtin_prefetch
v1 => v2:
   - Rename util/cpuinfo.c as util/aarch64-cpuid.c
   - Introduced header file include/qemu/aarch64-cpuid.h
   - Place all arch specific code under define __aarch64__ and
     CONFIG_LINUX.
   - Used builtin_prefetch() to add prefetch instruction.
   - Moved arch specific changes out of generic code
   - Dropped prefetching 5th cache line.

Vijaya Kumar K (3):
  cutils: Set __builtin_prefetch optional parameters
  utils: Add helper to read arm MIDR_EL1 register
  utils: Add prefetch for Thunderx platform

 include/qemu/aarch64-cpuid.h | 38 ++++++++++++++++++++++++++++++++
 util/Makefile.objs           |  1 +
 util/aarch64-cpuid.c         | 52 ++++++++++++++++++++++++++++++++++++++++++++
 util/bufferiszero.c          | 43 +++++++++++++++++++++++++++++++-----
 4 files changed, 129 insertions(+), 5 deletions(-)
 create mode 100644 include/qemu/aarch64-cpuid.h
 create mode 100644 util/aarch64-cpuid.c

-- 
1.9.1
