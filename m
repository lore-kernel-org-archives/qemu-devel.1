Received: from eggs.gnu.org ([2001:4830:134:3::10]:46424)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1d5fvT-0004eM-OY
	for qemu-devel@nongnu.org; Tue, 02 May 2017 18:05:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1d5fvS-0007LE-Mk
	for qemu-devel@nongnu.org; Tue, 02 May 2017 18:05:43 -0400
MIME-Version: 1.0
Sender: alistair23@gmail.com
In-Reply-To: <1493122030-32191-2-git-send-email-peter.maydell@linaro.org>
References: <1493122030-32191-1-git-send-email-peter.maydell@linaro.org>
	<1493122030-32191-2-git-send-email-peter.maydell@linaro.org>
From: Alistair Francis <alistair.francis@xilinx.com>
Date: Tue, 2 May 2017 15:05:08 -0700
Message-ID: <CAKmqyKMPX+=acJqRKkncy=s4G3C04Q8grD9PdSiPs8f1RuVRxg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PATCH 01/13] arm: Use the mmu_idx we're passed in
 arm_cpu_do_unaligned_access()
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

On Tue, Apr 25, 2017 at 5:06 AM, Peter Maydell <peter.maydell@linaro.org> wrote:
> When identifying the DFSR format for an alignment fault, use
> the mmu index that we are passed, rather than calling cpu_mmu_index()
> to get the mmu index for the current CPU state. This doesn't actually
> make any difference since the only cases where the current MMU index
> differs from the index used for the load are the "unprivileged
> load/store" instructions, and in that case the mmu index may
> differ but the translation regime is the same (apart from the
> "use from Hyp mode" case which is UNPREDICTABLE).
> However it's the more logical thing to do.
>
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

Reviewed-by: Alistair Francis <alistair.francis@xilinx.com>

Thanks,

Alistair

> ---
>  target/arm/op_helper.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/target/arm/op_helper.c b/target/arm/op_helper.c
> index 156b825..de24815 100644
> --- a/target/arm/op_helper.c
> +++ b/target/arm/op_helper.c
> @@ -208,7 +208,7 @@ void arm_cpu_do_unaligned_access(CPUState *cs, vaddr vaddr,
>      /* the DFSR for an alignment fault depends on whether we're using
>       * the LPAE long descriptor format, or the short descriptor format
>       */
> -    if (arm_s1_regime_using_lpae_format(env, cpu_mmu_index(env, false))) {
> +    if (arm_s1_regime_using_lpae_format(env, mmu_idx)) {
>          env->exception.fsr = (1 << 9) | 0x21;
>      } else {
>          env->exception.fsr = 0x1;
> --
> 2.7.4
>
>
