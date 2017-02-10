Received: from eggs.gnu.org ([2001:4830:134:3::10]:52325)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ccBNI-0005es-6P
	for qemu-devel@nongnu.org; Fri, 10 Feb 2017 08:36:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ccBNH-0007Na-46
	for qemu-devel@nongnu.org; Fri, 10 Feb 2017 08:36:32 -0500
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20170210092724.6470-1-lvivier@redhat.com>
	<20170210092724.6470-4-lvivier@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <fe248b76-609b-db93-092a-5058c78cba47@amsat.org>
Date: Fri, 10 Feb 2017 10:36:24 -0300
MIME-Version: 1.0
In-Reply-To: <20170210092724.6470-4-lvivier@redhat.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 3/3] spapr: replace debug printf with trace
 points
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Vivier <lvivier@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, Alexander Graf <agraf@suse.de>, David Gibson <david@gibson.dropbear.id.au>

On 02/10/2017 06:27 AM, Laurent Vivier wrote:
> Signed-off-by: Laurent Vivier <lvivier@redhat.com>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>  hw/ppc/spapr_ovec.c | 17 +++--------------
>  hw/ppc/trace-events |  4 ++++
>  2 files changed, 7 insertions(+), 14 deletions(-)
>
> diff --git a/hw/ppc/spapr_ovec.c b/hw/ppc/spapr_ovec.c
> index 3eb1d59..02ed740 100644
> --- a/hw/ppc/spapr_ovec.c
> +++ b/hw/ppc/spapr_ovec.c
> @@ -16,18 +16,9 @@
>  #include "qemu/bitmap.h"
>  #include "exec/address-spaces.h"
>  #include "qemu/error-report.h"
> +#include "trace.h"
>  #include <libfdt.h>
>
> -/* #define DEBUG_SPAPR_OVEC */
> -
> -#ifdef DEBUG_SPAPR_OVEC
> -#define DPRINTFN(fmt, ...) \
> -    do { fprintf(stderr, fmt "\n", ## __VA_ARGS__); } while (0)
> -#else
> -#define DPRINTFN(fmt, ...) \
> -    do { } while (0)
> -#endif
> -
>  #define OV_MAXBYTES 256 /* not including length byte */
>  #define OV_MAXBITS (OV_MAXBYTES * BITS_PER_BYTE)
>
> @@ -210,8 +201,7 @@ sPAPROptionVector *spapr_ovec_parse_vector(target_ulong table_addr, int vector)
>      for (i = 0; i < vector_len; i++) {
>          uint8_t entry = ldub_phys(&address_space_memory, addr + i);
>          if (entry) {
> -            DPRINTFN("read guest vector %2d, byte %3d / %3d: 0x%.2x",
> -                     vector, i + 1, vector_len, entry);
> +            trace_spapr_ovec_parse_vector(vector, i + 1, vector_len, entry);
>              guest_byte_to_bitmap(entry, ov->bitmap, i * BITS_PER_BYTE);
>          }
>      }
> @@ -245,8 +235,7 @@ int spapr_ovec_populate_dt(void *fdt, int fdt_offset,
>      for (i = 1; i < vec_len + 1; i++) {
>          vec[i] = guest_byte_from_bitmap(ov->bitmap, (i - 1) * BITS_PER_BYTE);
>          if (vec[i]) {
> -            DPRINTFN("encoding guest vector byte %3d / %3d: 0x%.2x",
> -                     i, vec_len, vec[i]);
> +            trace_spapr_ovec_populate_dt(i, vec_len, vec[i]);
>          }
>      }
>
> diff --git a/hw/ppc/trace-events b/hw/ppc/trace-events
> index f04bb1d..43d265f 100644
> --- a/hw/ppc/trace-events
> +++ b/hw/ppc/trace-events
> @@ -56,6 +56,10 @@ spapr_drc_realize_child(uint32_t index, char *childname) "drc: 0x%"PRIx32", chil
>  spapr_drc_realize_complete(uint32_t index) "drc: 0x%"PRIx32
>  spapr_drc_unrealize(uint32_t index) "drc: 0x%"PRIx32
>
> +# hw/ppc/spapr_ovec.c
> +spapr_ovec_parse_vector(int vector, int byte, uint16_t vec_len, uint8_t entry) "read guest vector %2d, byte %3d / %3d: 0x%.2x"
> +spapr_ovec_populate_dt(int byte, uint16_t vec_len, uint8_t entry) "encoding guest vector byte %3d / %3d: 0x%.2x"
> +
>  # hw/ppc/spapr_rtas.c
>  spapr_rtas_set_indicator_invalid(uint32_t index) "sensor index: 0x%"PRIx32
>  spapr_rtas_set_indicator_not_supported(uint32_t index, uint32_t type) "sensor index: 0x%"PRIx32", type: %"PRIu32
>
