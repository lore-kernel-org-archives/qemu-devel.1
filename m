Received: from eggs.gnu.org ([2001:4830:134:3::10]:36389)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fOKqs-0006m1-Es
	for qemu-devel@nongnu.org; Thu, 31 May 2018 06:30:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fOKqr-0003jb-G5
	for qemu-devel@nongnu.org; Thu, 31 May 2018 06:30:38 -0400
Received: from mail-ot0-x243.google.com ([2607:f8b0:4003:c0f::243]:39832)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fOKqr-0003i0-9c
	for qemu-devel@nongnu.org; Thu, 31 May 2018 06:30:37 -0400
Received: by mail-ot0-x243.google.com with SMTP id l12-v6so24728559oth.6
	for <qemu-devel@nongnu.org>; Thu, 31 May 2018 03:30:37 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180529220338.10879-2-jusual@mail.ru>
References: <20180529220338.10879-1-jusual@mail.ru>
	<20180529220338.10879-2-jusual@mail.ru>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 31 May 2018 11:30:16 +0100
Message-ID: <CAFEAcA-vWHUnpqkPY07398t9==eiCPyQBvKLHG=XR9xU2ust7g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [RFC 1/3] hw/arm/nrf51_soc: Fix compilation and
 memory regions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Julia Suvorova <jusual@mail.ru>
Cc: qemu-devel <qemu-devel@nongnu.org>, Stefan Hajnoczi <stefanha@gmail.com>, Joel Stanley <joel@jms.id.au>, Jim Mussared <jim@groklearning.com>, =?UTF-8?Q?Steffen_G=C3=B6rtz?= <mail@steffen-goertz.de>

On 29 May 2018 at 23:03, Julia Suvorova <jusual@mail.ru> wrote:
> nRF51 SoC implementation is intended for the BBC Micro:bit board,
> which has 256 KB flash and 16 KB RAM.
> Added FICR defines.
>
> Signed-off-by: Julia Suvorova <jusual@mail.ru>
> ---
>  hw/arm/nrf51_soc.c         | 12 +++++++-----
>  include/hw/arm/nrf51_soc.h |  1 +
>  2 files changed, 8 insertions(+), 5 deletions(-)
>
> diff --git a/hw/arm/nrf51_soc.c b/hw/arm/nrf51_soc.c
> index e59ba7079f..6fe06dcfd2 100644
> --- a/hw/arm/nrf51_soc.c
> +++ b/hw/arm/nrf51_soc.c
> @@ -26,15 +26,17 @@
>  #define IOMEM_SIZE      0x20000000
>
>  #define FLASH_BASE      0x00000000
> -#define FLASH_SIZE      (144 * 1024)
> +#define FLASH_SIZE      (256 * 1024)
> +
> +#define FICR_BASE       0x10000000
> +#define FICR_SIZE       0x100
>
>  #define SRAM_BASE       0x20000000
> -#define SRAM_SIZE       (6 * 1024)
> +#define SRAM_SIZE       (16 * 1024)
>
>  static void nrf51_soc_realize(DeviceState *dev_soc, Error **errp)
>  {
>      NRF51State *s = NRF51_SOC(dev_soc);
> -    DeviceState *nvic;
>      Error *err = NULL;
>
>      /* IO space */
> @@ -69,8 +71,8 @@ static void nrf51_soc_realize(DeviceState *dev_soc, Error **errp)
>      memory_region_add_subregion(system_memory, SRAM_BASE, sram);
>
>      /* TODO: implement a cortex m0 and update this */
> -    nvic = armv7m_init(get_system_memory(), FLASH_SIZE, 96,
> -            s->kernel_filename, ARM_CPU_TYPE_NAME("cortex-m3"));
> +    s->nvic = armv7m_init(get_system_memory(), FLASH_SIZE, 96,
> +               s->kernel_filename, ARM_CPU_TYPE_NAME("cortex-m3"));
>  }
>
>  static Property nrf51_soc_properties[] = {
> diff --git a/include/hw/arm/nrf51_soc.h b/include/hw/arm/nrf51_soc.h
> index 5431d200f8..a6bbe9f108 100644
> --- a/include/hw/arm/nrf51_soc.h
> +++ b/include/hw/arm/nrf51_soc.h
> @@ -23,6 +23,7 @@ typedef struct NRF51State {
>
>      /*< public >*/
>      char *kernel_filename;
> +    DeviceState *nvic;
>
>      MemoryRegion iomem;
>  } NRF51State;

The better approach here (which I think I suggested in review
of Joel's patches) is to have the armv7m object embedded in the
NRF51State. Then you can initialize and realize it in-place,
and the board code calls armv7m_load_kernel() rather than
having to pass the kernel filename to the SoC. (Nothing then
needs to call armv7m_init() at all.)

thanks
-- PMM
