Received: from eggs.gnu.org ([209.51.188.92]:43861)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gmAn3-0002XM-QR
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 00:09:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gmAn3-0002Nh-3O
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 00:09:29 -0500
Received: from mail-pg1-x534.google.com ([2607:f8b0:4864:20::534]:36931)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gmAn2-0002NM-K1
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 00:09:29 -0500
Received: by mail-pg1-x534.google.com with SMTP id c25so505366pgb.4
	for <qemu-devel@nongnu.org>; Tue, 22 Jan 2019 21:09:27 -0800 (PST)
References: <20190104223116.14037-1-richard.henderson@linaro.org>
	<d52c8ae0-edee-ed9a-56b8-43cc1cf0208d@ilande.co.uk>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <362de5ba-a678-aeed-6a5d-3a02844c2560@linaro.org>
Date: Tue, 22 Jan 2019 21:09:22 -0800
MIME-Version: 1.0
In-Reply-To: <d52c8ae0-edee-ed9a-56b8-43cc1cf0208d@ilande.co.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 00/10] tcg vector improvements
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org
Cc: Howard Spoelstra <hsp.cat7@gmail.com>

On 1/7/19 5:11 AM, Mark Cave-Ayland wrote:
> #7  0x0000555555852e53 in expand_4_vec (vece=2, dofs=197872,
> aofs=198288, bofs=197776, cofs=197792, oprsz=16, tysz=16,
> type=TCG_TYPE_V128, write_aofs=true, fni=0x55555599182a
> <gen_vaddsws_vec>) at
> /home/hsp/src/qemu-altivec-55/tcg/tcg-op-gvec.c:903
>         t0 = 0x1848
>         t1 = 0x1880
>         t2 = 0x18b8
>         t3 = 0x18f0
>         i = 0
> #8  0x0000555555853cc4 in tcg_gen_gvec_4 (dofs=197872, aofs=198288,
> bofs=197776, cofs=197792, oprsz=16, maxsz=16, g=0x5555562d33c0 <g>) at
> /home/hsp/src/qemu-altivec-55/tcg/tcg-op-gvec.c:1211
>         type = TCG_TYPE_V128
>         some = 21845
>         __PRETTY_FUNCTION__ = "tcg_gen_gvec_4"
>         __func__ = "tcg_gen_gvec_4"
> #9  0x0000555555991987 in gen_vaddsws (ctx=0x7fffe3ffe5f0) at
> /home/hsp/src/qemu-altivec-55/target/ppc/translate/vmx-impl.inc.c:597
>         g = {fni8 = 0x0, fni4 = 0x0, fniv = 0x55555599182a
> <gen_vaddsws_vec>, fno = 0x5555559601a1 <gen_helper_vaddsws>, opc =
> INDEX_op_add_vec, data = 0, vece = 2 '\002', prefer_i64 = false,
> write_aofs = true}
> 
> 
> Certainly according to patch 7 of the series only 8-bit and 16-bit accesses are
> supported on i386 hosts, but shouldn't we be falling back to the previous
> implementations rather than hitting an assert()?

In here:

#define GEN_VXFORM_SAT(NAME, VECE, NORM, SAT, OPC2, OPC3)               \
static void glue(glue(gen_, NAME), _vec)(unsigned vece, TCGv_vec t,     \
                                         TCGv_vec sat, TCGv_vec a,      \
                                         TCGv_vec b)                    \
{                                                                       \
    TCGv_vec x = tcg_temp_new_vec_matching(t);                          \
    glue(glue(tcg_gen_, NORM), _vec)(VECE, x, a, b);                    \
    glue(glue(tcg_gen_, SAT), _vec)(VECE, t, a, b);                     \
    tcg_gen_cmp_vec(TCG_COND_NE, VECE, x, x, t);                        \
    tcg_gen_or_vec(VECE, sat, sat, x);                                  \
    tcg_temp_free_vec(x);                                               \
}                                                                       \
static void glue(gen_, NAME)(DisasContext *ctx)                         \
{                                                                       \
    static const GVecGen4 g = {                                         \
        .fniv = glue(glue(gen_, NAME), _vec),                           \
        .fno = glue(gen_helper_, NAME),                                 \
        .opc = glue(glue(INDEX_op_, NORM), _vec),                       \

s/NORM/SAT/, so that we query whether the saturated opcode is supported.  The
normal arithmetic, cmp, and or opcodes are mandatory; we don't need to do
anything with those.


r~
