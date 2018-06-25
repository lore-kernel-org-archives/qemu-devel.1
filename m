Received: from eggs.gnu.org ([2001:4830:134:3::10]:60912)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1fXRDN-00047f-JA
	for qemu-devel@nongnu.org; Mon, 25 Jun 2018 09:07:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1fXRDI-00087l-Kg
	for qemu-devel@nongnu.org; Mon, 25 Jun 2018 09:07:29 -0400
Date: Mon, 25 Jun 2018 15:07:19 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20180625150719.0392da6c.cohuck@redhat.com>
In-Reply-To: <20180625124238.25339-20-f4bug@amsat.org>
References: <20180625124238.25339-1-f4bug@amsat.org>
	<20180625124238.25339-20-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v5 19/46] hw/s390x: Use the IEC binary
 prefix definitions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <f4bug@amsat.org>
Cc: Thomas Huth <thuth@redhat.com>, Stefan Weil <sw@weilnetz.de>, qemu-devel@nongnu.org, qemu-trivial@nongnu.org, Richard Henderson <rth@twiddle.net>, Alexander Graf <agraf@suse.de>, David Hildenbrand <david@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, "open list:S390" <qemu-s390x@nongnu.org>

On Mon, 25 Jun 2018 09:42:11 -0300
Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org> wrote:

> It eases code review, unit is explicit.
>=20
> Patch generated using:
>=20
>   $ git grep -E '(1024|2048|4096|8192|(<<|>>).?(10|20|30))' hw/ include/h=
w/
>=20
> and modified manually.
>=20
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> Reviewed-by: Thomas Huth <thuth@redhat.com>
> Acked-by: Cornelia Huck <cohuck@redhat.com>

Hm, I had not looked at the v2+ patches, as this already carried my
ack...

> ---
>  hw/s390x/s390-skeys.c    | 3 ++-
>  hw/s390x/s390-stattrib.c | 3 ++-

...but these two were added later on.

>  hw/s390x/sclp.c          | 3 ++-
>  3 files changed, 6 insertions(+), 3 deletions(-)
>=20
> diff --git a/hw/s390x/s390-skeys.c b/hw/s390x/s390-skeys.c
> index 76241c240e..15f7ab0e53 100644
> --- a/hw/s390x/s390-skeys.c
> +++ b/hw/s390x/s390-skeys.c
> @@ -10,6 +10,7 @@
>   */
> =20
>  #include "qemu/osdep.h"
> +#include "qemu/units.h"
>  #include "hw/boards.h"
>  #include "hw/s390x/storage-keys.h"
>  #include "qapi/error.h"
> @@ -19,7 +20,7 @@
>  #include "sysemu/kvm.h"
>  #include "migration/register.h"
> =20
> -#define S390_SKEYS_BUFFER_SIZE 131072  /* Room for 128k storage keys */
> +#define S390_SKEYS_BUFFER_SIZE (128 * KiB)  /* Room for 128k storage key=
s */

This one looks confusing to me. We're not allocating 128 chunks of 1
KiB size, but space enough for 128k byte values. What do others think?

>  #define S390_SKEYS_SAVE_FLAG_EOS 0x01
>  #define S390_SKEYS_SAVE_FLAG_SKEYS 0x02
>  #define S390_SKEYS_SAVE_FLAG_ERROR 0x04
> diff --git a/hw/s390x/s390-stattrib.c b/hw/s390x/s390-stattrib.c
> index 70b95550a8..5161a1659b 100644
> --- a/hw/s390x/s390-stattrib.c
> +++ b/hw/s390x/s390-stattrib.c
> @@ -10,6 +10,7 @@
>   */
> =20
>  #include "qemu/osdep.h"
> +#include "qemu/units.h"
>  #include "hw/boards.h"
>  #include "cpu.h"
>  #include "migration/qemu-file.h"
> @@ -20,7 +21,7 @@
>  #include "qapi/error.h"
>  #include "qapi/qmp/qdict.h"
> =20
> -#define CMMA_BLOCK_SIZE  (1 << 10)
> +#define CMMA_BLOCK_SIZE  (1 * KiB)

This one looks fine.

> =20
>  #define STATTR_FLAG_EOS     0x01ULL
>  #define STATTR_FLAG_MORE    0x02ULL
> diff --git a/hw/s390x/sclp.c b/hw/s390x/sclp.c
> index 047d577313..bd2a024efd 100644
> --- a/hw/s390x/sclp.c
> +++ b/hw/s390x/sclp.c
> @@ -13,6 +13,7 @@
>   */
> =20
>  #include "qemu/osdep.h"
> +#include "qemu/units.h"
>  #include "qapi/error.h"
>  #include "cpu.h"
>  #include "sysemu/sysemu.h"
> @@ -289,7 +290,7 @@ static void sclp_realize(DeviceState *dev, Error **er=
rp)
>      ret =3D s390_set_memory_limit(machine->maxram_size, &hw_limit);
>      if (ret =3D=3D -E2BIG) {
>          error_setg(&err, "host supports a maximum of %" PRIu64 " GB",
> -                   hw_limit >> 30);
> +                   hw_limit / GiB);
>      } else if (ret) {
>          error_setg(&err, "setting the guest size failed");
>      }
