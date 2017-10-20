Received: from eggs.gnu.org ([2001:4830:134:3::10]:58637)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1e5O1X-0005W6-Q5
	for qemu-devel@nongnu.org; Thu, 19 Oct 2017 23:31:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1e5O1U-00014J-MI
	for qemu-devel@nongnu.org; Thu, 19 Oct 2017 23:31:03 -0400
Received: from mail-qt0-x242.google.com ([2607:f8b0:400d:c0d::242]:45609)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1e5O1U-00013Y-Gh
	for qemu-devel@nongnu.org; Thu, 19 Oct 2017 23:31:00 -0400
Received: by mail-qt0-x242.google.com with SMTP id p1so17004733qtg.2
	for <qemu-devel@nongnu.org>; Thu, 19 Oct 2017 20:31:00 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <cover.1508390588.git.alistair.francis@xilinx.com>
	<136f534d6337e148924913a06c43b2e06fcebb4c.1508390588.git.alistair.francis@xilinx.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <9689eea3-864a-90f0-05d2-d70c481f3f73@amsat.org>
Date: Fri, 20 Oct 2017 00:30:39 -0300
MIME-Version: 1.0
In-Reply-To: <136f534d6337e148924913a06c43b2e06fcebb4c.1508390588.git.alistair.francis@xilinx.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 08/46] hw/char: Replace fprintf(stderr,
 "*\n" with error_report()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alistair Francis <alistair.francis@xilinx.com>, qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Paolo Bonzini <pbonzini@redhat.com>, armbru@redhat.com

On 10/19/2017 01:16 PM, Alistair Francis wrote:
> Replace a large number of the fprintf(stderr, "*\n" calls with
> error_report(). The functions were renamed with these commands and then
> compiler issues where manually fixed.
[...]
> ---
> V2:
>  - Split hw patch into individual directories
> 
>  hw/char/mcf_uart.c  | 5 +++--
>  hw/char/sh_serial.c | 9 +++++----
>  2 files changed, 8 insertions(+), 6 deletions(-)
> 
> diff --git a/hw/char/mcf_uart.c b/hw/char/mcf_uart.c
> index 56fa402b58..14cb051be9 100644
> --- a/hw/char/mcf_uart.c
> +++ b/hw/char/mcf_uart.c
> @@ -6,6 +6,7 @@
>   * This code is licensed under the GPL
>   */
>  #include "qemu/osdep.h"
> +#include "qemu/error-report.h"
>  #include "hw/hw.h"
>  #include "hw/sysbus.h"
>  #include "hw/m68k/mcf.h"
> @@ -174,7 +175,7 @@ static void mcf_do_command(mcf_uart_state *s, uint8_t cmd)
>          mcf_uart_do_tx(s);
>          break;
>      case 3: /* Reserved.  */
> -        fprintf(stderr, "mcf_uart: Bad TX command\n");
> +        error_report("mcf_uart: Bad TX command");

I'd rather use qemu_log_mask(LOG_GUEST_ERROR,...) here.

>          break;
>      }
>  
> @@ -189,7 +190,7 @@ static void mcf_do_command(mcf_uart_state *s, uint8_t cmd)
>          s->rx_enabled = 0;
>          break;
>      case 3: /* Reserved.  */
> -        fprintf(stderr, "mcf_uart: Bad RX command\n");
> +        error_report("mcf_uart: Bad RX command");

ditto

>          break;
>      }
>  }
> diff --git a/hw/char/sh_serial.c b/hw/char/sh_serial.c
> index 835b5378a0..7bb3f3c70b 100644
> --- a/hw/char/sh_serial.c
> +++ b/hw/char/sh_serial.c
> @@ -25,6 +25,7 @@
>   * THE SOFTWARE.
>   */
>  #include "qemu/osdep.h"
> +#include "qemu/error-report.h"
>  #include "hw/hw.h"
>  #include "hw/sh4/sh.h"
>  #include "chardev/char-fe.h"
> @@ -190,8 +191,8 @@ static void sh_serial_write(void *opaque, hwaddr offs,
>          }
>      }
>  
> -    fprintf(stderr, "sh_serial: unsupported write to 0x%02"
> -            HWADDR_PRIx "\n", offs);
> +    error_report("sh_serial: unsupported write to 0x%02"
> +                 HWADDR_PRIx "", offs);

and qemu_log_mask(LOG_UNIMP, ...) here

>      abort();
>  }
>  
> @@ -290,8 +291,8 @@ static uint64_t sh_serial_read(void *opaque, hwaddr offs,
>  #endif
>  
>      if (ret & ~((1 << 16) - 1)) {
> -        fprintf(stderr, "sh_serial: unsupported read from 0x%02"
> -                HWADDR_PRIx "\n", offs);
> +        error_report("sh_serial: unsupported read from 0x%02"
> +                     HWADDR_PRIx "", offs);

ditto

>          abort();
>      }
>  
> 
