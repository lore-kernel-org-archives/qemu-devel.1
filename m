Received: from eggs.gnu.org ([209.51.188.92]:46334)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gw4X4-0004CX-G4
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 07:29:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gw4Wz-0007mi-Tv
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 07:29:52 -0500
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:42583)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gw4Wy-0007Q4-Ui
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 07:29:49 -0500
Received: by mail-ot1-x344.google.com with SMTP id i5so33768423oto.9
	for <qemu-devel@nongnu.org>; Tue, 19 Feb 2019 04:29:24 -0800 (PST)
MIME-Version: 1.0
References: <20190214125107.22178-1-peter.maydell@linaro.org>
	<20190214125107.22178-13-peter.maydell@linaro.org>
In-Reply-To: <20190214125107.22178-13-peter.maydell@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 19 Feb 2019 12:29:11 +0000
Message-ID: <CAFEAcA_Q-ZSnaCE2-xQii4gGwwDDck6BM8PvRxs8d0xRMMtogQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH 12/14] hw/arm/musca: Add MPCs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>
Cc: "patches@linaro.org" <patches@linaro.org>

On Thu, 14 Feb 2019 at 12:51, Peter Maydell <peter.maydell@linaro.org> wrote:
>
> The Musca board puts its SRAM and flash behind TrustZone
> Memory Protection Controllers (MPCs). Each MPC sits between
> the CPU and the RAM/flash, and also has a set of memory mapped
> control registers. Wire up the MPCs, and the memory behind them.
> For the moment we implement the flash as simple ROM, which
> cannot be reprogrammed by the guest.
>
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  hw/arm/musca.c | 155 ++++++++++++++++++++++++++++++++++++++++++++++---
>  1 file changed, 147 insertions(+), 8 deletions(-)
>
> diff --git a/hw/arm/musca.c b/hw/arm/musca.c
> index 8774e0b87b7..5fadac8c09b 100644
> --- a/hw/arm/musca.c
> +++ b/hw/arm/musca.c
> @@ -27,11 +27,15 @@
>  #include "hw/arm/armsse.h"
>  #include "hw/boards.h"
>  #include "hw/core/split-irq.h"
> +#include "hw/misc/tz-mpc.h"
>  #include "hw/misc/tz-ppc.h"
>  #include "hw/misc/unimp.h"
>
>  #define MUSCA_NUMIRQ_MAX 96
>  #define MUSCA_PPC_MAX 3
> +#define MUSCA_MPC_MAX 5
> +
> +typedef struct MPCInfo MPCInfo;

[...]

> +typedef struct MPCInfo {
> +    const char *name;
> +    hwaddr addr;
> +    hwaddr size;
> +    MPCInfoType type;
> +} MPCInfo;

This should just be "struct MPCInfo { ... };" to avoid clang
complaining:

hw/arm/musca.c:165:3: error: redefinition of typedef 'MPCInfo' is a C11
      feature [-Werror,-Wtypedef-redefinition]

Since it's a minor thing I'll just squash it in when I
apply this series, assuming I don't need to respin for
anything else.

thanks
-- PMM
