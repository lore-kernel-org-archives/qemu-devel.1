Received: from eggs.gnu.org ([2001:4830:134:3::10]:51128)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fhPvD-0000v6-DH
	for qemu-devel@nongnu.org; Sun, 22 Jul 2018 21:46:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fhPvC-0004Q5-EG
	for qemu-devel@nongnu.org; Sun, 22 Jul 2018 21:45:59 -0400
Received: from mail-pg1-x543.google.com ([2607:f8b0:4864:20::543]:37345)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fhPvC-0004Pe-8b
	for qemu-devel@nongnu.org; Sun, 22 Jul 2018 21:45:58 -0400
Received: by mail-pg1-x543.google.com with SMTP id n7-v6so11032232pgq.4
	for <qemu-devel@nongnu.org>; Sun, 22 Jul 2018 18:45:58 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
References: <CAHmME9q8b0Nss8b7DEoGgqoCK4dEvasQN64QWx6Hio+N92wuSg@mail.gmail.com>
	<CAHmME9qX22YP9qrHErc43Z+LUi=ichqzG+OdXqjhJv4ZrKDmWQ@mail.gmail.com>
	<CAHmME9qMASSt2K4vACJTMiGNTt09upRhNFxL_y2KF1G3N1LB2g@mail.gmail.com>
	<b20edb3f-055a-c531-da70-d20a20137ad4@linaro.org>
Message-ID: <49659899-1c8c-f8a6-4356-07e6c6fb728d@linaro.org>
Date: Sun, 22 Jul 2018 18:45:53 -0700
MIME-Version: 1.0
In-Reply-To: <b20edb3f-055a-c531-da70-d20a20137ad4@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] ARM64 STR Instruction Crash Regression in TCG
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Jason A. Donenfeld" <Jason@zx2c4.com>, qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>

On 07/22/2018 02:31 PM, Richard Henderson wrote:
> On 07/22/2018 01:47 PM, Jason A. Donenfeld wrote:
>> Hello,
>>
>> Gcc 7.3 compiles bash's array_flush's dual assignment using:
>>
>> STP             X20, X20, [X20,#0x10]
>>
>> But gcc 8.1 compiles it as:
>>
>> STR             Q0, [X20,#0x10]
>>
>> Real processors seem okay, and qemu 2.11 seems okay. But qemu 2.12
>> results in a segfaulting process. I'm pretty sure this is a TCG bug.
>>
>> In the attached tarball, please find kernel and run.sh. Calling
>> ./run.sh will start the kernel with the bad bash executable that tries
>> to execute `config=({1..100000})` and crashes. Also included in there
>> is the actual crashing bash binary, in case you'd like to disassemble
>> a little bit.
> 
> Interesting.  The test passes on master with --enable-debug, but fails when
> qemu is compiled with optimization...
> 
> I'll dig a bit deeper.

The failing sequence is

0x0045ba44:  4e080e80  dup      v0.2d, x20
0x0045ba48:  90000340  adrp     x0, #0x4c3000
0x0045ba4c:  91098003  add      x3, x0, #0x260
0x0045ba50:  92800001  movn     x1, #0
0x0045ba54:  f9413002  ldr      x2, [x0, #0x260]
0x0045ba58:  3d800680  str      q0, [x20, #0x10]
...

OP after optimization and liveness analysis:
 ld_i32 tmp0,env,$0xffffffffffffffdc              dead: 1
 movi_i32 tmp1,$0x0
 brcond_i32 tmp0,tmp1,lt,$L0                      dead: 0 1

 ---- 000000000045ba44 0000000000000000 0000000000000000
 dup_vec v128,e64,tmp2,x20
 st_vec v128,e8,tmp2,env,$0x8c0                   dead: 0

...

 ---- 000000000045ba58 0000000000000000 0000000000000000
 movi_i64 tmp4,$0x10
 add_i64 tmp3,x20,tmp4                            dead: 1 2
 ld_i64 tmp4,env,$0x8c0
 movi_i64 tmp6,$0x8
 add_i64 tmp5,tmp3,tmp6                           dead: 2
 qemu_st_i64 tmp4,tmp3,leq,0                      dead: 0 1
 ld_i64 tmp4,env,$0x8c8                           dead: 1
 qemu_st_i64 tmp4,tmp5,leq,0                      dead: 0 1
...

0x7fffcd2e678c:  vmovq    0xe0(%r14), %xmm0
0x7fffcd2e6795:  vpbroadcastq %xmm0, %xmm1
0x7fffcd2e679a:  vmovdqu  %xmm1, 0x8c0(%r14)
...
0x7fffcd2c0e78:  vmovq    %xmm0, %r12
0x7fffcd2c0e7d:  addq     $0x10, %r12


The guest x20 is loaded in to xmm0 for the dup at 0x45ba44, and was reused for
the store at 0x45ba58.  However, if the load at 0x45ba54 misses the TLB, then
we will have a function call, which can clobber xmm0.

With -O0, it just so happens that the function call does not clobber xmm0; with
optimization enabled, the compiler's different code generation does clobber xmm0.

Fix by properly considering xmm registers to be call-clobbered.  At which point
the saved value is evicted from xmm0 naturally.  Patch posted separately.


r~
