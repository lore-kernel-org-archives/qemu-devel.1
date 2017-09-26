Received: from eggs.gnu.org ([2001:4830:134:3::10]:51271)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1dwtNi-0001dU-My
	for qemu-devel@nongnu.org; Tue, 26 Sep 2017 13:10:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1dwtNg-0002r8-7h
	for qemu-devel@nongnu.org; Tue, 26 Sep 2017 13:10:50 -0400
Received: from mail-wr0-x242.google.com ([2a00:1450:400c:c0c::242]:35387)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alistair23@gmail.com>)
	id 1dwtNg-0002qW-0w
	for qemu-devel@nongnu.org; Tue, 26 Sep 2017 13:10:48 -0400
Received: by mail-wr0-x242.google.com with SMTP id n64so2866524wrb.2
	for <qemu-devel@nongnu.org>; Tue, 26 Sep 2017 10:10:47 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <150642386887.3900.11789274449160294712.stgit@Misha-PC.lan02.inno>
References: <150642384156.3900.3326424823772221077.stgit@Misha-PC.lan02.inno>
	<150642386887.3900.11789274449160294712.stgit@Misha-PC.lan02.inno>
From: Alistair Francis <alistair23@gmail.com>
Date: Tue, 26 Sep 2017 10:10:15 -0700
Message-ID: <CAKmqyKP17659iBwdsKFKoeJg90ns4h-XzYYbNTDke8ihpBQchA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH 04/43] windbg: added '-windbg' option
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
> This option starts windbg server.
>
> Signed-off-by: Mihail Abakumov <mikhail.abakumov@ispras.ru>
> Signed-off-by: Pavel Dovgalyuk <dovgaluk@ispras.ru>
> Signed-off-by: Dmitriy Koltunov <koltunov@ispras.ru>

Acked-by: Alistair Francis <alistair.francis@xilinx.com>

Thanks,
Alistair

> ---
>  qemu-options.hx |    8 ++++++++
>  vl.c            |    8 ++++++++
>  2 files changed, 16 insertions(+)
>
> diff --git a/qemu-options.hx b/qemu-options.hx
> index 9f6e2adfff..1c84eb56d9 100644
> --- a/qemu-options.hx
> +++ b/qemu-options.hx
> @@ -3544,6 +3544,14 @@ Shorthand for -gdb tcp::1234, i.e. open a gdbserver on TCP port 1234
>  (@pxref{gdb_usage}).
>  ETEXI
>
> +DEF("windbg", HAS_ARG, QEMU_OPTION_windbg, \
> +    "-windbg         wait for windbg connection\n", QEMU_ARCH_I386)
> +STEXI
> +@item -windbg
> +@findex -windbg
> +Wait for windbg connection.
> +ETEXI
> +
>  DEF("d", HAS_ARG, QEMU_OPTION_d, \
>      "-d item1,...    enable logging of specified items (use '-d help' for a list of log items)\n",
>      QEMU_ARCH_ALL)
> diff --git a/vl.c b/vl.c
> index 8e247cc2a2..d6378cf03f 100644
> --- a/vl.c
> +++ b/vl.c
> @@ -80,6 +80,7 @@ int main(int argc, char **argv)
>  #include "sysemu/sysemu.h"
>  #include "sysemu/numa.h"
>  #include "exec/gdbstub.h"
> +#include "exec/windbgstub.h"
>  #include "qemu/timer.h"
>  #include "chardev/char.h"
>  #include "qemu/bitmap.h"
> @@ -2436,6 +2437,7 @@ struct device_config {
>          DEV_VIRTCON,   /* -virtioconsole */
>          DEV_DEBUGCON,  /* -debugcon */
>          DEV_GDB,       /* -gdb, -s */
> +        DEV_WINDBG,    /* -windbg */
>          DEV_SCLP,      /* s390 sclp */
>      } type;
>      const char *cmdline;
> @@ -3445,6 +3447,9 @@ int main(int argc, char **argv, char **envp)
>              case QEMU_OPTION_gdb:
>                  add_device_config(DEV_GDB, optarg);
>                  break;
> +            case QEMU_OPTION_windbg:
> +                add_device_config(DEV_WINDBG, optarg);
> +                break;
>              case QEMU_OPTION_L:
>                  if (is_help_option(optarg)) {
>                      list_data_dirs = true;
> @@ -4586,6 +4591,9 @@ int main(int argc, char **argv, char **envp)
>          exit(1);
>      }
>
> +    if (foreach_device_config(DEV_WINDBG, windbg_server_start) < 0) {
> +        exit(1);
> +    }
>      if (foreach_device_config(DEV_SERIAL, serial_parse) < 0)
>          exit(1);
>      if (foreach_device_config(DEV_PARALLEL, parallel_parse) < 0)
>
>
