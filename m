Received: from eggs.gnu.org ([209.51.188.92]:51381)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ghH5z-00023e-Oe
	for qemu-devel@nongnu.org; Wed, 09 Jan 2019 11:52:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ghH5y-0004Sw-NV
	for qemu-devel@nongnu.org; Wed, 09 Jan 2019 11:52:47 -0500
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:41293)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1ghH5y-0004Ri-7l
	for qemu-devel@nongnu.org; Wed, 09 Jan 2019 11:52:46 -0500
Received: by mail-ot1-x344.google.com with SMTP id u16so7267822otk.8
	for <qemu-devel@nongnu.org>; Wed, 09 Jan 2019 08:52:46 -0800 (PST)
MIME-Version: 1.0
References: <20190109152430.32359-1-agraf@suse.de>
In-Reply-To: <20190109152430.32359-1-agraf@suse.de>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 9 Jan 2019 16:52:33 +0000
Message-ID: <CAFEAcA9zugZiWirk9QjqmAO9QKhLdCAWuG1PX5z7Nxm4O69aTg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH] target/arm: Allow to switch from MON->HYP
 on AArch32
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alexander Graf <agraf@suse.de>
Cc: qemu-arm <qemu-arm@nongnu.org>, Tom Rini <trini@konsulko.com>, Michal Simek <michal.simek@xilinx.com>, QEMU Developers <qemu-devel@nongnu.org>, Stephen Warren <swarren@wwwdotorg.org>, =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>

On Wed, 9 Jan 2019 at 15:26, Alexander Graf <agraf@suse.de> wrote:
>
> In U-boot, we switch from S-SVC -> MON -> HYP when we want to enter
> HYP mode. This dance seems to work ok (hence it's there in the code
> base), but breaks with current QEMU.
>
> The reason seems to be that we try to see whether we are entering
> HYP mode from the NS side. However, MON is always considered secure,
> so we always fall into an error case when going MON->HYP and never
> manage to actually do the switch.
>
> Fix this by not using a different helper function that does not bork
> when we're in MON state, as that switch is supposed to work.
>
> Signed-off-by: Alexander Graf <agraf@suse.de>
> ---
>  target/arm/helper.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/target/arm/helper.c b/target/arm/helper.c
> index f00c141ef9..9bf8fbd8f9 100644
> --- a/target/arm/helper.c
> +++ b/target/arm/helper.c
> @@ -6297,7 +6297,7 @@ static int bad_mode_switch(CPUARMState *env, int mode, CPSRWriteType write_type)
>          return 0;
>      case ARM_CPU_MODE_HYP:
>          return !arm_feature(env, ARM_FEATURE_EL2)
> -            || arm_current_el(env) < 2 || arm_is_secure(env);
> +            || arm_current_el(env) < 2 || arm_is_secure_below_el3(env);
>      case ARM_CPU_MODE_MON:
>          return arm_current_el(env) < 3;
>      default:
> --

This took me a while to figure out, because the
bad_mode_switch() code is called for doing checks
in two situations:
 (1) changes to mode by instructions writing to
CPSR.M (ie not exception take/return) -- this
corresponds to the Armv8 Arm ARM pseudocode
AArch32.WriteModeByInstr, and using this to enter or
leave Hyp mode is forbidden in v8 and UNPREDICTABLE in v7
 (2) changes to mode by exception return

Changing to or from Hyp by writing CPSR.M is
forbidden, but we catch that already at the top
of the bad_mode_switch() function. So what we
need to consider here is the exception-return case.
An exception return from Mon to Hyp with the NS bit 0
is OK. So this change is the right thing.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM
