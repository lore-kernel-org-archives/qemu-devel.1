Received: from eggs.gnu.org ([2001:4830:134:3::10]:44857)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1e4L1T-000719-Uv
	for qemu-devel@nongnu.org; Tue, 17 Oct 2017 02:06:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1e4L1Q-0007q8-Pm
	for qemu-devel@nongnu.org; Tue, 17 Oct 2017 02:06:39 -0400
References: <20171017001209.32276-1-f4bug@amsat.org>
	<20171017001209.32276-31-f4bug@amsat.org>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <44b57d76-6d10-84c8-3a13-cdac7331c5d9@redhat.com>
Date: Tue, 17 Oct 2017 08:06:22 +0200
MIME-Version: 1.0
In-Reply-To: <20171017001209.32276-31-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 30/39] hw/display/vga: remove the old
 i386/pc dependency
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>, Gerd Hoffmann <kraxel@redhat.com>, =?UTF-8?Q?Herv=c3=a9_Poussineau?= <hpoussin@reactos.org>, Aurelien Jarno <aurelien@aurel32.net>, Yongbok Kim <yongbok.kim@imgtec.com>
Cc: qemu-devel@nongnu.org, qemu-trivial@nongnu.org

On 17.10.2017 02:12, Philippe Mathieu-Daud=C3=A9 wrote:
> move public API to "hw/display/vga.h" and private registers
> to "hw/display/vga_int_regs.h"
>=20
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> ---
>  hw/display/vga_int.h                 |  3 ++-
>  hw/display/{vga.h =3D> vga_int_regs.h} |  0
>  include/hw/display/vga.h             | 25 +++++++++++++++++++++++++
>  include/hw/i386/pc.h                 | 12 ------------
>  hw/display/vga-isa-mm.c              |  4 +---
>  hw/display/vga-isa.c                 |  2 +-
>  hw/display/vga.c                     |  4 ++--
>  hw/mips/mips_jazz.c                  |  1 +
>  vl.c                                 |  2 +-
>  MAINTAINERS                          |  1 +
>  10 files changed, 34 insertions(+), 20 deletions(-)
>  rename hw/display/{vga.h =3D> vga_int_regs.h} (100%)
>  create mode 100644 include/hw/display/vga.h
>=20
> diff --git a/hw/display/vga_int.h b/hw/display/vga_int.h
> index ad34a1f048..fe23b81442 100644
> --- a/hw/display/vga_int.h
> +++ b/hw/display/vga_int.h
> @@ -25,8 +25,9 @@
>  #ifndef HW_VGA_INT_H
>  #define HW_VGA_INT_H
> =20
> -#include "hw/hw.h"
> +#include "exec/ioport.h"
>  #include "exec/memory.h"
> +#include "ui/console.h"

So vga_int.h now includes console.h (is it really necessary?) ...

[...]
>  static inline bool isa_ne2000_init(ISABus *bus, int base, int irq, NIC=
Info *nd)
>  {
> diff --git a/hw/display/vga-isa-mm.c b/hw/display/vga-isa-mm.c
> index 51ccbccc41..e887b45651 100644
> --- a/hw/display/vga-isa-mm.c
> +++ b/hw/display/vga-isa-mm.c
> @@ -23,11 +23,9 @@
>   */
>  #include "qemu/osdep.h"
>  #include "hw/hw.h"
> -#include "ui/console.h"

... and here you also remove it from the .c file - OK ...

> -#include "hw/i386/pc.h"
> +#include "hw/display/vga.h"
>  #include "vga_int.h"
>  #include "ui/pixel_ops.h"
> -#include "qemu/timer.h"
> =20
>  #define VGA_RAM_SIZE (8192 * 1024)
> =20
> diff --git a/hw/display/vga-isa.c b/hw/display/vga-isa.c
> index 1af95562f2..9af43abee8 100644
> --- a/hw/display/vga-isa.c
> +++ b/hw/display/vga-isa.c
> @@ -26,7 +26,7 @@
>  #include "qemu/osdep.h"
>  #include "hw/hw.h"
>  #include "ui/console.h"

... but here you keep it? I think you should either remove it here, too,
or not add the include in the header (which I'd prefer if the header
itself does not depend on console.h).

> -#include "hw/i386/pc.h"
> +#include "hw/isa/isa.h"
>  #include "vga_int.h"
>  #include "ui/pixel_ops.h"
>  #include "qemu/timer.h"
> diff --git a/hw/display/vga.c b/hw/display/vga.c
> index ed24ef7076..0da4942a09 100644
> --- a/hw/display/vga.c
> +++ b/hw/display/vga.c
> @@ -24,9 +24,9 @@
>  #include "qemu/osdep.h"
>  #include "qapi/error.h"
>  #include "hw/hw.h"
> -#include "vga.h"
> +#include "hw/display/vga.h"
>  #include "ui/console.h"

Here's another one --^

 Thomas
