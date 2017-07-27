Received: from eggs.gnu.org ([2001:4830:134:3::10]:39555)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dasGP-0001X3-IC
	for qemu-devel@nongnu.org; Thu, 27 Jul 2017 19:32:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dasGM-00082P-SB
	for qemu-devel@nongnu.org; Thu, 27 Jul 2017 19:32:17 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <1501153150-19984-1-git-send-email-peter.maydell@linaro.org>
	<1501153150-19984-2-git-send-email-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <529d1ff6-e9d0-9c63-6d15-ed8f5263d47a@amsat.org>
Date: Thu, 27 Jul 2017 20:32:10 -0300
MIME-Version: 1.0
In-Reply-To: <1501153150-19984-2-git-send-email-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [Qemu-arm] [PATCH for-2.10 1/5] target/arm: Don't
 do MPU lookups for addresses in M profile PPB region
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: patches@linaro.org

On 07/27/2017 07:59 AM, Peter Maydell wrote:
> The M profile PMSAv7 specification says that if the address being looked
> up is in the PPB region (0xe0000000 - 0xe00fffff) then we do not use
> the MPU regions but always use the default memory map. Implement this
> (we were previously behaving like an R profile PMSAv7, which does not
> special case this).
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   target/arm/helper.c | 17 ++++++++++++++++-
>   1 file changed, 16 insertions(+), 1 deletion(-)
> 
> diff --git a/target/arm/helper.c b/target/arm/helper.c
> index 4ed32c5..ceef225 100644
> --- a/target/arm/helper.c
> +++ b/target/arm/helper.c
> @@ -8244,6 +8244,13 @@ static bool pmsav7_use_background_region(ARMCPU *cpu,
>       }
>   }
>   
> +static inline bool is_ppb_region(CPUARMState *env, uint32_t address)
> +{
> +    /* True if address is in the M profile PPB region 0xe0000000 - 0xe00fffff */
> +    return arm_feature(env, ARM_FEATURE_M) &&
> +        extract32(address, 20, 12) == 0xe00;
> +}
> +
>   static bool get_phys_addr_pmsav7(CPUARMState *env, uint32_t address,
>                                    int access_type, ARMMMUIdx mmu_idx,
>                                    hwaddr *phys_ptr, int *prot, uint32_t *fsr)
> @@ -8255,7 +8262,15 @@ static bool get_phys_addr_pmsav7(CPUARMState *env, uint32_t address,
>       *phys_ptr = address;
>       *prot = 0;
>   
> -    if (regime_translation_disabled(env, mmu_idx)) { /* MPU disabled */
> +    if (regime_translation_disabled(env, mmu_idx) ||
> +        is_ppb_region(env, address)) {
> +        /* MPU disabled or M profile PPB access: use default memory map.
> +         * The other case which uses the default memory map in the
> +         * v7M ARM ARM pseudocode is exception vector reads from the vector
> +         * table. In QEMU those accesses are done in arm_v7m_load_vector(),
> +         * which always does a direct read using address_space_ldl(), rather
> +         * than going via this function, so we don't need to check that here.
> +         */

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

>           get_phys_addr_pmsav7_default(env, mmu_idx, address, prot);
>       } else { /* MPU enabled */
>           for (n = (int)cpu->pmsav7_dregion - 1; n >= 0; n--) {
> 
