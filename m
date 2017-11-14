Received: from eggs.gnu.org ([2001:4830:134:3::10]:52749)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eEb2g-0001bD-Tb
	for qemu-devel@nongnu.org; Tue, 14 Nov 2017 08:14:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eEb2f-0006bw-Lg
	for qemu-devel@nongnu.org; Tue, 14 Nov 2017 08:14:18 -0500
Received: from mail-wr0-x244.google.com ([2a00:1450:400c:c0c::244]:51856)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1eEb2f-0006an-AS
	for qemu-devel@nongnu.org; Tue, 14 Nov 2017 08:14:17 -0500
Received: by mail-wr0-x244.google.com with SMTP id j15so17440519wre.8
	for <qemu-devel@nongnu.org>; Tue, 14 Nov 2017 05:14:17 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20171114125304.854-1-richard.henderson@linaro.org>
References: <20171114094203.28030-1-richard.henderson@linaro.org>
	<20171114125304.854-1-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 14 Nov 2017 13:13:55 +0000
Message-ID: <CAFEAcA8mSjNcb7SXDvACZ0Obh_E5CbTp-tb_L3AZrmcbQ9y-zg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH 2/1] target/arm: Use helper_retaddr in stxp
 helpers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 14 November 2017 at 12:53, Richard Henderson
<richard.henderson@linaro.org> wrote:
> We use raw memory primitives along the !parallel_cpus paths in order to
> simplify the endianness handling.  Because of that, we did not benefit
> from the generic changes to cpu_ldst_user_only_template.h.
>
> The simplest fix is to manipulate helper_retaddr here.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/helper-a64.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/target/arm/helper-a64.c b/target/arm/helper-a64.c
> index d0e435ca4b..96a3ecf707 100644
> --- a/target/arm/helper-a64.c
> +++ b/target/arm/helper-a64.c
> @@ -456,6 +456,8 @@ static uint64_t do_paired_cmpxchg64_le(CPUARMState *env, uint64_t addr,
>  #ifdef CONFIG_USER_ONLY
>          /* ??? Enforce alignment.  */
>          uint64_t *haddr = g2h(addr);
> +
> +        helper_retaddr = ra;
>          o0 = ldq_le_p(haddr + 0);
>          o1 = ldq_le_p(haddr + 1);
>          oldv = int128_make128(o0, o1);
> @@ -465,6 +467,7 @@ static uint64_t do_paired_cmpxchg64_le(CPUARMState *env, uint64_t addr,
>              stq_le_p(haddr + 0, int128_getlo(newv));
>              stq_le_p(haddr + 1, int128_gethi(newv));
>          }
> +        helper_retaddr = 0;
>  #else
>          int mem_idx = cpu_mmu_index(env, false);
>          TCGMemOpIdx oi0 = make_memop_idx(MO_LEQ | MO_ALIGN_16, mem_idx);
> @@ -523,6 +526,8 @@ static uint64_t do_paired_cmpxchg64_be(CPUARMState *env, uint64_t addr,
>  #ifdef CONFIG_USER_ONLY
>          /* ??? Enforce alignment.  */
>          uint64_t *haddr = g2h(addr);
> +
> +        helper_retaddr = ra;
>          o1 = ldq_be_p(haddr + 0);
>          o0 = ldq_be_p(haddr + 1);
>          oldv = int128_make128(o0, o1);
> @@ -532,6 +537,7 @@ static uint64_t do_paired_cmpxchg64_be(CPUARMState *env, uint64_t addr,
>              stq_be_p(haddr + 0, int128_gethi(newv));
>              stq_be_p(haddr + 1, int128_getlo(newv));
>          }
> +        helper_retaddr = 0;
>  #else
>          int mem_idx = cpu_mmu_index(env, false);
>          TCGMemOpIdx oi0 = make_memop_idx(MO_BEQ | MO_ALIGN_16, mem_idx);
> --
> 2.12.0

These functions aren't directly called from guest code, so needs
this fixup to work with an unoptimised build:


diff --git a/target/arm/helper-a64.c b/target/arm/helper-a64.c
index 96a3ecf..b84ebca 100644
--- a/target/arm/helper-a64.c
+++ b/target/arm/helper-a64.c
@@ -432,9 +432,8 @@ uint64_t HELPER(crc32c_64)(uint64_t acc, uint64_t
val, uint32_t bytes)
 /* Returns 0 on success; 1 otherwise.  */
 static uint64_t do_paired_cmpxchg64_le(CPUARMState *env, uint64_t addr,
                                        uint64_t new_lo, uint64_t new_hi,
-                                       bool parallel)
+                                       bool parallel, uintptr_t ra)
 {
-    uintptr_t ra = GETPC();
     Int128 oldv, cmpv, newv;
     bool success;

@@ -491,20 +490,19 @@ static uint64_t
do_paired_cmpxchg64_le(CPUARMState *env, uint64_t addr,
 uint64_t HELPER(paired_cmpxchg64_le)(CPUARMState *env, uint64_t addr,
                                               uint64_t new_lo, uint64_t new_hi)
 {
-    return do_paired_cmpxchg64_le(env, addr, new_lo, new_hi, false);
+    return do_paired_cmpxchg64_le(env, addr, new_lo, new_hi, false, GETPC());
 }

 uint64_t HELPER(paired_cmpxchg64_le_parallel)(CPUARMState *env, uint64_t addr,
                                               uint64_t new_lo, uint64_t new_hi)
 {
-    return do_paired_cmpxchg64_le(env, addr, new_lo, new_hi, true);
+    return do_paired_cmpxchg64_le(env, addr, new_lo, new_hi, true, GETPC());
 }

 static uint64_t do_paired_cmpxchg64_be(CPUARMState *env, uint64_t addr,
                                        uint64_t new_lo, uint64_t new_hi,
-                                       bool parallel)
+                                       bool parallel, uintptr_t ra)
 {
-    uintptr_t ra = GETPC();
     Int128 oldv, cmpv, newv;
     bool success;

@@ -561,11 +559,11 @@ static uint64_t
do_paired_cmpxchg64_be(CPUARMState *env, uint64_t addr,
 uint64_t HELPER(paired_cmpxchg64_be)(CPUARMState *env, uint64_t addr,
                                      uint64_t new_lo, uint64_t new_hi)
 {
-    return do_paired_cmpxchg64_be(env, addr, new_lo, new_hi, false);
+    return do_paired_cmpxchg64_be(env, addr, new_lo, new_hi, false, GETPC());
 }

 uint64_t HELPER(paired_cmpxchg64_be_parallel)(CPUARMState *env, uint64_t addr,
                                      uint64_t new_lo, uint64_t new_hi)
 {
-    return do_paired_cmpxchg64_be(env, addr, new_lo, new_hi, true);
+    return do_paired_cmpxchg64_be(env, addr, new_lo, new_hi, true, GETPC());
 }


thanks
-- PMM
