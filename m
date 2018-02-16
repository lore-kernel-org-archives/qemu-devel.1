Received: from eggs.gnu.org ([2001:4830:134:3::10]:54060)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1emg1L-0000c7-W8
	for qemu-devel@nongnu.org; Fri, 16 Feb 2018 08:25:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1emg1H-0003mf-9Y
	for qemu-devel@nongnu.org; Fri, 16 Feb 2018 08:25:47 -0500
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180215182421.23788-1-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <118274a7-3fc2-3245-55fb-5ddfde7b4f59@amsat.org>
Date: Fri, 16 Feb 2018 10:25:38 -0300
MIME-Version: 1.0
In-Reply-To: <20180215182421.23788-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [Qemu-arm] [PATCH] target/arm: Fix register
 definitions for VMIDR and VMPIDR
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

On 02/15/2018 03:24 PM, Peter Maydell wrote:
> The register definitions for VMIDR and VMPIDR have separate
> reginfo structs for the AArch32 and AArch64 registers. However
> the 32-bit versions are wrong:
>  * they use offsetof instead of offsetoflow32 to mark where
>    the 32-bit value lives in the uint64_t CPU state field

Maybe we can replace all offsetof() by offsetof64() and forbid the use
of offsetof() in this file, this will make A32 endian/alignment errors
more apparent.

>  * they don't mark themselves as ARM_CP_ALIAS
> 
> In particular this means that if you try to use an Arm guest CPU
> which enables EL2 on a big-endian host it will assert at reset:
>  target/arm/cpu.c:114: cp_reg_check_reset: Assertion `oldvalue == newvalue' failed.
> 
> because the reset of the 32-bit register writes to the top
> half of the uint64_t.
> 
> Correct the errors in the structures.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
> This is necessary for 'make check' to pass on big endian
> systems with the 'raspi3' board enabled, which is the
> first board which has an EL2-enabled-by-default CPU.
> ---
>  target/arm/helper.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/target/arm/helper.c b/target/arm/helper.c
> index e7586fcf6c..e27957df38 100644
> --- a/target/arm/helper.c
> +++ b/target/arm/helper.c
> @@ -5068,8 +5068,8 @@ void register_cp_regs_for_features(ARMCPU *cpu)
>              { .name = "VPIDR", .state = ARM_CP_STATE_AA32,
>                .cp = 15, .opc1 = 4, .crn = 0, .crm = 0, .opc2 = 0,
>                .access = PL2_RW, .accessfn = access_el3_aa32ns,
> -              .resetvalue = cpu->midr,
> -              .fieldoffset = offsetof(CPUARMState, cp15.vpidr_el2) },
> +              .resetvalue = cpu->midr, .type = ARM_CP_ALIAS,
> +              .fieldoffset = offsetoflow32(CPUARMState, cp15.vpidr_el2) },
>              { .name = "VPIDR_EL2", .state = ARM_CP_STATE_AA64,
>                .opc0 = 3, .opc1 = 4, .crn = 0, .crm = 0, .opc2 = 0,
>                .access = PL2_RW, .resetvalue = cpu->midr,
> @@ -5077,8 +5077,8 @@ void register_cp_regs_for_features(ARMCPU *cpu)
>              { .name = "VMPIDR", .state = ARM_CP_STATE_AA32,
>                .cp = 15, .opc1 = 4, .crn = 0, .crm = 0, .opc2 = 5,
>                .access = PL2_RW, .accessfn = access_el3_aa32ns,
> -              .resetvalue = vmpidr_def,
> -              .fieldoffset = offsetof(CPUARMState, cp15.vmpidr_el2) },
> +              .resetvalue = vmpidr_def, .type = ARM_CP_ALIAS,
> +              .fieldoffset = offsetoflow32(CPUARMState, cp15.vmpidr_el2) },
>              { .name = "VMPIDR_EL2", .state = ARM_CP_STATE_AA64,
>                .opc0 = 3, .opc1 = 4, .crn = 0, .crm = 0, .opc2 = 5,
>                .access = PL2_RW,
> 

After enjoying scrolling a 6666p specs,
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
