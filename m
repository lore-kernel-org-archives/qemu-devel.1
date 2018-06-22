Received: from eggs.gnu.org ([2001:4830:134:3::10]:51542)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fWHff-0001gu-D3
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 04:43:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fWHfe-0000LH-JR
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 04:43:55 -0400
References: <20180621180224.8312-1-f4bug@amsat.org>
	<20180621180224.8312-12-f4bug@amsat.org>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <346ca2ea-3423-b263-0a86-bd10fa62bb4d@redhat.com>
Date: Fri, 22 Jun 2018 10:43:47 +0200
MIME-Version: 1.0
In-Reply-To: <20180621180224.8312-12-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 11/11] hw/net/smc91c111: Use
 qemu_log_mask(GUEST_ERROR) instead of hw_error
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-trivial@nongnu.org, Jason Wang <jasowang@redhat.com>, qemu-arm@nongnu.org, qemu-devel@nongnu.org

On 21.06.2018 20:02, Philippe Mathieu-Daud=C3=A9 wrote:
> hw_error() finally calls abort(), but there is no need to abort here.
>=20
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> ---
>  hw/net/smc91c111.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
>=20
> diff --git a/hw/net/smc91c111.c b/hw/net/smc91c111.c
> index c8cc5379b7..705a034cb9 100644
> --- a/hw/net/smc91c111.c
> +++ b/hw/net/smc91c111.c
> @@ -11,6 +11,7 @@
>  #include "hw/sysbus.h"
>  #include "net/net.h"
>  #include "hw/devices.h"
> +#include "qemu/log.h"
>  /* For crc32 */
>  #include <zlib.h>
> =20
> @@ -478,7 +479,9 @@ static void smc91c111_writeb(void *opaque, hwaddr o=
ffset,
>          }
>          break;
>      }
> -    hw_error("smc91c111_write: Bad reg %d:%x\n", s->bank, (int)offset)=
;
> +    qemu_log_mask(LOG_GUEST_ERROR,
> +                  "smc91c111_write(bank:%d) 0x%" HWADDR_PRIx " =3D 0x%=
x\n",
> +                  s->bank, offset, value);
>  }
> =20
>  static uint32_t smc91c111_readb(void *opaque, hwaddr offset)
> @@ -621,7 +624,9 @@ static uint32_t smc91c111_readb(void *opaque, hwadd=
r offset)
>          }
>          break;
>      }
> -    hw_error("smc91c111_read: Bad reg %d:%x\n", s->bank, (int)offset);
> +    qemu_log_mask(LOG_GUEST_ERROR,
> +                  "smc91c111_read(bank:%d) 0x%" HWADDR_PRIx "\n",
> +                  s->bank, offset);
>      return 0;
>  }

Please keep "bad register" or a similar text in here.

 Thomas
