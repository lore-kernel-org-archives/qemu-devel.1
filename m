Received: from eggs.gnu.org ([2001:4830:134:3::10]:43285)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mjc@sifive.com>) id 1fGM68-0003XB-2p
	for qemu-devel@nongnu.org; Wed, 09 May 2018 06:13:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mjc@sifive.com>) id 1fGM64-0006mU-Bj
	for qemu-devel@nongnu.org; Wed, 09 May 2018 06:13:24 -0400
Received: from mail-pg0-x242.google.com ([2607:f8b0:400e:c05::242]:42619)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mjc@sifive.com>) id 1fGM64-0006lk-67
	for qemu-devel@nongnu.org; Wed, 09 May 2018 06:13:20 -0400
Received: by mail-pg0-x242.google.com with SMTP id p9-v6so19558542pgc.9
	for <qemu-devel@nongnu.org>; Wed, 09 May 2018 03:13:20 -0700 (PDT)
From: Michael Clark <mjc@sifive.com>
Date: Wed,  9 May 2018 22:11:47 +1200
Message-Id: <1525860713-3476-1-git-send-email-mjc@sifive.com>
Subject: [Qemu-devel] [PATCH v1 0/6] Translation loop conversion for riscv
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: patches@groups.riscv.org, Michael Clark <mjc@sifive.com>, Palmer Dabbelt <palmer@sifive.com>, Sagar Karandikar <sagark@eecs.berkeley.edu>, Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, Alistair Francis <Alistair.Francis@wdc.com>, "Emilio G . Cota" <cota@braap.org>

This is the riscv subset of Emilio G. Cota's translation loop
conversion patches forward ported to master, with a patch from
https://github.com/riscv/riscv-qemu/tree/qemu-2.13-for-upstream

The last patch in the series adds misa to DisasContext and
removes CPURISCVState from gen methods. The intention is to
add additional patches to this series to check for the misa
M, A, F and D extensions in multiply/divide, atomics, single
and double precision floating point methods to throw illegal
instruction exceptions for extensions that are not enabled.
The first step is to move misa into DisasContext.

The misa change has been rebased against Emilio G. Cota's
translation loop series so that target/riscv/translate.c
merges can be done more easily and so that patches can be
moved between trees.

Cc: Palmer Dabbelt <palmer@sifive.com>
Cc: Sagar Karandikar <sagark@eecs.berkeley.edu>
Cc: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
Cc: Alistair Francis <Alistair.Francis@wdc.com>
Cc: Emilio G. Cota <cota@braap.org>
Signed-off-by: Michael Clark <mjc@sifive.com>

Emilio G. Cota (5):
  target/riscv: avoid integer overflow in next_page PC check
  translator: merge max_insns into DisasContextBase
  target/riscv: convert to DisasJumpType
  target/riscv: convert to DisasContextBase
  target/riscv: convert to TranslatorOps

Michael Clark (1):
  target/riscv: add misa to DisasContext

 accel/tcg/translator.c     |  21 ++-
 include/exec/translator.h  |   8 +-
 target/alpha/translate.c   |   6 +-
 target/arm/translate-a64.c |   8 +-
 target/arm/translate.c     |  11 +-
 target/hppa/translate.c    |   7 +-
 target/i386/translate.c    |   5 +-
 target/ppc/translate.c     |   5 +-
 target/riscv/translate.c   | 326 ++++++++++++++++++++++-----------------------
 9 files changed, 187 insertions(+), 210 deletions(-)

-- 
2.7.0
