Received: from eggs.gnu.org ([2001:4830:134:3::10]:37437)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1diP9S-000435-0P
	for qemu-devel@nongnu.org; Thu, 17 Aug 2017 14:04:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1diP9M-0005G7-Vl
	for qemu-devel@nongnu.org; Thu, 17 Aug 2017 14:04:13 -0400
Received: from mail-wr0-x233.google.com ([2a00:1450:400c:c0c::233]:37109)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1diP9M-0005Ek-MJ
	for qemu-devel@nongnu.org; Thu, 17 Aug 2017 14:04:08 -0400
Received: by mail-wr0-x233.google.com with SMTP id z91so41837820wrc.4
	for <qemu-devel@nongnu.org>; Thu, 17 Aug 2017 11:04:07 -0700 (PDT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Thu, 17 Aug 2017 19:03:55 +0100
Message-Id: <20170817180404.29334-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [RFC PATCH 0/9] TCG Vector types and example conversion
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: rth@twiddle.net, cota@braap.org, batuzovk@ispras.ru
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>

Hi,

With upcoming work on SVE I've been looking at the way we implement
vector registers in QEMU's TCG. The current orthodoxy is to decompose
the vector into a series of TCG registers, often calling a helper
function the calculation of each element. The result of the helper is
then is then stored back in the vector representation afterwards.
There are occasional outliers like simd_tbl which access elements
directly from a passed CPUFooState env pointer but these are rare.

This series introduces the concept of TCGv_vec type. This is a pointer
to the start of the in memory representation of an arbitrarily long
vector register. This is passed to a helper function as a pointer
along with a normal TCG register containing information about the
actual vector length and any additional information the helper needs
to do the operation. The hope* is this saves on the churn of having
the TCG do things element by element and allows the compiler to use
native vector operations to streamline the helpers.

There are some downsides to this approach. The first is you have to be
careful about register aliasing. If you are doing a same reg to same
reg operation you need to make a copy of the vector so you don't
trample your input data as you go. The second is this involves
changing some of the assumptions the TCG makes about things. I've
managed to keep all the changes within the core TCG code for now but
so far it has only been tested for the tcg_call path which is the only
place where TCGv_vec's should turn up. It is possible to do the same
thing without touching the TCG code generation by using TCGv_ptrs and
manually emitting tcg_addi ops to pass the correct address. Richard
has been exploring this approach with his series. The downside of that
is you do miss the ability to have named global vector registers which
makes reading the TCG dumps a little easier.

I've only patched one helper in this series which implements the
indexed smull. This is because it appears in the profiles for my test
case which was using an arm64 ffmpeg to transcode:

  ./ffmpeg.arm64 -i big_buck_bunny_480p_surround-fix.avi \
    -threads 1 -qscale:v 3 -f null -

* hope. On an earlier revision (which included sqshrn conversions) I
  had measured a minor saving but this had disappeared once I measured
  the final code. However the profile is fairly dominated by
  softfloat.

master:
     8.05%  qemu-aarch64  qemu-aarch64             [.] roundAndPackFloat32
     7.28%  qemu-aarch64  qemu-aarch64             [.] float32_mul
     6.56%  qemu-aarch64  qemu-aarch64             [.] helper_lookup_tb_ptr
     5.31%  qemu-aarch64  qemu-aarch64             [.] float32_muladd
     4.09%  qemu-aarch64  qemu-aarch64             [.] helper_neon_mull_s16
     4.00%  qemu-aarch64  qemu-aarch64             [.] addFloat32Sigs
     3.86%  qemu-aarch64  qemu-aarch64             [.] subFloat32Sigs
     2.26%  qemu-aarch64  qemu-aarch64             [.] helper_simd_tbl
     2.00%  qemu-aarch64  qemu-aarch64             [.] float32_add
     1.81%  qemu-aarch64  qemu-aarch64             [.] helper_neon_unarrow_sat8
     1.64%  qemu-aarch64  qemu-aarch64             [.] float32_sub
     1.43%  qemu-aarch64  qemu-aarch64             [.] helper_neon_subl_u32
     0.98%  qemu-aarch64  qemu-aarch64             [.] helper_neon_widen_u8

tcg-native-vectors-rfc:
     7.93%  qemu-aarch64  qemu-aarch64             [.] roundAndPackFloat32             
     7.54%  qemu-aarch64  qemu-aarch64             [.] float32_mul                     
     6.29%  qemu-aarch64  qemu-aarch64             [.] helper_lookup_tb_ptr
     5.39%  qemu-aarch64  qemu-aarch64             [.] float32_muladd
     3.92%  qemu-aarch64  qemu-aarch64             [.] addFloat32Sigs
     3.86%  qemu-aarch64  qemu-aarch64             [.] subFloat32Sigs
     3.62%  qemu-aarch64  qemu-aarch64             [.] helper_advsimd_smull_idx_s32
     2.19%  qemu-aarch64  qemu-aarch64             [.] helper_simd_tbl
     2.09%  qemu-aarch64  qemu-aarch64             [.] helper_neon_mull_s16
     1.99%  qemu-aarch64  qemu-aarch64             [.] float32_add
     1.79%  qemu-aarch64  qemu-aarch64             [.] helper_neon_unarrow_sat8
     1.62%  qemu-aarch64  qemu-aarch64             [.] float32_sub
     1.43%  qemu-aarch64  qemu-aarch64             [.] helper_neon_subl_u32
     1.00%  qemu-aarch64  qemu-aarch64             [.] helper_neon_widen_u8
     0.98%  qemu-aarch64  qemu-aarch64             [.] helper_neon_addl_u32

At the moment the default compiler settings don't actually vectorise
the helper. I could get it to once I added some alignment guarantees
but the casting I did broke the instruction emulation so I haven't
included that patch in this series.

Given the results why continue investigating this? Well for one thing
vector sizes are growing, SVE vectors are up to 2048 bits long. Those
longer vectors should offer more scope for the host compiler to
generate efficient code in the helper. Also vector operations tend to
be quite complex operations, being able to handle this in C code
instead of TCGOps might be more preferable from a code maintainability
point of view. Finally this noddy little experiment has at least shown
it doesn't worsen performance. It would be nice if I could find a
benchmark that made heavy use if non-floating point SIMD instructions
to better measure the effect of marshalling elements vs vectorised
helpers. If anyone has any suggestions I'm all ears ;-)

Anyway questions, comments?

Alex Bennée (9):
  tcg/README: listify the TCG types.
  tcg: introduce the concepts of a TCGv_vec register type
  tcg: generate ptrs to vector registers
  helper-head: add support for vec type
  arm/cpu.h: align VFP registers
  target/arm/translate-a64: regnames -> x_regnames
  target/arm/translate-a64: register global vectors
  target/arm/helpers: introduce ADVSIMD flags
  target/arm/translate-a64: vectorise smull vD.4s, vN.[48]s, vM.h[]

 include/exec/helper-head.h        |  5 ++
 target/arm/advsimd_helper_flags.h | 50 ++++++++++++++++++++
 target/arm/cpu.h                  |  4 +-
 target/arm/helper-a64.c           | 18 ++++++++
 target/arm/helper-a64.h           |  2 +
 target/arm/translate-a64.c        | 97 +++++++++++++++++++++++++++++++++++++--
 tcg/README                        | 10 ++--
 tcg/tcg.c                         | 26 ++++++++++-
 tcg/tcg.h                         | 20 ++++++++
 9 files changed, 222 insertions(+), 10 deletions(-)
 create mode 100644 target/arm/advsimd_helper_flags.h

-- 
2.13.0
