Received: from eggs.gnu.org ([2001:4830:134:3::10]:39091)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1f0fQ1-0000Oj-1Q
	for qemu-devel@nongnu.org; Mon, 26 Mar 2018 23:37:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1f0fPx-0003FN-Tj
	for qemu-devel@nongnu.org; Mon, 26 Mar 2018 23:37:05 -0400
Received: from mail-pf0-x22e.google.com ([2607:f8b0:400e:c00::22e]:36191)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1f0fPx-0003F5-MW
	for qemu-devel@nongnu.org; Mon, 26 Mar 2018 23:37:01 -0400
Received: by mail-pf0-x22e.google.com with SMTP id g14so1849586pfh.3
	for <qemu-devel@nongnu.org>; Mon, 26 Mar 2018 20:37:01 -0700 (PDT)
References: <1521926678-76539-1-git-send-email-mjc@sifive.com>
	<CAHNT7NtnuZ7_dNHFUJ_4KL=11sWV2u5E51bUJK1XH7ekm=sbXw@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <2979bb1d-0f56-9b2e-66f0-94c157510fa6@linaro.org>
Date: Tue, 27 Mar 2018 11:36:36 +0800
MIME-Version: 1.0
In-Reply-To: <CAHNT7NtnuZ7_dNHFUJ_4KL=11sWV2u5E51bUJK1XH7ekm=sbXw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v1] RISC-V: RISC-V TCG backend work in
 progress
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Michael Clark <mjc@sifive.com>, QEMU Developers <qemu-devel@nongnu.org>
Cc: RISC-V Patches <patches@groups.riscv.org>

On 03/27/2018 08:26 AM, Michael Clark wrote:
> IN:
> 0x0000000000011138:  800002b7          lui             t0,-2147483648
> 0x000000000001113c:  ffff8337          lui             t1,-32768
> 0x0000000000011140:  0262a433          mulhsu          s0,t0,t1
> 0x0000000000011144:  800004b7          lui             s1,-2147483648
> 0x0000000000011148:  00700193          addi            gp,zero,7
> 0x000000000001114c:  f49412e3          bne             s0,s1,-188

At last something interesting.

-2147483648 * 18446744073709518848 (0xffff_ffff_ffff_8000)
= -39614081257132098428027797504
= -7FFF_FFFF_FFFF_C000_0000_0000
=  ffff_ffff_8000_0000 0000_0400_0000_0000


> OP after optimization and liveness analysis:
>  ld_i32 tmp0,env,$0xffffffffffffffec              dead: 1
>  movi_i32 tmp1,$0x0
>  brcond_i32 tmp0,tmp1,lt,$L0                      dead: 0 1
> 
>  ---- 0000000000011138
>  movi_i64 t0  ,$0xffffffff80000000                sync: 0  dead: 0
> 
>  ---- 000000000001113c
>  movi_i64 t1  ,$0xffffffffffff8000                sync: 0  dead: 0
> 
>  ---- 0000000000011140
>  movi_i64 tmp2,$0x80000000
>  mov_i64 s0  ,tmp2                                sync: 0  dead: 0 1
> 
>  ---- 0000000000011144
>  movi_i64 s1  ,$0xffffffff80000000                sync: 0  dead: 0

So, yes, your test is correct, because here we load that high-part.  But
crucially, the multiply has produced a result *without* the sign-extension, so
the test fails.

It would have been handy to see the opcodes emitted before optimization, so
that we can verify what the riscv front-end did.  However, it's not that hard
to regenerate.

Annoyingly, the tcg optimizer hasn't been taught to fold things the same way
when the backend supports mulu2, so we *don't* fold the test away for an x86_64
host.

 mulu2_i64 tmp4,tmp5,t0  ,t1                      dead: 0 2 3
 movi_i64 tmp4,$0xffffffffffff8000
 sub_i64 tmp2,tmp5,tmp4                           dead: 1 2
 mov_i64 s0  ,tmp2                                sync: 0  dead: 0 1

And thus no doubt the test succeeds for that case.
So lemme try again with an aarch64 host.

 movi_i64 tmp2,$0x80000000
 mov_i64 s0  ,tmp2                                sync: 0  dead: 0 1

Yay, reproduction.  The input to the optimization is

 mov_i64 tmp2,t0
 mov_i64 tmp3,t1
 mul_i64 tmp6,tmp2,tmp3
 muluh_i64 tmp5,tmp2,tmp3
 mov_i64 tmp4,tmp6
 movi_i64 tmp6,$0x3f
 sar_i64 tmp4,tmp2,tmp6
 and_i64 tmp4,tmp4,tmp3
 sub_i64 tmp2,tmp5,tmp4
 mov_i64 s0  ,tmp2

Now, dead-code and forward propagate constants by hand,

 movi_i64 tmp2,$0xffffffff80000000
 movi_i64 tmp3,$0xffffffffffff8000
 muluh_i64 tmp5,tmp2,tmp3
 sub_i64 tmp2,tmp5,$0xffffffffffff8000
 mov_i64 s0  ,tmp2

Now, for the unsigned multiplication we get

18446744071562067968 * 18446744073709518848
= 340282366881323777743332701689153060864
= FFFF_FFFF_7FFF_8000 0000_4000_0000_0000

....

Oops, I see the bug right away now.

Value returned is $3 = 18446744071562035200
(gdb) n
410	    if (!(def->flags & TCG_OPF_64BIT)) {
411	        res = (int32_t)res;

Failure to mark muluh_i64 and mulsh_i64 as 64-bit ops, so we've discarded the
high 32 bits of the result.

I'm surprised that we haven't seen this as a problem before.  Perhaps luck in
non-optimization; we need a test case this small (but no smaller, like RISU) to
be able to produce a bad result.

So.  Two line patch to follow.


r~
