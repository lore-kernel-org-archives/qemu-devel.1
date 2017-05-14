Received: from eggs.gnu.org ([2001:4830:134:3::10]:53115)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1d9m8I-0000yB-VI
	for qemu-devel@nongnu.org; Sun, 14 May 2017 01:31:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1d9m8E-00058z-8e
	for qemu-devel@nongnu.org; Sun, 14 May 2017 01:31:54 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <1493226792-3237-1-git-send-email-peter.maydell@linaro.org>
	<1493226792-3237-3-git-send-email-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <ce532829-b11b-7992-3fc4-3e21210c66f0@amsat.org>
Date: Sun, 14 May 2017 02:31:46 -0300
MIME-Version: 1.0
In-Reply-To: <1493226792-3237-3-git-send-email-peter.maydell@linaro.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 2/3] hw/intc/arm_gicv3_cpuif: Don't let BPR
 be set below its minimum
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

On 04/26/2017 02:13 PM, Peter Maydell wrote:
> icc_bpr_write() was not enforcing that writing a value below the
> minimum for the BPR should behave as if the BPR was set to the
> minimum value. This doesn't make a difference for the secure
> BPRs (since we define the minimum for the QEMU implementation
> as zero) but did mean we were allowing the NS BPR1 to be set to
> 0 when 1 should be the lowest value.
>
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  hw/intc/arm_gicv3_cpuif.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/hw/intc/arm_gicv3_cpuif.c b/hw/intc/arm_gicv3_cpuif.c
> index d31eba0..e660b3f 100644
> --- a/hw/intc/arm_gicv3_cpuif.c
> +++ b/hw/intc/arm_gicv3_cpuif.c
> @@ -1388,6 +1388,7 @@ static void icc_bpr_write(CPUARMState *env, const ARMCPRegInfo *ri,
>  {
>      GICv3CPUState *cs = icc_cs_from_env(env);
>      int grp = (ri->crm == 8) ? GICV3_G0 : GICV3_G1;
> +    uint64_t minval;
>
>      if (icv_access(env, grp == GICV3_G0 ? HCR_FMO : HCR_IMO)) {
>          icv_bpr_write(env, ri, value);
> @@ -1415,6 +1416,11 @@ static void icc_bpr_write(CPUARMState *env, const ARMCPRegInfo *ri,
>          return;
>      }
>
> +    minval = (grp == GICV3_G1NS) ? GIC_MIN_BPR_NS : GIC_MIN_BPR;
> +    if (value < minval) {
> +        value = minval;
> +    }
> +

which is:

     if (grp == GICV3_G1NS) {
         value = MAX(value, GIC_MIN_BPR_NS);
     }

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

>      cs->icc_bpr[grp] = value & 7;
>      gicv3_cpuif_update(cs);
>  }
>
