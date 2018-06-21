Received: from eggs.gnu.org ([2001:4830:134:3::10]:55896)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1fW3aj-0003qd-1B
	for qemu-devel@nongnu.org; Thu, 21 Jun 2018 13:41:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1fW3ai-0005mI-4q
	for qemu-devel@nongnu.org; Thu, 21 Jun 2018 13:41:53 -0400
References: <20180621171257.14897-1-f4bug@amsat.org>
	<20180621171257.14897-11-f4bug@amsat.org>
From: John Snow <jsnow@redhat.com>
Message-ID: <4aa9b48d-1934-bf06-0bae-9d8d2721f199@redhat.com>
Date: Thu, 21 Jun 2018 13:41:44 -0400
MIME-Version: 1.0
In-Reply-To: <20180621171257.14897-11-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 10/11] hw/block/fdc: Convert from
 FLOPPY_DPRINTF() macro to trace events
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-trivial@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, "open list:Floppy" <qemu-block@nongnu.org>



On 06/21/2018 01:12 PM, Philippe Mathieu-Daud=C3=A9 wrote:
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> ---
>  hw/block/fdc.c        | 6 +++---
>  hw/block/trace-events | 4 ++++
>  2 files changed, 7 insertions(+), 3 deletions(-)
>=20
> diff --git a/hw/block/fdc.c b/hw/block/fdc.c
> index cd29e27d8f..c7b4fe9b3e 100644
> --- a/hw/block/fdc.c
> +++ b/hw/block/fdc.c
> @@ -40,6 +40,7 @@
>  #include "sysemu/blockdev.h"
>  #include "sysemu/sysemu.h"
>  #include "qemu/log.h"
> +#include "trace.h"
> =20
>  /********************************************************/
>  /* debug Floppy devices */
> @@ -934,7 +935,7 @@ static uint32_t fdctrl_read (void *opaque, uint32_t=
 reg)
>          retval =3D (uint32_t)(-1);
>          break;
>      }
> -    FLOPPY_DPRINTF("read reg%d: 0x%02x\n", reg & 7, retval);
> +    trace_fdc_ioport_read(reg, retval);

Earlier in this function we've already masked the register number, which
is not clear from context.

Reviewed-by: John Snow <jsnow@redhat.com>

(and ACK, to whomever stages this outside of my branch. --js)

> =20
>      return retval;
>  }
> @@ -943,9 +944,8 @@ static void fdctrl_write (void *opaque, uint32_t re=
g, uint32_t value)
>  {
>      FDCtrl *fdctrl =3D opaque;
> =20
> -    FLOPPY_DPRINTF("write reg%d: 0x%02x\n", reg & 7, value);
> -
>      reg &=3D 7;
> +    trace_fdc_ioport_write(reg, value);
>      switch (reg) {
>      case FD_REG_DOR:
>          fdctrl_write_dor(fdctrl, value);
> diff --git a/hw/block/trace-events b/hw/block/trace-events
> index 6b9e733412..d842c45409 100644
> --- a/hw/block/trace-events
> +++ b/hw/block/trace-events
> @@ -1,5 +1,9 @@
>  # See docs/devel/tracing.txt for syntax documentation.
> =20
> +# hw/block/fdc.c
> +fdc_ioport_read(uint8_t reg, uint8_t value) "read reg 0x%02x val 0x%02=
x"
> +fdc_ioport_write(uint8_t reg, uint8_t value) "write reg 0x%02x val 0x%=
02x"
> +
>  # hw/block/virtio-blk.c
>  virtio_blk_req_complete(void *vdev, void *req, int status) "vdev %p re=
q %p status %d"
>  virtio_blk_rw_complete(void *vdev, void *req, int ret) "vdev %p req %p=
 ret %d"
>=20
