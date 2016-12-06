Received: from eggs.gnu.org ([2001:4830:134:3::10]:35163)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1cEDbW-0006bD-Po
	for qemu-devel@nongnu.org; Tue, 06 Dec 2016 06:08:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1cEDbO-0004dY-SW
	for qemu-devel@nongnu.org; Tue, 06 Dec 2016 06:08:10 -0500
Received: from mail-wj0-f176.google.com ([209.85.210.176]:35714)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1cEDbO-0004cK-DB
	for qemu-devel@nongnu.org; Tue, 06 Dec 2016 06:08:02 -0500
Received: by mail-wj0-f176.google.com with SMTP id v7so315938489wjy.2
	for <qemu-devel@nongnu.org>; Tue, 06 Dec 2016 03:08:02 -0800 (PST)
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Tue, 06 Dec 2016 11:06:59 +0000
Message-ID: <87pol5z57w.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] RISU TCG failures (AArch64 on AArch64)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Claudio Fontana <claudio.fontana@huawei.com>, Claudio Fontana <claudio.fontana@gmail.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "open list:ARM" <qemu-arm@nongnu.org>, Peter Maydell <peter.maydell@linaro.org>


Hi Claudio,

I've been fixing up the RISU tests for AArch64 while I was reviewing
Richard's latest TCG series. In the process I discovered a bunch of them
fail when run on an ARMv8 host using TCG although they pass on my x86_64
desktop machine. I'm assuming (but I could be wrong) this means the bug
is in the backend so I was wondering if you could have a look?

The failing binaries can be found at:

  http://people.linaro.org/~alex.bennee/testcases/arm64.risu/

The risu is statically compiled for easy running and you can run with
the record/playback traces:

  $QEMU ./risu testcase.risu.bin -t testcase.risu.bin.trace

And the failing tests are:

  testcases.aarch64/insn_ADDPv_ADD_RES1_ADD_RES2_ADDS__INC.risu.bin
  testcases.aarch64/insn_BSL_CCMN_CCMNi_CCMP__INC.risu.bin
  testcases.aarch64/insn_MOVI_MOVK_MOVN_MOVZ__INC.risu.bin
  testcases.aarch64/insn_UCVTFv_UCVTFvf_UCVTFvis_UCVTFv_RES1__INC.risu.bin

I ran up the failures with in_asm,op,op_opt,out_asm:

loading test image testcases.aarch64/insn_ADDPv_ADD_RES1_ADD_RES2_ADDS__INC=
.risu.bin...
starting apprentice image at 0x4000801000
Executed 100 test instructions (pc=3D0x4000801574).Executed 200 test instru=
ctions (pc=3D0x4000801aec).Executed 300 test instructions (pc=3D0x4000801d0=
8).Executed 400 test instructions (pc=3D0x4000802264).Executed 500 test ins=
tructions (pc=3D0x40008027b8).Executed 600 test instructions (pc=3D0x400080=
29e8).Executed 700 test instructions (pc=3D0x4000802f3c).Executed 800 test =
instructions (pc=3D0x40008034a8).Executed 900 test instructions (pc=3D0x400=
08036cc).Executed 1000 test instructions (pc=3D0x4000803c2c).--------------=
--
IN:
0x0000004000803cac:  ab1feff6      adds x22, xzr, xzr, lsl #59
0x0000004000803cb0:  00005af0      unallocated (Unallocated)

OP:
 ld_i32 tmp0,env,$0xfffffffffffffff8
 movi_i32 tmp1,$0x0
 brcond_i32 tmp0,tmp1,ne,$L0

 ---- 0000004000803cac 0000000000000000 0000000000000000
 movi_i64 tmp2,$0x0
 movi_i64 tmp3,$0x0
 movi_i64 tmp4,$0x3b
 shl_i64 tmp3,tmp3,tmp4
 movi_i64 tmp7,$0x0
 add2_i64 tmp5,tmp6,tmp2,tmp7,tmp3,tmp7
 mov_i32 CF,tmp6
 mov_i32 ZF,tmp5
 movi_i64 tmp9,$0x20
 shr_i64 tmp8,tmp5,tmp9
 mov_i32 NF,tmp8
 or_i32 ZF,ZF,NF
 xor_i64 tmp6,tmp5,tmp2
 xor_i64 tmp7,tmp2,tmp3
 andc_i64 tmp6,tmp6,tmp7
 movi_i64 tmp8,$0x20
 shr_i64 tmp7,tmp6,tmp8
 mov_i32 VF,tmp7
 mov_i64 tmp4,tmp5
 mov_i64 x22,tmp4

 ---- 0000004000803cb0 0000000000000000 0000000000000000
 movi_i64 pc,$0x4000803cb0
 movi_i32 tmp0,$0x1
 movi_i32 tmp1,$0x2000000
 movi_i32 tmp10,$0x1
 call exception_with_syndrome,$0x0,$0,env,tmp0,tmp1,tmp10
 set_label $L0
 exit_tb $0x7f7f530323

OP after optimization and liveness analysis:
 ld_i32 tmp0,env,$0xfffffffffffffff8              dead: 1
 movi_i32 tmp1,$0x0
 brcond_i32 tmp0,tmp1,ne,$L0                      dead: 0 1

 ---- 0000004000803cac 0000000000000000 0000000000000000
 movi_i64 tmp2,$0x0
 movi_i64 tmp3,$0x0
 movi_i64 tmp7,$0x0
 add2_i64 tmp5,tmp6,tmp2,tmp7,tmp3,tmp7           dead: 2 3 4 5
 mov_i32 CF,tmp6                                  sync: 0  dead: 0 1
 mov_i32 ZF,tmp5
 movi_i64 tmp9,$0x20
 shr_i64 tmp8,tmp5,tmp9                           dead: 2
 mov_i32 NF,tmp8                                  sync: 0  dead: 1
 or_i32 ZF,ZF,NF                                  sync: 0  dead: 0 1 2
 mov_i64 tmp6,tmp5
 movi_i64 tmp8,$0x20
 shr_i64 tmp7,tmp6,tmp8                           dead: 1 2
 mov_i32 VF,tmp7                                  sync: 0  dead: 0 1
 mov_i64 tmp4,tmp5                                dead: 1
 mov_i64 x22,tmp4                                 sync: 0  dead: 0 1

 ---- 0000004000803cb0 0000000000000000 0000000000000000
 movi_i64 pc,$0x4000803cb0                        sync: 0  dead: 0
 movi_i32 tmp0,$0x1
 movi_i32 tmp1,$0x2000000
 movi_i32 tmp10,$0x1
 call exception_with_syndrome,$0x0,$0,env,tmp0,tmp1,tmp10  dead: 0 1 2 3
 set_label $L0
 exit_tb $0x7f7f530323

OUT: [size=3D108]
0x556a9c11a0:  b85f8274      ldur w20, [x19, #-8]
0x556a9c11a4:  350002d4      cbnz w20, #+0x58 (addr 0x556a9c11fc)
0x556a9c11a8:  b10003f4      adds x20, sp, #0x0 (0)
0x556a9c11ac:  9a1f03f5      adc x21, xzr, xzr
0x556a9c11b0:  b9020275      str w21, [x19, #512]
0x556a9c11b4:  2a1403f5      mov w21, w20
0x556a9c11b8:  d360fe96      lsr x22, x20, #32
0x556a9c11bc:  b9020a76      str w22, [x19, #520]
0x556a9c11c0:  2a1602b5      orr w21, w21, w22
0x556a9c11c4:  b9020e75      str w21, [x19, #524]
0x556a9c11c8:  aa1403f5      mov x21, x20
0x556a9c11cc:  d360feb5      lsr x21, x21, #32
0x556a9c11d0:  b9020675      str w21, [x19, #516]
0x556a9c11d4:  f9007a74      str x20, [x19, #240]
0x556a9c11d8:  d2879614      mov x20, #0x3cb0
0x556a9c11dc:  f2a01014      movk x20, #0x80, lsl #16
0x556a9c11e0:  f2c00814      movk x20, #0x40, lsl #32
0x556a9c11e4:  f900a274      str x20, [x19, #320]
0x556a9c11e8:  aa1303e0      mov x0, x19
0x556a9c11ec:  52800021      mov w1, #0x1
0x556a9c11f0:  320703e2      orr w2, wzr, #0x2000000
0x556a9c11f4:  52800023      mov w3, #0x1
0x556a9c11f8:  97f78fa5      bl #-0x21c16c (addr 0x556a7a508c)
0x556a9c11fc:  d2806460      mov x0, #0x323
0x556a9c1200:  f2afea60      movk x0, #0x7f53, lsl #16
0x556a9c1204:  f2c00fe0      movk x0, #0x7f, lsl #32
0x556a9c1208:  17fe41fc      b #-0x6f810 (addr 0x556a9519f8)

match status...
mismatch on regs!
master reginfo:
  faulting insn 00005af0
  X 0   : 00000000ff225c54
  X 1   : 0000000064d1164b
  X 2   : 000000007db7eb84
  X 3   : 000000009bc02b7a
  X 4   : 000000000d4a8bc5
  X 5   : 0000000050a92442
  X 6   : 00000000ad558923
  X 7   : 000000007db7e665
  X 8   : 00073e143742a844
  X 9   : 000001fea8a8b9d6
  X10   : 000000009bc04afa
  X11   : 00000000a3fcee12
  X12   : 00000000ff225c54
  X13   : 0000000052b011d6
  X14   : 000000007db7e782
  X15   : 0000000065273f09
  X16   : 000000009a3b711f
  X17   : 00000000e7c25e2a
  X18   : 03fc897150000000
  X19   : 00000000aa907c4b
  X20   : 00000007ffa9683d
  X21   : 000000007c21e4ee
  X22   : 0000007fe2276ce0
  X23   : 00000000d4a747bb
  X24   : 00000000fe4bdb8f
  X25   : 000000008087e4d4
  X26   : 00073e1338204bf0
  X27   : 000000009bc02ad9
  X28   : 00000000faec4236
  X29   : 0000000096751240
  X30   : 00000000756ae202
  sp    : deadbeefdeadbeef
  pc    : 0000000000002cb0
  flags : 00000000
  fpsr  : 00000000
  fpcr  : 00000000
  V 0   : 4b181050edcddd9ff329587f70eaec09
  V 1   : f8d561c498464914fdf738050e338a17
  V 2   : 00000000000000006b903b502d4658bb
  V 3   : 65cc84ab75c606737da0814a9e807e25
  V 4   : 0000000000000000f8d561c498464914
  V 5   : f87feff28b4cf4f8fff0000000000000
  V 6   : ad397200863056f97ce80303a088c70a
  V 7   : 00000000cd25de5d000000008afb6af9
  V 8   : f37ea9ee293d7f898000000000000000
  V 9   : 9f8442a66be12ff683bce4eabc2451c2
  V10   : a097b2fa62df52eb8e5bc172c0baf03a
  V11   : 43fe43771f1b6ffb21ce413456aa9678
  V12   : 2b1d433304993f5d60361018b7034883
  V13   : fbf6e1db7a2b5e775194dafef9cfb117
  V14   : 4ffb992fc3efc73886b3c6632f24d9a8
  V15   : 0000000000000000064941f21e5af1b1
  V16   : 000000000000000055ee141258fdcc7d
  V17   : 83dfb8a2ea6bbbee0000000000000000
  V18   : ee57166e2e00fcaf8004d234eb8b691c
  V19   : 0000000000000000870ffbb080000000
  V20   : 72206b2e71c835dafff0000000000000
  V21   : 000000000000000084067685640628d1
  V22   : ef00b69a053b8a06fbd4b7358b3b447b
  V23   : f407ece814a3a98c711a96a52a1a9be0
  V24   : 0000000000000000aeebe08ffff00000
  V25   : 5201832c4d82bf7af520121e76c11dd8
  V26   : c8697d5293118f9bd1294a748cb4337b
  V27   : e8e5a2db42831c6f7a0d079a373dfebc
  V28   : 0000000000000000ef75000e9628bacb
  V29   : e7bc7ac7af489a780006a8a144fd7280
  V30   : dc5a82b17504d2d0000000006ac4fc41
  V31   : 9d793ee167101ba1ee3086d4bd34159c
apprentice reginfo:
  faulting insn 00005af0
  X 0   : 00000000ff225c54
  X 1   : 0000000064d1164b
  X 2   : 000000007db7eb84
  X 3   : 000000009bc02b7a
  X 4   : 000000000d4a8bc5
  X 5   : 0000000050a92442
  X 6   : 00000000ad558923
  X 7   : 000000007db7e665
  X 8   : 00073e143742a844
  X 9   : 000001fea8a8b9d6
  X10   : 000000009bc04afa
  X11   : 00000000a3fcee12
  X12   : 00000000ff225c54
  X13   : 0000000052b011d6
  X14   : 000000007db7e782
  X15   : 0000000065273f09
  X16   : 000000009a3b711f
  X17   : 00000000e7c25e2a
  X18   : 03fc897150000000
  X19   : 00000000aa907c4b
  X20   : 00000007ffa9683d
  X21   : 000000007c21e4ee
  X22   : 0000000000000000
  X23   : 00000000d4a747bb
  X24   : 00000000fe4bdb8f
  X25   : 000000008087e4d4
  X26   : 00073e1338204bf0
  X27   : 000000009bc02ad9
  X28   : 00000000faec4236
  X29   : 0000000096751240
  X30   : 00000000756ae202
  sp    : deadbeefdeadbeef
  pc    : 0000000000002cb0
  flags : 40000000
  fpsr  : 00000000
  fpcr  : 00000000
  V 0   : 4b181050edcddd9ff329587f70eaec09
  V 1   : f8d561c498464914fdf738050e338a17
  V 2   : 00000000000000006b903b502d4658bb
  V 3   : 65cc84ab75c606737da0814a9e807e25
  V 4   : 0000000000000000f8d561c498464914
  V 5   : f87feff28b4cf4f8fff0000000000000
  V 6   : ad397200863056f97ce80303a088c70a
  V 7   : 00000000cd25de5d000000008afb6af9
  V 8   : f37ea9ee293d7f898000000000000000
  V 9   : 9f8442a66be12ff683bce4eabc2451c2
  V10   : a097b2fa62df52eb8e5bc172c0baf03a
  V11   : 43fe43771f1b6ffb21ce413456aa9678
  V12   : 2b1d433304993f5d60361018b7034883
  V13   : fbf6e1db7a2b5e775194dafef9cfb117
  V14   : 4ffb992fc3efc73886b3c6632f24d9a8
  V15   : 0000000000000000064941f21e5af1b1
  V16   : 000000000000000055ee141258fdcc7d
  V17   : 83dfb8a2ea6bbbee0000000000000000
  V18   : ee57166e2e00fcaf8004d234eb8b691c
  V19   : 0000000000000000870ffbb080000000
  V20   : 72206b2e71c835dafff0000000000000
  V21   : 000000000000000084067685640628d1
  V22   : ef00b69a053b8a06fbd4b7358b3b447b
  V23   : f407ece814a3a98c711a96a52a1a9be0
  V24   : 0000000000000000aeebe08ffff00000
  V25   : 5201832c4d82bf7af520121e76c11dd8
  V26   : c8697d5293118f9bd1294a748cb4337b
  V27   : e8e5a2db42831c6f7a0d079a373dfebc
  V28   : 0000000000000000ef75000e9628bacb
  V29   : e7bc7ac7af489a780006a8a144fd7280
  V30   : dc5a82b17504d2d0000000006ac4fc41
  V31   : 9d793ee167101ba1ee3086d4bd34159c
mismatch detail (master : apprentice):
  X22   : 0000007fe2276ce0 vs 0000000000000000
  flags : 00000000 vs 40000000


loading test image testcases.aarch64/insn_BSL_CCMN_CCMNi_CCMP__INC.risu.bin=
...
starting apprentice image at 0x4000801000
----------------
IN:
0x000000400080157c:  3a5cabed      ccmn wzr, #28, #NZcV, ge
0x0000004000801580:  00005af0      unallocated (Unallocated)

OP:
 ld_i32 tmp0,env,$0xfffffffffffffff8
 movi_i32 tmp1,$0x0
 brcond_i32 tmp0,tmp1,ne,$L0

 ---- 000000400080157c 0000000000000000 0000000000000000
 xor_i32 tmp1,VF,NF
 movi_i32 tmp2,$0x0
 setcond_i32 tmp0,tmp1,tmp2,lt
 movi_i64 tmp3,$0x1c
 movi_i64 tmp4,$0x0
 movi_i32 tmp6,$0x0
 mov_i32 tmp1,tmp4
 mov_i32 tmp2,tmp3
 add2_i32 NF,CF,tmp1,tmp6,tmp2,tmp6
 mov_i32 ZF,NF
 xor_i32 VF,NF,tmp1
 xor_i32 tmp6,tmp1,tmp2
 andc_i32 VF,VF,tmp6
 extu_i32_i64 tmp5,NF
 neg_i32 tmp1,tmp0
 movi_i32 tmp6,$0x1
 sub_i32 tmp2,tmp0,tmp6
 or_i32 NF,NF,tmp1
 andc_i32 ZF,ZF,tmp1
 andc_i32 CF,CF,tmp1
 or_i32 VF,VF,tmp1

 ---- 0000004000801580 0000000000000000 0000000000000000
 movi_i64 pc,$0x4000801580
 movi_i32 tmp0,$0x1
 movi_i32 tmp1,$0x2000000
 movi_i32 tmp2,$0x1
 call exception_with_syndrome,$0x0,$0,env,tmp0,tmp1,tmp2
 set_label $L0
 exit_tb $0x7fb28eb38b

OP after optimization and liveness analysis:
 ld_i32 tmp0,env,$0xfffffffffffffff8              dead: 1
 movi_i32 tmp1,$0x0
 brcond_i32 tmp0,tmp1,ne,$L0                      dead: 0 1

 ---- 000000400080157c 0000000000000000 0000000000000000
 xor_i32 tmp1,VF,NF                               dead: 1 2
 movi_i32 tmp2,$0x0
 setcond_i32 tmp0,tmp1,tmp2,lt                    dead: 1 2
 movi_i64 tmp3,$0x1c
 movi_i64 tmp4,$0x0
 movi_i32 tmp6,$0x0
 mov_i32 tmp1,tmp4                                dead: 1
 mov_i32 tmp2,tmp3                                dead: 1
 add2_i32 NF,CF,tmp1,tmp6,tmp2,tmp6               dead: 3 5
 mov_i32 ZF,NF
 xor_i32 VF,NF,tmp1
 xor_i32 tmp6,tmp1,tmp2                           dead: 1 2
 andc_i32 VF,VF,tmp6                              dead: 1 2
 neg_i32 tmp1,tmp0                                dead: 1
 or_i32 NF,NF,tmp1                                sync: 0  dead: 0 1
 andc_i32 ZF,ZF,tmp1                              sync: 0  dead: 0 1
 andc_i32 CF,CF,tmp1                              sync: 0  dead: 0 1
 or_i32 VF,VF,tmp1                                sync: 0  dead: 0 1 2

 ---- 0000004000801580 0000000000000000 0000000000000000
 movi_i64 pc,$0x4000801580                        sync: 0  dead: 0
 movi_i32 tmp0,$0x1
 movi_i32 tmp1,$0x2000000
 movi_i32 tmp2,$0x1
 call exception_with_syndrome,$0x0,$0,env,tmp0,tmp1,tmp2  dead: 0 1 2 3
 set_label $L0
 exit_tb $0x7fb28eb38b

OUT: [size=3D144]
0x55956bfc30:  b85f8274      ldur w20, [x19, #-8]
0x55956bfc34:  350003f4      cbnz w20, #+0x7c (addr 0x55956bfcb0)
0x55956bfc38:  b9420674      ldr w20, [x19, #516]
0x55956bfc3c:  b9420a75      ldr w21, [x19, #520]
0x55956bfc40:  4a150294      eor w20, w20, w21
0x55956bfc44:  7100029f      cmp w20, #0x0 (0)
0x55956bfc48:  1a9fa7f4      cset w20, lt
0x55956bfc4c:  310073f5      adds w21, wsp, #0x1c (28)
0x55956bfc50:  1a1f03f6      adc w22, wzr, wzr
0x55956bfc54:  2a1503f7      mov w23, w21
0x55956bfc58:  52800018      mov w24, #0x0
0x55956bfc5c:  4a1802b9      eor w25, w21, w24
0x55956bfc60:  521e0b18      eor w24, w24, #0x1c
0x55956bfc64:  0a380338      bic w24, w25, w24
0x55956bfc68:  4b1403f4      neg w20, w20
0x55956bfc6c:  2a1402b5      orr w21, w21, w20
0x55956bfc70:  b9020a75      str w21, [x19, #520]
0x55956bfc74:  0a3402f5      bic w21, w23, w20
0x55956bfc78:  b9020e75      str w21, [x19, #524]
0x55956bfc7c:  0a3402d5      bic w21, w22, w20
0x55956bfc80:  b9020275      str w21, [x19, #512]
0x55956bfc84:  2a140314      orr w20, w24, w20
0x55956bfc88:  b9020674      str w20, [x19, #516]
0x55956bfc8c:  d282b014      mov x20, #0x1580
0x55956bfc90:  f2a01014      movk x20, #0x80, lsl #16
0x55956bfc94:  f2c00814      movk x20, #0x40, lsl #32
0x55956bfc98:  f900a274      str x20, [x19, #320]
0x55956bfc9c:  aa1303e0      mov x0, x19
0x55956bfca0:  52800021      mov w1, #0x1
0x55956bfca4:  320703e2      orr w2, wzr, #0x2000000
0x55956bfca8:  52800023      mov w3, #0x1
0x55956bfcac:  97f844f8      bl #-0x1eec20 (addr 0x55954d108c)
0x55956bfcb0:  d2967160      mov x0, #0xb38b
0x55956bfcb4:  f2b651c0      movk x0, #0xb28e, lsl #16
0x55956bfcb8:  f2c00fe0      movk x0, #0x7f, lsl #32
0x55956bfcbc:  17fef74f      b #-0x422c4 (addr 0x559567d9f8)

match status...
mismatch on regs!
master reginfo:
  faulting insn 00005af0
  X 0   : 0000000054e791ef
  X 1   : 00000000ccd22f6d
  X 2   : 0000000028cc17b5
  X 3   : 00000000dcffdc41
  X 4   : 000000009a4e4303
  X 5   : 000000006b826d08
  X 6   : 00000000fb3a37aa
  X 7   : 00000000de7006b8
  X 8   : 0000000076cb2211
  X 9   : 000000003f312441
  X10   : 00000000d83a3b3f
  X11   : 00000000d7dec11f
  X12   : 00000000bc8bb1d8
  X13   : 0000000021d78488
  X14   : 000000007a0fe3e6
  X15   : 00000000c8ca4eff
  X16   : 000000007f623bae
  X17   : 00000000919e155b
  X18   : 0000000071adf1e9
  X19   : 000000000904bf75
  X20   : 0000000054f40213
  X21   : 000000006d379e20
  X22   : 00000000952351ac
  X23   : 00000000168b4b22
  X24   : 00000000acc579a2
  X25   : 0000000096623735
  X26   : 000000003c575939
  X27   : 00000000bea11d65
  X28   : 00000000f556ac2f
  X29   : 00000000dd3fd845
  X30   : 00000000130dd9f8
  sp    : deadbeefdeadbeef
  pc    : 0000000000000580
  flags : 90000000
  fpsr  : 00000000
  fpcr  : 00000000
  V 0   : 0000000000000000f6fad5fc54490b5b
  V 1   : c92a23e5dfb82d755e67775cb133a2d2
  V 2   : 7230108f429de8b8bb8668165a8dee77
  V 3   : c6dbb4cbb72d89909366db01d8543907
  V 4   : 7ff0f4a3640408fb8b9410521c257973
  V 5   : 000000000000000009020029d40016a0
  V 6   : 8001791520ab8241ca1a1b766f98a03d
  V 7   : 00000000000000002f6edfbb96a09614
  V 8   : 80026516438f5bc36e3c8d1ce0792487
  V 9   : c524ba8cb487b236c56306751b7df80a
  V10   : 8004ee5cee119cf4a61983c0696606b1
  V11   : affc1cc3939958bb9bb99bb96fa3a807
  V12   : 76a31030f5f475d423674bf4a1daba9e
  V13   : c92a23e5dfb82d75ec789284496504a3
  V14   : 0000000000000000c30202763b18a008
  V15   : fc0fdb34265e4433ddac85c59372c676
  V16   : a6b00000000000002f6edfbb96a09614
  V17   : ce1f480ff669bee7485789a9923dae5f
  V18   : 0000000000000000a9e74be4b1fac2fe
  V19   : b91d867fa4637ccd6d0708009749c46d
  V20   : 11ab331eb418cdd9c6396b470da4bcdd
  V21   : fff00000000000000000000000000000
  V22   : 6ee7a2520059bd1579c55c320dab01b5
  V23   : 000b39dd5130491f8f0a3609dc1536e3
  V24   : 6ee7a2520059bd15bac75e4436b3a1bd
  V25   : 7a39605a20b32c42c31cd2d4f09a8825
  V26   : 80000000000000000000000000000000
  V27   : da266861c9f797c9db95adf4174c5530
  V28   : 19781e2fe88b0a29bf484626d402cd05
  V29   : ee3f4885f470f6e7d157c9afd2302e5d
  V30   : a6756d2730fb8708d0bed24263d4e367
  V31   : 0000000000000000b21fe5d8f856a671
apprentice reginfo:
  faulting insn 00005af0
  X 0   : 0000000054e791ef
  X 1   : 00000000ccd22f6d
  X 2   : 0000000028cc17b5
  X 3   : 00000000dcffdc41
  X 4   : 000000009a4e4303
  X 5   : 000000006b826d08
  X 6   : 00000000fb3a37aa
  X 7   : 00000000de7006b8
  X 8   : 0000000076cb2211
  X 9   : 000000003f312441
  X10   : 00000000d83a3b3f
  X11   : 00000000d7dec11f
  X12   : 00000000bc8bb1d8
  X13   : 0000000021d78488
  X14   : 000000007a0fe3e6
  X15   : 00000000c8ca4eff
  X16   : 000000007f623bae
  X17   : 00000000919e155b
  X18   : 0000000071adf1e9
  X19   : 000000000904bf75
  X20   : 0000000054f40213
  X21   : 000000006d379e20
  X22   : 00000000952351ac
  X23   : 00000000168b4b22
  X24   : 00000000acc579a2
  X25   : 0000000096623735
  X26   : 000000003c575939
  X27   : 00000000bea11d65
  X28   : 00000000f556ac2f
  X29   : 00000000dd3fd845
  X30   : 00000000130dd9f8
  sp    : deadbeefdeadbeef
  pc    : 0000000000000580
  flags : 00000000
  fpsr  : 00000000
  fpcr  : 00000000
  V 0   : 0000000000000000f6fad5fc54490b5b
  V 1   : c92a23e5dfb82d755e67775cb133a2d2
  V 2   : 7230108f429de8b8bb8668165a8dee77
  V 3   : c6dbb4cbb72d89909366db01d8543907
  V 4   : 7ff0f4a3640408fb8b9410521c257973
  V 5   : 000000000000000009020029d40016a0
  V 6   : 8001791520ab8241ca1a1b766f98a03d
  V 7   : 00000000000000002f6edfbb96a09614
  V 8   : 80026516438f5bc36e3c8d1ce0792487
  V 9   : c524ba8cb487b236c56306751b7df80a
  V10   : 8004ee5cee119cf4a61983c0696606b1
  V11   : affc1cc3939958bb9bb99bb96fa3a807
  V12   : 76a31030f5f475d423674bf4a1daba9e
  V13   : c92a23e5dfb82d75ec789284496504a3
  V14   : 0000000000000000c30202763b18a008
  V15   : fc0fdb34265e4433ddac85c59372c676
  V16   : a6b00000000000002f6edfbb96a09614
  V17   : ce1f480ff669bee7485789a9923dae5f
  V18   : 0000000000000000a9e74be4b1fac2fe
  V19   : b91d867fa4637ccd6d0708009749c46d
  V20   : 11ab331eb418cdd9c6396b470da4bcdd
  V21   : fff00000000000000000000000000000
  V22   : 6ee7a2520059bd1579c55c320dab01b5
  V23   : 000b39dd5130491f8f0a3609dc1536e3
  V24   : 6ee7a2520059bd15bac75e4436b3a1bd
  V25   : 7a39605a20b32c42c31cd2d4f09a8825
  V26   : 80000000000000000000000000000000
  V27   : da266861c9f797c9db95adf4174c5530
  V28   : 19781e2fe88b0a29bf484626d402cd05
  V29   : ee3f4885f470f6e7d157c9afd2302e5d
  V30   : a6756d2730fb8708d0bed24263d4e367
  V31   : 0000000000000000b21fe5d8f856a671
mismatch detail (master : apprentice):
  flags : 90000000 vs 00000000

loading test image testcases.aarch64/insn_MOVI_MOVK_MOVN_MOVZ__INC.risu.bin=
...
starting apprentice image at 0x4000801000
Executed 100 test instructions (pc=3D0x40008015e4).Executed 200 test instru=
ctions (pc=3D0x4000801bd0).Executed 300 test instructions (pc=3D0x40008021c=
c).Executed 400 test instructions (pc=3D0x40008027c0).Executed 500 test ins=
tructions (pc=3D0x4000802da4).Executed 600 test instructions (pc=3D0x400080=
302c).Executed 700 test instructions (pc=3D0x400080360c).Executed 800 test =
instructions (pc=3D0x4000803c0c).Executed 900 test instructions (pc=3D0x400=
08041e0).Executed 1000 test instructions (pc=3D0x40008047d0).Executed 1100 =
test instructions (pc=3D0x4000804de8).Executed 1200 test instructions (pc=
=3D0x4000805070).Executed 1300 test instructions (pc=3D0x4000805664).Execut=
ed 1400 test instructions (pc=3D0x4000805c40).Executed 1500 test instructio=
ns (pc=3D0x400080622c).Executed 1600 test instructions (pc=3D0x4000806838).=
Executed 1700 test instructions (pc=3D0x4000806ac8).Executed 1800 test inst=
ructions (pc=3D0x40008070c4).Executed 1900 test instructions (pc=3D0x400080=
76d0).Executed 2000 test instructions (pc=3D0x4000807ce4).Executed 2100 tes=
t instructions (pc=3D0x4000808300).Executed 2200 test instructions (pc=3D0x=
4000808904).Executed 2300 test instructions (pc=3D0x4000808f14).Executed 24=
00 test instructions (pc=3D0x40008091b8).Executed 2500 test instructions (p=
c=3D0x400080978c).Executed 2600 test instructions (pc=3D0x4000809d80).Execu=
ted 2700 test instructions (pc=3D0x400080a37c).Executed 2800 test instructi=
ons (pc=3D0x400080a990).Executed 2900 test instructions (pc=3D0x400080af8c)=
.Executed 3000 test instructions (pc=3D0x400080b228).Executed 3100 test ins=
tructions (pc=3D0x400080b818).Executed 3200 test instructions (pc=3D0x40008=
0bdfc).----------------
IN:
0x000000400080be2c:  6f01e7a0      movi v0.2d, #0xffffffff00ff
0x000000400080be30:  00005af0      unallocated (Unallocated)

OP:
 ld_i32 tmp0,env,$0xfffffffffffffff8
 movi_i32 tmp1,$0x0
 brcond_i32 tmp0,tmp1,ne,$L0

 ---- 000000400080be2c 0000000000000000 0000000000000000
 movi_i64 tmp2,$0xffffffff00ff
 mov_i64 tmp3,tmp2
 st_i64 tmp3,env,$0x838
 mov_i64 tmp3,tmp2
 st_i64 tmp3,env,$0x840

 ---- 000000400080be30 0000000000000000 0000000000000000
 movi_i64 pc,$0x400080be30
 movi_i32 tmp0,$0x1
 movi_i32 tmp1,$0x2000000
 movi_i32 tmp4,$0x1
 call exception_with_syndrome,$0x0,$0,env,tmp0,tmp1,tmp4
 set_label $L0
 exit_tb $0x7f8dc34b03

OP after optimization and liveness analysis:
 ld_i32 tmp0,env,$0xfffffffffffffff8              dead: 1
 movi_i32 tmp1,$0x0
 brcond_i32 tmp0,tmp1,ne,$L0                      dead: 0 1

 ---- 000000400080be2c 0000000000000000 0000000000000000
 movi_i64 tmp2,$0xffffffff00ff
 mov_i64 tmp3,tmp2                                dead: 1
 st_i64 tmp3,env,$0x838
 st_i64 tmp3,env,$0x840                           dead: 0

 ---- 000000400080be30 0000000000000000 0000000000000000
 movi_i64 pc,$0x400080be30                        sync: 0  dead: 0
 movi_i32 tmp0,$0x1
 movi_i32 tmp1,$0x2000000
 movi_i32 tmp4,$0x1
 call exception_with_syndrome,$0x0,$0,env,tmp0,tmp1,tmp4  dead: 0 1 2 3
 set_label $L0
 exit_tb $0x7f8dc34b03

OUT: [size=3D72]
0x5561a8beb0:  b85f8274      ldur w20, [x19, #-8]
0x5561a8beb4:  350001b4      cbnz w20, #+0x34 (addr 0x5561a8bee8)
0x5561a8beb8:  929fe014      mov x20, #0xffffffffffff00ff
0x5561a8bebc:  f9041e74      str x20, [x19, #2104]
0x5561a8bec0:  f9042274      str x20, [x19, #2112]
0x5561a8bec4:  d297c614      mov x20, #0xbe30
0x5561a8bec8:  f2a01014      movk x20, #0x80, lsl #16
0x5561a8becc:  f2c00814      movk x20, #0x40, lsl #32
0x5561a8bed0:  f900a274      str x20, [x19, #320]
0x5561a8bed4:  aa1303e0      mov x0, x19
0x5561a8bed8:  52800021      mov w1, #0x1
0x5561a8bedc:  320703e2      orr w2, wzr, #0x2000000
0x5561a8bee0:  52800023      mov w3, #0x1
0x5561a8bee4:  97f6206a      bl #-0x277e58 (addr 0x556181408c)
0x5561a8bee8:  d2896060      mov x0, #0x4b03
0x5561a8beec:  f2b1b860      movk x0, #0x8dc3, lsl #16
0x5561a8bef0:  f2c00fe0      movk x0, #0x7f, lsl #32
0x5561a8bef4:  17fcd2c1      b #-0xcb4fc (addr 0x55619c09f8)

match status...
mismatch on regs!
master reginfo:
  faulting insn 00005af0
  X 0   : 00000000ffff781d
  X 1   : 0000000038022a0a
  X 2   : 000000003e36e304
  X 3   : 1bf3000074dca93e
  X 4   : 00005f5f00000000
  X 5   : 0000000008cb30c3
  X 6   : 00000000c65a145a
  X 7   : 000000000322f0e0
  X 8   : 00000000ec2e6000
  X 9   : 00000000befa3651
  X10   : 00000000f094bb90
  X11   : 00000000b2b00ca3
  X12   : 7ca0000000000000
  X13   : 00000000f6190000
  X14   : ffff7f48ffffffff
  X15   : 00000000a9eab3dc
  X16   : 0000000047e636f3
  X17   : f8c8000000000000
  X18   : 000000000000d3ff
  X19   : ffffffffffff13d9
  X20   : 0000000006bd3a73
  X21   : 00000000a07c7f5a
  X22   : 000000007f6ab4ef
  X23   : 0000b7cd00000000
  X24   : 000000000f38c127
  X25   : 00000000b70c0a6c
  X26   : 00000000c3b62661
  X27   : 00000000a0b9c109
  X28   : 87d6ffffffffffff
  X29   : 00000000667b788c
  X30   : 0000000000009258
  sp    : deadbeefdeadbeef
  pc    : 000000000000ae30
  flags : 00000000
  fpsr  : 00000000
  fpcr  : 00000000
  V 0   : ffffffffffff00ffffffffffffff00ff
  V 1   : 00ffffffffffff0000ffffffffffff00
  V 2   : 8cc7b063ae603231fff7accd17e5bdba
  V 3   : 00f600f600f600f600f600f600f600f6
  V 4   : 0000abff0000abff0000abff0000abff
  V 5   : 603387a8c0bb2f14d7ee56ffbf75f62a
  V 6   : 0f2b5e0d1aa56eaafa5fa1974138bb6b
  V 7   : 00000000000000000000d0000000d000
  V 8   : 0000000000000000000019ff000019ff
  V 9   : 0000000000000000000000d4000000d4
  V10   : 00000000000000009ace4ce3595a3442
  V11   : 80e03077660c09840000000000000000
  V12   : b93f81ceba1aaf2bd06284c252df8eee
  V13   : a8eb828fd952186b24d8560f1a0683e9
  V14   : 0000000000000000ffff0000ff000000
  V15   : e8566877b61aa635d14cc7e102bbda7b
  V16   : 0000000000000000da00da00da00da00
  V17   : 54545454545454545454545454545454
  V18   : f7c8e03949c754a1000688a2043e3233
  V19   : 0000000000000000ff00ff00ffffffff
  V20   : 17d2cce265ad7d36000f7e9b1519d0c4
  V21   : 00004800000048000000480000004800
  V22   : 1fe97bcb98134394986838a9d2bc875d
  V23   : 0000000000000000ff00ff00ff00ff00
  V24   : 00000000000000000000e5f452b0237e
  V25   : 00004800000048000000480000004800
  V26   : e4ffb98816b5457c4216e34cc12af23d
  V27   : 0000f4000000f4000000f4000000f400
  V28   : 000048ff000048ff000048ff000048ff
  V29   : 00910091009100910091009100910091
  V30   : 81f9a439fd298374cf404295a08607fc
  V31   : eac59275c21c5804197b241e60e5191a
apprentice reginfo:
  faulting insn 00005af0
  X 0   : 00000000ffff781d
  X 1   : 0000000038022a0a
  X 2   : 000000003e36e304
  X 3   : 1bf3000074dca93e
  X 4   : 00005f5f00000000
  X 5   : 0000000008cb30c3
  X 6   : 00000000c65a145a
  X 7   : 000000000322f0e0
  X 8   : 00000000ec2e6000
  X 9   : 00000000befa3651
  X10   : 00000000f094bb90
  X11   : 00000000b2b00ca3
  X12   : 7ca0000000000000
  X13   : 00000000f6190000
  X14   : ffff7f48ffffffff
  X15   : 00000000a9eab3dc
  X16   : 0000000047e636f3
  X17   : f8c8000000000000
  X18   : 000000000000d3ff
  X19   : ffffffffffff13d9
  X20   : 0000000006bd3a73
  X21   : 00000000a07c7f5a
  X22   : 000000007f6ab4ef
  X23   : 0000b7cd00000000
  X24   : 000000000f38c127
  X25   : 00000000b70c0a6c
  X26   : 00000000c3b62661
  X27   : 00000000a0b9c109
  X28   : 87d6ffffffffffff
  X29   : 00000000667b788c
  X30   : 0000000000009258
  sp    : deadbeefdeadbeef
  pc    : 000000000000ae30
  flags : 00000000
  fpsr  : 00000000
  fpcr  : 00000000
  V 0   : 0000ffffffff00ff0000ffffffff00ff
  V 1   : 00ffffffffffff0000ffffffffffff00
  V 2   : 8cc7b063ae603231fff7accd17e5bdba
  V 3   : 00f600f600f600f600f600f600f600f6
  V 4   : 0000abff0000abff0000abff0000abff
  V 5   : 603387a8c0bb2f14d7ee56ffbf75f62a
  V 6   : 0f2b5e0d1aa56eaafa5fa1974138bb6b
  V 7   : 00000000000000000000d0000000d000
  V 8   : 0000000000000000000019ff000019ff
  V 9   : 0000000000000000000000d4000000d4
  V10   : 00000000000000009ace4ce3595a3442
  V11   : 80e03077660c09840000000000000000
  V12   : b93f81ceba1aaf2bd06284c252df8eee
  V13   : a8eb828fd952186b24d8560f1a0683e9
  V14   : 0000000000000000ffff0000ff000000
  V15   : e8566877b61aa635d14cc7e102bbda7b
  V16   : 0000000000000000da00da00da00da00
  V17   : 54545454545454545454545454545454
  V18   : f7c8e03949c754a1000688a2043e3233
  V19   : 0000000000000000ff00ff00ffffffff
  V20   : 17d2cce265ad7d36000f7e9b1519d0c4
  V21   : 00004800000048000000480000004800
  V22   : 1fe97bcb98134394986838a9d2bc875d
  V23   : 0000000000000000ff00ff00ff00ff00
  V24   : 00000000000000000000e5f452b0237e
  V25   : 00004800000048000000480000004800
  V26   : e4ffb98816b5457c4216e34cc12af23d
  V27   : 0000f4000000f4000000f4000000f400
  V28   : 000048ff000048ff000048ff000048ff
  V29   : 00910091009100910091009100910091
  V30   : 81f9a439fd298374cf404295a08607fc
  V31   : eac59275c21c5804197b241e60e5191a
mismatch detail (master : apprentice):
  V 0   : ffffffffffff00ffffffffffffff00ff vs 0000ffffffff00ff0000ffffffff0=
0ff

loading test image testcases.aarch64/insn_UCVTFv_UCVTFvf_UCVTFvis_UCVTFv_RE=
S1__INC.risu.bin...
starting apprentice image at 0x4000801000
Executed 100 test instructions (pc=3D0x400080158c).Executed 200 test instru=
ctions (pc=3D0x4000801b10).Executed 300 test instructions (pc=3D0x400080208=
c).Executed 400 test instructions (pc=3D0x40008022c8).Executed 500 test ins=
tructions (pc=3D0x4000802880).Executed 600 test instructions (pc=3D0x400080=
2e10).Executed 700 test instructions (pc=3D0x4000803034).Executed 800 test =
instructions (pc=3D0x40008035a8).----------------
IN:
0x0000004000803a74:  6f01e6fc      movi v28.2d, #0xffff00ffffff
0x0000004000803a78:  00005af0      unallocated (Unallocated)

OP:
 ld_i32 tmp0,env,$0xfffffffffffffff8
 movi_i32 tmp1,$0x0
 brcond_i32 tmp0,tmp1,ne,$L0

 ---- 0000004000803a74 0000000000000000 0000000000000000
 movi_i64 tmp2,$0xffff00ffffff
 mov_i64 tmp3,tmp2
 st_i64 tmp3,env,$0x9f8
 mov_i64 tmp3,tmp2
 st_i64 tmp3,env,$0xa00

 ---- 0000004000803a78 0000000000000000 0000000000000000
 movi_i64 pc,$0x4000803a78
 movi_i32 tmp0,$0x1
 movi_i32 tmp1,$0x2000000
 movi_i32 tmp4,$0x1
 call exception_with_syndrome,$0x0,$0,env,tmp0,tmp1,tmp4
 set_label $L0
 exit_tb $0x7f85e7670b

OP after optimization and liveness analysis:
 ld_i32 tmp0,env,$0xfffffffffffffff8              dead: 1
 movi_i32 tmp1,$0x0
 brcond_i32 tmp0,tmp1,ne,$L0                      dead: 0 1

 ---- 0000004000803a74 0000000000000000 0000000000000000
 movi_i64 tmp2,$0xffff00ffffff
 mov_i64 tmp3,tmp2                                dead: 1
 st_i64 tmp3,env,$0x9f8
 st_i64 tmp3,env,$0xa00                           dead: 0

 ---- 0000004000803a78 0000000000000000 0000000000000000
 movi_i64 pc,$0x4000803a78                        sync: 0  dead: 0
 movi_i32 tmp0,$0x1
 movi_i32 tmp1,$0x2000000
 movi_i32 tmp4,$0x1
 call exception_with_syndrome,$0x0,$0,env,tmp0,tmp1,tmp4  dead: 0 1 2 3
 set_label $L0
 exit_tb $0x7f85e7670b

OUT: [size=3D72]
0x555c897290:  b85f8274      ldur w20, [x19, #-8]
0x555c897294:  350001b4      cbnz w20, #+0x34 (addr 0x555c8972c8)
0x555c897298:  92bfe014      mov x20, #0xffffffff00ffffff
0x555c89729c:  f904fe74      str x20, [x19, #2552]
0x555c8972a0:  f9050274      str x20, [x19, #2560]
0x555c8972a4:  d2874f14      mov x20, #0x3a78
0x555c8972a8:  f2a01014      movk x20, #0x80, lsl #16
0x555c8972ac:  f2c00814      movk x20, #0x40, lsl #32
0x555c8972b0:  f900a274      str x20, [x19, #320]
0x555c8972b4:  aa1303e0      mov x0, x19
0x555c8972b8:  52800021      mov w1, #0x1
0x555c8972bc:  320703e2      orr w2, wzr, #0x2000000
0x555c8972c0:  52800023      mov w3, #0x1
0x555c8972c4:  97f7ab72      bl #-0x215238 (addr 0x555c68208c)
0x555c8972c8:  d28ce160      mov x0, #0x670b
0x555c8972cc:  f2b0bce0      movk x0, #0x85e7, lsl #16
0x555c8972d0:  f2c00fe0      movk x0, #0x7f, lsl #32
0x555c8972d4:  17fe5dc9      b #-0x688dc (addr 0x555c82e9f8)

match status...
mismatch on regs!
master reginfo:
  faulting insn 00005af0
  X 0   : 000000008087e4d4
  X 1   : 00000000e7c25e15
  X 2   : 00000000e3d63bb7
  X 3   : 00000000faec4236
  X 4   : 0000000096751240
  X 5   : 00000000756ae202
  X 6   : 000000009ae8fc71
  X 7   : 000000000e44e893
  X 8   : 00000000a8533746
  X 9   : 00000000784d5317
  X10   : 00000000c1fd98f2
  X11   : 000000000f58e580
  X12   : 00000000259e6328
  X13   : 00000000cc862679
  X14   : 00000000b43c7860
  X15   : 00000000b5473561
  X16   : 000000001c19e340
  X17   : 000000007c523e48
  X18   : 000000006dcb5783
  X19   : 0000000005354354
  X20   : 000000004fe16622
  X21   : 00000000021d37ef
  X22   : 0000000093b41a85
  X23   : 0000000068bc51a6
  X24   : 00000000f6c6ad01
  X25   : 000000007cf5cbb8
  X26   : 00000000cbc076f9
  X27   : 00000000a4e07589
  X28   : 00000000e78e6f51
  X29   : 00000000953011a6
  X30   : 000000002ad7ba1e
  sp    : deadbeefdeadbeef
  pc    : 0000000000002a78
  flags : 00000000
  fpsr  : 00000010
  fpcr  : 00000000
  V 0   : 63e904dc2a3f270278436d590bf90996
  V 1   : aa3f2718a088c70a1feeab9d7ce80303
  V 2   : 0b0f9e9bab02513ff87feff2003a6a8a
  V 3   : f37ea9ee293d7f89ad3972001fcf0d40
  V 4   : 5c93e109751063cf6331512a28d5ca2b
  V 5   : a097b2fa62df52eb8e5bc172c0baf03a
  V 6   : 0000000000000000000000004d54a8bc
  V 7   : 2b1d433304993f5d60361018b7034883
  V 8   : fbf6e1db7a2b5e775194dafef9cfb117
  V 9   : 4ffb992fc3efc73886b3c6632f24d9a8
  V10   : f1fd3dfd3e78ca4300077f5ead0c8c5d
  V11   : 000000000000000055ee141258fdcc7d
  V12   : 83dfb8a2ea6bbbee0000000000000000
  V13   : ee57166e2e00fcaf8004d234eb8b691c
  V14   : 00000000000000004175201240ed823c
  V15   : 72206b2e71c835dafff0000000000000
  V16   : 94acecec29b5cb817ff99850c8aeb624
  V17   : ec53509c12f81522000eff8231cd9b7c
  V18   : f407ece814a3a98c711a96a52a1a9be0
  V19   : a33ea61e6cda1c32199512b8b2897c22
  V20   : 5201832c4d82bf7af520121e76c11dd8
  V21   : c8697d5293118f9bd1294a748cb4337b
  V22   : e8e5a2db42831c6f7a0d079a373dfebc
  V23   : ea4ebbd5f80df9929351c574a6728493
  V24   : e7bc7ac7af489a780006a8a144fd7280
  V25   : 2d49197c118d654ffffb4e7a07461b04
  V26   : 9d793ee167101ba1ee3086d4bd34159c
  V27   : 63ad79cbaf6aa455be922cd3db024ca2
  V28   : ffffffff00ffffffffffffff00ffffff
  V29   : 63f011d6476bcdeead558923378283f8
  V30   : 4e70acca0fa09b0dfd42e6a6ad86168c
  V31   : d4a747bba3fcee129a3b711faa907c4b
apprentice reginfo:
  faulting insn 00005af0
  X 0   : 000000008087e4d4
  X 1   : 00000000e7c25e15
  X 2   : 00000000e3d63bb7
  X 3   : 00000000faec4236
  X 4   : 0000000096751240
  X 5   : 00000000756ae202
  X 6   : 000000009ae8fc71
  X 7   : 000000000e44e893
  X 8   : 00000000a8533746
  X 9   : 00000000784d5317
  X10   : 00000000c1fd98f2
  X11   : 000000000f58e580
  X12   : 00000000259e6328
  X13   : 00000000cc862679
  X14   : 00000000b43c7860
  X15   : 00000000b5473561
  X16   : 000000001c19e340
  X17   : 000000007c523e48
  X18   : 000000006dcb5783
  X19   : 0000000005354354
  X20   : 000000004fe16622
  X21   : 00000000021d37ef
  X22   : 0000000093b41a85
  X23   : 0000000068bc51a6
  X24   : 00000000f6c6ad01
  X25   : 000000007cf5cbb8
  X26   : 00000000cbc076f9
  X27   : 00000000a4e07589
  X28   : 00000000e78e6f51
  X29   : 00000000953011a6
  X30   : 000000002ad7ba1e
  sp    : deadbeefdeadbeef
  pc    : 0000000000002a78
  flags : 00000000
  fpsr  : 00000010
  fpcr  : 00000000
  V 0   : 63e904dc2a3f270278436d590bf90996
  V 1   : aa3f2718a088c70a1feeab9d7ce80303
  V 2   : 0b0f9e9bab02513ff87feff2003a6a8a
  V 3   : f37ea9ee293d7f89ad3972001fcf0d40
  V 4   : 5c93e109751063cf6331512a28d5ca2b
  V 5   : a097b2fa62df52eb8e5bc172c0baf03a
  V 6   : 0000000000000000000000004d54a8bc
  V 7   : 2b1d433304993f5d60361018b7034883
  V 8   : fbf6e1db7a2b5e775194dafef9cfb117
  V 9   : 4ffb992fc3efc73886b3c6632f24d9a8
  V10   : f1fd3dfd3e78ca4300077f5ead0c8c5d
  V11   : 000000000000000055ee141258fdcc7d
  V12   : 83dfb8a2ea6bbbee0000000000000000
  V13   : ee57166e2e00fcaf8004d234eb8b691c
  V14   : 00000000000000004175201240ed823c
  V15   : 72206b2e71c835dafff0000000000000
  V16   : 94acecec29b5cb817ff99850c8aeb624
  V17   : ec53509c12f81522000eff8231cd9b7c
  V18   : f407ece814a3a98c711a96a52a1a9be0
  V19   : a33ea61e6cda1c32199512b8b2897c22
  V20   : 5201832c4d82bf7af520121e76c11dd8
  V21   : c8697d5293118f9bd1294a748cb4337b
  V22   : e8e5a2db42831c6f7a0d079a373dfebc
  V23   : ea4ebbd5f80df9929351c574a6728493
  V24   : e7bc7ac7af489a780006a8a144fd7280
  V25   : 2d49197c118d654ffffb4e7a07461b04
  V26   : 9d793ee167101ba1ee3086d4bd34159c
  V27   : 63ad79cbaf6aa455be922cd3db024ca2
  V28   : 0000ffff00ffffff0000ffff00ffffff
  V29   : 63f011d6476bcdeead558923378283f8
  V30   : 4e70acca0fa09b0dfd42e6a6ad86168c
  V31   : d4a747bba3fcee129a3b711faa907c4b
mismatch detail (master : apprentice):
  V28   : ffffffff00ffffffffffffff00ffffff vs 0000ffff00ffffff0000ffff00fff=
fff

Cheers,


--
Alex Benn=C3=A9e
