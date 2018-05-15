Received: from eggs.gnu.org ([2001:4830:134:3::10]:36931)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fIYfY-0000pi-3x
	for qemu-devel@nongnu.org; Tue, 15 May 2018 08:03:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fIYfT-0000hz-6f
	for qemu-devel@nongnu.org; Tue, 15 May 2018 08:03:04 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:47326 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1fIYfT-0000hj-1l
	for qemu-devel@nongnu.org; Tue, 15 May 2018 08:02:59 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
	[10.11.54.3])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 905D483262B9
	for <qemu-devel@nongnu.org>; Tue, 15 May 2018 12:02:58 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
References: <20180515091356.24106-1-peterx@redhat.com>
Date: Tue, 15 May 2018 14:02:55 +0200
In-Reply-To: <20180515091356.24106-1-peterx@redhat.com> (Peter Xu's message of
	"Tue, 15 May 2018 17:13:56 +0800")
Message-ID: <87mux16s9c.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH RFC] qemu-error: introduce error_report_once
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org

Peter Xu <peterx@redhat.com> writes:

> I stole the printk_once() macro.
>
> I always wanted to be able to print some error directly if there is a
> buffer to dump, however we can't use error_report() really quite often
> when there can be any DDOS attack.

Got an example?

>                                     To avoid that, we can introduce a
> print-once function for it.
>
> CC: Markus Armbruster <armbru@redhat.com>
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
> We can for sure introduce similar functions for the rest of the
> error_*() functions, it's just an idea to see whether we'd like it
> in general.
> ---
>  include/qemu/error-report.h | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
>
> diff --git a/include/qemu/error-report.h b/include/qemu/error-report.h
> index e1c8ae1a52..efebb80e2c 100644
> --- a/include/qemu/error-report.h
> +++ b/include/qemu/error-report.h
> @@ -44,6 +44,18 @@ void error_report(const char *fmt, ...) GCC_FMT_ATTR(1, 2);
>  void warn_report(const char *fmt, ...) GCC_FMT_ATTR(1, 2);
>  void info_report(const char *fmt, ...) GCC_FMT_ATTR(1, 2);
>  
> +#define error_report_once(fmt, ...)             \
> +    ({                                          \
> +        static bool __print_once;               \
> +        bool __ret_print_once = !__print_once;  \
> +                                                \
> +        if (!__print_once) {					\
> +            __print_once = true;				\
> +            error_report(fmt, ##__VA_ARGS__);   \
> +        }                                       \
> +        unlikely(__ret_print_once);				\
> +    })
> +
>  const char *error_get_progname(void);
>  extern bool enable_timestamp_msg;

Ignorant question: what's the return value's intended use?
