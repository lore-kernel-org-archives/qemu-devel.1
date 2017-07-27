Received: from eggs.gnu.org ([2001:4830:134:3::10]:54432)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dashJ-0002j9-84
	for qemu-devel@nongnu.org; Thu, 27 Jul 2017 20:00:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dashE-0002Uv-Bj
	for qemu-devel@nongnu.org; Thu, 27 Jul 2017 20:00:05 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <1501153150-19984-1-git-send-email-peter.maydell@linaro.org>
	<1501153150-19984-3-git-send-email-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <7834a272-4106-f076-a62b-9cff45f4ae42@amsat.org>
Date: Thu, 27 Jul 2017 20:59:55 -0300
MIME-Version: 1.0
In-Reply-To: <1501153150-19984-3-git-send-email-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [Qemu-arm] [PATCH for-2.10 2/5] target/arm: Don't
 allow guest to make System space executable for M profile
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

Hi Peter,

On 07/27/2017 07:59 AM, Peter Maydell wrote:
> For an M profile v7PMSA, the system space (0xe0000000 - 0xffffffff) can
> never be executable, even if the guest tries to set the MPU registers
> up that way. Enforce this restriction.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   target/arm/helper.c | 16 +++++++++++++++-
>   1 file changed, 15 insertions(+), 1 deletion(-)
> 
> diff --git a/target/arm/helper.c b/target/arm/helper.c
> index ceef225..169c361 100644
> --- a/target/arm/helper.c
> +++ b/target/arm/helper.c
> @@ -8251,6 +8251,14 @@ static inline bool is_ppb_region(CPUARMState *env, uint32_t address)
>           extract32(address, 20, 12) == 0xe00;
>   }
>   

I wonder if these should renamed pmsav7_is_ppb_region() and 
pmsav7_is_system_region().

> +static inline bool is_system_region(CPUARMState *env, uint32_t address)
> +{
> +    /* True if address is in the M profile system region
> +     * 0xe0000000 - 0xffffffff
> +     */
> +    return arm_feature(env, ARM_FEATURE_M) && extract32(address, 29, 3) == 0x7;
> +}
> +
>   static bool get_phys_addr_pmsav7(CPUARMState *env, uint32_t address,
>                                    int access_type, ARMMMUIdx mmu_idx,
>                                    hwaddr *phys_ptr, int *prot, uint32_t *fsr)
> @@ -8354,6 +8362,12 @@ static bool get_phys_addr_pmsav7(CPUARMState *env, uint32_t address,
>               get_phys_addr_pmsav7_default(env, mmu_idx, address, prot);
>           } else { /* a MPU hit! */
>               uint32_t ap = extract32(env->pmsav7.dracr[n], 8, 3);

Maybe names access_perms/execute_never are easier to read..

> +            uint32_t xn = extract32(env->pmsav7.dracr[n], 12, 1);
> +

clear MemManage exceptions:

                *fsr &= ~0xff;

> +            if (is_system_region(env, address)) {
> +                /* System space is always execute never */
> +                xn = 1;

                } else {
                    xn = extract32(env->pmsav7.dracr[n], 12, 1);

> +            }
>   
>               if (is_user) { /* User mode AP bit decoding */
>                   switch (ap) {
> @@ -8394,7 +8408,7 @@ static bool get_phys_addr_pmsav7(CPUARMState *env, uint32_t address,
>               }
>   
>               /* execute never */
> -            if (env->pmsav7.dracr[n] & (1 << 12)) {
> +            if (xn) {
>                   *prot &= ~PAGE_EXEC;

and here we now can set eXecuteNever violation:

		    *fsr |= R_V7M_CFSR_IACCVIOL_MASK;

>               }
>           }
> 
     }
     *fsr = 0x00d; /* Permission fault */

I don't understand this mask, I don't have bit [2] defined in my 
datashit, maybe it was expected to turn on exception Entry/Return which 
I have defined as bits 4 and 3 respectively, so I'd rather see here:

     *fsr |= R_V7M_CFSR_MUNSTKERR_MASK | R_V7M_CFSR_MSTKERR_MASK;

What do you think?

Regards,

Phil.
