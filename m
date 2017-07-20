Received: from eggs.gnu.org ([208.118.235.92]:49959)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Yongbok.Kim@imgtec.com>) id 1dYDCN-0008CD-ID
	for qemu-devel@nongnu.org; Thu, 20 Jul 2017 11:17:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <Yongbok.Kim@imgtec.com>) id 1dYDCM-0007At-Jo
	for qemu-devel@nongnu.org; Thu, 20 Jul 2017 11:17:07 -0400
Received: from mailapp01.imgtec.com ([195.59.15.196]:17996)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Yongbok.Kim@imgtec.com>) id 1dYDCM-0007Am-Dv
	for qemu-devel@nongnu.org; Thu, 20 Jul 2017 11:17:06 -0400
References: <cover.34f8428dbbcaa0611cef759667d281ae508ac91d.1500378931.git-series.james.hogan@imgtec.com>
	<d3c982318e0ca1e4d33f67daa7d3f915941f08c5.1500378931.git-series.james.hogan@imgtec.com>
From: Yongbok Kim <yongbok.kim@imgtec.com>
Message-ID: <e0387ff8-fc42-dd5c-f861-f7b9792b17f1@imgtec.com>
Date: Thu, 20 Jul 2017 16:17:05 +0100
MIME-Version: 1.0
In-Reply-To: <d3c982318e0ca1e4d33f67daa7d3f915941f08c5.1500378931.git-series.james.hogan@imgtec.com>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 3/14] target/mips: Weaken TLB flush on UX,
 SX, KX, ASID changes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: James Hogan <james.hogan@imgtec.com>
Cc: qemu-devel@nongnu.org, Aurelien Jarno <aurelien@aurel32.net>



On 18/07/2017 12:55, James Hogan wrote:
> There is no need to invalidate any shadow TLB entries when the ASID
> changes or when access to one of the 64-bit segments has been disabled,
> since doing so doesn't reveal to software whether any TLB entries have
> been evicted into the shadow half of the TLB.
> 
> Therefore weaken the tlb flushes in these cases to only flush the QEMU
> TLB.
> 
> Signed-off-by: James Hogan <james.hogan@imgtec.com>
> Cc: Yongbok Kim <yongbok.kim@imgtec.com>
> Cc: Aurelien Jarno <aurelien@aurel32.net>
> ---
> Changes in v2:
> - New patch.
> ---
>  target/mips/helper.c    | 2 +-
>  target/mips/op_helper.c | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/target/mips/helper.c b/target/mips/helper.c
> index e359ca3b448d..ceaeb8ceaf49 100644
> --- a/target/mips/helper.c
> +++ b/target/mips/helper.c
> @@ -290,7 +290,7 @@ void cpu_mips_store_status(CPUMIPSState *env, target_ulong val)
>  #if defined(TARGET_MIPS64)
>      if ((env->CP0_Status ^ old) & (old & (7 << CP0St_UX))) {
>          /* Access to at least one of the 64-bit segments has been disabled */
> -        cpu_mips_tlb_flush(env);
> +        tlb_flush(CPU(mips_env_get_cpu(env)));
>      }
>  #endif
>      if (env->CP0_Config3 & (1 << CP0C3_MT)) {
> diff --git a/target/mips/op_helper.c b/target/mips/op_helper.c
> index 1961cacfab18..c07f68ce1a97 100644
> --- a/target/mips/op_helper.c
> +++ b/target/mips/op_helper.c
> @@ -1416,7 +1416,7 @@ void helper_mtc0_entryhi(CPUMIPSState *env, target_ulong arg1)
>      /* If the ASID changes, flush qemu's TLB.  */
>      if ((old & env->CP0_EntryHi_ASID_mask) !=
>          (val & env->CP0_EntryHi_ASID_mask)) {
> -        cpu_mips_tlb_flush(env);
> +        tlb_flush(CPU(mips_env_get_cpu(env)));
>      }
>  }
>  
> 

Tested-by: Yongbok Kim <yongbok.kim@imgtec.com>

Regards,
Yongbok
