Received: from eggs.gnu.org ([2001:4830:134:3::10]:59936)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1clJIp-0001YU-7l
	for qemu-devel@nongnu.org; Tue, 07 Mar 2017 12:53:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1clJIo-0004lv-AP
	for qemu-devel@nongnu.org; Tue, 07 Mar 2017 12:53:39 -0500
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20170307155054.5833-1-alex.bennee@linaro.org>
	<20170307155054.5833-12-alex.bennee@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <f46089b3-d794-5d86-b623-92f131693b5e@amsat.org>
Date: Tue, 7 Mar 2017 14:53:27 -0300
MIME-Version: 1.0
In-Reply-To: <20170307155054.5833-12-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [Qemu-arm] [PATCH v3 11/11] hw/intc/arm_gic:
 modernise the DPRINTF
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, peter.maydell@linaro.org, rth@twiddle.net, pbonzini@redhat.com
Cc: mttcg@listserver.greensocs.com, nikunj@linux.vnet.ibm.com, a.rigo@virtualopensystems.com, qemu-devel@nongnu.org, cota@braap.org, "open list:ARM cores" <qemu-arm@nongnu.org>, bobby.prani@gmail.com, fred.konrad@greensocs.com

On 03/07/2017 12:50 PM, Alex Bennée wrote:
> While I was debugging the icount issues I realised a bunch of the
> messages look quite similar. I've fixed this by including __func__ in
> the debug print. At the same time I move the a modern if (GATE) style
> printf which ensures the compiler can check for format string errors
> even if the code gets optimised away in the non-DEBUG_GIC case.
>
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>  hw/intc/arm_gic.c | 13 +++++++++----
>  1 file changed, 9 insertions(+), 4 deletions(-)
>
> diff --git a/hw/intc/arm_gic.c b/hw/intc/arm_gic.c
> index 8e5a9d8a3e..b305d9032a 100644
> --- a/hw/intc/arm_gic.c
> +++ b/hw/intc/arm_gic.c
> @@ -26,15 +26,20 @@
>  #include "qemu/log.h"
>  #include "trace.h"
>
> -//#define DEBUG_GIC
> +/* #define DEBUG_GIC */
>
>  #ifdef DEBUG_GIC
> -#define DPRINTF(fmt, ...) \
> -do { fprintf(stderr, "arm_gic: " fmt , ## __VA_ARGS__); } while (0)
> +#define DEBUG_GIC_GATE 1
>  #else
> -#define DPRINTF(fmt, ...) do {} while(0)
> +#define DEBUG_GIC_GATE 0
>  #endif
>
> +#define DPRINTF(fmt, ...) do {                                          \
> +        if (DEBUG_GIC_GATE) {                                           \
> +            fprintf(stderr, "%s: " fmt, __func__, ## __VA_ARGS__);      \
> +        }                                                               \
> +    } while (0)
> +
>  static const uint8_t gic_id_11mpcore[] = {
>      0x00, 0x00, 0x00, 0x00, 0x90, 0x13, 0x04, 0x00, 0x0d, 0xf0, 0x05, 0xb1
>  };
>
