Received: from eggs.gnu.org ([2001:4830:134:3::10]:54091)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gEvQq-0005Wy-Lv
	for qemu-devel@nongnu.org; Tue, 23 Oct 2018 08:05:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gEvQl-0007Td-Kw
	for qemu-devel@nongnu.org; Tue, 23 Oct 2018 08:05:08 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e]:37196)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gEvQl-0007T8-AT
	for qemu-devel@nongnu.org; Tue, 23 Oct 2018 08:05:03 -0400
Received: by mail-wm1-x32e.google.com with SMTP id x19-v6so1500392wmc.2
	for <qemu-devel@nongnu.org>; Tue, 23 Oct 2018 05:05:03 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Tue, 23 Oct 2018 13:04:47 +0100
Message-Id: <20181023120454.28553-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH 0/7] riscv decodetree followup
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: kbastian@mail.uni-paderborn.de, sagark@eecs.berkeley.edu, palmer@sifive.com, peer.adelt@hni.uni-paderborn.de, Alistair.Francis@wdc.com, mjc@sifive.com

The first patch is the promised change to argument sets to allow
them to be shared between two decoders.

Then I set about trying to use this... and ran into some other
interesting problems.  The first of which is that 

  bool trans_add(DecodeContext *ctx, struct arg_r *a, uint32_t insn);
  bool trans_add(DecodeContext *ctx, struct arg_r *a, uint16_t insn);

conflicts.

I think the best solution is to remove the insn argument to the
trans_* functions.  When this goes in for real, this will be
a big patch that touches lots of lines in target/arm and target/openrisc.
For now, I'm ignoring that and only building riscv{32,64}-linux-user.

Second, it occured to me that if we smoosh several files together
at build time, we don't have to play silly games with trying to
decode for riscv32 and riscv64 at the same time.  The last patch is,
I think, a big improvement in that.

Full tree at https://github.com/rth7680/qemu.git riscv-dt-rth.


r~


Richard Henderson (7):
  decodetree: Add !extern flag to argument sets
  decodetree: Remove "insn" argument from trans_* expanders
  target/riscv: Update for decodetree insn argument change
  target/riscv: Rename some argument sets in insn32.decode
  target/riscv: Convert @cs_2 insns to share translation functions
  target/riscv: Convert @cl_d, @cl_w, @cs_d, @cs_w insns
  target/riscv: Splice decodetree inputs for riscv32 vs riscv64

 .../riscv/insn_trans/trans_privileged.inc.c   |  19 +-
 target/riscv/insn_trans/trans_rva.inc.c       |  90 ++------
 target/riscv/insn_trans/trans_rvc.inc.c       | 215 ++++--------------
 target/riscv/insn_trans/trans_rvd.inc.c       |  90 +++-----
 target/riscv/insn_trans/trans_rvf.inc.c       |  78 +++----
 target/riscv/insn_trans/trans_rvi.inc.c       | 165 ++++++--------
 target/riscv/insn_trans/trans_rvm.inc.c       |  48 ++--
 target/riscv/translate.c                      |  30 ++-
 scripts/decodetree.py                         |  39 ++--
 target/riscv/Makefile.objs                    |  23 +-
 target/riscv/insn16-32.decode                 |  31 +++
 target/riscv/insn16-64.decode                 |  33 +++
 target/riscv/insn16.decode                    |  55 ++---
 target/riscv/insn32.decode                    |  68 +-----
 target/riscv/insn64.decode                    |  71 ++++++
 15 files changed, 450 insertions(+), 605 deletions(-)
 create mode 100644 target/riscv/insn16-32.decode
 create mode 100644 target/riscv/insn16-64.decode
 create mode 100644 target/riscv/insn64.decode

-- 
2.17.2
