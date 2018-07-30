Received: from eggs.gnu.org ([2001:4830:134:3::10]:52293)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fkCaC-00051q-Qp
	for qemu-devel@nongnu.org; Mon, 30 Jul 2018 14:07:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fkCaB-0000ND-W9
	for qemu-devel@nongnu.org; Mon, 30 Jul 2018 14:07:48 -0400
Received: from mail-oi0-x241.google.com ([2607:f8b0:4003:c06::241]:33246)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fkCaB-0000Lz-Qt
	for qemu-devel@nongnu.org; Mon, 30 Jul 2018 14:07:47 -0400
Received: by mail-oi0-x241.google.com with SMTP id l10-v6so22968220oii.0
	for <qemu-devel@nongnu.org>; Mon, 30 Jul 2018 11:07:47 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1532496652-26364-1-git-send-email-hongbo.zhang@linaro.org>
References: <1532496652-26364-1-git-send-email-hongbo.zhang@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 30 Jul 2018 19:07:26 +0100
Message-ID: <CAFEAcA-v+tOzub5V1_3stzNYX9M7hHX0c__jhSWM-q14QdtoTA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v2 1/2] hw/arm: check fw_cfg return value
 before using it
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Hongbo Zhang <hongbo.zhang@linaro.org>
Cc: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, Radoslaw Biernacki <radoslaw.biernacki@linaro.org>, Ard Biesheuvel <ard.biesheuvel@linaro.org>, Leif Lindholm <leif.lindholm@linaro.org>

On 25 July 2018 at 06:30, Hongbo Zhang <hongbo.zhang@linaro.org> wrote:
> The fw_cfg value returned from fw_cfg_find() may be NULL, so check it
> before using.
>
> Signed-off-by: Hongbo Zhang <hongbo.zhang@linaro.org>
> ---
>  hw/arm/boot.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/hw/arm/boot.c b/hw/arm/boot.c
> index e09201c..43b217f 100644
> --- a/hw/arm/boot.c
> +++ b/hw/arm/boot.c
> @@ -930,6 +930,7 @@ void arm_load_kernel(ARMCPU *cpu, struct arm_boot_info *info)
>      hwaddr entry;
>      static const ARMInsnFixup *primary_loader;
>      AddressSpace *as = arm_boot_address_space(cpu, info);
> +    FWCfgState *fw_cfg;
>
>      /* CPU objects (unlike devices) are not automatically reset on system
>       * reset, so we must always register a handler to do so. If we're
> @@ -960,11 +961,10 @@ void arm_load_kernel(ARMCPU *cpu, struct arm_boot_info *info)
>              info->dtb_start = info->loader_start;
>          }
>
> -        if (info->kernel_filename) {
> -            FWCfgState *fw_cfg;
> +        fw_cfg = fw_cfg_find();
> +        if (info->kernel_filename && fw_cfg) {
>              bool try_decompressing_kernel;

This can only happen if:
 * the user provided a firmware blob
 * the user provided a -kernel option
 * the board does not have a fw_cfg so we can't pass the kernel to
   the firmware blob
right?

I think in this situation we should exit with a helpful error
message to the user (telling them that this board model does
not support using the -kernel option when a guest firmware image
is being booted), rather than silently ignoring the option.

thanks
-- PMM
