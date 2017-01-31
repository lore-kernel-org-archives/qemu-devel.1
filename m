Received: from eggs.gnu.org ([2001:4830:134:3::10]:57740)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cYhYj-0004Za-Tx
	for qemu-devel@nongnu.org; Tue, 31 Jan 2017 18:09:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cYhYi-0006bN-KF
	for qemu-devel@nongnu.org; Tue, 31 Jan 2017 18:09:57 -0500
Sender: Richard Henderson <rth7680@gmail.com>
References: <20170127103922.19658-1-alex.bennee@linaro.org>
	<20170127103922.19658-17-alex.bennee@linaro.org>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <70fe24bb-c8f1-43c4-010f-a682bdd507ef@twiddle.net>
Date: Tue, 31 Jan 2017 15:09:49 -0800
MIME-Version: 1.0
In-Reply-To: <20170127103922.19658-17-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v8 16/25] cputlb and arm/sparc targets:
 convert mmuidx flushes from varg to bitmap
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, mttcg@greensocs.com, qemu-devel@nongnu.org, fred.konrad@greensocs.com, a.rigo@virtualopensystems.com, cota@braap.org, bobby.prani@gmail.com, nikunj@linux.vnet.ibm.com
Cc: mark.burton@greensocs.com, pbonzini@redhat.com, jan.kiszka@siemens.com, serge.fdrv@gmail.com, peter.maydell@linaro.org, claudio.fontana@huawei.com, bamvor.zhangjian@linaro.org, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, Artyom Tarasenko <atar4qemu@gmail.com>, "open list:ARM" <qemu-arm@nongnu.org>

On 01/27/2017 02:39 AM, Alex Bennée wrote:
> +    for (mmu_idx = 0; mmu_idx < NB_MMU_MODES; mmu_idx++) {
>
> -        tlb_debug("%d\n", mmu_idx);
> +        if (test_bit(mmu_idx, &mmu_idx_bitmask)) {
> +            tlb_debug("%d\n", mmu_idx);
>
> -        memset(env->tlb_table[mmu_idx], -1, sizeof(env->tlb_table[0]));
> -        memset(env->tlb_v_table[mmu_idx], -1, sizeof(env->tlb_v_table[0]));
> +            memset(env->tlb_table[mmu_idx], -1, sizeof(env->tlb_table[0]));
> +            memset(env->tlb_v_table[mmu_idx], -1, sizeof(env->tlb_v_table[0]));
> +        }

Perhaps it doesn't matter since NB_MMU_MODES is so small but

   for (; idxmap != 0; idxmap &= idxmap - 1) {
     int mmu_idx = ctz32(idxmap);
     ...
   }

iterates only for the bits that are set.

> -typedef enum ARMMMUIdx {
> -    ARMMMUIdx_S12NSE0 = 0,
> -    ARMMMUIdx_S12NSE1 = 1,
> -    ARMMMUIdx_S1E2 = 2,
> -    ARMMMUIdx_S1E3 = 3,
> -    ARMMMUIdx_S1SE0 = 4,
> -    ARMMMUIdx_S1SE1 = 5,
> -    ARMMMUIdx_S2NS = 6,
> +typedef enum ARMMMUBitMap {
> +    ARMMMUBit_S12NSE0 = 1 << 0,
> +    ARMMMUBit_S12NSE1 = 1 << 1,
> +    ARMMMUBit_S1E2 = 1 << 2,
> +    ARMMMUBit_S1E3 = 1 << 3,
> +    ARMMMUBit_S1SE0 = 1 << 4,
> +    ARMMMUBit_S1SE1 = 1 << 5,
> +    ARMMMUBit_S2NS = 1 << 6,
>      /* Indexes below here don't have TLBs and are used only for AT system
>       * instructions or for the first stage of an S12 page table walk.
>       */
> -    ARMMMUIdx_S1NSE0 = 7,
> -    ARMMMUIdx_S1NSE1 = 8,
> -} ARMMMUIdx;
> +    ARMMMUBit_S1NSE0 = 1 << 7,
> +    ARMMMUBit_S1NSE1 = 1 << 8,
> +} ARMMMUBitMap;
>
> -#define MMU_USER_IDX 0
> +typedef int ARMMMUIdx;
> +
> +static inline ARMMMUIdx arm_mmu_bit_to_idx(ARMMMUBitMap bit)
> +{
> +    g_assert(ctpop16(bit) == 1);
> +    return ctz32(bit);
> +}
> +
> +static inline ARMMMUBitMap arm_mmu_idx_to_bit(ARMMMUIdx idx)
> +{
> +    return 1 << idx;
> +}

I don't understand this redefinition though, causing...

> @@ -2109,13 +2109,13 @@ static void ats_write(CPUARMState *env, const ARMCPRegInfo *ri, uint64_t value)
>          /* stage 1 current state PL1: ATS1CPR, ATS1CPW */
>          switch (el) {
>          case 3:
> -            mmu_idx = ARMMMUIdx_S1E3;
> +            mmu_bit = ARMMMUBit_S1E3;
>              break;
>          case 2:
> -            mmu_idx = ARMMMUIdx_S1NSE1;
> +            mmu_bit = ARMMMUBit_S1NSE1;
>              break;
>          case 1:
> -            mmu_idx = secure ? ARMMMUIdx_S1SE1 : ARMMMUIdx_S1NSE1;
> +            mmu_bit = secure ? ARMMMUBit_S1SE1 : ARMMMUBit_S1NSE1;
>              break;
>          default:
>              g_assert_not_reached();
> @@ -2125,13 +2125,13 @@ static void ats_write(CPUARMState *env, const ARMCPRegInfo *ri, uint64_t value)
>          /* stage 1 current state PL0: ATS1CUR, ATS1CUW */
>          switch (el) {
>          case 3:
> -            mmu_idx = ARMMMUIdx_S1SE0;
> +            mmu_bit = ARMMMUBit_S1SE0;
>              break;
>          case 2:
> -            mmu_idx = ARMMMUIdx_S1NSE0;
> +            mmu_bit = ARMMMUBit_S1NSE0;
>              break;
>          case 1:
> -            mmu_idx = secure ? ARMMMUIdx_S1SE0 : ARMMMUIdx_S1NSE0;
> +            mmu_bit = secure ? ARMMMUBit_S1SE0 : ARMMMUBit_S1NSE0;
>              break;
>          default:
>              g_assert_not_reached();
> @@ -2139,17 +2139,17 @@ static void ats_write(CPUARMState *env, const ARMCPRegInfo *ri, uint64_t value)
>          break;
>      case 4:
>          /* stage 1+2 NonSecure PL1: ATS12NSOPR, ATS12NSOPW */
> -        mmu_idx = ARMMMUIdx_S12NSE1;
> +        mmu_bit = ARMMMUBit_S12NSE1;
>          break;
>      case 6:
>          /* stage 1+2 NonSecure PL0: ATS12NSOUR, ATS12NSOUW */
> -        mmu_idx = ARMMMUIdx_S12NSE0;
> +        mmu_bit = ARMMMUBit_S12NSE0;
>          break;
>      default:
>          g_assert_not_reached();
>      }
>
> -    par64 = do_ats_write(env, value, access_type, mmu_idx);
> +    par64 = do_ats_write(env, value, access_type, arm_mmu_bit_to_idx(mmu_bit));

... this sort of churn, only to convert *back* to an index.

> @@ -2185,26 +2186,26 @@ static void ats_write64(CPUARMState *env, const ARMCPRegInfo *ri,
>      case 0:
>          switch (ri->opc1) {
>          case 0: /* AT S1E1R, AT S1E1W */
> -            mmu_idx = secure ? ARMMMUIdx_S1SE1 : ARMMMUIdx_S1NSE1;
> +            mmu_idx = secure ? ARMMMUBit_S1SE1 : ARMMMUBit_S1NSE1;
>              break;
>          case 4: /* AT S1E2R, AT S1E2W */
> -            mmu_idx = ARMMMUIdx_S1E2;
> +            mmu_idx = ARMMMUBit_S1E2;
>              break;
>          case 6: /* AT S1E3R, AT S1E3W */
> -            mmu_idx = ARMMMUIdx_S1E3;
> +            mmu_idx = ARMMMUBit_S1E3;
>              break;
>          default:
>              g_assert_not_reached();
>          }
>          break;
>      case 2: /* AT S1E0R, AT S1E0W */
> -        mmu_idx = secure ? ARMMMUIdx_S1SE0 : ARMMMUIdx_S1NSE0;
> +        mmu_idx = secure ? ARMMMUBit_S1SE0 : ARMMMUBit_S1NSE0;
>          break;
>      case 4: /* AT S12E1R, AT S12E1W */
> -        mmu_idx = secure ? ARMMMUIdx_S1SE1 : ARMMMUIdx_S12NSE1;
> +        mmu_idx = secure ? ARMMMUBit_S1SE1 : ARMMMUBit_S12NSE1;
>          break;
>      case 6: /* AT S12E0R, AT S12E0W */
> -        mmu_idx = secure ? ARMMMUIdx_S1SE0 : ARMMMUIdx_S12NSE0;
> +        mmu_idx = secure ? ARMMMUBit_S1SE0 : ARMMMUBit_S12NSE0;
>          break;
>      default:
>          g_assert_not_reached();
> @@ -2499,8 +2500,8 @@ static void vttbr_write(CPUARMState *env, const ARMCPRegInfo *ri,

... and then there's this one where you don't rename the variable, and as far 
as I can tell don't adjust the argument for do_ats_write.

Which is probably a mistake?

Just define both Idx and Bit symbols and be done with it.


r~
