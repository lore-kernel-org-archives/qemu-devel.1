Received: from eggs.gnu.org ([2001:4830:134:3::10]:37112)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1erQq9-0003Le-2b
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 11:13:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1erQq8-00056s-5o
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 11:13:53 -0500
Received: from mail-ot0-x243.google.com ([2607:f8b0:4003:c0f::243]:42564)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1erQq8-000560-0P
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 11:13:52 -0500
Received: by mail-ot0-x243.google.com with SMTP id l5so6033456otf.9
	for <qemu-devel@nongnu.org>; Thu, 01 Mar 2018 08:13:51 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1519815685-29200-2-git-send-email-abdallah.bouassida@lauterbach.com>
References: <1519815685-29200-1-git-send-email-abdallah.bouassida@lauterbach.com>
	<1519815685-29200-2-git-send-email-abdallah.bouassida@lauterbach.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 1 Mar 2018 16:13:30 +0000
Message-ID: <CAFEAcA80d1AF=32Ds7GcfrxzHyywjueRMKMex0euwsFFwbfB-g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v3 1/4] target/arm: Add "ARM_CP_NO_GDB" as
 a new bit field for ARMCPRegInfo type
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Abdallah Bouassida <abdallah.bouassida@lauterbach.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>, Khaled Jmal <khaled.jmal@lauterbach.com>

On 28 February 2018 at 11:01, Abdallah Bouassida
<abdallah.bouassida@lauterbach.com> wrote:
> This is a preparation for the coming feature of creating dynamically an XML
> description for the ARM sysregs.
> A register has ARM_CP_NO_GDB enabled will not be shown in the dynamic XML.
> This bit is enabled automatically when creating CP_ANY wildcard aliases.
> This bit could be enabled manually for any register we want to remove from the
> dynamic XML description.
>
> Signed-off-by: Abdallah Bouassida <abdallah.bouassida@lauterbach.com>
> ---
>  target/arm/cpu.h    | 3 ++-
>  target/arm/helper.c | 2 +-
>  2 files changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/target/arm/cpu.h b/target/arm/cpu.h
> index 8c839fa..92cfe4c 100644
> --- a/target/arm/cpu.h
> +++ b/target/arm/cpu.h
> @@ -1776,10 +1776,11 @@ static inline uint64_t cpreg_to_kvm_id(uint32_t cpregid)
>  #define ARM_LAST_SPECIAL         ARM_CP_DC_ZVA
>  #define ARM_CP_FPU               0x1000
>  #define ARM_CP_SVE               0x2000
> +#define ARM_CP_NO_GDB            0x4000
>  /* Used only as a terminator for ARMCPRegInfo lists */
>  #define ARM_CP_SENTINEL          0xffff
>  /* Mask of only the flag bits in a type field */
> -#define ARM_CP_FLAG_MASK         0x30ff
> +#define ARM_CP_FLAG_MASK         0x70ff
>
>  /* Valid values for ARMCPRegInfo state field, indicating which of
>   * the AArch32 and AArch64 execution states this register is visible in.
> diff --git a/target/arm/helper.c b/target/arm/helper.c
> index c5bc69b..bdd212f 100644
> --- a/target/arm/helper.c
> +++ b/target/arm/helper.c
> @@ -5663,7 +5663,7 @@ static void add_cpreg_to_hashtable(ARMCPU *cpu, const ARMCPRegInfo *r,
>      if (((r->crm == CP_ANY) && crm != 0) ||
>          ((r->opc1 == CP_ANY) && opc1 != 0) ||
>          ((r->opc2 == CP_ANY) && opc2 != 0)) {
> -        r2->type |= ARM_CP_ALIAS;
> +        r2->type |= ARM_CP_ALIAS | ARM_CP_NO_GDB;
>      }
>
>      /* Check that raw accesses are either forbidden or handled. Note that
> --
> 2.7.4

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM
