Received: from eggs.gnu.org ([2001:4830:134:3::10]:38407)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ePgoS-0007qR-Rp
	for qemu-devel@nongnu.org; Thu, 14 Dec 2017 22:37:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ePgoS-0005tr-0m
	for qemu-devel@nongnu.org; Thu, 14 Dec 2017 22:37:28 -0500
MIME-Version: 1.0
Sender: philippe.mathieu.daude@gmail.com
In-Reply-To: <20171215033015.738-43-f4bug@amsat.org>
References: <20171215033015.738-1-f4bug@amsat.org>
	<20171215033015.738-43-f4bug@amsat.org>
From: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Date: Fri, 15 Dec 2017 00:37:26 -0300
Message-ID: <CAAdtpL4tJ3Q4iyTV9=ezb=VjisF9SAV9+uJXRU4cqGSMz2_sZQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v4 42/43] hw/i386/vmport: replace fprintf()
 by trace events
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>
Cc: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>, "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>, Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, QEMU Trivial <qemu-trivial@nongnu.org>, Richard Henderson <rth@twiddle.net>

Oops I sent the wrong file :(

On Fri, Dec 15, 2017 at 12:30 AM, Philippe Mathieu-Daud=C3=A9
<f4bug@amsat.org> wrote:
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> ---
>  hw/i386/vmport.c     | 8 +++-----
>  hw/i386/trace-events | 4 ++++
>  2 files changed, 7 insertions(+), 5 deletions(-)
>
> diff --git a/hw/i386/vmport.c b/hw/i386/vmport.c
> index eb880c6def..b5585a009a 100644
> --- a/hw/i386/vmport.c
> +++ b/hw/i386/vmport.c
> @@ -27,8 +27,7 @@
>  #include "hw/i386/pc.h"
>  #include "sysemu/hw_accel.h"
>  #include "hw/qdev.h"
> -
> -/* #define VMPORT_DEBUG */
> +#include "trace.h"
>
>  #define VMPORT_CMD_GETVERSION 0x0a
>  #define VMPORT_CMD_GETRAMSIZE 0x14
> @@ -54,6 +53,7 @@ void vmport_register(unsigned char command, VMPortReadF=
unc *func, void *opaque)
>          return;
>      }
>
> +    trace_vmport_register(command, func, opaque);
>      port_state->func[command] =3D func;
>      port_state->opaque[command] =3D opaque;
>  }
> @@ -80,9 +80,7 @@ static uint64_t vmport_ioport_read(void *opaque, hwaddr=
 addr,
>          return eax;
>      }
>      if (!s->func[command]) {
> -#ifdef VMPORT_DEBUG
> -        fprintf(stderr, "vmport: unknown command %x\n", command);
> -#endif
> +        trace_vmport_ioport_read_unknown_command(command, addr);
>          return eax;
>      }
>
> diff --git a/hw/i386/trace-events b/hw/i386/trace-events
> index d43b4b6cd3..f0522ea5e5 100644
> --- a/hw/i386/trace-events
> +++ b/hw/i386/trace-events
> @@ -113,3 +113,7 @@ amdvi_mode_invalid(uint8_t level, uint64_t addr)"erro=
r: translation level 0x%"PR
>  amdvi_page_fault(uint64_t addr) "error: page fault accessing guest physi=
cal address 0x%"PRIx64
>  amdvi_iotlb_hit(uint8_t bus, uint8_t slot, uint8_t func, uint64_t addr, =
uint64_t txaddr) "hit iotlb devid %02x:%02x.%x gpa 0x%"PRIx64" hpa 0x%"PRIx=
64
>  amdvi_translation_result(uint8_t bus, uint8_t slot, uint8_t func, uint64=
_t addr, uint64_t txaddr) "devid: %02x:%02x.%x gpa 0x%"PRIx64" hpa 0x%"PRIx=
64
> +
> +# hw/i386/vmport.c
> +vmport_register(unsigned char command, void *func, void *opaque) "comman=
d: 0x%02x func: %p opaque: %p"
> +vmport_ioport_read_unknown_command(unsigned char command, hwaddr addr) "=
unknown command: 0x%02x addr: 0x" HWADDR_PRIx

a '%' is missing here: 0x%" HWADDR_PRIx

-vmport_ioport_read_unknown_command(unsigned char command, hwaddr
addr) "unknown command: 0x%02x addr: 0x" HWADDR_PRIx
+vmport_ioport_read_unknown_command(unsigned char command, hwaddr
addr) "unknown command: 0x%02x addr: 0x%" HWADDR_PRIx

> --
> 2.15.1
>
