Received: from eggs.gnu.org ([2001:4830:134:3::10]:49515)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cPCwY-0002m0-Hc
	for qemu-devel@nongnu.org; Thu, 05 Jan 2017 13:39:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cPCwX-0007k4-9r
	for qemu-devel@nongnu.org; Thu, 05 Jan 2017 13:39:18 -0500
Received: from mail-vk0-x230.google.com ([2607:f8b0:400c:c05::230]:33409)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cPCwX-0007jy-4k
	for qemu-devel@nongnu.org; Thu, 05 Jan 2017 13:39:17 -0500
Received: by mail-vk0-x230.google.com with SMTP id 137so304560572vkl.0
	for <qemu-devel@nongnu.org>; Thu, 05 Jan 2017 10:39:17 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20170103211705.27876-1-jcd@tribudubois.net>
References: <20170103211705.27876-1-jcd@tribudubois.net>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 5 Jan 2017 18:38:56 +0000
Message-ID: <CAFEAcA91iJ_8MeKmMp7_fDfdc+aKLHHs4--CyYh=0FQP+SmxLw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PATCH] [m25p80] Abort in case we overrun the
 internal data buffer
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jean-Christophe Dubois <jcd@tribudubois.net>
Cc: QEMU Developers <qemu-devel@nongnu.org>, =?UTF-8?Q?Marcin_Krzemi=C5=84ski?= <mar.krzeminski@gmail.com>

On 3 January 2017 at 21:17, Jean-Christophe Dubois <jcd@tribudubois.net> wrote:
> Signed-off-by: Jean-Christophe Dubois <jcd@tribudubois.net>
> ---
>  hw/block/m25p80.c | 19 +++++++++++++++++--
>  1 file changed, 17 insertions(+), 2 deletions(-)
>
> diff --git a/hw/block/m25p80.c b/hw/block/m25p80.c
> index d29ff4c..6c374cf 100644
> --- a/hw/block/m25p80.c
> +++ b/hw/block/m25p80.c
> @@ -28,6 +28,7 @@
>  #include "hw/ssi/ssi.h"
>  #include "qemu/bitops.h"
>  #include "qemu/log.h"
> +#include "qemu/error-report.h"
>  #include "qapi/error.h"
>
>  #ifndef M25P80_ERR_DEBUG
> @@ -376,6 +377,8 @@ typedef enum {
>      MAN_GENERIC,
>  } Manufacturer;
>
> +#define _INTERNAL_DATA_SIZE 16
> +

Don't use leading underscores, please.

>  typedef struct Flash {
>      SSISlave parent_obj;
>
> @@ -386,7 +389,7 @@ typedef struct Flash {
>      int page_size;
>
>      uint8_t state;
> -    uint8_t data[16];
> +    uint8_t data[_INTERNAL_DATA_SIZE];
>      uint32_t len;
>      uint32_t pos;
>      uint8_t needed_bytes;
> @@ -1114,6 +1117,12 @@ static uint32_t m25p80_transfer8(SSISlave *ss, uint32_t tx)
>
>      case STATE_COLLECTING_DATA:
>      case STATE_COLLECTING_VAR_LEN_DATA:
> +
> +        if (s->len >= _INTERNAL_DATA_SIZE) {
> +            error_report("Bug - Write overrun internal data buffer");
> +            abort();
> +        }
> +
>          s->data[s->len] = (uint8_t)tx;
>          s->len++;
>
> @@ -1123,6 +1132,12 @@ static uint32_t m25p80_transfer8(SSISlave *ss, uint32_t tx)
>          break;
>
>      case STATE_READING_DATA:
> +
> +        if (s->pos >= _INTERNAL_DATA_SIZE) {
> +            error_report("Bug - Read overrun internal data buffer");
> +            abort();
> +        }
> +

If these are "can't happen unless some other part of QEMU
is buggy" cases, then we can just assert():

    assert(s->pos < ARRAY_SIZE(s->data));

A comment about what kind of other part of QEMU might be buggy
if the assertion fires would also be helpful for future readers.

(If they're "could happen if the guest does something wrong"
cases, we shouldn't just abort(), but if I'm reading the previous
mail thread correctly, that's not the situation here.)

>          r = s->data[s->pos];
>          s->pos++;
>          if (s->pos == s->len) {
> @@ -1195,7 +1210,7 @@ static const VMStateDescription vmstate_m25p80 = {
>      .pre_save = m25p80_pre_save,
>      .fields = (VMStateField[]) {
>          VMSTATE_UINT8(state, Flash),
> -        VMSTATE_UINT8_ARRAY(data, Flash, 16),
> +        VMSTATE_UINT8_ARRAY(data, Flash, _INTERNAL_DATA_SIZE),
>          VMSTATE_UINT32(len, Flash),
>          VMSTATE_UINT32(pos, Flash),
>          VMSTATE_UINT8(needed_bytes, Flash),
> --
> 2.9.3

thanks
-- PMM
