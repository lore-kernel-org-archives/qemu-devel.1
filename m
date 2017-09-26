Received: from eggs.gnu.org ([2001:4830:134:3::10]:51921)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1dwtQK-0002J9-M8
	for qemu-devel@nongnu.org; Tue, 26 Sep 2017 13:13:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1dwtQJ-0004JA-Lt
	for qemu-devel@nongnu.org; Tue, 26 Sep 2017 13:13:32 -0400
Received: from mail-it0-x230.google.com ([2607:f8b0:4001:c0b::230]:46859)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alistair23@gmail.com>)
	id 1dwtQJ-0004Ix-HK
	for qemu-devel@nongnu.org; Tue, 26 Sep 2017 13:13:31 -0400
Received: by mail-it0-x230.google.com with SMTP id d192so3997079itd.1
	for <qemu-devel@nongnu.org>; Tue, 26 Sep 2017 10:13:31 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <150642387446.3900.8629683985208127854.stgit@Misha-PC.lan02.inno>
References: <150642384156.3900.3326424823772221077.stgit@Misha-PC.lan02.inno>
	<150642387446.3900.8629683985208127854.stgit@Misha-PC.lan02.inno>
From: Alistair Francis <alistair23@gmail.com>
Date: Tue, 26 Sep 2017 10:13:00 -0700
Message-ID: <CAKmqyKMrFGWDctvuPMFyEGqBm6QMF2VTArqV6v2rONVeUa8SrA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH 05/43] windbg: added helper features
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Mihail Abakumov <mikhail.abakumov@ispras.ru>
Cc: "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>, Stefan Weil <sw@weilnetz.de>, lprosek@redhat.com, dovgaluk@ispras.ru, rkagan@virtuozzo.com, Paolo Bonzini <pbonzini@redhat.com>, den@openvz.org

On Tue, Sep 26, 2017 at 4:04 AM, Mihail Abakumov
<mikhail.abakumov@ispras.ru> wrote:
> Added some helper features for windbgstub.
>
> Signed-off-by: Mihail Abakumov <mikhail.abakumov@ispras.ru>
> Signed-off-by: Pavel Dovgalyuk <dovgaluk@ispras.ru>
> Signed-off-by: Dmitriy Koltunov <koltunov@ispras.ru>
> ---
>  include/exec/windbgstub-utils.h |   46 +++++++++++++++++++++++++++++++++++++++
>  include/exec/windbgstub.h       |    3 +++
>  windbgstub.c                    |    1 +
>  3 files changed, 50 insertions(+)
>
> diff --git a/include/exec/windbgstub-utils.h b/include/exec/windbgstub-utils.h
> index 2390597f1f..65f336e4bf 100755
> --- a/include/exec/windbgstub-utils.h
> +++ b/include/exec/windbgstub-utils.h
> @@ -13,7 +13,53 @@
>  #define WINDBGSTUB_UTILS_H
>
>  #include "qemu/osdep.h"
> +#include "qemu/error-report.h"
> +#include "cpu.h"
>  #include "exec/windbgstub.h"
>  #include "exec/windbgkd.h"
>
> +#ifndef TARGET_I386
> +#error Unsupported Architecture
> +#endif
> +#ifdef TARGET_X86_64 /* Unimplemented yet */
> +#error Unsupported Architecture
> +#endif
> +
> +#if (WINDBG_DEBUG_ON)
> +
> +# define WINDBG_DEBUG(...) do {    \
> +    printf("Debug: " __VA_ARGS__); \
> +    printf("\n");                  \
> +} while (false)
> +
> +# define WINDBG_ERROR(...) do {    \
> +    printf("Error: " __VA_ARGS__); \
> +    printf("\n");                  \
> +} while (false)

Use qemu_log() instead of printf().

Have a look as some other files for the usual way we handle debug printing.

> +
> +#else
> +
> +# define WINDBG_DEBUG(...)
> +# define WINDBG_ERROR(...) error_report(WINDBG ": " __VA_ARGS__)
> +
> +#endif
> +
> +#define FMT_ADDR "addr:0x" TARGET_FMT_lx
> +#define FMT_ERR  "Error:%d"
> +
> +#define UINT8_P(ptr) ((uint8_t *) (ptr))
> +#define UINT32_P(ptr) ((uint32_t *) (ptr))
> +#define FIELD_P(type, field, ptr) ((typeof_field(type, field) *) (ptr))
> +#define PTR(var) UINT8_P(&var)
> +
> +#define M64_SIZE sizeof(DBGKD_MANIPULATE_STATE64)
> +
> +#define sizeof_field(type, field) sizeof(((type *) NULL)->field)
> +
> +#define READ_VMEM(cpu, addr, type) ({                         \
> +    type _t;                                                  \
> +    cpu_memory_rw_debug(cpu, addr, PTR(_t), sizeof(type), 0); \
> +    _t;                                                       \
> +})
> +
>  #endif
> diff --git a/include/exec/windbgstub.h b/include/exec/windbgstub.h
> index 1a6e1cc6e5..703fc26b8f 100755
> --- a/include/exec/windbgstub.h
> +++ b/include/exec/windbgstub.h
> @@ -12,6 +12,9 @@
>  #ifndef WINDBGSTUB_H
>  #define WINDBGSTUB_H
>
> +#define WINDBG "windbg"
> +#define WINDBG_DEBUG_ON false

You should have a check here to see if the user has already set
WINDBG_DEBUG_ON to allow people to set it during build time.

Thanks,
Alistair

> +
>  int windbg_server_start(const char *device);
>
>  #endif
> diff --git a/windbgstub.c b/windbgstub.c
> index 4951f59203..3830446988 100755
> --- a/windbgstub.c
> +++ b/windbgstub.c
> @@ -11,6 +11,7 @@
>
>  #include "qemu/osdep.h"
>  #include "exec/windbgstub.h"
> +#include "exec/windbgstub-utils.h"
>
>  int windbg_server_start(const char *device)
>  {
>
>
