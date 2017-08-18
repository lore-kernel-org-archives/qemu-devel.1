Received: from eggs.gnu.org ([2001:4830:134:3::10]:48021)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <batuzovk@ispras.ru>) id 1difXE-0006zG-Qg
	for qemu-devel@nongnu.org; Fri, 18 Aug 2017 07:33:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <batuzovk@ispras.ru>) id 1difXD-0002II-GK
	for qemu-devel@nongnu.org; Fri, 18 Aug 2017 07:33:52 -0400
Date: Fri, 18 Aug 2017 14:33:42 +0300 (MSK)
From: Kirill Batuzov <batuzovk@ispras.ru>
In-Reply-To: <20170817180404.29334-1-alex.bennee@linaro.org>
Message-ID: <alpine.DEB.2.20.1708181355080.2770@bulbul.intra.ispras.ru>
References: <20170817180404.29334-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC PATCH 0/9] TCG Vector types and example
 conversion
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?ISO-8859-15?Q?Alex_Benn=E9e?= <alex.bennee@linaro.org>
Cc: rth@twiddle.net, cota@braap.org, qemu-devel@nongnu.org, qemu-arm@nongnu.org



On Thu, 17 Aug 2017, Alex Benn=C3=A9e wrote:

> Hi,
>=20
> With upcoming work on SVE I've been looking at the way we implement
> vector registers in QEMU's TCG. The current orthodoxy is to decompose
> the vector into a series of TCG registers, often calling a helper
> function the calculation of each element. The result of the helper is
> then is then stored back in the vector representation afterwards.
> There are occasional outliers like simd_tbl which access elements
> directly from a passed CPUFooState env pointer but these are rare.
>=20
> This series introduces the concept of TCGv_vec type. This is a pointer
> to the start of the in memory representation of an arbitrarily long
> vector register. This is passed to a helper function as a pointer
> along with a normal TCG register containing information about the
> actual vector length and any additional information the helper needs
> to do the operation. The hope* is this saves on the churn of having
> the TCG do things element by element and allows the compiler to use
> native vector operations to streamline the helpers.
>=20
> There are some downsides to this approach. The first is you have to be
> careful about register aliasing. If you are doing a same reg to same
> reg operation you need to make a copy of the vector so you don't
> trample your input data as you go. The second is this involves
> changing some of the assumptions the TCG makes about things. I've
> managed to keep all the changes within the core TCG code for now but
> so far it has only been tested for the tcg_call path which is the only
> place where TCGv_vec's should turn up. It is possible to do the same
> thing without touching the TCG code generation by using TCGv_ptrs and
> manually emitting tcg_addi ops to pass the correct address. Richard
> has been exploring this approach with his series. The downside of that
> is you do miss the ability to have named global vector registers which
> makes reading the TCG dumps a little easier.
>=20
> I've only patched one helper in this series which implements the
> indexed smull. This is because it appears in the profiles for my test
> case which was using an arm64 ffmpeg to transcode:
>=20
>   ./ffmpeg.arm64 -i big_buck_bunny_480p_surround-fix.avi \
>     -threads 1 -qscale:v 3 -f null -
>=20
> * hope. On an earlier revision (which included sqshrn conversions) I
>   had measured a minor saving but this had disappeared once I measured
>   the final code. However the profile is fairly dominated by
>   softfloat.
>=20
> master:
>      8.05%  qemu-aarch64  qemu-aarch64             [.] roundAndPackFloa=
t32
>      7.28%  qemu-aarch64  qemu-aarch64             [.] float32_mul
>      6.56%  qemu-aarch64  qemu-aarch64             [.] helper_lookup_tb=
_ptr
>      5.31%  qemu-aarch64  qemu-aarch64             [.] float32_muladd
>      4.09%  qemu-aarch64  qemu-aarch64             [.] helper_neon_mull=
_s16
>      4.00%  qemu-aarch64  qemu-aarch64             [.] addFloat32Sigs
>      3.86%  qemu-aarch64  qemu-aarch64             [.] subFloat32Sigs
>      2.26%  qemu-aarch64  qemu-aarch64             [.] helper_simd_tbl
>      2.00%  qemu-aarch64  qemu-aarch64             [.] float32_add
>      1.81%  qemu-aarch64  qemu-aarch64             [.] helper_neon_unar=
row_sat8
>      1.64%  qemu-aarch64  qemu-aarch64             [.] float32_sub
>      1.43%  qemu-aarch64  qemu-aarch64             [.] helper_neon_subl=
_u32
>      0.98%  qemu-aarch64  qemu-aarch64             [.] helper_neon_wide=
n_u8
>=20
> tcg-native-vectors-rfc:
>      7.93%  qemu-aarch64  qemu-aarch64             [.] roundAndPackFloa=
t32            =20
>      7.54%  qemu-aarch64  qemu-aarch64             [.] float32_mul     =
               =20
>      6.29%  qemu-aarch64  qemu-aarch64             [.] helper_lookup_tb=
_ptr
>      5.39%  qemu-aarch64  qemu-aarch64             [.] float32_muladd
>      3.92%  qemu-aarch64  qemu-aarch64             [.] addFloat32Sigs
>      3.86%  qemu-aarch64  qemu-aarch64             [.] subFloat32Sigs
>      3.62%  qemu-aarch64  qemu-aarch64             [.] helper_advsimd_s=
mull_idx_s32
>      2.19%  qemu-aarch64  qemu-aarch64             [.] helper_simd_tbl
>      2.09%  qemu-aarch64  qemu-aarch64             [.] helper_neon_mull=
_s16
>      1.99%  qemu-aarch64  qemu-aarch64             [.] float32_add
>      1.79%  qemu-aarch64  qemu-aarch64             [.] helper_neon_unar=
row_sat8
>      1.62%  qemu-aarch64  qemu-aarch64             [.] float32_sub
>      1.43%  qemu-aarch64  qemu-aarch64             [.] helper_neon_subl=
_u32
>      1.00%  qemu-aarch64  qemu-aarch64             [.] helper_neon_wide=
n_u8
>      0.98%  qemu-aarch64  qemu-aarch64             [.] helper_neon_addl=
_u32
>=20
> At the moment the default compiler settings don't actually vectorise
> the helper. I could get it to once I added some alignment guarantees
> but the casting I did broke the instruction emulation so I haven't
> included that patch in this series.
>=20
> Given the results why continue investigating this? Well for one thing
> vector sizes are growing, SVE vectors are up to 2048 bits long. Those
> longer vectors should offer more scope for the host compiler to
> generate efficient code in the helper. Also vector operations tend to
> be quite complex operations, being able to handle this in C code
> instead of TCGOps might be more preferable from a code maintainability
> point of view. Finally this noddy little experiment has at least shown
> it doesn't worsen performance. It would be nice if I could find a
> benchmark that made heavy use if non-floating point SIMD instructions
> to better measure the effect of marshalling elements vs vectorised
> helpers. If anyone has any suggestions I'm all ears ;-)

While doing my own vector register series I was using

1. Handwritten example (it's for ARM32 NEON, not aarch64)

    .cpu cortex-a8
    .fpu neon
    .text
    .global test
test:
    vld1.32     d0, [r0]!
    vld1.32     d1, [r0]
    vld1.32     d2, [r1]!
    vld1.32     d3, [r1]
	mov			r0, #0xb0000000
loop:
    vadd.i32    q0, q0, q1
    vadd.i32    q0, q0, q1
    vadd.i32    q0, q0, q1
    vadd.i32    q0, q0, q1
    subs        r0, r0, #1
    bne         loop
    vpadd.i32   d0, d0, d1
    vpadd.i32   d0, d0, d1
    vmov.i32    r0, d0[0]
    bx          lr

It can be adapted for aarch64 without much problems. This example shows
what potential speed up you can expect, as it is nearly perfect for the
optimization in question.

2. x264 video encoder. It has a lot of handwritten vector assembler for
different architectures, including aarch64. You probably can access it
as libx264 from within ffmpeg, if this library support was compiled.

>=20
> Anyway questions, comments?
>=20

>From my own experimentations some times ago,

(1) translating vector instructions to vector instructions in TCG is fast=
er than

(2) translating vector instructions to series of scalar instructions in T=
CG,
which is faster than*

(3) translating vector instructions to single helper calls, which is fast=
er
than*

(4) translating vector instructions to helper calls for each vector eleme=
nt.

(*) (2) and (3) may change their respective places in case of some
complicated instructions.

ARM (at least ARM32, I have not checked aarch64 in this regard) uses the
last, the slowest scheme. As far as I understand, you are want to change
it to the third approach. This approach is used in SSE emulation, may be
you can use similar structure of helpers?

I still hope to finish my own series about implementation of the first
approach. I apologize for the long delay since last update and hope to
send next version somewhere next week. I do not think our series
contradict each other: you are trying to optimize existing general
purpose case while I'm trying to optimize case where both host and guest
support vector instructions. Since I'm experimenting on ARM32, we'll not
have much merge conflicts either.

--=20
Kirill
