Received: from eggs.gnu.org ([209.51.188.92]:49688)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1guQ8v-0003LF-Cg
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 18:10:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1guQ05-00054c-AY
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 18:01:02 -0500
Received: from mail-lj1-x241.google.com ([2a00:1450:4864:20::241]:42114)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <jcmvbkbc@gmail.com>) id 1guQ03-0004sE-Uo
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 18:01:01 -0500
Received: by mail-lj1-x241.google.com with SMTP id l7-v6so6723065ljg.9
	for <qemu-devel@nongnu.org>; Thu, 14 Feb 2019 15:00:41 -0800 (PST)
From: Max Filippov <jcmvbkbc@gmail.com>
Date: Thu, 14 Feb 2019 14:59:47 -0800
Message-Id: <20190214230000.24894-1-jcmvbkbc@gmail.com>
Subject: [Qemu-devel] [PATCH 00/13] target/xtensa: add FLIX support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>, Max Filippov <jcmvbkbc@gmail.com>

Hello,

this series adds limited support for FLIX instructions.
FLIX (flexible length instruction extensions) allows bundling multiple
opcodes in a single instruction. Each opcode is executed as if it was
the only opcode in the instruction. Opcodes may not simultaneously
modify same resource (register or state). Multiple branches, even
non-taken, are also not allowed in one instruction.

Instructions with opcodes that have circular dependencies between used
resources other than registers (e.g. opcode A uses resource U and modifies
resource M, while opcode B uses resource M and modifies resource U) are not
supported in this series.

Max Filippov (13):
  target/xtensa: move xtensa_finalize_config to xtensa_core_class_init
  target/xtensa: don't require opcode table sorting
  target/xtensa: allow multiple names for single opcode
  target/xtensa: implement wide branches and loops
  target/xtensa: sort FLIX instruction opcodes
  target/xtensa: add generic instruction post-processing
  target/xtensa: move WINDOW_BASE SR update to postprocessing
  target/xtensa: only rotate window in the retw helper
  target/xtensa: reorganize register handling in translators
  target/xtensa: reorganize access to MAC16 registers
  target/xtensa: reorganize access to boolean registers
  target/xtensa: break circular register dependencies
  target/xtensa: prioritize load/store in FLIX bundles

 target/xtensa/cpu.h          |   37 +-
 target/xtensa/helper.c       |   93 ++-
 target/xtensa/helper.h       |    5 +-
 target/xtensa/overlay_tool.h |    1 -
 target/xtensa/translate.c    | 1595 +++++++++++++++++++++++++++---------------
 target/xtensa/win_helper.c   |   22 +-
 6 files changed, 1162 insertions(+), 591 deletions(-)

-- 
2.11.0
