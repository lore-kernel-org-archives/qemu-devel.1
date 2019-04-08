Received: from eggs.gnu.org ([209.51.188.92]:35890)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hDS1L-0005rO-94
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 07:01:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hDS1K-0004VR-4d
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 07:00:59 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:47022)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hDS1J-0004Uw-Sn
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 07:00:58 -0400
Received: by mail-wr1-f66.google.com with SMTP id t17so15772866wrw.13
	for <qemu-devel@nongnu.org>; Mon, 08 Apr 2019 04:00:57 -0700 (PDT)
References: <20190408083627.7479-1-armbru@redhat.com>
	<20190408083627.7479-13-armbru@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <73204a97-3391-141f-e636-3dd2ec5e1fa1@redhat.com>
Date: Mon, 8 Apr 2019 13:00:55 +0200
MIME-Version: 1.0
In-Reply-To: <20190408083627.7479-13-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 12/15] qemu-print: New qemu_printf(),
 qemu_vprintf() etc.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: "Dr . David Alan Gilbert" <dgilbert@redhat.com>

On 4/8/19 10:36 AM, Markus Armbruster wrote:
> We commonly want to print to the current monitor if we have one, else
> to stdout/stderr.  For stderr, have error_printf().  For stdout, all
> we have is monitor_vfprintf(), which is rather unwieldy.  We often
> print to stderr just because error_printf() is easier.
> 
> New qemu_printf() and qemu_vprintf() do exactly what's needed.  The
> next commits will put them to use.
> 
> Cc: Dr. David Alan Gilbert <dgilbert@redhat.com>
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>  MAINTAINERS               |  2 ++
>  include/qemu/qemu-print.h | 19 ++++++++++++++++++
>  stubs/monitor.c           |  5 +++++
>  util/Makefile.objs        |  1 +
>  util/qemu-print.c         | 42 +++++++++++++++++++++++++++++++++++++++
>  5 files changed, 69 insertions(+)
>  create mode 100644 include/qemu/qemu-print.h
>  create mode 100644 util/qemu-print.c
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 56139ac8ab..1aa19dc4ef 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1895,6 +1895,8 @@ F: hmp.[ch]
>  F: hmp-commands*.hx
>  F: include/monitor/hmp-target.h
>  F: tests/test-hmp.c
> +F: include/qemu/qemu-print.h
> +F: util/qemu-print.c
>  
>  Network device backends
>  M: Jason Wang <jasowang@redhat.com>
> diff --git a/include/qemu/qemu-print.h b/include/qemu/qemu-print.h
> new file mode 100644
> index 0000000000..8fed32bf42
> --- /dev/null
> +++ b/include/qemu/qemu-print.h
> @@ -0,0 +1,19 @@
> +/*
> + * Print to stream or current monitor
> + *
> + * Copyright (C) 2019 Red Hat Inc.
> + *
> + * Authors:
> + *  Markus Armbruster <armbru@redhat.com>,
> + *
> + * This work is licensed under the terms of the GNU GPL, version 2 or later.
> + * See the COPYING file in the top-level directory.
> + */
> +
> +#ifndef QEMU_PRINT_H
> +#define QEMU_PRINT_H
> +
> +int qemu_vprintf(const char *fmt, va_list ap) GCC_FMT_ATTR(1, 0);
> +int qemu_printf(const char *fmt, ...) GCC_FMT_ATTR(1, 2);

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>

> +
> +#endif
> diff --git a/stubs/monitor.c b/stubs/monitor.c
> index b57fe6c32f..b2ea975e40 100644
> --- a/stubs/monitor.c
> +++ b/stubs/monitor.c
> @@ -6,6 +6,11 @@
>  
>  __thread Monitor *cur_mon;
>  
> +int monitor_vprintf(Monitor *mon, const char *fmt, va_list ap)
> +{
> +    abort();
> +}
> +
>  int monitor_get_fd(Monitor *mon, const char *name, Error **errp)
>  {
>      error_setg(errp, "only QEMU supports file descriptor passing");
> diff --git a/util/Makefile.objs b/util/Makefile.objs
> index 835fcd69e2..9206878dec 100644
> --- a/util/Makefile.objs
> +++ b/util/Makefile.objs
> @@ -23,6 +23,7 @@ util-obj-y += bitmap.o bitops.o hbitmap.o
>  util-obj-y += fifo8.o
>  util-obj-y += cacheinfo.o
>  util-obj-y += error.o qemu-error.o
> +util-obj-y += qemu-print.o
>  util-obj-y += id.o
>  util-obj-y += iov.o qemu-config.o qemu-sockets.o uri.o notify.o
>  util-obj-y += qemu-option.o qemu-progress.o
> diff --git a/util/qemu-print.c b/util/qemu-print.c
> new file mode 100644
> index 0000000000..86f9417af8
> --- /dev/null
> +++ b/util/qemu-print.c
> @@ -0,0 +1,42 @@
> +/*
> + * Print to stream or current monitor
> + *
> + * Copyright (C) 2019 Red Hat Inc.
> + *
> + * Authors:
> + *  Markus Armbruster <armbru@redhat.com>,
> + *
> + * This work is licensed under the terms of the GNU GPL, version 2 or later.
> + * See the COPYING file in the top-level directory.
> + */
> +
> +#include "qemu/osdep.h"
> +#include "monitor/monitor.h"
> +#include "qemu/qemu-print.h"
> +
> +/*
> + * Print like vprintf().
> + * Print to current monitor if we have one, else to stdout.
> + */
> +int qemu_vprintf(const char *fmt, va_list ap)
> +{
> +    if (cur_mon) {
> +        return monitor_vprintf(cur_mon, fmt, ap);
> +    }
> +    return vprintf(fmt, ap);
> +}
> +
> +/*
> + * Print like printf().
> + * Print to current monitor if we have one, else to stdout.
> + */
> +int qemu_printf(const char *fmt, ...)
> +{
> +    va_list ap;
> +    int ret;
> +
> +    va_start(ap, fmt);
> +    ret = qemu_vprintf(fmt, ap);
> +    va_end(ap);
> +    return ret;
> +}
> 
