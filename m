Received: from eggs.gnu.org ([2001:4830:134:3::10]:52218)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1d9lyi-0006dd-Vd
	for qemu-devel@nongnu.org; Sun, 14 May 2017 01:22:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1d9lyf-0004ob-Qf
	for qemu-devel@nongnu.org; Sun, 14 May 2017 01:22:00 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <1493226792-3237-1-git-send-email-peter.maydell@linaro.org>
	<1493226792-3237-4-git-send-email-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <fa2c7203-644e-9209-91d8-e37c345b8240@amsat.org>
Date: Sun, 14 May 2017 02:21:52 -0300
MIME-Version: 1.0
In-Reply-To: <1493226792-3237-4-git-send-email-peter.maydell@linaro.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [Qemu-arm] [PATCH 3/3] hw/intc/arm_gicv3_cpuif:
 Fix priority masking for NS BPR1
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

On 04/26/2017 02:13 PM, Peter Maydell wrote:
> When we calculate the mask to use to get the group priority from
> an interrupt priority, the way that NS BPR1 is handled differs
> from how BPR0 and S BPR1 work -- a BPR1 value of 1 means
> the group priority is in bits [7:1], whereas for BPR0 and S BPR1
> this is indicated by a 0 BPR value.
>
> Subtract 1 from the BPR value before creating the mask if
> we're using the NS BPR value, for both hardware and virtual
> interrupts, as the GICv3 pseudocode does, and fix the comments
> accordingly.
>
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  hw/intc/arm_gicv3_cpuif.c | 41 +++++++++++++++++++++++++++++++++++++----
>  1 file changed, 37 insertions(+), 4 deletions(-)
>
> diff --git a/hw/intc/arm_gicv3_cpuif.c b/hw/intc/arm_gicv3_cpuif.c
> index e660b3f..eec53c8 100644
> --- a/hw/intc/arm_gicv3_cpuif.c
> +++ b/hw/intc/arm_gicv3_cpuif.c
> @@ -216,18 +216,34 @@ static uint32_t icv_gprio_mask(GICv3CPUState *cs, int group)
>  {
>      /* Return a mask word which clears the subpriority bits from
>       * a priority value for a virtual interrupt in the specified group.
> -     * This depends on the VBPR value:
> +     * This depends on the VBPR value. If using VBPR0 then:

just aesthetic but I'd move "If using VBPR0 then:" to a new line.

>       *  a BPR of 0 means the group priority bits are [7:1];
>       *  a BPR of 1 means they are [7:2], and so on down to
>       *  a BPR of 7 meaning no group priority bits at all.
> +     * If using VBPR1 then:
> +     *  a BPR of 0 is impossible (the minimum value is 1)
> +     *  a BPR of 1 means the group priority bits are [7:1];
> +     *  a BPR of 2 means they are [7:2], and so on down to
> +     *  a BPR of 6 meaning no group priority bits at all.

This last line seems wrong to me, probably due to copying VBPR0.
I think this should be:

         *  a BPR of 7 meaning the group priority is [7].

> +     *
>       * Which BPR to use depends on the group of the interrupt and
>       * the current ICH_VMCR_EL2.VCBPR settings.
> +     *
> +     * This corresponds to the VGroupBits() pseudocode.

Very welcome comment!

>       */
> +    int bpr;
> +
>      if (group == GICV3_G1NS && cs->ich_vmcr_el2 & ICH_VMCR_EL2_VCBPR) {
>          group = GICV3_G0;
>      }
>
> -    return ~0U << (read_vbpr(cs, group) + 1);
> +    bpr = read_vbpr(cs, group);
> +    if (group == GICV3_G1NS) {
> +        assert(bpr > 0);

Shouldn't happen but we never know!

> +        bpr--;

Yes.

> +    }
> +
> +    return ~0U << (bpr + 1);
>  }
>
>  static bool icv_hppi_can_preempt(GICv3CPUState *cs, uint64_t lr)
> @@ -674,20 +690,37 @@ static uint32_t icc_gprio_mask(GICv3CPUState *cs, int group)
>  {
>      /* Return a mask word which clears the subpriority bits from
>       * a priority value for an interrupt in the specified group.
> -     * This depends on the BPR value:
> +     * This depends on the BPR value. For CBPR0 (S or NS):
>       *  a BPR of 0 means the group priority bits are [7:1];
>       *  a BPR of 1 means they are [7:2], and so on down to
>       *  a BPR of 7 meaning no group priority bits at all.
> +     * For CBPR1 NS:
> +     *  a BPR of 0 is impossible (the minimum value is 1)
> +     *  a BPR of 1 means the group priority bits are [7:1];
> +     *  a BPR of 2 means they are [7:2], and so on down to
> +     *  a BPR of 6 meaning no group priority bits at all.

Same here:

         "*  a BPR of 7 meaning the group priority is [7]."

If you agree with upgrading those comments:
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> +     *
>       * Which BPR to use depends on the group of the interrupt and
>       * the current ICC_CTLR.CBPR settings.
> +     *
> +     * This corresponds to the GroupBits() pseudocode.
>       */
> +    int bpr;
> +
>      if ((group == GICV3_G1 && cs->icc_ctlr_el1[GICV3_S] & ICC_CTLR_EL1_CBPR) ||
>          (group == GICV3_G1NS &&
>           cs->icc_ctlr_el1[GICV3_NS] & ICC_CTLR_EL1_CBPR)) {
>          group = GICV3_G0;
>      }
>
> -    return ~0U << ((cs->icc_bpr[group] & 7) + 1);
> +    bpr = cs->icc_bpr[group] & 7;
> +
> +    if (group == GICV3_G1NS) {
> +        assert(bpr > 0);
> +        bpr--;
> +    }
> +
> +    return ~0U << (bpr + 1);
>  }
>
>  static bool icc_no_enabled_hppi(GICv3CPUState *cs)
>

Regards,

Phil.
