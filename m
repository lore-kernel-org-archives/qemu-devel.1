Received: from eggs.gnu.org ([2001:4830:134:3::10]:38114)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lprosek@redhat.com>) id 1eJb6C-0003aG-NP
	for qemu-devel@nongnu.org; Tue, 28 Nov 2017 03:18:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lprosek@redhat.com>) id 1eJb68-00022r-Js
	for qemu-devel@nongnu.org; Tue, 28 Nov 2017 03:18:36 -0500
Received: from mail-ua0-f193.google.com ([209.85.217.193]:45495)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <lprosek@redhat.com>) id 1eJb68-00022d-Fi
	for qemu-devel@nongnu.org; Tue, 28 Nov 2017 03:18:32 -0500
Received: by mail-ua0-f193.google.com with SMTP id r11so20920387uah.12
	for <qemu-devel@nongnu.org>; Tue, 28 Nov 2017 00:18:31 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <151127326409.6888.9209413226035587910.stgit@Misha-PC.lan02.inno>
References: <151127322955.6888.16198535123422076171.stgit@Misha-PC.lan02.inno>
	<151127326409.6888.9209413226035587910.stgit@Misha-PC.lan02.inno>
From: Ladi Prosek <lprosek@redhat.com>
Date: Tue, 28 Nov 2017 09:18:30 +0100
Message-ID: <CABdb7372q-LntFhkDuurfWi2JakzZCM9xVxkEA=cqYMbKv_jGw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v3 05/45] windbg: added helper features
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Mihail Abakumov <mikhail.abakumov@ispras.ru>
Cc: qemu-devel <qemu-devel@nongnu.org>, sw@weilnetz.de, Pavel Dovgalyuk <dovgaluk@ispras.ru>, Roman Kagan <rkagan@virtuozzo.com>, Paolo Bonzini <pbonzini@redhat.com>, "Denis V. Lunev" <den@openvz.org>

On Tue, Nov 21, 2017 at 3:07 PM, Mihail Abakumov
<mikhail.abakumov@ispras.ru> wrote:
> Added some helper features for windbgstub.
>
> Signed-off-by: Mihail Abakumov <mikhail.abakumov@ispras.ru>
> Signed-off-by: Pavel Dovgalyuk <dovgaluk@ispras.ru>
> Signed-off-by: Dmitriy Koltunov <koltunov@ispras.ru>
> ---
>  include/exec/windbgstub-utils.h |   27 +++++++++++++++++++++++++++
>  include/exec/windbgstub.h       |    6 ++++++
>  2 files changed, 33 insertions(+)
>
> diff --git a/include/exec/windbgstub-utils.h b/include/exec/windbgstub-utils.h
> index 2390597f1f..e9f5223e94 100755
> --- a/include/exec/windbgstub-utils.h
> +++ b/include/exec/windbgstub-utils.h
> @@ -13,7 +13,34 @@
>  #define WINDBGSTUB_UTILS_H
>
>  #include "qemu/osdep.h"
> +#include "qemu/error-report.h"
> +#include "log.h"
> +#include "cpu.h"
>  #include "exec/windbgstub.h"
>  #include "exec/windbgkd.h"
>
> +#define WINDBG_DEBUG(...) do {             \
> +    if (WINDBG_DEBUG_ON) {                 \
> +        qemu_log(WINDBG ": " __VA_ARGS__); \
> +        qemu_log("\n");                    \
> +    }                                      \
> +} while (false)
> +
> +#define WINDBG_ERROR(...) error_report(WINDBG ": " __VA_ARGS__)
> +
> +#define FMT_ADDR "addr:0x" TARGET_FMT_lx
> +#define FMT_ERR  "Error:%d"
> +
> +#define UINT8_P(ptr) ((uint8_t *) (ptr))
> +#define UINT32_P(ptr) ((uint32_t *) (ptr))

This doesn't cross-compile on Linux:

In file included from
/home/lprosek/qemu/target/i386/windbgstub.c:15:0:
/home/lprosek/qemu/target/i386/windbgstub.c: In function
'kd_api_read_msr':
/home/lprosek/qemu/include/exec/windbgstub-utils.h:35:24: error: cast
to pointer from integer of different size
[-Werror=int-to-pointer-cast]
 #define UINT32_P(ptr) ((uint32_t *) (ptr))
                        ^
/home/lprosek/qemu/target/i386/windbgstub.c:1210:27: note: in
expansion of macro 'UINT32_P'
     m64c->DataValueLow  = UINT32_P(val)[0];
                           ^~~~~~~~
/home/lprosek/qemu/include/exec/windbgstub-utils.h:35:24: error: cast
to pointer from integer of different size
[-Werror=int-to-pointer-cast]
 #define UINT32_P(ptr) ((uint32_t *) (ptr))
                        ^
/home/lprosek/qemu/target/i386/windbgstub.c:1211:27: note: in
expansion of macro 'UINT32_P'
     m64c->DataValueHigh = UINT32_P(val)[1];
                           ^~~~~~~~


The macro or the places where it's used need to make sure that the
argument is of the right size. I hacked around it by doing:

--- a/include/exec/windbgstub-utils.h
+++ b/include/exec/windbgstub-utils.h
@@ -32,7 +32,7 @@
 #define FMT_ERR  "Error:%d"

 #define UINT8_P(ptr) ((uint8_t *) (ptr))
-#define UINT32_P(ptr) ((uint32_t *) (ptr))
+#define UINT32_P(ptr) ((uint32_t *) (size_t) (ptr))
 #define PTR(var) UINT8_P(&var)


> +#define PTR(var) UINT8_P(&var)
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
> index 1a6e1cc6e5..21bc552e58 100755
> --- a/include/exec/windbgstub.h
> +++ b/include/exec/windbgstub.h
> @@ -12,6 +12,12 @@
>  #ifndef WINDBGSTUB_H
>  #define WINDBGSTUB_H
>
> +#define WINDBG "windbg"
> +
> +#ifndef WINDBG_DEBUG_ON
> +#define WINDBG_DEBUG_ON false
> +#endif
> +
>  int windbg_server_start(const char *device);
>
>  #endif
>
