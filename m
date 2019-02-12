Received: from eggs.gnu.org ([209.51.188.92]:59014)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gtajC-0005E5-4P
	for qemu-devel@nongnu.org; Tue, 12 Feb 2019 11:16:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gtaWV-0004hy-09
	for qemu-devel@nongnu.org; Tue, 12 Feb 2019 11:03:04 -0500
References: <20190212145322.30974-1-philmd@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <fd933137-81d6-1acc-0486-0bd170b52ade@redhat.com>
Date: Tue, 12 Feb 2019 17:02:48 +0100
MIME-Version: 1.0
In-Reply-To: <20190212145322.30974-1-philmd@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] hw/dma/i8257: Use qemu_log_mask(UNIMP)
 instead of fprintf
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>, qemu-trivial@nongnu.org, qemu-devel@nongnu.org
Cc: BALATON Zoltan <balaton@eik.bme.hu>, "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

On 2019-02-12 15:53, Philippe Mathieu-Daud=C3=A9 wrote:
> Avoid to clutter stdout until explicitly requested (with -d unimp):
>=20
>   $ qemu-system-mips64el -M fulong2e -bios pmon_2e.bin
>   dma: command df not supported
>   dma: command df not supported
>   dma: command df not supported
>   dma: command df not supported
>=20
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> ---
>  hw/dma/i8257.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>=20
> diff --git a/hw/dma/i8257.c b/hw/dma/i8257.c
> index 52675e97c9..3e1f13a4aa 100644
> --- a/hw/dma/i8257.c
> +++ b/hw/dma/i8257.c
> @@ -26,6 +26,7 @@
>  #include "hw/isa/isa.h"
>  #include "hw/dma/i8257.h"
>  #include "qemu/main-loop.h"
> +#include "qemu/log.h"
>  #include "trace.h"
> =20
>  #define I8257(obj) \
> @@ -185,7 +186,8 @@ static void i8257_write_cont(void *opaque, hwaddr n=
port, uint64_t data,
>      switch (iport) {
>      case 0x00:                  /* command */
>          if ((data !=3D 0) && (data & CMD_NOT_SUPPORTED)) {
> -            dolog("command %"PRIx64" not supported\n", data);
> +            qemu_log_mask(LOG_UNIMP, "%s: cmd 0x%02"PRIx64" not suppor=
ted\n",
> +                          __func__, data);
>              return;
>          }
>          d->command =3D data;
>=20

Reviewed-by: Thomas Huth <thuth@redhat.com>
