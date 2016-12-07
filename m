Received: from eggs.gnu.org ([2001:4830:134:3::10]:49079)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <edgar.iglesias@gmail.com>) id 1cEjND-000853-3a
	for qemu-devel@nongnu.org; Wed, 07 Dec 2016 16:03:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <edgar.iglesias@gmail.com>) id 1cEjNC-0001TO-0g
	for qemu-devel@nongnu.org; Wed, 07 Dec 2016 16:03:31 -0500
Date: Wed, 7 Dec 2016 22:02:21 +0100
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Message-ID: <20161207210221.GF9606@toto>
References: <1481046379-32632-1-git-send-email-peter.maydell@linaro.org>
	<1481046379-32632-3-git-send-email-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1481046379-32632-3-git-send-email-peter.maydell@linaro.org>
Subject: Re: [Qemu-devel] [PATCH 2/3] hw/intc/arm_gicv3: Remove incorrect
 usage of fieldoffset
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org

On Tue, Dec 06, 2016 at 05:46:18PM +0000, Peter Maydell wrote:
> In the ARMCPRegInfo definitions for the GICv3 CPU interface
> registers, we were trying to use .fieldoffset to specify
> the locations of data fields within the GICv3CPUState struct.
> This is completely broken, because .fieldoffset is for offsets
> into the CPUARMState struct. We didn't notice because we
> were only using this for reads to BPR0, AP0R<n>, IGRPEN0
> and CTLR_EL3, and Linux doesn't use these registers.
> 
> Replace the .fieldoffset uses with explicit read functions.

Reviewed-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>


> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  hw/intc/arm_gicv3_cpuif.c | 13 ++++++-------
>  1 file changed, 6 insertions(+), 7 deletions(-)
> 
> diff --git a/hw/intc/arm_gicv3_cpuif.c b/hw/intc/arm_gicv3_cpuif.c
> index bca30c4..35e8eb3 100644
> --- a/hw/intc/arm_gicv3_cpuif.c
> +++ b/hw/intc/arm_gicv3_cpuif.c
> @@ -1118,35 +1118,35 @@ static const ARMCPRegInfo gicv3_cpuif_reginfo[] = {
>        .opc0 = 3, .opc1 = 0, .crn = 12, .crm = 8, .opc2 = 3,
>        .type = ARM_CP_IO | ARM_CP_NO_RAW,
>        .access = PL1_RW, .accessfn = gicv3_fiq_access,
> -      .fieldoffset = offsetof(GICv3CPUState, icc_bpr[GICV3_G0]),
> +      .readfn = icc_bpr_read,
>        .writefn = icc_bpr_write,
>      },
>      { .name = "ICC_AP0R0_EL1", .state = ARM_CP_STATE_BOTH,
>        .opc0 = 3, .opc1 = 0, .crn = 12, .crm = 8, .opc2 = 4,
>        .type = ARM_CP_IO | ARM_CP_NO_RAW,
>        .access = PL1_RW, .accessfn = gicv3_fiq_access,
> -      .fieldoffset = offsetof(GICv3CPUState, icc_apr[GICV3_G0][0]),
> +      .readfn = icc_ap_read,
>        .writefn = icc_ap_write,
>      },
>      { .name = "ICC_AP0R1_EL1", .state = ARM_CP_STATE_BOTH,
>        .opc0 = 3, .opc1 = 0, .crn = 12, .crm = 8, .opc2 = 5,
>        .type = ARM_CP_IO | ARM_CP_NO_RAW,
>        .access = PL1_RW, .accessfn = gicv3_fiq_access,
> -      .fieldoffset = offsetof(GICv3CPUState, icc_apr[GICV3_G0][1]),
> +      .readfn = icc_ap_read,
>        .writefn = icc_ap_write,
>      },
>      { .name = "ICC_AP0R2_EL1", .state = ARM_CP_STATE_BOTH,
>        .opc0 = 3, .opc1 = 0, .crn = 12, .crm = 8, .opc2 = 6,
>        .type = ARM_CP_IO | ARM_CP_NO_RAW,
>        .access = PL1_RW, .accessfn = gicv3_fiq_access,
> -      .fieldoffset = offsetof(GICv3CPUState, icc_apr[GICV3_G0][2]),
> +      .readfn = icc_ap_read,
>        .writefn = icc_ap_write,
>      },
>      { .name = "ICC_AP0R3_EL1", .state = ARM_CP_STATE_BOTH,
>        .opc0 = 3, .opc1 = 0, .crn = 12, .crm = 8, .opc2 = 7,
>        .type = ARM_CP_IO | ARM_CP_NO_RAW,
>        .access = PL1_RW, .accessfn = gicv3_fiq_access,
> -      .fieldoffset = offsetof(GICv3CPUState, icc_apr[GICV3_G0][3]),
> +      .readfn = icc_ap_read,
>        .writefn = icc_ap_write,
>      },
>      /* All the ICC_AP1R*_EL1 registers are banked */
> @@ -1275,7 +1275,7 @@ static const ARMCPRegInfo gicv3_cpuif_reginfo[] = {
>        .opc0 = 3, .opc1 = 0, .crn = 12, .crm = 12, .opc2 = 6,
>        .type = ARM_CP_IO | ARM_CP_NO_RAW,
>        .access = PL1_RW, .accessfn = gicv3_fiq_access,
> -      .fieldoffset = offsetof(GICv3CPUState, icc_igrpen[GICV3_G0]),
> +      .readfn = icc_igrpen_read,
>        .writefn = icc_igrpen_write,
>      },
>      /* This register is banked */
> @@ -1299,7 +1299,6 @@ static const ARMCPRegInfo gicv3_cpuif_reginfo[] = {
>        .opc0 = 3, .opc1 = 6, .crn = 12, .crm = 12, .opc2 = 4,
>        .type = ARM_CP_IO | ARM_CP_NO_RAW,
>        .access = PL3_RW,
> -      .fieldoffset = offsetof(GICv3CPUState, icc_ctlr_el3),
>        .readfn = icc_ctlr_el3_read,
>        .writefn = icc_ctlr_el3_write,
>      },
> -- 
> 2.7.4
> 
