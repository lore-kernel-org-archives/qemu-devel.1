Received: from eggs.gnu.org ([2001:4830:134:3::10]:53509)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1d9mCp-0002Ka-Ql
	for qemu-devel@nongnu.org; Sun, 14 May 2017 01:36:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1d9mCl-0008AW-4g
	for qemu-devel@nongnu.org; Sun, 14 May 2017 01:36:35 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <1493226792-3237-1-git-send-email-peter.maydell@linaro.org>
	<1493226792-3237-2-git-send-email-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <58ed86e6-0b92-152e-2238-302554651306@amsat.org>
Date: Sun, 14 May 2017 02:36:26 -0300
MIME-Version: 1.0
In-Reply-To: <1493226792-3237-2-git-send-email-peter.maydell@linaro.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [Qemu-arm] [PATCH 1/3] hw/intc/arm_gicv3_cpuif:
 Fix reset value for VMCR_EL2.VBPR1
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
> We were setting the VBPR1 field of VMCR_EL2 to icv_min_vbpr()
> on reset, but this is not correct. The field should reset to
> the minimum value of ICV_BPR0_EL1 plus one.
>
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  hw/intc/arm_gicv3_cpuif.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/hw/intc/arm_gicv3_cpuif.c b/hw/intc/arm_gicv3_cpuif.c
> index 0b20856..d31eba0 100644
> --- a/hw/intc/arm_gicv3_cpuif.c
> +++ b/hw/intc/arm_gicv3_cpuif.c
> @@ -2014,7 +2014,7 @@ static void icc_reset(CPUARMState *env, const ARMCPRegInfo *ri)
>      cs->ich_hcr_el2 = 0;
>      memset(cs->ich_lr_el2, 0, sizeof(cs->ich_lr_el2));
>      cs->ich_vmcr_el2 = ICH_VMCR_EL2_VFIQEN |
> -        (icv_min_vbpr(cs) << ICH_VMCR_EL2_VBPR1_SHIFT) |
> +        ((icv_min_vbpr(cs) + 1) << ICH_VMCR_EL2_VBPR1_SHIFT) |

Indeed "a BPR of 0 is impossible (the minimum value is 1)"

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

>          (icv_min_vbpr(cs) << ICH_VMCR_EL2_VBPR0_SHIFT);
>  }
>
>
