Received: from eggs.gnu.org ([209.51.188.92]:39924)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1hF0UW-00080z-HM
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 14:01:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1hF0UV-0003pp-HO
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 14:01:32 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58354)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1hF0UV-0003pJ-AW
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 14:01:31 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id A21B13082E5F
	for <qemu-devel@nongnu.org>; Fri, 12 Apr 2019 18:01:30 +0000 (UTC)
Date: Fri, 12 Apr 2019 19:01:27 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20190412180127.GR2906@work-vm>
References: <20190411152520.10061-1-armbru@redhat.com>
	<20190411152520.10061-16-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190411152520.10061-16-armbru@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 15/17] monitor: Clean up how
 monitor_disas() funnels output to monitor
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org

* Markus Armbruster (armbru@redhat.com) wrote:
> INIT_DISASSEMBLE_INFO() takes an fprintf()-like callback and a FILE *
> to pass to it.  monitor_disas() passes monitor_fprintf() and the
> current monitor cast to FILE *.  monitor_fprintf() casts it right
> back, and is otherwise identical to monitor_printf().  The
> type-pinning is ugly.
> 
> Pass qemu_fprintf() and NULL instead.
> 
> monitor_fprintf() is now unused; delete it.
> 
> Signed-off-by: Markus Armbruster <armbru@redhat.com>

Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

> ---
>  disas.c                   |  3 ++-
>  include/monitor/monitor.h |  1 -
>  monitor.c                 | 11 -----------
>  3 files changed, 2 insertions(+), 13 deletions(-)
> 
> diff --git a/disas.c b/disas.c
> index d9aa713a40..d15cceb863 100644
> --- a/disas.c
> +++ b/disas.c
> @@ -3,6 +3,7 @@
>  #include "qemu-common.h"
>  #include "disas/bfd.h"
>  #include "elf.h"
> +#include "qemu/qemu-print.h"
>  
>  #include "cpu.h"
>  #include "disas/disas.h"
> @@ -609,7 +610,7 @@ void monitor_disas(Monitor *mon, CPUState *cpu,
>      int count, i;
>      CPUDebug s;
>  
> -    INIT_DISASSEMBLE_INFO(s.info, (FILE *)mon, monitor_fprintf);
> +    INIT_DISASSEMBLE_INFO(s.info, NULL, qemu_fprintf);
>  
>      s.cpu = cpu;
>      s.info.read_memory_func
> diff --git a/include/monitor/monitor.h b/include/monitor/monitor.h
> index 316a168c41..86656297f1 100644
> --- a/include/monitor/monitor.h
> +++ b/include/monitor/monitor.h
> @@ -31,7 +31,6 @@ int monitor_fd_param(Monitor *mon, const char *fdname, Error **errp);
>  int monitor_vprintf(Monitor *mon, const char *fmt, va_list ap)
>      GCC_FMT_ATTR(2, 0);
>  int monitor_printf(Monitor *mon, const char *fmt, ...) GCC_FMT_ATTR(2, 3);
> -int monitor_fprintf(FILE *stream, const char *fmt, ...) GCC_FMT_ATTR(2, 3);
>  void monitor_flush(Monitor *mon);
>  int monitor_set_cpu(int cpu_index);
>  int monitor_get_cpu_index(void);
> diff --git a/monitor.c b/monitor.c
> index ad6cec54a1..9b5f10b475 100644
> --- a/monitor.c
> +++ b/monitor.c
> @@ -480,17 +480,6 @@ int monitor_printf(Monitor *mon, const char *fmt, ...)
>      return ret;
>  }
>  
> -int monitor_fprintf(FILE *stream, const char *fmt, ...)
> -{
> -    int ret;
> -
> -    va_list ap;
> -    va_start(ap, fmt);
> -    ret = monitor_vprintf((Monitor *)stream, fmt, ap);
> -    va_end(ap);
> -    return ret;
> -}
> -
>  static void qmp_send_response(Monitor *mon, const QDict *rsp)
>  {
>      const QObject *data = QOBJECT(rsp);
> -- 
> 2.17.2
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
