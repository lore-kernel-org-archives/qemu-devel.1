Received: from eggs.gnu.org ([2001:4830:134:3::10]:38920)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cEDvc-00063N-6B
	for qemu-devel@nongnu.org; Tue, 06 Dec 2016 06:28:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cEDvY-0003EN-UG
	for qemu-devel@nongnu.org; Tue, 06 Dec 2016 06:28:56 -0500
Received: from mail-vk0-f46.google.com ([209.85.213.46]:33166)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cEDvY-0003Ai-DH
	for qemu-devel@nongnu.org; Tue, 06 Dec 2016 06:28:52 -0500
Received: by mail-vk0-f46.google.com with SMTP id 137so194296707vkl.0
	for <qemu-devel@nongnu.org>; Tue, 06 Dec 2016 03:28:31 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <87pol5z57w.fsf@linaro.org>
References: <87pol5z57w.fsf@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 6 Dec 2016 11:27:08 +0000
Message-ID: <CAFEAcA8qUBSSRS5a+0qv=450z5RXdbbS51RJ1Fj9OjO3K63xLw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] RISU TCG failures (AArch64 on AArch64)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: Claudio Fontana <claudio.fontana@huawei.com>, Claudio Fontana <claudio.fontana@gmail.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "open list:ARM" <qemu-arm@nongnu.org>

On 6 December 2016 at 11:06, Alex Benn=C3=A9e <alex.bennee@linaro.org> wrot=
e:

A quick eyeball of the logs:

> loading test image testcases.aarch64/insn_ADDPv_ADD_RES1_ADD_RES2_ADDS__I=
NC.risu.bin...
> starting apprentice image at 0x4000801000
> Executed 100 test instructions (pc=3D0x4000801574).Executed 200 test inst=
ructions (pc=3D0x4000801aec).Executed 300 test instructions (pc=3D0x4000801=
d08).Executed 400 test instructions (pc=3D0x4000802264).Executed 500 test i=
nstructions (pc=3D0x40008027b8).Executed 600 test instructions (pc=3D0x4000=
8029e8).Executed 700 test instructions (pc=3D0x4000802f3c).Executed 800 tes=
t instructions (pc=3D0x40008034a8).Executed 900 test instructions (pc=3D0x4=
0008036cc).Executed 1000 test instructions (pc=3D0x4000803c2c).------------=
----
> IN:
> 0x0000004000803cac:  ab1feff6      adds x22, xzr, xzr, lsl #59

>  ---- 0000004000803cac 0000000000000000 0000000000000000
>  movi_i64 tmp2,$0x0
>  movi_i64 tmp3,$0x0
>  movi_i64 tmp7,$0x0
>  add2_i64 tmp5,tmp6,tmp2,tmp7,tmp3,tmp7           dead: 2 3 4 5
>  mov_i32 CF,tmp6                                  sync: 0  dead: 0 1
>  mov_i32 ZF,tmp5
>  movi_i64 tmp9,$0x20
>  shr_i64 tmp8,tmp5,tmp9                           dead: 2
[...]

> OUT: [size=3D108]
> 0x556a9c11a0:  b85f8274      ldur w20, [x19, #-8]
> 0x556a9c11a4:  350002d4      cbnz w20, #+0x58 (addr 0x556a9c11fc)
> 0x556a9c11a8:  b10003f4      adds x20, sp, #0x0 (0)
> 0x556a9c11ac:  9a1f03f5      adc x21, xzr, xzr

Looks like the add2_i64 has emitted a bogus adds, because
it thinks adds (immediate) allows use of xzr when it doesn't
(for this insn Rn=3D=3D31 means SP, not XZR).


> loading test image testcases.aarch64/insn_BSL_CCMN_CCMNi_CCMP__INC.risu.b=
in...
> starting apprentice image at 0x4000801000
> ----------------
> IN:
> 0x000000400080157c:  3a5cabed      ccmn wzr, #28, #NZcV, ge
> 0x0000004000801580:  00005af0      unallocated (Unallocated)

> OP after optimization and liveness analysis:
>  ld_i32 tmp0,env,$0xfffffffffffffff8              dead: 1
>  movi_i32 tmp1,$0x0
>  brcond_i32 tmp0,tmp1,ne,$L0                      dead: 0 1
>
>  ---- 000000400080157c 0000000000000000 0000000000000000
>  xor_i32 tmp1,VF,NF                               dead: 1 2
>  movi_i32 tmp2,$0x0
>  setcond_i32 tmp0,tmp1,tmp2,lt                    dead: 1 2
>  movi_i64 tmp3,$0x1c
>  movi_i64 tmp4,$0x0
>  movi_i32 tmp6,$0x0
>  mov_i32 tmp1,tmp4                                dead: 1
>  mov_i32 tmp2,tmp3                                dead: 1
>  add2_i32 NF,CF,tmp1,tmp6,tmp2,tmp6               dead: 3 5

> 0x55956bfc4c:  310073f5      adds w21, wsp, #0x1c (28)
> 0x55956bfc50:  1a1f03f6      adc w22, wzr, wzr

Same again but with add2_i32.

> loading test image testcases.aarch64/insn_MOVI_MOVK_MOVN_MOVZ__INC.risu.b=
in...


> 0x000000400080be2c:  6f01e7a0      movi v0.2d, #0xffffffff00ff
> 0x000000400080be30:  00005af0      unallocated (Unallocated)

>  ---- 000000400080be2c 0000000000000000 0000000000000000
>  movi_i64 tmp2,$0xffffffff00ff
>  mov_i64 tmp3,tmp2                                dead: 1
>  st_i64 tmp3,env,$0x838
>  st_i64 tmp3,env,$0x840                           dead: 0

> OUT: [size=3D72]
> 0x5561a8beb0:  b85f8274      ldur w20, [x19, #-8]
> 0x5561a8beb4:  350001b4      cbnz w20, #+0x34 (addr 0x5561a8bee8)
> 0x5561a8beb8:  929fe014      mov x20, #0xffffffffffff00ff

Generated move with wrong constant value...

> loading test image testcases.aarch64/insn_UCVTFv_UCVTFvf_UCVTFvis_UCVTFv_=
RES1__INC.risu.bin...
> starting apprentice image at 0x4000801000
> Executed 100 test instructions (pc=3D0x400080158c).Executed 200 test inst=
ructions (pc=3D0x4000801b10).Executed 300 test instructions (pc=3D0x4000802=
08c).Executed 400 test instructions (pc=3D0x40008022c8).Executed 500 test i=
nstructions (pc=3D0x4000802880).Executed 600 test instructions (pc=3D0x4000=
802e10).Executed 700 test instructions (pc=3D0x4000803034).Executed 800 tes=
t instructions (pc=3D0x40008035a8).----------------
> IN:
> 0x0000004000803a74:  6f01e6fc      movi v28.2d, #0xffff00ffffff
> 0x0000004000803a78:  00005af0      unallocated (Unallocated)

>  movi_i64 tmp2,$0xffff00ffffff

> OUT: [size=3D72]
> 0x555c897290:  b85f8274      ldur w20, [x19, #-8]
> 0x555c897294:  350001b4      cbnz w20, #+0x34 (addr 0x555c8972c8)
> 0x555c897298:  92bfe014      mov x20, #0xffffffff00ffffff

Same thing again.

So there's two bugs here, one in handling of add2 in the
backend, and one in constant loading.

thanks
-- PMM
