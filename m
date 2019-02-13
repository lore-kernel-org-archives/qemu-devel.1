Received: from eggs.gnu.org ([209.51.188.92]:59315)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <palmer@sifive.com>) id 1gtwso-0001PA-Js
	for qemu-devel@nongnu.org; Wed, 13 Feb 2019 10:55:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <palmer@sifive.com>) id 1gtwsc-0001v1-CZ
	for qemu-devel@nongnu.org; Wed, 13 Feb 2019 10:55:26 -0500
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432]:39802)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <palmer@sifive.com>) id 1gtwsU-0000qW-L1
	for qemu-devel@nongnu.org; Wed, 13 Feb 2019 10:55:16 -0500
Received: by mail-pf1-x432.google.com with SMTP id f132so1323377pfa.6
	for <qemu-devel@nongnu.org>; Wed, 13 Feb 2019 07:54:37 -0800 (PST)
Date: Wed, 13 Feb 2019 07:53:39 -0800
Message-Id: <20190213155414.22285-1-palmer@sifive.com>
From: Palmer Dabbelt <palmer@sifive.com>
Subject: [Qemu-devel] [PATCH v7 00/35] target/riscv: Convert to decodetree
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-riscv@nongnu.org
Cc: qemu-devel@nongnu.org

Palmer: I caused some merge conflicts in Bastian's patch set so I
figured I'd attempt to clean these up.  As far as I'm concerned v6 was
good to go, but since the merge conflicts were fairly extensive (if
somewhat mechanical) I'd like to pass the baton back to Bastian here for
at least a sanity check.

Hi,

this patchset converts the RISC-V decoder to decodetree in four major steps:

1) Convert 32-bit instructions to decodetree [Patch 1-16]:
    Many of the gen_* functions are called by the decode functions for 16-bit
    and 32-bit functions. If we move translation code from the gen_*
    functions to the generated trans_* functions of decode-tree, we get a lot of
    duplication. Therefore, we mostly generate calls to the old gen_* function
    which are properly replaced after step 2).

    Each of the trans_ functions are grouped into files corresponding to their
    ISA extension, e.g. addi which is in RV32I is translated in the file
    'trans_rvi.inc.c'.

2) Convert 16-bit instructions to decodetree [Patch 17-19]:
    All 16 bit instructions have a direct mapping to a 32 bit instruction. Thus,
    we convert the arguments in the 16 bit trans_ function to the arguments of
    the corresponding 32 bit instruction and call the 32 bit trans_ function.

3) Remove old manual decoding in gen_* function [Patch 20-30]:
    this move all manual translation code into the trans_* instructions of
    decode tree, such that we can remove the old decode_* functions.

4) Simplify RVC by reusing as much as possible from the RVG decoder as suggested
   by Richard. [Patch 31-35]

full tree available at
https://github.com/palmer-dabbelt/qemu/tree/riscv-dt-v7

Cheers,
Bastian

v6 -> v7:
    - Rebased on top of riscv-for-master-4.0-sf1, which contains a
      refactoring of the original translation code.
    - Added handling of mstatus.fs to the floating-point routines.

v5 -> v6:
    - fixed funky indentation
