Received: from eggs.gnu.org ([2001:4830:134:3::10]:44456)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1diTn0-0004sY-DC
	for qemu-devel@nongnu.org; Thu, 17 Aug 2017 19:01:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1diTmw-0000gs-64
	for qemu-devel@nongnu.org; Thu, 17 Aug 2017 19:01:22 -0400
Received: from mail-pg0-x22f.google.com ([2607:f8b0:400e:c05::22f]:36527)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1diTmv-0000em-Uf
	for qemu-devel@nongnu.org; Thu, 17 Aug 2017 19:01:18 -0400
Received: by mail-pg0-x22f.google.com with SMTP id i12so51985685pgr.3
	for <qemu-devel@nongnu.org>; Thu, 17 Aug 2017 16:01:17 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Thu, 17 Aug 2017 16:01:06 -0700
Message-Id: <20170817230114.3655-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH 0/8] TCG vectorization and example conversion
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, alex.bennee@linaro.org

When Alex and I started talking about this topic, this is the direction
I was thinking.  The primary difference from Alex's version is that the
interface on the target/cpu/ side uses offsets and not a faux temp.  The
secondary difference is that, for smaller vector sizes at least, I will
expand to inline host vector operations.  The use of explicit offsets
aids that.

There are a number of things that are missing in the host vector support,
including register spill/fill.  But in this example conversion we will
never have more than 2 vector registers live at any point, and so we do
not run across those issues.

Some of this infrastructure cannot be exercised with existing front-ends.
It will require support for ARM SVE to be written to get there.
Or to add support for AVX2/AVX512 within target/i386.  ;-)

Unfortunately, the built-in disassembler is too old to handle AVX.
So for testing purposes I disabled the built-in disas so that I could
run the output assembly through an external objdump.

For a trivial test case via aarch64-linux-user:

IN: 
0x0000000000400078:  4e208400      add v0.16b, v0.16b, v0.16b
0x000000000040007c:  4e648462      add v2.8h, v3.8h, v4.8h
0x0000000000400080:  4ea48462      add v2.4s, v3.4s, v4.4s
0x0000000000400084:  4ee48462      add v2.2d, v3.2d, v4.2d
0x0000000000400088:  0ea28462      add v2.2s, v3.2s, v2.2s
0x000000000040008c:  00000000      unallocated (Unallocated)

OP after optimization and liveness analysis:
 ld_i32 tmp0,env,$0xffffffffffffffec              dead: 1
 movi_i32 tmp1,$0x0
 brcond_i32 tmp0,tmp1,lt,$L0                      dead: 0 1

 ---- 0000000000400078 0000000000000000 0000000000000000
 ld_v128 tmp2,env,$0x850
 add8_v128 tmp2,tmp2,tmp2                         dead: 1 2
 st_v128 tmp2,env,$0x850                          dead: 0

 ---- 000000000040007c 0000000000000000 0000000000000000
 ld_v128 tmp2,env,$0x880
 ld_v128 tmp3,env,$0x890
 add16_v128 tmp2,tmp2,tmp3                        dead: 1 2
 st_v128 tmp2,env,$0x870                          dead: 0

 ---- 0000000000400080 0000000000000000 0000000000000000
 ld_v128 tmp2,env,$0x880
 ld_v128 tmp3,env,$0x890
 add32_v128 tmp2,tmp2,tmp3                        dead: 1 2
 st_v128 tmp2,env,$0x870                          dead: 0

 ---- 0000000000400084 0000000000000000 0000000000000000
 ld_v128 tmp2,env,$0x880
 ld_v128 tmp3,env,$0x890
 add64_v128 tmp2,tmp2,tmp3                        dead: 1 2
 st_v128 tmp2,env,$0x870                          dead: 0

 ---- 0000000000400088 0000000000000000 0000000000000000
 ld_v64 tmp4,env,$0x880
 ld_v64 tmp5,env,$0x870
 add32_v64 tmp4,tmp4,tmp5                         dead: 1 2
 st_v64 tmp4,env,$0x870                           dead: 0
 movi_i64 tmp6,$0x0
 st_i64 tmp6,env,$0x878                           dead: 0

 ---- 000000000040008c 0000000000000000 0000000000000000
 movi_i64 pc,$0x40008c                            sync: 0  dead: 0
 movi_i32 tmp0,$0x1
 movi_i32 tmp1,$0x2000000
 movi_i32 tmp7,$0x1
 call exception_with_syndrome,$0x0,$0,env,tmp0,tmp1,tmp7  dead: 0 1 2 3
 set_label $L0
 exit_tb $0x521c86683

OUT: [size=220]
   521c86740:	41 8b 6e ec          		mov    -0x14(%r14),%ebp
   521c86744:	85 ed                		test   %ebp,%ebp
   521c86746:	0f 8c c4 00 00 00    		jl     0x521c86810
   521c8674c:	c4 c1 7a 6f 86 50 08 00 00 	vmovdqu 0x850(%r14),%xmm0
   521c86755:	c4 e1 79 fc c0       		vpaddb %xmm0,%xmm0,%xmm0
   521c8675a:	c4 c1 7a 7f 86 50 08 00 00	vmovdqu %xmm0,0x850(%r14)
   521c86763:	c4 c1 7a 6f 86 80 08 00 00 	vmovdqu 0x880(%r14),%xmm0
   521c8676c:	c4 c1 7a 6f 8e 90 08 00 00 	vmovdqu 0x890(%r14),%xmm1
   521c86775:	c4 e1 79 fd c1       		vpaddw %xmm1,%xmm0,%xmm0
   521c8677a:	c4 c1 7a 7f 86 70 08 00 00 	vmovdqu %xmm0,0x870(%r14)
   521c86783:	c4 c1 7a 6f 86 80 08 00 00 	vmovdqu 0x880(%r14),%xmm0
   521c8678c:	c4 c1 7a 6f 8e 90 08 00 00 	vmovdqu 0x890(%r14),%xmm1
   521c86795:	c4 e1 79 fe c1       		vpaddd %xmm1,%xmm0,%xmm0
   521c8679a:	c4 c1 7a 7f 86 70 08 00 00 	vmovdqu %xmm0,0x870(%r14)
   521c867a3:	c4 c1 7a 6f 86 80 08 00 00 	vmovdqu 0x880(%r14),%xmm0
   521c867ac:	c4 c1 7a 6f 8e 90 08 00 00 	vmovdqu 0x890(%r14),%xmm1
   521c867b5:	c4 e1 79 d4 c1       		vpaddq %xmm1,%xmm0,%xmm0
   521c867ba:	c4 c1 7a 7f 86 70 08 00 00 	vmovdqu %xmm0,0x870(%r14)
   521c867c3:	c4 c1 7a 7e 86 80 08 00 00 	vmovq  0x880(%r14),%xmm0
   521c867cc:	c4 c1 7a 7e 8e 70 08 00 00 	vmovq  0x870(%r14),%xmm1
   521c867d5:	c4 e1 79 fe c1       		vpaddd %xmm1,%xmm0,%xmm0
   521c867da:	c4 c1 79 d6 86 70 08 00 00 	vmovq  %xmm0,0x870(%r14)
   521c867e3:	49 c7 86 78 08 00 00 		movq   $0x0,0x878(%r14)
   521c867ea:	00 00 00 00 
   521c867ee:	49 c7 86 40 01 00 00 		movq   $0x40008c,0x140(%r14)
   521c867f5:	8c 00 40 00 
   521c867f9:	49 8b fe             		mov    %r14,%rdi
   521c867fc:	be 01 00 00 00       		mov    $0x1,%esi
   521c86801:	ba 00 00 00 02       		mov    $0x2000000,%edx
   521c86806:	b9 01 00 00 00       		mov    $0x1,%ecx
   521c8680b:	e8 90 40 c9 ff       		callq  0x52191a8a0
   521c86810:	48 8d 05 6c fe ff ff 		lea    -0x194(%rip),%rax
   521c86817:	e9 3c fe ff ff       		jmpq   0x521c86658

Because I already had some pending fixes to tcg/i386/ wrt VEX encoding,
I've based this on an existing tree.  The compete tree can be found at

    git://github.com/rth7680/qemu.git native-vector-registers-2


r~


Richard Henderson (8):
  tcg: Add generic vector infrastructure and ops for add/sub/logic
  target/arm: Use generic vector infrastructure for aa64 add/sub/logic
  tcg: Add types for host vectors
  tcg: Add operations for host vectors
  tcg: Add tcg_op_supported
  tcg: Add INDEX_op_invalid
  tcg: Expand target vector ops with host vector ops
  tcg/i386: Add vector operations

 Makefile.target            |   5 +-
 tcg/i386/tcg-target.h      |  46 +++-
 tcg/tcg-op-gvec.h          |  92 +++++++
 tcg/tcg-opc.h              |  91 +++++++
 tcg/tcg-runtime.h          |  16 ++
 tcg/tcg.h                  |  37 ++-
 target/arm/translate-a64.c | 137 +++++++----
 tcg/i386/tcg-target.inc.c  | 382 ++++++++++++++++++++++++++---
 tcg/tcg-op-gvec.c          | 583 +++++++++++++++++++++++++++++++++++++++++++++
 tcg/tcg-runtime-gvec.c     | 199 ++++++++++++++++
 tcg/tcg.c                  | 323 ++++++++++++++++++++++++-
 11 files changed, 1817 insertions(+), 94 deletions(-)
 create mode 100644 tcg/tcg-op-gvec.h
 create mode 100644 tcg/tcg-op-gvec.c
 create mode 100644 tcg/tcg-runtime-gvec.c

-- 
2.13.5
