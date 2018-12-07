Received: from eggs.gnu.org ([2001:4830:134:3::10]:58999)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gVDUv-0007xo-Qm
	for qemu-devel@nongnu.org; Fri, 07 Dec 2018 05:36:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gVDUs-0007BN-If
	for qemu-devel@nongnu.org; Fri, 07 Dec 2018 05:36:41 -0500
Received: from mail-oi1-x244.google.com ([2607:f8b0:4864:20::244]:37100)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gVDUs-0007AZ-4c
	for qemu-devel@nongnu.org; Fri, 07 Dec 2018 05:36:38 -0500
Received: by mail-oi1-x244.google.com with SMTP id y23so3000315oia.4
	for <qemu-devel@nongnu.org>; Fri, 07 Dec 2018 02:36:37 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Fri,  7 Dec 2018 04:36:05 -0600
Message-Id: <20181207103631.28193-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH 00/26] target/arm: Implement ARMv8.3-PAuth
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, ramana.radhakrishnan@arm.com

This has survivied a small user-only smoke test.

I need to build a kernel with the right patches in order to both
test this in system mode as well as verify the hashes that I am
producing vs ARM Fast Model.

However,

$ aarch64-linux-gcc-8.0.1 -msign-return-address=all z.c
$ ./aarch64-linux-user/qemu-aarch64 -D z -d in_asm,op,cpu -singlestep ./a.out 
Hello, World!

IN: main
0x004005a4:  d503233f  hint     #0x19

OP:
 ld_i32 tmp0,env,$0xffffffffffffffe4
 movi_i32 tmp1,$0x0
 brcond_i32 tmp0,tmp1,lt,$L0

 ---- 00000000004005a4 0000000000000000 0000000000000000
 call pacia,$0x20,$1,lr,env,lr,sp
 goto_tb $0x1
 movi_i64 pc,$0x4005a8
 exit_tb $0x5608e569e281
 set_label $L0
 exit_tb $0x5608e569e283

- X29=00000040007ff4a0 X30=00000040008778a4  SP=00000040007ff4a0
+ X29=00000040007ff4a0 X30=c0270040008778a4  SP=00000040007ff4a0

IN: main
0x004005c4:  d50323bf  hint     #0x1d

OP:
 ld_i32 tmp0,env,$0xffffffffffffffe4
 movi_i32 tmp1,$0x0
 brcond_i32 tmp0,tmp1,lt,$L0

 ---- 00000000004005c4 0000000000000000 0000000000000000
 call autia,$0x20,$1,lr,env,lr,sp
 goto_tb $0x1
 movi_i64 pc,$0x4005c8
 exit_tb $0x5608e5706241
 set_label $L0
 exit_tb $0x5608e5706243

- X29=00000040007ff4a0 X30=c0270040008778a4  SP=00000040007ff4a0
+ X29=00000040007ff4a0 X30=00000040008778a4  SP=00000040007ff4a0

So, yay!  We sign something with high bits set and can get
back the original pointer.  Note that this is with key==0,
as I do not yet initialize AutKeyIA to anything, as the
real kernel would for a given thread.

This is based on my v3 ARMv8.1-LOR patches, which in turn
are based on Peter's target-arm.next.  The full tree is
available at

  https://github.com/rth7680/qemu.git tgt-arm-pauth

and this version is tagged tgt-arm-pauth-hello-world.  ;-)


r~


Richard Henderson (26):
  target/arm: Add state for the ARMv8.3-PAuth extension
  target/arm: Add SCTLR bits through ARMv8.5
  target/arm: Add PAuth active bit to tbflags
  target/arm: Add PAuth helpers
  target/arm: Decode PAuth within system hint space
  target/arm: Rearrange decode in disas_data_proc_1src
  target/arm: Decode PAuth within disas_data_proc_1src
  target/arm: Decode PAuth within disas_data_proc_2src
  target/arm: Move helper_exception_return to helper-a64.c
  target/arm: Add new_pc argument to helper_exception_return
  target/arm: Rearrange decode in disas_uncond_b_reg
  target/arm: Decode PAuth within disas_uncond_b_reg
  target/arm: Decode Load/store register (pac)
  target/arm: Move cpu_mmu_index out of line
  target/arm: Introduce arm_mmu_idx
  target/arm: Create ARMVAParameters and helpers
  target/arm: Reuse aa64_va_parameters for setting tbflags
  target/arm: Export aa64_va_parameters to internals.h
  target/arm: Implement pauth_strip
  target/arm: Implement pauth_auth
  target/arm: Implement pauth_addpac
  target/arm: Implement pauth_computepac
  target/arm: Add PAuth system registers
  target/arm: Enable PAuth for user-only -cpu max
  target/arm: Enable PAuth for user-only, part 2
  target/arm: Tidy TBI handling in gen_a64_set_pc

 target/arm/cpu.h           | 151 ++++-----
 target/arm/helper-a64.h    |  14 +
 target/arm/helper.h        |   1 -
 target/arm/internals.h     |  35 ++
 target/arm/translate.h     |   2 +
 target/arm/cpu.c           |   6 +
 target/arm/cpu64.c         |   4 +
 target/arm/helper-a64.c    | 631 +++++++++++++++++++++++++++++++++++++
 target/arm/helper.c        | 459 ++++++++++++++++-----------
 target/arm/machine.c       |  23 ++
 target/arm/op_helper.c     | 155 ---------
 target/arm/translate-a64.c | 531 ++++++++++++++++++++++++++-----
 12 files changed, 1519 insertions(+), 493 deletions(-)

-- 
2.17.2
