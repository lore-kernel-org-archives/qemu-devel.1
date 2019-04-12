Received: from eggs.gnu.org ([209.51.188.92]:54709)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1hEzSU-0001Zp-Vn
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 12:55:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1hEzST-0008To-VO
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 12:55:22 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56372)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1hEzST-0008SE-N9
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 12:55:21 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id EA752330255
	for <qemu-devel@nongnu.org>; Fri, 12 Apr 2019 16:55:20 +0000 (UTC)
Date: Fri, 12 Apr 2019 17:55:17 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20190412165516.GH2906@work-vm>
References: <20190411152520.10061-1-armbru@redhat.com>
	<20190411152520.10061-3-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190411152520.10061-3-armbru@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 02/17] trace: Simplify how
 st_print_trace_file_status() prints
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
> st_print_trace_file_status() takes an fprintf()-like callback and a
> FILE * to pass to it.
> 
> Its only caller hmp_trace_file() passes monitor_fprintf() and the
> current monitor cast to FILE *.  monitor_fprintf() casts it right
> back, and is otherwise identical to monitor_printf().  The
> type-punning is ugly.
> 
> Drop the callback, and call qemu_printf() instead.
> 
> Signed-off-by: Markus Armbruster <armbru@redhat.com>

Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

> ---
>  monitor.c      | 2 +-
>  trace/simple.c | 7 ++++---
>  trace/simple.h | 2 +-
>  3 files changed, 6 insertions(+), 5 deletions(-)
> 
> diff --git a/monitor.c b/monitor.c
> index 10be8bdb86..a3e66b7159 100644
> --- a/monitor.c
> +++ b/monitor.c
> @@ -1056,7 +1056,7 @@ static void hmp_trace_file(Monitor *mon, const QDict *qdict)
>      const char *arg = qdict_get_try_str(qdict, "arg");
>  
>      if (!op) {
> -        st_print_trace_file_status((FILE *)mon, &monitor_fprintf);
> +        st_print_trace_file_status();
>      } else if (!strcmp(op, "on")) {
>          st_set_trace_file_enabled(true);
>      } else if (!strcmp(op, "off")) {
> diff --git a/trace/simple.c b/trace/simple.c
> index ac904eca91..fc7106ec49 100644
> --- a/trace/simple.c
> +++ b/trace/simple.c
> @@ -16,6 +16,7 @@
>  #include "trace/control.h"
>  #include "trace/simple.h"
>  #include "qemu/error-report.h"
> +#include "qemu/qemu-print.h"
>  
>  /** Trace file header event ID, picked to avoid conflict with real event IDs */
>  #define HEADER_EVENT_ID (~(uint64_t)0)
> @@ -363,10 +364,10 @@ void st_set_trace_file(const char *file)
>      st_set_trace_file_enabled(true);
>  }
>  
> -void st_print_trace_file_status(FILE *stream, int (*stream_printf)(FILE *stream, const char *fmt, ...))
> +void st_print_trace_file_status(void)
>  {
> -    stream_printf(stream, "Trace file \"%s\" %s.\n",
> -                  trace_file_name, trace_fp ? "on" : "off");
> +    qemu_printf("Trace file \"%s\" %s.\n",
> +                trace_file_name, trace_fp ? "on" : "off");
>  }
>  
>  void st_flush_trace_buffer(void)
> diff --git a/trace/simple.h b/trace/simple.h
> index 9931808c05..5771a0634f 100644
> --- a/trace/simple.h
> +++ b/trace/simple.h
> @@ -11,7 +11,7 @@
>  #ifndef TRACE_SIMPLE_H
>  #define TRACE_SIMPLE_H
>  
> -void st_print_trace_file_status(FILE *stream, fprintf_function stream_printf);
> +void st_print_trace_file_status(void);
>  void st_set_trace_file_enabled(bool enable);
>  void st_set_trace_file(const char *file);
>  bool st_init(void);
> -- 
> 2.17.2
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
