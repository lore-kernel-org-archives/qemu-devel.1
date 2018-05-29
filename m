Received: from eggs.gnu.org ([2001:4830:134:3::10]:48103)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1fNaxF-0006dx-Pc
	for qemu-devel@nongnu.org; Tue, 29 May 2018 05:30:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1fNaxB-0002uE-Pw
	for qemu-devel@nongnu.org; Tue, 29 May 2018 05:30:09 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:51322 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1fNaxB-0002u0-Js
	for qemu-devel@nongnu.org; Tue, 29 May 2018 05:30:05 -0400
Date: Tue, 29 May 2018 11:30:00 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20180529113000.1ee70ef4.cohuck@redhat.com>
In-Reply-To: <20180524044454.11792-2-peterx@redhat.com>
References: <20180524044454.11792-1-peterx@redhat.com>
	<20180524044454.11792-2-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v4 1/2] qemu-error: introduce
 {error|warn}_report_once
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, "Michael S . Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, Markus Armbruster <armbru@redhat.com>, Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <f4bug@amsat.org>, Halil Pasic <pasic@linux.ibm.com>

On Thu, 24 May 2018 12:44:53 +0800
Peter Xu <peterx@redhat.com> wrote:

> There are many error_report()s that can be used in frequently called
> functions, especially on IO paths.  That can be unideal in that
> malicious guest can try to trigger the error tons of time which might
> use up the log space on the host (e.g., libvirt can capture the stderr
> of QEMU and put it persistently onto disk).  In VT-d emulation code, we
> have trace_vtd_error() tracer.  AFAIU all those places can be replaced
> by something like error_report() but trace points are mostly used to
> avoid the DDOS attack that mentioned above.  However using trace points
> mean that errors are not dumped if trace not enabled.
> 
> It's not a big deal in most modern server managements since we have
> things like logrotate to maintain the logs and make sure the quota is
> expected.  However it'll still be nice that we just provide another way
> to restrict message generations.  In most cases, this kind of
> error_report()s will only provide valid information on the first message
> sent, and all the rest of similar messages will be mostly talking about
> the same thing.  This patch introduces *_report_once() helpers to allow
> a message to be dumped only once during one QEMU process's life cycle.
> It will make sure: (1) it's on by deffault, so we can even get something
> without turning the trace on and reproducing, and (2) it won't be
> affected by DDOS attack.

This is good for something (sub-)system wide, where it is enough to
alert the user once; but we may want to print something e.g. once per
the device where it happens (see v3 of "vfio-ccw: add force unlimited
prefetch property" for an example).

> 
> To implement it, I stole the printk_once() macro from Linux.

Would something akin to printk_ratelimited() also make sense to avoid
log flooding?

> 
> CC: Eric Blake <eblake@redhat.com>
> CC: Markus Armbruster <armbru@redhat.com>
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  include/qemu/error-report.h | 32 ++++++++++++++++++++++++++++++++
>  1 file changed, 32 insertions(+)
> 
> diff --git a/include/qemu/error-report.h b/include/qemu/error-report.h
> index e1c8ae1a52..c7ec54cb97 100644
> --- a/include/qemu/error-report.h
> +++ b/include/qemu/error-report.h
> @@ -44,6 +44,38 @@ void error_report(const char *fmt, ...) GCC_FMT_ATTR(1, 2);
>  void warn_report(const char *fmt, ...) GCC_FMT_ATTR(1, 2);
>  void info_report(const char *fmt, ...) GCC_FMT_ATTR(1, 2);
>  
> +/*
> + * Similar to error_report(), but it only prints the message once.  It
> + * returns true when it prints the first time, otherwise false.
> + */
> +#define error_report_once(fmt, ...)             \
> +    ({                                          \
> +        static bool print_once_;               \
> +        bool ret_print_once_ = !print_once_;  \
> +                                                \
> +        if (!print_once_) {                    \
> +            print_once_ = true;                \
> +            error_report(fmt, ##__VA_ARGS__);   \
> +        }                                       \
> +        unlikely(ret_print_once_);             \
> +    })
> +
> +/*
> + * Similar to warn_report(), but it only prints the message once.  It
> + * returns true when it prints the first time, otherwise false.
> + */
> +#define warn_report_once(fmt, ...)              \
> +    ({                                          \
> +        static bool print_once_;               \
> +        bool ret_print_once_ = !print_once_;  \
> +                                                \
> +        if (!print_once_) {                    \
> +            print_once_ = true;                \
> +            warn_report(fmt, ##__VA_ARGS__);   \
> +        }                                       \
> +        unlikely(ret_print_once_);             \
> +    })
> +
>  const char *error_get_progname(void);
>  extern bool enable_timestamp_msg;
>  

The patch mentioned above implements printing a warning once via a
passed-in variable (in that case, a per-device property). That looks
like a superset of what this patch provides.

Would such a functionality be useful for other callers as well? If so,
we should probably implement it in the common error handling functions.
[I'm currently planning to queue the vfio-ccw patch as-is; we can
switch to a common interface later if it makes sense.]
