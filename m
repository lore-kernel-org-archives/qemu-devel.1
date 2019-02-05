Received: from eggs.gnu.org ([209.51.188.92]:45447)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1gr8VV-0004Ab-I5
	for qemu-devel@nongnu.org; Tue, 05 Feb 2019 16:43:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1gr8HM-0001Ct-4m
	for qemu-devel@nongnu.org; Tue, 05 Feb 2019 16:29:17 -0500
Received: from chuckie.co.uk ([82.165.15.123]:39269
	helo=s16892447.onlinehome-server.info)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mark.cave-ayland@ilande.co.uk>)
	id 1gr8HL-00017C-T7
	for qemu-devel@nongnu.org; Tue, 05 Feb 2019 16:29:16 -0500
References: <20190104223116.14037-1-richard.henderson@linaro.org>
	<d52c8ae0-edee-ed9a-56b8-43cc1cf0208d@ilande.co.uk>
	<362de5ba-a678-aeed-6a5d-3a02844c2560@linaro.org>
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Message-ID: <6314c25b-a8c9-a8e2-2e1d-a8eeb3b88f2c@ilande.co.uk>
Date: Tue, 5 Feb 2019 21:29:00 +0000
MIME-Version: 1.0
In-Reply-To: <362de5ba-a678-aeed-6a5d-3a02844c2560@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v2 00/10] tcg vector improvements
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: Howard Spoelstra <hsp.cat7@gmail.com>

On 23/01/2019 05:09, Richard Henderson wrote:

> On 1/7/19 5:11 AM, Mark Cave-Ayland wrote:
>> #7  0x0000555555852e53 in expand_4_vec (vece=2, dofs=197872,
>> aofs=198288, bofs=197776, cofs=197792, oprsz=16, tysz=16,
>> type=TCG_TYPE_V128, write_aofs=true, fni=0x55555599182a
>> <gen_vaddsws_vec>) at
>> /home/hsp/src/qemu-altivec-55/tcg/tcg-op-gvec.c:903
>>         t0 = 0x1848
>>         t1 = 0x1880
>>         t2 = 0x18b8
>>         t3 = 0x18f0
>>         i = 0
>> #8  0x0000555555853cc4 in tcg_gen_gvec_4 (dofs=197872, aofs=198288,
>> bofs=197776, cofs=197792, oprsz=16, maxsz=16, g=0x5555562d33c0 <g>) at
>> /home/hsp/src/qemu-altivec-55/tcg/tcg-op-gvec.c:1211
>>         type = TCG_TYPE_V128
>>         some = 21845
>>         __PRETTY_FUNCTION__ = "tcg_gen_gvec_4"
>>         __func__ = "tcg_gen_gvec_4"
>> #9  0x0000555555991987 in gen_vaddsws (ctx=0x7fffe3ffe5f0) at
>> /home/hsp/src/qemu-altivec-55/target/ppc/translate/vmx-impl.inc.c:597
>>         g = {fni8 = 0x0, fni4 = 0x0, fniv = 0x55555599182a
>> <gen_vaddsws_vec>, fno = 0x5555559601a1 <gen_helper_vaddsws>, opc =
>> INDEX_op_add_vec, data = 0, vece = 2 '\002', prefer_i64 = false,
>> write_aofs = true}
>>
>>
>> Certainly according to patch 7 of the series only 8-bit and 16-bit accesses are
>> supported on i386 hosts, but shouldn't we be falling back to the previous
>> implementations rather than hitting an assert()?
> 
> In here:
> 
> #define GEN_VXFORM_SAT(NAME, VECE, NORM, SAT, OPC2, OPC3)               \
> static void glue(glue(gen_, NAME), _vec)(unsigned vece, TCGv_vec t,     \
>                                          TCGv_vec sat, TCGv_vec a,      \
>                                          TCGv_vec b)                    \
> {                                                                       \
>     TCGv_vec x = tcg_temp_new_vec_matching(t);                          \
>     glue(glue(tcg_gen_, NORM), _vec)(VECE, x, a, b);                    \
>     glue(glue(tcg_gen_, SAT), _vec)(VECE, t, a, b);                     \
>     tcg_gen_cmp_vec(TCG_COND_NE, VECE, x, x, t);                        \
>     tcg_gen_or_vec(VECE, sat, sat, x);                                  \
>     tcg_temp_free_vec(x);                                               \
> }                                                                       \
> static void glue(gen_, NAME)(DisasContext *ctx)                         \
> {                                                                       \
>     static const GVecGen4 g = {                                         \
>         .fniv = glue(glue(gen_, NAME), _vec),                           \
>         .fno = glue(gen_helper_, NAME),                                 \
>         .opc = glue(glue(INDEX_op_, NORM), _vec),                       \
> 
> s/NORM/SAT/, so that we query whether the saturated opcode is supported.  The
> normal arithmetic, cmp, and or opcodes are mandatory; we don't need to do
> anything with those.

Now that this and the other pre-requisite patches have been merged into master, I've
rebased the outstanding PPC parts of your "tcg, target/ppc vector improvements" on
master including the above fix and pushed the result to
https://github.com/mcayland/qemu/commits/ppc-altivec-v6.

The good news is that the graphics corruption I originally noticed caused by the
patch introducing the saturating add/sub vector ops has now gone, and with my
little-endian vsplt fix included then both OS X and MacOS 9 appear to run without any
obvious issues on an x86 host, and certainly feel smoother compared to before.

The only minor question I had with the patchset in its current form is whether to use
the new VsrD() macro for vscr_sat, or whether we don't really care enough?


ATB,

Mark.
