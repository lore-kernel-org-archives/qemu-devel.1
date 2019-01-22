Received: from eggs.gnu.org ([209.51.188.92]:37537)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gm1VZ-00023b-2e
	for qemu-devel@nongnu.org; Tue, 22 Jan 2019 14:14:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gm1VX-0005PS-2Y
	for qemu-devel@nongnu.org; Tue, 22 Jan 2019 14:14:49 -0500
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:43718)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gm1VW-0005Nc-PN
	for qemu-devel@nongnu.org; Tue, 22 Jan 2019 14:14:46 -0500
Received: by mail-ot1-x341.google.com with SMTP id a11so24656823otr.10
	for <qemu-devel@nongnu.org>; Tue, 22 Jan 2019 11:14:46 -0800 (PST)
MIME-Version: 1.0
References: <20190110121736.23448-1-richard.henderson@linaro.org>
	<20190110121736.23448-5-richard.henderson@linaro.org>
In-Reply-To: <20190110121736.23448-5-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 22 Jan 2019 13:26:54 +0000
Message-ID: <CAFEAcA9Yz53O1OiG-eN=0eCdnO=Lz+yJPUtqVxfFSb3rrG4TEg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH 04/11] target/arm: Record the GP bit for a
 page in MemTxAttrs
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

On Thu, 10 Jan 2019 at 12:17, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> This isn't really a transaction attribute, but that's the most
> convenient place to hold a random bit of information within the
> softmmu tlb.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  include/exec/memattrs.h | 2 ++
>  target/arm/helper.c     | 6 ++++++
>  2 files changed, 8 insertions(+)
>
> diff --git a/include/exec/memattrs.h b/include/exec/memattrs.h
> index d4a1642098..39d61188e1 100644
> --- a/include/exec/memattrs.h
> +++ b/include/exec/memattrs.h
> @@ -35,6 +35,8 @@ typedef struct MemTxAttrs {
>      unsigned int secure:1;
>      /* Memory access is usermode (unprivileged) */
>      unsigned int user:1;
> +    /* Page is marked as "guarded" */
> +    unsigned int guarded:1;

Given that this isn't a real transaction attribute in the traditional
sense, and it's pretty Arm-specific, I think we could do with a
more expansive comment than this...

>      /* Requester ID (for MSI for example) */
>      unsigned int requester_id:16;
>  } MemTxAttrs;
> diff --git a/target/arm/helper.c b/target/arm/helper.c
> index 138d9d5565..4e9ea2ed39 100644
> --- a/target/arm/helper.c
> +++ b/target/arm/helper.c
> @@ -9927,6 +9927,7 @@ static bool get_phys_addr_lpae(CPUARMState *env, target_ulong address,
>      bool ttbr1_valid;
>      uint64_t descaddrmask;
>      bool aarch64 = arm_el_is_aa64(env, el);
> +    bool guarded = false;
>
>      /* TODO:
>       * This code does not handle the different format TCR for VTCR_EL2.
> @@ -10098,6 +10099,7 @@ static bool get_phys_addr_lpae(CPUARMState *env, target_ulong address,
>          }
>          /* Merge in attributes from table descriptors */
>          attrs |= nstable << 3; /* NS */
> +        guarded |= extract64(descriptor, 50, 1);  /* GP */

Do we need to do the logical-OR here? Since this is a
block/page entry bit with no similar bit in the table
descriptors, there's no merging to be done (ie we
only execute this code once and 'guarded' will always
be 'false' before execution of the |=.)

>          if (param.hpd) {
>              /* HPD disables all the table attributes except NSTable.  */
>              break;
> @@ -10143,6 +10145,10 @@ static bool get_phys_addr_lpae(CPUARMState *env, target_ulong address,
>           */
>          txattrs->secure = false;
>      }
> +    /* When in aarch64 mode, and BTI is enabled, remember GP in the IOTLB.  */
> +    if (aarch64 && guarded && cpu_isar_feature(aa64_bti, cpu)) {
> +        txattrs->guarded = true;
> +    }
>
>      if (cacheattrs != NULL) {
>          if (mmu_idx == ARMMMUIdx_S2NS) {
> --
> 2.17.2
>

thanks
-- PMM
