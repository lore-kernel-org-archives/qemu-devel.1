Received: from eggs.gnu.org ([2001:4830:134:3::10]:34516)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fIbtY-0005vQ-9W
	for qemu-devel@nongnu.org; Tue, 15 May 2018 11:29:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fIbtV-00086y-4J
	for qemu-devel@nongnu.org; Tue, 15 May 2018 11:29:44 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:33390 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1fIbtU-00086r-Tl
	for qemu-devel@nongnu.org; Tue, 15 May 2018 11:29:41 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
	[10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 87467BB403
	for <qemu-devel@nongnu.org>; Tue, 15 May 2018 15:29:40 +0000 (UTC)
References: <20180515091356.24106-1-peterx@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <584bbd99-11dd-8da9-a5b4-de285cebc84d@redhat.com>
Date: Tue, 15 May 2018 10:29:39 -0500
MIME-Version: 1.0
In-Reply-To: <20180515091356.24106-1-peterx@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH RFC] qemu-error: introduce error_report_once
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>

On 05/15/2018 04:13 AM, Peter Xu wrote:
> I stole the printk_once() macro.
> 
> I always wanted to be able to print some error directly if there is a
> buffer to dump, however we can't use error_report() really quite often
> when there can be any DDOS attack.  To avoid that, we can introduce a
> print-once function for it.
> 
> CC: Markus Armbruster <armbru@redhat.com>
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
> We can for sure introduce similar functions for the rest of the
> error_*() functions, it's just an idea to see whether we'd like it
> in general.
> ---
>   include/qemu/error-report.h | 12 ++++++++++++
>   1 file changed, 12 insertions(+)
> 
> diff --git a/include/qemu/error-report.h b/include/qemu/error-report.h
> index e1c8ae1a52..efebb80e2c 100644
> --- a/include/qemu/error-report.h
> +++ b/include/qemu/error-report.h
> @@ -44,6 +44,18 @@ void error_report(const char *fmt, ...) GCC_FMT_ATTR(1, 2);
>   void warn_report(const char *fmt, ...) GCC_FMT_ATTR(1, 2);
>   void info_report(const char *fmt, ...) GCC_FMT_ATTR(1, 2);
>   
> +#define error_report_once(fmt, ...)             \
> +    ({                                          \
> +        static bool __print_once;               \

Double-underscore names are reserved for the compiler's use, not ours. 
Better would be naming this:

static bool print_once_;

with a trailing underscore, or at most a single leading underscore.

> +        bool __ret_print_once = !__print_once;  \

Same comment for this variable.

> +                                                \
> +        if (!__print_once) {					\
> +            __print_once = true;				\
> +            error_report(fmt, ##__VA_ARGS__);   \
> +        }                                       \
> +        unlikely(__ret_print_once);				\
> +    })
> +
>   const char *error_get_progname(void);
>   extern bool enable_timestamp_msg;
>   
> 

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
