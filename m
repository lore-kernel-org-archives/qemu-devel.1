Received: from eggs.gnu.org ([2001:4830:134:3::10]:34211)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dMrkD-0006Fq-Pu
	for qemu-devel@nongnu.org; Mon, 19 Jun 2017 04:09:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dMrkA-0003VX-JN
	for qemu-devel@nongnu.org; Mon, 19 Jun 2017 04:09:09 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34388)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1dMrkA-0003V0-9k
	for qemu-devel@nongnu.org; Mon, 19 Jun 2017 04:09:06 -0400
References: <20170615203735.19649-1-rth@twiddle.net>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <82919db8-1004-9e42-e2a1-a4791e992524@redhat.com>
Date: Mon, 19 Jun 2017 10:08:59 +0200
MIME-Version: 1.0
In-Reply-To: <20170615203735.19649-1-rth@twiddle.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] target/s390x: Implement CSST
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <rth@twiddle.net>, qemu-devel@nongnu.org
Cc: aurelien@aurel32.net, David Hildenbrand <david@redhat.com>

On 15.06.2017 22:37, Richard Henderson wrote:
> There are no uses in a Linux system with which to test,
> but it Looks Right by my reading of the PoO.
> 
> Signed-off-by: Richard Henderson <rth@twiddle.net>
> ---
>  target/s390x/helper.h      |   1 +
>  target/s390x/insn-data.def |   2 +
>  target/s390x/mem_helper.c  | 189 +++++++++++++++++++++++++++++++++++++++++++++
>  target/s390x/translate.c   |  13 +++-
>  4 files changed, 204 insertions(+), 1 deletion(-)
> 
> diff --git a/target/s390x/helper.h b/target/s390x/helper.h
> index b268367..456aaa9 100644
> --- a/target/s390x/helper.h
> +++ b/target/s390x/helper.h
> @@ -33,6 +33,7 @@ DEF_HELPER_3(celgb, i64, env, i64, i32)
>  DEF_HELPER_3(cdlgb, i64, env, i64, i32)
>  DEF_HELPER_3(cxlgb, i64, env, i64, i32)
>  DEF_HELPER_4(cdsg, void, env, i64, i32, i32)
> +DEF_HELPER_4(csst, i32, env, i32, i64, i64)
>  DEF_HELPER_FLAGS_3(aeb, TCG_CALL_NO_WG, i64, env, i64, i64)
>  DEF_HELPER_FLAGS_3(adb, TCG_CALL_NO_WG, i64, env, i64, i64)
>  DEF_HELPER_FLAGS_5(axb, TCG_CALL_NO_WG, i64, env, i64, i64, i64, i64)
> diff --git a/target/s390x/insn-data.def b/target/s390x/insn-data.def
> index aa4c5b2..ef02a8e 100644
> --- a/target/s390x/insn-data.def
> +++ b/target/s390x/insn-data.def
> @@ -256,6 +256,8 @@
>      D(0xbb00, CDS,     RS_a,  Z,   r3_D32, r1_D32, new, r1_D32, cs, 0, MO_TEQ)
>      D(0xeb31, CDSY,    RSY_a, LD,  r3_D32, r1_D32, new, r1_D32, cs, 0, MO_TEQ)
>      C(0xeb3e, CDSG,    RSY_a, Z,   0, 0, 0, 0, cdsg, 0)
> +/* COMPARE AND SWAP AND STORE */
> +    C(0xc802, CSST,    SSF,   CASS, la1, a2, 0, 0, csst, 0)
>  
>  /* COMPARE AND TRAP */
>      D(0xb972, CRT,     RRF_c, GIE, r1_32s, r2_32s, 0, 0, ct, 0, 0)
> diff --git a/target/s390x/mem_helper.c b/target/s390x/mem_helper.c
> index 6125725..4a7d770 100644
> --- a/target/s390x/mem_helper.c
> +++ b/target/s390x/mem_helper.c
> @@ -1344,6 +1344,195 @@ void HELPER(cdsg)(CPUS390XState *env, uint64_t addr,
>      env->regs[r1 + 1] = int128_getlo(oldv);
>  }
>  
> +uint32_t HELPER(csst)(CPUS390XState *env, uint32_t r3, uint64_t a1, uint64_t a2)
> +{
> +#if !defined(CONFIG_USER_ONLY) || defined(CONFIG_ATOMIC128)
> +    uint32_t mem_idx = cpu_mmu_index(env, false);
> +#endif
> +    uintptr_t ra = GETPC();
> +    uint32_t fc = extract32(env->regs[0], 0, 8);
> +    uint32_t sc = extract32(env->regs[0], 8, 8);
> +    uint64_t pl = get_address(env, 1) & -16;
> +    uint64_t svh, svl;
> +    uint32_t cc;
> +
> +    /* Sanity check the function code and storage characteristic.  */
> +    if (fc > 1 || sc > 3) {
> +        if (!s390_has_feat(S390_FEAT_COMPARE_AND_SWAP_AND_STORE_2)) {
> +            goto spec_exception;
> +        }
> +        if (fc > 2 || sc > 4 || (fc == 2 && (r3 & 1))) {

I think you could omit the "fc == 2" here. fc has to be bigger than 1
due to the outer if-statement, and if it is not 2, the first "fc > 1"
has already triggered. So "fc" has to be 2 here and the "fc == 2" is a
redundant check.

 Thomas
