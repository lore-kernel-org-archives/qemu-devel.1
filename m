Received: from eggs.gnu.org ([2001:4830:134:3::10]:38434)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sw@weilnetz.de>) id 1f7wcE-0006Gu-6Y
	for qemu-devel@nongnu.org; Mon, 16 Apr 2018 01:23:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sw@weilnetz.de>) id 1f7wcD-00085X-1D
	for qemu-devel@nongnu.org; Mon, 16 Apr 2018 01:23:46 -0400
References: <20180415234307.28132-1-f4bug@amsat.org>
	<20180415234307.28132-34-f4bug@amsat.org>
From: Stefan Weil <sw@weilnetz.de>
Message-ID: <f11c4eac-fcbf-0aa3-06bf-570ff57144c4@weilnetz.de>
Date: Mon, 16 Apr 2018 07:23:33 +0200
MIME-Version: 1.0
In-Reply-To: <20180415234307.28132-34-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: de-DE
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 33/41] hw/net: Use the BYTE-based
 definitions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, qemu-trivial@nongnu.org, Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, Dmitry Fleytman <dmitry.fleytman@gmail.com>, Jason Wang <jasowang@redhat.com>, Beniamino Galvani <b.galvani@gmail.com>, "open list:Allwinner-a10" <qemu-arm@nongnu.org>

Am 16.04.2018 um 01:42 schrieb Philippe Mathieu-Daud=C3=A9:
> It eases code review, unit is explicit.
>=20
> Patch generated using:
>=20
>   $ git grep -E '(1024|2048|4096|8192|(<<|>>).?(10|20|30))' hw/ include=
/hw/
>=20
> and modified manually.
>=20
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> ---
>  include/hw/net/allwinner_emac.h | 5 +++--
>  hw/net/e1000e.c                 | 7 ++++---
>  hw/net/e1000x_common.c          | 3 ++-
>  hw/net/eepro100.c               | 7 +++----
>  4 files changed, 12 insertions(+), 10 deletions(-)
>=20
> diff --git a/include/hw/net/allwinner_emac.h b/include/hw/net/allwinner=
_emac.h
> index 4cc8aab7ec..4b53b6485c 100644
> --- a/include/hw/net/allwinner_emac.h
> +++ b/include/hw/net/allwinner_emac.h
> @@ -23,6 +23,7 @@
>  #ifndef ALLWINNER_EMAC_H
>  #define ALLWINNER_EMAC_H
> =20
> +#include "qemu/units.h"
>  #include "net/net.h"
>  #include "qemu/fifo8.h"
>  #include "hw/net/mii.h"
> @@ -125,8 +126,8 @@
>  #define EMAC_INT_RX         (1 << 8)
> =20
>  /* Due to lack of specifications, size of fifos is chosen arbitrarily =
*/
> -#define TX_FIFO_SIZE        (4 * 1024)
> -#define RX_FIFO_SIZE        (32 * 1024)
> +#define TX_FIFO_SIZE        (4 * K_BYTE)
> +#define RX_FIFO_SIZE        (32 * K_BYTE)
> =20
>  #define NUM_TX_FIFOS        2
>  #define RX_HDR_SIZE         8
> diff --git a/hw/net/e1000e.c b/hw/net/e1000e.c
> index 16a9417a85..101efe7c83 100644
> --- a/hw/net/e1000e.c
> +++ b/hw/net/e1000e.c
> @@ -34,6 +34,7 @@
>  */
> =20
>  #include "qemu/osdep.h"
> +#include "qemu/units.h"
>  #include "net/net.h"
>  #include "net/tap.h"
>  #include "qemu/range.h"
> @@ -81,10 +82,10 @@ typedef struct E1000EState {
>  #define E1000E_IO_IDX       2
>  #define E1000E_MSIX_IDX     3
> =20
> -#define E1000E_MMIO_SIZE    (128 * 1024)
> -#define E1000E_FLASH_SIZE   (128 * 1024)
> +#define E1000E_MMIO_SIZE    (128 * K_BYTE)
> +#define E1000E_FLASH_SIZE   (128 * K_BYTE)
>  #define E1000E_IO_SIZE      (32)
> -#define E1000E_MSIX_SIZE    (16 * 1024)
> +#define E1000E_MSIX_SIZE    (16 * K_BYTE)
> =20
>  #define E1000E_MSIX_TABLE   (0x0000)
>  #define E1000E_MSIX_PBA     (0x2000)
> diff --git a/hw/net/e1000x_common.c b/hw/net/e1000x_common.c
> index eb0e097137..58c8db77e9 100644
> --- a/hw/net/e1000x_common.c
> +++ b/hw/net/e1000x_common.c
> @@ -23,6 +23,7 @@
>  */
> =20
>  #include "qemu/osdep.h"
> +#include "qemu/units.h"
>  #include "hw/hw.h"
>  #include "hw/pci/pci.h"
>  #include "net/net.h"
> @@ -111,7 +112,7 @@ bool e1000x_is_oversized(uint32_t *mac, size_t size=
)
>      static const int maximum_ethernet_vlan_size =3D 1522;
>      /* this is the size past which hardware will
>         drop packets when setting LPE=3D1 */
> -    static const int maximum_ethernet_lpe_size =3D 16384;
> +    static const int maximum_ethernet_lpe_size =3D 16 * K_BYTE;
> =20
>      if ((size > maximum_ethernet_lpe_size ||
>          (size > maximum_ethernet_vlan_size
> diff --git a/hw/net/eepro100.c b/hw/net/eepro100.c
> index a07a63247e..a02e2b55e8 100644
> --- a/hw/net/eepro100.c
> +++ b/hw/net/eepro100.c
> @@ -41,6 +41,7 @@
>   */
> =20
>  #include "qemu/osdep.h"
> +#include "qemu/units.h"
>  #include "hw/hw.h"
>  #include "hw/pci/pci.h"
>  #include "net/net.h"
> @@ -60,8 +61,6 @@
>   * changed to pad short packets itself. */
>  #define CONFIG_PAD_RECEIVED_FRAMES
> =20
> -#define KiB 1024
> -
>  /* Debug EEPRO100 card. */
>  #if 0
>  # define DEBUG_EEPRO100
> @@ -104,9 +103,9 @@
>  /* Use 64 word EEPROM. TODO: could be a runtime option. */
>  #define EEPROM_SIZE     64
> =20
> -#define PCI_MEM_SIZE            (4 * KiB)
> +#define PCI_MEM_SIZE            (4 * K_BYTE)
>  #define PCI_IO_SIZE             64
> -#define PCI_FLASH_SIZE          (128 * KiB)
> +#define PCI_FLASH_SIZE          (128 * K_BYTE)
> =20
>  #define BITS(n, m) (((0xffffffffU << (31 - n)) >> (31 - n + m)) << m)


Technically this is fine, therefore

Reviewed-by: Stefan Weil <sw@weilnetz.de>

Practically I'd prefer replacing all K_BYTE by KiB, because that is the
standard name with a precise definition:
https://en.wikipedia.org/wiki/Kibibyte.

Stefan
