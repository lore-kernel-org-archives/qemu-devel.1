Received: from eggs.gnu.org ([2001:4830:134:3::10]:38801)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1d61rX-0000q8-Nh
	for qemu-devel@nongnu.org; Wed, 03 May 2017 17:31:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1d61rW-0005uS-TI
	for qemu-devel@nongnu.org; Wed, 03 May 2017 17:31:07 -0400
MIME-Version: 1.0
Sender: alistair23@gmail.com
In-Reply-To: <1493122030-32191-7-git-send-email-peter.maydell@linaro.org>
References: <1493122030-32191-1-git-send-email-peter.maydell@linaro.org>
	<1493122030-32191-7-git-send-email-peter.maydell@linaro.org>
From: Alistair Francis <alistair.francis@xilinx.com>
Date: Wed, 3 May 2017 14:30:33 -0700
Message-ID: <CAKmqyKNfzT3P_=CuNhCfXG-_LnJnaZGri+sWqpLk3RAgr_OJqA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PATCH 06/13] arm: Don't let no-MPU PMSA cores
 write to SCTLR.M
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-arm <qemu-arm@nongnu.org>, "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>, Alistair Francis <alistair.francis@xilinx.com>, =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, Patch Tracking <patches@linaro.org>

On Tue, Apr 25, 2017 at 5:07 AM, Peter Maydell <peter.maydell@linaro.org> wrote:
> If the CPU is a PMSA config with no MPU implemented, then the
> SCTLR.M bit should be RAZ/WI, so that the guest can never
> turn on the non-existent MPU.
>
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

Reviewed-by: Alistair Francis <alistair.francis@xilinx.com>

Thanks,

Alistair

> ---
>  target/arm/helper.c | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/target/arm/helper.c b/target/arm/helper.c
> index 404bfdb..f0f25c8 100644
> --- a/target/arm/helper.c
> +++ b/target/arm/helper.c
> @@ -3258,6 +3258,11 @@ static void sctlr_write(CPUARMState *env, const ARMCPRegInfo *ri,
>          return;
>      }
>
> +    if (arm_feature(env, ARM_FEATURE_PMSA) && !cpu->has_mpu) {
> +        /* M bit is RAZ/WI for PMSA with no MPU implemented */
> +        value &= ~SCTLR_M;
> +    }
> +
>      raw_write(env, ri, value);
>      /* ??? Lots of these bits are not implemented.  */
>      /* This may enable/disable the MMU, so do a TLB flush.  */
> --
> 2.7.4
>
>
