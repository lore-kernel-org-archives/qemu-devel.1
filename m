Received: from eggs.gnu.org ([2001:4830:134:3::10]:41810)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <th.huth@posteo.de>) id 1gEujz-0008Uz-Ew
	for qemu-devel@nongnu.org; Tue, 23 Oct 2018 07:20:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <th.huth@posteo.de>) id 1gEujp-000512-04
	for qemu-devel@nongnu.org; Tue, 23 Oct 2018 07:20:47 -0400
Received: from mout02.posteo.de ([185.67.36.66]:40651)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <th.huth@posteo.de>) id 1gEujm-0004dP-FT
	for qemu-devel@nongnu.org; Tue, 23 Oct 2018 07:20:40 -0400
Received: from submission (posteo.de [89.146.220.130])
	by mout02.posteo.de (Postfix) with ESMTPS id 6A25E240100
	for <qemu-devel@nongnu.org>; Tue, 23 Oct 2018 13:20:19 +0200 (CEST)
References: <20181018182856.28001-1-mark.cave-ayland@ilande.co.uk>
	<20181018182856.28001-12-mark.cave-ayland@ilande.co.uk>
From: Thomas Huth <th.huth@posteo.de>
Message-ID: <dea80569-ff85-7b29-ad49-b1c54aadf003@posteo.de>
Date: Tue, 23 Oct 2018 12:20:16 +0100
MIME-Version: 1.0
In-Reply-To: <20181018182856.28001-12-mark.cave-ayland@ilande.co.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v4 11/11] hw/m68k: define Macintosh Quadra
 800
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org, kwolf@redhat.com, famz@redhat.com, qemu-block@nongnu.org, jasowang@redhat.com, dgilbert@redhat.com, mreitz@redhat.com, hpoussin@reactos.org, kraxel@redhat.com, pbonzini@redhat.com, aurelien@aurel32.net, laurent@vivier.eu

On 2018-10-18 19:28, Mark Cave-Ayland wrote:
> From: Laurent Vivier <laurent@vivier.eu>
>=20
> Co-developed-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> Signed-off-by: Laurent Vivier <laurent@vivier.eu>
> ---
[...]
> diff --git a/hw/m68k/Makefile.objs b/hw/m68k/Makefile.objs
> index d1f089c08a..18ebf1937a 100644
> --- a/hw/m68k/Makefile.objs
> +++ b/hw/m68k/Makefile.objs
> @@ -1,2 +1,4 @@
> -obj-y +=3D an5206.o mcf5208.o
> -obj-y +=3D mcf5206.o mcf_intc.o
> +obj-$(CONFIG_COLDFIRE) +=3D an5206.o mcf5208.o
> +obj-$(CONFIG_MAC) +=3D q800.o
> +
> +obj-$(CONFIG_COLDFIRE) +=3D mcf5206.o mcf_intc.o

Cosmetic nit: Keep the coldfire lines together instead of splitting them?


> diff --git a/hw/m68k/q800.c b/hw/m68k/q800.c
> new file mode 100644
> index 0000000000..bbf34262f0
> --- /dev/null
> +++ b/hw/m68k/q800.c
> @@ -0,0 +1,367 @@
> +/*
> + * QEMU Motorla 680x0 Macintosh hardware System Emulator
> + *
> + * Permission is hereby granted, free of charge, to any person obtaini=
ng a copy
> + * of this software and associated documentation files (the "Software"=
), to deal
> + * in the Software without restriction, including without limitation t=
he rights
> + * to use, copy, modify, merge, publish, distribute, sublicense, and/o=
r sell
> + * copies of the Software, and to permit persons to whom the Software =
is
> + * furnished to do so, subject to the following conditions:
> + *
> + * The above copyright notice and this permission notice shall be incl=
uded in
> + * all copies or substantial portions of the Software.
> + *
> + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXP=
RESS OR
> + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABI=
LITY,
> + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT S=
HALL
> + * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES O=
R OTHER
> + * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARI=
SING FROM,
> + * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALI=
NGS IN
> + * THE SOFTWARE.
> + */
> +
> +#include "qemu/osdep.h"
> +#include "sysemu/sysemu.h"
> +#include "cpu.h"
> +#include "hw/hw.h"
> +#include "hw/boards.h"
> +#include "elf.h"
> +#include "hw/loader.h"
> +#include "hw/display/framebuffer.h"
> +#include "ui/console.h"
> +#include "exec/address-spaces.h"
> +#include "hw/char/escc.h"
> +#include "hw/sysbus.h"
> +#include "hw/scsi/esp.h"
> +#include "bootinfo.h"
> +#include "hw/misc/mac_via.h"
> +#include "hw/input/adb.h"
> +#include "hw/audio/asc.h"
> +#include "hw/nubus/mac-nubus-bridge.h"
> +#include "hw/display/macfb.h"
> +#include "hw/intc/q800_irq.h"
> +#include "hw/block/swim.h"
> +#include "net/net.h"
> +#include "qapi/error.h"
> +#include "sysemu/qtest.h"
> +
> +#define MACROM_ADDR     0x40000000
> +#define MACROM_SIZE     0x00100000
> +
> +/*
> + *              .ident          =3D MAC_MODEL_Q800,
> + *              .name           =3D "Quadra 800",
> + *              .adb_type       =3D MAC_ADB_II,
> + *              .via_type       =3D MAC_VIA_QUADRA,
> + *              .scsi_type      =3D MAC_SCSI_QUADRA,
> + *              .scc_type       =3D MAC_SCC_QUADRA,
> + *              .ether_type     =3D MAC_ETHER_SONIC,
> + *              .nubus_type     =3D MAC_NUBUS
> + */

Is this comment intentional or left-over code from an older rebase?

 Thomas
