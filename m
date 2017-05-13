Received: from eggs.gnu.org ([2001:4830:134:3::10]:37761)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1d9ffk-0003BV-2j
	for qemu-devel@nongnu.org; Sat, 13 May 2017 18:38:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1d9ffh-00062W-0l
	for qemu-devel@nongnu.org; Sat, 13 May 2017 18:38:00 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <1493122030-32191-1-git-send-email-peter.maydell@linaro.org>
	<1493122030-32191-6-git-send-email-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <82878b52-ee9d-e427-f1f3-d112c693cc49@amsat.org>
Date: Sat, 13 May 2017 19:37:52 -0300
MIME-Version: 1.0
In-Reply-To: <1493122030-32191-6-git-send-email-peter.maydell@linaro.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 05/13] arm: Don't clear ARM_FEATURE_PMSA
 for no-mpu configs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: Alistair Francis <alistair.francis@xilinx.com>, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, patches@linaro.org

On 04/25/2017 09:07 AM, Peter Maydell wrote:
> Fix the handling of QOM properties for PMSA CPUs with no MPU:
>
> Allow no-MPU to be specified by either:
>  * has-mpu = false
>  * pmsav7_dregion = 0
> and make setting one imply the other. Don't clear the PMSA
> feature bit in this situation.
>
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  target/arm/cpu.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
>
> diff --git a/target/arm/cpu.c b/target/arm/cpu.c
> index f17e279..8e57498 100644
> --- a/target/arm/cpu.c
> +++ b/target/arm/cpu.c
> @@ -757,8 +757,14 @@ static void arm_cpu_realizefn(DeviceState *dev, Error **errp)
>          cpu->id_pfr1 &= ~0xf000;
>      }
>
> +    /* MPU can be configured out of a PMSA CPU either by setting has-mpu
> +     * to false or by setting pmsav7-dregion to 0.
> +     */
>      if (!cpu->has_mpu) {
> -        unset_feature(ARM_FEATURE_PMSA);

Oh, fixed here.

> +        cpu->pmsav7_dregion = 0;
> +    }
> +    if (cpu->pmsav7_dregion == 0) {
> +        cpu->has_mpu = false;
>      }
>
>      if (arm_feature(env, ARM_FEATURE_PMSA) &&
>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
