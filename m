Received: from eggs.gnu.org ([2001:4830:134:3::10]:34726)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1g7NeZ-0006b0-EK
	for qemu-devel@nongnu.org; Tue, 02 Oct 2018 12:36:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1g7NeY-00051w-C5
	for qemu-devel@nongnu.org; Tue, 02 Oct 2018 12:36:07 -0400
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue,  2 Oct 2018 17:35:43 +0100
Message-Id: <20181002163556.10279-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 00/13] target/arm: Implement v8M stack limit
 checks
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: patches@linaro.org

This patchset implements the v8M stack limit checking
feature, which is the last missing piece of the v8M
architectural support.

Note that the stack limit triggers when the SP value
is changed to something below the limit, not when
a load or store is performed below the limit. It's
also done only for certain instructions that update
SP, not for every possible way to change SP. For
loads and stores which do writeback to SP there are
also some rules about what parts of the load/store
are permitted to happen if the check triggers -- we
keep things simple by taking the approach of doing
the check first so that no accesses are done.

We take a straightforward approach to implementing
the checks: generating a call to a helper function
which does the comparison and might raise an exception.
This obviously imposes some overhead for the common
case where the limit isn't being breached, but
generating code for a compare-and-conditionally-call
seemed too tricky to insert into the existing code...

thanks
-- PMM

Peter Maydell (13):
  target/arm: Define new TBFLAG for v8M stack checking
  target/arm: Define new EXCP type for v8M stack overflows
  target/arm: Move v7m_using_psp() to internals.h
  target/arm: Add v8M stack checks on ADD/SUB/MOV of SP
  target/arm: Add some comments in Thumb decode
  target/arm: Add v8M stack checks on exception entry
  target/arm: Add v8M stack limit checks on NS function calls
  target/arm: Add v8M stack checks for LDRD/STRD (imm)
  target/arm: Add v8M stack checks for Thumb2 LDM/STM
  target/arm: Add v8M stack checks for T32 load/store single
  target/arm: Add v8M stack checks for Thumb push/pop
  target/arm: Add v8M stack checks for VLDM/VSTM
  target/arm: Add v8M stack checks for MSR to SP_NS

 target/arm/cpu.h       |   9 ++
 target/arm/helper.h    |   2 +
 target/arm/internals.h |  38 ++++++++
 target/arm/translate.h |   1 +
 target/arm/helper.c    |  99 ++++++++++++++++-----
 target/arm/op_helper.c |  23 ++++-
 target/arm/translate.c | 198 +++++++++++++++++++++++++++++++++++++----
 7 files changed, 330 insertions(+), 40 deletions(-)

-- 
2.19.0
