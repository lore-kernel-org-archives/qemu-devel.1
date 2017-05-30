Received: from eggs.gnu.org ([2001:4830:134:3::10]:33213)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dFiZQ-0000ED-V7
	for qemu-devel@nongnu.org; Tue, 30 May 2017 10:56:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dFiZM-00015A-9Z
	for qemu-devel@nongnu.org; Tue, 30 May 2017 10:56:29 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <1493122030-32191-1-git-send-email-peter.maydell@linaro.org>
	<1493122030-32191-10-git-send-email-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <c9954451-ad9b-2365-5ed7-bc4c29f40abe@amsat.org>
Date: Tue, 30 May 2017 11:56:21 -0300
MIME-Version: 1.0
In-Reply-To: <1493122030-32191-10-git-send-email-peter.maydell@linaro.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [Qemu-arm] [PATCH 09/13] armv7m: Implement M
 profile default memory map
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: Alistair Francis <alistair.francis@xilinx.com>, patches@linaro.org

Hi Peter,

On 04/25/2017 09:07 AM, Peter Maydell wrote:
> From: Michael Davidsaver <mdavidsaver@gmail.com>
>
> Add support for the M profile default memory map which is used
> if the MPU is not present or disabled.
>
> The main differences in behaviour from implementing this
> correctly are that we set the PAGE_EXEC attribute on
> the right regions of memory, such that device regions
> are not executable.
>
> Signed-off-by: Michael Davidsaver <mdavidsaver@gmail.com>
> [PMM: rephrased comment and commit message; don't mark
>  the flash memory region as not-writable]

"not-writable by system caches" maybe to clarify?

> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  target/arm/helper.c | 35 ++++++++++++++++++++++++++---------
>  1 file changed, 26 insertions(+), 9 deletions(-)
>
> diff --git a/target/arm/helper.c b/target/arm/helper.c
> index 9e1ed1c..51662ad 100644
> --- a/target/arm/helper.c
> +++ b/target/arm/helper.c
> @@ -8129,18 +8129,35 @@ static inline void get_phys_addr_pmsav7_default(CPUARMState *env,
>                                                  ARMMMUIdx mmu_idx,
>                                                  int32_t address, int *prot)
>  {
> -    *prot = PAGE_READ | PAGE_WRITE;
> -    switch (address) {
> -    case 0xF0000000 ... 0xFFFFFFFF:
> -        if (regime_sctlr(env, mmu_idx) & SCTLR_V) { /* hivecs execing is ok */
> +    if (!arm_feature(env, ARM_FEATURE_M)) {
> +        *prot = PAGE_READ | PAGE_WRITE;
> +        switch (address) {
> +        case 0xF0000000 ... 0xFFFFFFFF:
> +            if (regime_sctlr(env, mmu_idx) & SCTLR_V) {
> +                /* hivecs execing is ok */
> +                *prot |= PAGE_EXEC;
> +            }
> +            break;
> +        case 0x00000000 ... 0x7FFFFFFF:
 >              *prot |= PAGE_EXEC;

I checked at Table B3-1 on the ARMv7-M Architecture Reference Manual I 
got at https://static.docs.arm.com/ddi0403/e/DDI0403E_B_armv7m_arm.pdf 
and the on-chip peripheral address space at 0x40000000 is eXecute Never.

> +            break;
> +        }
> +    } else {
> +        /* Default system address map for M profile cores.
> +         * The architecture specifies which regions are execute-never;
> +         * at the MPU level no other checks are defined.
> +         */
> +        switch (address) {
> +        case 0x00000000 ... 0x1fffffff: /* ROM */
> +        case 0x20000000 ... 0x3fffffff: /* SRAM */
> +        case 0x60000000 ... 0x7fffffff: /* RAM */
> +        case 0x80000000 ... 0x9fffffff: /* RAM */
> +            *prot = PAGE_READ | PAGE_WRITE | PAGE_EXEC;
> +            break;
> +        default: /* Peripheral, 2x Device, and System */
> +            *prot = PAGE_READ | PAGE_WRITE;

This body is correct, however what do you think about using cases with 
comments instead of 'default'? This would be clearer.

>          }
> -        break;
> -    case 0x00000000 ... 0x7FFFFFFF:
> -        *prot |= PAGE_EXEC;
> -        break;
>      }
> -
>  }
>
>  static bool get_phys_addr_pmsav7(CPUARMState *env, uint32_t address,
>

Regards,

Phil.
