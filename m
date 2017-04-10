Received: from eggs.gnu.org ([2001:4830:134:3::10]:37421)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1cxXjI-0001lU-0i
	for qemu-devel@nongnu.org; Mon, 10 Apr 2017 07:43:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1cxXjE-0003S2-VD
	for qemu-devel@nongnu.org; Mon, 10 Apr 2017 07:43:32 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <1491820793-5348-1-git-send-email-peter.maydell@linaro.org>
	<1491820793-5348-2-git-send-email-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <264eb0ef-168b-487e-3911-a2f1beafcd68@amsat.org>
Date: Mon, 10 Apr 2017 08:43:24 -0300
MIME-Version: 1.0
In-Reply-To: <1491820793-5348-2-git-send-email-peter.maydell@linaro.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [Qemu-arm] [PATCH 1/7] arm: Don't implement BXJ on
 M-profile CPUs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: Richard Henderson <rth@twiddle.net>, patches@linaro.org

On 04/10/2017 07:39 AM, Peter Maydell wrote:
> For M-profile CPUs, the BXJ instruction does not exist at all, and
> the encoding should always UNDEF. We were accidentally implementing
> it to behave like A-profile BXJ; correct the error.
>
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>  target/arm/translate.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
>
> diff --git a/target/arm/translate.c b/target/arm/translate.c
> index e32e38c..fe3f442 100644
> --- a/target/arm/translate.c
> +++ b/target/arm/translate.c
> @@ -10485,7 +10485,12 @@ static int disas_thumb2_insn(CPUARMState *env, DisasContext *s, uint16_t insn_hw
>                          }
>                          break;
>                      case 4: /* bxj */
> -                        /* Trivial implementation equivalent to bx.  */
> +                        /* Trivial implementation equivalent to bx.
> +                         * This instruction doesn't exist at all for M-profile.
> +                         */
> +                        if (arm_dc_feature(s, ARM_FEATURE_M)) {
> +                            goto illegal_op;
> +                        }
>                          tmp = load_reg(s, rn);
>                          gen_bx(s, tmp);
>                          break;
>
