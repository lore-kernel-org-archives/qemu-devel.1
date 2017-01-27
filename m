Received: from eggs.gnu.org ([2001:4830:134:3::10]:47310)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1cX7me-0003fX-2z
	for qemu-devel@nongnu.org; Fri, 27 Jan 2017 09:45:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1cX7mY-0006xV-T5
	for qemu-devel@nongnu.org; Fri, 27 Jan 2017 09:45:47 -0500
Received: from mail-wm0-x22c.google.com ([2a00:1450:400c:c09::22c]:36968)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1cX7mY-0006wu-Nm
	for qemu-devel@nongnu.org; Fri, 27 Jan 2017 09:45:42 -0500
Received: by mail-wm0-x22c.google.com with SMTP id c206so141473988wme.0
	for <qemu-devel@nongnu.org>; Fri, 27 Jan 2017 06:45:42 -0800 (PST)
References: <1484247815-15279-1-git-send-email-peter.maydell@linaro.org>
	<1484247815-15279-4-git-send-email-peter.maydell@linaro.org>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <1484247815-15279-4-git-send-email-peter.maydell@linaro.org>
Date: Fri, 27 Jan 2017 14:45:39 +0000
Message-ID: <87tw8k8sto.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 3/3] stellaris: Use the 'unimplemented'
 device for parts we don't implement
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, patches@linaro.org


Peter Maydell <peter.maydell@linaro.org> writes:

> Use the 'unimplemented' dummy device to cover regions of the
> SoC device memory map which we don't have proper device
> implementations for yet.
>
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

Looks good although I couldn't find any Stellaris images to test with so
I take the actual behaviour on trust ;-)

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>

> ---
>  hw/arm/stellaris.c | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
>
> diff --git a/hw/arm/stellaris.c b/hw/arm/stellaris.c
> index 204502a..1f51e2b 100644
> --- a/hw/arm/stellaris.c
> +++ b/hw/arm/stellaris.c
> @@ -21,6 +21,7 @@
>  #include "exec/address-spaces.h"
>  #include "sysemu/sysemu.h"
>  #include "hw/char/pl011.h"
> +#include "hw/misc/unimp.h"
>
>  #define GPIO_A 0
>  #define GPIO_B 1
> @@ -1401,6 +1402,19 @@ static void stellaris_init(const char *kernel_filename, const char *cpu_model,
>              }
>          }
>      }
> +
> +    /* Add dummy regions for the devices we don't implement yet,
> +     * so guest accesses don't cause unlogged crashes.
> +     */
> +    create_unimplemented_device("wdtimer", 0x40000000, 0x1000);
> +    create_unimplemented_device("i2c-0", 0x40002000, 0x1000);
> +    create_unimplemented_device("i2c-2", 0x40021000, 0x1000);
> +    create_unimplemented_device("PWM", 0x40028000, 0x1000);
> +    create_unimplemented_device("QEI-0", 0x4002c000, 0x1000);
> +    create_unimplemented_device("QEI-1", 0x4002d000, 0x1000);
> +    create_unimplemented_device("analogue-comparator", 0x4003c000, 0x1000);
> +    create_unimplemented_device("hibernation", 0x400fc000, 0x1000);
> +    create_unimplemented_device("flash-control", 0x400fd000, 0x1000);
>  }
>
>  /* FIXME: Figure out how to generate these from stellaris_boards.  */


--
Alex Bennée
