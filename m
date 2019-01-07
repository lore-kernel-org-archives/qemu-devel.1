Received: from eggs.gnu.org ([209.51.188.92]:36229)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1ggUgz-0006EJ-Sd
	for qemu-devel@nongnu.org; Mon, 07 Jan 2019 08:11:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1ggUgy-0001I9-Pt
	for qemu-devel@nongnu.org; Mon, 07 Jan 2019 08:11:45 -0500
Received: from chuckie.co.uk ([82.165.15.123]:41805
	helo=s16892447.onlinehome-server.info)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mark.cave-ayland@ilande.co.uk>)
	id 1ggUgy-0001DJ-Ec
	for qemu-devel@nongnu.org; Mon, 07 Jan 2019 08:11:44 -0500
References: <20190104223116.14037-1-richard.henderson@linaro.org>
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Message-ID: <d52c8ae0-edee-ed9a-56b8-43cc1cf0208d@ilande.co.uk>
Date: Mon, 7 Jan 2019 13:11:32 +0000
MIME-Version: 1.0
In-Reply-To: <20190104223116.14037-1-richard.henderson@linaro.org>
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

On 04/01/2019 22:31, Richard Henderson wrote:

> I've split this out from the target/ppc patch set in which
> it was developed.
> 
> 
> r~
> 
> 
> Richard Henderson (10):
>   tcg: Add logical simplifications during gvec expand
>   tcg: Add gvec expanders for nand, nor, eqv
>   tcg: Add write_aofs to GVecGen4
>   tcg: Add opcodes for vector saturated arithmetic
>   tcg: Add opcodes for vector minmax arithmetic
>   tcg/i386: Split subroutines out of tcg_expand_vec_op
>   tcg/i386: Implement vector saturating arithmetic
>   tcg/i386: Implement vector minmax arithmetic
>   tcg/aarch64: Implement vector saturating arithmetic
>   tcg/aarch64: Implement vector minmax arithmetic
> 
>  accel/tcg/tcg-runtime.h      |  23 ++
>  tcg/aarch64/tcg-target.h     |   2 +
>  tcg/i386/tcg-target.h        |   2 +
>  tcg/tcg-op-gvec.h            |  18 ++
>  tcg/tcg-op.h                 |  11 +
>  tcg/tcg-opc.h                |   8 +
>  tcg/tcg.h                    |   2 +
>  accel/tcg/tcg-runtime-gvec.c | 257 ++++++++++++++++
>  tcg/aarch64/tcg-target.inc.c |  48 +++
>  tcg/i386/tcg-target.inc.c    | 580 +++++++++++++++++++++--------------
>  tcg/tcg-op-gvec.c            | 305 ++++++++++++++++--
>  tcg/tcg-op-vec.c             |  75 ++++-
>  tcg/tcg.c                    |  10 +
>  13 files changed, 1078 insertions(+), 263 deletions(-)

Not sure that I'm particularly qualified to give this an R-B, however should there be
a corresponding update to tcg/README for the new instructions?

One other thing is that Howard sent me off-list a backtrace from trying my combined
branch at https://github.com/mcayland/qemu/tree/ppc-altivec-v5.5-rth booting MacOS
10.5 in the guest and ended up hitting an assert in an --enable-debug build:

Thread 5 (Thread 0x7fffe3fff700 (LWP 10627)):
#0  0x00007ffff698d53f in raise () at /lib64/libc.so.6
#1  0x00007ffff6977895 in abort () at /lib64/libc.so.6
#2  0x00007ffff6977769 in _nl_load_domain.cold.0 () at /lib64/libc.so.6
#3  0x00007ffff69859f6 in .annobin_assert.c_end () at /lib64/libc.so.6
#4  0x000055555584bb67 in do_op3 (vece=2, r=0x1848, a=0x18b8,
b=0x18f0, opc=INDEX_op_ssadd_vec) at
/home/hsp/src/qemu-altivec-55/tcg/tcg-op-vec.c:407
        rt = 0x7fffdc002368
        at = 0x7fffdc0023d8
        bt = 0x7fffdc002410
        ri = 140736884384616
        ai = 140736884384728
        bi = 140736884384784
        type = TCG_TYPE_V128
        can = 0
        __PRETTY_FUNCTION__ = "do_op3"
#5  0x000055555584bbfa in tcg_gen_ssadd_vec (vece=2, r=0x1848,
a=0x18b8, b=0x18f0) at
/home/hsp/src/qemu-altivec-55/tcg/tcg-op-vec.c:419
#6  0x0000555555991887 in gen_vaddsws_vec (vece=2, t=0x1848,
sat=0x1880, a=0x18b8, b=0x18f0) at
/home/hsp/src/qemu-altivec-55/target/ppc/translate/vmx-impl.inc.c:597
        x = 0x1928
#7  0x0000555555852e53 in expand_4_vec (vece=2, dofs=197872,
aofs=198288, bofs=197776, cofs=197792, oprsz=16, tysz=16,
type=TCG_TYPE_V128, write_aofs=true, fni=0x55555599182a
<gen_vaddsws_vec>) at
/home/hsp/src/qemu-altivec-55/tcg/tcg-op-gvec.c:903
        t0 = 0x1848
        t1 = 0x1880
        t2 = 0x18b8
        t3 = 0x18f0
        i = 0
#8  0x0000555555853cc4 in tcg_gen_gvec_4 (dofs=197872, aofs=198288,
bofs=197776, cofs=197792, oprsz=16, maxsz=16, g=0x5555562d33c0 <g>) at
/home/hsp/src/qemu-altivec-55/tcg/tcg-op-gvec.c:1211
        type = TCG_TYPE_V128
        some = 21845
        __PRETTY_FUNCTION__ = "tcg_gen_gvec_4"
        __func__ = "tcg_gen_gvec_4"
#9  0x0000555555991987 in gen_vaddsws (ctx=0x7fffe3ffe5f0) at
/home/hsp/src/qemu-altivec-55/target/ppc/translate/vmx-impl.inc.c:597
        g = {fni8 = 0x0, fni4 = 0x0, fniv = 0x55555599182a
<gen_vaddsws_vec>, fno = 0x5555559601a1 <gen_helper_vaddsws>, opc =
INDEX_op_add_vec, data = 0, vece = 2 '\002', prefer_i64 = false,
write_aofs = true}


Certainly according to patch 7 of the series only 8-bit and 16-bit accesses are
supported on i386 hosts, but shouldn't we be falling back to the previous
implementations rather than hitting an assert()?


ATB,

Mark.
