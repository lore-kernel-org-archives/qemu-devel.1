Received: from eggs.gnu.org ([2001:4830:134:3::10]:34882)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eQdU8-0000Tg-4z
	for qemu-devel@nongnu.org; Sun, 17 Dec 2017 13:16:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eQdU4-0007De-Vt
	for qemu-devel@nongnu.org; Sun, 17 Dec 2017 13:16:24 -0500
Received: from mail-qt0-x242.google.com ([2607:f8b0:400d:c0d::242]:37707)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eQdU4-0007Cv-R8
	for qemu-devel@nongnu.org; Sun, 17 Dec 2017 13:16:20 -0500
Received: by mail-qt0-x242.google.com with SMTP id f2so17632756qtj.4
	for <qemu-devel@nongnu.org>; Sun, 17 Dec 2017 10:16:20 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20171217125457.3429-1-marcel@redhat.com>
	<20171217125457.3429-2-marcel@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <2ff27216-1dc8-4025-0149-8d5321799120@amsat.org>
Date: Sun, 17 Dec 2017 15:16:15 -0300
MIME-Version: 1.0
In-Reply-To: <20171217125457.3429-2-marcel@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH V2 1/5] pci/shpc: Move function to generic
 header file
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Marcel Apfelbaum <marcel@redhat.com>, qemu-devel@nongnu.org
Cc: ehabkost@redhat.com, mst@redhat.com, yuval.shaia@oracle.com, pbonzini@redhat.com, imammedo@redhat.com

Hi Marcel, Yuval,

On 12/17/2017 09:54 AM, Marcel Apfelbaum wrote:
> From: Yuval Shaia <yuval.shaia@oracle.com>
> 
> This function should be declared in generic header file so we can
> utilize it.
> 
> Signed-off-by: Yuval Shaia <yuval.shaia@oracle.com>
> Signed-off-by: Marcel Apfelbaum <marcel@redhat.com>
> ---
>  hw/pci/shpc.c         | 11 +----------
>  include/qemu/cutils.h | 10 ++++++++++
>  2 files changed, 11 insertions(+), 10 deletions(-)
> 
> diff --git a/hw/pci/shpc.c b/hw/pci/shpc.c
> index 69fc14b218..3d22424fd2 100644
> --- a/hw/pci/shpc.c
> +++ b/hw/pci/shpc.c
> @@ -1,6 +1,7 @@
>  #include "qemu/osdep.h"
>  #include "qapi/error.h"
>  #include "qemu-common.h"
> +#include "qemu/cutils.h"
>  #include "qemu/range.h"
>  #include "qemu/error-report.h"
>  #include "hw/pci/shpc.h"
> @@ -122,16 +123,6 @@
>  #define SHPC_PCI_TO_IDX(pci_slot) ((pci_slot) - 1)
>  #define SHPC_IDX_TO_PHYSICAL(slot) ((slot) + 1)
>  
> -static int roundup_pow_of_two(int x)
> -{
> -    x |= (x >> 1);
> -    x |= (x >> 2);
> -    x |= (x >> 4);
> -    x |= (x >> 8);
> -    x |= (x >> 16);
> -    return x + 1;
> -}
> -
>  static uint16_t shpc_get_status(SHPCDevice *shpc, int slot, uint16_t msk)
>  {
>      uint8_t *status = shpc->config + SHPC_SLOT_STATUS(slot);
> diff --git a/include/qemu/cutils.h b/include/qemu/cutils.h
> index f0878eaafa..4895334645 100644
> --- a/include/qemu/cutils.h
> +++ b/include/qemu/cutils.h

I'd rather move this function below pow2ceil() in "qemu/host-utils.h"
and rename it pow2roundup().

> @@ -164,4 +164,14 @@ bool test_buffer_is_zero_next_accel(void);
>  int uleb128_encode_small(uint8_t *out, uint32_t n);
>  int uleb128_decode_small(const uint8_t *in, uint32_t *n);
>  
> +static inline int roundup_pow_of_two(w x)
> +{
> +    x |= (x >> 1);
> +    x |= (x >> 2);
> +    x |= (x >> 4);
> +    x |= (x >> 8);
> +    x |= (x >> 16);

So this would be pow2roundup32(uint32_t value)...

Naming it pow2roundup() without specifying the integer size, I'd
directly use a uint64_t argument, and:

       x |= (x >> 32);

> +    return x + 1;
> +}
> +
>  #endif

Naming it pow2roundup() in "qemu/host-utils.h" (regardless the arg size):
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

Regards,

Phil.
